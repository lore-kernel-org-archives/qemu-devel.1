Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB49C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9C520760
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KzX927FJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9C520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQEpi-0007FQ-9s
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kQEjr-0007q2-EP; Wed, 07 Oct 2020 15:04:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9864
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kQEjp-0004c8-E8; Wed, 07 Oct 2020 15:04:35 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 097J2j9N011185; Wed, 7 Oct 2020 15:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=VWa9iQJe6xR3nHQ0EzTralh5Vd/CDAleZG3fRWbq6Yk=;
 b=KzX927FJsEfk+yhNJyYMdo32+g3hniExfRzcVgMDcFlILf6kHUlWrYSh0zZrxYMEf5ro
 DmCAejFQQVnmv69PSCYDs0jbQmL6Ij1zN0qEhnWuiML7+xxBthHZYbg3sVfeYFR55U6f
 FG0IiChcObpyU1NAmjaLDADzVQF4C64msdrtR6ypk7CBl936Of79bJPvN/ryHEyIhkzJ
 SDt8zysNewLbBauzBXmcKpCKdNdJCU48uX2a21qvZUaYE41XpuxkEOrZjXuC+lpBAGjd
 pWqQ26m1iujERJEXrYg5oUUcJtqVmko7qo0zIaYe9ppZrqn5lgN2ZlJSM5nvMSgzGXqY 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 341k938bkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 15:04:32 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 097J4V7q021536;
 Wed, 7 Oct 2020 15:04:31 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 341k938bk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 15:04:31 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 097IlJXi016572;
 Wed, 7 Oct 2020 19:04:31 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02wdc.us.ibm.com with ESMTP id 341car2vyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 19:04:31 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 097J4U0K53936638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Oct 2020 19:04:30 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 970E0AC05F;
 Wed,  7 Oct 2020 19:04:30 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25FA3AC059;
 Wed,  7 Oct 2020 19:04:28 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.60.106])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  7 Oct 2020 19:04:27 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com, thuth@redhat.com
Subject: [PATCH v3 04/10] linux-headers: update against 5.9-rc8
Date: Wed,  7 Oct 2020 15:04:09 -0400
Message-Id: <1602097455-15658-5-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602097455-15658-1-git-send-email-mjrosato@linux.ibm.com>
References: <1602097455-15658-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-07_10:2020-10-07,
 2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=997
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070118
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 15:04:22
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kvm@vger.kernel.org, pmorel@linux.ibm.com, david@redhat.com,
 schnelle@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PLACEHOLDER as the kernel patch driving the need for this ("vfio: Introduce
capability definitions for VFIO_DEVICE_GET_INFO") isn't merged yet.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 linux-headers/linux/kvm.h       |  6 ++--
 linux-headers/linux/vfio.h      | 11 ++++++
 linux-headers/linux/vfio_zdev.h | 78 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 2 deletions(-)
 create mode 100644 linux-headers/linux/vfio_zdev.h

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 6683e2e..43580c7 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -790,9 +790,10 @@ struct kvm_ppc_resize_hpt {
 #define KVM_VM_PPC_HV 1
 #define KVM_VM_PPC_PR 2
 
-/* on MIPS, 0 forces trap & emulate, 1 forces VZ ASE */
-#define KVM_VM_MIPS_TE		0
+/* on MIPS, 0 indicates auto, 1 forces VZ ASE, 2 forces trap & emulate */
+#define KVM_VM_MIPS_AUTO	0
 #define KVM_VM_MIPS_VZ		1
+#define KVM_VM_MIPS_TE		2
 
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
@@ -1035,6 +1036,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_LAST_CPU 184
 #define KVM_CAP_SMALLER_MAXPHYADDR 185
 #define KVM_CAP_S390_DIAG318 186
+#define KVM_CAP_STEAL_TIME 187
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index a906724..467eeab 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -201,8 +201,10 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
 #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
 #define VFIO_DEVICE_FLAGS_AP	(1 << 5)	/* vfio-ap device */
+#define VFIO_DEVICE_FLAGS_CAPS	(1 << 6)	/* Info supports caps */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
+	__u32   cap_offset;	/* Offset within info struct of first cap */
 };
 #define VFIO_DEVICE_GET_INFO		_IO(VFIO_TYPE, VFIO_BASE + 7)
 
@@ -218,6 +220,15 @@ struct vfio_device_info {
 #define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
 #define VFIO_DEVICE_API_AP_STRING		"vfio-ap"
 
+/*
+ * The following capabilities are unique to s390 zPCI devices.  Their contents
+ * are further-defined in vfio_zdev.h
+ */
+#define VFIO_DEVICE_INFO_CAP_ZPCI_BASE		1
+#define VFIO_DEVICE_INFO_CAP_ZPCI_GROUP		2
+#define VFIO_DEVICE_INFO_CAP_ZPCI_UTIL		3
+#define VFIO_DEVICE_INFO_CAP_ZPCI_PFIP		4
+
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
  *				       struct vfio_region_info)
diff --git a/linux-headers/linux/vfio_zdev.h b/linux-headers/linux/vfio_zdev.h
new file mode 100644
index 0000000..b430939
--- /dev/null
+++ b/linux-headers/linux/vfio_zdev.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * VFIO Region definitions for ZPCI devices
+ *
+ * Copyright IBM Corp. 2020
+ *
+ * Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ *            Matthew Rosato <mjrosato@linux.ibm.com>
+ */
+
+#ifndef _VFIO_ZDEV_H_
+#define _VFIO_ZDEV_H_
+
+#include <linux/types.h>
+#include <linux/vfio.h>
+
+/**
+ * VFIO_DEVICE_INFO_CAP_ZPCI_BASE - Base PCI Function information
+ *
+ * This capability provides a set of descriptive information about the
+ * associated PCI function.
+ */
+struct vfio_device_info_cap_zpci_base {
+	struct vfio_info_cap_header header;
+	__u64 start_dma;	/* Start of available DMA addresses */
+	__u64 end_dma;		/* End of available DMA addresses */
+	__u16 pchid;		/* Physical Channel ID */
+	__u16 vfn;		/* Virtual function number */
+	__u16 fmb_length;	/* Measurement Block Length (in bytes) */
+	__u8 pft;		/* PCI Function Type */
+	__u8 gid;		/* PCI function group ID */
+};
+
+/**
+ * VFIO_DEVICE_INFO_CAP_ZPCI_GROUP - Base PCI Function Group information
+ *
+ * This capability provides a set of descriptive information about the group of
+ * PCI functions that the associated device belongs to.
+ */
+struct vfio_device_info_cap_zpci_group {
+	struct vfio_info_cap_header header;
+	__u64 dasm;		/* DMA Address space mask */
+	__u64 msi_addr;		/* MSI address */
+	__u64 flags;
+#define VFIO_DEVICE_INFO_ZPCI_FLAG_REFRESH 1 /* Program-specified TLB refresh */
+	__u16 mui;		/* Measurement Block Update Interval */
+	__u16 noi;		/* Maximum number of MSIs */
+	__u16 maxstbl;		/* Maximum Store Block Length */
+	__u8 version;		/* Supported PCI Version */
+};
+
+/**
+ * VFIO_DEVICE_INFO_CAP_ZPCI_UTIL - Utility String
+ *
+ * This capability provides the utility string for the associated device, which
+ * is a device identifier string made up of EBCDID characters.  'size' specifies
+ * the length of 'util_str'.
+ */
+struct vfio_device_info_cap_zpci_util {
+	struct vfio_info_cap_header header;
+	__u32 size;
+	__u8 util_str[];
+};
+
+/**
+ * VFIO_DEVICE_INFO_CAP_ZPCI_PFIP - PCI Function Path
+ *
+ * This capability provides the PCI function path string, which is an identifier
+ * that describes the internal hardware path of the device. 'size' specifies
+ * the length of 'pfip'.
+ */
+struct vfio_device_info_cap_zpci_pfip {
+	struct vfio_info_cap_header header;
+	__u32 size;
+	__u8 pfip[];
+};
+
+#endif
-- 
1.8.3.1


