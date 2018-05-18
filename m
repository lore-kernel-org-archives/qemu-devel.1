Received: from eggs.gnu.org ([2001:4830:134:3::10]:46506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=669710df0=Paul.Durrant@citrix.com>)
	id 1fJgH1-0006IX-Cu
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=669710df0=Paul.Durrant@citrix.com>)
	id 1fJgGy-0007lC-8v
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:22:23 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:16185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=669710df0=Paul.Durrant@citrix.com>)
	id 1fJgGx-0007k1-UU
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:22:20 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 18 May 2018 14:22:18 +0000
Message-ID: <c2a28c7b574d405787d7e63ec82a67b1@AMSPEX02CL03.citrite.net>
References: <1526648406-1746-1-git-send-email-paul.durrant@citrix.com>
	<5AFED64102000078001C4069@prv1-mh.provo.novell.com>
	<f4620ef5cd6d45b58bb4ef29259c6ee9@AMSPEX02CL03.citrite.net>
	<5AFEE01F02000078001C4100@prv1-mh.provo.novell.com>
In-Reply-To: <5AFEE01F02000078001C4100@prv1-mh.provo.novell.com>
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
> Sent: 18 May 2018 15:16
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: Anthony Perard <anthony.perard@citrix.com>; Roger Pau Monne
> <roger.pau@citrix.com>; Stefano Stabellini <sstabellini@kernel.org>; xen-
> devel <xen-devel@lists.xenproject.org>; qemu-devel@nongnu.org;
> ehabkost@redhat.com; marcel@redhat.com; mst@redhat.com; Paolo
> Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>
> Subject: RE: [Xen-devel] [PATCH v2] xen-hvm: stop faking I/O to access PC=
I
> config space
>=20
> >>> On 18.05.18 at 15:51, <Paul.Durrant@citrix.com> wrote:
> >> Sent: 18 May 2018 14:34
> >> To: Paul Durrant <Paul.Durrant@citrix.com>
> >> >>> On 18.05.18 at 15:00, <paul.durrant@citrix.com> wrote:
> >> > +    QLIST_FOREACH(xendev, &state->dev_list, entry) {
> >> > +        unsigned int i;
> >> > +        uint32_t tmp;
> >> > +
> >> > +        if (xendev->sbdf !=3D sbdf) {
> >> > +            continue;
> >> > +        }
> >> > +
> >> > +        if (!req->data_is_ptr) {
> >> > +            if (req->dir =3D=3D IOREQ_READ) {
> >> > +                for (i =3D 0; i < req->count; i++) {
> >> > +                    rw_config_req_item(xendev, req, i, &tmp);
> >> > +                    req->data =3D tmp;
> >> > +                }
> >> > +            } else if (req->dir =3D=3D IOREQ_WRITE) {
> >> > +                for (i =3D 0; i < req->count; i++) {
> >> > +                    tmp =3D req->data;
> >> > +                    rw_config_req_item(xendev, req, i, &tmp);
> >> > +                }
> >> > +            }
> >>
> >> Wouldn't it be more sensible to fail req->count !=3D 1 requests here?
> >>
> >
> > I'm wondering whether we'd want to handle count > 1 once we allow
> MMCONFIG
> > accesses though. I guess it would be easier just to defer that.
>=20
> For the data_is_ptr case - sure. But here? Or wait - are you thinking abo=
ut
> REP STOS (and the relatively useless REP LODS)?
>=20

Yes. We'd need to cope with a rep stos if we had memory mapped access, but =
we don't need to worry about it until then I think.

In the meantime I doubt any well behaved OS is going to do rep ins or rep o=
uts to cfc so just aborting on count > 1 is probably fine.

  Paul

> Jan
>=20
