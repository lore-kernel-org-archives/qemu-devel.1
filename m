Received: from eggs.gnu.org ([2001:4830:134:3::10]:53439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ek7Rm-0006g8-0R
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ek7Rh-0006su-6r
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:06:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ek7Rh-0006sT-2A
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:06:25 -0500
Date: Fri, 9 Feb 2018 12:06:07 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180209120607.GC2428@work-vm>
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<1517915299-15349-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517915299-15349-2-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

* Wei Wang (wei.w.wang@intel.com) wrote:

<snip>

> @@ -374,6 +459,7 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
>      VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
>      f |= dev->host_features;
>      virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
> +    virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);

I agree with Michael that has to be tied to a compatibility flag
somewhere; otherwise we'd hit problems with migration to older QEMUs of
newer guests.

> diff --git a/migration/ram.c b/migration/ram.c
> index cb1950f..d6f462c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2186,6 +2186,16 @@ static int ram_init_all(RAMState **rsp)
>      return 0;
>  }
>  
> +void skip_free_pages_from_dirty_bitmap(RAMBlock *block, ram_addr_t offset,
> +                                       size_t len)
> +{
> +    long start = offset >> TARGET_PAGE_BITS,
> +         nr = len >> TARGET_PAGE_BITS;
> +
> +    bitmap_clear(block->bmap, start, nr);
> +    ram_state->migration_dirty_pages -= nr;
> +}
> +

I don't think this will work for postcopy; just not sending a page will
mean that the guest will block in userfault waiting for the page
(then it will request it but it wont be sent because the source already
thinks it's clean).

I think you're going to need to make the 'unused' pages be sent as zero
pages; probably by modifying save_zero_page to check a bitmap.

(I'm not sure how that will interact with hugepages)

Dave

>  /*
>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>   * long-running RCU critical section.  When rcu-reclaims in the code
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
