Received: from eggs.gnu.org ([2001:4830:134:3::10]:44550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chNPB-0000Ba-H5
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chNPA-0001uX-6C
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:27:57 -0500
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-3-git-send-email-armbru@redhat.com>
	<5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
	<878toxmeol.fsf@dusky.pond.sub.org> <877f4g2f6m.fsf@dusky.pond.sub.org>
	<c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com>
	<87h93j2ytj.fsf@dusky.pond.sub.org>
	<86ea8b80-f2ae-088f-ae2d-cf529d2db02b@redhat.com>
	<87r32nxrzm.fsf@dusky.pond.sub.org>
	<420c2df1-5bb9-29dc-ed0f-707e8985b4f3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7030cab7-202d-15bc-dcdc-2710c7ebb4eb@redhat.com>
Date: Fri, 24 Feb 2017 15:27:46 -0600
MIME-Version: 1.0
In-Reply-To: <420c2df1-5bb9-29dc-ed0f-707e8985b4f3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ruIdAf8JfnlA0E9mJi8PEF5vP7qTtiHts"
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ruIdAf8JfnlA0E9mJi8PEF5vP7qTtiHts
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <7030cab7-202d-15bc-dcdc-2710c7ebb4eb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
 <1487710908-26356-3-git-send-email-armbru@redhat.com>
 <5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
 <878toxmeol.fsf@dusky.pond.sub.org> <877f4g2f6m.fsf@dusky.pond.sub.org>
 <c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com>
 <87h93j2ytj.fsf@dusky.pond.sub.org>
 <86ea8b80-f2ae-088f-ae2d-cf529d2db02b@redhat.com>
 <87r32nxrzm.fsf@dusky.pond.sub.org>
 <420c2df1-5bb9-29dc-ed0f-707e8985b4f3@redhat.com>
In-Reply-To: <420c2df1-5bb9-29dc-ed0f-707e8985b4f3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 03:06 PM, Eric Blake wrote:

>=20
> Also for 2.9: turn on the deprecation warning for QemuOpts negative
> sugar, but leave positive sugar unchanged (it seems like positive sugar=

> is probably more in use than negative sugar, other than chardev nowait)=
=2E

Capturing the gist of an IRC conversation:

Right now, it appears that '-chardev nowait' is in heavy use ('git grep
nowait' shows that qemu itself recommends it in documentation, nodelay
being another one).  Right now, QemuOpts says that '-chardev
wait,nowait' results in 'wait=3Doff', and '-chardev nowait,wait' results
in 'wait=3Don' (that is, last-one-wins semantics) - but in reality, there=

are probably few (if any) clients that rely on this particular semantics.=


If we get rid of 'noFOO' magic, we can still teach the chardev QemuOpts
to recognize optional keys for BOTH 'wait' and 'nowait'; a user that
specifies neither gets the default behavior as always; a user that
specifies only 'wait' or 'nowait' gets the requested behavior (although
now chardev has to check both key spellings rather than one), and a user
that specifies 'wait,nowait' or 'nowait,wait' causes an error, not at
QemuOpts parse time, but in the chardev initialization code.  That is,
for any boolean option where 'noFOO' magic is currently handled by
QemuOpts, we can still mostly keep back-compat by adding a new 'noFOO'
key to the object, and teaching that object to check that 'FOO' and
'noFOO' are not both selected at once.

But whether this change to QemuOpts is the right thing to do is not 2.9
material, so let's take a breather and revisit it for 2.10 (or whenever
we try to fix QemuOpts to layer on top of keyval_parse()).


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ruIdAf8JfnlA0E9mJi8PEF5vP7qTtiHts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsKVSAAoJEKeha0olJ0NqxKUH/ijatu3Z2xX2npaxl9aQXMW3
0Fkac96jQAlL9e8x8dYIpmqOmt00tTRLQYmLswCAZSOUm4GuGDmNoJ+l3pXqQU5X
7REY8ehqojR4dJIxsNB5E8VFoHv3q3L5KOBR9ZxeYiCD4/tfX0dWRg4Dpd+5OxQm
QaM0NoDJmVkfZfTaH78WPtsjppNMcA7+cwMQMsjfGG33yrxwLgQAhw9Osqmt5lrX
HuKDeZGlVZuq9nVz1r3R9OwTJnUufahhkMOCYFusb1tljxysOdv2b1vlh/8CL84A
mArmECi5R5PZviv9WYAfYYoJDW1Mgt9E4Wi6SH4QQbawfFW9iaG/h9VZzvqYvOM=
=DTcd
-----END PGP SIGNATURE-----

--ruIdAf8JfnlA0E9mJi8PEF5vP7qTtiHts--
