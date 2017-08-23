Received: from eggs.gnu.org ([2001:4830:134:3::10]:52388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkRc4-0000j1-A5
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkRbz-0004U6-Ap
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:06:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dkRbz-0004R4-0w
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:06:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7N94VUl038072
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 05:06:05 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ch1u1het4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 05:06:05 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 23 Aug 2017 10:06:02 +0100
References: <1503471212-109371-1-git-send-email-borntraeger@de.ibm.com>
	<cc76787a-e65f-f4e4-de65-7233edc53d3a@redhat.com>
	<aef4b38d-eeb2-5c96-32c1-fbeadb9013b5@redhat.com>
	<4e463848-3be4-1b31-c2d9-04ef32d79925@redhat.com>
	<20170823103918.3a2a87a5.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 23 Aug 2017 11:05:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170823103918.3a2a87a5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2e1e1593-9135-7328-5b75-04e4714a3eed@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] configure: enable --s390-pgste linker
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Dan Horak <dhorak@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, Alexander Graf <agraf@suse.de>



On 08/23/2017 10:39 AM, Cornelia Huck wrote:
> On Wed, 23 Aug 2017 10:16:27 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 23/08/2017 10:06, Thomas Huth wrote:
>>> On 23.08.2017 10:00, David Hildenbrand wrote:  
>>>> On 23.08.2017 08:53, Christian Borntraeger wrote:  
> 
>>>>> @@ -6522,6 +6527,20 @@ if test "$target_linux_user" = "yes" -o "$target_bsd_user" = "yes" ; then
>>>>>    ldflags="$ldflags $textseg_ldflags"
>>>>>  fi
>>>>>  
>>>>> +# Newer kernels on s390 check for an S390_PGSTE program header and
>>>>> +# enable the pgste page table extensions in that case. This makes
>>>>> +# the vm.allocate_pgste sysctl unnecessary. We enable this program
>>>>> +# header if
>>>>> +#  - we build on s390x
>>>>> +#  - we build the system emulation for s390x (qemu-system-s390x)
>>>>> +#  - KVM is enabled
>>>>> +#  - the linker support --s390-pgste
>>>>> +if test "$TARGET_ARCH" = "s390x" -a "$target_softmmu" = "yes"  -a "$ARCH" = "s390x" -a "$kvm" = "yes"; then  
>>>>
>>>> Wonder if the "$ARCH" check is really necessary: TARGET_ARCH=s390x with
>>>> kvm=yes should only build on s390x.  
>>>
>>> Isn't kvm=yes and TARGET_ARCH=s390x also possible on a x86 host, where
>>> only the x86_64 target is built with CONFIG_KVM=y, but the s390x target
>>> with CONFIG_KVM=n ?  
>>
>> Yes.  You could use
>>
>>   if test "$ARCH" = "s390x" && supported_kvm_target $target; then
>>     ...
>>   fi
>>
>> Or, in the existing "if supported_kvm_target $target" conditional, add
>>
>>   if test "$ARCH" = s390x && ld_has --s390-pgste; then
>>     ...
>>   fi
> 
> That conditional is unfortunately before the setup of ldflags; but I
> like the idea of using supported_kvm_target.

This is now bike-shedding, no? :-)
I think I prefer to write out the the single statements as is.
I would need to test for supported_kvm_target AND s390 anyway, to prevent
checking ld on x86 as well.

So unless there are complains, I will provide a v3 with the typo fixed.

Christian
