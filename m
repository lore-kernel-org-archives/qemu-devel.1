Received: from eggs.gnu.org ([2001:4830:134:3::10]:57982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cQhMR-0002gW-6R
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cQhMI-0004NB-EJ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:20:11 -0500
Received: from relay5-d.mail.gandi.net ([2001:4b98:c:538::197]:36695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cQhMI-0004Mb-86
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:20:02 -0500
References: <20170104220624.26557-1-jcd@tribudubois.net>
	<CAFEAcA8dwhoSZTWS9JJ6-vSUs1Asw8ymktmD+oOqx0DNpCV2XQ@mail.gmail.com>
	<1be7123c-acee-7d16-8a10-c8965d5805ff@gmail.com>
	<CAFEAcA9cUEGL=rSrq2cstParBYHMWdkDy_acu7mTW754+G_Y6Q@mail.gmail.com>
	<fb9b6b0a-62b5-2421-2826-d3f853b5d5b3@tribudubois.net>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <f6ddf63f-78b8-935b-9075-838a0ca0aa7d@tribudubois.net>
Date: Mon, 9 Jan 2017 22:19:56 +0100
MIME-Version: 1.0
In-Reply-To: <fb9b6b0a-62b5-2421-2826-d3f853b5d5b3@tribudubois.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] [i.MX] fix CS handling during SPI
 access.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "mar.krzeminski" <mar.krzeminski@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hum, ... I think I have a problem.

With the default register value (that I get a reset) the CS line is 
deselected when the CS is high.

So at reset I would need to set my 4 CS lines to high in order to be 
able to drive them low later.

So during the "reset" I need to set my 4 CS line to 1 but according to 
you feedback I should not do it with qemu_set_irq()...

Is there another way than qemu_set_irq() to do set my lines to high level ?

Regards.

JC

Le 09/01/2017 à 21:05, Jean-Christophe DUBOIS a écrit :
> Le 09/01/2017 à 20:06, Peter Maydell a écrit :
>> On 9 January 2017 at 19:04, mar.krzeminski <mar.krzeminski@gmail.com> 
>> wrote:
>>>
>>> W dniu 09.01.2017 o 11:46, Peter Maydell pisze:
>>>> Calling qemu_set_irq() in a device reset function is a bit
>>>> tricky, because in a full system reset the device at the other
>>>> end might have already reset or might not, and calling into
>>>> its handler function for the irq line change might provoke
>>>> an unwanted change of its state. We don't really have a coherent
>>>> model here but for the moment we just try to avoid calling
>>>> set_irq in a reset method.
>>> JC, if you remove qemu_set_irq() call from reset, at least m25p80 
>>> behavior
>>> should not change since m25p80 reset handler will reset it's whole 
>>> internal
>>> state.
>> I noticed the reset function is also called from within the
>> register emulation too, so it's maybe not quite that simple...
> OK, I'll fix it.
>
> JC
>
>>
>> thanks
>> -- PMM
>>
>>
>
>
>
