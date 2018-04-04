Received: from eggs.gnu.org ([2001:4830:134:3::10]:35983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3XRw-00057p-DK
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 21:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3XRt-00017P-Ah
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 21:42:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f3XRt-00017C-4x
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 21:42:53 -0400
Date: Wed, 4 Apr 2018 09:42:50 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180404014250.GG6839@lemon.usersys.redhat.com>
References: <20180402032336.31834-1-famz@redhat.com>
	<daef9368-e5b6-2eb9-70fa-3f5a6c1db6a0@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <daef9368-e5b6-2eb9-70fa-3f5a6c1db6a0@linux.vnet.ibm.com>
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
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 04/03 17:41, Daniel Henrique Barboza wrote:
> Hi Fam,
>=20
> I've tried this patch and found issues when booting a VM using SCSI
> passthrough. This is the backtrace from gdb from the segfault that happ=
ens
> in the middle of kernel boot:
>=20
> Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7ffff7ff63a0 (LWP 16830)]
> 0x0000000000000000 in ?? ()
> (gdb) bt
> #0=A0 0x0000000000000000 in ?? ()
> #1=A0 0x00000001007b8da8 in scsi_block_sgio_cb (opaque=3D0x10212e580, r=
et=3D0) at
> /home/danielhb/qemu/hw/scsi/scsi-disk.c:2772
> #2=A0 0x0000000100993f68 in blk_aio_complete (acb=3D0x101909520) at
> /home/danielhb/qemu/block/block-backend.c:1331
> #3=A0 0x0000000100994ccc in blk_aio_ioctl_entry (opaque=3D0x101909520) =
at
> /home/danielhb/qemu/block/block-backend.c:1542
> #4=A0 0x0000000100ac0954 in coroutine_trampoline (i0=3D28666944, i1=3D1=
) at
> /home/danielhb/qemu/util/coroutine-ucontext.c:116
> #5=A0 0x00007ffff789574c in makecontext () at
> ../sysdeps/unix/sysv/linux/powerpc/powerpc64/makecontext.S:136
> #6=A0 0x0000000000000000 in ?? ()
>=20
> The segfault is happening at this line:
>=20
> static void scsi_block_sgio_cb(void *opaque, int ret)
> {
> =A0=A0=A0 SCSIBlockReq *req =3D opaque;
>=20
> =A0=A0=A0 if (!ret &&
> =A0=A0=A0=A0=A0=A0=A0 (req->io_header.status ||
> =A0=A0=A0=A0=A0=A0=A0=A0 req->io_header.host_status ||
> =A0=A0=A0=A0=A0=A0=A0=A0 req->io_header.driver_status)) {
> =A0=A0=A0=A0=A0=A0=A0 ret =3D -EIO;
> =A0=A0=A0 }
> =A0=A0=A0 req->cb(req->cb_opaque, ret); <-----------------
> }
>=20
>=20
> This is happening because inside scsi_block_do_sgio you're not setting
> req->cb, just req->cb_opaque. Setting req->cb made the VM boot again:

Oops, thanks. Apparently I failed to test my patch, sorry. :(

Fam
