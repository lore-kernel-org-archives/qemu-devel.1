Received: from eggs.gnu.org ([2001:4830:134:3::10]:58647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cmnS3-0003tP-DI
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 15:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cmnRz-00033m-Er
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 15:17:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cmnRz-00032y-6O
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 15:17:15 -0500
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-5-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84148275-6410-68f7-4da0-345b635c42f3@redhat.com>
Date: Sat, 11 Mar 2017 14:17:11 -0600
MIME-Version: 1.0
In-Reply-To: <20170311132256.22951-5-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="deKoMK2D3XaPuC66EoAjIW2WdBp5APBaS"
Subject: Re: [Qemu-devel] [PATCH 04/21] qobject: add quint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.comMarkus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--deKoMK2D3XaPuC66EoAjIW2WdBp5APBaS
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, anderson@redhat.com,
 pbonzini@redhat.com, lersek@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <84148275-6410-68f7-4da0-345b635c42f3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/21] qobject: add quint type
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
 <20170311132256.22951-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/11/2017 07:22 AM, Marc-Andr=C3=A9 Lureau wrote:
> The type is not used at all yet. Add some tests to exercice it.

s/exercice/exercise/

I wonder if we need this patch at all.

I've been thinking about a possible alternative representation, such
that a single QInt type can cover _both_ signed and unsigned types, by
having QInt track a sign bit bool in addition to a uint64_t value.

If the user passes in a value in the range [0, INT64_MAX], the number is
representable in both uint64_t and int64_t. So the internal sign bit
would be omitted, as in { value=3Dv, sign=3Dfalse }.  Input visitors can
visit this value with both the 'uint64' and the 'int64' visitors, and
output visitors will output the same value.

If the user passes in a value in the range [-INT64_MAX-1, -1], the
number is intended to be used as a negative signed number.  So the QInt
representation would be the 2s complement representation, { value=3D-v,
sign=3Dtrue }.  On input, the uint64_t visitor would reject the value as
out of range, the int64_t visitor would return the appropriate negative
value, and the generic int visitor will return the uint64_t value.  On
output, the number would be given the negative signed value
representation in anything that stringizes the value.

If the user passes in a value in the range [INT64_MAX+1, UINT64_MAX},
the number is intended to be used as a large unsigned number. So the
QInt representation would be { value=3Dv, sign=3Dfalse }.  On input, the
uint64_t visitor would accept the value, the int64_t visitor would
reject it as out of range, and the generic int visitor will return the
uint64_t value.  On output, the number would be given the positive
unsigned value representation in the stringized form.

That way, you don't have to complicate the (already-awkward) type
promotion rules of QFloat vs QInt with yet another scalar type.  The
input parser becomes friendlier - you can either use generic 'int' when
you want to allow the user to pass in either signed or unsigned values
(important for back-compat, where callers like libvirt learned that only
signed values worked even when large unsigned values were wanted); or
the specific 'int64' and 'uint64' types to force proper ranges.

It's definitely an alternative implementation to the one you pursued in
your series, so maybe we should first figure out WHAT we want
represented, before implementing something that will be more baggage
than we want (you at least have the advantage of patches that are
written; my idea of adding a sign bool to QInt is still just in the
initial idea stage).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--deKoMK2D3XaPuC66EoAjIW2WdBp5APBaS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxFtHAAoJEKeha0olJ0NqSqoH/iiYyyg9ELhPaaceHAnI8TcB
/FN7DI8SutyGWPFT1IjFU5ffa54saUCpjxYjpAzCdCnWFljOMws2tPCbiwKYNYSb
enJdqYffVUtnxXxycv8cprDJ/k7l/PTSFnOHdX5ILlzFoCkhbTpHxr9QOd26Flri
zNaBkyS6N1b9ieFAp6J/N5No5slvuTtGPnK7o5zJgcXDlxzMhL/3ifHqdZ3fO6Ni
xOoWL9k36qrAAxOMjBO15C52b1c24o3Dd3ny+H3IzOv0HZiAkDgfQHEIIIH0o4fu
yFTio3ANZ9bHTQlod0GLfiX2dhqJFsTCpx9pz0v18MYG/md3qCRWjNfwUGbwFz4=
=AXiz
-----END PGP SIGNATURE-----

--deKoMK2D3XaPuC66EoAjIW2WdBp5APBaS--
