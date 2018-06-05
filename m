Received: from eggs.gnu.org ([2001:4830:134:3::10]:52878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fQFyZ-0006FP-CJ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fQFyW-0003BA-9G
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:42:31 -0400
Received: from mail-by2nam01on0067.outbound.protection.outlook.com
	([104.47.34.67]:43819
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1fQFyV-0003Ak-JQ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:42:28 -0400
From: Edgar Iglesias <edgari@xilinx.com>
Date: Tue, 5 Jun 2018 17:42:22 +0000
Message-ID: <l2atfaoxbakjm4lkr6fpijgm.1528220631723@email.android.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
	<20180529105011.1914-28-edgar.iglesias@gmail.com>,
	<CAFEAcA9PQV8toYAFxHUA7cwre64FGPVuTwCiUPROocKyMU2NWA@mail.gmail.com>
In-Reply-To: <CAFEAcA9PQV8toYAFxHUA7cwre64FGPVuTwCiUPROocKyMU2NWA@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 27/38] target-microblaze: mmu: Add a
 configurable output address mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi,

Sorry for top post. This was my fuck up. The second assignment should go aw=
ay. I'll send out a fix later.

Thanks,
Edgar


---
Sent from my phone


-------- Original Message --------
Subject: Re: [PULL v1 27/38] target-microblaze: mmu: Add a configurable out=
put address mask
From: Peter Maydell <peter.maydell@linaro.org>
Date: Jun 4, 2018, 20:15
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
On 29 May 2018 at 11:50, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote=
:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add a configurable output address mask, used to mimic the
> configurable physical address bit width.
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/cpu.c | 1 +
>  target/microblaze/mmu.c | 1 +
>  target/microblaze/mmu.h | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 6ee15ac800..71fc8d09fe 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -128,6 +128,7 @@ static void mb_cpu_reset(CPUState *s)
>      env->mmu.c_mmu =3D 3;
>      env->mmu.c_mmu_tlb_access =3D 3;
>      env->mmu.c_mmu_zones =3D 16;
> +    env->mmu.c_addr_mask =3D MAKE_64BIT_MASK(0, cpu->cfg.addr_size);
>  #endif
>  }
>
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index a379968618..166c79908c 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -164,6 +164,7 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu=
,
>              tlb_rpn =3D d & TLB_RPN_MASK;
>
>              lu->vaddr =3D tlb_tag;
> +            lu->paddr =3D tlb_rpn & mmu->c_addr_mask;
>              lu->paddr =3D tlb_rpn;
>              lu->size =3D tlb_size;
>              lu->err =3D ERR_HIT;

Coverity points out (CID 1391441) that the line added here
has no effect, because we immediately overwrite lu->paddr in
the following line. What was the intention here ?

thanks
-- PMM
