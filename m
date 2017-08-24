Received: from eggs.gnu.org ([2001:4830:134:3::10]:53349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkmo5-0003NA-LY
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkmo0-0006Zs-O3
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:44:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37550
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dkmo0-0006YX-HM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:43:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7O7hstu090059
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 03:43:55 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2chsgcmx1c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 03:43:54 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 24 Aug 2017 08:43:52 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20170823155458.19601-1-cohuck@redhat.com>
	<20170823155458.19601-4-cohuck@redhat.com>
	<5c445775-eb1c-7f20-94d4-80eda7d4c623@de.ibm.com>
Date: Thu, 24 Aug 2017 09:43:48 +0200
MIME-Version: 1.0
In-Reply-To: <5c445775-eb1c-7f20-94d4-80eda7d4c623@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <87ab396e-437f-27f9-4b31-e4b5417bed74@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/9] s390x/pci: add stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, pasic@linux.vnet.ibm.com



On 08/24/2017 09:38 AM, Christian Borntraeger wrote:
> 
> 
> On 08/23/2017 05:54 PM, Cornelia Huck wrote:
>> Some non-pci code calls into zpci code. Provide some stubs for builds
>> without pci.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  hw/s390x/Makefile.objs   |  3 +-
>>  hw/s390x/s390-pci-stub.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 76 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/s390x/s390-pci-stub.c
>>
>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index b2aade2466..7ee19d3abc 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -11,7 +11,8 @@ obj-y += 3270-ccw.o
>>  obj-y += virtio-ccw.o
>>  obj-y += css-bridge.o
>>  obj-y += ccw-device.o
>> -obj-y += s390-pci-bus.o s390-pci-inst.o
>> +obj-$(CONFIG_PCI) += s390-pci-bus.o s390-pci-inst.o
>> +obj-$(call lnot,$(CONFIG_PCI)) += s390-pci-stub.o
>>  obj-y += s390-skeys.o
>>  obj-y += s390-stattrib.o
>>  obj-$(CONFIG_KVM) += s390-skeys-kvm.o
>> diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
>> new file mode 100644
>> index 0000000000..2e7e42a2af
>> --- /dev/null
>> +++ b/hw/s390x/s390-pci-stub.c
>> @@ -0,0 +1,74 @@
>> +/* stubs for non-pci builds */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +#include "cpu.h"
>> +#include "s390-pci-inst.h"
>> +#include "s390-pci-bus.h"
>> +
>> +/* target/s390x/ioinst.c */
>> +int chsc_sei_nt2_get_event(void *res)
>> +{
>> +    return 1;
>> +}
>> +
>> +int chsc_sei_nt2_have_event(void)
>> +{
>> +    return 0;
>> +}
>> +
>> +/* hw/s390x/sclp.c */
>> +void s390_pci_sclp_configure(SCCB *sccb)
>> +{
>> +}
>> +
>> +void s390_pci_sclp_deconfigure(SCCB *sccb)
>> +{
>> +}
> 
> shouldnt these function set an error code in the sccb, e.g.
> something like
> 
>    sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
> 
> 
> 

Oh you have something like that in patch 7. Maybe move?
