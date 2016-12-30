Received: from eggs.gnu.org ([2001:4830:134:3::10]:50275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu5J-0008Ll-9c
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu5G-0004bN-5N
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:06:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cMu5F-0004aR-St
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:06:46 -0500
References: <1478502595-8484-1-git-send-email-jasowang@redhat.com>
	<1478502595-8484-3-git-send-email-jasowang@redhat.com>
	<20161216025345.GA5938@pxdev.xzpeter.org>
	<33cf0c8c-5ab2-4e11-b08e-abf193a17c94@redhat.com>
	<074a96e2-c248-5996-d1e7-6ca7a092254f@redhat.com>
	<20161230092209.GE4195@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <02352ce4-e54b-fffb-686f-7a3b3e6cb55f@redhat.com>
Date: Fri, 30 Dec 2016 18:06:33 +0800
MIME-Version: 1.0
In-Reply-To: <20161230092209.GE4195@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 02/10] intel_iommu: name vtd address
 space with devfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, wexu@redhat.com, vkaplans@redhat.com, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>



On 2016=E5=B9=B412=E6=9C=8830=E6=97=A5 17:22, Peter Xu wrote:
> On Fri, Dec 30, 2016 at 04:19:31PM +0800, Jason Wang wrote:
>>
>> On 2016=E5=B9=B412=E6=9C=8816=E6=97=A5 11:53, Jason Wang wrote:
>>>
>>> On 2016=E5=B9=B412=E6=9C=8816=E6=97=A5 10:53, Peter Xu wrote:
>>>> On Mon, Nov 07, 2016 at 03:09:47PM +0800, Jason Wang wrote:
>>>>> To avoid duplicated name and ease debugging.
>>>>>
>>>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Cc: Richard Henderson <rth@twiddle.net>
>>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>> ---
>>>>>   hw/i386/intel_iommu.c | 4 +++-
>>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>>> index 1655a65..5272c30 100644
>>>>> --- a/hw/i386/intel_iommu.c
>>>>> +++ b/hw/i386/intel_iommu.c
>>>>> @@ -2323,6 +2323,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUSt=
ate
>>>>> *s, PCIBus *bus, int devfn)
>>>>>       uintptr_t key =3D (uintptr_t)bus;
>>>>>       VTDBus *vtd_bus =3D g_hash_table_lookup(s->vtd_as_by_busptr, =
&key);
>>>>>       VTDAddressSpace *vtd_dev_as;
>>>>> +    char name[128];
>>>>>         if (!vtd_bus) {
>>>>>           /* No corresponding free() */
>>>>> @@ -2336,6 +2337,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUSt=
ate
>>>>> *s, PCIBus *bus, int devfn)
>>>>>       vtd_dev_as =3D vtd_bus->dev_as[devfn];
>>>>>         if (!vtd_dev_as) {
>>>>> +        snprintf(name, sizeof(name), "intel_iommu_devfn_%d", devfn=
);
>>>> Better with bus number as well? ;)
>>>>
>>>> Like: "%02x:%02x.%x" for (bus, dev, fn).
>>>>
>>>> Thanks,
>>>>
>>>> -- peterx
>>> Yes, will do it in next version.
>>>
>>> Thanks
>>>
>> Actually, I choose not to bother since bus and fn number needs more co=
des to
>> get.
> Should this work?
>
>      snprintf(name, sizeof(name), "intel_iommu_%02x:%02x.%x",
>               pci_bus_num(bus), VTD_PCI_SLOT(devfn),
>               VTD_PCI_FUNC(devfn));
>
> Anyway, I am okay as well to keep it as it is. :)
>
> -- peterx

This may work but I tend to keep it as is and make this on top :)

Thanks
