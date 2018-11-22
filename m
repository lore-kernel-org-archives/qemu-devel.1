Received: from eggs.gnu.org ([2001:4830:134:3::10]:41216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPsMW-0000XM-Fj
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPsMR-0000qP-1g
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:01:56 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gPsMQ-0000on-TI
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:01:50 -0500
Received: by mail-ot1-x343.google.com with SMTP id 40so8582857oth.4
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 09:01:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181120184148.22501-1-pbonzini@redhat.com>
References: <20181120184148.22501-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 17:01:29 +0000
Message-ID: <CAFEAcA-7GePo8ycBHTW1D0WCC3ryToneSzGnY3kABKaT=YzWbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] nvme: fix out-of-bounds access to the CMB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Keith Busch <keith.busch@intel.com>, Li Qiang <liq3ea@gmail.com>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 20 November 2018 at 18:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Because the CMB BAR has a min_access_size of 2, if you read the last
> byte it will try to memcpy *2* bytes from n->cmbuf, causing an off-by-one
> error.  This is CVE-2018-16847.

Maybe we should change the MemoryRegionOps API so that
devices have to explicitly opt in to handling accesses
that span off the end of the region size they've registered?
IIRC we have one or two oddball devices that care about that
(probably mostly x86 IO port devices), but most device
implementations will not be expecting it.

I'm also surprised that the memory subsystem permits a
2 byte access at address sz-1 here, since .impl.unaligned
is not set...

thanks
-- PMM
