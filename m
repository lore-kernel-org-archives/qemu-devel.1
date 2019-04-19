Received: from eggs.gnu.org ([209.51.188.92]:43019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hHcYu-0005mp-T2
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hHcYt-0005Ec-Oj
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:04:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hHcYt-0005EH-BS
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:04:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id o25so7555223wmf.5
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:04:51 -0700 (PDT)
References: <20190419103722.17062-1-shahab.vahedi@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190419103722.17062-1-shahab.vahedi@gmail.com>
Date: Fri, 19 Apr 2019 23:04:48 +0000
Message-ID: <871s1xha0f.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Shahab Vahedi <shahab.vahedi@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Shahab Vahedi <shahab.vahedi@gmail.com> writes:

> This change adapts io_readx() to its input access_type. Currently
> io_readx() treats any memory access as a read, although it has an
> input argument "MMUAccessType access_type". This results in:
>
> 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> 2) Considering only entry->addr_read as the tlb_addr
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1825359

This bug talks about the distinction between DATA_LOAD and INST_FETCH but...

>
> Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> ---
>  accel/tcg/cputlb.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 88cc8389e9..0daac0e806 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -878,10 +878,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTL=
BEntry *iotlbentry,
>          CPUTLBEntry *entry;
>          target_ulong tlb_addr;
>
> -        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
> +        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
>
>          entry =3D tlb_entry(env, mmu_idx, addr);
> -        tlb_addr =3D entry->addr_read;
> +        tlb_addr =3D
> +            (access_type =3D=3D MMU_DATA_LOAD ) ? entry->addr_read  :
> +            (access_type =3D=3D MMU_DATA_STORE) ? entry->addr_write :
> +            entry->addr_code;

...why do we care here about MMU_DATA_STORE?

We could just assert (access_type =3D=3D MMU_DATA_LOAD || access_type =3D=3D
MMU_INST_FETCH) and then have:

  (access_type =3D=3D MMU_DATA_LOAD ) ? entry->addr_read  : entry->addr_code


>          if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
>              /* RAM access */
>              uintptr_t haddr =3D addr + entry->addend;


--
Alex Benn=C3=A9e
