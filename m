Received: from eggs.gnu.org ([2001:4830:134:3::10]:56477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fgERW-0006ed-67
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fgERS-0006Ot-OI
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:18:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fgERS-0006Oa-IM
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:18:22 -0400
Date: Thu, 19 Jul 2018 20:18:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180719191818.GD2462@work-vm>
References: <1532012617-16777-1-git-send-email-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532012617-16777-1-git-send-email-walling@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: print message when using 'help'
 with an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-devel@nongnu.org

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
> ---
>  monitor.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 7af1f18..7942f9f 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1034,9 +1034,12 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
>              } else {
>                  help_cmd_dump_one(mon, cmd, args, arg_index);
>              }
> -            break;
> +            return;
>          }
>      }
> +
> +    /* Entry not found */
> +    monitor_printf(mon, "unknown command: '%s'\n", args[arg_index]);

Thanks, that does suffer from a similar bug to the one you fixed a
few months back in  317c52cc6aa0d ('monitor: report entirety of hmp
command on error'):

(qemu) help foo
unknown command: 'foo'
(qemu) help info foo
unknown command: 'foo'

Dave
(And yes, please cc me, otherwise I can miss them)

>  }
>  
>  static void help_cmd(Monitor *mon, const char *name)
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
