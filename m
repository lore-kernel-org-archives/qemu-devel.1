Received: from eggs.gnu.org ([2001:4830:134:3::10]:45895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM8Sg-0007s0-Fd
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM8Sf-0001h5-DQ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:52:34 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fM8Se-0001gq-Td
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:52:33 -0400
Received: by mail-oi0-x244.google.com with SMTP id l1-v6so3939330oii.1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 01:52:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f568933d-2d8c-da22-c588-3ca4d3140538@redhat.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-18-peter.maydell@linaro.org>
	<8736yivgw3.fsf@linaro.org>
	<f568933d-2d8c-da22-c588-3ca4d3140538@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 09:52:11 +0100
Message-ID: <CAFEAcA--wyed8qg=4P-DG9QyZe1eACWh+68g99Gowx71CFAh_w@mail.gmail.com>
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
To: Auger Eric <eric.auger@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 24 May 2018 at 20:54, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 05/23/2018 11:51 AM, Alex Benn=C3=A9e wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> Currently we don't support board configurations that put an IOMMU
>>> in the path of the CPU's memory transactions, and instead just
>>> assert() if the memory region fonud in address_space_translate_for_iotl=
b()
> found
>>> is an IOMMUMemoryRegion.
>>>
>>> Remove this limitation by having the function handle IOMMUs.
>>> This is mostly straightforward, but we must make sure we have
>>> a notifier registered for every IOMMU that a transaction has
>>> passed through, so that we can flush the TLB appropriately
> Can you elaborate on what (TCG) TLB we are talking about?

The TCG TLB, as implemented in accel/tcg/cputlb.c. Basically
the thing that caches the results it gets back from the memory
system so it can fast path device and memory accesses.

> The concept of IOMMUs downstream to a CPU is not obvious to me. Maybe an
> example may be documented in the commit message?

The MPC implemented in this patchset is an example.



>>> +static void tcg_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *io=
tlb)
>>> +{
>>> +    TCGIOMMUNotifier *notifier =3D container_of(n, TCGIOMMUNotifier, n=
);
>>> +
>>> +    if (!notifier->active) {
>>> +        return;
>>> +    }
>>> +    tlb_flush(notifier->cpu);
>>> +    notifier->active =3D false;
>>> +    /* We leave the notifier struct on the list to avoid reallocating =
it later.
>>> +     * Generally the number of IOMMUs a CPU deals with will be small.
>>> +     * In any case we can't unregister the iommu notifier from a notif=
y
>>> +     * callback.
>>> +     */
> I don't get the life cycle of the notifier and why it becomes inactive
> after the invalidate. Could you detail the specificity of this one?

Once we've flushed the TLB it is empty and will have no cached
information from the IOMMU. So there's no point in flushing the
TLB again (which is expensive) until the next time a transaction
goes through the IOMMU and we're caching something from it.

So the cycle goes:
 * CPU makes transaction that goes through an IOMMU
 * in tcg_register_iommu_notifier() we register the notifier
   if we haven't already, and make sure it's got active =3D true
 * in the unmap notify, we flush the whole TLB for the CPU, and
   set active =3D false
 * repeat...


>>> +static void tcg_iommu_notifier_destroy(gpointer data)
>>> +{
>>> +    TCGIOMMUNotifier *notifier =3D data;
>>> +
>>> +    if (notifier->active) {
>>> +        memory_region_unregister_iommu_notifier(notifier->mr, &notifie=
r->n);
>>> +    }
> Is it safe to leave the notifier registered to an IOMMU whereas it gets
> freed?

Oh, this is a bug, left over from my first idea (which was to
unregister the IOMMU notifier in the notifier unmap callback,
in which case active =3D=3D true would be the only case when we
had a registered notifier).

We should unconditionally unregister the notifier here.


>>>  /* Called from RCU critical section */
>>>  MemoryRegionSection *
>>>  address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr add=
r,
>>> -                                  hwaddr *xlat, hwaddr *plen)
>>> +                                  hwaddr *xlat, hwaddr *plen,
>>> +                                  MemTxAttrs attrs, int *prot)
>>>  {
>>>      MemoryRegionSection *section;
>>> +    IOMMUMemoryRegion *iommu_mr;
>>> +    IOMMUMemoryRegionClass *imrc;
>>> +    IOMMUTLBEntry iotlb;
>>> +    int iommu_idx;
>>>      AddressSpaceDispatch *d =3D atomic_rcu_read(&cpu->cpu_ases[asidx].=
memory_dispatch);
>>>
>>> -    section =3D address_space_translate_internal(d, addr, xlat, plen, =
false);
>>> +    for (;;) {
>>> +        section =3D address_space_translate_internal(d, addr, &addr, p=
len, false);
>>> +
>>> +        iommu_mr =3D memory_region_get_iommu(section->mr);
>>> +        if (!iommu_mr) {
>>> +            break;
>>> +        }
>>> +
>>> +        imrc =3D memory_region_get_iommu_class_nocheck(iommu_mr);
>>> +
>>> +        iommu_idx =3D imrc->attrs_to_index(iommu_mr, attrs);
>>> +        tcg_register_iommu_notifier(cpu, iommu_mr, iommu_idx);
>>> +        /* We need all the permissions, so pass IOMMU_NONE so the IOMM=
U
>>> +         * doesn't short-cut its translation table walk.
> it is not clear to me why you don't use the access flag as you seem to
> handle the perm fault after the translate() call.

We need to know all the permissions (because we'll cache the result
in the TCG TLB and later use them for future read and write accesses),
so we pass IOMMU_NONE.

My understanding from previous discussion is that the only
reason to pass in some other access flag value is if you
only care about one of read or write and want to allow the
IOMMU to stop walking the page table early as soon as it decides
it doesn't have permissions.

thanks
-- PMM
