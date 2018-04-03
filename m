Received: from eggs.gnu.org ([2001:4830:134:3::10]:55377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f3SkJ-0005tV-E5
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 16:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f3SkG-0001Mw-8J
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 16:41:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1f3SkF-0001MZ-Vn
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 16:41:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w33KefLR108320
	for <qemu-devel@nongnu.org>; Tue, 3 Apr 2018 16:41:29 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h4fuqb3md-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 16:41:29 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 3 Apr 2018 16:41:28 -0400
References: <20180402032336.31834-1-famz@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 3 Apr 2018 17:41:24 -0300
MIME-Version: 1.0
In-Reply-To: <20180402032336.31834-1-famz@redhat.com>
Content-Language: en-US
Message-Id: <daef9368-e5b6-2eb9-70fa-3f5a6c1db6a0@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scsi-block: Handle error from host devices
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

Hi Fam,

I've tried this patch and found issues when booting a VM using SCSI=20
passthrough. This is the backtrace from gdb from the segfault that=20
happens in the middle of kernel boot:

Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ffff7ff63a0 (LWP 16830)]
0x0000000000000000 in ?? ()
(gdb) bt
#0=C2=A0 0x0000000000000000 in ?? ()
#1=C2=A0 0x00000001007b8da8 in scsi_block_sgio_cb (opaque=3D0x10212e580, =
ret=3D0)=20
at /home/danielhb/qemu/hw/scsi/scsi-disk.c:2772
#2=C2=A0 0x0000000100993f68 in blk_aio_complete (acb=3D0x101909520) at=20
/home/danielhb/qemu/block/block-backend.c:1331
#3=C2=A0 0x0000000100994ccc in blk_aio_ioctl_entry (opaque=3D0x101909520)=
 at=20
/home/danielhb/qemu/block/block-backend.c:1542
#4=C2=A0 0x0000000100ac0954 in coroutine_trampoline (i0=3D28666944, i1=3D=
1) at=20
/home/danielhb/qemu/util/coroutine-ucontext.c:116
#5=C2=A0 0x00007ffff789574c in makecontext () at=20
../sysdeps/unix/sysv/linux/powerpc/powerpc64/makecontext.S:136
#6=C2=A0 0x0000000000000000 in ?? ()

The segfault is happening at this line:

static void scsi_block_sgio_cb(void *opaque, int ret)
{
 =C2=A0=C2=A0=C2=A0 SCSIBlockReq *req =3D opaque;

 =C2=A0=C2=A0=C2=A0 if (!ret &&
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (req->io_header.status ||
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->io_header.host_sta=
tus ||
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->io_header.driver_s=
tatus)) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
 =C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0 req->cb(req->cb_opaque, ret); <-----------------
}


This is happening because inside scsi_block_do_sgio you're not setting=20
req->cb, just req->cb_opaque. Setting req->cb made the VM boot again:


--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2851,6 +2851,7 @@ static BlockAIOCB *scsi_block_do_sgio(SCSIBlockReq=20
*req,
 =C2=A0=C2=A0=C2=A0=C2=A0 io_header->usr_ptr =3D r;
 =C2=A0=C2=A0=C2=A0=C2=A0 io_header->flags |=3D SG_FLAG_DIRECT_IO;

+=C2=A0=C2=A0=C2=A0 req->cb =3D cb;
 =C2=A0=C2=A0=C2=A0=C2=A0 req->cb_opaque =3D opaque;
 =C2=A0=C2=A0=C2=A0=C2=A0 aiocb =3D blk_aio_ioctl(s->qdev.conf.blk, SG_IO=
, io_header,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 scsi_block_sgio_cb, req);




Thanks,


Daniel

On 04/02/2018 12:23 AM, Fam Zheng wrote:
> The callback of blk_aio_ioctl is not sensible to SCSI errors, so
> werror=3Dstop doesn't work if ioctl returns 0 but the scsi status is
> error.
>
> Peek at the sg_io_hdr_t fields and amend ret to fix that.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   hw/scsi/scsi-disk.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index f5ab767ab5..2c43830586 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2651,10 +2651,26 @@ typedef struct SCSIBlockReq {
>       /* Selected bytes of the original CDB, copied into our own CDB.  =
*/
>       uint8_t cmd, cdb1, group_number;
>
> +    BlockCompletionFunc *cb;
> +    void *cb_opaque;
> +
>       /* CDB passed to SG_IO.  */
>       uint8_t cdb[16];
>   } SCSIBlockReq;
>
> +static void scsi_block_sgio_cb(void *opaque, int ret)
> +{
> +    SCSIBlockReq *req =3D opaque;
> +
> +    if (!ret &&
> +        (req->io_header.status ||
> +         req->io_header.host_status ||
> +         req->io_header.driver_status)) {
> +        ret =3D -EIO;
> +    }
> +    req->cb(req->cb_opaque, ret);
> +}
> +
>   static BlockAIOCB *scsi_block_do_sgio(SCSIBlockReq *req,
>                                         int64_t offset, QEMUIOVector *i=
ov,
>                                         int direction,
> @@ -2734,7 +2750,9 @@ static BlockAIOCB *scsi_block_do_sgio(SCSIBlockRe=
q *req,
>       io_header->usr_ptr =3D r;
>       io_header->flags |=3D SG_FLAG_DIRECT_IO;
>
> -    aiocb =3D blk_aio_ioctl(s->qdev.conf.blk, SG_IO, io_header, cb, op=
aque);
> +    req->cb_opaque =3D opaque;
> +    aiocb =3D blk_aio_ioctl(s->qdev.conf.blk, SG_IO, io_header,
> +                          scsi_block_sgio_cb, req);
>       assert(aiocb !=3D NULL);
>       return aiocb;
>   }
