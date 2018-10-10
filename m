Received: from eggs.gnu.org ([2001:4830:134:3::10]:40913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAHtY-0004Mg-Hv
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAHtV-0006FZ-Nx
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:03:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gAHtV-0006B4-DE
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:03:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9AGxU0s136511
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 13:03:23 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1jqhgccj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 13:03:23 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Wed, 10 Oct 2018 11:03:22 -0600
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 10 Oct 2018 13:03:02 -0400
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20181010170309.12045-1-akrowiak@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v11 0/6] s390x: vfio-ap: guest dedicated crypto
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
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com, fiuczy@linux.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

This patch series is the QEMU counterpart to the KVM/kernel support for 
guest dedicated crypto adapters. The KVM/kernel model is built on the 
VFIO mediated device framework and provides the infrastructure for 
granting exclusive guest access to crypto devices installed on the linux 
host. This patch series introduces a new QEMU command line option, QEMU 
object model and CPU model features to exploit the KVM/kernel model.

See the detailed specifications for AP virtualization provided by this 
patch set in docs/vfio-ap.txt for a more complete discussion of the 
design introduced by this patch series.

v10 => v11 Change log:
=====================
* Replaced DO_UPCAST macros in ap.c
* Initializing GError in vfio_ap_get_group() function (BUG)
* Updated s390 maintainers with new files in MAINTAINERS
* Fixed memory leak in vfio_ap_get_group() function

v9 => v10 Change log:
====================
* Removed KVM_S390_VM_CPU_FEAT_AP feature from kvm.h
* Moved check for KVM_S390_VM_CRYPTO_ENABLE_APIE from patch 2/6 to patch
  3/6
* Removed vfio from all function names in ap-bridge.c 
* Removed unused macros and structure from ap-bridge.h
* Removed unused macros from ap-device.h

v8 => v9 Change log:
===================
* Removed all references to VFIO in AP bridge and bus
* Expose AP feature only if the KVM_S390_VM_CRYPTO_ENABLE_APIE VM attribute
  is exposed by KVM - i.e., if AP instructions are available on the linux
  host.
* Enable AP interpretation only if AP feature is switched on; no need to
  disable because it is disabled by default.

v7 => v8 Change log:
===================
* Enable SIE interpretation AP instructions if the CPU model feature for
  AP instructions is turned on for the guest.

v6 => v7 Change log;
===================
* Changed email address for Signed-off-by

v5 => v6 Change log:
===================
* Added reset handling fo vfio-ap device
* Added a bridge/bus to AP device object model - thanks to Halil Pasic

v4 => v5 Change log:
===================
* Added MAINTAINERS entries for VFIO AP
* Added explanation for why we are only supporting zEC12 and newer CPU 
  models.
* Changed CPU model feature qci=on|off to apqci=on|off
* Misc. minor changes

v3 => v4 Change log:
===================
* Made vfio-ap device unpluggable for now
* Renamed command line CPU model feature for QCI: qci=on -> apqci=on
* Removed call to KVM_S390_VM_CRYPTO_INTERPRET_AP ioctl - ioctl was 
  removed from kernel and AP instruction interpretation is set from the
  VFIO device driver
* Added check to ensure only one vfio-ap device can be configured per 
  guest
* Removed AP instruction interception handlers: AP instructions will be 
  interpreted by default if AP facilities are installed to handle the case
  where feature ap=on and no vfio-ap device is configured for the guest.


Tony Krowiak (6):
  linux-headers: linux header updates for AP support
  s390x/cpumodel: Set up CPU model for AP device support
  s390x/kvm: enable AP instruction interpretation for guest
  s390x/ap: base Adjunct Processor (AP) object model
  s390x/vfio: ap: Introduce VFIO AP device
  s390: doc: detailed specifications for AP virtualization

 MAINTAINERS                       |  16 +
 default-configs/s390x-softmmu.mak |   1 +
 docs/vfio-ap.txt                  | 825 ++++++++++++++++++++++++++++++
 hw/s390x/Makefile.objs            |   2 +
 hw/s390x/ap-bridge.c              |  78 +++
 hw/s390x/ap-device.c              |  38 ++
 hw/s390x/s390-virtio-ccw.c        |   4 +
 hw/vfio/Makefile.objs             |   1 +
 hw/vfio/ap.c                      | 179 +++++++
 include/hw/s390x/ap-bridge.h      |  19 +
 include/hw/s390x/ap-device.h      |  22 +
 include/hw/vfio/vfio-common.h     |   1 +
 linux-headers/asm-s390/kvm.h      |   2 +
 linux-headers/linux/vfio.h        |   2 +
 target/s390x/cpu_features.c       |   3 +
 target/s390x/cpu_features_def.h   |   3 +
 target/s390x/cpu_models.c         |   2 +
 target/s390x/gen-features.c       |   3 +
 target/s390x/kvm.c                |  19 +
 19 files changed, 1220 insertions(+)
 create mode 100644 docs/vfio-ap.txt
 create mode 100644 hw/s390x/ap-bridge.c
 create mode 100644 hw/s390x/ap-device.c
 create mode 100644 hw/vfio/ap.c
 create mode 100644 include/hw/s390x/ap-bridge.h
 create mode 100644 include/hw/s390x/ap-device.h

-- 
2.19.0.221.g150f307
