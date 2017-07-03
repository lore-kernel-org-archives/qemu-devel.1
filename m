Received: from eggs.gnu.org ([2001:4830:134:3::10]:53211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dS4Ow-00050q-Tc
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dS4Ov-0003rn-JU
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:40:42 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:34870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dS4Ov-0003r9-9B
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:40:41 -0400
Received: by mail-wm0-x232.google.com with SMTP id w126so173648055wme.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:40:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <24d9856c-dd4e-70d1-5eaf-3f36e70fad72@twiddle.net>
References: <CAFEAcA_OcQY1V16Vi8Ld1iZprPUsq+OCML0udYzLhVToCUXt_g@mail.gmail.com>
	<24d9856c-dd4e-70d1-5eaf-3f36e70fad72@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jul 2017 17:40:19 +0100
Message-ID: <CAFEAcA_QfLHR1dFQphS5DzjnekUACq=DOGKaqaeQgM_XpouLjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] handling emulation fine-grained memory protection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 3 July 2017 at 17:07, Richard Henderson <rth@twiddle.net> wrote:
> On 07/03/2017 03:04 AM, Peter Maydell wrote:
>> Does anybody have any good ideas for how this ought to be done?
>> We could wind down the "page size" for these CPUs (since we
>> now have runtime-configurable-page-size for ARM CPUs this
>> shouldn't compromise the A profile cores which can stick to
>> 1K or 4K pages) but I don't think we can get down as low as
>> 64 bytes due to all the things we keep in the low bits of
>> TLB entries.
>
>
> It's close..  We need 3 bits that do not overlap any requested alignment.
>
> Does the v7m profile have 8-byte aligned operations?  I see that STREXD is
> out, and I can't think of anything else.  So bits 8, 16, 32 are up for
> grabs, which does fit a 64-byte page minimum.

Looking at section B5.4 in the v8M ARM ARM, it lists only
alignment faults for non-halfword-aligned halfword accesses
and for non-word-aligned various, so we don't need 8-byte
alignment checks.

> That said...
>
>> I'm guessing we'd need to have "this page has fine grained
>> protection regions" imply "take the slow path" and then do
>> the protection check in the slow path. Alex Graf pointed out
>> to me a while back that we already have a data structure for
>> handling sub-page-sized things in the slow path (the subpage
>> handling in the memory system), but can we easily (or otherwise)
>> use it, or would it be simpler just to have a separate thing?
>
>
> I think it would be simpler to have a separate thing, since the regular
> subpage handling requires memory allocation.
>
> I would just think about a bit, TLB_PROT_RECHECK or so, that not only takes
> the slow path through the helper, but also the slow path back through
> tlb_fill.
>
> Since these are defined by system registers, I can imagine there can only be
> a few pages for which this fine grained handling might apply any any one
> time. This would certainly be preferable to reducing the effectiveness of
> the entire TLB by a factor of 16.

Yes, that was somewhat my feeling too -- really tiny TLB pages
are not very nice, and most pages probably won't be finegrained.

thanks
-- PMM
