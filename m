Received: from eggs.gnu.org ([2001:4830:134:3::10]:56602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dRyEG-0006VI-CI
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dRyEF-0006Ff-DY
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:05:16 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dRyEF-0006Fa-6S
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:05:15 -0400
Received: by mail-wr0-x236.google.com with SMTP id k67so231056066wrc.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 03:05:15 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jul 2017 11:04:53 +0100
Message-ID: <CAFEAcA_OcQY1V16Vi8Ld1iZprPUsq+OCML0udYzLhVToCUXt_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] handling emulation fine-grained memory protection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

For the ARM v7M microcontrollers we currently treat their memory
protection unit like a funny kind of MMU that only has a 1:1
address mapping. This basically works but it means that we can
only support protection regions which are a multiple of 1K in
size and on a 1K address boundary (because that's what we define
as the "page size" for it). The real hardware lets you define
protection regions on a granularity down to 64 bytes (both size
and address).

So far we've got away with this, but I think only because the
payloads we've tested haven't really used the MPU much or at all.
With v8M I expect the MPU (and its secure/non-secure cousin the
Security Attribution Unit) to be much more heavily used, so it
would be nice if we could lift this limitation somehow.

Does anybody have any good ideas for how this ought to be done?
We could wind down the "page size" for these CPUs (since we
now have runtime-configurable-page-size for ARM CPUs this
shouldn't compromise the A profile cores which can stick to
1K or 4K pages) but I don't think we can get down as low as
64 bytes due to all the things we keep in the low bits of
TLB entries.

I'm guessing we'd need to have "this page has fine grained
protection regions" imply "take the slow path" and then do
the protection check in the slow path. Alex Graf pointed out
to me a while back that we already have a data structure for
handling sub-page-sized things in the slow path (the subpage
handling in the memory system), but can we easily (or otherwise)
use it, or would it be simpler just to have a separate thing?

There are probably some awkward corner cases too, for instance
translate.c code would have to cope with the fact that it would
now be possible for the first address in a page to be executable
but later addresses in the same page not be executable...

Any thoughts/ideas/suggestions?

thanks
-- PMM
