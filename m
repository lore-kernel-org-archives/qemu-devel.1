Received: from eggs.gnu.org ([2001:4830:134:3::10]:35300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ce5GT-0003t9-9J
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ce5GQ-0007Nu-8A
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:29:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33404
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1ce5GQ-0007NT-2U
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:29:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1FJSgAH042444
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 14:29:16 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28mq9u0tsr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 14:29:15 -0500
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Wed, 15 Feb 2017 17:29:13 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id BA45B1DC006D
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 14:29:12 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1FJT6CK33947884
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 17:29:11 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1FJSpdn030471
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 17:28:51 -0200
Date: Wed, 15 Feb 2017 17:28:37 -0200
From: joserz@linux.vnet.ibm.com
References: <1478452528-13684-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1478452528-13684-5-git-send-email-joserz@linux.vnet.ibm.com>
	<CAFEAcA9SUkpgg-wDON+GtY1nOMohFBadeP7-YqCcsbngzi3GAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9SUkpgg-wDON+GtY1nOMohFBadeP7-YqCcsbngzi3GAg@mail.gmail.com>
Message-Id: <20170215192837.GA19724@pacoca>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, Feb 15, 2017 at 06:50:13PM +0000, Peter Maydell wrote:
> On 6 November 2016 at 17:15, Jose Ricardo Ziviani
> <joserz@linux.vnet.ibm.com> wrote:
> > This library is the initial effort to have PPC64 support for Risu. It
> > implements functions to initialize, compare and print PPC64 registers.
> >
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> 
> Hi; I've been looking at refactoring risu to reduce the huge
> code duplication between the CPU backends, and I noticed this
> weirdness in the PPC code:
> 
> 
> > +/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
> > +int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
> > +{
> 
> > +    for (i = 0; i < 32; i++) {
> > +        if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
> > +                m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
> > +                m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
> > +                m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
> > +
> > +            if (uc != NULL && (m->gregs[CCR] & 0x10)) {
> > +                uc->uc_mcontext.v_regs->vrregs[i][0] = a->vrregs.vrregs[i][0];
> > +                uc->uc_mcontext.v_regs->vrregs[i][1] = a->vrregs.vrregs[i][1];
> > +                uc->uc_mcontext.v_regs->vrregs[i][2] = a->vrregs.vrregs[i][2];
> > +                uc->uc_mcontext.v_regs->vrregs[i][3] = a->vrregs.vrregs[i][3];
> > +                return 1;
> > +            }
> 
> What is this intended to be doing? reginfo_is_eq() should be
> a simple "compare two structures" operation, but here we
> take a ucontext_t* (which is something completely different)
> and modify it. We don't even necessarily have a ucontext_t
> to hand when we're trying to compare reginfo structs...

hmmm, good question, it's certainly something I've done for testing but forgot to remove. I'll send a patch removing it.

Thanks!

> 
> thanks
> -- PMM
> 
