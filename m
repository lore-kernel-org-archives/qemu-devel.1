Received: from eggs.gnu.org ([2001:4830:134:3::10]:40400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f0fXL-0003QJ-GK
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f0fXI-0007vF-Dx
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:44:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@redhat.com>) id 1f0fXI-0007s2-7c
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:44:36 -0400
Date: Tue, 27 Mar 2018 14:44:16 +1100
From: David Gibson <dgibson@redhat.com>
Message-ID: <20180327144416.2ed36b8e@umbus.fritz.box>
In-Reply-To: <20180326072639.GB31422@lemon.usersys.redhat.com>
References: <20180322073822.25795-1-famz@redhat.com>
	<097f05b7-c628-c529-1c64-a84dc6483f7c@linux.vnet.ibm.com>
	<20180326072639.GB31422@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/3oQY+0i=UWyvfpUt6ZwlLue";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: Don't enlarge min_io_size to
 max_io_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/3oQY+0i=UWyvfpUt6ZwlLue
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Mar 2018 15:26:39 +0800
Fam Zheng <famz@redhat.com> wrote:

> On Thu, 03/22 09:19, Daniel Henrique Barboza wrote:
> > Hi,
> >=20
> > On 03/22/2018 04:38 AM, Fam Zheng wrote: =20
> > > Some backends report big max_io_sectors. Making min_io_size the same
> > > value in this case will make it impossible for guest to align memory,
> > > therefore the disk may not be usable at all.
> > >=20
> > > Change the default behavior (when min_io_size and opt_io_size are not
> > > specified in the command line), do not assume max_io_sectors is a good
> > > value for opt_io_size and min_io_size, use 512 instead.
> > >=20
> > > Reported-by: David Gibson <dgibson@redhat.com>
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > ---
> > >   hw/scsi/scsi-disk.c | 6 ++----
> > >   1 file changed, 2 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > > index 5b7a48f5a5..76e3c9eaa4 100644
> > > --- a/hw/scsi/scsi-disk.c
> > > +++ b/hw/scsi/scsi-disk.c
> > > @@ -714,10 +714,8 @@ static int scsi_disk_emulate_inquiry(SCSIRequest=
 *req, uint8_t *outbuf)
> > >=20
> > >                   /* min_io_size and opt_io_size can't be greater than
> > >                    * max_io_sectors */
> > > -                min_io_size =3D
> > > -                    MIN_NON_ZERO(min_io_size, max_io_sectors);
> > > -                opt_io_size =3D
> > > -                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
> > > +                min_io_size =3D MIN(min_io_size ? : 512, max_io_sect=
ors);
> > > +                opt_io_size =3D MIN(opt_io_size ? : 512, max_io_sect=
ors);
> > >               } =20
> >=20
> > This code you're changing was added in d082d16a5c ("consider
> > bl->max_transfer ..").
> > I've borrowed this logic from scsi-generic.c, scsi_read_complete:
> >=20
> > =C2=A0=C2=A0=C2=A0 if (s->type =3D=3D TYPE_DISK &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r->req.cmd.buf[0] =3D=3D INQ=
UIRY &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r->req.cmd.buf[2] =3D=3D 0xb=
0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t max_transfer =3D
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_=
get_max_transfer(s->conf.blk) / s->blocksize;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(max_transfer);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stl_be_p(&r->buf[8], max_tra=
nsfer);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Also take care of the opt=
 xfer len. */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stl_be_p(&r->buf[12],
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12]=
)));
> > =C2=A0=C2=A0=C2=A0 }
> >=20
> >=20
> > Unless I've misunderstood the bug, you will want to change this code to=
o.
> > Otherwise
> > you'll fix it with emulated disks but it might appear when using SCSI
> > passthrough. =20
>=20
> I am assuming (because I don't have a reproducer myself)

Sorry, I should have given you specific reproduce instructions.  You
don't need a POWER host - I've verified that the bug trips under TCG.

  1. Grab a RHEL ppc64le install image (other installers could well
     also hit it, but I haven't tried them)
  2. Build current qemu master, including the ppc64-softmmu target
  3. Create a fresh new guest disk image
        qemu-img create -f qcow2 disk.qcow2 20G
  4. Attempt to install the new guest:
        $QEMU -nodefaults -nographic -machine pseries \
              -cpu POWER8 -smp 1 -m 1G \
              -chardev stdio,id=3Dconmon,mux=3Don,signal=3Doff \
              -device spapr-vty,chardev=3Dconmon \
              -mon conmon \
              -device virtio-scsi-pci,id=3Dscsi \
              -drive file=3Ddisk.qcow2,if=3Dnone,format=3Dqcow2,id=3Dhd \
              -device scsi-disk,drive=3Dhd,bus=3Dscsi.0 \
              -drive file=3DRHEL-7.4-20170711.0-Server-ppc64le-dvd1.iso,for=
mat=3Draw,media=3Dcdrom,if=3Dnone,id=3Dcd \
              -device scsi-cd,drive=3Dcd,bus=3Dscsi.0

That's using the RHEL7.4 GA image, a recent 7.5 snapshot also works as may =
others.

> what matters is
> min_io_size here.
>=20
> David, could you help test if you see the same problem with "-device
> scsi-block"? If we I'll patch scsi-generic.c in v2 too.

I'm not sure exactly what you want me to check here?  You mean putting
the guest disk on a scsi-block instead of scsi-disk?  That's a bit more
fiddly, since I have to find a block device to back it instead of an
image.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/3oQY+0i=UWyvfpUt6ZwlLue
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlq5vhAACgkQbDjKyiDZ
s5L3yw//fzHcjypta0pOAbbcKjm1kZ3aiFgYDYFDAhXs6ITzFQDJHCRlCErE4oL0
bCNUmGLdHZ6BNKJYJDaQGxCadFIzaZQB+xRAWdK5gO2sCNJK3lHp0/Y4EGlAACEg
065EzJ+q2MGI7aWXPPjyNNjaPmcpc/teafbeZoIYru/8o57bc/I5Hkye+hxOY6Tw
9qOnghAF8paed75e9O2yL7OlktLLY/vzL1O4TNCTSv0EEuJvwPc/+VDCDYEwLgm7
/RLeLovs9XSXoq49xM4Ru161A5NHluvwy57nLeGuMjIliLfgocWm3XbggaQxf/vf
ype1ftxakGibu6ip/bGsgB5srYn3gZy8u29EgHszVNJL+nyb+msc44Awxk+OsKiM
YkuDmfVNR3mxrr4ZbTrxgFtGNC2U9hGEPE1CzhWoJjkAiIdJQMJgCdi0d5cQHNFm
papHyWx7gJ+CU64dVIuEED30PPfOMvfOGhdmrH9fJqog28xxbbv76nAiuvFfNWmL
WPJU1hD7wLZVeWEuF/8NYqLmfp00M1GsCsPxv/h23lmJM5zT0U4wpJIVFb4xi5Yw
QwF1Oo0I6T8nfR2lIPlVNQT/8ey95uyYniXIey5aZ4uTxebTtx53OZWxWVYo6k/L
eg/cNtzO+VPs9zpB9q71guEIhjYzwdtNVEfWoBG7arc0pTjW6kc=
=IEk+
-----END PGP SIGNATURE-----

--Sig_/3oQY+0i=UWyvfpUt6ZwlLue--
