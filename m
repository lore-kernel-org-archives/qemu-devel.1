Received: from eggs.gnu.org ([2001:4830:134:3::10]:44296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYaZB-0002Q5-O7
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYaZ9-0003AO-1Z
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:46:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eYaZ8-00039Y-NI
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:46:26 -0500
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-6-eblake@redhat.com>
	<87k22dw4r2.fsf@dusky.pond.sub.org>
	<c9564021-896a-2c29-8f74-0921e94d292a@redhat.com>
	<87lgkurtiw.fsf@dusky.pond.sub.org>
	<7893edd1-4f6c-7954-f682-e27824b8c984@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8ef31a0-887d-e315-bd42-40b68c3c7c45@redhat.com>
Date: Mon, 8 Jan 2018 10:46:23 -0600
MIME-Version: 1.0
In-Reply-To: <7893edd1-4f6c-7954-f682-e27824b8c984@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oyHGQQ5CrcmudXgZ3zQytfDKrV30i2Usl"
Subject: Re: [Qemu-devel] [PATCH v4 05/22] qobject: Simplify
 qobject_from_jsonv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oyHGQQ5CrcmudXgZ3zQytfDKrV30i2Usl
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <f8ef31a0-887d-e315-bd42-40b68c3c7c45@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 05/22] qobject: Simplify
 qobject_from_jsonv()
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-6-eblake@redhat.com> <87k22dw4r2.fsf@dusky.pond.sub.org>
 <c9564021-896a-2c29-8f74-0921e94d292a@redhat.com>
 <87lgkurtiw.fsf@dusky.pond.sub.org>
 <7893edd1-4f6c-7954-f682-e27824b8c984@redhat.com>
In-Reply-To: <7893edd1-4f6c-7954-f682-e27824b8c984@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:30 AM, Eric Blake wrote:
> On 10/02/2017 12:46 AM, Markus Armbruster wrote:
>=20
>>>>> +    /*
>>>>> +     * This seemingly unnecessary copy is required in case va_list=

>>>>> +     * is an array type.
>>>>> +     */
>>>>
>>>> --verbose?
>>>>
>>>>> +    va_copy(ap_copy, ap);
>>>>> +    obj =3D qobject_from_json_internal(string, &ap_copy, &error_ab=
ort);
>>>>> +    va_end(ap_copy);
>>>
>>> Code motion. But if the comment needs to be more verbose in the
>>> destination than it was on the source, the rationale is that C99/POSI=
X
>>> allows 'typedef something va_list[]' (that is, where va_list is an ar=
ray
>>> of some other type), although I don't know of any modern OS that
>>> actually defines it like that.  Based on C pointer-decay rules, '&ap'=

>>> has a different type based on whether va_list was a struct/pointer or=
 an
>>> array type, when 'va_list ap' was passed as a parameter; so we can't
>>> portably use qobject_from_json_internal(string, &ap, &error_abort).  =
The
>>> va_copy() is what lets us guarantee that &ap_list is a pointer to a
>>> va_list regardless of the type of va_list (because va_copy was declar=
ed
>>> locally, rather than in a parameter list, and is therefore not subjec=
t
>>> to pointer decay), and NOT an accidental pointer to first element of =
the
>>> va_list array on platforms where va_list is an array.

When I first wrote that, I didn't know where it mattered in practice;
now I do.  Here's a gcc non-bug:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D14557

that documents a workaround of using a macro va_ptr() because there ARE
existing modern platforms that use an array type for va_list:
https://sourceware.org/ml/newlib/2017/msg01302.html

I don't know if va_ptr() is any more elegant than the va_copy() used in
my code motion.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oyHGQQ5CrcmudXgZ3zQytfDKrV30i2Usl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpToF8ACgkQp6FrSiUn
Q2oulQgArsxWRvw9nfLCT1+/reRpQTEyB4Jqu7t/uoNaGIRTYpodc6faMstNcBZR
63QXGdjWQnqFT7DZ60hYOqidjzK3lcXoBSBYE3RPOU/2Vyip8K+gVl+WqiKdU5K5
1jO6qxnIJoMz8c2od0p4BKDKa7I50MgFsbzOxCP+uu+RlEhiiTP6LqqZ/ZsvGLxY
LNHPt0ad3mI6cnrDcTmaWXADsxPp55n89nDS4ochgzdGmjwpj+kNVFQfmtikVtn2
y2lhzGp2rw8K28pkbHlcM5SJQ35Y8f1h0nVJyhNXXuGyHWRRf3Y8TyxpEm3BervQ
DXYoFEvbEp4g0BaWmub4DVa3AMjJTA==
=nn15
-----END PGP SIGNATURE-----

--oyHGQQ5CrcmudXgZ3zQytfDKrV30i2Usl--
