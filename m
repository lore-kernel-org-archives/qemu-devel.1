Received: from eggs.gnu.org ([2001:4830:134:3::10]:38917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRMfw-0006cj-UI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRMfv-00050A-FN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:27:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRMfv-0004zp-6z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:27:03 -0500
Date: Wed, 11 Jan 2017 17:26:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170111172655.GH9269@stefanha-x1.localdomain>
References: <38337537-d2f4-6933-f4fe-2092247a199d@cardoe.com>
	<20170109130852.GE2541@work-vm>
	<20170110160154.GD17540@stefanha-x1.localdomain>
	<eb09b932-772f-edcc-abca-a90c2e2d98af@cardoe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <eb09b932-772f-edcc-abca-a90c2e2d98af@cardoe.com>
Subject: Re: [Qemu-devel] assert hit on master with q35 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Goldstein <cardoe@cardoe.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 07:22:24PM -0600, Doug Goldstein wrote:
> On 1/10/17 10:01 AM, Stefan Hajnoczi wrote:
> > On Mon, Jan 09, 2017 at 01:08:53PM +0000, Dr. David Alan Gilbert wrote:
> >> copying in Stefan since it's his commit.
> >=20
> > I can't reproduce the assertion failure.
> >=20
> > Are you able to provide a backtrace (e.g. launch QEMU under gdb and then
> > use the 'bt' command after the assertion failure is raised)?
> >=20
> > Thanks,
> > Stefan
> >=20
>=20
> #0  __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.=
c:58
> #1  0x00007ffff44db3ea in __GI_abort () at abort.c:89
> #2  0x00007ffff44d1bb7 in __assert_fail_base (fmt=3D<optimized out>,
>     assertion=3Dassertion@entry=3D0x555555ae8e8a "vq->notification_disabl=
ed
> > 0",
>     file=3Dfile@entry=3D0x555555ae89c0
> "/home/doug/work/qemu/hw/virtio/virtio.c",
>     line=3Dline@entry=3D215,
>     function=3Dfunction@entry=3D0x555555ae9630 <__PRETTY_FUNCTION__.43707>
> "virtio_queue_set_notification") at assert.c:92
> #3  0x00007ffff44d1c62 in __GI___assert_fail (
>     assertion=3Dassertion@entry=3D0x555555ae8e8a "vq->notification_disabl=
ed
> > 0",
>     file=3Dfile@entry=3D0x555555ae89c0
> "/home/doug/work/qemu/hw/virtio/virtio.c",
>     line=3Dline@entry=3D215,
>     function=3Dfunction@entry=3D0x555555ae9630 <__PRETTY_FUNCTION__.43707>
> "virtio_queue_set_notification") at assert.c:101
> #4  0x00005555557f25d6 in virtio_queue_set_notification (vq=3D0x55555666a=
a90,
>     enable=3Denable@entry=3D1) at /home/doug/work/qemu/hw/virtio/virtio.c=
:215
> #5  0x00005555557dc311 in virtio_net_has_buffers (q=3D<optimized out>,
>     q=3D<optimized out>, bufsize=3D102)
>     at /home/doug/work/qemu/hw/net/virtio-net.c:1008
> #6  virtio_net_receive (nc=3D<optimized out>, buf=3D0x555557386b88 "", si=
ze=3D102)
>     at /home/doug/work/qemu/hw/net/virtio-net.c:1148

Thanks, it's a legitimate bug.  This code still assumes
virtio_queue_set_notification() calls are idempotent.  It needs to be
updated to support nested callers (e.g. virtqueue polling and
virtio-net).

I'll send a patch to address this and CC you.

Stefan

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdmrfAAoJEJykq7OBq3PIcj0IAJWWOSz2DQd9PUXtPBySfCNd
EKSkbL44kxm8OOryFUuaB2N7LUze4in0rNlKVfMedj5ugMV82vrmzmGnID6HFMwJ
BBXSOZGh3BzkqYDxKnEqcNAp5JDc1OjloZifz1NZGv4+AJn5yMt/sXbITzbf5NLU
SHPnOJH+3Hd8un8dK1zEzFsDaE6kgeKRyZfSQJGlVYOBASlQUQkcC6eCEbKQP8Ac
uEiAwW+1ei6pR8MpLyxXylfDpbMullXZ9EhnBMujAsjvANWEFuuZ1FyxHbzmGV6I
OtH3ii+4cZFwzFjqxxiqROx9QtHdGV/bhpK8t4EI7pa+vs81N5qV9hNbaWWOPDE=
=wQUd
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
