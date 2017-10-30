Received: from eggs.gnu.org ([2001:4830:134:3::10]:59183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e9AQg-0004Lu-Dl
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e9AQc-0004eS-El
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:48:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e9AQc-0004dx-60
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:48:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9UDlm1Z135936
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 09:48:29 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dx4qq2s9e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 09:48:29 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 30 Oct 2017 13:48:26 -0000
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<feea3ded-fecc-50ff-fe70-09e63966933b@de.ibm.com>
	<20171030134233.6aaa81a1.cohuck@redhat.com>
	<54504556-d508-e86f-388b-b07fa7576978@de.ibm.com>
	<90f3e3b9-be67-cda8-4ff8-20dac42090c7@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Oct 2017 14:48:23 +0100
MIME-Version: 1.0
In-Reply-To: <90f3e3b9-be67-cda8-4ff8-20dac42090c7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b0bd0d34-548d-b461-7397-9ab92fb4e6fc@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/5][RFC] Refactoring of AIS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org



On 10/30/2017 02:44 PM, Pierre Morel wrote:
> On 30/10/2017 13:44, Christian Borntraeger wrote:
>>
>>
>> On 10/30/2017 01:42 PM, Cornelia Huck wrote:
>>> On Mon, 30 Oct 2017 09:28:09 +0100
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>
>>>> Now I thought about that for a while and I start to think that we cannot implement ais
>>>> in QEMU and cover all cases.
>>>> One aspect was certainly passthrough (like you handled in patch 4).
>>>> Another aspect is that some interrupts might be injected from the kernel - even for
>>>> emulated devices. e.g. virtio-pci together with vhost-net, will inject interrupts via
>>>> the set_irq callback. I think disabling irqfd for these cases is not a good idea.
>>>
>>> Is there still a fallback for irqfd emulation?
>>
>> it might disable dataplane or other things. (it once did). So I think we should not
>> go down this path.
>>
>>>
>>>>
>>>> So what about adding a new KVM capability (for 4.14), fixup the other things in
>>>> QEMU and then bind it to the new capability?
>>>
>>> For 4.15, surely?
>>>
>>> Probably the only way we can make this work correctly...
>>>
> 
> I may have not understand.
> 
> Why do we need a new capability, we already have the KVM_CAP_S390_AIS capability?

To mark a kernel that supports AIS+migration without having to instantiate a flic device.


> The PCI device has a netdev property pointing to a netdev, if this netdev sets the vhost property, can't we test this to know if we can realize this device or not?
> 
> Using virtio-pci instead of virtio-ccw is not the first choice for S390. The use case I see for S390 using virtio-pci is as a fallback in case for the migration of a PCI device the target host does not support AIS or do not have VFIO device and one do not want to modify the guest.

This was just one example. Having the interrupt controller in the kernel, implementing AIS in
qemu is very prone to break something that we have forgotten about.


FWIW, I am testing a guest patch that enables zPCI without AIS. Its as simple as


diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 7b30af5..9b24836 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -953,7 +953,7 @@ static int __init pci_base_init(void)
        if (!s390_pci_probe)
                return 0;
 
-       if (!test_facility(69) || !test_facility(71) || !test_facility(72))
+       if (!test_facility(69) || !test_facility(71))
                return 0;
 
        rc = zpci_debug_init();
diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index ea34086..61f8c82 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <asm/facility.h>
 #include <asm/pci_insn.h>
 #include <asm/pci_debug.h>
 #include <asm/processor.h>
@@ -93,6 +94,8 @@ int zpci_refresh_trans(u64 fn, u64 addr, u64 range)
 /* Set Interruption Controls */
 void zpci_set_irq_ctrl(u16 ctl, char *unused, u8 isc)
 {
+       if (!test_facility(72))
+               return;
        asm volatile (
                "       .insn   rsy,0xeb00000000d1,%[ctl],%[isc],%[u]\n"
                : : [ctl] "d" (ctl), [isc] "d" (isc << 27), [u] "Q" (*unused));
