Received: from eggs.gnu.org ([2001:4830:134:3::10]:45044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drs3A-0007Yu-5d
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drs35-0004FX-U6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:44:52 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:33185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drs35-0004Ex-Qe
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:44:47 -0400
Received: by mail-qt0-x229.google.com with SMTP id i50so28406363qtf.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 13:44:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-8-richard.henderson@linaro.org>
	<d1f97f10-921e-1c50-9407-2007b1cbe169@amsat.org>
Message-ID: <e4f3dabd-8bc3-b8ad-a3db-6dac103a3f66@amsat.org>
Date: Tue, 12 Sep 2017 17:44:43 -0300
MIME-Version: 1.0
In-Reply-To: <d1f97f10-921e-1c50-9407-2007b1cbe169@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/16] target/arm: Align vector registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

>> -        float64 regs[64];
>> +        float64 regs[64] __attribute__((aligned(16)));
> 
> I understand this should be aligned to the biggest vector register the 
> host support, i.e. for AVX-512 this would be QEMU_ALIGNED(64), is it 
> correct?
> 

checking datashits:

"INTEL® ADVANCED VECTOR EXTENSIONS"

2.5 MEMORY ALIGNMENT

With the exception of explicitly aligned 16 or 32 byte SIMD load/store 
instructions, most VEX-encoded, arithmetic and data processing 
instructions operate in a flexible environment regarding memory address 
alignment, i.e. VEX-encoded instruction with 32-byte or 16-byte load 
semantics will support unaligned load operation by default. Memory 
arguments for most instructions with VEX prefix operate normally without 
causing #GP(0) on any byte-granularity alignment (unlike Legacy SSE 
instructions). The instructions that require explicit memory alignment 
requirements are listed in Table 2-4.

Table 2-4. Instructions Requiring Explicitly Aligned Memory

Require 32-byte alignment:
   VMOVDQA ymm, m256
   VMOVDQA m256, ymm
   VMOVAPS ymm, m256
   VMOVAPS m256, ymm
   VMOVAPD ymm, m256
   VMOVAPD m256, ymm
   VMOVNTPS m256, ymm
   VMOVNTPD m256, ymm
   VMOVNTDQ m256, ymm
   VMOVNTDQA ymm, m256

General Protection, #GP(0):
   VEX.256: Memory operand is not 32-byte aligned
   VEX.128: Memory operand is not 16-byte aligned
   Legacy SSE: Memory operand is not 16-byte aligned

--

"Intel® Architecture Instruction Set Extensions Programming Reference"

2.6 MEMORY ALIGNMENT

Memory alignment requirements on EVEX-encoded SIMD instructions are 
similar to VEX-encoded SIMD instructions. Memory alignment applies to 
EVEX-encoded SIMD instructions in three categories:
• Explicitly-aligned SIMD load and store instructions accessing 64 bytes 
of memory with EVEX prefix encoded vector length of 512 bits (e.g., 
VMOVAPD, VMOVAPS, VMOVDQA, etc.). These instructions always require
memory address to be aligned on 64-byte boundary.
• Explicitly-unaligned SIMD load and store instructions accessing 64 
bytes or less of data from memory (e.g. VMOVUPD, VMOVUPS, VMOVDQU, 
VMOVQ, VMOVD, etc.). These instructions do not require memory address
to be aligned on natural vector-length byte boundary.
• Most arithmetic and data processing instructions encoded using EVEX 
support memory access semantics. When these instructions access from 
memory, there are no alignment restrictions.
[...]
AVX-512 instructions may generate an #AC(0) fault on misaligned 4 or 
8-byte memory references in Ring-3 when CR0.AM=1. 16, 32 and 64-byte 
memory references will not generate #AC(0) fault. See Table 2-7 for details.
Certain AVX-512 Foundation instructions always require 64-byte alignment 
(see the complete list of VEX and EVEX encoded instructions in Table 
2-6). These instructions will #GP(0) if not aligned to 64-byte boundaries.
