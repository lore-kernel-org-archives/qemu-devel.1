Received: from eggs.gnu.org ([2001:4830:134:3::10]:51933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eyzBY-0002sH-MQ
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eyzBV-0007T5-EL
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:19:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54858
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eyzBV-0007Si-7W
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:19:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2MCEGka040530
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 08:19:08 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gvc0es6rx-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 08:19:07 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 22 Mar 2018 06:19:07 -0600
References: <20180322073822.25795-1-famz@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 09:19:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180322073822.25795-1-famz@redhat.com>
Content-Language: en-US
Message-Id: <097f05b7-c628-c529-1c64-a84dc6483f7c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Hi,

On 03/22/2018 04:38 AM, Fam Zheng wrote:
> Some backends report big max_io_sectors. Making min_io_size the same
> value in this case will make it impossible for guest to align memory,
> therefore the disk may not be usable at all.
>
> Change the default behavior (when min_io_size and opt_io_size are not
> specified in the command line), do not assume max_io_sectors is a good
> value for opt_io_size and min_io_size, use 512 instead.
>
> Reported-by: David Gibson <dgibson@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   hw/scsi/scsi-disk.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 5b7a48f5a5..76e3c9eaa4 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -714,10 +714,8 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *=
req, uint8_t *outbuf)
>
>                   /* min_io_size and opt_io_size can't be greater than
>                    * max_io_sectors */
> -                min_io_size =3D
> -                    MIN_NON_ZERO(min_io_size, max_io_sectors);
> -                opt_io_size =3D
> -                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
> +                min_io_size =3D MIN(min_io_size ? : 512, max_io_sector=
s);
> +                opt_io_size =3D MIN(opt_io_size ? : 512, max_io_sector=
s);
>               }

This code you're changing was added in d082d16a5c ("consider=20
bl->max_transfer ..").
I've borrowed this logic from scsi-generic.c, scsi_read_complete:

 =C2=A0=C2=A0=C2=A0 if (s->type =3D=3D TYPE_DISK &&
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r->req.cmd.buf[0] =3D=3D INQU=
IRY &&
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r->req.cmd.buf[2] =3D=3D 0xb0=
) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t max_transfer =3D
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_g=
et_max_transfer(s->conf.blk) / s->blocksize;

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(max_transfer);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stl_be_p(&r->buf[8], max_tran=
sfer);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Also take care of the opt =
xfer len. */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stl_be_p(&r->buf[12],
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])=
));
 =C2=A0=C2=A0=C2=A0 }


Unless I've misunderstood the bug, you will want to change this code=20
too. Otherwise
you'll fix it with emulated disks but it might appear when using SCSI=20
passthrough.


Thanks,


Daniel


>               /* required VPD size with unmap support */
>               buflen =3D 0x40;
