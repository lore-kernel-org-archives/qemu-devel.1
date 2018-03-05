Received: from eggs.gnu.org ([2001:4830:134:3::10]:36850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1esnuU-0003eB-9D
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1esnuR-0005YW-4X
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:04:02 -0500
Date: Mon, 5 Mar 2018 11:03:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180305110356.GF7910@stefanha-x1.localdomain>
References: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
	<20180302092318.GA6026@stefanha-x1.localdomain>
	<6a3461c2-368d-1aa1-5b86-a6a602251829@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <6a3461c2-368d-1aa1-5b86-a6a602251829@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [BUG] I/O thread segfault for QEMU on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mreitz@redhat.com, famz@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 10:30:57AM -0500, Farhan Ali wrote:
>=20
>=20
> On 03/02/2018 04:23 AM, Stefan Hajnoczi wrote:
> > On Thu, Mar 01, 2018 at 09:33:35AM -0500, Farhan Ali wrote:
> > > Hi,
> > >=20
> > > I have been noticing some segfaults for QEMU on s390x, and I have been
> > > hitting this issue quite reliably (at least once in 10 runs of a test=
 case).
> > > The qemu version is 2.11.50, and I have systemd created coredumps
> > > when this happens.
> > >=20
> > > Here is a back trace of the segfaulting thread:
> > The backtrace looks normal.
> >=20
> > Please post the QEMU command-line and the details of the segfault (which
> > memory access faulted?).
> >=20
>=20
>=20
> I was able to create another crash today and here is the qemu comand line
>=20
> /usr/bin/qemu-kvm -name guest=3Dsles,debug-threads=3Don \
> -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qe=
mu/domain-2-sles/master-key.aes
> \
> -machine s390-ccw-virtio-2.12,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff=
 \
> -m 4096 -realtime mlock=3Doff -smp 8,sockets=3D8,cores=3D1,threads=3D1 \
> -object iothread,id=3Diothread1 -object iothread,id=3Diothread2 -uuid
> b83a596b-3a1a-4ac9-9f3e-d9a4032ee52c \
> -display none -no-user-config -nodefaults -chardev socket,id=3Dcharmonito=
r,path=3D/var/lib/libvirt/qemu/domain-2-sles/monitor.sock,server,nowait
>=20
> -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -n=
o-shutdown
> \
> -boot strict=3Don -drive file=3D/dev/mapper/360050763998b0883980000002400=
002b,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone,aio=3Dnati=
ve
> -device virtio-blk-ccw,iothread=3Diothread1,scsi=3Doff,devno=3Dfe.0.0001,=
drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1
> -drive file=3D/dev/mapper/360050763998b0883980000002800002f,format=3Draw,=
if=3Dnone,id=3Ddrive-virtio-disk1,cache=3Dnone,aio=3Dnative
> -device virtio-blk-ccw,iothread=3Diothread2,scsi=3Doff,devno=3Dfe.0.0002,=
drive=3Ddrive-virtio-disk1,id=3Dvirtio-disk1
> -netdev tap,fd=3D24,id=3Dhostnet0,vhost=3Don,vhostfd=3D26 -device
> virtio-net-ccw,netdev=3Dhostnet0,id=3Dnet0,mac=3D02:38:a6:36:e8:1f,devno=
=3Dfe.0.0000
> -chardev pty,id=3Dcharconsole0 -device
> sclpconsole,chardev=3Dcharconsole0,id=3Dconsole0 -device
> virtio-balloon-ccw,id=3Dballoon0,devno=3Dfe.3.ffba -msg timestamp=3Don
>=20
>=20
> This the latest back trace on the segfaulting thread, and it seems to
> segfault in swapcontext.
>=20
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  0x000003ff8595202c in swapcontext () from /lib64/libc.so.6

Please include the following gdb output:

  (gdb) disas swapcontext
  (gdb) i r

That way it's possible to see which instruction faulted and which
registers were being accessed.

> This is the remaining back trace:
>=20
> #0  0x000003ff8595202c in swapcontext () from /lib64/libc.so.6
> #1  0x000002aa33b45566 in qemu_coroutine_new () at
> util/coroutine-ucontext.c:164
> #2  0x000002aa33b43eac in qemu_coroutine_create
> (entry=3Dentry@entry=3D0x2aa33a94c98 <blk_aio_write_entry>,
> opaque=3Dopaque@entry=3D0x3ff74018be0) at util/qemu-coroutine.c:76
> #3  0x000002aa33a954da in blk_aio_prwv (blk=3D0x2aa4f0efda0, offset=3D<op=
timized
> out>, bytes=3D<optimized out>, qiov=3D0x3ff74019080,
> co_entry=3Dco_entry@entry=3D0x2aa33a94c98 <blk_aio_write_entry>, flags=3D=
0,
>     cb=3D0x2aa338c62e8 <virtio_blk_rw_complete>, opaque=3D0x3ff74019020) =
at
> block/block-backend.c:1299
> #4  0x000002aa33a9563e in blk_aio_pwritev (blk=3D<optimized out>,
> offset=3D<optimized out>, qiov=3D<optimized out>, flags=3D<optimized out>,
> cb=3D<optimized out>, opaque=3D0x3ff74019020) at block/block-backend.c:14=
00
> #5  0x000002aa338c6a38 in submit_requests (niov=3D<optimized out>, num_re=
qs=3D1,
> start=3D<optimized out>, mrb=3D0x3ff831fe6e0, blk=3D<optimized out>) at
> /usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:369
> #6  virtio_blk_submit_multireq (blk=3D<optimized out>,
> mrb=3Dmrb@entry=3D0x3ff831fe6e0) at
> /usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:426
> #7  0x000002aa338c7b78 in virtio_blk_handle_vq (s=3D0x2aa4f2507c8,
> vq=3D0x3ff869df010) at /usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:=
620
> #8  0x000002aa338ebdf2 in virtio_queue_notify_aio_vq (vq=3D0x3ff869df010)=
 at
> /usr/src/debug/qemu-2.11.50/hw/virtio/virtio.c:1515
> #9  0x000002aa33b2df46 in aio_dispatch_handlers
> (ctx=3Dctx@entry=3D0x2aa4f0ca050) at util/aio-posix.c:406
> #10 0x000002aa33b2eb50 in aio_poll (ctx=3D0x2aa4f0ca050,
> blocking=3Dblocking@entry=3Dtrue) at util/aio-posix.c:692
> #11 0x000002aa33957f6a in iothread_run (opaque=3D0x2aa4f0c9630) at
> iothread.c:60
> #12 0x000003ff86987e82 in start_thread () from /lib64/libpthread.so.0
> #13 0x000003ff85a11596 in thread_start () from /lib64/libc.so.6
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
>=20

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanSQcAAoJEJykq7OBq3PIm7MH/2xwRQnkQ4TkSfK4Yln2XQuC
GD5bU9zXJkCxuwVTF9rNwd38aR5Ol1ljjD72klMCJbu7nIUyflOKwgzKSh7FOGk6
5oEIPgyw5EQbEx7ipAOuGF8oApwnEgGX5IefTClbdONAPGC4JrhO8HnERKHobm1+
WBEqpmiNpTGEqqfefqj9Dg9RMv1/ytwymzLGdjKKFSgMutwWnXs/akso3wxcYUe1
VcIZ1PpoxFldxElPmw6bgvq/fR4SdID4WfeJtAojxCvoHo2UxwPGQc5yOFlbuD1O
yLar6FbFUfm2ButHIKlenIlk4SBP6zluRtxoNaI6Onvh0lcM/unWpabAFy5cD/0=
=D67i
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
