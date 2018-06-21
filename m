Received: from eggs.gnu.org ([2001:4830:134:3::10]:36460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fW2AC-0003os-6I
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fW2AA-0004TS-Ue
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:10:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48334
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fW2AA-0004TL-P8
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:10:22 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5LGAKW4128766
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 12:10:22 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jrca70vgw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 12:10:21 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 21 Jun 2018 17:10:15 +0100
References: <20180424101859.10239-1-david@redhat.com>
	<7c046e3c-8752-87c5-f4ff-06ef56ef0128@de.ibm.com>
	<20180621180443.1f0dc588.cohuck@redhat.com>
	<9b9aaca9-5d32-73a0-049f-ee4c08b0b388@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 21 Jun 2018 18:10:11 +0200
MIME-Version: 1.0
In-Reply-To: <9b9aaca9-5d32-73a0-049f-ee4c08b0b388@redhat.com>
Content-Language: en-US
Message-Id: <163c23f1-2549-c76c-3399-b57d95f7c2e6@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x: refactor reset/reipl handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 06/21/2018 06:07 PM, David Hildenbrand wrote:
> On 21.06.2018 18:04, Cornelia Huck wrote:
>> On Thu, 21 Jun 2018 17:49:56 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 04/24/2018 12:18 PM, David Hildenbrand wrote:
>>>> Calling pause_all_vcpus()/resume_all_vcpus() from a VCPU thread might
>>>> not be the best idea. As pause_all_vcpus() temporarily drops the qemu
>>>> mutex, two parallel calls to pause_all_vcpus() can be active at a time,
>>>> resulting in a deadlock. (either by two VCPUs or by the main thread and a
>>>> VCPU)
>>>>
>>>> Let's handle it via the main loop instead, as suggested by Paolo. If we
>>>> would have two parallel reset requests by two different VCPUs at the
>>>> same time, the last one would win.
>>>>
>>>> We use the existing ipl device to handle it. The nice side effect is
>>>> that we can get rid of reipl_requested.
>>>>
>>>> This change implies that all reset handling now goes via the common
>>>> path, so "no-reboot" handling is now active for all kinds of reboots.  
>>>
>>> Ok, this breaks the s390 IPL process when -no-reboot  is specified.
>>> The bios does a diagnose 308 subcode 1 to jump to the final image while
>>> at the same time resetting all devices. This is now blocked with -no-reboot
>>> (although it is actually the boot)
>>>
>>>
>>> I have noticed that with virt-install on iso images since virt-install
>>> specifies -no-reboot.
>>>
>>> Something like this seems to help but it is not a nice solution.
>>
>> It's a bit ugly, but allows us to accommodate the different semantics
>> for the different diag subcodes... the -no-reboot parameter is only
>> supposed to suppress normal guest reboot requests, right?
> 
> The question is if -no-reboot should also be considered for kexec. There
> are (at least on x86, not sure about s390x) "fast reboot techniques
> using kexec". So it feels like -no-reboot should also apply for kexec.

these fast reboots via kexec also work on s390.
But from a machine perspective kexec/kdump is not a reboot. It should not
be blocked by -no-reboot - if it does it would be wrong from a user 
perspective.

> But definitely not for the BIOS :)
> 
> 
