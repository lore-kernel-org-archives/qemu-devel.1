Received: from eggs.gnu.org ([2001:4830:134:3::10]:51901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBlOD-0004vz-6p
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBlO9-0007ED-Rc
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:13:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58568 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBlO9-0007Dj-Kv
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:13:01 -0400
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-2-git-send-email-ian.jackson@eu.citrix.com>
	<f9d7f1bd-2ef2-691a-fa98-129ecca06b02@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dc046746-c36d-33fc-de34-2c8b2dc150a8@redhat.com>
Date: Thu, 26 Apr 2018 13:12:53 -0500
MIME-Version: 1.0
In-Reply-To: <f9d7f1bd-2ef2-691a-fa98-129ecca06b02@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jbQ6p6eo2zTmufPYQWO9ESqsZhORZ3AGz"
Subject: Re: [Qemu-devel] [RFC PATCH 1/7] error reporting: Introduce
 errnoval parameter to vreport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jbQ6p6eo2zTmufPYQWO9ESqsZhORZ3AGz
From: Eric Blake <eblake@redhat.com>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <dc046746-c36d-33fc-de34-2c8b2dc150a8@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/7] error reporting: Introduce errnoval
 parameter to vreport
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
 <1524761612-5307-2-git-send-email-ian.jackson@eu.citrix.com>
 <f9d7f1bd-2ef2-691a-fa98-129ecca06b02@redhat.com>
In-Reply-To: <f9d7f1bd-2ef2-691a-fa98-129ecca06b02@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 12:24 PM, Eric Blake wrote:

>> @@ -222,6 +224,11 @@ static void vreport(report_type type, const char =
*fmt, va_list ap)
>>      }
>> =20
>>      error_vprintf(fmt, ap);
>> +
>> +    if (errnoval >=3D 0) {
>> +        error_printf(": %s", strerror(errnoval));
>=20
> Off-by-one.  You do NOT want to print strerror(0) (that results in
> appending ": Success" or similar to what is supposed to be an error
> message).

>=20
> Passing -1 to suppress the output feels awkward, especially if 0 can be=

> used for the same purpose and would then let us use -errno and errno
> interchangeable by passing the absolute value to sterror.
>=20

I'm also using, as my reference, the glibc 'man 3 error' function, which
specifically documents:

  if  errnum  is  nonzero,  a second colon and a space followed by the
string
       given by strerror(errnum).

making it a very versatile function for outputting messages to stderr
whether or not you also have an errno value to convert via strerror(),
by using 0 (not -1) as the sentinel value.

Consistency argues that even if we are going to invent our own qemu
functions, we're better off sticking to well-known paradigms already in
the wild (such as 0 to suppress appending strerror()) rather than making
readers learn yet another paradigm.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jbQ6p6eo2zTmufPYQWO9ESqsZhORZ3AGz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriFqUACgkQp6FrSiUn
Q2qv3Af/V56eve9zt5QGLecjhwRdBNujZdLxvt+ziCFUqzeEgk45mvx68OTC+UOY
n9+jBsxTNeIwx4cslRbGPcxC/smIVQK6qT4R34t4j6U7Uhr4TR+2CNckZwT2qYeA
Dwrh0IQzrFxUjfrhDNpeH2BgGnKypiFL7+L8xTevZ5GT7ZD3eLQDoj59UlPCnDdY
NLMy/wWKzVp7lvpfGicKd+uf4NjootzHRmiy1QIHWxjXA2BeK35V9VJOP0vinL4F
GXx0D52qFThXl4yG7LJ/fczgNM6yptJsRsbc8qCc0DS52qKinuvkjAH8ytLGfLz4
iZ7hahAYWMmZvdXMUR6RQUADb2LlQA==
=VNgZ
-----END PGP SIGNATURE-----

--jbQ6p6eo2zTmufPYQWO9ESqsZhORZ3AGz--
