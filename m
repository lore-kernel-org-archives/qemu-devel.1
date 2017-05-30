Received: from eggs.gnu.org ([2001:4830:134:3::10]:51886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFi2X-0006s3-DV
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFi2T-0005lm-7d
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:22:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFi2S-0005lS-US
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:22:25 -0400
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-8-marcandre.lureau@redhat.com>
	<87tw4mgr07.fsf@dusky.pond.sub.org>
	<CAJ+F1CKctXGjPOghFGXQTyTdT9Oaxn8w3x0N+L5vBp4m8U4XCA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ad923132-af5a-07e4-723c-df115b902538@redhat.com>
Date: Tue, 30 May 2017 09:22:22 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKctXGjPOghFGXQTyTdT9Oaxn8w3x0N+L5vBp4m8U4XCA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RwTXlRBVt9IPTwf9nN8XiTwgaXhWSaBqw"
Subject: Re: [Qemu-devel] [PATCH 07/17] json: learn to parse uint64 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RwTXlRBVt9IPTwf9nN8XiTwgaXhWSaBqw
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <ad923132-af5a-07e4-723c-df115b902538@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/17] json: learn to parse uint64 numbers
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
 <20170509173559.31598-8-marcandre.lureau@redhat.com>
 <87tw4mgr07.fsf@dusky.pond.sub.org>
 <CAJ+F1CKctXGjPOghFGXQTyTdT9Oaxn8w3x0N+L5vBp4m8U4XCA@mail.gmail.com>
In-Reply-To: <CAJ+F1CKctXGjPOghFGXQTyTdT9Oaxn8w3x0N+L5vBp4m8U4XCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 06:35 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, May 15, 2017 at 6:00 PM Markus Armbruster <armbru@redhat.com> w=
rote:
>=20
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>> Switch strtoll() usage to qemu_strtoi64() helper while at it.
>>>
>>> Replace temporarily the error in qnum_get_int() with values >INT64_MA=
X
>>> until the visitor is updated.
>>>
>>> Add a few tests for large numbers.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  qobject/json-lexer.c               |  4 ++++
>>>  qobject/json-parser.c              | 30 ++++++++++++++++++++++------=
--
>>>  qobject/qnum.c                     |  4 ++--
>>>  tests/check-qjson.c                | 28 ++++++++++++++++++++++++++++=

>>>  tests/check-qnum.c                 |  9 +++++----
>>>  tests/test-qobject-input-visitor.c |  7 ++-----
>>>  6 files changed, 63 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
>>> index af4a75e05b..a0beb0b106 100644
>>> --- a/qobject/json-lexer.c
>>> +++ b/qobject/json-lexer.c
>>> @@ -227,15 +227,18 @@ static const uint8_t json_lexer[][256] =3D  {
>>>      /* escape */
>>>      [IN_ESCAPE_LL] =3D {
>>>          ['d'] =3D JSON_ESCAPE,
>>> +        ['u'] =3D JSON_ESCAPE,

Do we really want to add MORE escape sequences to our pseudo-JSON escape
parser? I had a series a while back that was able to completely kill the
pseudo-JSON escapes, in favor of teaching the testsuite how to directly
handle %s (which is really the most useful of the escapes - we really
aren't using many others).

If there's interest in removing the JSON parser escape sequences, I can
revive my series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RwTXlRBVt9IPTwf9nN8XiTwgaXhWSaBqw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLYAeAAoJEKeha0olJ0NqYfsH/RqKPQ/LUFouOqa64iyUETgf
rusD63rLprJRepbzG5cRQbTczecqOBfzrKab7ssHSTktMRvz6FaUqGCWZBihRd8v
9Myspx5QlXBgKXa6Iu0hYpB8MYIpUxsO+EGbSro2Wywa7zMwCU6/Medfk7AvIXLh
1hnccaozR/KTMVXuhkZQUloomwwbhuP3vFmYbeX5XDJis7tj3SlYbR7Krt0X1XB1
5ebbxy7Xabv/T7Iyl0xcXGQYf/mxaTnGSuH5YGofNPCh9Jf5VDsoj3H2q5eWMIPp
6//0yHF89340O5xhXbWPCTz03b+eO7CJ0UPmUYA/eKA6mNBpFo7r0Di9BcopruI=
=GCpZ
-----END PGP SIGNATURE-----

--RwTXlRBVt9IPTwf9nN8XiTwgaXhWSaBqw--
