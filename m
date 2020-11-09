Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569D0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0FD206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NlBWPyqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0FD206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc9QR-00076Q-DL
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kc9Pk-0006MV-BA; Mon, 09 Nov 2020 10:49:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28484
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kc9PY-00049O-QG; Mon, 09 Nov 2020 10:49:04 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A9FWP4D106394; Mon, 9 Nov 2020 10:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id; s=pp1; bh=FCoWNVnx4oAn/Ml+yN+hlTxWvHRLavPdrGYBs0RUcfA=;
 b=NlBWPyqw72QSdolvhbi7NHPDG5ABcSl+mAxjmrp9HoENanTdVa3NWyxmmISzhjQ/qkHa
 h/DtGl8skhv0VCTLCSRjGZgYJm9mxh49/tQ13R/3f9KT97+qYQ3XAA4hWWD3UFQ7Y9lg
 Yb3dS1wayfuqlNJj/udbqPmhSg7/p+o8KJ66AAnjkS510e0XwWoCNn+f7Myr146jL2dw
 orL3FbXmrHbVi1OfgYlU+jVKiAJaSXd4wdunafe//7lBI5XrLLyNYhEoV7rLIu+o53WE
 WoTdjjHrrnoiW3HNdvK4/hGvki8UNhLoR1yujVBzzesHvlHByO9GiB/JnT402VKanhHs NA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34q59302d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2020 10:48:48 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A9FWg5b112066;
 Mon, 9 Nov 2020 10:48:47 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34q59302cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2020 10:48:47 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A9FSPgo016218;
 Mon, 9 Nov 2020 15:48:45 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03fra.de.ibm.com with ESMTP id 34q08407y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2020 15:48:45 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A9FmgVB55640410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2020 15:48:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65A44A4051;
 Mon,  9 Nov 2020 15:48:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26A81A4055;
 Mon,  9 Nov 2020 15:48:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2020 15:48:42 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 1/1] virtio-blk-ccw: tweak the default for num_queues
Date: Mon,  9 Nov 2020 16:48:31 +0100
Message-Id: <20201109154831.20779-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-09_08:2020-11-05,
 2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 10:48:48
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the default value of num_queues is effectively 1 for
virtio-blk-ccw. Recently 9445e1e15e ("virtio-blk-pci: default num_queues
to -smp N") changed the default for pci to the number of vcpus, citing
interrupt better locality and better performance as a rationale.

While virtio-blk-ccw does not yet benefit from better interrupt
locality, measurements have shown that for secure VMs multiqueue does
help with performance. Since the bounce buffering happens with the queue
lock held (in the guest) this is hardly a surprise.

As for non-secure VMs the extra queues shouldn't hurt too much.

Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---

We would prefer to land this for 5.2. If we do then commit 9445e1e15e
("virtio-blk-pci: default num_queues to -smp N") took care of all the
necessary compat handling.

If that's not possible, I will send a version that does the necessary
compat handling.
---
 hw/s390x/virtio-ccw-blk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
index 2294ce1ce4..7296140dde 100644
--- a/hw/s390x/virtio-ccw-blk.c
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
@@ -20,6 +21,11 @@ static void virtio_ccw_blk_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIOBlkCcw *dev = VIRTIO_BLK_CCW(ccw_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIOBlkConf *conf = &dev->vdev.conf;
+
+    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
+        conf->num_queues = MIN(4, current_machine->smp.cpus);
+    }
 
     qdev_realize(vdev, BUS(&ccw_dev->bus), errp);
 }

base-commit: 2a190a7256a3e0563b29ffd67e0164097b4a6dac
-- 
2.17.1


