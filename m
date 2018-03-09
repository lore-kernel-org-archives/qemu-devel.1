Received: from eggs.gnu.org ([2001:4830:134:3::10]:57420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euIrd-0006AE-90
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euIrc-0004YT-DV
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:19:17 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:43029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euIrc-0004YC-6i
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:19:16 -0500
Received: by mail-ot0-x244.google.com with SMTP id m22so8787066otf.10
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 06:19:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2d530201-d5f3-1b02-17a9-1c2ed9e2d5e2@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-6-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_4ANVq-Rd63R7BOhd2axy7_Jn-BchzAksKR6g7JbjnTA@mail.gmail.com>
	<2d530201-d5f3-1b02-17a9-1c2ed9e2d5e2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 14:18:54 +0000
Message-ID: <CAFEAcA8or88+BG48VbWyVf3jg6xkw1+3AXvg49pg6dn5SRRF0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 05/14] hw/arm/smmuv3: Wired IRQ and
 GERROR helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 9 March 2018 at 14:03, Auger Eric <eric.auger@redhat.com> wrote:
> On 08/03/18 18:49, Peter Maydell wrote:
>>> +#define smmuv3_eventq_irq_enabled(s)                   \
>>> +    (FIELD_EX32(s->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN))
>>> +#define smmuv3_gerror_irq_enabled(s)                  \
>>> +    (FIELD_EX32(s->irq_ctrl, IRQ_CTRL, GERROR_IRQEN))
>>
>> These are only ever used in smmuv3.c, so you can just move them
>> to there (and make them inline functions, ideally).
> smmuv3-internal.h contains helpers, macros which are only used by
> smmuv3.c . I though this could avoid putting too much code in smmuv3.c
> and would help in the readability.
>
> what is the exact benefit of transforming those into inline functions
> instead of macros. Not meaning I don't want to take this into account
> but to improve my coding style ;-)

You get the benefit of type checking (and it self-documents that
the macros want to be passed an SMMUv3State*). You don't have to
worry about trying to write your macro to not evaluate arguments multiple
times. These are one-liners so they're fairly easy to read,
but when you get to 3 or 4 lines you end up with a lot of '\'
lines and the inline function is I think more clearly better.
I prefer to save macros for cases where you really need a macro
and can't get the same effect with a function.

thanks
-- PMM
