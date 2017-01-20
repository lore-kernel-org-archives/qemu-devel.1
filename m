Received: from eggs.gnu.org ([2001:4830:134:3::10]:59389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUXg5-0002OB-8J
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUXg1-0004QU-BV
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:48:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cUXg1-0004Po-65
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:48:17 -0500
Date: Fri, 20 Jan 2017 11:48:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170120114809.GH2658@work-vm>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<1482303148-22059-4-git-send-email-liang.z.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482303148-22059-4-git-send-email-liang.z.li@intel.com>
Subject: Re: [Qemu-devel] [PATCH v6 kernel 3/5] virtio-balloon: speed up
 inflate/deflate process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Li <liang.z.li@intel.com>
Cc: kvm@vger.kernel.org, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, amit.shah@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, mst@redhat.com, david@redhat.com, aarcange@redhat.com, quintela@redhat.com

* Liang Li (liang.z.li@intel.com) wrote:

<snip>

> +static void free_extended_page_bitmap(struct virtio_balloon *vb)
> +{
> +	int i, bmap_count = vb->nr_page_bmap;
> +
> +	for (i = 1; i < bmap_count; i++) {
> +		kfree(vb->page_bitmap[i]);
> +		vb->page_bitmap[i] = NULL;
> +		vb->nr_page_bmap--;
> +	}
> +}
> +
> +static void kfree_page_bitmap(struct virtio_balloon *vb)
> +{
> +	int i;
> +
> +	for (i = 0; i < vb->nr_page_bmap; i++)
> +		kfree(vb->page_bitmap[i]);
> +}

It might be worth commenting that pair of functions to make it clear
why they are so different; I guess the kfree_page_bitmap
is used just before you free the structure above it so you
don't need to keep the count/pointers updated?

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
