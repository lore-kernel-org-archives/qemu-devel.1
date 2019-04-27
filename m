Received: from eggs.gnu.org ([209.51.188.92]:48635)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hKRhE-0000x3-AG
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1hKRhD-0003oo-91
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:05:08 -0400
References: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
	<20190427163007.5113-3-samuel.thibault@ens-lyon.org>
	<73079d95-cf99-e0e3-c464-4568622f0008@gmx.com>
	<20190427175708.76nq4w2mdexb4gkp@function>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <331bee21-743c-5eb8-9c6d-77a23b2dc607@gmx.com>
Date: Sat, 27 Apr 2019 20:05:32 +0200
MIME-Version: 1.0
In-Reply-To: <20190427175708.76nq4w2mdexb4gkp@function>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4f07vlMXqZ0yimzlM1zmTIzaDzdSDtzOb"
Subject: Re: [Qemu-devel] [PATCHv3 1/2] ui/curses: Do not assume wchar_t
 contains unicode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: kamil@netbsd.org, qemu-devel@nongnu.org, kraxel@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4f07vlMXqZ0yimzlM1zmTIzaDzdSDtzOb
From: Kamil Rytarowski <n54@gmx.com>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: kamil@netbsd.org, qemu-devel@nongnu.org, kraxel@redhat.com
Message-ID: <331bee21-743c-5eb8-9c6d-77a23b2dc607@gmx.com>
Subject: Re: [Qemu-devel] [PATCHv3 1/2] ui/curses: Do not assume wchar_t
 contains unicode
References: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
 <20190427163007.5113-3-samuel.thibault@ens-lyon.org>
 <73079d95-cf99-e0e3-c464-4568622f0008@gmx.com>
 <20190427175708.76nq4w2mdexb4gkp@function>
In-Reply-To: <20190427175708.76nq4w2mdexb4gkp@function>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2019 19:57, Samuel Thibault wrote:
> Kamil Rytarowski, le sam. 27 avril 2019 19:36:40 +0200, a ecrit:
>> On 27.04.2019 18:30, Samuel Thibault wrote:
>>> E.g. BSD and Solaris even use locale-specific encoding there.
>>>
>>> We thus have to go through the native multibyte representation and us=
e
>>> mbtowc/wctomb to make a proper conversion.
>>>
>>> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>>
>> Both patches work for me on NetBSD/amd64 8.99.37 for qemu-system-x86_6=
4.
>> Borders are printed correctly.
>>
>> Regarding the patch I'm not sure whether to use MB_LEN_MAX or MB_CUR_M=
AX?
>=20
> I don't know if qemu can afford VLA?
>=20

It's better to avoid VLA and pick MB_LEN_MAX.

>> I'm also unsure whether to reset conversion state between a multibyte
>> character and wide character, with: `mbtowc(NULL, 0, 0);`. It's
>> recommended to use in code examples examples. I think it doesn't make
>> any harm to use it.
>=20
> Mmm, better yet, we should actually use mbrtowc and wcrtomb. I have
> fixed this in my tree.
>=20

This is even better.

>> I'm not sure if this is related, but "qemu-system-hppa -curses" is
>> broken for me. I didn't use it in the past as it just recently acquire=
d
>> NetBSD guest support.
>>
>> (lldb) bt
>> libcurses.so.7`mvwadd_wchnstr(win=3D0x0000000000000000, y=3D<unavailab=
le>,
>> x=3D<unavailable>, wchstr=3D0x00007f7fffffe020, n=3D0) at add_wchstr.c=
:123
>>   * frame #2: 0x000000000078629e
>> qemu-system-hppa`curses_update(dcl=3D0x00007f7ff7bd8bc0, x=3D0, y=3D0,=
 w=3D79,
>> h=3D24) at curses.c:86:9
>>     frame #3: 0x0000000000753dae
>> qemu-system-hppa`dpy_text_update(con=3D0x00007f7ff7bae580, x=3D0, y=3D=
0, w=3D79,
>=20
>> (lldb) p screenpad
>> (WINDOW *) $2 =3D 0x0000000000000000
>=20
> I don't think this is related at all, screenpad management is another
> matter.
>=20

OK! I will treat it as an independent issue and try to address it.

> Samuel
>=20



--4f07vlMXqZ0yimzlM1zmTIzaDzdSDtzOb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlzEme0MHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs/T0P/2Lasgx+NsnT1qP86Bh2fydL9xkFBnln7CxoERe6
QGTSsZpeAXmHsnrLO8N3fGMSg5lZ2XirFPImikYRFLLbEx/coj84hj+NEGP0mk8q
PArk+lTNVDkHtkHgvMr5ieBfk0CcI6yChP1Z8qPBhbuZlBONOSw2/idOSKLaa/q2
OS8eFzKupFyHFKZG3JziSAJU9ShFR7w82ENj3MKV8+SOB8iimdGriKqmL+Z8dktu
Sa+7a54KpgW7ZCJQwFsYn+ClfuoTi1qcTTnL06LIwhIvTDIQPPYtvlzNdlA9F/PF
oPCRcptXKcEwL+1TxnhC7rDP1ageFWouHWJX58FpRmX2FUBNLScAS7cebbU8nb71
0yZPw9Why18uZq8wbUqHQrPy72Eo/8PBz+j+8OhBMmny1kZp3ouLAK3z/Z/G1LQX
O4KxigY291pNlz0RxVxHm2GnogbdrYkRriMRYwNt7PVgjkkcHEePiQjHXl5dmVBI
Flh7Z674cNHDd/dDuWXmQM9LN4CqN+SH1jYk8lc34qPcjMAoIF2sJCSgfnD4Drnz
6Pc/KCj4IXIMd0liLkcjw2IGHyZVpp4f4+6Z3ugnhKUYWjELs75fZCqVNCR073kV
SV/jMS2cuqmjEO8XIe6hwGtVrQcc0YgFDEDo04CzuekzSJPgpp5xUFZCZKbJ+UrW
T65r
=7iq5
-----END PGP SIGNATURE-----

--4f07vlMXqZ0yimzlM1zmTIzaDzdSDtzOb--
