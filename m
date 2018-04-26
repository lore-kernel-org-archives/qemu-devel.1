Received: from eggs.gnu.org ([2001:4830:134:3::10]:44015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBkxC-00059h-Vn
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBkxA-0003CF-BF
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:45:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50062 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBkxA-0003Bn-4O
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:45:08 -0400
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-2-git-send-email-ian.jackson@eu.citrix.com>
	<f9d7f1bd-2ef2-691a-fa98-129ecca06b02@redhat.com>
	<23266.3384.611703.928502@mariner.uk.xensource.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d78d25c0-3259-6f71-34f7-321140b87c69@redhat.com>
Date: Thu, 26 Apr 2018 12:45:02 -0500
MIME-Version: 1.0
In-Reply-To: <23266.3384.611703.928502@mariner.uk.xensource.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="elTZgR6oL6e0dsngtUCbP9OSkx16tlMwp"
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
To: Ian Jackson <ian.jackson@citrix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "=?UTF-8?Q?Daniel_P.Berrang=c3=a9?=" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--elTZgR6oL6e0dsngtUCbP9OSkx16tlMwp
From: Eric Blake <eblake@redhat.com>
To: Ian Jackson <ian.jackson@citrix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, =?UTF-8?Q?Daniel_P.Berrang=c3=a9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <d78d25c0-3259-6f71-34f7-321140b87c69@redhat.com>
Subject: Re: [RFC PATCH 1/7] error reporting: Introduce errnoval parameter to
 vreport
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
 <1524761612-5307-2-git-send-email-ian.jackson@eu.citrix.com>
 <f9d7f1bd-2ef2-691a-fa98-129ecca06b02@redhat.com>
 <23266.3384.611703.928502@mariner.uk.xensource.com>
In-Reply-To: <23266.3384.611703.928502@mariner.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 12:32 PM, Ian Jackson wrote:

>>>   * Print a message to current monitor if we have one, else to stderr=
=2E
>>>   * @report_type is the type of message: error, warning or informatio=
nal.
>>> + * If @errnoval is nonnegative it is fed to strerror and printed too=
=2E
>>
>> That implies 0 is fed to strerror(), which is not the case.
>=20
> But, 0 might be fed to strerror.  This is not normally deliberate, but
> it does occor.  It is not unusual for people to write code which can
> feed 0 to strerror.  strerror then conventionally returns "Error 0".

No, POSIX requires:
http://pubs.opengroup.org/onlinepubs/9699919799/functions/strerror.html
"if the value of errnum is zero, the message string shall either be an
empty string or indicate that no error occurred;"

and at least in glibc, strerror(0) returns "Success", which looks dumb
in an error message.

>=20
> This is why I chose -1 as the sentinel value meaning "there is no
> errno being passed".
>=20
>> "If @errnoval is not zero, its absolute value is fed to strerror" to l=
et
>> people pass in both EIO and -EIO for the same output (something that
>> strerror() can't do, but our wrapper can) - but I don't know if that
>> convenience is a good thing.
>=20
> I think it is more important not to turn inintended situations where 0
> would previously have been passed to strerror, into situations where
> the errno value string simply vanishes.

Passing 0 as an errno value to indicate an error is almost always wrong.
But if you don't have an errno value to report, having the error string
disappear is preferable to outputting garbage or even assert()ing that
the error value was nonzero.

>>
>> Passing -1 to suppress the output feels awkward, especially if 0 can b=
e
>> used for the same purpose and would then let us use -errno and errno
>> interchangeable by passing the absolute value to sterror.
>=20
> I think no good can come of taking the absolute value.  The confusion
> resulting from -errnoval is bad enough already IMO.

You are correct that in the past, we've had code passing or returning
the wrong sign without realizing it.  So the question is whether, at
least for reporting purposes, it looks better to report "Operation not
permitted" instead of "Unknown error -1", or whether munging the error
message as a convenience for better output makes it harder for the
programmer to realize that they are returning the wrong sign up the
stack to the caller.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--elTZgR6oL6e0dsngtUCbP9OSkx16tlMwp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriEB4ACgkQp6FrSiUn
Q2prQQgAgNte/Rikx1+R/f3c+7SKormUFCKWUvhbWThjrq1Z8op8TxXZPCXStRvn
++ewKVH6XAHOCxUOS9ggN7CmjnB3EYZyYJfLX0eB86TSAYTSiMdpJuaoQ92G6swH
PfkrK/SPgFhGc/xPCGsF2ESNpz0PPaAn1PLVQGgE50l64Y1zNoK1K8j8z/3jekW8
wOmpTj8xG8UQo4m+eGXvw+SS+e0Qs3bFGmIxFVKMIWuqfO6mC8WhxKRzFCdvTh7i
d+nE9ZQPRMwGX3TXpatwzpX9UWqFKuWEOoVul1LkKnj9C2uNbWAvJ/X7v1MKF7Ih
LwM05LyQ4rGnHBCelARRVD6T5B0Kww==
=E1xL
-----END PGP SIGNATURE-----

--elTZgR6oL6e0dsngtUCbP9OSkx16tlMwp--
