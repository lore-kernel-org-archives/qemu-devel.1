Received: from eggs.gnu.org ([2001:4830:134:3::10]:41708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elGvx-0003Fb-6S
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elGvu-0005AZ-A0
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:26:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1elGvu-00058J-0F
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:26:22 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1CGPAMC137873
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 11:26:20 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g3c5spuy1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 11:26:20 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 12 Feb 2018 16:26:17 -0000
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180212163847.7b9779d6.cohuck@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 17:26:12 +0100
MIME-Version: 1.0
In-Reply-To: <20180212163847.7b9779d6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <3766340c-a2ab-b524-1d76-917e71abea61@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] add query-cpu-fast and related s390
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, lcapitulino@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, dgilbert@redhat.com, rth@twiddle.net, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

On 12.02.2018 16:38, Cornelia Huck wrote:
> On Mon, 12 Feb 2018 13:14:29 +0100
> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> 
>> This series consolidates patches around a performance issue
>> caused by the usage of QMP query-cpus.
> 
> Thank you for consolidating this; it was a bit hard to follow the
> different discussions.
> 
>>
>> A performance issue was found in an OpenStack environment, where
>> ceilometer was collecting domain statistics with libvirt. The domain
>> statistics reported by libvirt include the vCPU halted state, which 
>> in turn is retrieved with QMP query-cpus.
>>
>> This causes two issues:
>> 1. Performance: on most architectures query-cpus needs to issue a KVM ioctl
>>    to find out whether a vCPU was halted. This is not the case for s390
>>    but query-cpus is always causing the vCPU to exit the VM.
>>
>> 2. Semantics: on x86 and other architectures, halted is a highly transient
>>    state, which is likely to have already changed shortly after the state
>>    information has been retrieved. This is not the case for s390, where
>>    halted is an indication that the vCPU is stopped, meaning its not
>>    available to the guest operating system until it has been restarted.
>>
>> The following patches help to alleviate the issues:
>>
>> Patch 1/3:
>>   Adds architecture specific data to the QMP CpuInfo type, exposing
>>   the existing s390 cpu-state in QMP. The cpu-state is a representation
>>   more adequate than the ambiguous 'halted' condition.
>>
>>   Changes since original v2:
>>   - fixed cpu-state usage in hw/intc/s390_flic.c, necessary because
>>     master was updated in the meantime
>>   - removed superfluous newline while printing cpu-state
> 
> So this is adding s390x info in query-cpus (presumably for legacy
> callers?)...
> 
Yeah, as long as we have the slow call, the fast data should be in there
as well.
[...]
> 
> ...this is adding the new query-cpus-fast...
> 
[...]
> 
> ...and this is adding the s390x state to query-cpus-fast, right?
> 
Exactly.


-- 
Regards,
 Viktor Mihajlovski
