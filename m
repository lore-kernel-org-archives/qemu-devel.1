Received: from eggs.gnu.org ([2001:4830:134:3::10]:48398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d3jV5-0007lZ-F4
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d3jV1-0005QU-7J
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:30:27 -0400
References: <1493298053-17140-1-git-send-email-armbru@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <b7a05120-f94d-a99b-aab2-6208715d47ff@cn.fujitsu.com>
Date: Thu, 27 Apr 2017 21:30:53 +0800
MIME-Version: 1.0
In-Reply-To: <1493298053-17140-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] replication: Make --disable-replication
 compile again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: zhangchen.fnst@cn.fujitsu.com, wencongyang@gmail.com, zhang.zhanghailiang@huawei.com, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>



On 04/27/2017 09:00 PM, Markus Armbruster wrote:
> Broken in commit daa33c5.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

About this bug I remember have discussed with paolo.

https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg01326.html

And about this patch content.

Reviewed-by:Zhang Chen <zhangchen.fnst@cn.fujitsu.com>


Thanks
Zhang Chen


> ---
>   migration/colo.c | 12 ++++++++++++
>   monitor.c        |  5 +++++
>   2 files changed, 17 insertions(+)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index c19eb3f..963c802 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -153,6 +153,7 @@ void qmp_xen_set_replication(bool enable, bool primary,
>                                bool has_failover, bool failover,
>                                Error **errp)
>   {
> +#ifdef CONFIG_REPLICATION
>       ReplicationMode mode = primary ?
>                              REPLICATION_MODE_PRIMARY :
>                              REPLICATION_MODE_SECONDARY;
> @@ -171,10 +172,14 @@ void qmp_xen_set_replication(bool enable, bool primary,
>           }
>           replication_stop_all(failover, failover ? NULL : errp);
>       }
> +#else
> +    abort();
> +#endif
>   }
>   
>   ReplicationStatus *qmp_query_xen_replication_status(Error **errp)
>   {
> +#ifdef CONFIG_REPLICATION
>       Error *err = NULL;
>       ReplicationStatus *s = g_new0(ReplicationStatus, 1);
>   
> @@ -189,11 +194,18 @@ ReplicationStatus *qmp_query_xen_replication_status(Error **errp)
>   
>       error_free(err);
>       return s;
> +#else
> +    abort();
> +#endif
>   }
>   
>   void qmp_xen_colo_do_checkpoint(Error **errp)
>   {
> +#ifdef CONFIG_REPLICATION
>       replication_do_checkpoint_all(errp);
> +#else
> +    abort();
> +#endif
>   }
>   
>   static void colo_send_message(QEMUFile *f, COLOMessage msg,
> diff --git a/monitor.c b/monitor.c
> index 6289e52..62c9f81 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -974,6 +974,11 @@ static void qmp_unregister_commands_hack(void)
>   #ifndef CONFIG_SPICE
>       qmp_unregister_command(&qmp_commands, "query-spice");
>   #endif
> +#ifndef CONFIG_REPLICATION
> +    qmp_unregister_command(&qmp_commands, "xen-set-replication");
> +    qmp_unregister_command(&qmp_commands, "query-xen-replication-status");
> +    qmp_unregister_command(&qmp_commands, "xen-colo-do-checkpoint");
> +#endif
>   #ifndef TARGET_I386
>       qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
>   #endif

-- 
Thanks
Zhang Chen
