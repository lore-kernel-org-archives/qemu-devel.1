Received: from eggs.gnu.org ([2001:4830:134:3::10]:36331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dUhvi-00034c-Pk
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dUhvh-0007Lk-JY
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:17:26 -0400
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:36237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ricardo.ribalda@gmail.com>)
	id 1dUhvh-0007K9-DI
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:17:25 -0400
Received: by mail-it0-x235.google.com with SMTP id m68so48306138ith.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 16:17:21 -0700 (PDT)
MIME-Version: 1.0
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 11 Jul 2017 01:17:00 +0200
Message-ID: <CAPybu_28Fi-QEpoCP2APs+FdEuEOmSJnEK==ubJimE907-WLYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu-x86_64: Error processing bextr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Blue Swirl <blauwirbel@gmail.com>, Richard Henderson <rth@twiddle.net>

Hi

I have the following   assembly snipset (from get_common_indeces in
glibc compiled with gcc 6.3 -march=bdver4)

   0x00000040008179b3 <+19>: 89 15 8b c3 20 00 mov
%edx,0x20c38b(%rip)        # 0x4000a23d44 <_rtld_local_ro+132>
   0x00000040008179b9 <+25>: 89 1d 7d c3 20 00 mov
%ebx,0x20c37d(%rip)        # 0x4000a23d3c <_rtld_local_ro+124>
   0x00000040008179bf <+31>: 8f ea 78 10 d0 08 04 00 00 bextr  $0x408,%eax,%edx
   0x00000040008179c8 <+40>: 89 0d 72 c3 20 00 mov
%ecx,0x20c372(%rip)        # 0x4000a23d40 <_rtld_local_ro+128>
   0x00000040008179ce <+46>: 89 05 64 c3 20 00 mov
%eax,0x20c364(%rip)        # 0x4000a23d38 <_rtld_local_ro+120>


When I run the application using qemu-x86-64, the instruction bextr is
not understood by the emulator and results in a SIGSEGV, because it
runs:

0x00000040008179b9: mov    %ebx,0x20c37d(%rip)        # 0x4000a23d3c
0x00000040008179bf: (bad)
0x00000040008179c0: (bad)
0x00000040008179c1: js     0x40008179d3
0x00000040008179c3: rorb   (%rax)


It seems that, bextr is not supported by the emulator/cpu, althoug I
have launched the emualtor with -cpu Haswell, that should support bmi1
(https://en.wikipedia.org/wiki/Bit_Manipulation_Instruction_Sets#BMI1)

What am I doing wrong?


Thanks!


cc: Richard Henderson and Blue Swril, that Implemented BEXTR
-- 
Ricardo Ribalda
