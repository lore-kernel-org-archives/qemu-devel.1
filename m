Received: from eggs.gnu.org ([2001:4830:134:3::10]:52741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJejh-0003kS-UO
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJejc-0004Ha-V5
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:07:05 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cJejc-0004HO-PD
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:07:00 -0500
Received: by mail-wm0-x244.google.com with SMTP id m203so29752707wma.3
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 03:07:00 -0800 (PST)
Date: Wed, 21 Dec 2016 11:06:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161221110657.GD9482@stefanha-x1.localdomain>
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20161219150230.GA20757@stefanha-x1.localdomain>
	<20161219163214.GA9801@lemon>
	<20161220093938.GB5602@stefanha-x1.localdomain>
	<d6502c6d-616c-66dc-9c49-0fff7f1ee28c@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <d6502c6d-616c-66dc-9c49-0fff7f1ee28c@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/4] block/qapi: refactor and
 optimize the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2016 at 05:13:39PM +0800, Dou Liyang wrote:
> Hi Stefan,
>=20
> At 12/20/2016 05:39 PM, Stefan Hajnoczi wrote:
> > On Tue, Dec 20, 2016 at 12:32:40AM +0800, Fam Zheng wrote:
> > > On Mon, 12/19 15:02, Stefan Hajnoczi wrote:
> > > > On Mon, Dec 19, 2016 at 04:51:22PM +0800, Dou Liyang wrote:
> > > > > These patches aim to refactor the qmp_query_blockstats() and
> > > > > improve the performance by reducing the running time of it.
> > > > >=20
> > > > > qmp_query_blockstats() is used to monitor the blockstats, it
> > > > > querys all the graph_bdrv_states or monitor_block_backends.
> > > > >=20
> > > > > There are the two jobs:
> > > > >=20
> > > > > 1 For the performance:
> > > > >=20
> > > > > 1.1 the time it takes(ns) in each time:
> > > > > the disk numbers     | 10    | 500
> > > > > -------------------------------------
> > > > > before these patches | 19429 | 667722
> > > > > after these patches  | 17516 | 557044
> > > > >=20
> > > > > 1.2 the I/O performance is degraded(%) during the monitor:
> > > > >=20
> > > > > the disk numbers     | 10    | 500
> > > > > -------------------------------------
> > > > > before these patches | 1.3   | 14.2
> > > > > after these patches  | 0.8   | 9.1
> > > >=20
> > > > Do you know what is consuming the remaining 9.1%?
> > > >=20
> > > > I'm surprised to see such a high performance impact caused by a QMP
> > > > command.
> > >=20
> > > If it's "performance is 9.1% worse only during the 557044 ns when the=
 QMP
> > > command is being processed", it's probably becaues the main loop is s=
talled a
> > > bit, and it's not a big problem. I'd be very surprised if the degrada=
tion is
> > > more longer than that.
> >=20
> > It would be interesting to compare against virtio-blk dataplane.  That
> > way the QMP command can execute without interfering with disk I/O activ=
ity.
> >=20
> > qemu-system-x86_64 ... \
> >     -object iothread,id=3Diothread0 \
> >     -drive if=3Dnone,id=3Ddrive0,file=3Dvm.img,format=3Draw,aio=3Dnativ=
e,cache=3Dnone \
> >     -device virtio-blk-pci,drive=3Ddrive0,iothread=3Diothread0
>=20
> Here is the result in the guest with 500 disks:
>=20
> QMP command     | not execute | execute in each 0.5s |
> -------------------------------------------------------
> Average Times/s | 102.34675   | 103.128              |
>=20
> the degradation is 0.76%, that can be ignored.
>=20
> the dd command:
> dd if=3Ddate_1.dat of=3Ddate_2.dat conv=3Dfsync oflag=3Ddirect bs=3D1k co=
unt=3D400k

Excellent.  It's good to know that dataplane is a solution to this
problem.

Stefan

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYWmJRAAoJEJykq7OBq3PIGaAIAJY6c2Sbmdoe2uKH2M5LSpJi
CrnkKaH2+ZMW+zlyVnhNv/qIbWmE0Phicx8InPEZ9+986SO8757j4yhzz9G017/1
G0Gp/fPnHyNAJTMrWtwxcj3Gp7Dwn4HEHjXjUW3WAHWiJNhiqFPDJT7WA2k8szU8
InflacPeLRnZGF0d1zo3IeiG5n0pHxSB/A+Lp/08L1j7KLo/jKU2qHq4AxACk+I1
w4cMWm1K0Uf0K24L9UyV70xZaaP7P0WAYFTb1I+HNgdrkvC6ax0BY8Gmr10XNLZX
jFeTC68EZDJeoB5ecnFyqqu5FdOpGv8FJXM6cZYs+JuY0n6RMjcoPuhyEl8qpTA=
=fr9j
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
