Received: from eggs.gnu.org ([2001:4830:134:3::10]:42095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eiopF-0006o3-G5
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 17:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eiopE-0006Dj-Ag
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 17:01:21 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:44478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eiopE-0006DH-1g
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 17:01:20 -0500
Received: by mail-oi0-x230.google.com with SMTP id b3so19393874oib.11
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 14:01:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ce17e6a5-7e22-a73e-36f5-89c81bcb60a6@linaro.org>
References: <1517811767-75958-1-git-send-email-mjc@sifive.com>
	<1517811767-75958-6-git-send-email-mjc@sifive.com>
	<ce17e6a5-7e22-a73e-36f5-89c81bcb60a6@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 6 Feb 2018 11:01:18 +1300
Message-ID: <CAHNT7NsoC36h9nT5E_GLb5WzQ8ga4uc5waKHvFo5hMzQqnqbNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 06/22] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Tue, Feb 6, 2018 at 3:01 AM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 02/04/2018 10:22 PM, Michael Clark wrote:
> > +uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t
> frs2,
> > +                        uint64_t frs3)
> > +{
> > +    return float32_muladd(frs1, frs2, frs3 ^ (uint32_t)INT32_MIN, 0,
> > +                          &env->fp_status);
>
> Missing the requested change to use float32_chs or
> float_muladd_negate_product
> et al throughout the fma family of helpers.
>
> Probably float_muladd_* since you've re-enabled default_nan_mode.


I'll go through your comments again. I wasn't sure whether you had some of
these changes in your tree

I was previously a little hesitant about change floating point stuff but
now i've got riscv-tests running i'm less worried.

We are currently failing several floating point tests.

rv64ua-v-amoadd_d
rv64ua-v-amoadd_w
rv64ua-v-amoand_d
rv64ua-v-amoand_w
rv64ua-v-amomax_d
rv64ua-v-amomax_w
rv64ua-v-amomaxu_d
rv64ua-v-amomaxu_w
rv64ua-v-amomin_d
rv64ua-v-amomin_w
rv64ua-v-amominu_d
rv64ua-v-amominu_w
rv64ua-v-amoor_d
rv64ua-v-amoor_w
rv64ua-v-amoswap_d
rv64ua-v-amoswap_w
rv64ua-v-amoxor_d
rv64ua-v-amoxor_w
rv64ua-v-lrsc
rv64uc-v-rvc
rv64ud-v-fadd
rv64ud-v-fclass
rv64ud-v-fcmp
rv64ud-v-fcvt
rv64ud-v-fcvt_w
rv64ud-v-fdiv
rv64ud-v-fmadd
rv64ud-v-fmin
*** FAILED *** (tohost = 20
)rv64ud-v-ldst
*** FAILED *** (tohost = 6)
rv64ud-v-move
*** FAILED *** (tohost = 40)
rv64ud-v-recoding
rv64ud-v-structural
rv64uf-v-fadd
rv64uf-v-fclass
rv64uf-v-fcmp
rv64uf-v-fcvt
rv64uf-v-fcvt_w
rv64uf-v-fdiv
rv64uf-v-fmadd
rv64uf-v-fmin
*** FAILED *** (tohost = 20)
rv64uf-v-ldst
rv64uf-v-move
rv64uf-v-recoding
rv64ui-v-add
rv64ui-v-addi
rv64ui-v-addiw
rv64ui-v-addw
rv64ui-v-and
rv64ui-v-andi
rv64ui-v-auipc
rv64ui-v-beq
rv64ui-v-bge
rv64ui-v-bgeu
rv64ui-v-blt
rv64ui-v-bltu
rv64ui-v-bne
rv64ui-v-fence_i
rv64ui-v-jal
rv64ui-v-jalr
rv64ui-v-lb
rv64ui-v-lbu
rv64ui-v-ld
rv64ui-v-lh
rv64ui-v-lhu
rv64ui-v-lui
rv64ui-v-lw
rv64ui-v-lwu
rv64ui-v-or
rv64ui-v-ori
rv64ui-v-sb
rv64ui-v-sd
rv64ui-v-sh
rv64ui-v-simple
rv64ui-v-sll
rv64ui-v-slli
rv64ui-v-slliw
rv64ui-v-sllw
rv64ui-v-slt
rv64ui-v-slti
rv64ui-v-sltiu
rv64ui-v-sltu
rv64ui-v-sra
rv64ui-v-srai
rv64ui-v-sraiw
rv64ui-v-sraw
rv64ui-v-srl
rv64ui-v-srli
rv64ui-v-srliw
rv64ui-v-srlw
rv64ui-v-sub
rv64ui-v-subw
rv64ui-v-sw
rv64ui-v-xor
rv64ui-v-xori
rv64um-v-div
rv64um-v-divu
rv64um-v-divuw
rv64um-v-divw
rv64um-v-mul
rv64um-v-mulh
rv64um-v-mulhsu
rv64um-v-mulhu
rv64um-v-mulw
rv64um-v-rem
rv64um-v-remu
rv64um-v-remuw
rv64um-v-remw
