Received: from eggs.gnu.org ([2001:4830:134:3::10]:36288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1diigf-0007V7-RV
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1diigc-0001rS-HS
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:55:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1diigc-0001r4-6C
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:55:46 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7IEt5D0045076
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:55:44 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cdxjx81yx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:55:44 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Fri, 18 Aug 2017 08:55:43 -0600
References: <150305073858.13788.4068645609072927349.stgit@aravinda>
	<20170818103318.GB3658@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Fri, 18 Aug 2017 20:25:32 +0530
MIME-Version: 1.0
In-Reply-To: <20170818103318.GB3658@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <51b2e4dc-8785-4d41-8de0-ff77d3e2fe30@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/5] target-ppc/spapr: Add FWNMI support
 in QEMU for PowerKVM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com



On Friday 18 August 2017 04:03 PM, David Gibson wrote:
> On Fri, Aug 18, 2017 at 03:36:44PM +0530, Aravinda Prasad wrote:
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
>> (commit e20bbd3d). This series containe QEMU changes.
>>
>> Change Log v4:
>>     - Included the RTAS_DISP_FULLY_RECOVERED scenario in
>>       patch 4/5.
> 
> You don't seem to have addressed any of the other comments from the
> last round, however.

Unfortunately I did not receive those mails. I got this mail along with
a message that the mails to my account are bouncing. I just now checked
the mailing list web page to see couple of comments. Looking into it..

Regards,
Aravinda

> 
>>
>> Change Log v3:
>>     - Rebased to v2.10.0-rc0 (git://github.com/dgibson/qemu)
>>
>> Change Log v2:
>>     - Added KVM capability
>>     - Serialized multiple NMIs with a conditional wait
>>
>> ---
>>
>> Aravinda Prasad (5):
>>       ppc: spapr: Register and handle HCALL to receive updated RTAS region
>>       ppc: spapr: Handle "ibm,nmi-register" and "ibm,nmi-interlock" RTAS calls
>>       Wrapper function to wait on condition for the main loop mutex
>>       target/ppc: Handle NMI guest exit
>>       ppc: spapr: Enable FWNMI capability
>>
>>
>>  cpus.c                   |    5 ++
>>  hw/ppc/spapr.c           |   12 ++++++
>>  hw/ppc/spapr_hcall.c     |    8 ++++
>>  hw/ppc/spapr_rtas.c      |   52 ++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h   |   14 ++++++-
>>  include/qemu/main-loop.h |    8 ++++
>>  target/ppc/kvm.c         |   93 ++++++++++++++++++++++++++++++++++++++++++++++
>>  target/ppc/kvm_ppc.h     |   82 +++++++++++++++++++++++++++++++++++++++++
>>  8 files changed, 272 insertions(+), 2 deletions(-)
>>
> 

-- 
Regards,
Aravinda
