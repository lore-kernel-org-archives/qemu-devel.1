Received: from eggs.gnu.org ([2001:4830:134:3::10]:33142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cLLIh-0002RZ-Sj
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 21:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cLLId-0005yZ-0G
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 21:46:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cLLIc-0005y1-O7
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 21:46:06 -0500
References: <1482400096-23078-1-git-send-email-peterx@redhat.com>
	<b2b1424c-1bd0-00ea-8d14-f935b8901629@redhat.com>
	<20161222110412.GB26435@pxdev.xzpeter.org>
	<6798718b-3949-032f-0e5f-fa6b2e2d83fb@redhat.com>
	<20161223032601.GC26435@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f37cf386-8fe4-ded8-0341-dc765882cf72@redhat.com>
Date: Mon, 26 Dec 2016 10:45:55 +0800
MIME-Version: 1.0
In-Reply-To: <20161223032601.GC26435@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: allow dynamic switch of
 IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, david@gibson.dropbear.id.au



On 2016=E5=B9=B412=E6=9C=8823=E6=97=A5 11:26, Peter Xu wrote:
> On Thu, Dec 22, 2016 at 07:34:10PM +0800, Jason Wang wrote:
>>
>> On 2016=E5=B9=B412=E6=9C=8822=E6=97=A5 19:04, Peter Xu wrote:
>>> On Thu, Dec 22, 2016 at 05:52:58PM +0800, Jason Wang wrote:
>>>> On 2016=E5=B9=B412=E6=9C=8822=E6=97=A5 17:48, Peter Xu wrote:
>>>>>   /* Handle Translation Enable/Disable */
>>>>>   static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
>>>>>   {
>>>>> +    if (s->dmar_enabled =3D=3D en) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>>       VTD_DPRINTF(CSR, "Translation Enable %s", (en ? "on" : "off")=
);
>>>>>       if (en) {
>>>>> @@ -1196,6 +1237,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUStat=
e *s, bool en)
>>>>>           /* Ok - report back to driver */
>>>>>           vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0=
);
>>>>>       }
>>>>> +
>>>>> +    vtd_switch_address_space_all(s, en);
>>>>>   }
>>>> We may need something like notifier here to tell e.g vhost to stop d=
evice
>>>> IOTLB. (Since it's likely this series were applied after device IOTL=
B
>>>> patches)
>>> Yes, I missed vhost case.
>>>
>>> To notify vhost, IMO we should be able to use memory listeners just
>>> like how vfio devices do (please refer to vfio_memory_listener).
>> Just for switching? This seems an overkill since we don't depends on i=
t for
>> all other things. Guest should setup correct mappings by explicitly no=
tify
>> device IOTLB. A quick glance at ATS spec, for enabling and disabling, =
looks
>> like it was done through enable bit of ASTctl instead of here.
>>
>> So we are probably ok here :)
> So we need a more general way to notify ATS about this, right? (e.g.,
> for future devices that support ATS as well, not only vhost)

Yes, if we want to make ATS visible to guest. But looks like it needs=20
more e.g VFIO support for device IOTLB invalidation.

>
>>> However, I think the bigger issue is we still don't have a dynamic wa=
y
>>> to turn vhost DMAR on/off, right?
>> The API was ready for this, just issue another set_feature ioctl witho=
ut
>> IOMMU_PLATFORM. (But unfortunately, vhost need a small patch to make t=
his
>> work).
> That'll be nice. :)
>
>>> If so, we may need to re-touch all the parts to enable the dynamic
>>> switching of DMA remapping - QEMU vhost, kernel vhost, and virtio on
>>> the guest side... I start to doubt whether that effort will worth it
>>> due to this single change, especially if this feature (dynamic on/off
>>> DMA remapping) won't be used by most VMs (i.e., Linux should only tur=
n
>>> VT-d on when kernel detects it, and should never turn it off in
>>> anyway).
>> For vhost part, the changes should be very minor, probably just:
>>
>> - a patch to make sure vhost can disable device IOTLB during feature s=
et
>> - properly handling enabling bit of ATSctl in qemu (probably through a=
n
>> notifier)
> Do you think I should provide another patch for the domain switch
> notification (along with this one)? Or I can just postpone this patch
> until DMAR series merged (after all this patch is not an urgent one).

My understanding is, at least device IOTLB does not care about this. So=20
we can leave it as is.

Thanks
