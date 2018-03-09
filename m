Received: from eggs.gnu.org ([2001:4830:134:3::10]:41245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euJcB-0002pV-Vj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euJcA-00084r-MH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:07:23 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euJcA-00084g-EE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:07:22 -0500
Received: by mail-oi0-x242.google.com with SMTP id c12so7174480oic.7
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:07:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305084111.GM2450@redhat.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<20180305084111.GM2450@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 10 Mar 2018 04:07:21 +1300
Message-ID: <CAHNT7NtNaO9GzWoogrs8Cv3cYS3dJb+KuEmRoQ7JxwjZsudHDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Mon, Mar 5, 2018 at 9:41 PM, Richard W.M. Jones <rjones@redhat.com>
wrote:

>
> The attached patch is also needed to avoid crashes during various
> math-heavy test suites.
>

Thanks. I missed your email.

I've integrated this and the other outstanding patches into the `riscv-all`
branch in the riscv repo here.

- https://github.com/riscv/riscv-qemu/commits/riscv-all

This also triggered aborts on riscv-tests, which is all the more reason to
get riscv-tests running in the CI so we spot these things early.

Thanks,
Michael.

Rich.
>
> From: Stef O'Rear <address@hidden>
>
> Date: Sat, 3 Mar 2018 03:46:00 -0800
>
> Subject: [PATCH] softfloat: fix crash on int conversion of SNaN
>
>
>> Signed-off-by: Stef O'Rear <address@hidden>
>
>
Signed-off-by: Michael Clark <mjc@sifive.com>


> ---
>
>  fpu/softfloat.c | 4 ++++
>
>  1 file changed, 4 insertions(+)
>
>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>
> index e7fb0d357a..1da1db377e 100644
>
> --- a/fpu/softfloat.c
>
> +++ b/fpu/softfloat.c
>
> @@ -1342,6 +1342,8 @@ static int64_t round_to_int_and_pack(FloatParts in,
>> int rmode,
>
>      switch (p.cls) {
>
>      case float_class_snan:
>
>      case float_class_qnan:
>
> +    case float_class_dnan:
>
> +    case float_class_msnan:
>
>          return max;
>
>      case float_class_inf:
>
>          return p.sign ? min : max;
>
> @@ -1430,6 +1432,8 @@ static uint64_t round_to_uint_and_pack(FloatParts
>> in, int rmode, uint64_t max,
>
>      switch (p.cls) {
>
>      case float_class_snan:
>
>      case float_class_qnan:
>
> +    case float_class_dnan:
>
> +    case float_class_msnan:
>
>          s->float_exception_flags = orig_flags | float_flag_invalid;
>
>          return max;
>
>      case float_class_inf:
>
> --
>
> 2.15.1
>
>
>
