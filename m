Received: from eggs.gnu.org ([209.51.188.92]:32852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gvnDu-0001ya-SX
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gvnDs-0000Se-JF
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:00:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gvnDh-0007yB-O5
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:00:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1IHrjKV086846
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:00:19 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qqx7gbhjt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:00:18 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Mon, 18 Feb 2019 18:00:18 -0000
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 18 Feb 2019 13:00:00 -0500
In-Reply-To: <1550512800-9922-1-git-send-email-akrowiak@linux.ibm.com>
References: <1550512800-9922-1-git-send-email-akrowiak@linux.ibm.com>
Message-Id: <1550512800-9922-3-git-send-email-akrowiak@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/2] s390x/vfio-ap: document hot plug/unplug
 of vfio-ap device
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

Let's update the vfio-ap.txt document to include the hot plug/unplug
support introduced in this patch set.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 docs/vfio-ap.txt | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/docs/vfio-ap.txt b/docs/vfio-ap.txt
index 12339684cd52..fae40f218620 100644
--- a/docs/vfio-ap.txt
+++ b/docs/vfio-ap.txt
@@ -440,8 +440,7 @@ unassign_control_domain
    'unassign_domain' file. This may be done multiple times to unassign more than
    one control domain.
 
-Notes: Hot plug/unplug is not currently supported for mediated AP matrix
-devices, so no changes to the AP matrix will be allowed while a guest using
+Notes: No changes to the AP matrix will be allowed while a guest using
 the mediated matrix device is running. Attempts to assign an adapter,
 domain or control domain will be rejected and an error (EBUSY) returned.
 
@@ -562,6 +561,51 @@ facilities:
                      for guest usage, no AP devices can be made accessible to a
                      guest started without APFT installed.
 
+Hot plug a vfio-ap device into a running guest:
+==============================================
+Only one vfio-ap device can be attached to the guest's ap-bus, so a vfio-ap
+device can be hot plugged if and only if the 
+'-device vfio-ap,sysfsdev=$path-to-mdev' option was NOT specified on the QEMU
+command line when the guest was started.
+
+To hot plug a vfio-ap device, use the QEMU device_add command:
+
+    (qemu) device_add vfio-ap,sysfsdev="$path-to-mdev"
+
+    Where the '$path-to-mdev' value specifies the absolute path to a mediated
+    device configured with an AP matrix identifying the AP resources assigned
+    to the guest.
+
+The AP devices will be created in the /sys/bus/ap/devices directory on the
+guest when the AP bus subsequently performs its periodic scan, so there may be
+a short delay before the AP devices are accessible on the guest.
+
+The command will fail if:
+
+* The KVM guest was started with the '-device vfio-ap,sysfs=$path-to-mdev'
+  QEMU command line option.
+
+* The CPU model features for controlling guest access to AP facilities are not
+  enabled (see 'CPU model features' subsection in the previous section).
+
+Hot unplug a vfio-ap device from a running guest:
+================================================
+A vfio-ap device can be unplugged from a running KVM guest if the
+'-device vfio-ap,sysfsdev=$path-to-mdev' option was specified on the QEMU
+command line when the guest was started.
+
+To hot unplug a vfio-ap device, use the QEMU device_del command:
+
+    (qemu) device_del vfio-ap,sysfsdev="$path-to-mdev"
+
+The AP devices will be removed from the /sys/bus/ap/devices directory on the
+guest when the AP bus subsequently performs its periodic scan, so there may be
+a short delay before the AP devices are no longer accessible by the guest.
+
+The command will fail if the $path-to-mdev specified on the device_del command
+does not match the value specified on the '-device vfio-ap,sysfs=$path-to-mdev'
+QEMU command line used to start the guest.
+
 Example: Configure AP Matrixes for Three Linux Guests:
 =====================================================
 Let's now provide an example to illustrate how KVM guests may be given
@@ -819,7 +863,11 @@ Limitations
   assigned lest the host be given access to the private data of the AP queue
   device, such as a private key configured specifically for the guest.
 
-* Dynamically modifying the AP matrix for a running guest (which would amount to
-  hot(un)plug of AP devices for the guest) is currently not supported
+* Dynamically assigning AP resources to or unassigning AP resources from a
+  mediated matrix device - see 'Configuring an AP matrix for a linux guest'
+  section above - while a running guest is using it is currently not supported.
 
-* Live guest migration is not supported for guests using AP devices.
+* Live guest migration is not supported for guests using AP devices. If a guest
+  is using AP devices, the vfio-ap device configured for the guest must be
+  unplugged before migrating the guest (see 'Hot unplug a vfio-ap device from a
+  running guest' section above.
-- 
2.7.4
