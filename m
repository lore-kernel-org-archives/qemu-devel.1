Received: from eggs.gnu.org ([2001:4830:134:3::10]:44087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMzcp-0007NJ-T0
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMzco-0006K8-HI
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:06:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eMzco-0006Jj-6c
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:06:18 -0500
References: <20171205044844.3597-1-richard.henderson@linaro.org>
	<CAFEAcA-i7pFPwdTvW=4VeRXfJC6hYD=PY6J-Z9XZcWmAk7hwiw@mail.gmail.com>
	<659ad21b-5c17-a194-6104-fe4f50e58009@twiddle.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <803c99d5-a4bc-4888-f20d-6840e7a75254@redhat.com>
Date: Thu, 7 Dec 2017 11:06:15 -0600
MIME-Version: 1.0
In-Reply-To: <659ad21b-5c17-a194-6104-fe4f50e58009@twiddle.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tbGCDMoCbFGPDNUSIQF6HF0NLLW6rlxno"
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Use *at functions instead
 of caching interp_prefix contents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tbGCDMoCbFGPDNUSIQF6HF0NLLW6rlxno
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <803c99d5-a4bc-4888-f20d-6840e7a75254@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Use *at functions instead of
 caching interp_prefix contents
References: <20171205044844.3597-1-richard.henderson@linaro.org>
 <CAFEAcA-i7pFPwdTvW=4VeRXfJC6hYD=PY6J-Z9XZcWmAk7hwiw@mail.gmail.com>
 <659ad21b-5c17-a194-6104-fe4f50e58009@twiddle.net>
In-Reply-To: <659ad21b-5c17-a194-6104-fe4f50e58009@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 08:43 AM, Richard Henderson wrote:

>>> -    fd =3D open(path(filename), O_RDONLY);
>>> +    switch (interp_dirfd > 0 && filename[0] =3D=3D '/') {
>>> +    case true:
>>
>> gcc doesn't like this pattern:
>>
>> /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/syscall.c: In
>> function =E2=80=98do_name_to_handle_at=E2=80=99:
>> /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/syscall.c:7231:=
13:
>> error: switch condition has boolean value [-Werror=3Dswitch-bool]
>>      switch (interp_dirfd > 0 && name[0] =3D=3D '/') {
>>              ^
>>
>> It seems like an odd way to write an if().
>=20
> Huh.  My gcc likes it just fine.  What version are you using?
>=20
> It's an IF with a /* fallthru */, so there are very few
> less ugly ways to write it...

Maybe:

while (1) {
    if (interp_dirfd > 0 && filename[0] =3D=3D '/') {
        fd =3D openat(interp_dirfd, filename + 1, O_RDONLY);
        if (fd >=3D 0 || errno !=3D ENOENT) {
            break;
        }
    }
    fd =3D open(filename, O_RDONLY);
    break;
}

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tbGCDMoCbFGPDNUSIQF6HF0NLLW6rlxno
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopdQcACgkQp6FrSiUn
Q2rbsAf/RHIDkzQhhCF5/BlBkxOJzfrRXSDqGQu7OvJDNu8SMUomYso+BCUE2VI9
zF3oiEfqxlELeL4APDS9KY/c014jQkBh+pOAowzpv+zFoNsAmKdynPfIZfghTbo2
2jFKp+P0HNtToFZx6rcZprqkXtN5BdmjqleepuhaQ+Gi7e4fA0jeSEO2vQAokd2z
DWnfJSUhBoztBrFlljvWeu7dlR43o4Zuet4JhgxeDbTu0iPz/1HN072EAOUt8lCf
DnNBn/xv74JOQkTcS/R8WQBnz43PVUz/QDyc660bB28SE0WjvkF99JmC9e9qmjDV
TUX9aeBJyzV9dLSE8GJvnewvSorZaA==
=rW/7
-----END PGP SIGNATURE-----

--tbGCDMoCbFGPDNUSIQF6HF0NLLW6rlxno--
