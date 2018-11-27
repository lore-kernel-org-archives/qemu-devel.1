Received: from eggs.gnu.org ([2001:4830:134:3::10]:52933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gRW7Y-00081T-47
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 00:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gRW7S-0007RA-F3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 00:41:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gRW7S-0007Qj-AJ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 00:41:10 -0500
Date: Tue, 27 Nov 2018 13:40:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181127054056.GA3205@xz-x1>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1542276484-25508-4-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v9 3/8] migration: use bitmap_mutex in
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
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On Thu, Nov 15, 2018 at 06:07:59PM +0800, Wei Wang wrote:
> The bitmap mutex is used to synchronize threads to update the dirty
> bitmap and the migration_dirty_pages counter. For example, the free
> page optimization clears bits of free pages from the bitmap in an
> iothread context. This patch makes migration_bitmap_clear_dirty update
> the bitmap and counter under the mutex.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 7e7deec..ef69dbe 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1556,11 +1556,14 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
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

It seems fine to me, but have you thought about
test_and_clear_bit_atomic()?  Note that we just had
test_and_set_bit_atomic() a few months ago.

And not related to this patch: I'm unclear on why we have had
bitmap_mutex before, since it seems unnecessary.

Regards,

-- 
Peter Xu
