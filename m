Received: from eggs.gnu.org ([2001:4830:134:3::10]:52001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chNff-0007o2-Ut
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chNfc-0004mr-QJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:44:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chNfc-0004ld-Fu
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:44:56 -0500
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
	<9292fef8-929a-e89e-eca5-cd247ca9334b@redhat.com>
	<f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
	<c207e00d-25a6-45bb-a849-235d0cd2be0d@redhat.com>
	<2b0840d7-7540-d732-36ac-af7a512d2c8f@kamp.de>
	<b59eb68b-5dac-b18b-c2f7-1ea820f4d747@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <589533ff-2e7d-0ffb-e0b9-5b2e055813b6@redhat.com>
Date: Fri, 24 Feb 2017 15:44:53 -0600
MIME-Version: 1.0
In-Reply-To: <b59eb68b-5dac-b18b-c2f7-1ea820f4d747@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gTkRW3QoU7mURpwnl1MOxjrxpqlFioIqG"
Subject: Re: [Qemu-devel] Qemu and Changed Block Tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Christian Theune <ct@flyingcircus.io>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gTkRW3QoU7mURpwnl1MOxjrxpqlFioIqG
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Christian Theune <ct@flyingcircus.io>
Message-ID: <589533ff-2e7d-0ffb-e0b9-5b2e055813b6@redhat.com>
Subject: Re: [Qemu-devel] Qemu and Changed Block Tracking
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
 <9292fef8-929a-e89e-eca5-cd247ca9334b@redhat.com>
 <f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
 <c207e00d-25a6-45bb-a849-235d0cd2be0d@redhat.com>
 <2b0840d7-7540-d732-36ac-af7a512d2c8f@kamp.de>
 <b59eb68b-5dac-b18b-c2f7-1ea820f4d747@redhat.com>
In-Reply-To: <b59eb68b-5dac-b18b-c2f7-1ea820f4d747@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 03:31 PM, John Snow wrote:
>>
>> But the Backup Server could instead connect to the NAS directly avoidi=
ng
>> load on the frontent LAN
>> and the Qemu Node.
>>
>=20
> In a live backup I don't see how you will be removing QEMU from the dat=
a
> transfer loop. QEMU is the only process that knows what the correct vie=
w
> of the image is, and needs to facilitate.
>=20
> It's not safe to copy the blocks directly without QEMU's mediation.

Although we may already have enough tools in place to help achieve that:
create a temporary qcow2 wrapper around the primary image via external
snapshot, so that the primary image is now read-only in qemu; then use
whatever block-status mechanism (whether the NBD block status extension,
or directly reading from a persistent bitmap) to facilitate whatever
more efficient offline transfer of just the relevant portions of that
main file, then live block-commit to get qemu to start writing to the
file again.

In other words, any time your algorithm wants to cause an I/O freeze to
a particular file, the solution is to add a qcow2 external snapshot
followed by a live commit.

So tweaking the proposal a few mails ago:

fsfreeze (optional)
create qcow2 snapshot wrapper as a write lock (via QMP)
fsthaw - now with no risk of violating guest timing constraints
dirtymap =3D find all blocks that are dirty since last backup (via named
bitmap/NBD block status)
foreach block in dirtymap {
               copy to backup via external software
}
live commit image (via QMP)

The window where guest I/O is frozen is small (the freeze/snapshot
create/thaw steps can be done in less than a second), while the window
where you are extracting incremental backup data is longer (during that
time, guest I/O is happening into a wrapper qcow2 file).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gTkRW3QoU7mURpwnl1MOxjrxpqlFioIqG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsKlVAAoJEKeha0olJ0NqO9cH/iMJDziVEhvCprSjSGshYiKt
+D3aOspUqqlIFUcnt9VCAavx0rSIrVHOKqSw1eXtQMnLwbYrRuQqpoz0Gea0aJ45
ObPL+Ok8VEaZxhrZxGqlKEPkN2A5C3ugH8zoEOQWq+Z9PuOdTg9VUvjvPgNZEaqA
J6zu+lbL6caGY319++oiy3JqxuSAUAo6P/0+k3j4EB9QI6YE7gJLqI424IF54yl5
z/+FEHK7RUlnfvV3y2ZbWahJFbW/cwFlW+bEtChpTHYfLe9tGRzLPJxTfunwSvNh
mZJeABDRoTKAnbezFkPIFil95711mjYBRHMP4GB881+u5ZrukW0QfJFRnLJOu78=
=8Vyt
-----END PGP SIGNATURE-----

--gTkRW3QoU7mURpwnl1MOxjrxpqlFioIqG--
