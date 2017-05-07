Received: from eggs.gnu.org ([2001:4830:134:3::10]:40449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d7Dii-0006it-IH
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d7Dif-00055X-9s
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:22:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:57275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d7Dif-00055R-10
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:22:53 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sun, 7 May 2017 04:22:46 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7391FFBE8@shsmsx102.ccr.corp.intel.com>
References: <1493887815-6070-1-git-send-email-wei.w.wang@intel.com>
	<1493887815-6070-4-git-send-email-wei.w.wang@intel.com>
	<20170506012146-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170506012146-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 3/6] virtio-balloon:
 VIRTIO_BALLOON_F_PAGE_CHUNKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>

On 05/06/2017 06:29 AM, Michael S. Tsirkin wrote:
> On Thu, May 04, 2017 at 04:50:12PM +0800, Wei Wang wrote:
> > Add a new feature, VIRTIO_BALLOON_F_PAGE_CHUNKS, which enables the
> > transfer of the ballooned (i.e. inflated/deflated) pages in chunks to
> > the host.
> >
> > The implementation of the previous virtio-balloon is not very
> > efficient, because the ballooned pages are transferred to the host one
> > by one. Here is the breakdown of the time in percentage spent on each
> > step of the balloon inflating process (inflating 7GB of an 8GB idle
> > guest).
> >
> > 1) allocating pages (6.5%)
> > 2) sending PFNs to host (68.3%)
> > 3) address translation (6.1%)
> > 4) madvise (19%)
> >
> > It takes about 4126ms for the inflating process to complete.
> > The above profiling shows that the bottlenecks are stage 2) and stage
> > 4).
> >
> > This patch optimizes step 2) by transferring pages to the host in
> > chunks. A chunk consists of guest physically continuous pages.
> > When the pages are packed into a chunk, they are converted into
> > balloon page size (4KB) pages. A chunk is offered to the host via a
> > base PFN (i.e. the start PFN of those physically continuous
> > pages) and the size (i.e. the total number of the 4KB balloon size
> > pages). A chunk is formatted as below:
> > --------------------------------------------------------
> > |                 Base (52 bit)        | Rsvd (12 bit) |
> > --------------------------------------------------------
> > --------------------------------------------------------
> > |                 Size (52 bit)        | Rsvd (12 bit) |
> > --------------------------------------------------------
> >
> > By doing so, step 4) can also be optimized by doing address
> > translation and madvise() in chunks rather than page by page.
> >
> > With this new feature, the above ballooning process takes ~590ms
> > resulting in an improvement of ~85%.
> >
> > TODO: optimize stage 1) by allocating/freeing a chunk of pages instead
> > of a single page each time.
> >
> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>=20
>=20
> This is much cleaner, thanks. It might be even better to have wrappers th=
at put
> array and its size in a struct and manage that struct, but I won't requir=
e this for
> submission.

OK, thanks. Would this be your suggestion:

struct virtio_balloon_page_struct {=20
	unsigned int page_bmap_num;
	unsigned long *page_bmap[VIRTIO_BALLOON_PAGE_BMAP_MAX_NUM];
}

Best,
Wei
