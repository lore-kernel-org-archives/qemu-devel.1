Received: from eggs.gnu.org ([2001:4830:134:3::10]:39801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsidS-0004T4-Vp
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 00:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsidP-00058e-Pj
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 00:53:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <53de205c-7c24-426c-129a-7cce7ca67210@amsat.org>
Date: Fri, 15 Sep 2017 01:53:43 -0300
MIME-Version: 1.0
In-Reply-To: <20170914183516.19537-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/10] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

On 09/14/2017 03:35 PM, Richard Henderson wrote:
> As occasionally discussed on this list, due to licensing conflicts,
> we are restricted to a version of libopcodes that pre-dates its
> upstream re-licensing to gplv3.  That makes our copy rather old
> and dated.
> 
> I've already seen this as problematic for s390x guest.  I'm sure
> the same problem exists for Power8+, though I haven't looked.
> As we go forward with vector operations we'll see this for x86 host.
> 
> An alternative is to use a BSD-licensed disassembler:
> 
>    https://www.capstone-engine.org/
> 
> This is an actively maintained project derived from llvm.  Moreover,
> it is already in the major Linux distributions, which makes it easy
> to phase in its use.
> 
> I've arranged the code such that we attempt to use capstone first,
> and if that initialization fails, fall back to the existing code
> from binutils.
> 
> 
> r~
> 
> 
> Richard Henderson (10):
>    target/i386: Convert to disas_set_info hook
>    target/ppc: Convert to disas_set_info hook
>    disas: Remove unused flags arguments
>    disas: Support the Capstone disassembler library
>    target/i386: Support Capstone in disas_set_info
>    target/arm: Support Capstone in disas_set_info
>    target/ppc: Support Capstone in disas_set_info
>    target/s390x: Support Capstone in disas_set_info
>    target/sparc: Support Capstone in disas_set_info
>    target/mips: Support Capstone in disas_set_info

At least this msg disappeared:

"Disassembler disagrees with translator over instruction decoding"

i386 comparison:

  ----------------
  IN:
  0xfffffc30:  cli
-0xfffffc31:  mov    %eax,%ebp
-0xfffffc34:  mov    $0x1,%al
-0xfffffc36:  out    %al,$0x80
-0xfffffc38:  xor    %eax,%eax
+0xfffffc31:  movl         %eax, %ebp
+0xfffffc34:  movb         $1, %al
+0xfffffc36:  outb         %al, $0x80
+0xfffffc38:  xorl         %eax, %eax

  IN:
  0x000fd5b8:  cli
  0x000fd5b9:  cld
-0x000fd5ba:  push   %ds
-0x000fd5bb:  push   %eax
+0x000fd5ba:  pushw        %ds
+0x000fd5bb:  pushl        %eax
-0x000fd5bd:  mov    $0xe000,%eax
-0x000fd5c3:  mov    %ax,%ds
-0x000fd5c5:  mov    0xf2f8,%eax
+0x000fd5bd:  movl         $0xe000, %eax
+0x000fd5c3:  movw         %ax, %ds
+0x000fd5c5:  movl         0xf2f8, %eax
+0x000fd5c9:  subl         $0x28, %eax
-0x000fd5c9:  sub    $0x28,%eax
+0x000fd5cd:  popl         0x1c(%eax)
+0x000fd5d2:  popw         (%eax)
-0x000fd5cd:  addr32 popl 0x1c(%eax)
-0x000fd5d2:  addr32 popw (%eax)

For i386, arm, mips32/64:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

This series but patch 4/10:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
