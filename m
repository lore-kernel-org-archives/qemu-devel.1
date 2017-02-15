Received: from eggs.gnu.org ([2001:4830:134:3::10]:49170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ce4ez-0003pF-AO
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ce4ey-00050y-0q
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:50:37 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ce4ex-00050V-Q3
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:50:35 -0500
Received: by mail-wm0-x22c.google.com with SMTP id v77so47721460wmv.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 10:50:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478452528-13684-5-git-send-email-joserz@linux.vnet.ibm.com>
References: <1478452528-13684-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1478452528-13684-5-git-send-email-joserz@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Feb 2017 18:50:13 +0000
Message-ID: <CAFEAcA9SUkpgg-wDON+GtY1nOMohFBadeP7-YqCcsbngzi3GAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH Risu v2 4/9] Implement lib to deal with
 PPC64 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 November 2016 at 17:15, Jose Ricardo Ziviani
<joserz@linux.vnet.ibm.com> wrote:
> This library is the initial effort to have PPC64 support for Risu. It
> implements functions to initialize, compare and print PPC64 registers.
>
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

Hi; I've been looking at refactoring risu to reduce the huge
code duplication between the CPU backends, and I noticed this
weirdness in the PPC code:


> +/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
> +int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
> +{

> +    for (i = 0; i < 32; i++) {
> +        if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
> +                m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
> +                m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
> +                m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
> +
> +            if (uc != NULL && (m->gregs[CCR] & 0x10)) {
> +                uc->uc_mcontext.v_regs->vrregs[i][0] = a->vrregs.vrregs[i][0];
> +                uc->uc_mcontext.v_regs->vrregs[i][1] = a->vrregs.vrregs[i][1];
> +                uc->uc_mcontext.v_regs->vrregs[i][2] = a->vrregs.vrregs[i][2];
> +                uc->uc_mcontext.v_regs->vrregs[i][3] = a->vrregs.vrregs[i][3];
> +                return 1;
> +            }

What is this intended to be doing? reginfo_is_eq() should be
a simple "compare two structures" operation, but here we
take a ucontext_t* (which is something completely different)
and modify it. We don't even necessarily have a ucontext_t
to hand when we're trying to compare reginfo structs...

thanks
-- PMM
