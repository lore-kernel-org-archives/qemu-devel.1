Received: from eggs.gnu.org ([2001:4830:134:3::10]:33135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fYyRi-0004Xu-6S
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fYyRf-0003Wi-3B
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:48:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fYyRe-0003VO-TT
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:48:35 -0400
Date: Fri, 29 Jun 2018 14:48:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180629184832.GB14726@flamenco>
References: <20180614193147.29680-15-richard.henderson@linaro.org>
	<000601d40f7a$4be320b0$e3a96210$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601d40f7a$4be320b0$e3a96210$@ru>
Subject: Re: [Qemu-devel] [PULL,
 14/18] translate-all: discard TB when tb_link_page returns an
 existing matching TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Richard Henderson' <richard.henderson@linaro.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Fri, Jun 29, 2018 at 10:25:03 +0300, Pavel Dovgalyuk wrote:
> This patch breaks record/replay.
> 
> I run execution recording of the WindowsXP machine with the following script:
> 
> ./bin/qemu-system-i386 -d in_asm,exec -D xp_save.log -global apic-common.vapic=off \
>   -icount shift=7,rr=record,rrfile=xp0.replay \
>   -drive file=./images/xp_sp2.qcow2,if=none,id=img-direct,snapshot \
>   -drive driver=blkreplay,if=none,image=img-direct,id=img-replay \
>   -device ide-hd,drive=img-replay -net none -m 512M
> 
> QEMU fails at some moment. Here are the contents of the log:
> 
> ----------------
> IN: 
> 0x806ee2d0:  33 c0                    xorl     %eax, %eax
> 0x806ee2d2:  8a c1                    movb     %cl, %al
> 0x806ee2d4:  33 c9                    xorl     %ecx, %ecx
> 0x806ee2d6:  8a 88 58 e2 6e 80        movb     -0x7f911da8(%eax), %cl
> 0x806ee2dc:  89 0d 80 00 fe ff        movl     %ecx, 0xfffe0080
> 0x806ee2e2:  a1 80 00 fe ff           movl     0xfffe0080, %eax
> 0x806ee2e7:  c3                       retl     
> 
> Trace 0: 0x7fdc103b16a0 [00000000/806ee2d0/0x4000b0]
> qemu: fatal: cpu_io_recompile: could not find TB for pc=0x7fec24fde2de

Thanks for reporting.

>From code inspection I can see how this could happen: we're calling
tcg_tb_remove for a TB that we did not just generate--we got an
existing one instead. Note that CF_NOCACHE is not part of
the CF_HASH mask, so this might explain why the problem only
occurs for r/r.

Can you reproduce this with any other guest? If not, I'd be
happy to use your windows qcow2 file if you could share it
with me off-list.

Thanks,

		Emilio
