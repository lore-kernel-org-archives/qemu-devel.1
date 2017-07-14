Received: from eggs.gnu.org ([2001:4830:134:3::10]:34953)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dVytd-0007hh-8U
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dVytY-0006LY-AK
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:36:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:63517)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dVytX-0006Hu-UL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:36:28 -0400
References: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <910a8148-915a-ab66-1c6c-f18145c13e37@gmx.com>
Date: Fri, 14 Jul 2017 13:27:14 +0200
MIME-Version: 1.0
In-Reply-To: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="inhaoUMKgFchhRWVL86n0VKa4BqmquRM4"
Subject: Re: [Qemu-devel] [PATCH] tests: Handle $RANDOM not being supported
 by the shell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--inhaoUMKgFchhRWVL86n0VKa4BqmquRM4
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eric Blake <eblake@redhat.com>
Message-ID: <910a8148-915a-ab66-1c6c-f18145c13e37@gmx.com>
Subject: Re: [PATCH] tests: Handle $RANDOM not being supported by the shell
References: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.07.2017 12:45, Peter Maydell wrote:
> In various places in our test makefiles and scripts we use the
> shell $RANDOM to create a random number. This is a bash
> specific extension, and doesn't work on other shells.

This is supported on other shells like ksh (Korn Shell), but still as an
extension.

> With dash the shell doesn't complain, it just effectively
> always evaluates $RANDOM to 0:
>   echo $((RANDOM + 32768))     =3D> 32768
>=20
> However, on NetBSD the shell will complain:
>   "-sh: arith: syntax error: "RANDOM + 32768"
>=20

I will make sure whether this behavior is correct in our sh(1).

> which means that "make check" fails.
>=20
> Switch to using "${RANDOM:-0}" instead of $RANDOM,
> which will portably either give us a random number or zero.
> This means that on non-bash shells we don't get such
> good test coverage via the MALLOC_PERTURB_ setting, but
> we were already in that situation for non-bash shells.
>=20
> Our only other uses of $RANDOM (in tests/qemu-iotests/check
> and tests/qemu-iotests/162) are in shell scripts which use
> a #!/bin/bash line so they are always run under bash.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Kamil Rytarowski <n54@gmx.com>

> ---
>  tests/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 6d6cb74..f6310d2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -826,7 +826,7 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): che=
ck-qtest-%: $(check-qtest-y)
>  	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
>  	$(call quiet-command,QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
>  		QTEST_QEMU_IMG=3Dqemu-img$(EXESUF) \
> -		MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$((RANDOM % 255 + 1))} \
> +		MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))=
} \
>  		gtester $(GTESTER_OPTIONS) -m=3D$(SPEED) $(check-qtest-$*-y) $(check=
-qtest-generic-y),"GTESTER","$@")
>  	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$*-y) $(gcov-files-generic=
-y); do \
>  	  echo Gcov report for $$f:;\
> @@ -837,7 +837,7 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): che=
ck-qtest-%: $(check-qtest-y)
>  $(patsubst %, check-%, $(check-unit-y)): check-%: %
>  	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
>  	$(call quiet-command, \
> -		MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$((RANDOM % 255 + 1))} \
> +		MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))=
} \
>  		gtester $(GTESTER_OPTIONS) -m=3D$(SPEED) $*,"GTESTER","$*")
>  	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$(subst tests/,,$*)-y) $(g=
cov-files-generic-y); do \
>  	  echo Gcov report for $$f:;\
>=20



--inhaoUMKgFchhRWVL86n0VKa4BqmquRM4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZaKqTAAoJEEuzCOmwLnZsls0P/AvjuskS1mH5KFdOn7G5WU1e
q4uK+ViaqyGCODYfqQTHMW0+zVP9URbraOi8+gXPLrscRRmrOZCuUIIl6I2TkIA7
uGTDFhKM73gkvN6u88v1bD6R/juI+G71/iJTh8GAZvaV61EXzaB3jWImeZ2py83J
sQ7/mfnDpa2iH07hhTb/9FETGn0qiX3Ic93N3JEsUkxyHv7WCl7ZV4CdUSK2SEVE
qxwHxiBpaq7ecyJ0FombU+rlxHHAjjWPoc8GA46ThHZsrcBfayVzujwSsMQwA3LC
YAaewgZe2HGwHrso89l6KEU/xvm+V4yd0ejXSeC0+VlmlpqTL3pVChQvay4uI0Ko
uaxQqJKurlEXJLHxJvD6GONIqccO96pLjBvc3Rsrp5yEMAfAAAgDIyc/azXrFLGy
xYaECF1N1Wn1gdtH0T7hwqNY9j9eM4Aemb0peJE24dpWEqj2/kpUqjJ1KyVF4zHA
BEOgTYFW/n/+Mzj8/Z6NXzxhujFAfmN2DF0NYMoN1Djs6BPOsze3tnTxjMdLaH1X
RuzaSr8gXGY2sEfF0mnu6PqiL9zWTOduX5f02LU49gmo8enjOJizcRiuIzRQj877
lEZyrC2yP6P5uVsFHJhQOzOhn6UtmAaDHJWHha59uJ5R+MD8X7ARm78wdfvnGFNe
vWWeUoUu4HXf4yB+5OBa
=n9Qg
-----END PGP SIGNATURE-----

--inhaoUMKgFchhRWVL86n0VKa4BqmquRM4--
