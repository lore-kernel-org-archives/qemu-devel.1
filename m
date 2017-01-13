Received: from eggs.gnu.org ([2001:4830:134:3::10]:54202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cRy65-0008PV-VG
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cRy62-0003Za-MG
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:24:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:25367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cRy62-0003YK-Al
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:24:30 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Fri, 13 Jan 2017 09:24:22 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C351AE8@shsmsx102.ccr.corp.intel.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<1482303148-22059-3-git-send-email-liang.z.li@intel.com>
	<20170112185719-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170112185719-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v6 kernel 2/5]
 virtio-balloon: define new feature bit and head struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "david@redhat.com" <david@redhat.com>, "aarcange@redhat.com" <aarcange@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>

> On Wed, Dec 21, 2016 at 02:52:25PM +0800, Liang Li wrote:
> > Add a new feature which supports sending the page information with
> > range array. The current implementation uses PFNs array, which is not
> > very efficient. Using ranges can improve the performance of
> > inflating/deflating significantly.
> >
> > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Cc: Amit Shah <amit.shah@redhat.com>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > ---
> >  include/uapi/linux/virtio_balloon.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/include/uapi/linux/virtio_balloon.h
> > b/include/uapi/linux/virtio_balloon.h
> > index 343d7dd..2f850bf 100644
> > --- a/include/uapi/linux/virtio_balloon.h
> > +++ b/include/uapi/linux/virtio_balloon.h
> > @@ -34,10 +34,14 @@
> >  #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before
> reclaiming pages */
> >  #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue
> */
> >  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon
> on OOM */
> > +#define VIRTIO_BALLOON_F_PAGE_RANGE	3 /* Send page info
> with ranges */
> >
> >  /* Size of a PFN in the balloon interface. */  #define
> > VIRTIO_BALLOON_PFN_SHIFT 12
> >
> > +/* Bits width for the length of the pfn range */
>=20
> What does this mean? Couldn't figure it out.
>=20
> > +#define VIRTIO_BALLOON_NR_PFN_BITS 12
> > +
> >  struct virtio_balloon_config {
> >  	/* Number of pages host wants Guest to give up. */
> >  	__u32 num_pages;
> > @@ -82,4 +86,12 @@ struct virtio_balloon_stat {
> >  	__virtio64 val;
> >  } __attribute__((packed));
> >
> > +/* Response header structure */
> > +struct virtio_balloon_resp_hdr {
> > +	__le64 cmd : 8; /* Distinguish different requests type */
> > +	__le64 flag: 8; /* Mark status for a specific request type */
> > +	__le64 id : 16; /* Distinguish requests of a specific type */
> > +	__le64 data_len: 32; /* Length of the following data, in bytes */
>=20
> This use of __le64 makes no sense.  Just use u8/le16/le32 pls.
>=20

Got it, will change in the next version.=20

And could help take a look at other parts? as well as the QEMU part.

Thanks!
Liang
