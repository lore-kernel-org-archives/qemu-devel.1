Received: from eggs.gnu.org ([2001:4830:134:3::10]:44207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1f10Vy-0000o3-5b
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1f10Vu-0001wO-6n
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:08:38 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1f10Vu-0001w6-0P
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:08:34 -0400
Received: by mail-pl0-x242.google.com with SMTP id m22-v6so649919pls.5
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 19:08:33 -0700 (PDT)
Date: Tue, 27 Mar 2018 19:08:32 -0700 (PDT)
In-Reply-To: <1522180487-22899-2-git-send-email-mjc@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-5a16f222-68a9-4ed1-9d09-53ef07c6aa19@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [patches] [PATCH v1 1/1] RISC-V: Workaround for
 critical mstatus.FS MTTCG bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, peter.maydell@linaro.org

On Tue, 27 Mar 2018 12:54:47 PDT (-0700), Michael Clark wrote:
> This change is a workaround for a bug where mstatus.FS
> is not correctly reporting dirty when MTTCG and SMP are
> enabled which results in the floating point register file
> not being saved during context switches. This a critical
> bug for RISC-V in QEMU as it results in floating point
> register file corruption when running SMP Linux in the
> RISC-V 'virt' machine.
>
> This workaround will return dirty if mstatus.FS is
> switched from off to initial or clean. We have checked
> the specification and it is legal for an implementation
> to return either off, or dirty, if set to initial or clean.
>
> This workaround will result in unnecessary floating point
> save restore. When mstatus.FS is off, floating point
> instruction trap to indicate the process is using the FPU.
> The OS can then save floating-point state of the previous
> process using the FPU and set mstatus.FS to initial or
> clean. With this workaround, mstatus.FS will always return
> dirty if set to a non-zero value, indicating floating point
> save restore is necessary, versus misreporting mstatus.FS
> resulting in floating point register file corruption.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/op_helper.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index e34715d..7281b98 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -144,8 +144,23 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
>          }
>
>          mstatus = (mstatus & ~mask) | (val_to_write & mask);
> -        int dirty = (mstatus & MSTATUS_FS) == MSTATUS_FS;
> -        dirty |= (mstatus & MSTATUS_XS) == MSTATUS_XS;
> +
> +        /* Note: this is a workaround for an issue where mstatus.FS
> +           does not report dirty when SMP and MTTCG is enabled. This
> +           workaround is technically compliant with the RISC-V Privileged
> +           specification as it is legal to return only off, or dirty,
> +           however this may cause unnecessary saves of floating point state.
> +           Without this workaround, floating point state is not saved and
> +           restored correctly when SMP and MTTCG is enabled, */
> +        if (qemu_tcg_mttcg_enabled()) {
> +            /* FP is always dirty or off */
> +            if (mstatus & MSTATUS_FS) {
> +                mstatus |= MSTATUS_FS;
> +            }
> +        }
> +
> +        int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
> +                    ((mstatus & MSTATUS_XS) == MSTATUS_XS);
>          mstatus = set_field(mstatus, MSTATUS_SD, dirty);
>          env->mstatus = mstatus;
>          break;

FWIW, this isn't just "technically compliant with the RISC-V Privileged 
specification" but it's actually an intended design point.  We're considering 
making this a bit more explicit in the ISA manual -- well, unless Andrew 
decides I'm being too pedantic in one of my possible readings of the spec :).

Reviewed-By: Palmer Dabbelt <palmer@sifive.com>
