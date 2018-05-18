Received: from eggs.gnu.org ([2001:4830:134:3::10]:44855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJWL7-0003rm-CK
	for qemu-devel@nongnu.org; Thu, 17 May 2018 23:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJWL6-0008J2-JN
	for qemu-devel@nongnu.org; Thu, 17 May 2018 23:45:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-33-alex.bennee@linaro.org>
	<9ef2bc85-cead-080c-8313-bf0113d5019e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <927cd32b-6de1-3702-5125-e682fb2ffcd4@amsat.org>
Date: Fri, 18 May 2018 00:45:39 -0300
MIME-Version: 1.0
In-Reply-To: <9ef2bc85-cead-080c-8313-bf0113d5019e@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="hFC4m1Pc39Av3iyTIbFBdDm2YVwE7IOtY"
Subject: Re: [Qemu-devel] [PATCH v4 32/49] tests/tcg/arm: add fcvt test
 cases for AArch32/64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hFC4m1Pc39Av3iyTIbFBdDm2YVwE7IOtY
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org,
 famz@redhat.com, berrange@redhat.com, balrogg@gmail.com,
 aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM" <qemu-arm@nongnu.org>
Message-ID: <927cd32b-6de1-3702-5125-e682fb2ffcd4@amsat.org>
Subject: Re: [PATCH v4 32/49] tests/tcg/arm: add fcvt test cases for
 AArch32/64
References: <20180517174718.10107-1-alex.bennee@linaro.org>
 <20180517174718.10107-33-alex.bennee@linaro.org>
 <9ef2bc85-cead-080c-8313-bf0113d5019e@linaro.org>
In-Reply-To: <9ef2bc85-cead-080c-8313-bf0113d5019e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2018 05:30 PM, Richard Henderson wrote:
> On 05/17/2018 10:47 AM, Alex Benn=C3=A9e wrote:
>> This runs through the usual float to float conversions and crucially
>> also runs with ARM Alternative Half Precision Format.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> [rth: tweak vcvtb.f16.f32/vctb.f32.f16 code and regen]
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> ---
>> v4
>>   - add fcvt.ref and check results against it
>>   - fix single_to_half, single_to_double conversions
>>   - properly toggle AHP mode (fpsr->fpcr)
>>   - more values around the AHP margins
>>   - add INF/NAN/SNAN inputs
>>   - build for ARM and AArch64
>>   - fix bug for hex literals
>>   - add float-to-int
>>   - checkpatch fix
>> ---
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks Richard, I was not very motivated to review each line of the
fcvt.ref files =3D)

> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.tar=
get
> index 9d2b551732..7bb777f442 100644
> --- a/tests/tcg/arm/Makefile.target
> +++ b/tests/tcg/arm/Makefile.target
> @@ -8,7 +8,9 @@ ARM_SRC=3D$(SRC_PATH)/tests/tcg/arm
>  # Set search path for all sources
>  VPATH 		+=3D $(ARM_SRC)
>
> -TESTS +=3D hello-arm test-arm-iwmmxt
> +ARM_TESTS=3Dhello-arm test-arm-iwmmxt
> +
> +TESTS +=3D $(ARM_TESTS) fcvt
>
>  hello-arm: CFLAGS+=3D-marm -ffreestanding
>  hello-arm: LDFLAGS+=3D-nostdlib
> @@ -24,3 +26,14 @@ run-test-mmap: test-mmap
>  	$(call quiet-command, $(QEMU) -p 8192 $< 8192 > test-mmap-8192.out,
"TEST", "$< (8k pages) on $(TARGET_NAME)")
>  	$(call quiet-command, $(QEMU) -p 16384 $< 16384 >
test-mmap-16384.out, "TEST", "$< (16k pages) on $(TARGET_NAME)")
>  endif
> +
> +ifeq ($(TARGET_NAME), arm)
> +fcvt: LDFLAGS+=3D-lm
> +# fcvt: CFLAGS+=3D-march=3Darmv8.2-a+fp16 -mfpu=3Dneon-fp-armv8

Alex, What is your idea here, enable this later?
Maybe add some TODO comment around..

Except this nit, for both Makefile.target:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> +
> +run-fcvt: fcvt
> +	$(call quiet-command, \
> +		$(QEMU) $< > fcvt.out && \
> +		diff -u $(ARM_SRC)/fcvt.ref fcvt.out, \
> +		"TEST", "$< (default) on $(TARGET_NAME)")
> +endif

$ make -j1 run-tcg-tests-aarch64-linux-user
  BUILD   debian9
  BUILD   debian-arm64-cross
  CROSS-BUILD aarch64 guest-tests with docker qemu:debian-arm64-cross
  BUILD   debian9
  BUILD   debian-arm64-cross
  CROSS-BUILD aarch64 guest-tests with docker qemu:debian-arm64-cross
  RUN-TESTS for aarch64
  TEST    test-mmap (default) on aarch64
  TEST    test-mmap (8k pages) on aarch64
  TEST    test-mmap (16k pages) on aarch64
  TEST    test-mmap (32k pages) on aarch64
  TEST    sha1 on aarch64
  TEST    linux-test on aarch64
  TEST    testthread on aarch64
  TEST    fcvt (default) on aarch64
  TEST    sysregs on aarch64

\o/

Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>



--hFC4m1Pc39Av3iyTIbFBdDm2YVwE7IOtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlr+TGUACgkQ4+MsLN6t
wN40vhAAuXXucMeHEkaCJYEG1YeZXhusu43LTVLxsOE1eVnfBX3P2VAYb/oyDFkw
kQy5sDk5xDAZWtnvwuODOPepUpSwES8clbZ81KB+PXBk0LNKbO2/LeNFZ3ik7q8b
l1z89iTo7fN7oxd5BZmwM2aLqh6rn1QnEubFkuAiR/ZKCw2WaEJIVSDprB2B9rQQ
8D1juhobOHPobTWm/Swwepbv7qaLTBA1JSfMRAIf+ALEqpQJlS4yHQKp3c5c9Czt
5oLQFfkrMDlOUbc0swITZYQ+bQ/EcD7+OkZiozFr46aGd7hzYhIf83pOtFW/SAh+
aE8JHpZIEKy4KadL+Qjlpw8c0mm4MyuCbUoBOn2zuxvXoK5gWEvTx8L7rz6a0EcD
d0d/U9sYTrbUzGq91LQDrxZ3ehl3rVkF5tRTf34IN2P2MQsRDxCBfsd4O3hYbtdb
haRTeLmDVCoVXFHAxIoJ7eXbXOgZaBTDGtPiP0Xruy2aVwEwtMgiU2g3OTMTYR4F
jK7EF/fPIq7PXhCy+BxMyrOs5DLNEQdNqQgyyuyEM+97bGE09lVJcPTd9qwfyuT0
S+wTqRGq1fnX9gzagTQR4cCjJQgdQA0W1lj0Ub6Z/RBqzFqY3mbke/a2HhRWJZon
HNcs/efRfySEW8dvIhMZmflQHXVtIUfX00DS4SBYMnrtxPS6xvc=
=2Ywr
-----END PGP SIGNATURE-----

--hFC4m1Pc39Av3iyTIbFBdDm2YVwE7IOtY--
