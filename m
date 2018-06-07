Received: from eggs.gnu.org ([2001:4830:134:3::10]:58356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQtD7-0000WI-0h
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQtD2-0007WZ-5a
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:36:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fQtD2-0007WI-1H
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:36:04 -0400
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
	<50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
	<77604174-3c15-a8d3-3ea3-53a1759cd885@redhat.com>
	<e2e0ff2b-139e-0582-c8f9-9a716780ff1f@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <56943de0-74f6-0746-c2c2-eeb9fdeabd74@redhat.com>
Date: Thu, 7 Jun 2018 13:36:01 +0200
MIME-Version: 1.0
In-Reply-To: <e2e0ff2b-139e-0582-c8f9-9a716780ff1f@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Igor Mammedov <imammedo@redhat.com>, xuyandong <xuyandong2@huawei.com>
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 07.06.2018 13:02, Paolo Bonzini wrote:
> On 07/06/2018 12:37, David Hildenbrand wrote:
>>
>> I have a related requirement, which would be to atomically grow a
>> memory regions. So instead of region_del(old)+region_add(new), I would
>> have to do it in one shot (atomically).
>>
>> AFAICS an atomic replace of the memory map would work for this, too.
>> However I am not sure how we want to handle all kinds of tracking data
>> that is connected to e.g. x86 memory slots (e.g. rmap, dirty bitmap ..=
.).
>=20
> The dirty bitmap would be synced in kvm_region_del (so it's not true
> that kvm_region_del would disappear, but almost :)).

I was rather concerned when doing a KVM_SET_USER_MEMORY_REGIONS while
some (already present) memory region is performing dirty tracking and
therefore has a dirty_bitmap pointer assigned.

As we have to expect that all different kinds of parameters can change
(e.g. the size of a slot as I pointed out), the old bitmap cannot be
reused. At least not atomically -  we could create a new one and the
simply or the old content.

Well, we could make that dirty tracking a special case ("all dirty
tracking data will be lost in case doing a KVM_SET_USER_MEMORY_REGIONS"
- but this again could lead to races (if the bitmap sync happens before
KVM_SET_USER_MEMORY_REGIONS)). It's tricky to get it right :)

>=20
> The rmap is more interesting.  Perhaps it can be just rebuilt on every
> KVM_SET_USER_MEMORY_REGIONS call.
>=20
> Paolo
>=20


--=20

Thanks,

David / dhildenb
