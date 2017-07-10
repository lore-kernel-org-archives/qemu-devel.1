Received: from eggs.gnu.org ([2001:4830:134:3::10]:39314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUUxp-0007vO-4f
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUUxo-000214-BD
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:26:45 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUUxo-0001xr-3T
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:26:44 -0400
Received: by mail-wr0-x233.google.com with SMTP id r103so130402965wrb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 02:26:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <B1DA44315104F94D9F3F23C74275EA9D729B34@Ikerlan-12.ikerlan.es>
References: <B1DA44315104F94D9F3F23C74275EA9D729B34@Ikerlan-12.ikerlan.es>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 10:26:20 +0100
Message-ID: <CAFEAcA853fSo86JXF0E=yt+Dfu8gVjcdpycx+z5OMX7z_mPKXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Code source modifying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ormaetxea Xabier <xormaetxea@ikerlan.es>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 10 July 2017 at 10:14, Ormaetxea Xabier <xormaetxea@ikerlan.es> wrote:
> My standalone program writes "0xffffffff" in the position 0x95000000
> when the timer should start, and "0x00000000" when it have to finish.
> I want to modify the code so every single (standalone) program step
> reads the virtual 0x95000000 and changes the value of a gpio. But I
> can't find how I can read from the source code the virtual memory,
> and I can't find neither where/how does the program process (step
> by step) the standalone program.

QEMU doesn't really work that way. What we do is take blocks of the
guest binary (usually up to the next branch instruction), translate
the whole block to native host binary code, and then execute those
translated blocks. So our main execution loop (cpu_exec()) is
basically a loop that does:
 * handle any pending interrupt or exception work
 * find previously translated block for this PC
   (and translate it if it didn't already exist)
 * execute that TB (which will execute multiple guest insns
   and may jump directly to another TB without coming back to C code)

Do you really mean virtual addresses here? That is very weird:
hardware doesn't do that -- timer devices are at fixed physical
addresses which the guest can then choose to map where they like
in the virtual address space using the MMU.

thanks
-- PMM
