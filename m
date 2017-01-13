Received: from eggs.gnu.org ([2001:4830:134:3::10]:57323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cS5dw-0001Rc-35
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cS5dv-0001Hr-BO
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:28:00 -0500
Received: from mail-it0-x234.google.com ([2607:f8b0:4001:c0b::234]:38206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1cS5du-0001H3-TU
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:27:59 -0500
Received: by mail-it0-x234.google.com with SMTP id x2so42494048itf.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 09:27:58 -0800 (PST)
MIME-Version: 1.0
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 13 Jan 2017 17:27:57 +0000
Message-ID: <CAKv+Gu-m-gMCJLYYuoQYh=HaXtrEi5yN2iCxqkqKpH4x8EPF4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] bug in new ubfx code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Hi all,

I tracked down a boot issue I was having with running the kernel under
AArch64 system emulation to commit

It appears that ubfx is executing incorrectly: the following code

    .global _start
_start:
    mov x1, #0x1124
    ubfx x2, x1, #28, #4

built with

aarch64-linux-gnu-gcc -o /tmp/ubfx /tmp/ubfx.s -nostartfiles
aarch64-linux-gnu-objcopy -O binary /tmp/ubfx.bin /tmp/ubfx

and executed with

qemu-system-aarch64 -M virt -cpu cortex-a53 -kernel /tmp/ubfx -s -S -nographic

produces the value 0x1124000000000 in x2 (as can be observed via GDB),
while the expected value is 0

Regards,
Ard.
