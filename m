Received: from eggs.gnu.org ([208.118.235.92]:38962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezolg-0004iq-Ed
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezofW-0001Dj-RF
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:18:40 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:46282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ezofW-0001D7-JQ
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:17:34 -0400
Received: by mail-ot0-x229.google.com with SMTP id g97-v6so16700414otg.13
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:17:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521915220-65389-15-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<1521915220-65389-15-git-send-email-mjc@sifive.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 12:17:33 -0700
Message-ID: <CAHNT7NuMdMLrJtAD5Z6j=BdUKsRqeB-cJ=9LENwbBom8TAr=5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 26/26] RISC-V: Workaround for critical
 mstatus.FS MTTCG bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: RISC-V Patches <patches@groups.riscv.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Richard W . M . Jones" <rjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Sat, Mar 24, 2018 at 11:13 AM, Michael Clark <mjc@sifive.com> wrote:

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
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/op_helper.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 1fdde90..d345688 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -144,8 +144,23 @@ void csr_write_helper(CPURISCVState *env,
> target_ulong val_to_write,
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
> +           however this may cause unnecessary saves of floating point
> state.
> +           Without this workaround, floating point state is not saved and
> +           restored coorectly when SMP and MTTCG is enabled, */
>

typo in "correctly". I will fix this...


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
> --
> 2.7.0
>
>
