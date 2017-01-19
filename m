Received: from eggs.gnu.org ([2001:4830:134:3::10]:50696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cU1mR-0007q6-Ti
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 20:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cU1mO-0005DK-Rm
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 20:44:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:39607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cU1mO-0005D5-Hp
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 20:44:44 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Thu, 19 Jan 2017 01:44:36 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C3578BF@shsmsx102.ccr.corp.intel.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<1482303148-22059-4-git-send-email-liang.z.li@intel.com>
	<20170117211131-mutt-send-email-mst@kernel.org>
	<F2CBF3009FA73547804AE4C663CAB28E3C355672@shsmsx102.ccr.corp.intel.com>
	<20170118172401-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170118172401-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "david@redhat.com" <david@redhat.com>, "aarcange@redhat.com" <aarcange@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>

> On Wed, Jan 18, 2017 at 04:56:58AM +0000, Li, Liang Z wrote:
> > > > -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> > > > -	virtqueue_kick(vq);
> > > > +static void do_set_resp_bitmap(struct virtio_balloon *vb,
> > > > +		unsigned long base_pfn, int pages)
> > > >
> > > > -	/* When host has read buffer, this completes via balloon_ack */
> > > > -	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> > > > +{
> > > > +	__le64 *range =3D vb->resp_data + vb->resp_pos;
> > > >
> > > > +	if (pages > (1 << VIRTIO_BALLOON_NR_PFN_BITS)) {
> > > > +		/* when the length field can't contain pages, set it to 0 to
> > >
> > > /*
> > >  * Multi-line
> > >  * comments
> > >  * should look like this.
> > >  */
> > >
> > > Also, pls start sentences with an upper-case letter.
> > >
> >
> > Sorry for that.
> >
> > > > +		 * indicate the actual length is in the next __le64;
> > > > +		 */
> > >
> > > This is part of the interface so should be documented as such.
> > >
> > > > +		*range =3D cpu_to_le64((base_pfn <<
> > > > +				VIRTIO_BALLOON_NR_PFN_BITS) | 0);
> > > > +		*(range + 1) =3D cpu_to_le64(pages);
> > > > +		vb->resp_pos +=3D 2;
> > >
> > > Pls use structs for this kind of stuff.
> >
> > I am not sure if you mean to use
> >
> > struct  range {
> >  	__le64 pfn: 52;
> > 	__le64 nr_page: 12
> > }
> > Instead of the shift operation?
>=20
> Not just that. You want to add a pages field as well.
>=20

pages field? Could you give more hints?

> Generally describe the format in the header in some way so host and guest
> can easily stay in sync.

'VIRTIO_BALLOON_NR_PFN_BITS' is for this purpose and it will be passed to t=
he
related function in page_alloc.c as a parameter.

Thanks!
Liang
> All the pointer math and void * means we get zero type safety and I'm not
> happy about it.
>=20
> It's not good that virtio format seeps out to page_alloc anyway.
> If unavoidable it is not a good idea to try to hide this fact, people wil=
l assume
> they can change the format at will.
>=20
> --
> MST
