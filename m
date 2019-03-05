Received: from eggs.gnu.org ([209.51.188.92]:47436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h18no-0004x5-HB
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h18nn-0001jr-Ep
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:04:08 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:52524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h18nn-0001eW-7K
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:04:07 -0500
Received: by mail-wm1-f42.google.com with SMTP id f65so2298488wma.2
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 04:04:06 -0800 (PST)
References: <1551733750-4902-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1551733750-4902-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8acd73e1-219f-b5f7-e001-6f6dd086171d@redhat.com>
Date: Tue, 5 Mar 2019 13:04:04 +0100
MIME-Version: 1.0
In-Reply-To: <1551733750-4902-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 02/14] disas: nanoMIPS: Add graphical
 description of pool organization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 3/4/19 10:08 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Add graphical description of nanoMIPS instruction pool organization.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  disas/nanomips.cpp | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
> index 10f6d96..9b44208 100644
> --- a/disas/nanomips.cpp
> +++ b/disas/nanomips.cpp
> @@ -16592,6 +16592,108 @@ std::string NMD::YIELD(uint64 instruction)
>  
>  
>  
> +/*
> + *                nanoMIPS instruction pool organization
> + *                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *
> + *                 ┌─ P.ADDIU ─── P.RI ─── P.SYSCALL
> + *                 │
> + *                 │                                      ┌─ P.TRAP
> + *                 │                                      │
> + *                 │                      ┌─ _POOL32A0_0 ─┼─ P.CMOVE
> + *                 │                      │               │
> + *                 │                      │               └─ P.SLTU
> + *                 │        ┌─ _POOL32A0 ─┤
> + *                 │        │             │
> + *                 │        │             │
> + *                 │        │             └─ _POOL32A0_1 ─── CRC32
> + *                 │        │
> + *                 ├─ P32A ─┤
> + *                 │        │                           ┌─ PP.LSX
> + *                 │        │             ┌─ P.LSX ─────┤
> + *                 │        │             │             └─ PP.LSXS
> + *                 │        └─ _POOL32A7 ─┤
> + *                 │                      │             ┌─ POOL32Axf_4
> + *                 │                      └─ POOL32Axf ─┤
> + *                 │                                    └─ POOL32Axf_5
> + *                 │
> + *                 ├─ PBAL
> + *                 │
> + *                 ├─ P.GP.W   ┌─ PP.LSX
> + *         ┌─ P32 ─┤           │
> + *         │       ├─ P.GP.BH ─┴─ PP.LSXS
> + *         │       │
> + *         │       ├─ P.J ─────── PP.BALRSC
> + *         │       │
> + *         │       ├─ P48I
> + *         │       │           ┌─ P.SR
> + *         │       │           │
> + *         │       │           ├─ P.SHIFT
> + *         │       │           │
> + *         │       ├─ P.U12 ───┼─ P.ROTX
> + *         │       │           │
> + *         │       │           ├─ P.INS
> + *         │       │           │
> + *         │       │           └─ P.EXT
> + *         │       │
> + *         │       ├─ P.LS.U12 ── P.PREF.U12
> + *         │       │
> + *         │       ├─ P.BR1 ───── P.BR3A
> + *         │       │
> + *         │       │           ┌─ P.LS.S0 ─── P16.SYSCALL
> + *         │       │           │
> + *         │       │           │           ┌─ P.LL
> + *         │       │           ├─ P.LS.S1 ─┤
> + *         │       │           │           └─ P.SC
> + *         │       │           │
> + *         │       │           │           ┌─ P.PREFE
> + *  MAJOR ─┤       ├─ P.LS.S9 ─┤           │
> + *         │       │           ├─ P.LS.E0 ─┼─ P.LLE
> + *         │       │           │           │
> + *         │       │           │           └─ P.SCE
> + *         │       │           │
> + *         │       │           ├─ P.LS.WM
> + *         │       │           │
> + *         │       │           └─ P.LS.UAWM
> + *         │       │
> + *         │       │
> + *         │       ├─ P.BR2
> + *         │       │
> + *         │       ├─ P.BRI
> + *         │       │
> + *         │       └─ P.LUI
> + *         │
> + *         │
> + *         │       ┌─ P16.MV ──── P16.RI ─── P16.SYSCALL
> + *         │       │
> + *         │       ├─ P16.SR
> + *         │       │
> + *         │       ├─ P16.SHIFT
> + *         │       │
> + *         │       ├─ P16.4x4
> + *         │       │
> + *         │       ├─ P16C ────── POOL16C_0 ── POOL16C_00
> + *         │       │
> + *         └─ P16 ─┼─ P16.LB
> + *                 │
> + *                 ├─ P16.A1
> + *                 │
> + *                 ├─ P16.LH
> + *                 │
> + *                 ├─ P16.A2 ──── P.ADDIU[RS5]
> + *                 │
> + *                 ├─ P16.ADDU
> + *                 │
> + *                 └─ P16.BR ──┬─ P16.JRC
> + *                             │
> + *                             └─ P16.BR1

Nice ASCII tree! And you got it fits the 80 chars per line limit =)

> + *
> + *
> + *  (FP, DPS, and some minor instruction pools are omitted from the diagram)
> + *
> + */
> +
>  NMD::Pool NMD::P_SYSCALL[2] = {
>      { instruction         , 0                   , 0   , 32,
>         0xfffc0000, 0x00080000, &NMD::SYSCALL_32_      , 0,
> 
