Received: from eggs.gnu.org ([2001:4830:134:3::10]:47359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkYZT-0006ji-2n
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkYZP-0004mq-Q3
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:31:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkYZP-0004mN-Jt
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:31:55 -0400
Date: Wed, 23 Aug 2017 17:31:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170823163138.GE2648@work-vm>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503471071-2233-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 1/8] monitor: move skip_flush into
 monitor_data_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> It's part of the data init.  Collect it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

OK, this can probably go separately as well.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index e0f8801..7c90df7 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -568,13 +568,14 @@ static void monitor_qapi_event_init(void)
>  
>  static void handle_hmp_command(Monitor *mon, const char *cmdline);
>  
> -static void monitor_data_init(Monitor *mon)
> +static void monitor_data_init(Monitor *mon, bool skip_flush)
>  {
>      memset(mon, 0, sizeof(Monitor));
>      qemu_mutex_init(&mon->out_lock);
>      mon->outbuf = qstring_new();
>      /* Use *mon_cmds by default. */
>      mon->cmd_table = mon_cmds;
> +    mon->skip_flush = skip_flush;
>  }
>  
>  static void monitor_data_destroy(Monitor *mon)
> @@ -594,8 +595,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      char *output = NULL;
>      Monitor *old_mon, hmp;
>  
> -    monitor_data_init(&hmp);
> -    hmp.skip_flush = true;
> +    monitor_data_init(&hmp, true);
>  
>      old_mon = cur_mon;
>      cur_mon = &hmp;
> @@ -4098,7 +4098,7 @@ void monitor_init(Chardev *chr, int flags)
>      }
>  
>      mon = g_malloc(sizeof(*mon));
> -    monitor_data_init(mon);
> +    monitor_data_init(mon, false);
>  
>      qemu_chr_fe_init(&mon->chr, chr, &error_abort);
>      mon->flags = flags;
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
