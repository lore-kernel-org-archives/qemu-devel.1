Received: from eggs.gnu.org ([2001:4830:134:3::10]:54267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1esmxE-0003Oe-2J
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1esmxA-0001Kl-Vx
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:02:48 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1esmxA-0001IX-My
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:02:44 -0500
Received: by mail-wm0-x242.google.com with SMTP id i3so14186706wmi.4
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 02:02:44 -0800 (PST)
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<20180305084111.GM2450@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180305084111.GM2450@redhat.com>
Date: Mon, 05 Mar 2018 10:02:41 +0000
Message-ID: <87fu5eu9fi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>


Richard W.M. Jones <rjones@redhat.com> writes:

> The attached patch is also needed to avoid crashes during various
> math-heavy test suites.
>
> Rich.
>
> --
<snip>
> From: Stef O'Rear <sorear2@gmail.com>
> Date: Sat, 3 Mar 2018 03:46:00 -0800
> Subject: [PATCH] softfloat: fix crash on int conversion of SNaN
>
> Signed-off-by: Stef O'Rear <sorear2@gmail.com>
> ---
>  fpu/softfloat.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index e7fb0d357a..1da1db377e 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1342,6 +1342,8 @@ static int64_t round_to_int_and_pack(FloatParts in,=
 int rmode,
>      switch (p.cls) {
>      case float_class_snan:
>      case float_class_qnan:
> +    case float_class_dnan:
> +    case float_class_msnan:
>          return max;
>      case float_class_inf:
>          return p.sign ? min : max;
> @@ -1430,6 +1432,8 @@ static uint64_t round_to_uint_and_pack(FloatParts i=
n, int rmode, uint64_t max,
>      switch (p.cls) {
>      case float_class_snan:
>      case float_class_qnan:
> +    case float_class_dnan:
> +    case float_class_msnan:
>          s->float_exception_flags =3D orig_flags | float_flag_invalid;
>          return max;
>      case float_class_inf:

Obviously I wasn't exercising the NaN exit paths enough and we added the
return_nan() common code fairly late in the series.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
