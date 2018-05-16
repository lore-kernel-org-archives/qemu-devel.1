Received: from eggs.gnu.org ([2001:4830:134:3::10]:35586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66789f4f5=Paul.Durrant@citrix.com>)
	id 1fIwyq-0000Gw-NX
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66789f4f5=Paul.Durrant@citrix.com>)
	id 1fIwym-0006xM-Hj
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:00:36 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 16 May 2018 14:00:18 +0000
Message-ID: <79a995df547b4125973b181adaccdaf5@AMSPEX02CL03.citrite.net>
References: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
	<1525461967-32174-2-git-send-email-paul.durrant@citrix.com>
	<20180516135020.GF2057@perard.uk.xensource.com>
In-Reply-To: <20180516135020.GF2057@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/8] xen_backend: add grant table helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 16 May 2018 14:50
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: xen-devel@lists.xenproject.org; qemu-block@nongnu.org; qemu-
> devel@nongnu.org; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v3 1/8] xen_backend: add grant table helpers
>=20
> On Fri, May 04, 2018 at 08:26:00PM +0100, Paul Durrant wrote:
> > This patch adds grant table helper functions to the xen_backend code to
> > localize error reporting and use of xen_domid.
> >
> > The patch also defers the call to xengnttab_open() until just before th=
e
> > initialise method in XenDevOps is invoked. This method is responsible f=
or
> > mapping the shared ring. No prior method requires access to the grant
> table.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> >
> > v2:
> >  - New in v2
> > ---
> >  hw/xen/xen_backend.c         | 123
> ++++++++++++++++++++++++++++++++++++++-----
> >  include/hw/xen/xen_backend.h |  33 ++++++++++++
> >  2 files changed, 144 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> > index 7445b50..50412d6 100644
> > --- a/hw/xen/xen_backend.c
> > +++ b/hw/xen/xen_backend.c
> > @@ -106,6 +106,103 @@ int xen_be_set_state(struct XenDevice *xendev,
> enum xenbus_state state)
> >      return 0;
> >  }
> >
> > +void xen_be_set_max_grant_refs(struct XenDevice *xendev,
> > +                               unsigned int nr_refs)
>=20
> Is it fine to ignore error from set_max_grants and continue ? xen_disk.c
> seems to fail the initialisation if set_max_grants call fails. On the
> other end, xen-usb.c just keep going.
>=20

I guess the upshot will be that a subsequent grant map would fail, so I thi=
nk it should be sufficient to deal with the failure there. As you say it's =
use is inconsistent, and just plain missing in some cases.

> > +{
> > +    assert(xendev->ops->flags & DEVOPS_FLAG_NEED_GNTDEV);
> > +
> > +    if (xengnttab_set_max_grants(xendev->gnttabdev, nr_refs)) {
> > +        xen_pv_printf(xendev, 0, "xengnttab_set_max_grants failed: %s\=
n",
> > +                      strerror(errno));
> > +    }
> > +}
> > +
>=20
> > +int xen_be_copy_grant_refs(struct XenDevice *xendev,
> > +                           bool to_domain,
> > +                           XenGrantCopySegment segs[],
> > +                           unsigned int nr_segs)
> > +{
> > +    xengnttab_grant_copy_segment_t *xengnttab_segs;
> > +    unsigned int i;
> > +    int rc;
> > +
> > +    assert(xendev->ops->flags & DEVOPS_FLAG_NEED_GNTDEV);
> > +
> > +    xengnttab_segs =3D g_new0(xengnttab_grant_copy_segment_t,
> nr_segs);
> > +
> > +    for (i =3D 0; i < nr_segs; i++) {
> > +        XenGrantCopySegment *seg =3D &segs[i];
> > +        xengnttab_grant_copy_segment_t *xengnttab_seg =3D
> &xengnttab_segs[i];
> > +
> > +        if (to_domain) {
> > +            xengnttab_seg->flags =3D GNTCOPY_dest_gref;
> > +            xengnttab_seg->dest.foreign.domid =3D xen_domid;
> > +            xengnttab_seg->dest.foreign.ref =3D seg->dest.foreign.ref;
> > +            xengnttab_seg->dest.foreign.offset =3D seg->dest.foreign.o=
ffset;
> > +            xengnttab_seg->source.virt =3D seg->source.virt;
> > +        } else {
> > +            xengnttab_seg->flags =3D GNTCOPY_source_gref;
> > +            xengnttab_seg->source.foreign.domid =3D xen_domid;
> > +            xengnttab_seg->source.foreign.ref =3D seg->source.foreign.=
ref;
> > +            xengnttab_seg->source.foreign.offset =3D
> > +                seg->source.foreign.offset;
> > +            xengnttab_seg->dest.virt =3D seg->dest.virt;
> > +        }
>=20
> That's not going to work because xengnttab_grant_copy_segment_t doesn't
> exist on Xen 4.7.

Ah, I'd missed the ifdef around that in xen_disk. I'll add it here.

Cheers,

  Paul

>=20
> > +
> > +        xengnttab_seg->len =3D seg->len;
> > +    }
> > +
> > +    rc =3D xengnttab_grant_copy(xendev->gnttabdev, nr_segs,
> xengnttab_segs);
>=20
> Thanks,
>=20
> --
> Anthony PERARD
