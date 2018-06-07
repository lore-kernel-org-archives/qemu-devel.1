Received: from eggs.gnu.org ([2001:4830:134:3::10]:43221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1fQxOI-00055k-H3
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1fQxOE-0003PE-G6
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:03:58 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:26032 helo=zju.edu.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1fQxOD-0003Lc-PH
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:03:54 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: =?utf-8?B?5rWZ5aSn6YKu566x?= <linzc@zju.edu.cn>
In-Reply-To: <ced449d6-1778-6641-d055-4fedda442a47@redhat.com>
Date: Fri, 8 Jun 2018 00:03:45 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE460DFB-87F8-45A3-A007-E59C3B23BB67@zju.edu.cn>
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
	<50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
	<77604174-3c15-a8d3-3ea3-53a1759cd885@redhat.com>
	<e2e0ff2b-139e-0582-c8f9-9a716780ff1f@redhat.com>
	<56943de0-74f6-0746-c2c2-eeb9fdeabd74@redhat.com>
	<4409ea2d-971d-8898-bd1a-9e9b9e9172dc@redhat.com>
	<ced449d6-1778-6641-d055-4fedda442a47@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Igor Mammedov <imammedo@redhat.com>, xuyandong <xuyandong2@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

Hi=EF=BC=8Call
I still have a question after reading your discussion: Will seabios detect t=
he change of address space even if we add_region and del_region automaticall=
y? I guess that seabios may not take this change into consideration.

Looking forward to your replies,
Thanks

>> On Jun 7, 2018, at 20:55, David Hildenbrand <david@redhat.com> wrote:
>>=20
>> On 07.06.2018 14:36, Paolo Bonzini wrote:
>> On 07/06/2018 13:36, David Hildenbrand wrote:
>>>> The dirty bitmap would be synced in kvm_region_del (so it's not true
>>>> that kvm_region_del would disappear, but almost :)).
>>> I was rather concerned when doing a KVM_SET_USER_MEMORY_REGIONS while
>>> some (already present) memory region is performing dirty tracking and
>>> therefore has a dirty_bitmap pointer assigned.
>>>=20
>>> As we have to expect that all different kinds of parameters can change
>>> (e.g. the size of a slot as I pointed out), the old bitmap cannot be
>>> reused. At least not atomically -  we could create a new one and the
>>> simply or the old content.
>>>=20
>>> Well, we could make that dirty tracking a special case ("all dirty
>>> tracking data will be lost in case doing a KVM_SET_USER_MEMORY_REGIONS"
>>> - but this again could lead to races (if the bitmap sync happens before
>>> KVM_SET_USER_MEMORY_REGIONS)). It's tricky to get it right :)
>>=20
>> At the point where QEMU calls region_del, the guest is not supposed to
>> access the region anymore, so it's okay to do the final sync there.  The
>> same race exists now already.
>=20
> The point is that KVM_SET_USER_MEMORY_REGIONS is the big hammer, not the
> fine grained region_add/region_del. All regions are suddenly involved.
> So we have to handle dirty_bitmaps somehow.
>=20
> But I agree that those that would actually change
> (split/resized/whatever) should not be currently dirty tracked (or at if
> they are, they should be able to live with the possible race).
>=20
> Devil is in the detail :)
>=20
>>=20
>> Paolo
>>=20
>>>> The rmap is more interesting.  Perhaps it can be just rebuilt on every
>>>> KVM_SET_USER_MEMORY_REGIONS call.
>=20
>=20
> --=20
>=20
> Thanks,
>=20
> David / dhildenb
