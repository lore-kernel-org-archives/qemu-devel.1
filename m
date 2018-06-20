Received: from eggs.gnu.org ([2001:4830:134:3::10]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfs2-0002ye-Bf
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfs1-0000t2-Bd
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:22:10 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:38513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVfs0-0000sY-U8
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:22:09 -0400
Received: by mail-ot0-x243.google.com with SMTP id p95-v6so166208ota.5
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:22:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dabacef8-081c-8808-d42e-ebb6fd0e6012@ilande.co.uk>
References: <20180620130619.11362-1-peter.maydell@linaro.org>
	<20180620130619.11362-2-peter.maydell@linaro.org>
	<dabacef8-081c-8808-d42e-ebb6fd0e6012@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 17:21:47 +0100
Message-ID: <CAFEAcA8fYtFxPTjOCLrf2CmeCwho1sv=vwrz=U_kdKW+51aayA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] tcg: Support MMU protection regions
 smaller than TARGET_PAGE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 20 June 2018 at 16:46, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 20/06/18 14:06, Peter Maydell wrote:
>
>> Add support for MMU protection regions that are smaller than
>> TARGET_PAGE_SIZE. We do this by marking the TLB entry for those
>> pages with a flag TLB_RECHECK. This flag causes us to always
>> take the slow-path for accesses. In the slow path we can then
>> special case them to always call tlb_fill() again, so we have
>> the correct information for the exact address being accessed.
>>
>> This change allows us to handle reading and writing from small
>> regions; we cannot deal with execution from the small region.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> This patch is very interesting as forcing the slow path is something
> required to implement the sun4u MMU IE (invert endian) bit - for some
> background see Richard's email at
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02835.html.
>
> Presumably there is nothing here that would prevent the slow path being used
> outside of TLB_RECHECK?

Nope; we already have various things that force a slowpath.
Essentially all you need to do is ensure that some lowbit in
the tlb addr fields is set, and we're only moderately
constrained in how many of those we have. You might or might
not be able to use TLB_RECHECK, I don't know.

thanks
-- PMM
