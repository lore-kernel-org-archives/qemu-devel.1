Received: from eggs.gnu.org ([2001:4830:134:3::10]:38797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvP4p-0001GO-L2
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvP4m-0001fV-Gh
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvP4m-0001f9-7i
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:04:52 -0400
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<20170403130041.GD5036@noname.str.redhat.com>
	<20170403135012.GY26598@andariel.pipo.sk>
	<20170404121624.GA4536@noname.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d270f1a4-5814-9b23-61f6-745c73ecaadd@redhat.com>
Date: Tue, 4 Apr 2017 16:04:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170404121624.GA4536@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l8ghXe2AjVMwK8c0QFS13a6FaA12qOSLh"
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Cc: svc-armband <armband@enea.com>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l8ghXe2AjVMwK8c0QFS13a6FaA12qOSLh
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Cc: svc-armband <armband@enea.com>, Markus Armbruster <armbru@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 Alexandru Avadanii <Alexandru.Avadanii@enea.com>
Message-ID: <d270f1a4-5814-9b23-61f6-745c73ecaadd@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
 <9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
 <20170403081542.GA5036@noname.str.redhat.com>
 <33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
 <20170403130041.GD5036@noname.str.redhat.com>
 <20170403135012.GY26598@andariel.pipo.sk>
 <20170404121624.GA4536@noname.str.redhat.com>
In-Reply-To: <20170404121624.GA4536@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 04/04/2017 14:16, Kevin Wolf wrote:
> Just not requesting the
> write permission initially if runstate_check(RUN_STATE_INMIGRATE) is
> easy. But we need to find a place to actually request it later, after
> the mirror has completed, and before the VM is running.

Isn't there already a bdrv_invalidate_cache_all or something like that
called when the VM is started?

Having to touch all devices would be ugly.  Maybe some permissions could
be marked as "deferred".

The big question is how this fits into release management.  We have
another important regression from the op blocker work and only a week to
go before the last rc.  Are we going to delay 2.9 arbitrarily?  Are we
going to shorten the 2.10 development period correspondingly?  (I vote
yes and yes, FWIW).

Paolo

> My first thought was that we could add a VMChangeStateHandler and just
> request the permission in there. However, requesting the permission can=

> fail (e.g. because the NBD server hasn't been shut down) and we can't
> let a state transition fail from a VMChangeStateHandler.
>=20
> Maybe the next best thing we could do is to have a BlockDevOps callback=

> for invalidate_cache/inactivate and get the permissions there. This one=

> could return an error, which would be passed up the stack and eventuall=
y
> cause qmp_cont() to fail (i.e. it would refuse to resume the VM). This
> sounds workable to me.


--l8ghXe2AjVMwK8c0QFS13a6FaA12qOSLh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY46f6AAoJEL/70l94x66DIEoH/A9/bX1dmv5FWLZa8bf9etC+
OyEO5cHjjjPB5DRz9Mkoi5Mg4hUi51z1Nt1Ny6hhi8U+F3wnVSP6CzOmoGDF77Dm
5M8/ArXuBvlT9e1RQDk77RvaH4p9+mp/xMSBC9cfx24NwpkshQEzs7k/DlqfzShw
lpZgNSm/+KvZEJEkFhetLf3bv7dRjThNepKfjlTEQ+KX4eiwCZ4r24B0HdeVXtd2
daK5wiuVDwDGWhk9brYRTfaeuiel1Me7rzzAsMtktNDOrimVR2UfHInE/e0a4ggr
2R8YaOOF/zyXBm1XuNskttnIwkI18/8e+4ubgpN8f6rwGYCObiTcjRRxKSMegm8=
=kFCs
-----END PGP SIGNATURE-----

--l8ghXe2AjVMwK8c0QFS13a6FaA12qOSLh--
