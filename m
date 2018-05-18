Received: from eggs.gnu.org ([2001:4830:134:3::10]:37861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=669710df0=Paul.Durrant@citrix.com>)
	id 1fJfn9-0000lF-7N
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=669710df0=Paul.Durrant@citrix.com>)
	id 1fJfn5-00083h-94
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:51:31 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:14586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=669710df0=Paul.Durrant@citrix.com>)
	id 1fJfn4-00082p-TR
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:51:27 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 18 May 2018 13:51:24 +0000
Message-ID: <f4620ef5cd6d45b58bb4ef29259c6ee9@AMSPEX02CL03.citrite.net>
References: <1526648406-1746-1-git-send-email-paul.durrant@citrix.com>
	<5AFED64102000078001C4069@prv1-mh.provo.novell.com>
In-Reply-To: <5AFED64102000078001C4069@prv1-mh.provo.novell.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v2] xen-hvm: stop faking I/O to
 access PCI config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Jan Beulich' <JBeulich@suse.com>
Cc: Anthony Perard <anthony.perard@citrix.com>, Roger Pau Monne <roger.pau@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

> -----Original Message-----
> From: Jan Beulich [mailto:JBeulich@suse.com]
> Sent: 18 May 2018 14:34
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: Anthony Perard <anthony.perard@citrix.com>; Roger Pau Monne
> <roger.pau@citrix.com>; Stefano Stabellini <sstabellini@kernel.org>; xen-
> devel <xen-devel@lists.xenproject.org>; qemu-devel@nongnu.org;
> ehabkost@redhat.com; marcel@redhat.com; mst@redhat.com; Paolo
> Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>
> Subject: Re: [Xen-devel] [PATCH v2] xen-hvm: stop faking I/O to access PC=
I
> config space
>=20
> >>> On 18.05.18 at 15:00, <paul.durrant@citrix.com> wrote:
> > @@ -903,6 +926,80 @@ static void cpu_ioreq_move(ioreq_t *req)
> >      }
> >  }
> >
> > +static void rw_config_req_item(XenPciDevice *xendev, ioreq_t *req,
>=20
> It looks to me as if both parameters could be constified.
>=20

They could for this function, yes.

> > +                               uint32_t i, uint32_t *val)
> > +{
> > +    int32_t reg =3D req->addr;
> > +    uint32_t offset =3D req->size * i;
> > +
> > +    reg +=3D (req->df ? -1 : 1) * offset;
> > +    if (reg < 0 || reg > PCI_CONFIG_SPACE_SIZE) {
>=20
> Having fought a number of issues in this area in the hypervisor a couple
> of years back I wonder
> - why reg is of signed type,

I did that so I could do a < 0 check.

> - whether overflow of the first multiplication really doesn't matter,

It would be better to check it.

> - whether wrapping when adding in the offset is not an issue.
>=20

I'll do limits check on offset then... should be able to make reg unsigned =
then I guess.

> I take it that the rather lax upper bound check (should imo really be
> reg + size > PCI_CONFIG_SPACE_SIZE [implying reg + size doesn't
> itself wrap], or at least reg >=3D PCI_CONFIG_SPACE_SIZE) is not a
> problem because ...
>=20
> > +        if (req->dir =3D=3D IOREQ_READ) {
> > +            *val =3D ~0u;
> > +        }
> > +        return;
> > +    }
> > +
> > +    if (req->dir =3D=3D IOREQ_READ) {
> > +        *val =3D pci_host_config_read_common(xendev->pci_dev, reg,
> > +                                           PCI_CONFIG_SPACE_SIZE,
> > +                                           req->size);
> > +        trace_cpu_ioreq_config_read(req, xendev->sbdf, reg,
> > +                                    req->size, *val);
> > +    } else {
> > +        trace_cpu_ioreq_config_write(req, xendev->sbdf, reg, req->size=
,
> > +                                     *val);
> > +        pci_host_config_write_common(xendev->pci_dev, reg,
> > +                                     PCI_CONFIG_SPACE_SIZE, *val,
> > +                                     req->size);
> > +    }
>=20
> ... these called functions do full checking anyway?

Yes, I'm deferring further checking to these common functions. I'm only int=
ending to avoid passing junk into them here.

>=20
> > +static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
> > +{
> > +    uint32_t sbdf =3D req->addr >> 32;
> > +    XenPciDevice *xendev;
> > +
> > +    if (req->size > sizeof(uint32_t)) {
> > +        hw_error("PCI config access: bad size (%u)", req->size);
>=20
> What about size 0 or 3?
>=20

Yes, I can reject those here also.

> > +    }
> > +
> > +    QLIST_FOREACH(xendev, &state->dev_list, entry) {
> > +        unsigned int i;
> > +        uint32_t tmp;
> > +
> > +        if (xendev->sbdf !=3D sbdf) {
> > +            continue;
> > +        }
> > +
> > +        if (!req->data_is_ptr) {
> > +            if (req->dir =3D=3D IOREQ_READ) {
> > +                for (i =3D 0; i < req->count; i++) {
> > +                    rw_config_req_item(xendev, req, i, &tmp);
> > +                    req->data =3D tmp;
> > +                }
> > +            } else if (req->dir =3D=3D IOREQ_WRITE) {
> > +                for (i =3D 0; i < req->count; i++) {
> > +                    tmp =3D req->data;
> > +                    rw_config_req_item(xendev, req, i, &tmp);
> > +                }
> > +            }
>=20
> Wouldn't it be more sensible to fail req->count !=3D 1 requests here?
>=20

I'm wondering whether we'd want to handle count > 1 once we allow MMCONFIG =
accesses though. I guess it would be easier just to defer that.

  Paul

> Jan
>=20
