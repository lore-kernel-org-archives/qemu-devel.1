Received: from eggs.gnu.org ([2001:4830:134:3::10]:38166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dW0n9-0002L2-Jp
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dW0n8-0003pl-O5
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:37:59 -0400
Date: Fri, 14 Jul 2017 14:37:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170714133746.GC17616@stefanha-x1.localdomain>
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-4-famz@redhat.com>
	<20170710150707.GK14195@stefanha-x1.localdomain>
	<61a85481-9194-d68e-2544-d80365fca83e@redhat.com>
	<20170711100535.GM17792@stefanha-x1.localdomain>
	<3b602080-ef8f-6642-04cb-be5c098dd9f5@redhat.com>
	<20170712010757.GB7449@lemon>
	<404be6bd-6596-bca9-2836-da0c6a93c322@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <404be6bd-6596-bca9-2836-da0c6a93c322@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 3/6] block: Introduce
 bdrv_dma_map and bdrv_dma_unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Karl Rister <krister@redhat.com>


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 04:03:57PM +0200, Paolo Bonzini wrote:
> On 12/07/2017 03:07, Fam Zheng wrote:
> > On Tue, 07/11 12:28, Paolo Bonzini wrote:
> >> On 11/07/2017 12:05, Stefan Hajnoczi wrote:
> >>> On Mon, Jul 10, 2017 at 05:08:56PM +0200, Paolo Bonzini wrote:
> >>>> On 10/07/2017 17:07, Stefan Hajnoczi wrote:
> >>>>> On Wed, Jul 05, 2017 at 09:36:32PM +0800, Fam Zheng wrote:
> >>>>>> Allow block driver to map and unmap a buffer for later I/O, as a p=
erformance
> >>>>>> hint.
> >>>>> The name blk_dma_map() is confusing since other "dma" APIs like
> >>>>> dma_addr_t and dma_blk_io() deal with guest physical addresses inst=
ead
> >>>>> of host addresses.  They are about DMA to/from guest RAM.
> >>>>>
> >>>>> Have you considered hiding this cached mapping in block/nvme.c so t=
hat
> >>>>> it isn't exposed?  block/nvme.c could keep the last buffer mapped a=
nd
> >>>>> callers would get the performance benefit without a new blk_dma_map=
()
> >>>>> API.
> >>>>
> >>>> One buffer is enough for qemu-img bench, but not for more complex ca=
ses
> >>>> (e.g. fio).
> >>>
> >>> I don't see any other blk_dma_map() callers.
> >>
> >> Indeed, the fio plugin is not part of this series, but it also used
> >> blk_dma_map.  Without it, performance is awful.
> >=20
> > How many buffers does fio use, typically? If it's not too many, block/n=
vme.c can
> > cache the last N buffers. I'm with Stefan that hiding the mapping logic=
 from
> > block layer callers makes a nicer API, especially such that qemu-img is=
 much
> > easier to maintain good performance across subcommmands.
>=20
> It depends on the queue depth.
>=20
> I think the API addition is necessary, otherwise we wouldn't have added
> the RAMBlockNotifier which is a layering violation that does the same
> thing (create permanent HVA->IOVA mappings).  In fact, the
> RAMBlockNotifier could be moved out of nvme.c and made to use
> blk_dma_map/unmap, though I'm not proposing to do it now.
>=20
> I don't think qemu-img convert and dd are impacted by IOMMU map/unmap as
> heavily as bench, because they operate with queue depth 1.  But adding
> map/unmap there would not be hard.

I'm not against an API existing for this.  I would just ask:

1. It's documented so the purpose and semantics are clear.
2. The name cannot be confused with dma-helpers.c APIs.

Maybe blk_register_buf() or blk_add_buf_hint()?

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaMkpAAoJEJykq7OBq3PIwOQH/jXXyQ1l47V/9DEZZ1SSbPfG
RZsoy4vWJq7wn5NkGVKiViS7A+WJJYiNiOGDqqVyYHZKNR/h6YfduyC2kcU7o78g
srne+ersNUKJLo9oaBMjIP1XsTF6FYVjHjnpFR1rwTjhA2//FAIElVdV8Q5Aj32t
9Drr6kPxwtMetkO14E9466+4tjLcIGcAyi3Cg6wDmRFi5b7giTHKp6QBFJNim/pG
3FglA+dVEPC2g3P2RucUQXHbVKktdp6RiMzfED8A6ULNtTaRcafYwyuEUNwA7v2i
p1pFFLtRCNWElayxN9Z58+HywJ4djP0DooO5BaDF7L1YapsgpS6NIRW0tkFL2rM=
=sAJw
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
