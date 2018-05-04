Received: from eggs.gnu.org ([2001:4830:134:3::10]:42735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEcUd-0002wK-U2
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEcUZ-0004Ys-JO
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:19:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEcUZ-0004Yc-Ay
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:19:27 -0400
References: <1525445354-16233-1-git-send-email-walling@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e9e9dfd-795b-47f2-453a-59bf65f28229@redhat.com>
Date: Fri, 4 May 2018 10:19:18 -0500
MIME-Version: 1.0
In-Reply-To: <1525445354-16233-1-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] monitor: report entirety of hmp command on
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org

On 05/04/2018 09:49 AM, Collin Walling wrote:
> When a user incorrectly provides an hmp command, an error response will be
> printed that prompts the user to try "help <command name>". However, when
> the command contains multiple parts e.g. "info skeys", only the last
> whitespace delimited string will be reported (in this example "info" will
> be dropped and the message will read "Try "help skeys" for more information",
> which is incorrect).

What's the exact formula for reproducing this?  I tried:

$ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic --monitor stdio
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) info skeys
unknown command: 'info skeys'

Oh, I see now:

(qemu) info uuid blah
uuid: extraneous characters at the end of line
Try "help uuid" for more information
(qemu) help uuid
(qemu)

You'll want to update your commit message to document something that is 
reproducible (you may be adding an 'info skeys', but until that is in, 
it doesn't make a good example).

> 
> Let's correct this by capturing the full name of the command as we recurse
> through the function monitor_parse_command.
> 
> Reported-by: Mikhail Fokin <fokin@de.ibm.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   monitor.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 39f8ee1..d4844b4 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -2964,7 +2964,8 @@ static const mon_cmd_t *search_dispatch_table(const mon_cmd_t *disp_table,
>   static const mon_cmd_t *monitor_parse_command(Monitor *mon,
>                                                 const char *cmdp_start,
>                                                 const char **cmdp,
> -                                              mon_cmd_t *table)
> +                                              mon_cmd_t *table,
> +                                              char *fullname)

Umm, how is fullname any better than cmdp_start that we already have?

>   {
>       const char *p;
>       const mon_cmd_t *cmd;
> @@ -2987,10 +2988,14 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
>           p++;
>       }
>   
> +    strncat(fullname, cmdname, strlen(cmdname));

gcc 8 is pickier about using strncat() [perhaps too picky - see 
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85602], but it is generally 
NOT the function you want to be using.

> +
>       *cmdp = p;
>       /* search sub command */
>       if (cmd->sub_table != NULL && *p != '\0') {
> -        return monitor_parse_command(mon, cmdp_start, cmdp, cmd->sub_table);
> +        strncat(fullname, " ", 1);
> +        return monitor_parse_command(mon, cmdp_start, cmdp, cmd->sub_table,
> +                                     fullname);

See, you're reconstructing a command into fullname, which already 
matches the original command in cmdp_start, so I see no reason to change 
the signature.

>       }
>   
>       return cmd;
> @@ -3371,10 +3376,12 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
>   {
>       QDict *qdict;
>       const mon_cmd_t *cmd;
> +    char fullname[256];

EWWW. Don't do that.  You are just ASKING for a buffer overflow exploit 
that prints the wrong thing or causes a security hole, when I 
intentionally type a super-long garbage command into HMP.

>   
>       trace_handle_hmp_command(mon, cmdline);
>   
> -    cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
> +    cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table,
> +                                fullname);

Note that even without your patch, this call updates 'cmdline' to point 
to the position within the original string (although that position has 
already skipped spaces).

>       if (!cmd) {
>           return;
>       }
> @@ -3382,7 +3389,7 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
>       qdict = monitor_parse_arguments(mon, &cmdline, cmd);
>       if (!qdict) {
>           monitor_printf(mon, "Try \"help %s\" for more information\n",
> -                       cmd->name);
> +                       fullname);

So rather than trying to reconstruct a string, you could reuse what you 
already have.  This is a shorter patch that I think accomplishes the 
same goal:

diff --git i/monitor.c w/monitor.c
index 39f8ee17ba7..38736b3a20d 100644
--- i/monitor.c
+++ w/monitor.c
@@ -3371,6 +3371,7 @@ static void handle_hmp_command(Monitor *mon, const 
char *cmdline)
  {
      QDict *qdict;
      const mon_cmd_t *cmd;
+    const char *cmd_start = cmdline;

      trace_handle_hmp_command(mon, cmdline);

@@ -3381,8 +3382,11 @@ static void handle_hmp_command(Monitor *mon, 
const char *cmdline)

      qdict = monitor_parse_arguments(mon, &cmdline, cmd);
      if (!qdict) {
-        monitor_printf(mon, "Try \"help %s\" for more information\n",
-                       cmd->name);
+        while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
+            cmdline--;
+        }
+        monitor_printf(mon, "Try \"help %.*s\" for more information\n",
+                       (int)(cmdline - cmd_start), cmd_start);
          return;
      }



-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
