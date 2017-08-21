Received: from eggs.gnu.org ([2001:4830:134:3::10]:37427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1djijU-0006Az-6J
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1djijO-0002ak-QY
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:10:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54704
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1djijO-0002a3-Kd
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:10:46 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7L998Lu006757
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 05:10:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cfrfgubk0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 05:10:42 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 21 Aug 2017 03:10:42 -0600
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<20170817033554.ip36jmv6kwf7bpbp@tungsten.ozlabs.ibm.com>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 14:40:17 +0530
MIME-Version: 1.0
In-Reply-To: <20170817033554.ip36jmv6kwf7bpbp@tungsten.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <7f67f71b-1661-09cb-1b6f-c8edeaa54144@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] target-ppc/spapr: Add FWNMI support
 in QEMU for PowerKVM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org



On Thursday 17 August 2017 09:05 AM, Sam Bobroff wrote:
> On Wed, Aug 16, 2017 at 02:41:59PM +0530, Aravinda Prasad wrote:
>> This series of patches adds support for FWNMI in PowerKVM guests.
>>
>> Memory error such as bit flips that cannot be corrected
>> by hardware is passed on to the kernel for handling
>> by raising machine check exception (an NMI). Upon such
>> machine check exception, if the address in error belongs
>> to guest then KVM causes a guest exit with KVM_EXIT_NMI
>> exit reason.
>>
>> This patch series adds functionality to pass on such
>> machine check exception to the guest kernel by suitably
>> handling KVM_EXIT_NMI exit and building the error log.
>>
>> The KVM changes are now part of the upstream kernel
>> (commit e20bbd3d). This series contain QEMU changes.
> 
> [snip]
> 
> Hi,
> 
> I'm concerned that this implementation may introduce a problem with
> kexec. If a VM registers an NMI handler, then kexecs to a new kernel
> and an NMI is received before the new kernel has registered it's
> handler, won't QEMU cause the guest to jump to the old, now invalid,
> handler address? Is this worth worrying about?

I think there is a small time window till the kexec kernel registers a
new handler during which NMI can branch to the old invalid address.

Two points of interest. First, I did not find any "ibm,nmi-unregister"
call. Hence, once the VM registers for NMI it cannot unregister it.
Second, if kexec is triggered due to VM crash, then the guest will not
get the opportunity to unregister NMI even in case something similar to
"ibm,nmi-unregister" is available.

Not sure if this is worth handling as machine check NMIs are rare, and
getting a machine check NMI during that small time window is very rare.

Regards,
Aravinda

> 
> Cheers,
> Sam.
> 

-- 
Regards,
Aravinda
