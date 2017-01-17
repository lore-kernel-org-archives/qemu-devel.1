Received: from eggs.gnu.org ([2001:4830:134:3::10]:56056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTZEW-00005E-TJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTZES-0001F1-Fm
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:15:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTZES-0001DD-AS
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:15:48 -0500
Date: Tue, 17 Jan 2017 21:15:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170117211131-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, amit.shah@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, david@redhat.com, aarcange@redhat.com, dgilbert@redhat.com, quintela@redhat.com

On Wed, Dec 21, 2016 at 02:52:26PM +0800, Liang Li wrote:
>  
> -	/* We should always be able to add one buffer to an empty queue. */
> -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> -	virtqueue_kick(vq);
> +static void do_set_resp_bitmap(struct virtio_balloon *vb,
> +		unsigned long base_pfn, int pages)
>  
> -	/* When host has read buffer, this completes via balloon_ack */
> -	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> +{
> +	__le64 *range = vb->resp_data + vb->resp_pos;
>  
> +	if (pages > (1 << VIRTIO_BALLOON_NR_PFN_BITS)) {
> +		/* when the length field can't contain pages, set it to 0 to

/*
 * Multi-line
 * comments
 * should look like this.
 */

Also, pls start sentences with an upper-case letter.

> +		 * indicate the actual length is in the next __le64;
> +		 */

This is part of the interface so should be documented as such.

> +		*range = cpu_to_le64((base_pfn <<
> +				VIRTIO_BALLOON_NR_PFN_BITS) | 0);
> +		*(range + 1) = cpu_to_le64(pages);
> +		vb->resp_pos += 2;

Pls use structs for this kind of stuff.

> +	} else {
> +		*range = (base_pfn << VIRTIO_BALLOON_NR_PFN_BITS) | pages;
> +		vb->resp_pos++;
> +	}
> +}
