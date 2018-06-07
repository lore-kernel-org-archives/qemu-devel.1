Received: from eggs.gnu.org ([2001:4830:134:3::10]:46582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQu9l-0003wI-8T
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQu9h-0003LW-6j
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:36:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36770 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fQu9h-0003Gj-18
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:36:41 -0400
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
	<50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
	<77604174-3c15-a8d3-3ea3-53a1759cd885@redhat.com>
	<e2e0ff2b-139e-0582-c8f9-9a716780ff1f@redhat.com>
	<56943de0-74f6-0746-c2c2-eeb9fdeabd74@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4409ea2d-971d-8898-bd1a-9e9b9e9172dc@redhat.com>
Date: Thu, 7 Jun 2018 14:36:23 +0200
MIME-Version: 1.0
In-Reply-To: <56943de0-74f6-0746-c2c2-eeb9fdeabd74@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: David Hildenbrand <david@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Igor Mammedov <imammedo@redhat.com>, xuyandong <xuyandong2@huawei.com>
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 07/06/2018 13:36, David Hildenbrand wrote:
>> The dirty bitmap would be synced in kvm_region_del (so it's not true
>> that kvm_region_del would disappear, but almost :)).
> I was rather concerned when doing a KVM_SET_USER_MEMORY_REGIONS while
> some (already present) memory region is performing dirty tracking and
> therefore has a dirty_bitmap pointer assigned.
> 
> As we have to expect that all different kinds of parameters can change
> (e.g. the size of a slot as I pointed out), the old bitmap cannot be
> reused. At least not atomically -  we could create a new one and the
> simply or the old content.
> 
> Well, we could make that dirty tracking a special case ("all dirty
> tracking data will be lost in case doing a KVM_SET_USER_MEMORY_REGIONS"
> - but this again could lead to races (if the bitmap sync happens before
> KVM_SET_USER_MEMORY_REGIONS)). It's tricky to get it right :)

At the point where QEMU calls region_del, the guest is not supposed to
access the region anymore, so it's okay to do the final sync there.  The
same race exists now already.

Paolo

>> The rmap is more interesting.  Perhaps it can be just rebuilt on every
>> KVM_SET_USER_MEMORY_REGIONS call.
