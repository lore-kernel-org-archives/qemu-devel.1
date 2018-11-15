Received: from eggs.gnu.org ([2001:4830:134:3::10]:49863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNI5l-000251-0a
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNI5k-0006E3-6u
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:53:56 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNI5j-0006Dj-LU
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:53:56 -0500
Received: by mail-oi1-x242.google.com with SMTP id u130-v6so16763236oie.7
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 05:53:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7e05e89a-6eec-257d-03af-78a2d2b60628@twiddle.net>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-6-peter.maydell@linaro.org>
	<3ac12d41-2095-f0ad-db1b-0e3ceea8f44e@redhat.com>
	<7e05e89a-6eec-257d-03af-78a2d2b60628@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 13:53:34 +0000
Message-ID: <CAFEAcA-cE1cBe3BAxMRbdNjtHde3XGf842rqdc8gV8bN7WHNHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/6] accel/tcg: Return -1 for execution
 from MMIO regions in get_page_addr_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, "Emilio G . Cota" <cota@braap.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 15 November 2018 at 07:32, Richard Henderson <rth@twiddle.net> wrote:
> On 11/14/18 6:19 PM, Thomas Huth wrote:
>> Program received signal SIGSEGV, Segmentation fault.
>> [...]
>> (gdb) bt
>> #0  0x0000555555addc68 in onenand_read (opaque=0x555557600600, addr=98304, size=4) at hw/block/onenand.c:612
>
> So the crash is an off-by-one on the line above:
>
> --- a/hw/block/onenand.c
> +++ b/hw/block/onenand.c
> @@ -608,7 +608,7 @@ static uint64_t onenand_read(void *opaque, hwaddr addr,
>      int offset = addr >> s->shift;
>
>      switch (offset) {
> -    case 0x0000 ... 0xc000:
> +    case 0x0000 ... 0xbfff:
>          return lduw_le_p(s->boot[0] + addr);
>
>      case 0xf000:       /* Manufacturer ID */
>
> as the memory segment has size 0xc000.

Presumably it should be ... 0xbffe, since we are
doing a 16-bit load ?

> The guest will now eventually crash with
>
> onenand_read: unknown OneNAND register c000
> ...
> onenand_read: unknown OneNAND register fefe
> qemu: hardware error: onenand_read: implement ECC
>
> CPU #0:
> R00=00000000 R01=00000000 R02=00000000 R03=00000000
> R04=00000000 R05=00000000 R06=00000000 R07=00000000
> R08=00000000 R09=00000000 R10=00000000 R11=00000000
> R12=00000000 R13=00000000 R14=00000000 R15=0001fe04
> PSR=400001d3 -Z-- A svc32
> s00=00000000 s01=00000000 d00=0000000000000000
> s02=00000000 s03=00000000 d01=0000000000000000
> s04=00000000 s05=00000000 d02=0000000000000000
> s06=00000000 s07=00000000 d03=0000000000000000
> s08=00000000 s09=00000000 d04=0000000000000000
> s10=00000000 s11=00000000 d05=0000000000000000
> s12=00000000 s13=00000000 d06=0000000000000000
> s14=00000000 s15=00000000 d07=0000000000000000
> s16=00000000 s17=00000000 d08=0000000000000000
> s18=00000000 s19=00000000 d09=0000000000000000
> s20=00000000 s21=00000000 d10=0000000000000000
> s22=00000000 s23=00000000 d11=0000000000000000
> s24=00000000 s25=00000000 d12=0000000000000000
> s26=00000000 s27=00000000 d13=0000000000000000
> s28=00000000 s29=00000000 d14=0000000000000000
> s30=00000000 s31=00000000 d15=0000000000000000
> FPSCR: 00000000
> Aborted (core dumped)
>
> I'll note that fprintf at the end of onenand_read should be
> qemu_log(LOG_GUEST_ERROR) instead.

Yeah, I'll put together a patch which makes it use the qemu_log
facilities rather than fprintf() and hw_error(). With that
plus the case statement fix then QEMU correctly just sits there
as the guest execution races through memory...

thanks
-- PMM
