Received: from eggs.gnu.org ([2001:4830:134:3::10]:49832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYbQm-0006k1-Qt
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYbQj-0004ZK-Md
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:37:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYbQj-0004Z2-DQ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:37:17 -0500
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<87zii75jze.fsf@dusky.pond.sub.org>
	<20170131172752-mutt-send-email-mst@kernel.org>
	<87o9yn2oy9.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7df08f03-9244-a246-ff89-fc0ffb69c736@redhat.com>
Date: Tue, 31 Jan 2017 10:37:12 -0600
MIME-Version: 1.0
In-Reply-To: <87o9yn2oy9.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FncrnsPpTesjhijtcXeCgSCAQ9dWQg2jk"
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FncrnsPpTesjhijtcXeCgSCAQ9dWQg2jk
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7df08f03-9244-a246-ff89-fc0ffb69c736@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
 <87zii75jze.fsf@dusky.pond.sub.org>
 <20170131172752-mutt-send-email-mst@kernel.org>
 <87o9yn2oy9.fsf@dusky.pond.sub.org>
In-Reply-To: <87o9yn2oy9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 10:07 AM, Markus Armbruster wrote:
>> I tried that first thing.
>> This generates lots of warnings if you have multiple users
>> within a function: gcc is unhappy about the redundant extern
>> declarations.
>=20
> #define QEMU_BUILD_BUG_ON(x) \
>     _Pragma("GCC diagnostic push") \
>     _Pragma("GCC diagnostic ignored \"-Wredundant-decls\"") \
>     extern char qemu_build_bug_on_[QEMU_BUILD_BUG_ON_ZERO((x))] __attri=
bute__((unused)); \
>     _Pragma("GCC diagnostic pop")

Do we know if pragma GCC diagnostic push is supported in our minimum
compiler requirements (gcc 4.1, and presumably clang just ignores the
pragma)?

>=20
> Drawback: natural use like
>=20
>     QEMU_BUILD_BUG_ON(x);
>=20
> expands into a declaration followed by an extra semicolon.

Can you emit a mid-declaration _Pragma, as in:

extern char ...[...] \
_Pragma("GCC diagnostic pop") \
__attribute__((__unused__));

Also, I guess this points out that we are inconsistent on whether we use
the __-decorated variants of all __attribute__ arguments; system headers
should always do it, since __unused__ is reserved to the implementation
but the user is free to #define unused and mess up the parse of the
header; but we aren't a system header and it obviously hasn't tripped us
up yet.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--FncrnsPpTesjhijtcXeCgSCAQ9dWQg2jk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkL04AAoJEKeha0olJ0NqN0AH/RoUtWoi/7OC5twuWilcpGJP
hMdtSVw4wKBgZ4rv1EMvkiw7rtTOBI8pn3wUYQB864kXDQ9rYOtVmBzqEELG88QI
uWA2x/cM44hl6+zW97xynf9LtDkkL0Ifgf9Je7enYWdnxWO6u1apcDGbsXGCvX+K
0mGAtYMJszRxZjKPIoGcW6NjyjMa/cSJzf3jkdMmHZV4y2Pgr6+Te6HkhSyLLsN/
D1L42HS7sYKWV1z5HZOmLy6FCfMuxHsAQTxmFwKwgdU/l4/zOFMJ/yv3hFSoF3xp
PBNy3qOn5OwGV4mzV7v1+l1T880yBMp0CDuwy0IW5y0SuV+E6sY+k361sohRlw4=
=oY2x
-----END PGP SIGNATURE-----

--FncrnsPpTesjhijtcXeCgSCAQ9dWQg2jk--
