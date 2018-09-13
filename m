Received: from eggs.gnu.org ([2001:4830:134:3::10]:46859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1g0JHt-00028K-2d
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1g0JHo-0001vD-By
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:31:28 -0400
Received: from chuckie.co.uk ([82.165.15.123]:43161
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1g0JHo-0001tZ-03
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:31:24 -0400
References: <1536755529-2709-1-git-send-email-liq3ea@gmail.com>
	<CAFEAcA-gybpeAucvWuUW3QAyvwjMVcxL_5xxrcaaekJS51vT4Q@mail.gmail.com>
	<9b7e968f-b683-c431-b524-4df7de36b806@redhat.com>
	<CAFEAcA_50n98m=9a9hiLvV5_iQyXicf70WT1CFAYyV_mfhJnrg@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <022d6d74-d294-5b73-6256-78b55c00e353@ilande.co.uk>
Date: Thu, 13 Sep 2018 05:31:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_50n98m=9a9hiLvV5_iQyXicf70WT1CFAYyV_mfhJnrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 13/09/18 01:31, Peter Maydell wrote:

> On 12 September 2018 at 18:43, Laszlo Ersek <lersek@redhat.com> wrote:
>> On 09/12/18 14:54, Peter Maydell wrote:
>>> There's patches on-list which drop the old_mmio field from the MemoryRegion
>>> struct entirely, so I think this patch as it stands is obsolete.
>>>
>>> Currently our semantics are "you must provide both read and write, even
>>> if one of them just always returns 0 / does nothing / returns an error".
>>
>> That's new to me. Has this always been the case?
> 
> Pretty sure it has, yes, because the code assumes that if you can
> get a guest read then your MemoryRegion provides an accessor for it.
> If your guest never actually tries to do a read then of course we'll
> never notice...
> 
>> There are several
>> static MemoryRegionOps structures that don't conform. (See the end of my
>> other email:
>> <http://mid.mail-archive.com/84da6f02-1f60-4bc7-92da-6a7f74deded3@redhat.com>.)
>> Beyond the one that Li Qiang reported directly ("fw_cfg_ctl_mem_read").
>>
>> Are all of those ops guest-triggerable QEMU crashers?
> 
> Some of them are special cases like the notdirty-memory one where
> reads always go to host RAM rather than taking the slow path via
> the io accessor. But others are probably guest crashers.
> 
>>> We could probably reasonably assert this at the point when the
>>> MemoryRegionOps is registered.
>>
>> Apparently, we should have...
> 
> Yeah. Or we could define a default for if there's no read function,
> which I guess should be the same as what we do if
> memory_region_access_valid() fails. If we want that then the
> simplest thing is for memory_region_access_valid() itself to
> check that at least one of the accessor functions exists and
> return false if none do. (But as I mention above we should get
> all the "old_mmio is going away" patches in first and base the
> change on that, or there'll be a conflict.)

This sounds familiar to me. I remember whilst working on the Mac
uninorth patches I couldn't quite figure out why a simple change to the
PCI bridge IO address space started to cause some accesses to fail: it
was because the guest was issuing a periodic read to an address without
a MemoryRegion which was now failing with MEMTX_ERROR rather than the
returning 0 which was the previous behaviour.

The fix was ultimately to add an unassigned_io_ops to the parent
MemoryRegion which I found out was being sneakily added by the old code,
although it certainly had me scratching my head for a while...


ATB,

Mark.
