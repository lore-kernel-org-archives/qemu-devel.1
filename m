Received: from eggs.gnu.org ([2001:4830:134:3::10]:37751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHuBo-00082M-3D
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHuBl-0002dl-FU
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:21:56 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gHuBk-0002c0-R2
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:21:53 -0400
Received: by mail-pl1-x642.google.com with SMTP id y11-v6so7610156plt.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 10:21:52 -0700 (PDT)
Date: Wed, 31 Oct 2018 10:21:50 -0700 (PDT)
In-Reply-To: <53959ab8-6039-2c43-ccb0-8aafba74820c@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-9a033334-c95a-4c72-8c99-9da50e238de8@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/29] target/riscv: Convert RV32D insns
 to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org

On Wed, 31 Oct 2018 03:44:27 PDT (-0700), Bastian Koppelmann wrote:
>
> On 10/20/18 9:14 AM, Bastian Koppelmann wrote:
> [...]
>> +static bool trans_fclass_d(DisasContext *ctx, arg_fclass_d *a, uint32_t insn)
>> +{
>> +#if defined(TARGET_RISCV64)
>> +    REQUIRE_FPU;
>> +
>> +    TCGv t0 = tcg_temp_new();
>> +    gen_helper_fclass_d(t0, cpu_fpr[a->rs1]);
>> +    gen_set_gpr(a->rd, t0);
>> +    tcg_temp_free(t0);
>> +#else
>> +    gen_exception_illegal(ctx);
>> +#endif
>> +    return true;
>> +}
>
>
> I'm a bit confused here. According to the spec fclass_d is a RV32F
> instruction but according to the original qemu code it is not?

fclass.d is part of the D extension, see section 9.7 of the user spec.  It 
should be present for all base ISAs when the D extension is present.  The above 
code is incorrect, but appears to be trivially fixable.

It looks like master is also incorrect, which I'm somewhat surprised about.  
This might explain a whole host of 32-bit glibc floating-point test suite 
failures...
