Received: from eggs.gnu.org ([2001:4830:134:3::10]:55074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQ9qc-0002MJ-F5
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQ9qZ-0002Lm-BB
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:05:22 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dQ9qZ-0002LP-1h
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:05:19 -0400
Received: by mail-wm0-x22c.google.com with SMTP id b184so53033422wme.1
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 03:05:18 -0700 (PDT)
Date: Wed, 28 Jun 2017 11:05:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170628100515.GB29104@stefanha-x1.localdomain>
References: <20170622140827.GA29936@stefanha-x1.localdomain>
	<20170623001313.n6cms5sunwuqnf4h@hz-desktop>
	<20170623095522.GB12689@stefanha-x1.localdomain>
	<20170626020501.xq54xlnqmhika3zw@hz-desktop>
	<20170626125651.GA7776@stefanha-x1.localdomain>
	<20170627143001.jsfmxqnaig7nfawx@hz-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20170627143001.jsfmxqnaig7nfawx@hz-desktop>
Subject: Re: [Qemu-devel] NVDIMM live migration broken?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 10:30:01PM +0800, Haozhong Zhang wrote:
> On 06/26/17 13:56 +0100, Stefan Hajnoczi wrote:
> > On Mon, Jun 26, 2017 at 10:05:01AM +0800, Haozhong Zhang wrote:
> > > On 06/23/17 10:55 +0100, Stefan Hajnoczi wrote:
> > > > On Fri, Jun 23, 2017 at 08:13:13AM +0800, haozhong.zhang@intel.com =
wrote:
> > > > > On 06/22/17 15:08 +0100, Stefan Hajnoczi wrote:
> > > > > > I tried live migrating a guest with NVDIMM on qemu.git/master (=
edf8bc984):
> > > > > >=20
> > > > > >   $ qemu -M accel=3Dkvm,nvdimm=3Don -m 1G,slots=3D4,maxmem=3D8G=
 -cpu host \
> > > > > >          -object memory-backend-file,id=3Dmem1,share=3Don,mem-p=
ath=3Dnvdimm.dat,size=3D1G \
> > > > > > 	 -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1 \
> > > > > > 	 -drive if=3Dvirtio,file=3Dtest.img,format=3Draw
> > > > > >=20
> > > > > >   $ qemu -M accel=3Dkvm,nvdimm=3Don -m 1G,slots=3D4,maxmem=3D8G=
 -cpu host \
> > > > > >          -object memory-backend-file,id=3Dmem1,share=3Don,mem-p=
ath=3Dnvdimm.dat,size=3D1G \
> > > > > > 	 -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1 \
> > > > > > 	 -drive if=3Dvirtio,file=3Dtest.img,format=3Draw \
> > > > > > 	 -incoming tcp::1234
> > > > > >=20
> > > > > >   (qemu) migrate tcp:127.0.0.1:1234
> > > > > >=20
> > > > > > The guest kernel panics or hangs every time on the destination.=
  It
> > > > > > happens as long as the nvdimm device is present - I didn't even=
 mount it
> > > > > > inside the guest.
> > > > > >=20
> > > > > > Is migration expected to work?
> > > > >=20
> > > > > Yes, I tested on QEMU 2.8.0 several months ago and it worked. I'll
> > > > > have a look at this issue.
> > > >=20
> > > > Great, thanks!
> > > >=20
> > > > David Gilbert suggested the following on IRC, it sounds like a good
> > > > starting point for debugging:
> > > >=20
> > > > Launch the destination QEMU with -S (vcpus will be paused) and after
> > > > migration has completed, compare the NVDIMM contents on source and
> > > > destination.
> > > >=20
> > >=20
> > > Which host and guest kernel are you testing? Is any workload running
> > > in guest when migration?
> > >=20
> > > I just tested QEMU commit edf8bc984 with host/guest kernel 4.8.0, and
> > > could not reproduce the issue.
> >=20
> > I can still reproduce the problem on qemu.git edf8bc984.
> >=20
> > My guest kernel is fairly close to yours.  The host kernel is newer.
> >=20
> > Host kernel: 4.11.6-201.fc25.x86_64
> > Guest kernel: 4.8.8-300.fc25.x86_64
> >=20
> > Command-line:
> >=20
> >   qemu-system-x86_64 \
> >       -enable-kvm \
> >       -cpu host \
> >       -machine pc,nvdimm \
> >       -m 1G,slots=3D4,maxmem=3D8G \
> >       -object memory-backend-file,id=3Dmem1,share=3Don,mem-path=3Dnvdim=
m.dat,size=3D1G \
> >       -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1 \
> >       -drive if=3Dvirtio,file=3Dtest.img,format=3Draw \
> >       -display none \
> >       -serial stdio \
> >       -monitor unix:/tmp/monitor.sock,server,nowait
> >=20
> > Start migration at the guest login prompt.  You don't need to log in or
> > do anything inside the guest.
> >=20
> > There seems to be a guest RAM corruption because I get different
> > backtraces inside the guest every time.
> >=20
> > The problem goes away if I remove -device nvdimm.
> >=20
>=20
> I managed to reproduce this bug. After bisect between good v2.8.0 and
> bad edf8bc984, it looks a regression introduced by
>     6b6712efccd "ram: Split dirty bitmap by RAMBlock"
> This commit may result in guest crash after migration if any host
> memory backend is used.
>=20
> Could you test whether the attached draft patch fixes this bug? If yes,
> I will make a formal patch later.

Thanks for the fix!  I tested and replied to your v2 patch.

Stefan

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZU39bAAoJEJykq7OBq3PIUOYH/iBizDzwzz2isn6VADMyvrao
gBfdYg8VcL31urczZHEsEQBvigy6ut1oXniwDDw+q6mcfKEQ2UV05ZBFG/+0y20v
L3MFqMj3G4g6QS33m0jmsAv43VDu6RmFivVKMruenyEx36sfIATrAWXVcT90410b
Pk6ESReADVCImGAa/dxEybx8xdElo6tNhVgYl9frHMK5UAvj7qVcyjQ+aI8mOl2g
ExJ7NWhvoa9l965pvtfFbVuKsrfDolBlSApUlMSG7vEYX+o2dw0iSyjIyF5bIvh+
Kd9P5DnTdg6QmsbHiloV1cwTjruZTMqglDjhSnqgIdnvOgnlc14O+CAu2yq7jRg=
=tM5A
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
