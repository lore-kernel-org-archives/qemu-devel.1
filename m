Received: from eggs.gnu.org ([2001:4830:134:3::10]:36456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cvcbd-0007M1-KU
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 00:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cvcbY-0001Pu-Ho
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 00:31:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:21816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cvcbY-0001No-6R
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 00:31:36 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Wed, 5 Apr 2017 04:31:29 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7391E19B9@shsmsx102.ccr.corp.intel.com>
References: <1489648127-37282-1-git-send-email-wei.w.wang@intel.com>
	<1489648127-37282-3-git-send-email-wei.w.wang@intel.com>
	<286AC319A985734F985F78AFA26841F7391E1962@shsmsx102.ccr.corp.intel.com>
	<20170405065313-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170405065313-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH kernel v8 2/4] virtio-balloon:
 VIRTIO_BALLOON_F_CHUNK_TRANSFER
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

On Wednesday, April 5, 2017 11:54 AM, Michael S. Tsirkin wrote:
> On Wed, Apr 05, 2017 at 03:31:36AM +0000, Wang, Wei W wrote:
> > On Thursday, March 16, 2017 3:09 PM Wei Wang wrote:
> > > The implementation of the current virtio-balloon is not very
> > > efficient, because the ballooned pages are transferred to the host
> > > one by one. Here is the breakdown of the time in percentage spent on
> > > each step of the balloon inflating process (inflating 7GB of an 8GB i=
dle guest).
> > >
> > > 1) allocating pages (6.5%)
> > > 2) sending PFNs to host (68.3%)
> > > 3) address translation (6.1%)
> > > 4) madvise (19%)
> > >
> > > It takes about 4126ms for the inflating process to complete.
> > > The above profiling shows that the bottlenecks are stage 2) and stage=
 4).
> > >
> > > This patch optimizes step 2) by transferring pages to the host in
> > > chunks. A chunk consists of guest physically continuous pages, and
> > > it is offered to the host via a base PFN (i.e. the start PFN of
> > > those physically continuous pages) and the size (i.e. the total numbe=
r of the
> pages). A chunk is formated as below:
> > >
> > > --------------------------------------------------------
> > > |                 Base (52 bit)        | Rsvd (12 bit) |
> > > --------------------------------------------------------
> > > --------------------------------------------------------
> > > |                 Size (52 bit)        | Rsvd (12 bit) |
> > > --------------------------------------------------------
> > >
> > > By doing so, step 4) can also be optimized by doing address
> > > translation and
> > > madvise() in chunks rather than page by page.
> > >
> > > This optimization requires the negotiation of a new feature bit,
> > > VIRTIO_BALLOON_F_CHUNK_TRANSFER.
> > >
> > > With this new feature, the above ballooning process takes ~590ms
> > > resulting in an improvement of ~85%.
> > >
> > > TODO: optimize stage 1) by allocating/freeing a chunk of pages
> > > instead of a single page each time.
> > >
> > > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_balloon.c     | 371
> +++++++++++++++++++++++++++++++++-
> > > --
> > >  include/uapi/linux/virtio_balloon.h |   9 +
> > >  2 files changed, 353 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_balloon.c
> > > b/drivers/virtio/virtio_balloon.c index
> > > f59cb4f..3f4a161 100644
> > > --- a/drivers/virtio/virtio_balloon.c
> > > +++ b/drivers/virtio/virtio_balloon.c
> > > @@ -42,6 +42,10 @@
> > >  #define OOM_VBALLOON_DEFAULT_PAGES 256  #define
> > > VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
> > >
> > > +#define PAGE_BMAP_SIZE	(8 * PAGE_SIZE)
> > > +#define PFNS_PER_PAGE_BMAP	(PAGE_BMAP_SIZE * BITS_PER_BYTE)
> > > +#define PAGE_BMAP_COUNT_MAX	32
> > > +
> > >  static int oom_pages =3D OOM_VBALLOON_DEFAULT_PAGES;
> > > module_param(oom_pages, int, S_IRUSR | S_IWUSR);
> > > MODULE_PARM_DESC(oom_pages, "pages to free on OOM"); @@ -50,6
> +54,14
> > > @@ MODULE_PARM_DESC(oom_pages, "pages to free on OOM");  static
> > > struct vfsmount *balloon_mnt;  #endif
> > >
> > > +#define BALLOON_CHUNK_BASE_SHIFT 12 #define
> > > +BALLOON_CHUNK_SIZE_SHIFT 12 struct balloon_page_chunk {
> > > +	__le64 base;
> > > +	__le64 size;
> > > +};
> > > +
> > > +typedef __le64 resp_data_t;
> > >  struct virtio_balloon {
> > >  	struct virtio_device *vdev;
> > >  	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq; @@ -67,6
> > > +79,31 @@ struct virtio_balloon {
> > >
> > >  	/* Number of balloon pages we've told the Host we're not using. */
> > >  	unsigned int num_pages;
> > > +	/* Pointer to the response header. */
> > > +	struct virtio_balloon_resp_hdr *resp_hdr;
> > > +	/* Pointer to the start address of response data. */
> > > +	resp_data_t *resp_data;
> >
> > I think the implementation has an issue here - both the balloon pages a=
nd the
> unused pages use the same buffer ("resp_data" above) to store chunks. It =
would
> cause a race in this case: live migration starts while ballooning is also=
 in progress.
> I plan to use separate buffers for CHUNKS_OF_BALLOON_PAGES and
> CHUNKS_OF_UNUSED_PAGES. Please let me know if you have a different
> suggestion. Thanks.
> >
> > Best,
> > Wei
>=20
> Is only one resp data ever in flight for each kind?
> If not you want as many buffers as vq allows.
>=20

No, all the kinds were using only one resp_data. I will make it one resp_da=
ta for each kind.

Best,
Wei
