Received: from eggs.gnu.org ([2001:4830:134:3::10]:46315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eltCl-0004S3-7E
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eltCe-0008CC-Rz
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:18:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40600
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eltCe-0008BR-MP
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:18:12 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1E9DkJV026488
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 04:18:11 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g4huss6h2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 04:18:11 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 14 Feb 2018 09:18:09 -0000
References: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
	<20180214101128.1bc889ea.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Feb 2018 10:18:04 +0100
MIME-Version: 1.0
In-Reply-To: <20180214101128.1bc889ea.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9b9488c4-3c7d-3743-2e6d-e094b3281994@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post documenting
 Spectre/Meltdown options for QEMU 2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>



On 02/14/2018 10:11 AM, Cornelia Huck wrote:
> On Tue, 13 Feb 2018 18:11:05 -0600
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> 
>> This blog entry is intended as a follow-up to the original entry in
>> January regarding Spectre/Meltdown and the proposed changes to address
>> them in the upcoming 2.11.1 release.
>>
>> This entry is meant to accompany the 2.11.1 release (planned for
>> 2018-02-14) and document how to make use of the new options for
>> various architectures.
>>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> ---
>>
>> The pseries/s390 bits have gotten some initial review (thanks Suraj/Christian),
>> but it can definitely use some additional review on the x86 side of things.
>>
>> Also, Peter if think anything extra should to be mentioned on the ARM side just
>> let me know what to add.
>>
>>  .../2018-02-14-qemu-2-11-1-and-spectre-update.md   | 180 +++++++++++++++++++++
>>  1 file changed, 180 insertions(+)
>>  create mode 100644 _posts/2018-02-14-qemu-2-11-1-and-spectre-update.md
> 
> [some comments/questions regarding s390 cpu models, adding DavidH on cc:]
> 
>> +## enabling mitigations for s390 KVM guests
>> +
>> +For s390 guests there are 2 CPU options relating to Spectre/Meltdown:
> 
> s/options/feature bits/ ?
> 
>> +
>> +* bpb: Branch prediction blocking
>> +* ppa15: PPA15 is installed
>> +
>> +**bpb** requires a host kernel patched with:
>> +
>> +    commit 35b3fde6203b932b2b1a5b53b3d8808abc9c4f60
>> +    KVM: s390: wire up bpb feature
>> +
>> +and both **bpb** and **ppa15** require a firmware with the appropriate support
>> +level as well as guest kernel patches to enable the functionality within
>> +guests. Please check with your distro/vendor to confirm.
>> +
>> +Both **bpb** and **ppa15** are enabled by default with newer/patched host
>> +kernels, and can also be set manually. For example:
>> +
>> +    qemu-system-s390x -M s390-ccw-virtio-2.11 ... \
>> +      -cpu zEC12,bpb=on,ppa15=on 
> 
> Do we also want to add that bpb/ppa15 are on if you use the _full_
> model (as opposed to the _base_ model)? Or is this going into too much
> detail about the cpu model?

full model is just an internal implementation.
Either use
- host passthrough
- host model
- add bpb and ppa15 manually to the choosen model (e.g. z13,bpb=on,ppa15=on)

> 
>> +
>> +WRT to migration, enabling **bpb** requires the source/target also have **bpb**
> 
> Either "WRT migration", or "With regard to migration" :)
> 
>> +enabled. Since this is enabled by default, you must ensure that **bpb**=off if
>> +you wish to maintain migration compatibility with existing guests, or take
>> +steps to reboot guests with **bpb** enabled prior to migrating them.
> 
> This paragraph confuses me a bit. Both bpb and ppa15 are guest visible,
> aren't they?
> 
