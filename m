Received: from eggs.gnu.org ([2001:4830:134:3::10]:49975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLvsr-0008PO-Es
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLvsq-0008IK-8M
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:26:45 -0400
References: <1527091418-11874-1-git-send-email-eric.auger@redhat.com>
	<ec6bc0b3-5f0b-bf0c-7d9b-0382e114ee9e@redhat.com>
	<bf99311a-823d-34e8-1892-be27534afc32@redhat.com>
	<22c4e504-a7b4-e6dd-b2cc-618d306b6f0c@redhat.com>
	<CAFEAcA9LMV_-vVAwUkuY=uw2Gf6XLvsgmi8y0PgHPJnQZkWC0w@mail.gmail.com>
	<550464ac-5155-6311-d0f7-92c7c0813f82@redhat.com>
	<CAFEAcA-hobu_=VKhYQ+UZ1WX_JFfwCarkPKQhiBtXc3fre57rg@mail.gmail.com>
	<ee204f5f-600f-2425-a1ff-0418b4611e96@redhat.com>
	<CAKv+Gu8Lp7gUqdurVSYF2wVP0TPHY7Vox5J8ZdT=g0UytoKOUg@mail.gmail.com>
	<e5dc23df-6400-d9ea-ef83-814663b35ef9@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <db7741a4-cc1b-1b4b-c5e1-dda2de21790d@redhat.com>
Date: Thu, 24 May 2018 21:26:32 +0200
MIME-Version: 1.0
In-Reply-To: <e5dc23df-6400-d9ea-ef83-814663b35ef9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/2] ARM virt: Support up to 256 PCIe buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Eric Auger <eric.auger.pro@gmail.com>



On 05/24/2018 07:20 PM, Laszlo Ersek wrote:
> On 05/24/18 16:14, Ard Biesheuvel wrote:
>> On 24 May 2018 at 15:59, Laszlo Ersek <lersek@redhat.com> wrote:
>>> On 05/24/18 15:07, Peter Maydell wrote:
>>>> On 24 May 2018 at 13:59, Laszlo Ersek <lersek@redhat.com> wrote:
>>>>> On 05/24/18 11:11, Peter Maydell wrote:
>>>>>> Won't it also break a guest which is just Linux loaded not via
>>>>>> firmware which is an aarch32 kernel without LPAE support?
>>>>>
>>>>> Does such a thing exist? (I honestly have no clue.)
>>>>
>>>> Yes, it does; LPAE isn't a mandatory kernel config option.
>>>> This is why we have the machine 'highmem' option, so that
>>>> we can run on those kernels by not putting anything above
>>>> the 4G boundary. Looking back at the history on that, we
>>>> opted at the time for "default to highmem on, and if you're
>>>> running an non-lpae kernel you need to turn it off manually".
>>>
>>> Ah, OK, I didn't know that.
>>>
>>>> So we can handle those kernels by just not putting ECAM
>>>> above 4G if highmem is false.
>>>
>>> The problem is we can have a combination of 32-bit UEFI firmware (which
>>> certainly lacks LPAE) and a 32-bit kernel which supports LPAE.
>>> Previously, you wouldn't specify highmem=off, and things would just work
>>> -- the firmware would simply ignore the >=4GB MMIO aperture, and use the
>>> 32-bit MMIO aperture only (and use the sole 32-bit ECAM). The kernel
>>> could then use both low and high MMIO apertures, however (I gather?).
>>>
>>> The difference with "high ECAM" is that it is *moved* (not *added*), so
>>> the 32-bit firmware is left with nothing for config space access. For
>>> booting the same combination as above, you are suddenly forced to add
>>> highmem=off, just to keep the ECAM low -- and that, while it keeps the
>>> firmware happy, prevents the LPAE-capable kernel from using the high
>>> MMIO aperture.
>>>
>>> So I think "highmem_ecam" should be computed like this:
>>>
>>>   highmem_ecam = highmem_ecam_machtype_default &&
>>>                  highmem &&
>>>                  (!firmware_loaded || aarch64);
>>>
>>
>> Given that the firmware is tightly coupled to the platform, we may
>> decide not to care about ECAM for UEFI itself, and invent a secondary
>> config space access mechanism that does not consume such a huge amount
>> of address space. For instance, legacy PCI uses a pair of I/O ports
>> for this, one to set the address and one to perform the actual read or
>> write, and we could easily implement something similar (such an
>> interface is problematic in SMP context but we don't care about that
>> anyway)
>>
>> Just a thought - perhaps we don't care enough about 32-bit to go
>> through the trouble, but it would be nice if LPAE capable 32-bit
>> guests could make use of the expanded PCIe config space as well.
> 
> Under the above proposal, they could, they'd just have to be launched
> without firmware:
> 
>   highmem_ecam_machtype_default = true;
>   highmem = true;
>   firmware_loaded = false;
>   aarch64 = false;
> 
>   highmem_ecam = true &&
>                  true &&
>                  (!false || false);

I think we mostly care about 64b guest experience improvement here. So
personally I am fine with your proposal.

Also there is this vmalloc shortage issue, hit with aarch32 guest only,
up to now (Which I reported at the end of the cover letter). This can
cause some existing guest configs (even without FW) to not boot with the
new high ECAM region whereas it booted before. I don't know if this is
acceptable.

Thanks

Eric
> 
> I see a return to the 0xCF8/0xCFC pattern regressive; I'd rather
> restrict the large/high ECAM feature to 64-bit guests (with or without
> firmware), and to 32-bit LPAE kernels that are launched without firmware
> (which, I think, has been the case for most of their history).
> 
> Personally I don't have a stake in 32-bit ARM, so do take my opinion
> with a grain of salt. Wearing my upstream ArmVirtQemu co-maintainer hat,
> my sole 32-bit interest is in keeping command lines working, *if* they
> once worked. Not extending new QEMU features to 32-bit firmware is fine
> with me -- in fact I would value that over seeing more quirky firmware
> code just for 32-bit's sake.
> 
> Side topic: the last subcondition basically says, "IF we use firmware
> THEN the VM had better be 64-bit". This is a "logical implication":
> A-->B. The C language doesn't have an "implication operator", so I
> rewrote it equivalently with the logical negation and logical OR
> operators: A-->B is equivalent to (!A || B). (If A is true, then B must
> hold; if A is false, then B doesn't matter.)
> 
> Thanks,
> Laszlo
> 
