Received: from eggs.gnu.org ([2001:4830:134:3::10]:39597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gIWj4-0001r9-23
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gIWj1-0004G1-1x
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gIWj0-0004At-N6
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA2ATgaB120256
	for <qemu-devel@nongnu.org>; Fri, 2 Nov 2018 06:30:34 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ngmkwrmys-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:30:34 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 2 Nov 2018 10:30:31 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri,  2 Nov 2018 11:30:18 +0100
In-Reply-To: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
References: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1541154621-22423-3-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v1 2/5] s390x/cpumodel: Set up CPU model for
 AQIC interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

A new CPU model facilities is introduced to support AP devices
interruption interception for a KVM guest.

CPU model facility:

The S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, CPU facility indicates
whether AP interruption interception is available to the guest.
This feature will be enabled only if the AP instructions are
available on the linux host and AQIC facility is installed on
the host.

This feature must be turned on from userspace to intercept AP
instructions on the KVM guest. The QEMU command line to turn
this feature on looks something like this:

    qemu-system-s390x ... -cpu xxx,aqci=on ...

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 target/s390x/cpu_features.c     | 1 +
 target/s390x/cpu_features_def.h | 1 +
 target/s390x/cpu_models.c       | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 60cfeba48f..c464abf30a 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -84,6 +84,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("sema", S390_FEAT_TYPE_STFL, 59, "Semaphore-assist facility"),
     FEAT_INIT("tsi", S390_FEAT_TYPE_STFL, 60, "Time-slice Instrumentation facility"),
     FEAT_INIT("ri", S390_FEAT_TYPE_STFL, 64, "CPU runtime-instrumentation facility"),
+    FEAT_INIT("aqic", S390_FEAT_TYPE_STFL, 65, "AP-Queue interruption Control facility"),
     FEAT_INIT("zpci", S390_FEAT_TYPE_STFL, 69, "z/PCI facility"),
     FEAT_INIT("aen", S390_FEAT_TYPE_STFL, 71, "General-purpose-adapter-event-notification facility"),
     FEAT_INIT("ais", S390_FEAT_TYPE_STFL, 72, "General-purpose-adapter-interruption-suppression facility"),
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 5fc7e7bf01..3f22780104 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -72,6 +72,7 @@ typedef enum {
     S390_FEAT_SEMAPHORE_ASSIST,
     S390_FEAT_TIME_SLICE_INSTRUMENTATION,
     S390_FEAT_RUNTIME_INSTRUMENTATION,
+    S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
     S390_FEAT_ZPCI,
     S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
     S390_FEAT_ADAPTER_INT_SUPPRESSION,
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7c253ff308..6b5e94b9f6 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -788,6 +788,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
         { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
         { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
+        { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
     };
     int i;
 
-- 
2.17.0
