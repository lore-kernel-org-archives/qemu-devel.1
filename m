Received: from eggs.gnu.org ([2001:4830:134:3::10]:47392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fnTh9-00013a-WB
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fnTh6-0005KB-Sw
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:00:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fnTh6-0005Je-Ir
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:00:28 -0400
Date: Wed, 8 Aug 2018 20:00:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180808190023.GN2734@work-vm>
References: <1532115624-27568-1-git-send-email-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532115624-27568-1-git-send-email-walling@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] monitor: print message when using
 'help' with an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, stzi@linux.ibm.com, eblake@redhat.com

* Collin Walling (walling@linux.ibm.com) wrote:
> When typing 'help' followed by an unknown command, QEMU will
> not print anything to the command line to let the user know
> they typed a bad command. Let's fix this by printing a message
> to the monitor when this happens. For example:
> 
>     (qemu) help xyz
>     unknown command: 'xyz'
> 
> Reported-by: Stefan Zimmermann <stzi@linux.ibm.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 7af1f18..deeb41c 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1013,6 +1013,7 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
>                            char **args, int nb_args, int arg_index)
>  {
>      const mon_cmd_t *cmd;
> +    size_t i;
>  
>      /* No valid arg need to compare with, dump all in *cmds */
>      if (arg_index >= nb_args) {
> @@ -1034,9 +1035,15 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
>              } else {
>                  help_cmd_dump_one(mon, cmd, args, arg_index);
>              }
> -            break;
> +            return;
>          }
>      }
> +
> +    /* Command not found */
> +    monitor_printf(mon, "unknown command: '");
> +    for (i = 0; i <= arg_index; i++) {
> +        monitor_printf(mon, "%s%s", args[i], i == arg_index ? "'\n" : " ");
> +    }
>  }
>  
>  static void help_cmd(Monitor *mon, const char *name)
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
