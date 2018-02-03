Received: from eggs.gnu.org ([2001:4830:134:3::10]:55456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ei5P7-0000Af-JH
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ei5P6-0000fH-RI
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:31:21 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:36948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ei5P6-0000e2-Lw
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:31:20 -0500
Received: by mail-ot0-x241.google.com with SMTP id e64so3771047ote.4
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 13:31:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <675ab9e3-80ec-97fc-5c01-ce28b2d2d4d1@linaro.org>
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-5-git-send-email-peter.maydell@linaro.org>
	<675ab9e3-80ec-97fc-5c01-ce28b2d2d4d1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 3 Feb 2018 21:30:59 +0000
Message-ID: <CAFEAcA9xBQO-o8wV0bR1qK1PG23xbAAWtd-JdXqS0ao9N+f3mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/7] target/arm: Make v7M exception entry
 stack push check MPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 3 February 2018 at 21:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 01/30/2018 07:02 AM, Peter Maydell wrote:
>> +    if (get_phys_addr(env, addr, MMU_DATA_STORE, mmu_idx, &physaddr,
>> +                      &attrs, &prot, &page_size, &fi, NULL)) {
>
> Given that you know you're going to call this at least 8 times in a row,
> probably with all operations on the same page, it is worth querying the qemu
> tlb first, and when that fails but the lookup succeeds, installing the result
> into the tlb?

get_phys_addr and address_space_stl_le don't touch the TLB though?
We could in theory do a get_phys_addr() once per-page rather than
doing it all 8 times though, yes.

But yes, I figured I'd write the straightforward code -- M class
CPU h/w all runs much slower than the host CPU anyway so we
probably have some overhead to play with. If anybody ever
complains maybe we can profile it :-)

thanks
-- PMM
