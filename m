Received: from eggs.gnu.org ([2001:4830:134:3::10]:43292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYICx-0006ep-Ez
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYICt-0002G8-GL
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYICt-0002Fy-6U
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:37:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3CF47AE98
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 20:37:57 +0000 (UTC)
References: <20170714190827.4083-1-eblake@redhat.com>
	<20170714190827.4083-6-eblake@redhat.com>
	<87zibzl8py.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff471aeb-51dc-1abd-f512-f1a93db3752c@redhat.com>
Date: Thu, 20 Jul 2017 15:37:56 -0500
MIME-Version: 1.0
In-Reply-To: <87zibzl8py.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PwGxdp943fMP3VgHi2WAaxOSX5aIhK9mw"
Subject: Re: [Qemu-devel] [PATCH 5/5] qtest: Document calling conventions
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
--PwGxdp943fMP3VgHi2WAaxOSX5aIhK9mw
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <ff471aeb-51dc-1abd-f512-f1a93db3752c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] qtest: Document calling conventions
References: <20170714190827.4083-1-eblake@redhat.com>
 <20170714190827.4083-6-eblake@redhat.com> <87zibzl8py.fsf@dusky.pond.sub.org>
In-Reply-To: <87zibzl8py.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 05:10 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> We have two flavors of vararg usage in qtest; make it clear that
>> qmp() has different semantics than hmp(), and let the compiler
>> enforce that hmp() is used correctly. Since qmp() only accepts
>> a subset of printf flags (namely, those that our JSON parser
>> understands), I figured that it is probably not worth adding a
>> format attribute to qmp() at this time.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  tests/libqtest.h | 23 ++++++++++++++---------
>>  1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/tests/libqtest.h b/tests/libqtest.h
>> index 38bc1e9..762ed13 100644
>> --- a/tests/libqtest.h
>> +++ b/tests/libqtest.h
>> @@ -50,7 +50,8 @@ void qtest_quit(QTestState *s);
>>  /**
>>   * qtest_qmp_discard_response:
>>   * @s: #QTestState instance to operate on.
>> - * @fmt...: QMP message to send to qemu
>> + * @fmt...: QMP message to send to qemu; only recognizes formats
>> + * understood by json-lexer.c
>>   *
>>   * Sends a QMP message to QEMU and consumes the response.
>>   */
>=20
> These formats are chosen so that gcc can help us check them.  Please ad=
d
> GCC_FMT_ATTR().  Precedence: qobject_from_jsonf().

Will do.  (This patch was originally part of my larger series trying to
get rid of qobject_from_jsonf() - I may still succeed at that, but
separating the easy stuff from the controversial means that the easy
stuff needs tweaking).

>=20
> Where are the "formats understood by json-lexer.c" documented?

Near the top of qobject/json-lexer.c:

 * Extension for vararg handling in JSON construction:
 *
 * %((l|ll|I64)?d|[ipsf])

Note that %i differs from %d (the former produces true/false, while the
latter produces "42" and friends - but it happens to "work" with gcc's
-Wformat checking, thanks to var-arg type promotion rules).

I could just spell it out directly (in fact, in the above-mentioned
larger series, I still kept qtest_qmp() able to understand %s, but
dropped all the other formats like %ld and %p).

>> + * @fmt...: HMP command to send to QEMU, passed through sprintf()
>=20
> Not actually through sprintf(), but I get what you mean.  I like to
> document such things as "Format arguments like vsprintf()."

Works for me.

>> @@ -592,13 +597,13 @@ static inline QDict *qmp_eventwait_ref(const cha=
r *event)
>>
>>  /**
>>   * hmp:
>> - * @fmt...: HMP command to send to QEMU
>> + * @fmt...: HMP command to send to QEMU, passed through printf()
>=20
> Here, you claim printf().  Typo?

Or inconsistent copy-and-paste.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PwGxdp943fMP3VgHi2WAaxOSX5aIhK9mw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllxFKQACgkQp6FrSiUn
Q2q51AgAqhxFnQmLxjqOTvIGI2K01iLRYZA7ZDgNC/PNtLCzB5WKsubKZcbET5dd
1hP4/9HwHLPpD/8YYXrN8gf5FQHukttHH3elMdy1ieGyGu1/D0KJ3JXWW9m+oJCd
LqLV/fQLYRVEI2/fEWVZynmloXJuePd/tOc0ydjiIqg3tb0S0D1YRangBdGbFPxe
+q146j/2o9jnHosPucKp+M/dbgQkxO1a+PLDpACs+UXE+XZpRVnhXn98UZzhwL9G
/wSiZa9h13g1VZz+lrTZaeKakyr1pEyltelahq9T/WLp/OqEcikzGedTTRwZ4ppj
ZxiQXpgzebEk5Kbc8NvuDHRTxE19qQ==
=hDOw
-----END PGP SIGNATURE-----

--PwGxdp943fMP3VgHi2WAaxOSX5aIhK9mw--
