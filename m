Received: from eggs.gnu.org ([2001:4830:134:3::10]:59585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLSKF-0000cw-79
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLSKE-000627-Ai
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:53:03 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:36147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLSKE-00061t-4y
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:53:02 -0400
Received: by mail-ot0-x243.google.com with SMTP id m11-v6so24838972otf.3
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 04:53:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8736yivgw3.fsf@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-18-peter.maydell@linaro.org>
	<8736yivgw3.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 May 2018 12:52:41 +0100
Message-ID: <CAFEAcA-dzhUsTW+_+VPZT5W4ArvDi5hEs7jAnmdLzEod9=Bc4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/27] exec.c: Handle IOMMUs in
 address_space_translate_for_iotlb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 23 May 2018 at 10:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Currently we don't support board configurations that put an IOMMU
>> in the path of the CPU's memory transactions, and instead just
>> assert() if the memory region fonud in address_space_translate_for_iotlb=
()
>> is an IOMMUMemoryRegion.
>>
>> Remove this limitation by having the function handle IOMMUs.
>> This is mostly straightforward, but we must make sure we have
>> a notifier registered for every IOMMU that a transaction has
>> passed through, so that we can flush the TLB appropriately
>> when any of the IOMMUs change their mappings.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  include/exec/exec-all.h |   3 +-
>>  include/qom/cpu.h       |   3 +
>>  accel/tcg/cputlb.c      |   3 +-
>>  exec.c                  | 147 +++++++++++++++++++++++++++++++++++++++-
>>  4 files changed, 152 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>> index 4d09eaba72..e0ff19b711 100644
>> --- a/include/exec/exec-all.h
>> +++ b/include/exec/exec-all.h
>> @@ -469,7 +469,8 @@ void tb_flush_jmp_cache(CPUState *cpu, target_ulong =
addr);
>>
>>  MemoryRegionSection *
>>  address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr=
,
>> -                                  hwaddr *xlat, hwaddr *plen);
>> +                                  hwaddr *xlat, hwaddr *plen,
>> +                                  MemTxAttrs attrs, int *prot);
>>  hwaddr memory_region_section_get_iotlb(CPUState *cpu,
>>                                         MemoryRegionSection *section,
>>                                         target_ulong vaddr,
>> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
>> index 9d3afc6c75..d4a30149dd 100644
>> --- a/include/qom/cpu.h
>> +++ b/include/qom/cpu.h
>> @@ -429,6 +429,9 @@ struct CPUState {
>>      uint16_t pending_tlb_flush;
>>
>>      int hvf_fd;
>> +
>> +    /* track IOMMUs whose translations we've cached in the TCG TLB */
>> +    GSList *iommu_notifiers;
>
> So we are only concerned about TCG IOMMU notifiers here, specifically
> TCGIOMMUNotifier structures. Why not just use a GArray and save
> ourselves chasing pointers?

I don't have a strong opinion about which data structure to use;
but GSList has a "find an entry" API and GArray doesn't, so I
picked the one that had the API that meant I didn't need to
hand-code a search loop.

>> --- a/exec.c
>> +++ b/exec.c
>> @@ -650,18 +650,158 @@ MemoryRegion *flatview_translate(FlatView *fv, hw=
addr addr, hwaddr *xlat,
>>      return mr;
>>  }
>>
>> +typedef struct TCGIOMMUNotifier {
>> +    IOMMUNotifier n;
>> +    MemoryRegion *mr;
>> +    CPUState *cpu;
>
> This seems superfluous if we are storing the list of notifiers in the CPU=
State

You need it because in the notifier callback all you get is a pointer
to the IOMMUNotifier, and we need to get from there to the CPUState*.

>> +    int iommu_idx;
>> +    bool active;
>> +} TCGIOMMUNotifier;

thanks
-- PMM
