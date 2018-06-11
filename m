Received: from eggs.gnu.org ([2001:4830:134:3::10]:55007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSKJJ-0000gx-Su
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSKJF-0006ds-0l
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:44:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fSKJE-0006dW-Rx
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:44:24 -0400
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
	<50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
	<77604174-3c15-a8d3-3ea3-53a1759cd885@redhat.com>
	<e2e0ff2b-139e-0582-c8f9-9a716780ff1f@redhat.com>
	<56943de0-74f6-0746-c2c2-eeb9fdeabd74@redhat.com>
	<4409ea2d-971d-8898-bd1a-9e9b9e9172dc@redhat.com>
	<ced449d6-1778-6641-d055-4fedda442a47@redhat.com>
	<AE460DFB-87F8-45A3-A007-E59C3B23BB67@zju.edu.cn>
From: David Hildenbrand <david@redhat.com>
Message-ID: <679ab02f-b110-c80a-c99e-1301b7fa1725@redhat.com>
Date: Mon, 11 Jun 2018 12:44:20 +0200
MIME-Version: 1.0
In-Reply-To: <AE460DFB-87F8-45A3-A007-E59C3B23BB67@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] An emulation failure occurs,
 if I hotplug vcpus immediately after the VM start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?5rWZ5aSn6YKu566x?= <linzc@zju.edu.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Igor Mammedov <imammedo@redhat.com>, xuyandong <xuyandong2@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 07.06.2018 18:03, =E6=B5=99=E5=A4=A7=E9=82=AE=E7=AE=B1 wrote:
> Hi=EF=BC=8Call
> I still have a question after reading your discussion: Will seabios det=
ect the change of address space even if we add_region and del_region auto=
matically? I guess that seabios may not take this change into considerati=
on.

Hi,

We would just change the way how KVM memory slots are updated. This is
right now not atomic, but would be later on. It should not have any
other effect.

Thanks

>=20
> Looking forward to your replies,
> Thanks
>=20
>>> On Jun 7, 2018, at 20:55, David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 07.06.2018 14:36, Paolo Bonzini wrote:
>>> On 07/06/2018 13:36, David Hildenbrand wrote:
>>>>> The dirty bitmap would be synced in kvm_region_del (so it's not tru=
e
>>>>> that kvm_region_del would disappear, but almost :)).
>>>> I was rather concerned when doing a KVM_SET_USER_MEMORY_REGIONS whil=
e
>>>> some (already present) memory region is performing dirty tracking an=
d
>>>> therefore has a dirty_bitmap pointer assigned.
>>>>
>>>> As we have to expect that all different kinds of parameters can chan=
ge
>>>> (e.g. the size of a slot as I pointed out), the old bitmap cannot be
>>>> reused. At least not atomically -  we could create a new one and the
>>>> simply or the old content.
>>>>
>>>> Well, we could make that dirty tracking a special case ("all dirty
>>>> tracking data will be lost in case doing a KVM_SET_USER_MEMORY_REGIO=
NS"
>>>> - but this again could lead to races (if the bitmap sync happens bef=
ore
>>>> KVM_SET_USER_MEMORY_REGIONS)). It's tricky to get it right :)
>>>
>>> At the point where QEMU calls region_del, the guest is not supposed t=
o
>>> access the region anymore, so it's okay to do the final sync there.  =
The
>>> same race exists now already.
>>
>> The point is that KVM_SET_USER_MEMORY_REGIONS is the big hammer, not t=
he
>> fine grained region_add/region_del. All regions are suddenly involved.
>> So we have to handle dirty_bitmaps somehow.
>>
>> But I agree that those that would actually change
>> (split/resized/whatever) should not be currently dirty tracked (or at =
if
>> they are, they should be able to live with the possible race).
>>
>> Devil is in the detail :)
>>
>>>
>>> Paolo
>>>
>>>>> The rmap is more interesting.  Perhaps it can be just rebuilt on ev=
ery
>>>>> KVM_SET_USER_MEMORY_REGIONS call.
>>
>>
>> --=20
>>
>> Thanks,
>>
>> David / dhildenb
>=20


--=20

Thanks,

David / dhildenb
