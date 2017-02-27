Received: from eggs.gnu.org ([2001:4830:134:3::10]:49524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLOr-0000QI-DM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLOn-0006CW-Gp
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:31:37 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciLOn-0006CK-9i
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:31:33 -0500
Received: by mail-wr0-x236.google.com with SMTP id g10so52208081wrg.2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:31:33 -0800 (PST)
Date: Mon, 27 Feb 2017 13:31:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227133130.GS28403@stefanha-x1.localdomain>
References: <20170227094050.ia6nrkvtvzmg7b2q@XZHOUW.usersys.redhat.com>
	<20170227101104.GB28403@stefanha-x1.localdomain>
	<20170227125003.fegyd7gbrfdvrwjv@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yBTw3iMQSKDA2CaE"
Content-Disposition: inline
In-Reply-To: <20170227125003.fegyd7gbrfdvrwjv@XZHOUW.usersys.redhat.com>
Subject: Re: [Qemu-devel] Fail to start 2nd guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiong Zhou <xzhou@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, libvir-list@redhat.com


--yBTw3iMQSKDA2CaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 08:50:03PM +0800, Xiong Zhou wrote:
> On Mon, Feb 27, 2017 at 10:11:04AM +0000, Stefan Hajnoczi wrote:
> > On Mon, Feb 27, 2017 at 05:40:50PM +0800, Xiong Zhou wrote:
> > > It worked fine on Linus tree commit:
> > >   7bb0338 Merge tag 'rodata-v4.11-rc1' of git://git.kernel.org/pub/sc=
m/..
> > >=20
> > > failed to start 2nd domain on this commit:
> > > 37c8596 Merge tag 'tty-4.11-rc1' of git://git.kernel.org/pub/scm/..
> > > (this commit probably is not the first bad, i didn't do the bisecting)
> > >=20
> > >=20
> > > sh-4.2# uname -r
> > > 4.10.0-master-37c8596+
> > > sh-4.2# rpm -qv qemu
> > > qemu-2.0.0-1.el7.6.x86_64
> > > sh-4.2# ps ajxf | grep qemu
> > > ...
> > > sh-4.2# virsh list
> > >  Id    Name                           State
> > > ----------------------------------------------------
> > >  1     73h                            running
> > >=20
> > > sh-4.2# virsh start 73us
> > > error: Failed to start domain 73us
> > > error: internal error: qemu unexpectedly closed the monitor: ((null):=
11497): Spice-Warning **: reds.c:2499:reds_init_socket: listen: Address alr=
eady in use
> > > 2017-02-27T09:33:42.335708Z qemu-kvm: failed to initialize spice serv=
er
> >=20
> > The error message says that the spice remote desktop cannot listen on
> > -spice port=3D5900,addr=3D127.0.0.1.
> >=20
> > Did you hardcode port 5900 in the domain XML?  That could explain why
> No.
> > the second guest fails to launch - you need to use unique port numbers
> > or let libvirt automatically assign them.  Check the domain XML:
> >=20
> >   <graphics type=3D'spice' port=3D'-1' tlsPort=3D'-1' autoport=3D'yes'>
>=20
> It looks like:
>=20
>     <graphics type=3D'spice' autoport=3D'yes'>
>       <listen type=3D'address'/>
>       <image compression=3D'off'/>
>     </graphics>
>=20
>=20
> >=20
> > Another possibility is that a process running on the host is already
> > using port 5900.  Perhaps a guest or VNC server that was launched
> > outside of libvirt?  You can check this with:
> >=20
> >   netstat -alpn | grep 5900
> # netstat -alpn | grep 5900
> tcp        0      0 127.0.0.1:5900          0.0.0.0:*               LISTE=
N      11065/qemu-kvm     =20

Please check that 11065/qemu-kvm was launched by the same libvirtd and
its domain XML also uses autoport=3D'yes'.

I have CCed the libvirt mailing list because they may be able to explain
why there is a collision on TCP port 5900.

Stefan

--yBTw3iMQSKDA2CaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCoyAAoJEJykq7OBq3PIgAwIALHkaMSglM/AqSbiYC6fyr6a
Z9/jQrF308fic5fCWUuZKVY0nxHNQiRw1P2ob74nGxy+06YM0B8/V3xX2xQ1HmGg
RVczF2nnxBiamYP0r4EVpajKkQjm6dTavoFtdPI8wLzMsQtdQt8Pocko+cWw5EXs
4/LF3iqBMyFn/Cw5HT3Bhbbcrlmlg3ql02SDPknTq32fChEzT7C1/mpLMkvMo/kE
kPsDjJ5QbR2sO2kXVeY31Fll+qZXPt2MZRN8dKAgEed22hh2sF1i7+RTmzVafvRM
s22RJwWnArKMI6c+/Wg+40DC+YHXPpgOfn1AZPc0hEcrh/ySS+mWzvzb7OjFFZc=
=p7L1
-----END PGP SIGNATURE-----

--yBTw3iMQSKDA2CaE--
