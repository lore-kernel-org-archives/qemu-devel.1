Received: from eggs.gnu.org ([2001:4830:134:3::10]:57524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTW1z-0007Vv-L3
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTW1v-0002Ly-Mp
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:22:59 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTW1v-0002Lg-I1
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:22:55 -0400
Received: by mail-qk0-x244.google.com with SMTP id v143so4890654qkb.3
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 09:22:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
	<9645bafa-2c7e-96e8-5f3c-9cf7a9415285@physik.fu-berlin.de>
	<51a3a21f-6145-d721-170f-b8cf20cbc2d9@twiddle.net>
	<313d3f03-f487-4881-5f0a-6dd150f1ebdc@physik.fu-berlin.de>
	<3349c01e-1f1a-2111-28c2-70fb5cc077cd@physik.fu-berlin.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b7f8b2dd-a154-fc14-7be1-1cdbe248d350@twiddle.net>
Date: Fri, 7 Jul 2017 06:22:48 -1000
MIME-Version: 1.0
In-Reply-To: <3349c01e-1f1a-2111-28c2-70fb5cc077cd@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/27] linux-user/sh4: Notice gUSA
 regions during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 07/06/2017 10:35 PM, John Paul Adrian Glaubitz wrote:
> On 07/07/2017 10:30 AM, John Paul Adrian Glaubitz wrote:
>> The scripts which are run here can be found as /var/lib/dpkg/info/tzdata.{config,postinst).
>> I don't know yet which command in particular triggers the crash.
> Interesting. It crashes for me immediately after resizing the terminal window with:
> 
> (sid-sh4-sbuild)root@nofan:/# Unhandled trap: 0x180
> pc=0xf6ffe9fa sr=0x00000101 pr=0x004a73c2 fpscr=0x00080000
> spc=0x00000000 ssr=0x00000000 gbr=0xf6646470 vbr=0x00000000
> sgr=0x00000000 dbr=0x00000000 delayed_pc=0xf6ffea14 fpul=0x00000000
> r0=0xfffffffc r1=0xf6ffea1c r2=0x00000000 r3=0x00000134
> r4=0x00000001 r5=0xf6ffeac0 r6=0x00000000 r7=0x00000000
> r8=0x00000000 r9=0x0041a050 r10=0xf677e4b8 r11=0xf6ffea40
> r12=0xf677ec54 r13=0x00000000 r14=0x0041a0a4 r15=0xf6ffea1c
> r16=0x00000000 r17=0x00000000 r18=0x00000000 r19=0x00000000
> r20=0x00000000 r21=0x00000000 r22=0x00000000 r23=0x00000000
> root@nofan:~>
> 
> I did not enter any commands. Just chrooting into the chroot, the resizing the
> terminal window was enough.

Thanks for the hint.  I've got it now.

The problem is that sh4-linux-user does not limit the page mappings in the same 
way that the sh4 kernel does.  So we begin the program with the stack mapped at 
0xf7xxxxxx, which matches our normal check of 0xc0000000.

I think a more restricted check of -128 -- the most negative value that can be 
placed by mov #imm,sp -- will work and is more appropriate.  Indeed, I assume 
that the only reason the kernel doesn't perform the check that was is having to 
do it all in sh assembly with minimal free registers.


r~
