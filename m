Received: from eggs.gnu.org ([209.51.188.92]:58333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0K-0007Zj-Ng
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0J-0007Aj-KU
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:24 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0J-000795-CW
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:23 -0400
Received: by mail-ot1-x342.google.com with SMTP id f10so6987339otb.6
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:22 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
Date: Mon,  8 Apr 2019 14:27:43 -0400
Message-Id: <20190408182748.1238-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 0/5] Fix RISU build for i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Bobek <jan.bobek@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Hi all,

here's a patch series that tries to fix the (currently broken) build
of RISU for i386. With the patches applied, I am able to successfully
cross-compile and run RISU for i386 on my x86_64 laptop running Debian
10 with:

$ CC='cc -m32 -std=c99' LD='ld -m32' AS='nasm -f elf32' ARCH=i386 ./configure
$ make
$ ./risu --master --trace test_i386.trace test_i386.bin
$ ./risu --trace test_i386.trace test_i386.bin

There's a couple of points that I'd like to mention/highlight:

1. Most of it is just moving stuff around, however I've implemented
   reginfo_dump_mismatch (based on reginfo_dump and code in other
   architectures) and defined EAX as the param register. There is no
   support for more registers yet, that will need to be added later.

2. Note the '-std=c99' switch in the command-line above; without it,
   GCC defines the symbol 'i386' to 1 and the preprocessor magic for
   including arch-specific headers in risu.h breaks. Does anyone have
   an idea how to fix this in a more robust way?

3. gas (the GNU assembler) chokes on the syntax of test_i386.s; that's
   why I'm using nasm as the assembler above. Is that intentional? I
   haven't found the nasm dependency mentioned anywhere.

   Also, nasm will happily emit the UD1 opcode (0F B9) with no
   operands (see test_i386.s). That's a bit surprising to me, since
   Intel's Software Developer's Manual says UD1 has two operands; I'd
   expect at least a follow-up ModR/M byte. gas refuses to assemble
   UD1 with no operands, and gdb's disassembler gets confused when I
   load up the nasm's binary into risu. Is there something obvious
   that I'm missing?

Thanks,
-Jan Bobek

P.S. This is my first time using git send-email, so please bear with
     me if something goes wrong and/or let me know how I can improve
     my future submissions. Thank you!

Jan Bobek (5):
  risu_i386: move reginfo_t and related defines to risu_reginfo_i386.h
  risu_i386: move reginfo-related code to risu_reginfo_i386.c
  risu_reginfo_i386: implement arch-specific reginfo interface
  risu_i386: implement missing CPU-specific functions
  risu_i386: remove old unused code

 risu_i386.c         | 140 ++++++--------------------------------------
 risu_reginfo_i386.c | 104 ++++++++++++++++++++++++++++++++
 risu_reginfo_i386.h |  38 ++++++++++++
 3 files changed, 160 insertions(+), 122 deletions(-)
 create mode 100644 risu_reginfo_i386.c
 create mode 100644 risu_reginfo_i386.h

-- 
2.20.1
