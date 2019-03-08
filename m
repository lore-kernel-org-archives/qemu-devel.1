Received: from eggs.gnu.org ([209.51.188.92]:41544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2JUh-0002dt-5O
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2JUg-000378-GM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:41:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h2JUg-00036V-7v
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:41:14 -0500
Date: Fri, 8 Mar 2019 17:41:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190308174108.GG2834@work-vm>
References: <20190303145021.2962-1-chen.zhang@intel.com>
	<20190303145021.2962-7-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303145021.2962-7-chen.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH V3 6/7] Migration/colo.c: Add the necessary
 checks for colo_do_failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

OK, we should make that properly return an error.
(Actually we should make the failover command be one of the new OOB
commands; so that it can work even if the main loop is blocked- that
would make COLO robust properly against network failures)


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index dbe2b88807..d1ae2e6d11 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -197,10 +197,16 @@ void colo_do_failover(MigrationState *s)
>          vm_stop_force_state(RUN_STATE_COLO);
>      }
>  
> -    if (get_colo_mode() == COLO_MODE_PRIMARY) {
> +    switch (get_colo_mode()) {
> +    case COLO_MODE_PRIMARY:
>          primary_vm_do_failover();
> -    } else {
> +        break;
> +    case COLO_MODE_SECONDARY:
>          secondary_vm_do_failover();
> +        break;
> +    default:
> +        error_report("colo_do_failover failed because the colo mode"
> +                     " could not be obtained");
>      }
>  }
>  
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
