Received: from eggs.gnu.org ([2001:4830:134:3::10]:38756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ca0sQ-0005bi-Vd
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 08:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ca0sN-0005y6-2O
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 08:59:43 -0500
Received: from greensocs.com ([193.104.36.180]:43814)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ca0sM-0005xJ-MD
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 08:59:39 -0500
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
	<1486141597-13941-5-git-send-email-fred.konrad@greensocs.com>
	<d64a7dfd-cb55-ba59-9731-282bb98cf20e@redhat.com>
	<1673015b-b059-8094-1b8c-b7039a45cf8e@greensocs.com>
	<14c737f4-b965-a1b8-ba3c-003e5fa9e3fd@redhat.com>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <d81969f9-1e64-22ff-80eb-e5da72f8ad76@greensocs.com>
Date: Sat, 4 Feb 2017 14:59:35 +0100
MIME-Version: 1.0
In-Reply-To: <14c737f4-b965-a1b8-ba3c-003e5fa9e3fd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 4/5] exec: allow to get a pointer for some
 mmio memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, qemu-devel@nongnu.org, alistair.francis@xilinx.com, clg@kaod.org

On 02/04/2017 01:41 PM, Paolo Bonzini wrote:
>=20
...
>>
>> Doesn't hotplug use dynamic MemoryRegion? In which case we better
>> make that work with MTTCG. I wonder if we can't simply handle that
>> with a safe_work for this case?
>=20
> Hot-unplug works because the backing memory is only freed when the
> device gets instance_finalize, so at that point the region cannot have
> any references.
>=20
> What can go wrong is the following (from the docs):
>=20
> - the memory region's owner had a reference taken via memory_region_ref
>   (for example by address_space_map)
>=20
> - the region is unparented, and has no owner anymore
>=20
> - when address_space_unmap is called, the reference to the memory
>   region's owner is leaked.

true.

>=20
> In your case you have phys_section_add/phys_section_destroy instead of
> address_space_map/unmap, but the problem is the same.
>=20
> I am a bit unsure about using the same lqspi_buf for caching different
> addresses, and about using the same buffer for MMIO execution and read.
> What if you allocate a different buffer every time
> lqspi_request_mmio_ptr is called (adding a char* argument to
> lqspi_load_cache) and free the old one from the safe_work item, after a
> global TLB flush?  Then you don't need the Notifiers which were the
> complicated and handwavy part of my proposal.

Actually this was just because it was the way xilinx_qspi worked.
It load 1K of SPI data and fill the buffer.

In some other case we don't want to free the pointer at all, just make
it not accessible for execution / read.
(BTW I'll add the read-only property to this).

What about a simple Object eg: mmio-execution-interface which has a
MemoryRegion? Instead of creating the MemoryRegion in request_pointer,
We create a mmio-execution-interface object which create and map the
region on the subregion.
Then in invalidate: we unplug the mmio-execution-interface, unref it and
it is freed all by magic when the map doesn't need it.

This avoid the reference issue and probably the bug with MTTCG.

Fred

>=20
> Paolo
>=20
>>
>> BTW the tests I have seems to pass without issues.
>>
>>>
>>> An alternative design could be:
>>>
>>> - memory_region_request_mmio_ptr returns a MemoryRegionCache instead =
of
>>> a pointer, so that the device can map a subset of the device (e.g. a
>>> single page)
>>
>> I'm not aware of this MemoryRegionCache yet, it seems pretty new.
>> I'll take a look.
>>
>> Thanks,
>> Fred
>>
>>>
>>> - memory_region_request_mmio_ptr and MemoryRegionOps.request_ptr acce=
pt
>>> a Notifier
>>>
>>> - the device adds the Notifier to a NotifierList.  Before invalidatin=
g,
>>> it invokes the Notifier and empties the NotifierList.
>>>
>>> - for the TLB case, the Notifier calls tlb_flush_page.
>>>
>>> I like the general idea though!
>>>
>>> Paolo
>>>
>>>> +    }
>>>> +}
>>
>>
>>
