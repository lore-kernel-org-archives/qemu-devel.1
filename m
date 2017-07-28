Received: from eggs.gnu.org ([2001:4830:134:3::10]:37452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAUw-0003I9-Ad
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAUr-0001yH-QO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:00:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dbAUr-0001xe-HF
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:00:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21A4D75F72
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 19:00:24 +0000 (UTC)
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-4-eblake@redhat.com>
	<87y3r8jtu5.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fed09f84-2112-73e2-5541-603a77fe746d@redhat.com>
Date: Fri, 28 Jul 2017 14:00:17 -0500
MIME-Version: 1.0
In-Reply-To: <87y3r8jtu5.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HMUBVuXP8ba7EMW7NPEvAstR2rxctb3a3"
Subject: Re: [Qemu-devel] [PATCH v3 03/12] qtest: Document calling
 conventions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HMUBVuXP8ba7EMW7NPEvAstR2rxctb3a3
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <fed09f84-2112-73e2-5541-603a77fe746d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/12] qtest: Document calling conventions
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-4-eblake@redhat.com> <87y3r8jtu5.fsf@dusky.pond.sub.org>
In-Reply-To: <87y3r8jtu5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 01:32 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> We have two flavors of vararg usage in qtest; make it clear that
>> qmp() has different semantics than hmp(), and let the compiler
>> enforce that hmp() is used correctly. However, qmp() (and friends)
>> only accept a subset of printf flags look-alikes (namely, those
>> that our JSON parser understands), and what is worse, qmp("true")
>> (the JSON keyword 'true') is different from qmp("%s", "true")
>> (the JSON string '"true"'), and we have some intermediate cleanup
>> patches to do before we can mark those as printf-like.
>=20
> It's not "worse", it's just different :)
>=20
> Suggest:
>=20
>   We have two flavors of vararg usage in qtest: qtest_hmp() etc. work
>   like sprintf(), and qtest_qmp() etc. work like qobject_from_jsonf().
>   Spell that out in the comments.
>=20
>   Also add GCC_FMT_ATTR() to qtest_hmp() etc. so that the compiler can
>   flag incorrect use.
>=20
>   We have some cleanup work to do before we can do the same for
>   qtest_qmp() etc.  This will get us the same better-than-nothing
>   checking we already have for qobject_from_jsonf(): common incorrect
>   uses of supported conversion specifications will be flagged
>   (e.g. passing a double for %d), but use of unsupported ones won't.

"Mikey likes it" (no idea if that pop culture reference from my
childhood has broader range than the US)

>> @@ -134,19 +140,19 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, co=
nst char *event);
>>  /**
>>   * qtest_hmp:
>>   * @s: #QTestState instance to operate on.
>> - * @fmt...: HMP command to send to QEMU
>> + * @fmt...: HMP command to send to QEMU, formats arguments like vspri=
ntf().
>=20
> Like sprintf().

Hmm, you asked me to use vsprintf on the last one.  Oh, I finally see -
you're trying to get me to match: vsprintf if it is 'va_list', sprintf
if it is '...'.  Yeah, that makes sense.


> With the comment fixed, and preferably with an improved commit message:=

> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks for the reviews and suggestions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HMUBVuXP8ba7EMW7NPEvAstR2rxctb3a3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7icEACgkQp6FrSiUn
Q2qcAwf/RDDwQKaohjKvzBRvFBbvDEW1sd5YnvB3fiKVjaXaNBZhJyLasB2ittjT
QY4+Cr3Z0sx9e+W8nZizwdfR5fwcxfLBuh+r4AGSmP9gcIwmLX8AprwLaucgeGyf
5rEda1R2BMliAKleBPbYLzOnOvtKDFGGNMKJ+/S5/aK4202RVVoFboqlsNqMtPrE
/gnDTdwLFHH7GD7c+fCWGtbQXtl2pKzHyXTA7jWdoQBAxamFwPitQ4UD/DnFjw7o
P6wPivGKyvf8aB1vudD10Ycp/Of6BWANxCEYg6Lq3YwHohgNuOYCXFW8CUyT0rhF
0oJ7+8CnwaIFArCOQISn9YC2hHeVeA==
=bNMy
-----END PGP SIGNATURE-----

--HMUBVuXP8ba7EMW7NPEvAstR2rxctb3a3--
