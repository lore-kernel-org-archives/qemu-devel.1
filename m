Received: from eggs.gnu.org ([2001:4830:134:3::10]:37763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ee8jN-0005m9-1j
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ee8jI-0007jr-0r
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:15:56 -0500
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:34937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ee8jH-0007il-LS
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:15:51 -0500
Received: by mail-pg0-x234.google.com with SMTP id o13so1450142pgs.2
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 16:15:51 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-7-git-send-email-mjc@sifive.com>
	<f15753f1-7446-26f1-9937-f3b67d15c0a6@linaro.org>
	<CAHNT7NvcUU8D10jaq+y=B2odsD7-r0MnsZRsq2yheY_a-THSUA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <14dcf85d-a8e0-fc21-df46-b94fe48d1067@linaro.org>
Date: Tue, 23 Jan 2018 16:15:47 -0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7NvcUU8D10jaq+y=B2odsD7-r0MnsZRsq2yheY_a-THSUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 06/21] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>, Jim Wilson <jimw@sifive.com>

On 01/23/2018 03:15 PM, Michael Clark wrote:
>     > +uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>     > +                        uint64_t frs3, uint64_t rm)
>     > +{
>     > +    require_fp;
>     > +    set_float_rounding_mode(RM, &env->fp_status);
>     > +    frs1 = float32_muladd(frs1, frs2, frs3 ^ (uint32_t)INT32_MIN, 0,
>     > +                          &env->fp_status);
> 
>     Given that RISC-V always returns a default NaN, you obviously do not care about
>     the sign of a NaN result.  Therefore you should use float_muladd_negate_c as
>     the fourth argument here and not perform the sign flip manually.
> 
> 
> We do care about the sign of NaN results.
> 
> Jim Wilson spotted this bug and removed a call to set_default_nan_mode
> 
> https://github.com/riscv/riscv-qemu/commit/4223d89b0c5c671332d66bcd649db5c6f46559f5

Ok.  Now it depends on what result you care about for madd specifically.

If, like x86 and Power, fmsub returns the (silenced) original input NaN, you
want the float_muladd_* flags.

If, like ARM, fmsub returns the (silenced) negated input NaN, then you do need
to change sign externally.  If this is the case, please use float32_chs instead
of open-coding it with xor.


r~
