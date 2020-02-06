Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5EBC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F03214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F03214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izpE7-0002yK-0H
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 17:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1izoxd-0002xR-JZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1izoxb-0007MI-3P
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1izoxa-0007IO-ME
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:18 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 016LienJ129141
 for <qemu-devel@nongnu.org>; Thu, 6 Feb 2020 16:45:17 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y0mpnnspj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 16:45:17 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Thu, 6 Feb 2020 21:45:15 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Feb 2020 21:45:12 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 016LjALS38666242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Feb 2020 21:45:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B32B5A404D;
 Thu,  6 Feb 2020 21:45:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CBF4A405B;
 Thu,  6 Feb 2020 21:45:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu,  6 Feb 2020 21:45:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 1C3F9E0289; Thu,  6 Feb 2020 22:45:09 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: [RFC PATCH v2 7/7] vfio-ccw: Add support for the CRW irq
Date: Thu,  6 Feb 2020 22:45:09 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206214509.16434-1-farman@linux.ibm.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20020621-0028-0000-0000-000003D81F4C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020621-0029-0000-0000-0000249C82A4
Message-Id: <20200206214509.16434-8-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-06_04:2020-02-06,
 2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060158
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Farhan Ali <alifm@linux.ibm.com>

The CRW irq will be used by vfio-ccw to notify the userspace
about any CRWs the userspace needs to handle. Let's add support
for it.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v1->v2:
     - Add a loop to continually read region while data is
       present, queueing CRWs as found [CH]
    v0->v1: [EF]
     - Check vcdev->crw_region before registering the irq,
       in case host kernel does not have matching support
     - Split the refactoring changes to an earlier (new) patch
       (and don't remove the "num_irqs" check in the register
       routine, but adjust it to the check the input variable)
     - Don't revert the cool vfio_set_irq_signaling() stuff
     - Unregister CRW IRQ before IO IRQ in unrealize
     - s/crw1/crw0/

 hw/vfio/ccw.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 044441a277..5e3d446213 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -48,6 +48,7 @@ struct VFIOCCWDevice {
     uint64_t crw_region_offset;
     struct ccw_crw_region *crw_region;
     EventNotifier io_notifier;
+    EventNotifier crw_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
 };
@@ -265,6 +266,40 @@ static void vfio_ccw_reset(DeviceState *dev)
     ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
 }
 
+static void vfio_ccw_crw_notifier_handler(void *opaque)
+{
+    VFIOCCWDevice *vcdev = opaque;
+    struct ccw_crw_region *region = vcdev->crw_region;
+    CRW crw;
+    int size;
+    uint8_t rsc, erc;
+
+    if (!event_notifier_test_and_clear(&vcdev->crw_notifier)) {
+        return;
+    }
+
+    do {
+        memset(region, 0, sizeof(*region));
+        size = pread(vcdev->vdev.fd, region, vcdev->crw_region_size,
+                     vcdev->crw_region_offset);
+
+        if (size == -1) {
+            error_report("vfio-ccw: Read crw region failed with errno=%d", errno);
+            break;
+        }
+
+        if (size == 0 || region->crw0 == 0) {
+            /* No more CRWs to queue */
+            break;
+        }
+
+        memcpy(&crw, &region->crw0, sizeof(CRW));
+        rsc = (crw.flags & 0x0f00) >> 8;
+        erc = crw.flags & 0x003f;
+        css_queue_crw(rsc, erc, 0, 0, crw.rsid);
+    } while (1);
+}
+
 static void vfio_ccw_io_notifier_handler(void *opaque)
 {
     VFIOCCWDevice *vcdev = opaque;
@@ -351,6 +386,10 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         notifier = &vcdev->io_notifier;
         fd_read = vfio_ccw_io_notifier_handler;
         break;
+    case VFIO_CCW_CRW_IRQ_INDEX:
+        notifier = &vcdev->crw_notifier;
+        fd_read = vfio_ccw_crw_notifier_handler;
+        break;
     default:
         error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
         return;
@@ -401,6 +440,9 @@ static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
     case VFIO_CCW_IO_IRQ_INDEX:
         notifier = &vcdev->io_notifier;
         break;
+    case VFIO_CCW_CRW_IRQ_INDEX:
+        notifier = &vcdev->crw_notifier;
+        break;
     default:
         error_report("vfio: Unsupported device irq(%d)", irq);
         return;
@@ -621,6 +663,14 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_notifier_err;
     }
 
+    if (vcdev->crw_region) {
+        vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX, &err);
+        if (err) {
+            vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
+            goto out_notifier_err;
+        }
+    }
+
     return;
 
 out_notifier_err:
@@ -645,6 +695,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIOGroup *group = vcdev->vdev.group;
 
+    vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX);
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
     vfio_ccw_put_device(vcdev);
-- 
2.17.1


