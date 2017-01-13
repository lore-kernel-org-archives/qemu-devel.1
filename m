Received: from eggs.gnu.org ([2001:4830:134:3::10]:33381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS5pE-00054x-H8
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS5pD-00014S-M0
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:39:40 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:33610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cS5pD-00014G-H7
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:39:39 -0500
Received: by mail-yw0-x244.google.com with SMTP id k6so4219951ywk.0
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 09:39:39 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAKv+Gu-m-gMCJLYYuoQYh=HaXtrEi5yN2iCxqkqKpH4x8EPF4A@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4950d02b-8ccc-6660-8ec7-5d0a8b5f249a@twiddle.net>
Date: Fri, 13 Jan 2017 09:39:34 -0800
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-m-gMCJLYYuoQYh=HaXtrEi5yN2iCxqkqKpH4x8EPF4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] bug in new ubfx code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 01/13/2017 09:27 AM, Ard Biesheuvel wrote:
> Hi all,
> 
> I tracked down a boot issue I was having with running the kernel under
> AArch64 system emulation to commit
> 
> It appears that ubfx is executing incorrectly: the following code
> 
>     .global _start
> _start:
>     mov x1, #0x1124
>     ubfx x2, x1, #28, #4
> 
> built with
> 
> aarch64-linux-gnu-gcc -o /tmp/ubfx /tmp/ubfx.s -nostartfiles
> aarch64-linux-gnu-objcopy -O binary /tmp/ubfx.bin /tmp/ubfx
> 
> and executed with
> 
> qemu-system-aarch64 -M virt -cpu cortex-a53 -kernel /tmp/ubfx -s -S -nographic
> 
> produces the value 0x1124000000000 in x2 (as can be observed via GDB),
> while the expected value is 0

Ho hum.  Somehow the relevant patch was corrupted.  It has half of
Alex's fix in

  http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg00137.html

but is also missing half.  I'll fix it up asap.


r~
