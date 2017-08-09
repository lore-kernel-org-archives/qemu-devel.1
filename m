Received: from eggs.gnu.org ([2001:4830:134:3::10]:47941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfQoW-0001rh-0z
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfQoR-0005sO-Cs
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:14:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5521)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfQoR-0005rz-3K
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:14:15 -0400
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-6-eblake@redhat.com>
	<87k22dw4r2.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9564021-896a-2c29-8f74-0921e94d292a@redhat.com>
Date: Wed, 9 Aug 2017 08:14:09 -0500
MIME-Version: 1.0
In-Reply-To: <87k22dw4r2.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UaUtFd88wrFnG0i1n6UfPUXulGsQ8CwjB"
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
--UaUtFd88wrFnG0i1n6UfPUXulGsQ8CwjB
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <c9564021-896a-2c29-8f74-0921e94d292a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 05/22] qobject: Simplify
 qobject_from_jsonv()
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-6-eblake@redhat.com> <87k22dw4r2.fsf@dusky.pond.sub.org>
In-Reply-To: <87k22dw4r2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 02:59 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> qobject_from_jsonv() was unusual in that it took a va_list*, instead
>> of the more typical va_list; this was so that callers could pass
>> NULL to avoid % interpolation.  While this works under the hood, it
>> is awkward for callers, so move the magic into qjson.c rather than
>> in the public interface, and finally improve the documentation of
>> qobject_from_jsonf().
>>

>> -    /* Going through qobject ensures we escape strings properly.
>> -     * This seemingly unnecessary copy is required in case va_list
>> -     * is an array type.
>> -     */
>> -    va_copy(ap_copy, ap);
>> -    qobj =3D qobject_from_jsonv(fmt, &ap_copy, &error_abort);
>> -    va_end(ap_copy);
>> +    /* Going through qobject ensures we escape strings properly. */
>> +    qobj =3D qobject_from_jsonv(fmt, ap);
>>      qstr =3D qobject_to_json(qobj);
>>
>>      /*
>=20
> Wait!  Oh, the va_copy() moves iinto qobject_from_jsonv().  Okay, I
> guess.


>> +
>> +    /*
>> +     * This seemingly unnecessary copy is required in case va_list
>> +     * is an array type.
>> +     */
>=20
> --verbose?

Code motion. But if the comment needs to be more verbose in the
destination than it was on the source, the rationale is that C99/POSIX
allows 'typedef something va_list[]' (that is, where va_list is an array
of some other type), although I don't know of any modern OS that
actually defines it like that.  Based on C pointer-decay rules, '&ap'
has a different type based on whether va_list was a struct/pointer or an
array type, when 'va_list ap' was passed as a parameter; so we can't
portably use qobject_from_json_internal(string, &ap, &error_abort).  The
va_copy() is what lets us guarantee that &ap_list is a pointer to a
va_list regardless of the type of va_list (because va_copy was declared
locally, rather than in a parameter list, and is therefore not subject
to pointer decay), and NOT an accidental pointer to first element of the
va_list array on platforms where va_list is an array.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UaUtFd88wrFnG0i1n6UfPUXulGsQ8CwjB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLCqEACgkQp6FrSiUn
Q2r0nAf9EABXmr03QzpIJ4zXXxFwL1pBHAPlK4tbHcOEU70lVYJ6fKPu6RlLAsfF
DJn38+W9WZEX74dFriiJyRchyIYKbGiyicvN6mSxmPfcTvHsgNy/Lv3unN4LchGj
tzKC5uW+xXj/s4fU2TiBso8Qjx2hminf13Uwwr9t6YRM3ihwU+0QzehJSy6OKlww
KSR0+8CBzx0Ls/mYFy48pPXkvqPASM4OxMhTbzK3522vvOtaN7RwK0ATQXii36xT
rhzR0yhKyKHZpkNJqBJrYYXNnnkUx3wuLoKt9ODDvcSu/NvfSGnsJuO2l/w5lFKs
x/Mp36mpcLABR/ujDsqQdZc6In770Q==
=F4Dt
-----END PGP SIGNATURE-----

--UaUtFd88wrFnG0i1n6UfPUXulGsQ8CwjB--
