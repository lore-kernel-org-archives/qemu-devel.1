Received: from eggs.gnu.org ([209.51.188.92]:40784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyaUS-00060B-Aw
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyaUP-00018O-Sj
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:01:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gyaUJ-0000wd-88
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:01:28 -0500
Date: Tue, 26 Feb 2019 11:01:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190226110115.GD2721@work-vm>
References: <20190226053434.6252-1-chen.zhang@intel.com>
	<20190226053434.6252-4-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226053434.6252-4-chen.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] Migration/colo.c: Make COLO node
 running after failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-dev <qemu-devel@nongnu.org>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> Delay to close COLO for auto start VM after failover.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

Yes, I guess the state sent over the global state is probably
RUN_STATE_COLO so it doesn't autostart on new machine types, and this
looks like it would fix it.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c      | 1 -
>  migration/migration.c | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index a13acac192..89325952c7 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -875,7 +875,6 @@ out:
>          qemu_fclose(mis->to_src_file);
>          mis->to_src_file = NULL;
>      }
> -    migration_incoming_disable_colo();
>  
>      rcu_unregister_thread();
>      return NULL;
> diff --git a/migration/migration.c b/migration/migration.c
> index 37e06b76dc..cec5f529c3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -383,6 +383,9 @@ static void process_incoming_migration_bh(void *opaque)
>          } else {
>              runstate_set(RUN_STATE_PAUSED);
>          }
> +    } else if (migration_incoming_colo_enabled()) {
> +        migration_incoming_disable_colo();
> +        vm_start();
>      } else {
>          runstate_set(global_state_get_runstate());
>      }
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
