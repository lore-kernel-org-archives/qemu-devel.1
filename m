Received: from eggs.gnu.org ([2001:4830:134:3::10]:57181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZl6z-0006Id-W0
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZl6w-0003fR-Pc
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:09:41 -0500
Received: from greensocs.com ([193.104.36.180]:51727)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZl6w-0003ex-AY
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:09:38 -0500
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
	<1486141597-13941-5-git-send-email-fred.konrad@greensocs.com>
	<d64a7dfd-cb55-ba59-9731-282bb98cf20e@redhat.com>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <1673015b-b059-8094-1b8c-b7039a45cf8e@greensocs.com>
Date: Fri, 3 Feb 2017 22:09:34 +0100
MIME-Version: 1.0
In-Reply-To: <d64a7dfd-cb55-ba59-9731-282bb98cf20e@redhat.com>
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, clg@kaod.org, mark.burton@greensocs.com

On 02/03/2017 06:26 PM, Paolo Bonzini wrote:
>=20
>=20
> On 03/02/2017 09:06, fred.konrad@greensocs.com wrote:
>> +    host =3D mr->ops->request_ptr(mr->opaque, addr - mr->addr, &size,=
 &offset);
>> +
>> +    if (!host || !size) {
>> +        memory_region_transaction_commit();
>> +        return false;
>> +    }
>> +
>> +    sub =3D g_new(MemoryRegion, 1);
>> +    memory_region_init_ram_ptr(sub, OBJECT(mr), "mmio-map", size, hos=
t);
>> +    memory_region_add_subregion(mr, offset, sub);
>> +    memory_region_transaction_commit();
>> +    return true;
>> +}
>> +
>> +void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offse=
t,
>> +                                       unsigned size)
>> +{
>> +    MemoryRegionSection section =3D memory_region_find(mr, offset, si=
ze);
>> +
>> +    if (section.mr !=3D mr) {
>> +        memory_region_del_subregion(mr, section.mr);
>> +        /* memory_region_find add a ref on section.mr */
>> +        memory_region_unref(section.mr);
>> +        object_unparent(OBJECT(section.mr));
>=20
> I think this would cause a use-after-free when using MTTCG.  In general=
,
> creating and dropping MemoryRegions dynamically can cause bugs that are
> nondeterministic and hard to fix without rewriting everything.

Hi Paolo,

Thanks for your comment.
Yes, I read in the docs that dynamically dropping MemoryRegions is badly
broken when we use NULL as an owner because the machine owns it.
But it seems nothing said this is the case with an owner.

But I think I see your point here:
  * memory_region_unref will unref the owner.
  * object_unparent will unref the memory region (which should be 1).
  =3D> the region will be dropped immediately.

Doesn't hotplug use dynamic MemoryRegion? In which case we better
make that work with MTTCG. I wonder if we can't simply handle that
with a safe_work for this case?

BTW the tests I have seems to pass without issues.

>=20
> An alternative design could be:
>=20
> - memory_region_request_mmio_ptr returns a MemoryRegionCache instead of
> a pointer, so that the device can map a subset of the device (e.g. a
> single page)

I'm not aware of this MemoryRegionCache yet, it seems pretty new.
I'll take a look.

Thanks,
Fred

>=20
> - memory_region_request_mmio_ptr and MemoryRegionOps.request_ptr accept
> a Notifier
>=20
> - the device adds the Notifier to a NotifierList.  Before invalidating,
> it invokes the Notifier and empties the NotifierList.
>=20
> - for the TLB case, the Notifier calls tlb_flush_page.
>=20
> I like the general idea though!
>=20
> Paolo
>=20
>> +    }
>> +}
