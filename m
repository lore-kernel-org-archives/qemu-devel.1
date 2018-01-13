Received: from eggs.gnu.org ([2001:4830:134:3::10]:52459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eaL6H-0001m7-8z
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 07:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eaL6G-0003tt-IP
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 07:39:53 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eaL6G-0003tL-CG
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 07:39:52 -0500
Received: by mail-oi0-x242.google.com with SMTP id w135so5632515oie.3
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 04:39:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAYMZQvY=yp2xaGWPPW3gXrj_no3jWgtemJY3eDgo34WU2OVCQ@mail.gmail.com>
References: <20171126231634.9531-1-frasse.iglesias@gmail.com>
	<20171126231634.9531-8-frasse.iglesias@gmail.com>
	<CAFEAcA-Z2-M88JS7n+zW1AgA99gmeT-cj90BjbEzYEN95c6Zuw@mail.gmail.com>
	<CAAYMZQvY=yp2xaGWPPW3gXrj_no3jWgtemJY3eDgo34WU2OVCQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2018 12:39:31 +0000
Message-ID: <CAFEAcA8F7VJ2Gp3AJuhbu8iSuBPjyeK==dPEZB_fHSf_uAvang@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 07/13] xilinx_spips: Add support for RX
 discard and RX drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: francisco iglesias <frasse.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 13 January 2018 at 01:04, francisco iglesias
<frasse.iglesias@gmail.com> wrote:
> CID 1383841 (#2 of 4): Uninitialized scalar variable (UNINIT)29.
> uninit_use_in_call: Using uninitialized value (uint32_t)tx_rx[0] when
> calling
> ssi_transfer.
>
> This is correct, tx_rx is used uninitialized but since we are transmitting
> dummy cycles the transmitted value (tx_rx[0] in this case) is not used (by
> the flashes), this the reason the code looks like that. Would you like me to
> create a patch for quieting coverity here anyway?

  tx_rx[0] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[0]);

is effectively using the value (since you don't know what the
thing on the other end of that function is going to do with the
value you pass it. You really don't want to make this code's
correctness depend on the called function never looking at
its argument. If you want to pass a dummy value why not
just use constant 0 or something rather than an uninitialized
variable ?

I think quieting coverity is probably a good idea anyway for
the other false positives (it sounds like it hasn't been able
to determine that paths in the rest of the loop can only occur
if the top of the loop went through a path initializing the
variable. Code like that is also hard for humans to comprehend,
though...)

thanks
-- PMM
