Received: from eggs.gnu.org ([2001:4830:134:3::10]:57050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gMMFY-0000Zj-Cz
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 19:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gMM5m-0002VQ-26
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 18:58:10 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:33768
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gMM5l-0002Uo-Oy
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 18:58:05 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23991783AbeKLX4i7iNT6 (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Tue, 13 Nov 2018 00:56:38 +0100
Date: Mon, 12 Nov 2018 23:56:38 +0000 (GMT)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.1811091618230.27920@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1811122327290.9637@eddie.linux-mips.org>
References: <cover.1541701393.git.noring@nocrew.org>
	<39b6a168-22ef-21cc-ae2a-0ce1c3dac5a5@vivier.eu>
	<alpine.LFD.2.21.1811091403450.27920@eddie.linux-mips.org>
	<8aee2864-4fb1-73e8-42d0-44598e663ac2@vivier.eu>
	<alpine.LFD.2.21.1811091618230.27920@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user/mips: Support the n32 ABI
 for the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Fredrik Noring <noring@nocrew.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

On Fri, 9 Nov 2018, Maciej W. Rozycki wrote:

> > Some readelf results:
> > 
> > mips64el/stretch
> > 
> >   Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
> >   Class:   ELF64
> >   Flags:   0x80000007, noreorder, pic, cpic, mips64r2
> 
>  Hmm, that's weird -- what executable did you check?  There may be some 
> that are n64, or maybe they've switched (which I would applaud, FWIW).  I 
> remember seeing mostly n32, with minimal support for n64, but that was a 
> while ago -- jessie or suchlike, I believe.  Using MIPS64r2 as the base 
> ISA also looks new to me, that used to be plain MIPS III, and some of 
> Debian's MIPS build systems used to be either MIPS III (Lemote Loongson) 
> or MIPS64r1 (Broadcom SiByte).

 OK, I definitely got this confused.  I did some checking and jessie 
didn't even have a 64-bit MIPS port.  I got their build systems right 
though, and the kernel is 64-bit for systems that support it.

> > Any binaries that need qemu-mipsn32 or qemu-mipsn32el?
> 
>  I'd expect at least the n32 dynamic loader (along with libc and some 
> other essential DSOs) to be present with MIPS64 Debian.  Traditionally, 
> under the FHS rules, it would be installed as /lib32/ld.so.1 (with the o32 
> one as /lib/ld.so.1 and the n64 as /lib64/ld.so.1), but Debian uses their 
> own multiarch filesystem layout standard, and offhand I don't remember 
> what the paths are defined to there.

 So with jessie you can install the `libc6-dev-mipsn32' package, which 
will get you n32 glibc development libraries and will pull the 
complementing n32 dynamic loader (at /lib32/ld.so.1 actually) and n32 
glibc shared libraries as well.

 Unfortunately multilib support files, such as the CRT files, seem to be 
missing from GCC for n32 or I cannot find them.  Otherwise you would be 
able to compile and link n32 binaries just by calling `gcc -mabi=n32'.  
Still the dynamic loader is directly runnable, as I noted above.

 HTH,

  Maciej
