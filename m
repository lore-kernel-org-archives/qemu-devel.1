Received: from eggs.gnu.org ([2001:4830:134:3::10]:33262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duIK9-0006Ny-PC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duIK3-00020i-Gr
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:12:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1duIK3-0001ze-92
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:12:19 -0400
References: <1490347615-19222-1-git-send-email-thuth@redhat.com>
	<f3b0b14e-4ea1-6c4e-f9c6-cb86e78c6104@de.ibm.com>
	<c2195ec9-a3d7-eb14-c204-d5c0e6239811@redhat.com>
	<129fdced-8f83-e408-b37a-26c6ba8bb48f@de.ibm.com>
	<169bbaaf-3212-ce1d-a0db-6edede5b481d@redhat.com>
	<004effcd-142f-d667-3f14-c77c211cd219@de.ibm.com>
	<6f711dfd-84bc-8683-3655-b836bb5d0a51@redhat.com>
	<09c14d39-8867-0a19-aeeb-f8edcd0df66e@redhat.com>
	<3ce8f3c2-1ef5-6e1d-504d-9ca9a68cb818@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <872bdedf-b0d2-1301-684e-678060ef68a0@redhat.com>
Date: Tue, 19 Sep 2017 15:12:13 +0200
MIME-Version: 1.0
In-Reply-To: <3ce8f3c2-1ef5-6e1d-504d-9ca9a68cb818@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x/kvm: Fix problem when running
 with SELinux under z/VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>

On 19.09.2017 15:03, David Hildenbrand wrote:
> On 19.09.2017 14:48, Thomas Huth wrote:
>> On 19.09.2017 14:38, David Hildenbrand wrote:
>>> On 18.09.2017 09:43, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 09/15/2017 04:36 PM, Thomas Huth wrote:
>>>>> On 29.03.2017 16:25, Christian Borntraeger wrote:
>>>>>> On 03/29/2017 04:21 PM, Thomas Huth wrote:
>>>>>>> On 24.03.2017 10:39, Christian Borntraeger wrote:
>>>>>>>> On 03/24/2017 10:26 AM, Thomas Huth wrote:
>>>>>>>>> When running QEMU with KVM under z/VM, the memory for the guest
>>>>>>>>> is allocated via legacy_s390_alloc() since the KVM_CAP_S390_COW
>>>>>>>>> extension is not supported on z/VM. legacy_s390_alloc() then uses
>>>>>>>>> mmap(... PROT_EXEC ...) for the guest memory - but this does not
>>>>>>>>> work when running with SELinux enabled, mmap() fails and QEMU aborts
>>>>>>>>> with the following error message:
>>>>>>>>>
>>>>>>>>>  cannot set up guest memory 's390.ram': Permission denied
>>>>>>>>>
>>>>>>>>> Looking at the other allocator function qemu_anon_ram_alloc(), it
>>>>>>>>> seems like PROT_EXEC is normally not needed for allocating the
>>>>>>>>> guest RAM, and indeed, the guest also starts successfully under
>>>>>>>>> z/VM when we remove the PROT_EXEC from the legacy_s390_alloc()
>>>>>>>>> function. So let's get rid of that flag here to be able to run
>>>>>>>>> with SELinux under z/VM, too.
>>>>>>>>
>>>>>>>> Older z/VM versions do not provide the enhanced suppression on protection
>>>>>>>> facility, which would result in guest failures as soon as the kernel
>>>>>>>> starts dirty pages tracking by write protecting the pages via the page
>>>>>>>> table. Some kernel release back (last time I checked) the PROT_EXEC was 
>>>>>>>> necessary to prevent the dirty pages tracking from taking place. So this
>>>>>>>> patch would break KVM in that case.
>>>>>>>>
>>>>>>>> Newer z/VMs (e.g. 6.3) do provide ESOP. SO the question is,
>>>>>>>> why is KVM_CAP_S390_COW not set?
>>>>>>>
>>>>>>> I now had another look at this, and seems like the ESOP bit is indeed
>>>>>>> not set in S390_lowcore.machine_flags here. According to /proc/sysinfo,
>>>>>>> z/VM is version 6.1.0 here, so I guess that's just too old for ESOP?
>>>>>>
>>>>>> Yes, this was introduced with z/VM 6.3
>>>>>
>>>>> FWIW, the last version without ESOP, z/VM 6.2, is now end of life,
>>>>> according to: http://www.vm.ibm.com/techinfo/lpmigr/vmleos.html
>>>>> ... so I guess we could remove the legacy_s390_alloc() function now?
>>>>
>>>>
>>>> I recently learned that you can buy some extended z/VM support not sure how
>>>> long this will be available. In addition, ESOP was added with z10, so
>>>> if we still care about z9 and older then this would break things on
>>>> very very old boxes.
>>>
>>> I wonder if that is really relevant anymore.
>>>
>>> Existing user on such machines (I doubt there are many) can simply stick
>>> to QEMU <= 2.10. Or do we actually expect people with such old
>>> environments to use latest and grates QEMU versions?
>>>
>>> We could add an error message an error out.
>>
>> Well, as long as the code does not cause any trouble for us, and as long
>> as there still might be possible users, there is also no real urge to
>> remove it, is there? I originally thought that all affected systems
>> would now be EOL, but as Christian pointed out, the z9 BC is not EOL
>> yet, so I'd say we should at least wait for that point in time before
>> removing it (I haven't found any public information about extended z/VM
>> support though, so no clue whether we should really take that into account).
>>
>>  Thomas
>>
> 
> It's the last remaining alloc hack we have in QEMU :) That's why I am
> asking the question.

Hmm, maybe we could remove it for QEMU v3.0 ? ;-)

 Thomas
