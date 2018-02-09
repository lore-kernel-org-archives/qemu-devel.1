Received: from eggs.gnu.org ([2001:4830:134:3::10]:32808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ekA0I-00072Z-3y
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:50:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ekA0D-0008T2-8R
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:50:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50402
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ekA0D-0008SN-1e
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:50:13 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w19EnAcs012155
	for <qemu-devel@nongnu.org>; Fri, 9 Feb 2018 09:50:12 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g19w8j46k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 09:50:11 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Fri, 9 Feb 2018 14:50:10 -0000
References: <20180208111732.09869f84@redhat.com>
	<20180208203342.GE13981@localhost.localdomain>
	<f8157f02-4c16-6811-7857-e1ec4d55d49c@linux.vnet.ibm.com>
	<20180209084949.569007d7@redhat.com>
	<20180209142735.GK13981@localhost.localdomain>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 15:50:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180209142735.GK13981@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <48b8aa8e-36f8-1d2c-ee53-d8006cde77bc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com, berrange@redhat.com

On 09.02.2018 15:27, Eduardo Habkost wrote:
[...]
>> I'm keeping it mainly for s390. Viktor, libvirt is still using
>> this field in s390, no?
>>
>> Dropping halted and having management software still using query-cpus
>> because of halted would be a total failure of query-cpus-fast.
> 
> If I understood correctly, the CpuInfoS390::cpu_state field added
> by Viktor in another patch[1] would replace "halted" for the s390
> case.
Right, CPUState.halted is derived from CPUS390XState.cpu_state on s390:
A cpu_state of CPU_STATE_STOPPED or CPU_STATE_CHECK_STOPPED results in
halted = true. This derivation can be done by libvirt for s390.
> 
> I'm assuming QEMU will be able to return that field without
> interrupting the VCPUs.  Viktor, is that correct?
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02032.html
> 
That's correct.
>>
>>>> Also, the code that sets/clears cpu->halted is target-specific,
>>>> so I wouldn't be so sure that simply checking for
>>>> !kvm_irqchip_in_kernel() is enough on all targets.
>>
>> I checked the code and had the impression it was enough, but
>> I don't have experience with other archs. So, would be nice
>> if other archs maintainers could review this. I'll try to ping them.
> 
> I think we need to take a step back and rethink:
> 
> 1) What the field is supposed to mean?  The semantics of "halted"
>    are completely unclear.  What exactly we want to communicate
>    to libvirt/management?
> 2) On which cases the information (whatever it means) is really
>    useful/important?  If you are excluding cases with in-kernel
>    irqchip, you are already excluding most users.
> 
> 
Given that nobody (including myself) sees a need for halted we can
remove it for the fast version of query-cpus without surprising anyone.
[...]

-- 
Regards,
 Viktor Mihajlovski
