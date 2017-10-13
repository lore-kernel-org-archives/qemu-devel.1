Received: from eggs.gnu.org ([2001:4830:134:3::10]:40119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e30v0-0004ED-Dw
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e30uz-0006k3-7G
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:26:30 -0400
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1506954812-6552-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51fuanjfop.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <515d6e61-2e1f-0661-e04a-526844deb9ce@redhat.com>
Date: Fri, 13 Oct 2017 09:26:17 -0500
MIME-Version: 1.0
In-Reply-To: <w51fuanjfop.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o08Fb2XqoCTrawKBm8H9ccBKNs0TbKj3Q"
Subject: Re: [Qemu-devel] [PATCH v13 2/6] qmp: Use ThrottleLimits structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o08Fb2XqoCTrawKBm8H9ccBKNs0TbKj3Q
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>,
 Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Manos Pitsidianakis <el13635@mail.ntua.gr>,
 jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu block <qemu-block@nongnu.org>
Message-ID: <515d6e61-2e1f-0661-e04a-526844deb9ce@redhat.com>
Subject: Re: [PATCH v13 2/6] qmp: Use ThrottleLimits structure
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1506954812-6552-3-git-send-email-pradeep.jagadeesh@huawei.com>
 <w51fuanjfop.fsf@maestria.local.igalia.com>
In-Reply-To: <w51fuanjfop.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding Markus, and block list]

On 10/13/2017 09:16 AM, Alberto Garcia wrote:
> On Mon 02 Oct 2017 04:33:28 PM CEST, Pradeep Jagadeesh wrote:
>> This patch factors out code to use the ThrottleLimits
>> structure.
>=20
>>  { 'struct': 'BlockIOThrottle',
>> -  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': '=
int',
>> -            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_w=
r': 'int',
>> -            '*bps_max': 'int', '*bps_rd_max': 'int',
>> -            '*bps_wr_max': 'int', '*iops_max': 'int',
>> -            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
>> -            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
>> -            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>> -            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int=
',
>> -            '*iops_size': 'int', '*group': 'str' } }
>> +  'base': 'ThrottleLimits',
>> +  'data': { '*device': 'str', '*id': 'str', '*group': 'str' } }
>=20
> So BlockIOThrottle used to have parameters named bps_rd and iops_wr, an=
d
> after this patch they become bps-read and iops-write. This breaks the
> API completely, as you can see if you run e.g. iotest 129:
>=20
> AssertionError: failed path traversal for "return" in "{u'error': {u'cl=
ass': u'GenericError', u'desc': u"Parameter 'iops_rd' is unexpected"}}"
>=20
> I just checked previous versions of the series and I see that Manos
> already warned you of this in v11:
>=20
>    https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04698.html

On the bright side, ThrottleLimits is marked 'since 2.11' (added in
commit 432d889e), meaning it has not yet been released, so we CAN fix
the naming in ThrottleLimits to be compatible with BlockIOThrottle if we
want to share the type, as long as we get it done before the 2.11
release.  It does mean tweaking Manos' code to use compatible names
everywhere, but that may be a wise course of action (we tend to favor
'-' in new API names unless there is a strong reason to use '_'; but
sharing code for maximum back-compat would be a reason to use '_').

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--o08Fb2XqoCTrawKBm8H9ccBKNs0TbKj3Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlngzQkACgkQp6FrSiUn
Q2oWUgf+L25qPnmYtPG1qShuwPNdaBKB8HeFW0Rj13kQx9E4q35NardIM7YWklpN
ygwKm70Gu6kO84DgYqQF/9i0A7LXBtflhRR0P+BWRgjLbSIuUGrex77KEidlh8Eu
K7WJFHSIbyjrVFcbB7MS+Ck+D2ecW5nV1MiFpLYyBS5/1aV4oYZwORczn1c4v5cK
bqSYwylOxmwoOJKwYxhGvRJ3KMwi6rYxEqMKXqgMZttSSNC/fqZZsgctKRN14b3t
qE/xK6Rsr/IPlL+tPKHI+TJfmE9SIfYM31ywb16mJqxMgD25HY6cAU+BjNVKHRuy
mwi99ohlkJBmbnRLUGYabvoPY8Kr6g==
=BlBJ
-----END PGP SIGNATURE-----

--o08Fb2XqoCTrawKBm8H9ccBKNs0TbKj3Q--
