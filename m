Received: from eggs.gnu.org ([2001:4830:134:3::10]:55921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZzXR-0004tl-WF
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZzXR-0001Gn-18
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:33:58 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZzXQ-0001GZ-PK
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:33:56 -0500
Received: by mail-wm0-x236.google.com with SMTP id r141so65056606wmg.1
	for <qemu-devel@nongnu.org>; Sat, 04 Feb 2017 04:33:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Feb 2017 12:33:34 +0000
Message-ID: <CAFEAcA9J-F4bVONk_Yhafx3T6R2POW9=pAbLdY+5iW_R_fmBCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 0/5] execute code from mmio area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Mark Burton <mark.burton@greensocs.com>

On 3 February 2017 at 17:06,  <fred.konrad@greensocs.com> wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
>
> This patch-set allows to execute code from mmio areas.
> The main goal of this is to be able to run code for example from an SPI device.
>
> The three first patch fixes the way get_page_addr_code fills the TLB.
>
> The fourth patch implements the mmio execution helpers: the device must
> implement the request_ptr callback of the MemoryRegion and will be notified when
> the guest wants to execute code from it.
>
> The fifth patch implements the execution from the SPI memories in the
> xilinx_spips model.

I like the general idea, but there's an awkward issue:
at the moment our translation system assumes that when we're
translating code then if the first instruction in the TB
can be read OK then we won't ever get a fault trying to
read subsequent bytes up to the end of the page. If we
move from "we only translate code out of whole pages of
RAM" to "we might translate code out of devices that
are in subpages" then this assumption gets broken.
(The symptom would be that we would report the fault
in the wrong place, for the PC at the start of the TB.)

thanks
-- PMM
