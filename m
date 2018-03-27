Received: from eggs.gnu.org ([2001:4830:134:3::10]:50770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f0rSI-0005E7-SP
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f0rSF-0005m1-D9
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:28:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f0rSF-0005lP-76
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:28:11 -0400
Date: Wed, 28 Mar 2018 00:28:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180327162807.GJ31422@lemon.usersys.redhat.com>
References: <20180322073822.25795-1-famz@redhat.com>
	<097f05b7-c628-c529-1c64-a84dc6483f7c@linux.vnet.ibm.com>
	<20180326072639.GB31422@lemon.usersys.redhat.com>
	<20180327144416.2ed36b8e@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180327144416.2ed36b8e@umbus.fritz.box>
Content-Transfer-Encoding: quoted-printable
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
To: David Gibson <dgibson@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 03/27 14:44, David Gibson wrote:
> On Mon, 26 Mar 2018 15:26:39 +0800
> Fam Zheng <famz@redhat.com> wrote:
>=20
> > On Thu, 03/22 09:19, Daniel Henrique Barboza wrote:
> > > Hi,
> > >=20
> > > On 03/22/2018 04:38 AM, Fam Zheng wrote: =20
> > > > Some backends report big max_io_sectors. Making min_io_size the s=
ame
> > > > value in this case will make it impossible for guest to align mem=
ory,
> > > > therefore the disk may not be usable at all.
> > > >=20
> > > > Change the default behavior (when min_io_size and opt_io_size are=
 not
> > > > specified in the command line), do not assume max_io_sectors is a=
 good
> > > > value for opt_io_size and min_io_size, use 512 instead.
> > > >=20
> > > > Reported-by: David Gibson <dgibson@redhat.com>
> > > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > > ---
> > > >   hw/scsi/scsi-disk.c | 6 ++----
> > > >   1 file changed, 2 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > > > index 5b7a48f5a5..76e3c9eaa4 100644
> > > > --- a/hw/scsi/scsi-disk.c
> > > > +++ b/hw/scsi/scsi-disk.c
> > > > @@ -714,10 +714,8 @@ static int scsi_disk_emulate_inquiry(SCSIReq=
uest *req, uint8_t *outbuf)
> > > >=20
> > > >                   /* min_io_size and opt_io_size can't be greater=
 than
> > > >                    * max_io_sectors */
> > > > -                min_io_size =3D
> > > > -                    MIN_NON_ZERO(min_io_size, max_io_sectors);
> > > > -                opt_io_size =3D
> > > > -                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
> > > > +                min_io_size =3D MIN(min_io_size ? : 512, max_io_=
sectors);
> > > > +                opt_io_size =3D MIN(opt_io_size ? : 512, max_io_=
sectors);
> > > >               } =20
> > >=20
> > > This code you're changing was added in d082d16a5c ("consider
> > > bl->max_transfer ..").
> > > I've borrowed this logic from scsi-generic.c, scsi_read_complete:
> > >=20
> > > =A0=A0=A0 if (s->type =3D=3D TYPE_DISK &&
> > > =A0=A0=A0=A0=A0=A0=A0 r->req.cmd.buf[0] =3D=3D INQUIRY &&
> > > =A0=A0=A0=A0=A0=A0=A0 r->req.cmd.buf[2] =3D=3D 0xb0) {
> > > =A0=A0=A0=A0=A0=A0=A0 uint32_t max_transfer =3D
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blk_get_max_transfer(s->conf.blk)=
 / s->blocksize;
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0 assert(max_transfer);
> > > =A0=A0=A0=A0=A0=A0=A0 stl_be_p(&r->buf[8], max_transfer);
> > > =A0=A0=A0=A0=A0=A0=A0 /* Also take care of the opt xfer len. */
> > > =A0=A0=A0=A0=A0=A0=A0 stl_be_p(&r->buf[12],
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MIN_NON_ZERO(max_t=
ransfer, ldl_be_p(&r->buf[12])));
> > > =A0=A0=A0 }
> > >=20
> > >=20
> > > Unless I've misunderstood the bug, you will want to change this cod=
e too.
> > > Otherwise
> > > you'll fix it with emulated disks but it might appear when using SC=
SI
> > > passthrough. =20
> >=20
> > I am assuming (because I don't have a reproducer myself)
>=20
> Sorry, I should have given you specific reproduce instructions.  You
> don't need a POWER host - I've verified that the bug trips under TCG.
>=20
>   1. Grab a RHEL ppc64le install image (other installers could well
>      also hit it, but I haven't tried them)
>   2. Build current qemu master, including the ppc64-softmmu target
>   3. Create a fresh new guest disk image
>         qemu-img create -f qcow2 disk.qcow2 20G
>   4. Attempt to install the new guest:
>         $QEMU -nodefaults -nographic -machine pseries \
>               -cpu POWER8 -smp 1 -m 1G \
>               -chardev stdio,id=3Dconmon,mux=3Don,signal=3Doff \
>               -device spapr-vty,chardev=3Dconmon \
>               -mon conmon \
>               -device virtio-scsi-pci,id=3Dscsi \
>               -drive file=3Ddisk.qcow2,if=3Dnone,format=3Dqcow2,id=3Dhd=
 \
>               -device scsi-disk,drive=3Dhd,bus=3Dscsi.0 \
>               -drive file=3DRHEL-7.4-20170711.0-Server-ppc64le-dvd1.iso=
,format=3Draw,media=3Dcdrom,if=3Dnone,id=3Dcd \
>               -device scsi-cd,drive=3Dcd,bus=3Dscsi.0
>=20
> That's using the RHEL7.4 GA image, a recent 7.5 snapshot also works as =
may others.

Thanks, your reproducer works. So I've verified that fixing min_io_size a=
lone
will eliminate the problem.

So there is no such problem for scsi-block.  Of course aligning opt_io_si=
ze up
to max_io_size is dubious but as far as fixing guest I/O, I think touchin=
g up
scsi-disk is okay. I'll address Paolo's comments and post v2.

Fam
