Received: from eggs.gnu.org ([2001:4830:134:3::10]:48415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cYgc8-0007MY-UY
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cYgc5-0006oF-Pa
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:09:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cYgc5-0006o8-Fu
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:09:21 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0VM9Kf4036025
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 17:09:20 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28aycmgd4k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 17:09:20 -0500
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 31 Jan 2017 20:09:17 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 0730E1DC006D
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 17:09:15 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v0VM9DF04214956
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 20:09:13 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v0VM9Dvd007777
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 20:09:13 -0200
Date: Tue, 31 Jan 2017 20:09:08 -0200
From: joserz@linux.vnet.ibm.com
References: <1485744457-10324-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1485744457-10324-2-git-send-email-joserz@linux.vnet.ibm.com>
	<CAFEAcA_juuc1jxnLqE6BFOcROM7uR_UEkY+d1Zrh2b17CiaVjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_juuc1jxnLqE6BFOcROM7uR_UEkY+d1Zrh2b17CiaVjQ@mail.gmail.com>
Message-Id: <20170131220908.GA19075@pacoca>
Subject: Re: [Qemu-devel] [PATCH Risu 1/2] risu_ppc64: Fix Risu to run under
 qemu linux user
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

On Mon, Jan 30, 2017 at 11:49:34AM +0000, Peter Maydell wrote:
> On 30 January 2017 at 02:47, Jose Ricardo Ziviani
> <joserz@linux.vnet.ibm.com> wrote:
> > Qemu linux-user doesn't fill uc_mcontext completely like full emul. does.
> > For instance, uc->uc_mcontext.regs->nip is an invalid so this
> > commit replaces it by uc->uc_mcontext.gp_regs[PT_NIP]
> 
> It's not clear to me from this commit message whether this is
> a bug in QEMU's userspace emulation which this is trying to work
> around (in which case we should just fix it in QEMU), or a
> bug in risu where we were incorrectly relying on something the
> kernel doesn't actually guarantee. Which is it?
> 
> Also, looking at the kernel source and headers as far
> as I can see uc_context.regs is a pointer set up such that
> uc->uc_mcontext.regs->nip is pointing at the same bit of
> memory where uc->uc_mcontext.gp_regs[PT_NIP] is,
> and the QEMU code does similar, so I don't see how you can
> get two different values from the two things.
> 
> (It is certainly the case that risu is quite good at exercising
> odd corner cases of the signal handling code in QEMU which most
> normal programs don't care about...)

Peter

I just sent a patch "linux-user: fill target sigcontext struct accordingly" to fix it in QEMU. Please, forget this patchset, I'll reorganize it and send it later.

Thank you

Ziviani
