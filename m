Received: from eggs.gnu.org ([209.51.188.92]:52227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hCP2Y-0002QH-2e
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hCP2R-0002jV-8i
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:37:49 -0400
Date: Fri, 5 Apr 2019 15:36:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190405153621.79a0b995.cohuck@redhat.com>
In-Reply-To: <ec4dd665-53c6-5731-8f36-0e0bef55e646@redhat.com>
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
	<6cd9fc3c-f5cb-e0fd-6990-d519014bead0@redhat.com>
	<d5b711f6-2e0e-f664-70cc-8d9c906bf122@redhat.com>
	<5749904a-9ac3-1b68-c544-b0f0cdcc8ffa@linux.ibm.com>
	<ec4dd665-53c6-5731-8f36-0e0bef55e646@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v6 00/16] s390: vfio-ccw dasd
 ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, jjherne@linux.ibm.com
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Fri, 5 Apr 2019 15:26:24 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 05/04/2019 15.11, Jason J. Herne wrote:

> > Your analysis of the problem matches what I'm seeing as well. Here is
> > what I'm proposing to fix it. If you like it, let me know if you want me
> > to re-send just the final patch, or the entire series again with a v7 t=
ag.

If you (Jason) resend just that patch, I'm happy to give it a tag :)

> >=20
> >=20
> > diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> > index 03e90e3..3d1e9a4 100644
> > --- a/pc-bios/s390-ccw/main.c
> > +++ b/pc-bios/s390-ccw/main.c
> > @@ -67,6 +67,7 @@ static bool find_subch(int dev_no)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0 Schib schib;
> > =C2=A0=C2=A0=C2=A0=C2=A0 int i, r;
> > +=C2=A0=C2=A0=C2=A0 bool is_virtio;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 0x10000; i++) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_schid.sch_no =3D i;
> > @@ -80,12 +81,13 @@ static bool find_subch(int dev_no)
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable_subchannel(blk_=
schid);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cutype =3D cu_type(blk=
_schid);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_virtio =3D virtio_is_sup=
ported(blk_schid);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No specific devno g=
iven, just return 1st possibly bootable
> > device */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev_no < 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 switch (cutype) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case CU_TYPE_VIRTIO:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (virtio_is_supported(blk_schid)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (is_virtio) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Skip net device=
s since no IPLB is created and
> > therefore
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * no network boot=
loader has been loaded
> >=20
> >  =20
>=20
> Looks fine to me. But maybe we should also add a comment before the new
> "virtio_is_supported" line, saying something like "Note: we always have
> to run virtio_is_supported() here to make sure that the vdev.senseid
> data gets pre-initialized"? Otherwise, we might accidentally "revert"
> this patch when somebody thinks that the code might be optimizable by
> removing the is_virtio variable again...

Agreed.

>=20
> If you like, I can squash these changes in when I pick up the patches,
> so you don't have to resend.
>=20
>  Thomas
>=20
