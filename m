Received: from eggs.gnu.org ([2001:4830:134:3::10]:50522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eK5Fi-0001zh-1O
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eK5Ff-0007mH-CE
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:30:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40332
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eK5Ff-0007lm-5u
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:30:23 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vATGT2Pv104767
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 11:30:20 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ehxbrq0hy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 11:30:20 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 29 Nov 2017 16:30:18 -0000
References: <20171128130758.67556-1-pasic@linux.vnet.ibm.com>
	<20171129081735.GR5859@bjsdjshi@linux.vnet.ibm.com>
	<20171129124747.63c1359b.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 29 Nov 2017 17:30:15 +0100
MIME-Version: 1.0
In-Reply-To: <20171129124747.63c1359b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a00f1f2f-3f63-bac8-6e57-52a509967064@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/1] s390x/css: unrestrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>



On 11/29/2017 12:47 PM, Cornelia Huck wrote:
> On Wed, 29 Nov 2017 16:17:35 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
>> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-11-28 14:07:58 +0100]:
>>
>> [...]
>>> The auto-generated bus ids are affected by both changes. We hope to not
>>> encounter any auto-generated bus ids in production as Libvirt is always
>>> explicit about the bus id.  Since 8ed179c937 ("s390x/css: catch section
>>> mismatch on load", 2017-05-18) the worst that can happen because the same
>>> device ended up having a different bus id is a cleanly failed migration.
>>> I find it hard to reason about the impact of changed auto-generated bus
>>> ids on migration for command line users as I don't know which rules is
>>> such an user supposed to follow.  
>> For this paragraph, Halil pointed to me a case that he is thinking of.
>> 1. VM configuration with 3 devices:
>>   -device virtio (e.g. virtio-blk-ccw,id=disk0)
>>   -device vfio-ccw (e.g. id=vfio0)
>>   -device virtio (e.g. virtio-rng-ccw,id=rng0)
>> 2. Start the vm.
>> 3. device_del vfio0
>> 4. migrate "exec:gzip -c > /tmp/tmp_vmstate.gz"
>> 5. modify cmd line from step 1 by removing the vfio0 device, and adding:
>>    -incoming "exec:gzip -c -d /tmp/tmp_vmstate.gz"
>>
>> Let me list my test results here for everybody's reference.
>>
>> W/o this patch
>> ==============
>>
>> ------------+---------------+-------------
>>             | squashing off | squashing on
>> ------------+---------------+-------------
>>     auto id |        F      |     F
>> ------------+---------------+-------------
>> explicit id |        F      |     S
>> ------------+---------------+-------------
>>
>> T1. squashing off + auto id
>>   qemu-system-s390x: vmstate: get_nullptr expected VMS_NULLPTR_MARKER
>>   qemu-system-s390x: Failed to load s390_css:css
>>   qemu-system-s390x: error while loading state for instance 0x0 of device 's390_css'
>>   qemu-system-s390x: load of migration failed: Invalid argument
>> [Fail due to css mismatch - there is no css 0 in the new vm.]
>>
>> T2. squashing off + explicit given id
>>   qemu-system-s390x: vmstate: get_nullptr expected VMS_NULLPTR_MARKER
>>   qemu-system-s390x: Failed to load s390_css:css
>>   qemu-system-s390x: error while loading state for instance 0x0 of device 's390_css'
>>   qemu-system-s390x: load of migration failed: Invalid argument
>> [Fail due to css mismatch - there is no css 0 in the new vm.]
> Hmm... so should we even try to migrate an empty css 0? It only exists
> because we have created a device that we had to detach anyway because
> it was non-migrateable...
> 
> [Probably no easy way to deal with this, though.]
> 

We could make the thing go away when the last device is gone.
I see a general problem with implicitly generated shared stuff.

Obviously we can't fix the past.

@Dong Jia:

Thanks for doing the experiments and publishing your findings.

Halil
