Received: from eggs.gnu.org ([2001:4830:134:3::10]:50928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g0JVh-0004ZI-3i
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g0JVg-0006i3-F7
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:45:45 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g0JVg-0006hT-24
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:45:44 -0400
Received: by mail-ot1-x344.google.com with SMTP id v44-v6so110594ote.13
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 21:45:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <022d6d74-d294-5b73-6256-78b55c00e353@ilande.co.uk>
References: <1536755529-2709-1-git-send-email-liq3ea@gmail.com>
	<CAFEAcA-gybpeAucvWuUW3QAyvwjMVcxL_5xxrcaaekJS51vT4Q@mail.gmail.com>
	<9b7e968f-b683-c431-b524-4df7de36b806@redhat.com>
	<CAFEAcA_50n98m=9a9hiLvV5_iQyXicf70WT1CFAYyV_mfhJnrg@mail.gmail.com>
	<022d6d74-d294-5b73-6256-78b55c00e353@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Sep 2018 05:45:22 +0100
Message-ID: <CAFEAcA_WOayetj67SDaiJytib1+SE_yYjCycWRLZPye4puzrpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] memory region: check the old.mmio.read
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 13 September 2018 at 05:31, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> This sounds familiar to me. I remember whilst working on the Mac
> uninorth patches I couldn't quite figure out why a simple change to the
> PCI bridge IO address space started to cause some accesses to fail: it
> was because the guest was issuing a periodic read to an address without
> a MemoryRegion which was now failing with MEMTX_ERROR rather than the
> returning 0 which was the previous behaviour.

You may have been caught by changes in the handling of
unmapped-region accesses: historically we did read-as-zero/write-ignored,
which is some combination of "what x86 does" and the natural result
of not having support for flagging bus errors up to the CPU emulation.
Adding support for architectures that need bus errors to be reported
probably meant a change in the default at some point.

One thing we don't handle as cleanly as might be ideal is the case where
architecturally the CPU supports bus faults but the bus in an SoC or
board doesn't actually report unmapped accesses back to the CPU as
bus faults. You can model that by adding a suitable io accessor to the
relevant container MR, as you found, but it's a bit unobvious.

thanks
-- PMM
