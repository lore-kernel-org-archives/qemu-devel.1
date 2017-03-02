Received: from eggs.gnu.org ([2001:4830:134:3::10]:33441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjWs6-0003wM-H9
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjWs3-0004zm-TP
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:58:42 -0500
Date: Thu, 2 Mar 2017 20:58:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA_b_iOCBk0dXGNGLve0hM5sLx5qAzq5mvDN-5yARopkdg@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1703022058020.83701@zero.eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<65f979bc1683c46f74ddb5e931810f4e2b8ea27c.1488068248.git.balaton@eik.bme.hu>
	<CAFEAcA8hgztzBZ=4EK7GR_1V4WnKL_hp-CopC1q5NwxeARkgSA@mail.gmail.com>
	<CAFEAcA_b_iOCBk0dXGNGLve0hM5sLx5qAzq5mvDN-5yARopkdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 02/14] sm501: Use defines instead of
 constants where available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, 2 Mar 2017, Peter Maydell wrote:
> On 2 March 2017 at 18:53, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 7 November 2016 at 09:03, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> I just found a datasheet which says that the power-on-default
>> for the misc-control register is 0b0000.0000.0000.00x0.0001.0000.xxx0.0xxx
>> which means that the 0x1000 decimal value is correct and setting
>> the IRQ_INVERT bit is wrong.
>>
>> I think the "active=low" bit is referencing the fact that the
>> DAC_POWER bit is 1 for "disable" and 0 for "enable".
>
> Actually it's referring to bit 17 (which is an "X" in the reset value
> above), which is documented as being set by a GPIO pin on reset,
> and having different meanings for SH and SA1110. In this case we're
> saying 'reset bit 17 to 0, meaning "SH series CPU, Active Low"'.
>
> Note also that the low bits indicate the bus type which is 000 for
> SH and 001 for PCI, etc.
>
> So a better comment here would be:
>    /* Bits 17 (SH), 7 (CDR), 6:5 (Test), 2:0 (Bus) are all supposed
>     * to be determined at reset by GPIO lines which set config bits.
>     * We hardwire them:
>     *  SH = 0 : Hitachi Ready Polarity == Active Low
>     *  CDR = 0 : do not reset clock divider
>     *  TEST = 0 : Normal mode (not testing the silicon)
>     *  BUS = 0 : Hitachi SH3/SH4
>     */
>    s->misc_control = SM501_MISC_DAC_POWER;
>
> ...and you'll want to put something in to get the right Bus value
> for the PCI version.

Thanks for investigating this, I'll update it in v3.
