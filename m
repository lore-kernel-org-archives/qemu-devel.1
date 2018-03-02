Received: from eggs.gnu.org ([2001:4830:134:3::10]:50740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1erguq-0006Ci-Ki
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ergun-0003YY-C2
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:23:48 -0500
Date: Fri, 2 Mar 2018 09:23:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180302092318.GA6026@stefanha-x1.localdomain>
References: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
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


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 09:33:35AM -0500, Farhan Ali wrote:
> Hi,
>=20
> I have been noticing some segfaults for QEMU on s390x, and I have been
> hitting this issue quite reliably (at least once in 10 runs of a test cas=
e).
> The qemu version is 2.11.50, and I have systemd created coredumps
> when this happens.
>=20
> Here is a back trace of the segfaulting thread:

The backtrace looks normal.

Please post the QEMU command-line and the details of the segfault (which
memory access faulted?).

> #0  0x000003ffafed202c in swapcontext () from /lib64/libc.so.6
> #1  0x000002aa355c02ee in qemu_coroutine_new () at
> util/coroutine-ucontext.c:164
> #2  0x000002aa355bec34 in qemu_coroutine_create
> (entry=3Dentry@entry=3D0x2aa3550f7a8 <blk_aio_read_entry>,
> opaque=3Dopaque@entry=3D0x3ffa002afa0) at util/qemu-coroutine.c:76
> #3  0x000002aa35510262 in blk_aio_prwv (blk=3D0x2aa65fbefa0, offset=3D<op=
timized
> out>, bytes=3D<optimized out>, qiov=3D0x3ffa002a9c0,
> co_entry=3Dco_entry@entry=3D0x2aa3550f7a8 <blk_aio_read_entry>, flags=3D0,
>     cb=3D0x2aa35340a50 <virtio_blk_rw_complete>, opaque=3D0x3ffa002a960) =
at
> block/block-backend.c:1299
> #4  0x000002aa35510376 in blk_aio_preadv (blk=3D<optimized out>,
> offset=3D<optimized out>, qiov=3D<optimized out>, flags=3D<optimized out>,
> cb=3D<optimized out>, opaque=3D0x3ffa002a960) at block/block-backend.c:13=
92
> #5  0x000002aa3534114e in submit_requests (niov=3D<optimized out>,
> num_reqs=3D<optimized out>, start=3D<optimized out>, mrb=3D<optimized out=
>,
> blk=3D<optimized out>) at
> /usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:372
> #6  virtio_blk_submit_multireq (blk=3D<optimized out>,
> mrb=3Dmrb@entry=3D0x3ffad77e640) at
> /usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:402
> #7  0x000002aa353422e0 in virtio_blk_handle_vq (s=3D0x2aa6611e7d8,
> vq=3D0x3ffb0f5f010) at /usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:=
620
> #8  0x000002aa3536655a in virtio_queue_notify_aio_vq
> (vq=3Dvq@entry=3D0x3ffb0f5f010) at
> /usr/src/debug/qemu-2.11.50/hw/virtio/virtio.c:1515
> #9  0x000002aa35366cd6 in virtio_queue_notify_aio_vq (vq=3D0x3ffb0f5f010)=
 at
> /usr/src/debug/qemu-2.11.50/hw/virtio/virtio.c:1511
> #10 virtio_queue_host_notifier_aio_poll (opaque=3D0x3ffb0f5f078) at
> /usr/src/debug/qemu-2.11.50/hw/virtio/virtio.c:2409
> #11 0x000002aa355a8ba4 in run_poll_handlers_once
> (ctx=3Dctx@entry=3D0x2aa65f99310) at util/aio-posix.c:497
> #12 0x000002aa355a9b74 in run_poll_handlers (max_ns=3D<optimized out>,
> ctx=3D0x2aa65f99310) at util/aio-posix.c:534
> #13 try_poll_mode (blocking=3Dtrue, ctx=3D0x2aa65f99310) at util/aio-posi=
x.c:562
> #14 aio_poll (ctx=3D0x2aa65f99310, blocking=3Dblocking@entry=3Dtrue) at
> util/aio-posix.c:602
> #15 0x000002aa353d2d0a in iothread_run (opaque=3D0x2aa65f990f0) at
> iothread.c:60
> #16 0x000003ffb0f07e82 in start_thread () from /lib64/libpthread.so.0
> #17 0x000003ffaff91596 in thread_start () from /lib64/libc.so.6
>=20
>=20
> I don't have much knowledge about i/o threads and the block layer code in
> QEMU, so I would like to report to the community about this issue.
> I believe this very similar to the bug that I reported upstream couple of
> days ago
> (https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04452.html).
>=20
> Any help would be greatly appreciated.
>=20
> Thanks
> Farhan
>=20

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJamRgGAAoJEJykq7OBq3PI/+EH/R/cAJDMD+oDd/B+tK9u3n3E
KZdSeMO3/D9fkxZblUq+GpNix5+OtXZy1ca66GiiYq52yuJ+gf0pYgMyZGUq3DuZ
Om2emUDq5W9+YpyLX9Cc7UxvOHxcDxWLv+nOm9gq+HWf+yEhoy7j0IxVh3bXmJf0
1lv3gAnYWbE/P0ANMJAY4LFdDU+ZaaONLKksOH+tXM+PsJgKolKi/7UJO/AWyiwx
XHtlAQo7GJyznAoJtWBiKQ9tK10WrnFv6JchwtoVLliFyFKNOOZhvK2vTyC32lLB
NL4XtmCjJ3d4yDI+GGI3RjRxh3pOroH7e5Y6Wc5WQLZxfZv3CnEUUysJ6cZmXvI=
=phVF
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
