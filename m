Received: from eggs.gnu.org ([2001:4830:134:3::10]:57574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cZs4l-00024m-FN
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 23:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cZs4i-0003dB-CP
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 23:35:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:30448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cZs4i-0003aq-2g
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 23:35:48 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Sat, 4 Feb 2017 04:35:41 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C363988@shsmsx102.ccr.corp.intel.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<1482303148-22059-4-git-send-email-liang.z.li@intel.com>
	<20170120114809.GH2658@work-vm>
In-Reply-To: <20170120114809.GH2658@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "david@redhat.com" <david@redhat.com>, "aarcange@redhat.com" <aarcange@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>

> <snip>
>=20
> > +static void free_extended_page_bitmap(struct virtio_balloon *vb) {
> > +	int i, bmap_count =3D vb->nr_page_bmap;
> > +
> > +	for (i =3D 1; i < bmap_count; i++) {
> > +		kfree(vb->page_bitmap[i]);
> > +		vb->page_bitmap[i] =3D NULL;
> > +		vb->nr_page_bmap--;
> > +	}
> > +}
> > +
> > +static void kfree_page_bitmap(struct virtio_balloon *vb) {
> > +	int i;
> > +
> > +	for (i =3D 0; i < vb->nr_page_bmap; i++)
> > +		kfree(vb->page_bitmap[i]);
> > +}
>=20
> It might be worth commenting that pair of functions to make it clear why
> they are so different; I guess the kfree_page_bitmap is used just before =
you
> free the structure above it so you don't need to keep the count/pointers
> updated?
>=20

Yes. I will add some comments for that. Thanks!

Liang
=20
> Dave
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
