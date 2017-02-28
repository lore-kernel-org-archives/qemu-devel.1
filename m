Received: from eggs.gnu.org ([2001:4830:134:3::10]:41107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciqdA-0007HN-Nn
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciqd9-0002IT-OX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:52:28 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciqd9-0002IB-GL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:52:27 -0500
Received: by mail-wm0-x234.google.com with SMTP id v77so96515882wmv.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 14:52:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228215801.10472-3-Andrew.Baumann@microsoft.com>
References: <20170228215801.10472-1-Andrew.Baumann@microsoft.com>
	<20170228215801.10472-3-Andrew.Baumann@microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 22:52:05 +0000
Message-ID: <CAFEAcA_hNXrQ4rihj4-ha+m25pkaf7GqMEa=WL93hF+27hPE1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: lie more convincingly
 about memory attributes in PAR_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 28 February 2017 at 21:58, Andrew Baumann
<Andrew.Baumann@microsoft.com> wrote:
> On a successful long-descriptor translation, PAR_EL1 bits 56:63 are
> expected to report the memory attributes of the page. However, the
> page table walker (get_phys_addr()) does not currently retrieve these
> attributes. Rather than leaving these bits clear (which implies
> uncacheable device memory), this change sets them to 0xff, which
> corresponds to write-back cached normal memory.
>
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> ---
> In my (biased!) opinion, this is a better lie to tell for an emulated
> environment. It also happens to un-break the Windows boot process, and
> enable an NT kernel optimisation (DC ZVA for page zeroing).

It's not clear to me that misreporting Device memory as
Normal is any better than misreporting Normal memory as
Device -- at least, it seems like it might break currently
working guests.

I think it would be safer to implement the PAR as "honour the
attribute index bits in page table descriptors and return
the corresponding bits from the MAIR registers".

thanks
-- PMM
