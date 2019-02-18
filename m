Received: from eggs.gnu.org ([209.51.188.92]:33330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gvovg-0003dB-KR
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 14:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gvovf-0007iu-Qj
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 14:50:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gvovf-0007dZ-FM
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 14:50:15 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1IJi6Hw100095
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:50:13 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qr1r6m5ne-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:50:13 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Mon, 18 Feb 2019 19:50:12 -0000
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 18 Feb 2019 14:49:55 -0500
Message-Id: <1550519397-25359-1-git-send-email-akrowiak@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/2] s390x/vfio-ap: hot plug/unplug vfio-ap
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, akrowiak@linux.ibm.com, fiuczy@linux.ibm.com

This patch series introduces hot plug/unplug of a vfio-ap device.

To hot plug a vfio-ap device, the QEMU device_add function may be used:

   (qemu) device_add vfio-ap,sysfsdev=$path-to-mdev

   Where $path-to-mdev is the absolute path to the mediated matrix device
   to which AP resources to be used by the guest have been assigned.

   A vfio-ap device can be hot plugged only if:

   1. A vfio-ap device has not been attached to the ap-bus (only one is
      allowed per guest) either via the QEMU command line or a prior hot
      plug action.

   2. The guest was started with the CPU model feature for AP enabled
      (e.g., -cpu host,ap=on).

To hot unplug a vfio-ap device, the QEMU device-del function may be used:

   (qemu) device_del vfio-ap,sysfsdev=$path-to-mdev

   Where $path-to-mdev is the absolute path to the mediated matrix device
   specified when the vfio-ap device was attached to the virtual machine's
   ap-bus.

   A vfio-ap device can be hot unplugged only if:

   1. A vfio-ap device has been attached to the virtual machine's ap-abus
      either via the QEMU command line or a prior hot plug action. 

   2. The guest was started with the CPU model feature for AP enabled
      (e.g., -cpu host,ap=on).

Tony Krowiak (2):
  s390x/vfio-ap: Implement hot plug/unplug of vfio-ap device
  s390x/vfio-ap: document hot plug/unplug of vfio-ap device

 docs/vfio-ap.txt     | 58 +++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/s390x/ap-bridge.c | 12 ++++++++++-
 hw/vfio/ap.c         |  2 +-
 3 files changed, 65 insertions(+), 7 deletions(-)

-- 
Changes: v2==>v3
* Split documentation changes into a separate patch
* Grammatical changes recommended by Connie
2.7.4
