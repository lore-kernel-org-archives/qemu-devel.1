Received: from eggs.gnu.org ([2001:4830:134:3::10]:60549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZJY1-0004qF-Cg
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZJXw-0008Ew-N4
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:48:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZJXw-0008Ea-D6
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:48:12 -0500
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<87r2qxk7o6.fsf@rpws.prws.suse.cz>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb7ae03d-1249-e772-e7e9-99b777054bb3@redhat.com>
Date: Wed, 10 Jan 2018 10:48:08 -0600
MIME-Version: 1.0
In-Reply-To: <87r2qxk7o6.fsf@rpws.prws.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="me4x2ID5TKVhPKB4Z6wB7kefjwo92JfHM"
Subject: Re: [Qemu-devel] [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rpalethorpe@suse.de
Cc: Richard Palethorpe <richiejp@f-m.fm>, qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, quintela@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--me4x2ID5TKVhPKB4Z6wB7kefjwo92JfHM
From: Eric Blake <eblake@redhat.com>
To: rpalethorpe@suse.de
Cc: Richard Palethorpe <richiejp@f-m.fm>, qemu-devel@nongnu.org,
 armbru@redhat.com, dgilbert@redhat.com, quintela@redhat.com
Message-ID: <cb7ae03d-1249-e772-e7e9-99b777054bb3@redhat.com>
Subject: Re: [PATCH 1/2] Add save-snapshot, load-snapshot and delete-snapshot
 to QAPI
References: <20180107122336.29333-1-richiejp@f-m.fm>
 <fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
 <87r2qxk7o6.fsf@rpws.prws.suse.cz>
In-Reply-To: <87r2qxk7o6.fsf@rpws.prws.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 10:19 AM, Richard Palethorpe wrote:
> Hello Eric & Peter,
>=20
> Eric Blake writes:
>=20
>> On 01/07/2018 06:23 AM, Richard Palethorpe wrote:
>>> Add QAPI wrapper functions for the existing snapshot functionality. T=
hese
>>> functions behave the same way as the HMP savevm, loadvm and delvm
>>> commands. This will allow applications, such as OpenQA, to programmat=
ically
>>> revert the VM to a previous state with no dependence on HMP or qemu-i=
mg.
>>
>> That's already possible; libvirt uses QMP's human-monitor-command to
>> access these HMP commands programmatically.
>=20
> That is what we are currently doing and is an improvement over
> programatically using HMP, but I wanted to improve upon
> that. Occasionally saving or loading snapshots fails and it is not clea=
r
> why.

Straightforward mapping of the existing HMP commands into QMP without
any thought about the design won't make the errors any clearer. My
argument is that any QMP design for managing internal snapshots must be
well-designed, but that since we discourage internal snapshots, no one
has been actively working on that design.

>=20
>>
>> We've had discussions in the past about what it would take to have
>> specific QMP commands for these operations; the biggest problem is tha=
t
>> these commands promote the use of internal snapshots, and there are
>> enough performance and other issues with internal snapshots that we ar=
e
>> not yet ready to commit to a long-term interface for making their use
>> easier.  At this point, our recommendation is to prefer external
>> snapshots.
>=20
> I don't think there are any issues with using external snapshots for th=
e
> use case I have in mind, so long as they can contain the CPU & RAM
> state. All that is really required is a good clean way of reverting to =
a
> previous state (where the VM is running). I don't see in the
> documentation or code that blockdev-snapshot-* or any other command can=

> save the CPU & RAM state to a file then load it along with a storage
> snapshot?

The trick is to time a blockdev external snapshot with a
migration-to-file as your point-in-time live snapshot, then rollback
means reverting back to the right disk state before starting via
incoming migration from that saved CPU state.

Libvirt has managed to combine blockdev-snapshot (external snapshots)
plus migration to file in order to properly save CPU + RAM state to a
combination of files (admittedly, it is more files to manage than what
you get with a single internal snapshot that captures CPU + RAM + disk
state all into a single qcow2 image, but the building blocks allow more
flexibility).  What libvirt has not done well (yet) is the ability to
roll back to a particular live snapshot, and has ended up documenting
hacks that a user has to manually massage their domain XML to point back
to the correct disk image when restoring state from a given CPU state.
But again, all the pieces are there, and it's more a matter of just
wiring them up correctly.

>=20
> Perhaps instead we could use migrate with exec or fd URIs as Peter
> suggests. So we could do a differential migration to a file, then
> continue until the guest enters a bad state, then do an incoming
> migration to go back to the file.
>=20
> I don't think that is ideal however, especially from a useability point=

> of view. Probably many users approaching the problem will just choose t=
o
> use loadvm/savevm.

As long as a management app hides the complexity, external disk
snapshots coupled with external CPU state saved by migration-to-file is
just as featured as internal snapshots.  Yes, it's not as convenient at
the low level as loadvm/savevm using internal snapshots, but it is more
powerful, better tested, and less error prone.


>=20
> Savevm and loadvm are actually very easy to use in our particular use
> case. However using a transaction comprised of lower-level commands
> should not be too difficult either. Although for the common case it
> might be a good idea to have a simpler command which wraps the
> transaction. Whether it defaults to an internal location or requires an=

> external file path is not a problem for me at least. The issue seems to=

> be just adding a QMP command to take a snapshot of the CPU state,

That exists, in the form of 'migrate'.

> similar to the blockdev-snapshot commands, and allowing it to be part o=
f
> a transaction.

Having 'migrate' be part of a block transaction is not implemented, but
given that libvirt has already figured out how to time the combination
of the two commands (block snapshots + migration to file) to get a
consistent snapshot, I'm not sure that there is any urgent need to
improve 'migrate' to work inside 'transaction'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--me4x2ID5TKVhPKB4Z6wB7kefjwo92JfHM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpWQ8gACgkQp6FrSiUn
Q2qT5AgAhDH1G61kbP2koqLUxQBhAlph/oZZ1/X0TCie3B4L+oqt1sPZSIvKUf3d
emAu3dE0XZr9/3RD+k6WkejImywMRzjkSHhaQbnnLiIdJe1Kokcrsp0QH8eyGRrv
3j0ru4hpyZ3up0UMPwL13BM3BDAE2JngEtyy4cSg+entvcfHuPsDARwkCqGVu7wz
h0YhXsEa3iggAarPOd2A/k9lyhulsDd+3LMFYwbEMtYxOG9PO8ALS9h0IiFDEDQk
tsUuifRGXn3G19YRY13ds2M5X68h9mE1w8eOp+2d3l1HYBSan8idblh6xxQEygNt
S25O+73vThMasdiVO6Da3IhN4cIlgA==
=zReB
-----END PGP SIGNATURE-----

--me4x2ID5TKVhPKB4Z6wB7kefjwo92JfHM--
