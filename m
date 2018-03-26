Received: from eggs.gnu.org ([2001:4830:134:3::10]:46709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f0MWv-0000xX-RF
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f0MWr-0003rc-SZ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:26:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f0MWr-0003np-Ma
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:26:53 -0400
Date: Mon, 26 Mar 2018 15:26:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180326072639.GB31422@lemon.usersys.redhat.com>
References: <20180322073822.25795-1-famz@redhat.com>
	<097f05b7-c628-c529-1c64-a84dc6483f7c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <097f05b7-c628-c529-1c64-a84dc6483f7c@linux.vnet.ibm.com>
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
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, dgibson@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 03/22 09:19, Daniel Henrique Barboza wrote:
> Hi,
>=20
> On 03/22/2018 04:38 AM, Fam Zheng wrote:
> > Some backends report big max_io_sectors. Making min_io_size the same
> > value in this case will make it impossible for guest to align memory,
> > therefore the disk may not be usable at all.
> >=20
> > Change the default behavior (when min_io_size and opt_io_size are not
> > specified in the command line), do not assume max_io_sectors is a goo=
d
> > value for opt_io_size and min_io_size, use 512 instead.
> >=20
> > Reported-by: David Gibson <dgibson@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   hw/scsi/scsi-disk.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > index 5b7a48f5a5..76e3c9eaa4 100644
> > --- a/hw/scsi/scsi-disk.c
> > +++ b/hw/scsi/scsi-disk.c
> > @@ -714,10 +714,8 @@ static int scsi_disk_emulate_inquiry(SCSIRequest=
 *req, uint8_t *outbuf)
> >=20
> >                   /* min_io_size and opt_io_size can't be greater tha=
n
> >                    * max_io_sectors */
> > -                min_io_size =3D
> > -                    MIN_NON_ZERO(min_io_size, max_io_sectors);
> > -                opt_io_size =3D
> > -                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
> > +                min_io_size =3D MIN(min_io_size ? : 512, max_io_sect=
ors);
> > +                opt_io_size =3D MIN(opt_io_size ? : 512, max_io_sect=
ors);
> >               }
>=20
> This code you're changing was added in d082d16a5c ("consider
> bl->max_transfer ..").
> I've borrowed this logic from scsi-generic.c, scsi_read_complete:
>=20
> =A0=A0=A0 if (s->type =3D=3D TYPE_DISK &&
> =A0=A0=A0=A0=A0=A0=A0 r->req.cmd.buf[0] =3D=3D INQUIRY &&
> =A0=A0=A0=A0=A0=A0=A0 r->req.cmd.buf[2] =3D=3D 0xb0) {
> =A0=A0=A0=A0=A0=A0=A0 uint32_t max_transfer =3D
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blk_get_max_transfer(s->conf.blk) / s=
->blocksize;
>=20
> =A0=A0=A0=A0=A0=A0=A0 assert(max_transfer);
> =A0=A0=A0=A0=A0=A0=A0 stl_be_p(&r->buf[8], max_transfer);
> =A0=A0=A0=A0=A0=A0=A0 /* Also take care of the opt xfer len. */
> =A0=A0=A0=A0=A0=A0=A0 stl_be_p(&r->buf[12],
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MIN_NON_ZERO(max_trans=
fer, ldl_be_p(&r->buf[12])));
> =A0=A0=A0 }
>=20
>=20
> Unless I've misunderstood the bug, you will want to change this code to=
o.
> Otherwise
> you'll fix it with emulated disks but it might appear when using SCSI
> passthrough.

I am assuming (because I don't have a reproducer myself) what matters is
min_io_size here.

David, could you help test if you see the same problem with "-device
scsi-block"? If we I'll patch scsi-generic.c in v2 too.

Fam
