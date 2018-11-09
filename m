Received: from eggs.gnu.org ([2001:4830:134:3::10]:60905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gL8D9-0006cS-QA
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gL8D6-0002Ty-HW
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:56:39 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:35865)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gL8D5-0002OK-Gv
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:56:35 -0500
References: <cover.1541701393.git.noring@nocrew.org>
	<39b6a168-22ef-21cc-ae2a-0ce1c3dac5a5@vivier.eu>
	<alpine.LFD.2.21.1811091403450.27920@eddie.linux-mips.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8aee2864-4fb1-73e8-42d0-44598e663ac2@vivier.eu>
Date: Fri, 9 Nov 2018 15:56:12 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1811091403450.27920@eddie.linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Fredrik Noring <noring@nocrew.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

On 09/11/2018 15:14, Maciej W. Rozycki wrote:
> On Fri, 9 Nov 2018, Laurent Vivier wrote:
> 
>> if you have time, o32 & n32 support needs to be reworked.
>>
>> We have two binaries qemu-mips and qemu-mipsn32 sharing the same ELF
>> mask/magic.
>>
>> As n32 identifies a kernel ABI version, we should have only one binary
>> for qemu-mips and qemu-mipsn32 and the ABI version should be identified
>> at runtime as it is done for ARM:
>>
>>   ce4defa062 Arm Linux EABI syscall support.
> 
>  Are you sure?  So is the ARM ABI handled with ce4defa062 64-bit?

I'm sure of nothing. It's why it's better if someone involved in mips
development has an opinion on it :)

>  The o32 ABI is 32-bit (32-bit GPR width) while n32 is 64-bit (64-bit GPR 
> width).  The correspondence between the i386 ABI and the x86-64 x32 ABI is 
> analogous to these two ABIs.
>  How are these x86 ABIs handled WRT the user emulation mode; are they 
> analogous to the ARM ABIs you've mentioned?
> 
>> [I think we can use e_flags for that]
> 
>  The EF_MIPS_ABI2 `e_flags' bit denotes the n32 ABI.  The container format 
> is ELF32 obviously, because addressing is 32-bit with n32.

OK, I understand better. It looks like qemu-sparc32plus or qemu-ppc64abi32.
If this is the case, you're right we need different binaries.

>> I never did the change because I don't know where to find mipsn32
>> binaries to test my changes.
> 
>  I believe MIPS64 Debian is all n32.

Some readelf results:

mips64el/stretch

  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:   ELF64
  Flags:   0x80000007, noreorder, pic, cpic, mips64r2

mipsel/stretch

  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:   ELF32
  Flags:   0x70001007, noreorder, pic, cpic, o32, mips32r2

mips/stretch/bin

  Magic:   7f 45 4c 46 01 02 01 00 00 00 00 00 00 00 00 00
  Class:   ELF32
  Flags:   0x70001007, noreorder, pic, cpic, o32, mips32r2

So 32bit mips are all o32, 64bit is n32.

Are there any distros that are 32bit but n32?
Any binaries that need qemu-mipsn32 or qemu-mipsn32el?

Thanks,
Laurent
