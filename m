Received: from eggs.gnu.org ([2001:4830:134:3::10]:35265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctlzH-0007t0-EX
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 22:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctlzE-00042a-9w
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 22:08:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ctlzE-000410-0j
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 22:08:24 -0400
References: <058D52979F67BF47BCD9EA78EAECA6DC7779F2D5@SESTOEX04.enea.se>
	<de0d3d40-833b-f24b-7689-b23eb9c78244@redhat.com>
	<058D52979F67BF47BCD9EA78EAECA6DC7779F35F@SESTOEX04.enea.se>
	<153e27df-ed6d-f562-9831-9790b584beb1@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd465426-e057-a68b-de02-1c244132ecc8@redhat.com>
Date: Thu, 30 Mar 2017 21:08:20 -0500
MIME-Version: 1.0
In-Reply-To: <153e27df-ed6d-f562-9831-9790b584beb1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k2iR0sb5gaAdABl35pK6U7pHQw6tTtnia"
Subject: Re: [Qemu-devel] rbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandru Avadanii <Alexandru.Avadanii@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k2iR0sb5gaAdABl35pK6U7pHQw6tTtnia
From: Eric Blake <eblake@redhat.com>
To: Alexandru Avadanii <Alexandru.Avadanii@enea.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 svc-armband <armband@enea.com>
Message-ID: <fd465426-e057-a68b-de02-1c244132ecc8@redhat.com>
Subject: Re: [Qemu-devel] rbd: Possible regression in 2.9 RCs
References: <058D52979F67BF47BCD9EA78EAECA6DC7779F2D5@SESTOEX04.enea.se>
 <de0d3d40-833b-f24b-7689-b23eb9c78244@redhat.com>
 <058D52979F67BF47BCD9EA78EAECA6DC7779F35F@SESTOEX04.enea.se>
 <153e27df-ed6d-f562-9831-9790b584beb1@redhat.com>
In-Reply-To: <153e27df-ed6d-f562-9831-9790b584beb1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 08:22 PM, Eric Blake wrote:
> On 03/30/2017 08:05 PM, Alexandru Avadanii wrote:
>> c7cacb3e7a2e9fdf929c993b98268e4179147cbb is the first bad commit
>>     block/rbd: parse all options via bdrv_parse_filename
>=20
> Yep, my bisect finished about 2 minutes after your email on the same
> spot. I'm working on a patch.  I can reproduce the problem with a mere:=

>=20
> ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio
> -drive
> 'file=3Drbd:volumes/volume-ea141b5c-cdb3-4765-910d-e7008b209a70:id=3Dco=
mpute:key=3DAQAVkvxXAAAAABAA9ZxWFYdRmV+DSwKr7BKKXg=3D=3D:auth_supported=3D=
cephx\;none:mon_host=3D192.168.1.2\:6789,format=3Draw,if=3Dnone,id=3Ddriv=
e-virtio-disk0,serial=3Dea141b5c-cdb3-4765-910d-e7008b209a70,cache=3Dwrit=
eback'
>=20
> the good behavior (on my setup) just hangs trying to connect to a
> non-existent machine, the bad behavior gets rather-badly misparsed
> (splitting the escaped : in the host:port portion as if the port were
> the next key-value pair) resulting in an instant error message. I don't=

> have an actual RBD setup for testing the fix, but will cc you on the
> patch that I propose once I have something.

I found the culprit, but the patch is taking me longer.

We are unescaping key=3D"mon_host", value=3D"192.168.1.2\:6789" when we
first parse the key/value pairs in qemu_rbd_parse_filename(), then we
slam the unescaped values back into a single string with ':' separators
resulting in "mon_host=3D192.168.1.2:6789" for stuffing through the QDict=
,
then we pass that string BACK through qemu_rbd_next_tok() inside
qemu_rbd_set_keypairs(), and since we no longer have the \: escape, we
are trying to treat 6789 as a new key on the second pass.  Moral of the
story: don't parse stuff twice.

My patch will be to use a QList instead of a QString for the hidden
"=3Dkeyvalue-pairs" object that we use to pass things around between
parsing the filename and actually passing parameters to RBD, matching
the fact that we already have this telling comment:

            /* FIXME: This is pretty ugly, and not the right way to do th=
is.
             *        These should be contained in a structure, and then
             *        passed explicitly as individual key/value pairs to
             *        rados.  Consider this legacy code that needs to be
             *        updated. */

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--k2iR0sb5gaAdABl35pK6U7pHQw6tTtnia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3boUAAoJEKeha0olJ0NqDjMH+wdpgsbYeMP1huogWx3Crsmi
ZYUpH80ktLoGFW8iCiQUC9Iv/0/ctPIOQZiZqZEb+crKZCEoQyykPj7jGDKWZNrm
EM+5skEoAWu0O3s2EtzWHGCBWyNTUJ8DqO33sBjggPfLLrBTAW11NdZdlJmp8yI6
9m/p8VI12rQrzUEYoSddQxBs43WQJXPIUSTK6IPjhmeqdEUBOmwIf+XcHdR22FNl
yIaCNg7lUxUcQ2QV/0RiCW6x0vcPGpV7+mv1D5KinG/EZzW97ovQH3xMzpeeB/c8
5qCQWwqRX38ptMuA92BbFgLCBHSiPzQ4Gol5VuKGH1fuNQiePl+zkBOLBevMJWI=
=sfvP
-----END PGP SIGNATURE-----

--k2iR0sb5gaAdABl35pK6U7pHQw6tTtnia--
