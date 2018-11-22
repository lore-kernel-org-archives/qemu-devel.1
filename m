Received: from eggs.gnu.org ([2001:4830:134:3::10]:59425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gPrxc-0007ef-BH
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gPrxa-0000Dh-C8
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gPrxa-00009u-3T
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAMGYHc2059920
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 11:36:09 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nwwu0e805-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 11:36:09 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 22 Nov 2018 16:36:06 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 22 Nov 2018 17:35:53 +0100
In-Reply-To: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1542904555-1136-5-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 4/6] s390x/cpumodel: Set up CPU model for
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
 target/s390x/gen-features.c     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 60cfeba..c464abf 100644
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
index 5fc7e7b..3f22780 100644
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
index 7c253ff..6b5e94b 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -788,6 +788,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
         { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
         { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
+        { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 70015ea..b051221 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -448,6 +448,7 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_EDAT_2,
     S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
     S390_FEAT_AP_QUERY_CONFIG_INFO,
+    S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
     S390_FEAT_AP_FACILITIES_TEST,
     S390_FEAT_AP,
 };
-- 
2.7.4
