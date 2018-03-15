Received: from eggs.gnu.org ([2001:4830:134:3::10]:57902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ewcae-0004M4-H9
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 19:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ewcaZ-0006YE-Kh
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 19:47:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1ewcaZ-0006Xo-Br
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 19:47:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2FNO0c8136421
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 19:25:45 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gqxyf88dt-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 19:25:44 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Thu, 15 Mar 2018 17:25:10 -0600
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 19:24:53 -0400
Message-Id: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/7] s390x: vfio-ap: guest dedicated crypto
 adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com

This patch series is the QEMU counterpart to the KVM/kernel support for 
guest dedicated crypto adapters. The KVM/kernel model is built on the 
VFIO mediated device framework and provides the infrastructure for 
granting exclusive guest access to crypto devices installed on the linux 
host. This patch series introduces a new QEMU command line option, QEMU 
object model and CPU model features to exploit the KVM/kernel model.

See the detailed specifications for AP virtualization provided by this 
patch set in docs/vfio-ap.txt for a more complete discussion of the 
design introduced by this patch series.

v2 -> v3 Change log:
===================
* The corresponding KVM/kernel patch series defined a new device attribute
  to the KVM_S390_VM_CRYPTO attribute group to set interpretive execution
  of AP instructions for the guest. Now, when the vfio-ap device is 
  realized, the KVM_SET_DEVICE_ATTR ioctl is invoked to enable 
  interpretation of AP instructions executed on the guest.

* When the CPU model feature indicating AP instructions are supported for
  the guest (i.e., -cpu xxxx,ap=on), the expectation is that the AP bus 
  will be initialized on the guest. In v2, however; AP instructions were
  intercepted unless a vfio-ap device (i.e., -device vfio-ap,sysfsdev=$path)
  was defined for the guest. Since there were no handlers defined to 
  process intercepted AP instructions, an operation exception was injected
  into the guest causing the AP bus to fail initialization. The v3 version
  adds handlers for intercepted AP instructions that incorporate the 
  following logic:

  If the CPU model indicates AP instructions are installed 
     Set the status response code for the instruction to indicate that
     the APQN contained in the instruction is not valid. This is actually
     true because the AP devices are configured for the guest via the  
     sysfs attribute files of the vfio-ap device, so any APQN would not
     be valid.
   
  Else
     Return an error from the handler. This will cause an operation 
     exception to be injected into the guest in which case the AP bus
     would not initialize. This is the same behavior as exists prior to 
     the introduction of this patch series.

* Miscellaneous code formatting and other trivial changes.

Tony Krowiak (7):
  linux-headers: linux header updates for AP support
  s390x/ap: base Adjunct Processor (AP) object
  s390x/cpumodel: Set up CPU model for AP device support
  s390x/kvm: interface to interpret AP instructions
  s390x/vfio: ap: Introduce VFIO AP device
  s390x/kvm: handle AP instruction interception
  s390: doc: detailed specifications for AP virtualization

 default-configs/s390x-softmmu.mak |    1 +
 docs/vfio-ap.txt                  |  624 +++++++++++++++++++++++++++++++++++++
 hw/s390x/Makefile.objs            |    1 +
 hw/s390x/ap-device.c              |   38 +++
 hw/vfio/Makefile.objs             |    1 +
 hw/vfio/ap.c                      |  229 ++++++++++++++
 include/hw/s390x/ap-device.h      |   44 +++
 include/hw/vfio/vfio-common.h     |    1 +
 linux-headers/asm-s390/kvm.h      |    2 +
 linux-headers/linux/vfio.h        |    2 +
 target/s390x/cpu_features.c       |    3 +
 target/s390x/cpu_features_def.h   |    3 +
 target/s390x/cpu_models.c         |    2 +
 target/s390x/gen-features.c       |    3 +
 target/s390x/kvm.c                |   31 ++
 target/s390x/kvm_s390x.h          |    2 +
 16 files changed, 987 insertions(+), 0 deletions(-)
 create mode 100644 docs/vfio-ap.txt
 create mode 100644 hw/s390x/ap-device.c
 create mode 100644 hw/vfio/ap.c
 create mode 100644 include/hw/s390x/ap-device.h
