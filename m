Received: from eggs.gnu.org ([2001:4830:134:3::10]:55408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euN4j-0006wS-Ig
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euN4i-0003x2-Kk
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:49:05 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:40852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euN4i-0003wu-Ft
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:49:04 -0500
Received: by mail-ot0-x243.google.com with SMTP id l12so9583181otj.7
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 10:49:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180309182030.GA22836@roeck-us.net>
References: <1520444223-8389-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA-+J7MUSssjPZ5BTNzGx_4h0YANdCegGfWNzYmoNatcqg@mail.gmail.com>
	<20180308171239.GA22206@roeck-us.net>
	<201803081028.39635.wpaul@windriver.com>
	<CAFEAcA9T=sydu47UGry2TVOa0gZF8SZLnaaQ5gqzTQmAgm2b1w@mail.gmail.com>
	<20180309182030.GA22836@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 18:48:43 +0000
Message-ID: <CAFEAcA85BTihe_spKnRjraJ65YB6ja0OfG6b03ojj8cE-s410A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fsl-imx6: Swap Ethernet interrupt defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bill Paul <wpaul@windriver.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Jason Wang <jasowang@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>

On 9 March 2018 at 18:20, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Mar 09, 2018 at 05:47:16PM +0000, Peter Maydell wrote:
>> Thanks for that really useful writeup. So if I understand correctly
>> we have several choices here:
>>
>>  (1) we could implement a model of the IOMUX block that is at least
>>  sufficient to support guests that configure it to route the ENET interrupt
>>  line to a GPIO pin. Then we could apply this patch that fixes the ENET
>>  line definitions. Old kernels would continue to work (for the same
>>  reason they worked on hardware), and new ones would work now too.
>>  This is in some ways the preferred option, but it's possibly a lot
>>  of code and we're nearly in freeze for 2.12.
>>
>>  (2) we could leave everything as it is for 2.12. This would mean that
>>  at least we don't regress setups that used to work on older QEMU versions.
>>  Downside is that we wouldn't be able to run Linux v4.15+, or other
>>  guest OSes that don't have the bug that older Linux kernels do.
>>  (Presumably we'd only do this on the understanding that we were going
>>  to go down route (1) for 2.13.)
>>
>>  (3) we could apply this patch for 2.12. Linux v4.15+ now works, as
>>  do other guest OSes that use the ENET interrupt. v4.1 and older Linux
>>  guests that used to boot in QEMU stop doing so, and 4.2-4.9 boot but
>>  lose the ethernet device support. Perhaps for 2.13 we might
>>  take route (1) to make those older guests start working again.
>>
>> Do I have that right?
>>
> Pretty much.
>
>> None of these options seems especially palatable to me, so we're
>> choosing the lesser evil, I think... (unless somebody wants to say
>> that option (1) would be 20 lines of code and here's the patch :-))
>> I guess in the absence of (1) that (3) is better than (2) ?
>>
>
> I would prefer (2). This is what I decided to use in my "local"
> version of qemu. Older versions of Linux can be fixed by applying one
> (4.2..4.9) or two (4.1 and older) upstream patches; anyone interested
> running those kernels in qemu with Ethernet working should apply those
> patches (or, alternatively, provide a patch adding IOMUX support to
> qemu).

Did you mean "prefer (3) [apply this patch]" ? The rest of the paragraph
makes more sense if you did.

thanks
-- PMM
