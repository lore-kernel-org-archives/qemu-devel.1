Received: from eggs.gnu.org ([2001:4830:134:3::10]:54570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOasz-0008Np-HD
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOasw-0001fI-E9
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:37:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fOasw-0001aI-9t
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:37:50 -0400
Date: Fri, 1 Jun 2018 11:37:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180601033739.GF14867@xz-mi>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524550428-27173-3-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/5] migration: use bitmap_mutex in
 migration_bitmap_clear_dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On Tue, Apr 24, 2018 at 02:13:45PM +0800, Wei Wang wrote:
> The bitmap mutex is used to synchronize threads to update the dirty
> bitmap and the migration_dirty_pages counter. This patch makes
> migration_bitmap_clear_dirty update the bitmap and counter under the
> mutex.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> ---
>  migration/ram.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 0e90efa..9a72b1a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -795,11 +795,14 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>  {
>      bool ret;
>  
> +    qemu_mutex_lock(&rs->bitmap_mutex);
>      ret = test_and_clear_bit(page, rb->bmap);
>  
>      if (ret) {
>          rs->migration_dirty_pages--;
>      }
> +    qemu_mutex_unlock(&rs->bitmap_mutex);
> +
>      return ret;
>  }
>  
> -- 
> 1.8.3.1
> 
> 

Do we need the lock after all?

I see that we introduced this lock due to device hotplug at dd63169766
("migration: extend migration_bitmap", 2015-07-07), however now we
actually don't allow that to happen any more after commit b06424de62
("migration: Disable hotplug/unplug during migration", 2017-04-21).
I'm not sure whether it means that the lock is not needed now.

If so, this patch seems to be unecessary.

Regards,

-- 
Peter Xu
