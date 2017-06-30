Received: from eggs.gnu.org ([2001:4830:134:3::10]:55807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQkWQ-0007cx-Qd
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQkWP-0005Y9-MP
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:14:58 -0400
References: <20170606162652.112122-1-vsementsov@virtuozzo.com>
	<20170606162652.112122-2-vsementsov@virtuozzo.com>
	<50f19b1d-9736-b8b3-5616-67c3393336f3@redhat.com>
	<8eb8d7bc-deba-f3cf-dc6f-a455eda81a44@redhat.com>
	<6e4fe097-c125-9f0b-1716-e12173f73e67@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea5ac81f-14f5-62fb-d91d-60e729939d3a@redhat.com>
Date: Thu, 29 Jun 2017 20:14:46 -0500
MIME-Version: 1.0
In-Reply-To: <6e4fe097-c125-9f0b-1716-e12173f73e67@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="67wPI6lnQPWH01EBoVSO903eNXBvWvK2U"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/3] block: add
 bdrv_get_format_alloc_stat format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--67wPI6lnQPWH01EBoVSO903eNXBvWvK2U
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Message-ID: <ea5ac81f-14f5-62fb-d91d-60e729939d3a@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 1/3] block: add bdrv_get_format_alloc_stat
 format interface
References: <20170606162652.112122-1-vsementsov@virtuozzo.com>
 <20170606162652.112122-2-vsementsov@virtuozzo.com>
 <50f19b1d-9736-b8b3-5616-67c3393336f3@redhat.com>
 <8eb8d7bc-deba-f3cf-dc6f-a455eda81a44@redhat.com>
 <6e4fe097-c125-9f0b-1716-e12173f73e67@redhat.com>
In-Reply-To: <6e4fe097-c125-9f0b-1716-e12173f73e67@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 07:54 PM, John Snow wrote:


>> Not necessarily an error, if it corresponds to a section that the gues=
t
>> has done a TRIM operation on, but where we did not have the means to
>> punch a hole in the protocol layer.  The semantics of guest TRIM is th=
at
>> the data can no longer be reliably read, making it weaker (and thus
>> easier to implement) than explicitly writing things to zero (although
>> writing zeroes can often be sped up by trimming, when you have
>> guarantees on what will be read later).
>>
>=20
> But the data is considered "used" -- if it cannot be reliably read but
> the format driver expects to be able to read it, is this not inherently=

> a category that signifies a semantic error?

It's a semantic error if the region belongs to the metadata portion of
the format driver, but not necessarily a problem if it belongs to the
guest-visible contents.  You're right that a guest probably shouldn't
read from areas that it trimmed, but since it is possible to do that on
bare metal block devices, it is reasonable that a format driver can
emulate what happens when a guest reads from trimmed (but
unknown-content) clusters.  You're also right that qcow2 probably can't
get into this situation (qcow2 v3 files always turned guest-trimmed
clusters into read-as-zero; and qcow2 v2 files discard the cluster
treating it as unused rather than used, thereby deferring to the backing
image).

It also corresponds somewhat to the behavior you get when putting a
qcow2 format on top of a block device (creating qcow2 as a POSIX file
gives you some nice assurances from the filesystem that clusters you
haven't touched read as zero; but not so with a brand-new qcow2 file on
a block device, where reads can be random until the first write)

> Data that is considered "Discarded" by the protocol (we succeeded in
> passing on the TRIM request from the guest through to the protocol)
> should almost certainly no longer be considered "used" by the format...=
?

The qcow2 format doesn't have a way to specifically represent a cluster
as discarded in this manner, but other protocols might.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--67wPI6lnQPWH01EBoVSO903eNXBvWvK2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVaYGAAoJEKeha0olJ0NqGogH/RcFiZaplu1vBwq6LET8XavB
3cU9uvDqDFe4KwBwoq3axJJ78V+g99NwEQs8TwIxdtEfjj+YD9y2ClgzgeqmZqDh
KMT+5LFIuhz37GKpv3vgc+RGlx0rkfpGuhSYUXeHxw5Df2C41Mpr8S2q0dF/Jap0
Jg7OAdtWZzb23OsfgrUleA4fJ4E24BEZ+34fI7z21FUm/ICFUfF0ND3Snvsg9pJX
65vz1hRNmBJs51GmD9riYfnEylUyTkEqphgoCWIUvUz4KZc1fOevB/vZttYptXaL
Bf1dU7Qwq+oIvLqkv6T4UI7gjf4Wg9zj5rdLr/wZD525KFtpXJZQEaub4qxvpn4=
=eZVa
-----END PGP SIGNATURE-----

--67wPI6lnQPWH01EBoVSO903eNXBvWvK2U--
