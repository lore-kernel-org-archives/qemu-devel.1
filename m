Received: from eggs.gnu.org ([2001:4830:134:3::10]:49315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzMRU-0003IL-FQ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzMRR-0002zD-8Y
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:36:56 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:57016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dzMRR-0002z3-43
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:36:53 -0400
Received: by mail-ua0-f171.google.com with SMTP id n22so3689777uaj.13
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 05:36:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642400352.3900.13935192906711901682.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642400352.3900.13935192906711901682.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 3 Oct 2017 14:36:51 +0200
Message-ID: <CABdb734KoO5Myps-hA9qkhUDP=XvBtZsVgyB_G=W1+9p5e5j5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 28/43] windbg: implemented
 windbg_read_ks_regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Tue, Sep 26, 2017 at 1:06 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  windbgstub-utils.c |   38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/windbgstub-utils.c b/windbgstub-utils.c
> index 73ff98dfbc..537ba9e2aa 100755
> --- a/windbgstub-utils.c
> +++ b/windbgstub-utils.c
> @@ -587,6 +587,44 @@ static int windbg_write_context(CPUState *cpu, uint8_t *buf, int len,
>  static int windbg_read_ks_regs(CPUState *cpu, uint8_t *buf, int len,
>                                 int offset)
>  {
> +    CPUArchState *env = cpu->env_ptr;
> +    const bool new_mem = (len != sizeof(CPU_KSPECIAL_REGISTERS)
> +                       || offset != 0);
> +    CPU_KSPECIAL_REGISTERS *ckr;
> +    if (new_mem) {
> +        ckr = g_new(CPU_KSPECIAL_REGISTERS, 1);
> +    } else {
> +        ckr = (CPU_KSPECIAL_REGISTERS *) buf;
> +    }
> +
> +    memset(ckr, 0, len);

Buffer overrun on len > sizeof(CPU_KSPECIAL_REGISTERS).

> +    ckr->Cr0 = ldl_p(&env->cr[0]);
> +    ckr->Cr2 = ldl_p(&env->cr[2]);
> +    ckr->Cr3 = ldl_p(&env->cr[3]);
> +    ckr->Cr4 = ldl_p(&env->cr[4]);
> +
> +    ckr->KernelDr0 = ldtul_p(&env->dr[0]);
> +    ckr->KernelDr1 = ldtul_p(&env->dr[1]);
> +    ckr->KernelDr2 = ldtul_p(&env->dr[2]);
> +    ckr->KernelDr3 = ldtul_p(&env->dr[3]);
> +    ckr->KernelDr6 = ldtul_p(&env->dr[6]);
> +    ckr->KernelDr7 = ldtul_p(&env->dr[7]);
> +
> +    ckr->Gdtr.Pad = lduw_p(&env->gdt.selector);
> +    ckr->Idtr.Pad = lduw_p(&env->idt.selector);
> +
> +    ckr->Gdtr.Limit = lduw_p(&env->gdt.limit);
> +    ckr->Gdtr.Base  = ldtul_p(&env->gdt.base);
> +    ckr->Idtr.Limit = lduw_p(&env->idt.limit);
> +    ckr->Idtr.Base  = ldtul_p(&env->idt.base);
> +    ckr->Tr         = lduw_p(&env->tr.selector);
> +    ckr->Ldtr       = lduw_p(&env->ldt.selector);
> +
> +    if (new_mem) {
> +        memcpy(buf, (uint8_t *) ckr + offset, len);
> +        g_free(ckr);
> +    }
>      return 0;
>  }
>
>
