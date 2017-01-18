Received: from eggs.gnu.org ([2001:4830:134:3::10]:38448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cTiJ3-00038Q-J9
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 23:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cTiJ0-0007z3-AJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 23:57:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:26981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cTiJ0-0007yQ-11
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 23:57:06 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Wed, 18 Jan 2017 04:56:58 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C355672@shsmsx102.ccr.corp.intel.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<1482303148-22059-4-git-send-email-liang.z.li@intel.com>
	<20170117211131-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170117211131-mutt-send-email-mst@kernel.org>
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

> > -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> > -	virtqueue_kick(vq);
> > +static void do_set_resp_bitmap(struct virtio_balloon *vb,
> > +		unsigned long base_pfn, int pages)
> >
> > -	/* When host has read buffer, this completes via balloon_ack */
> > -	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> > +{
> > +	__le64 *range =3D vb->resp_data + vb->resp_pos;
> >
> > +	if (pages > (1 << VIRTIO_BALLOON_NR_PFN_BITS)) {
> > +		/* when the length field can't contain pages, set it to 0 to
>=20
> /*
>  * Multi-line
>  * comments
>  * should look like this.
>  */
>=20
> Also, pls start sentences with an upper-case letter.
>=20

Sorry for that.

> > +		 * indicate the actual length is in the next __le64;
> > +		 */
>=20
> This is part of the interface so should be documented as such.
>=20
> > +		*range =3D cpu_to_le64((base_pfn <<
> > +				VIRTIO_BALLOON_NR_PFN_BITS) | 0);
> > +		*(range + 1) =3D cpu_to_le64(pages);
> > +		vb->resp_pos +=3D 2;
>=20
> Pls use structs for this kind of stuff.

I am not sure if you mean to use=20

struct  range {
 	__le64 pfn: 52;
	__le64 nr_page: 12
}
Instead of the shift operation?

I didn't use this way because I don't want to include 'virtio-balloon.h' in=
 page_alloc.c,
or copy the define of this struct in page_alloc.c

Thanks!
Liang
