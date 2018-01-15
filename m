Received: from eggs.gnu.org ([2001:4830:134:3::10]:38702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb8Ls-0001hv-F3
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb8Lq-0005yY-Km
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eb8Lq-0005y1-AQ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:15:14 -0500
References: <20180115170243.24578-1-berrange@redhat.com>
	<20180115170243.24578-8-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <33212c79-61aa-3089-dda3-2715cd43caf0@redhat.com>
Date: Mon, 15 Jan 2018 11:15:01 -0600
MIME-Version: 1.0
In-Reply-To: <20180115170243.24578-8-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="za5Xdoa3JpqnUljBNkXczPMOmInnR1OnA"
Subject: Re: [Qemu-devel] [PATCH v4 07/13] qapi: force a UTF-8 locale for
 running Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--za5Xdoa3JpqnUljBNkXczPMOmInnR1OnA
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33212c79-61aa-3089-dda3-2715cd43caf0@redhat.com>
Subject: Re: [PATCH v4 07/13] qapi: force a UTF-8 locale for running Python
References: <20180115170243.24578-1-berrange@redhat.com>
 <20180115170243.24578-8-berrange@redhat.com>
In-Reply-To: <20180115170243.24578-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 11:02 AM, Daniel P. Berrange wrote:
> Python2 did not validate locale correctness when reading input data, so=

> would happily read UTF-8 data in non-UTF-8 locales. Python3 is strict s=
o
> if you try to read UTF-8 data in the C locale, it will raise an error
> for any UTF-8 bytes that aren't representable in 7-bit ascii encoding.

Urgh, that sounds like a Python bug. The C locale is defined by POSIX to
be 8-bit clean (ie. a superset of ascii with 256 characters, not strict
ascii with only 128 characters and 128 bytes that form encoding errors).
 But that doesn't change the fact that we have to work around python's
braindead misinterpretation of reality.

> e.g.
>=20
> UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 54=
: ordinal not in range(128)
> Traceback (most recent call last):
>   File "/tmp/qemu-test/src/scripts/qapi-commands.py", line 317, in <mod=
ule>
>     schema =3D QAPISchema(input_file)
>   File "/tmp/qemu-test/src/scripts/qapi.py", line 1468, in __init__
>     parser =3D QAPISchemaParser(open(fname, 'r'))
>   File "/tmp/qemu-test/src/scripts/qapi.py", line 301, in __init__
>     previously_included)
>   File "/tmp/qemu-test/src/scripts/qapi.py", line 348, in _include
>     exprs_include =3D QAPISchemaParser(fobj, previously_included, info)=

>   File "/tmp/qemu-test/src/scripts/qapi.py", line 271, in __init__
>     self.src =3D fp.read()
>   File "/usr/lib64/python3.5/encodings/ascii.py", line 26, in decode
>     return codecs.ascii_decode(input, self.errors)[0]
>=20
> Many distros support a new C.UTF-8 locale that is like the C locale,
> but with UTF-8 instead of 7-bit ASCII. That is not entirely portable
> though, so this patch instead forces the en_US.UTF-8 locale, which
> is pretty similar but more widely available.
>=20
> We set LANG, rather than only LC_CTYPE, since generated source ought
> to be independant of all of the user's locale settings.

s/independant/independent/

LANG is the lowest-priority setting - if the user has explicitly set
LC_CTYPE or LC_ALL, their settings override what is in LANG.

>=20
> This patch only forces UTF-8 for QAPI scripts, since that is the one
> showing the immediate error under Python3 with C locale, but potentiall=
y
> we ought to force this for all python scripts used in the build process=
=2E
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index d86ecd2dd4..fde91cc42d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -17,6 +17,8 @@ ifneq ($(wildcard config-host.mak),)
>  all:
>  include config-host.mak
> =20
> +PYTHON_UTF8 =3D LANG=3Den_US.UTF-8 $(PYTHON)

I'm worried that this is not reproducible in the face of a user that
explicitly sets different locale env-vars with higher priority than LANG.=


> +
>  git-submodule-update:
> =20
>  .PHONY: git-submodule-update
> @@ -471,17 +473,17 @@ qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PAT=
H)/scripts/ordereddict.py
> =20
>  qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.=
h :\
>  $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(q=
api-py)
> -	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
> +	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-types.py=
 \

But once we agree on the right override to stuff into PYTHON_UTF8, the
rest of the patch converting invocations to PYTHON_UTF8 makes sense.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--za5Xdoa3JpqnUljBNkXczPMOmInnR1OnA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpc4ZUACgkQp6FrSiUn
Q2rcOgf/QUqoLqKCCdPxzYsJiIIpqD/ZbEWfEgyDpl9209zzlPWc1SqohCJUR3tH
iME0URKxpmLNFflr4CPsp7E+ax94E+98v+OVd+hdyrxevPQIxGRq5sq01zMNohwm
9/ueEa9gkhrw9d0BJpPxIc4jxc/9Q+hXKqDYh7qKZCKM7LoHlVIHx94tmdejsuIL
KwyBx6eU65JZlhstlBq0N2rnWQ0hFXGiDBq0RD3jmRySb4y2lqNTEi/RAE0y3AJJ
PPwJT6XsckSTSDb55m6rcXKVMbruCRs+eyYzp9xA/IbHqkaPyWiOj6h1Cr9gmjqg
dblx5pQPEKwgTelN+A/30M4RsptwBw==
=PNbQ
-----END PGP SIGNATURE-----

--za5Xdoa3JpqnUljBNkXczPMOmInnR1OnA--
