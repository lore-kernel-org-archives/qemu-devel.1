Received: from eggs.gnu.org ([2001:4830:134:3::10]:60605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZbtG-0006X5-CN
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZbtD-00056G-7L
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:51:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dZbtC-00055S-Tu
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:51:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B89BDC0587DD
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:51:03 +0000 (UTC)
References: <20170721210707.21805-1-eblake@redhat.com>
	<87bmoatd8y.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3fb01b83-f5fb-c839-9a4d-44eefb0f8942@redhat.com>
Date: Mon, 24 Jul 2017 06:51:00 -0500
MIME-Version: 1.0
In-Reply-To: <87bmoatd8y.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o60VDbgAuwhSSubkrLi5kodwHIvRQ0SRS"
Subject: Re: [Qemu-devel] [PATCH] qobject: Accept "%"PRId64 in
 qobject_from_jsonf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o60VDbgAuwhSSubkrLi5kodwHIvRQ0SRS
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <3fb01b83-f5fb-c839-9a4d-44eefb0f8942@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qobject: Accept "%"PRId64 in
 qobject_from_jsonf()
References: <20170721210707.21805-1-eblake@redhat.com>
 <87bmoatd8y.fsf@dusky.pond.sub.org>
In-Reply-To: <87bmoatd8y.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 04:06 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Commit 1792d7d0 was written because PRId64 expands to non-portable
>> crap for some libc, and we had testsuite failures on Mac OS as a
>> result.  This in turn makes it difficult to rely on the obvious
>> conversions of 64-bit values into JSON, requiring things such as
>> casting int64_t to long long so we can use a reliable %lld and
>> still keep -Wformat happy.  So now it's time to fix that.
>>

>> +case $(strings $TMPE | grep ^UnLiKeLyToClAsH) in
>> +    '' | *"$nl"* ) error_exit "can't determine value of PRId64" ;;
>> +    *_ld | *_lld | *_I64d | *_qd) ;;
>> +    *) error_exit "unexepected value of PRId64, please add %$(strings=
 $TMPE |
>> +       sed -n s/^UnLiKeLyToClAsH_//p) support to json-lexer.c" ;;
>> +esac
>> +
>=20
> Why is this easier or more robust than examining output of the
> preprocessor?  Hmm, you explain it in the commit message.  I think you
> should also (briefly!) explain it in the "Sadly" comment.

Okay.  (Something along the lines of: We can't guarantee if the
preprocessor will produce "ld" or "l" "d", nor even if the expansion
will occur on the same line as any marker)

I also wonder if I should anchor some \n in the magic bytes being
searched for in the binary, so that if 'strings' fails (which may indeed
be the case for a mingw binary), then falling back to raw grep may also
have a chance.  But first, I'm hoping to get some patchew feedback first
if one of the build platforms has problems with the current attempt.


>> +++ b/qobject/json-lexer.c
>> @@ -31,7 +31,7 @@
>>   *
>>   * Extension for vararg handling in JSON construction:
>>   *
>> - * %((l|ll|I64)?d|[ipsf])
>> + * %(PRI[du]64|(l|ll)?[ud]|[ipsf])
>=20
> Confusing.  The lexer accepts more than that, but parse_escape() filter=
s
> it out.  Need a comment explaining what, because the latter isn't
> locally obvious.

True - we lex all known forms, and then only parse the current
platform's form.  Will improve the comment.


>>      } else if (!strcmp(token->str, "%ld")) {
>>          return QOBJECT(qnum_from_int(va_arg(*ap, long)));
>> -    } else if (!strcmp(token->str, "%lld") ||
>> -               !strcmp(token->str, "%I64d")) {
>> +    } else if (!strcmp(token->str, "%" PRId64)) {
>> +        return QOBJECT(qnum_from_int(va_arg(*ap, int64_t)));
>> +    } else if (!strcmp(token->str, "%lld")) {
>>          return QOBJECT(qnum_from_int(va_arg(*ap, long long)));
>=20
> Let's do "ll" before PRId64.

Sure.


>> +++ b/tests/check-qjson.c
>> @@ -990,8 +990,10 @@ static void vararg_number(void)
>>      QNum *qnum;
>>      int value =3D 0x2342;
>>      long long value_ll =3D 0x2342342343LL;
>> +    uint64_t value_u =3D UINT64_C(0x2342342343);
>=20
> Is UINT64_C() really necessary here?

Not as long as none of the compilers we use complains about uint64_t x =3D=

1ULL.  I'll simplify, then we can uglify if a compiler complains.

>=20
> Call the variable value_u64?

Yes.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--o60VDbgAuwhSSubkrLi5kodwHIvRQ0SRS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll13yUACgkQp6FrSiUn
Q2oGXAf/THG5TuMhnRDGtNYy/PJ9w//sD2RyTSPrYlY/aCxuxAD/CRTGN/58eceh
qyMCxHJECNfeF5zuMDGVwNmteCwrjsL2jMbz4e8HiG+x5Dk/KmCE7ijrAKjZjHga
jjy57rdGnMVnJdsgKjwhBdq02kk6GaJwKhvcMBgtRxuYRZa89R0+i11inMXyEo2b
6LxDoHutvwlE0vSdDKWd6zZD+r4uTIkJCrOBcSVxxxNGaJatzJnhRwS0X1Mi8LKj
V0//k1ZkMaqJ0gjdW95cTg77Ul3wgLdZw1oIyaVILKTSeGwlnbj9j8DJl/z84GmX
bH3Y/9gNDcsEXHBwbg7qtgfNLQUDCw==
=Dy9D
-----END PGP SIGNATURE-----

--o60VDbgAuwhSSubkrLi5kodwHIvRQ0SRS--
