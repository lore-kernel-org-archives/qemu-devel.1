Received: from eggs.gnu.org ([2001:4830:134:3::10]:56984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYodf-00008H-U0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYodf-0007AO-0e
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:20:19 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:36137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYode-00076u-Ij
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:20:18 -0400
Received: by mail-ot0-x243.google.com with SMTP id c15-v6so9080641otl.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 01:20:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625131253.11218-2-kraxel@redhat.com>
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 09:19:57 +0100
Message-ID: <CAFEAcA_hfvKR2aRkLO+TL2vAGJecUfNxfXtvtuO94VGMybt1xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/6] audio/hda: create millisecond timers
 that handle IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Martin Schrodt <martin@schrodt.org>

On 25 June 2018 at 14:12, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Currently, the HDA device tries to sync itself with the QEMU audio
> backend by waiting for the guest driver to handle buffer completion
> interrupts. This causes the backend to often read too much data from the
> device, as well as running out of data whenever the guest takes too long
> to handle the interrupt.
>
> According to the HDA specification, the guest is also not required to
> use interrupts, but can also sync itself by polling the LPIB registers.
>
> This patch will introduce high frequency (1000Hz) timers that interface
> with the device and allow for much smoother emulation of the LPIB
> registers. Since the timing is now provided by these timers, the need
> to wait for buffer completion interrupts also ceases.

> +static inline int64_t hda_bytes_per_second(HDAAudioStream *st)
> +{
> +    return 2 * st->as.nchannels * st->as.freq;
> +}

Hi; Coverity warns about this expression because the
multiplication is done as a 32-bit multiply and the
result is returned as a 64-bit (CID 1393631). As usual,
a suitable cast would fix it.

thanks
-- PMM
