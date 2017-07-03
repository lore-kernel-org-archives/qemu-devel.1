Received: from eggs.gnu.org ([2001:4830:134:3::10]:44831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS3t3-0003sR-B2
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS3sz-00083A-AP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:07:45 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS3sz-00080t-4o
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:07:41 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so24484893qkq.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:07:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA_OcQY1V16Vi8Ld1iZprPUsq+OCML0udYzLhVToCUXt_g@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <24d9856c-dd4e-70d1-5eaf-3f36e70fad72@twiddle.net>
Date: Mon, 3 Jul 2017 09:07:32 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_OcQY1V16Vi8Ld1iZprPUsq+OCML0udYzLhVToCUXt_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] handling emulation fine-grained memory protection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/03/2017 03:04 AM, Peter Maydell wrote:
> For the ARM v7M microcontrollers we currently treat their memory
> protection unit like a funny kind of MMU that only has a 1:1
> address mapping. This basically works but it means that we can
> only support protection regions which are a multiple of 1K in
> size and on a 1K address boundary (because that's what we define
> as the "page size" for it). The real hardware lets you define
> protection regions on a granularity down to 64 bytes (both size
> and address).
> 
> So far we've got away with this, but I think only because the
> payloads we've tested haven't really used the MPU much or at all.
> With v8M I expect the MPU (and its secure/non-secure cousin the
> Security Attribution Unit) to be much more heavily used, so it
> would be nice if we could lift this limitation somehow.
> 
> Does anybody have any good ideas for how this ought to be done?
> We could wind down the "page size" for these CPUs (since we
> now have runtime-configurable-page-size for ARM CPUs this
> shouldn't compromise the A profile cores which can stick to
> 1K or 4K pages) but I don't think we can get down as low as
> 64 bytes due to all the things we keep in the low bits of
> TLB entries.

It's close..  We need 3 bits that do not overlap any requested alignment.

Does the v7m profile have 8-byte aligned operations?  I see that STREXD is out, 
and I can't think of anything else.  So bits 8, 16, 32 are up for grabs, which 
does fit a 64-byte page minimum.

That said...

> I'm guessing we'd need to have "this page has fine grained
> protection regions" imply "take the slow path" and then do
> the protection check in the slow path. Alex Graf pointed out
> to me a while back that we already have a data structure for
> handling sub-page-sized things in the slow path (the subpage
> handling in the memory system), but can we easily (or otherwise)
> use it, or would it be simpler just to have a separate thing?

I think it would be simpler to have a separate thing, since the regular subpage 
handling requires memory allocation.

I would just think about a bit, TLB_PROT_RECHECK or so, that not only takes the 
slow path through the helper, but also the slow path back through tlb_fill.

Since these are defined by system registers, I can imagine there can only be a 
few pages for which this fine grained handling might apply any any one time. 
This would certainly be preferable to reducing the effectiveness of the entire 
TLB by a factor of 16.


r~
