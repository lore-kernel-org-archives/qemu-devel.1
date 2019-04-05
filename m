Received: from eggs.gnu.org ([209.51.188.92]:37829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCQ4R-0000b0-4y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCPrN-0003Tw-Qr
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCPrL-0003Me-3w
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:30:24 -0400
Date: Fri, 5 Apr 2019 15:30:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190405143017.GF2819@work-vm>
References: <20190329222951.28945-1-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329222951.28945-1-chen.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH] migration/ram.c: Fix codes conflict about
 bitmap_mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>
Cc: Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, qemu-dev <qemu-devel@nongnu.org>, Wei Wang <wei.w.wang@intel.com>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> I found upstream codes conflict with COLO and lead to crash,
> and I located to this patch:

Queued.

> 
> commit 386a907b37a9321bc5d699bc37104d6ffba1b34d
> Author: Wei Wang <wei.w.wang@intel.com>
> Date:   Tue Dec 11 16:24:49 2018 +0800
> 
> migration: use bitmap_mutex in migration_bitmap_clear_dirty
> 
> My colleague Wei's patch add bitmap_mutex in migration_bitmap_clear_dirty,
> but COLO didn't initialize the bitmap_mutex. So we always get an error
> when COLO start up. like that:
> qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
> 
> This patch add the bitmap_mutex initialize and destroy in COLO
> lifecycle.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  migration/ram.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index d7f8fe45a8..f68beeeeff 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3918,6 +3918,7 @@ int colo_init_ram_cache(void)
>      }
>      ram_state = g_new0(RAMState, 1);
>      ram_state->migration_dirty_pages = 0;
> +    qemu_mutex_init(&ram_state->bitmap_mutex);
>      memory_global_dirty_log_start();
>  
>      return 0;
> @@ -3956,6 +3957,7 @@ void colo_release_ram_cache(void)
>      }
>  
>      rcu_read_unlock();
> +    qemu_mutex_destroy(&ram_state->bitmap_mutex);
>      g_free(ram_state);
>      ram_state = NULL;
>  }
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
