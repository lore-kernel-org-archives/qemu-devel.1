Received: from eggs.gnu.org ([2001:4830:134:3::10]:35786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVxcG-0004uo-DU
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVxcF-0004Rb-IW
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:19:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60798 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fVxcF-0004RT-E8
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:19:03 -0400
Date: Thu, 21 Jun 2018 12:19:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180621111859.GA10744@work-vm>
References: <1525445354-16233-1-git-send-email-walling@linux.ibm.com>
	<7e9e9dfd-795b-47f2-453a-59bf65f28229@redhat.com>
	<7274b001-02f2-6584-ea0a-c3d0f96d46b8@linux.ibm.com>
	<89dc884d-97af-4922-bd69-1cb7308399d8@redhat.com>
	<724592be-f5ac-7a40-8c26-5d2dd200ef82@linux.ibm.com>
	<ee680f5e-ac9a-479d-f65e-9f8ae9cfe5d4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee680f5e-ac9a-479d-f65e-9f8ae9cfe5d4@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] monitor: report entirety of hmp command
 on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

* Collin Walling (walling@linux.ibm.com) wrote:
> When a user incorrectly provides an hmp command, an error response will be
> printed that prompts the user to try "help <command name>". However, when
> the command contains multiple parts e.g. "info uuid xyz", only the last
> whitespace delimited string will be reported (in this example "info" will
> be dropped and the message will read "Try "help uuid" for more information",
> which is incorrect).
> 
> Let's correct this by capturing the entirety of the command from the command
> line -- excluding any extraneous characters.
> 
> Reported-by: Mikhail Fokin <fokin@de.ibm.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Queued

> ---
>  monitor.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 39f8ee1..38736b3 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3371,6 +3371,7 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
>  {
>      QDict *qdict;
>      const mon_cmd_t *cmd;
> +    const char *cmd_start = cmdline;
>  
>      trace_handle_hmp_command(mon, cmdline);
>  
> @@ -3381,8 +3382,11 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
>  
>      qdict = monitor_parse_arguments(mon, &cmdline, cmd);
>      if (!qdict) {
> -        monitor_printf(mon, "Try \"help %s\" for more information\n",
> -                       cmd->name);
> +        while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
> +            cmdline--;
> +        }
> +        monitor_printf(mon, "Try \"help %.*s\" for more information\n",
> +                       (int)(cmdline - cmd_start), cmd_start);
>          return;
>      }
>  
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
