Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7EFC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFF321741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FkBHSHai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFF321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKqk-0001R5-03
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izKm8-0002nZ-Ve
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izKm7-0003qJ-9p
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:31:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izKm6-0003kC-W2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:31:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DOCZS105859;
 Wed, 5 Feb 2020 13:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=GjUL5a4kyniTF1SvYXJbBhI25MMEyM1X8rbW5G5+EGw=;
 b=FkBHSHaiOxQ3Vp1sZpaVTSS+MHsbVrQiza5tOOWVLb4l9aGGtb6gcCGPKZ77DDSH7wl8
 lo1J9opDmtMdzMGh1R/1276NWf21KiTTtDnSS8nYdioty1y9iKHghBNUfE/DKeH6yHGc
 x3lE1u1cZWbGdEjWajIvyavy9ke/Kw310ikJhja4vE2G74OYbocpBD6mfHHl9Q9o06RB
 ixp2ZvgfiCqwlw53JjJxR3cMQsQJP9H1E+/Oyzqehq+eZ6UH5gVRHbFdIMD1Ppcb6ZJP
 HM/C+l3gOCfim1SSAdWQRggd4j5CqWAVUdIKHt6vMHjxbHdgsVMKFrTA4ggBrUXjYNfy 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2xykbp2yt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:31:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DT3uF138075;
 Wed, 5 Feb 2020 13:31:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2xymusr4vj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:31:24 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015DVNZC014576;
 Wed, 5 Feb 2020 13:31:23 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 05:31:23 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 7A49557DBC4F;
 Wed,  5 Feb 2020 13:31:18 +0000 (GMT)
Date: Wed, 5 Feb 2020 13:31:18 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 20/21] fuzz: add virtio-scsi fuzz target
Message-ID: <20200205133118.wuxamj3lrqsysvce@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-21-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-21-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050109
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:28AM +0000, Bulekov, Alexander wrote:
>The virtio-scsi fuzz target sets up and fuzzes the available virtio-scsi
>queues. After an element is placed on a queue, the fuzzer can select
>whether to perform a kick, or continue adding elements.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Similar comments below here about maybe documenting how the fuzz
data is being mapped into actions.

>---
> tests/qtest/fuzz/Makefile.include   |   1 +
> tests/qtest/fuzz/virtio_scsi_fuzz.c | 200 ++++++++++++++++++++++++++++
> 2 files changed, 201 insertions(+)
> create mode 100644 tests/qtest/fuzz/virtio_scsi_fuzz.c
>
>diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
>index 77385777ef..cde3e9636c 100644
>--- a/tests/qtest/fuzz/Makefile.include
>+++ b/tests/qtest/fuzz/Makefile.include
>@@ -9,6 +9,7 @@ fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
> # Targets
> fuzz-obj-y += tests/qtest/fuzz/i440fx_fuzz.o
> fuzz-obj-y += tests/qtest/fuzz/virtio_net_fuzz.o
>+fuzz-obj-y += tests/qtest/fuzz/virtio_scsi_fuzz.o
>
> FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
>
>diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
>new file mode 100644
>index 0000000000..ee7ca5448c
>--- /dev/null
>+++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
>@@ -0,0 +1,200 @@
>+/*
>+ * virtio-serial Fuzzing Target
>+ *
>+ * Copyright Red Hat Inc., 2019
>+ *
>+ * Authors:
>+ *  Alexander Bulekov   <alxndr@bu.edu>
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
>+ * See the COPYING file in the top-level directory.
>+ */
>+
>+#include "qemu/osdep.h"
>+
>+#include "tests/qtest/libqtest.h"
>+#include "tests/qtest/libqos/virtio-net.h"
>+#include "libqos/virtio-scsi.h"
>+#include "libqos/virtio.h"
>+#include "libqos/virtio-pci.h"
>+#include "standard-headers/linux/virtio_ids.h"
>+#include "standard-headers/linux/virtio_pci.h"
>+#include "standard-headers/linux/virtio_scsi.h"
>+#include "fuzz.h"
>+#include "fork_fuzz.h"
>+#include "qos_fuzz.h"
>+
>+#define PCI_SLOT                0x02
>+#define PCI_FN                  0x00
>+#define QVIRTIO_SCSI_TIMEOUT_US (1 * 1000 * 1000)
>+
>+#define MAX_NUM_QUEUES 64
>+
>+/* Based on tests/virtio-scsi-test.c */
>+typedef struct {
>+    int num_queues;
>+    QVirtQueue *vq[MAX_NUM_QUEUES + 2];
>+} QVirtioSCSIQueues;
>+
>+static QVirtioSCSIQueues *qvirtio_scsi_init(QVirtioDevice *dev, uint64_t mask)
>+{
>+    QVirtioSCSIQueues *vs;
>+    uint64_t feat;
>+    int i;
>+
>+    vs = g_new0(QVirtioSCSIQueues, 1);
>+
>+    feat = qvirtio_get_features(dev);
>+    if (mask) {
>+        feat &= ~QVIRTIO_F_BAD_FEATURE | mask;
>+    } else {
>+        feat &= ~(QVIRTIO_F_BAD_FEATURE | (1ull << VIRTIO_RING_F_EVENT_IDX));
>+    }
>+    qvirtio_set_features(dev, feat);
>+
>+    vs->num_queues = qvirtio_config_readl(dev, 0);
>+
>+    for (i = 0; i < vs->num_queues + 2; i++) {
>+        vs->vq[i] = qvirtqueue_setup(dev, fuzz_qos_alloc, i);
>+    }
>+
>+    qvirtio_set_driver_ok(dev);
>+
>+    return vs;
>+}
>+
>+static void virtio_scsi_fuzz(QTestState *s, QVirtioSCSIQueues* queues,
>+        const unsigned char *Data, size_t Size)
>+{
>+    typedef struct vq_action {
>+        uint8_t queue;
>+        uint8_t length;
>+        uint8_t write;
>+        uint8_t next;
>+        uint8_t kick;
>+    } vq_action;
>+
>+    uint32_t free_head[MAX_NUM_QUEUES + 2] = {0};
>+    QGuestAllocator *t_alloc = fuzz_qos_alloc;
>+
>+    QVirtioSCSI *scsi = fuzz_qos_obj;
>+    QVirtioDevice *dev = scsi->vdev;
>+    QVirtQueue *q;
>+    vq_action vqa;
>+    while (Size >= sizeof(vqa)) {
>+        memcpy(&vqa, Data, sizeof(vqa));
>+
>+        Data += sizeof(vqa);
>+        Size -= sizeof(vqa);
>+
>+        vqa.queue = vqa.queue % queues->num_queues;
>+        vqa.length = vqa.length >= Size ? Size : vqa.length;
>+        vqa.write = vqa.write & 1;
>+        vqa.next = vqa.next & 1;
>+        vqa.kick = vqa.kick & 1;
>+
>+
>+        q = queues->vq[vqa.queue];
>+
>+        uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
>+        qtest_memwrite(s, req_addr, Data, vqa.length);
>+        if (free_head[vqa.queue] == 0) {
>+            free_head[vqa.queue] = qvirtqueue_add(s, q, req_addr, vqa.length,
>+                    vqa.write, vqa.next);
>+        } else {
>+            qvirtqueue_add(s, q, req_addr, vqa.length, vqa.write , vqa.next);
>+        }
>+
>+        if (vqa.kick) {
>+            qvirtqueue_kick(s, dev, q, free_head[vqa.queue]);
>+            free_head[vqa.queue] = 0;
>+        }
>+        Data += vqa.length;
>+        Size -= vqa.length;
>+    }
>+    for (int i = 0; i < MAX_NUM_QUEUES + 2; i++) {
>+        if (free_head[i]) {
>+            qvirtqueue_kick(s, dev, queues->vq[i], free_head[i]);
>+        }
>+    }
>+}
>+
>+static void virtio_scsi_fork_fuzz(QTestState *s,
>+        const unsigned char *Data, size_t Size)
>+{
>+    QVirtioSCSI *scsi = fuzz_qos_obj;
>+    static QVirtioSCSIQueues *queues;
>+    if (!queues) {
>+        queues = qvirtio_scsi_init(scsi->vdev, 0);
>+    }
>+    if (fork() == 0) {
>+        virtio_scsi_fuzz(s, queues, Data, Size);
>+        flush_events(s);
>+        _Exit(0);
>+    } else {
>+        wait(NULL);
>+    }
>+}
>+
>+static void virtio_scsi_with_flag_fuzz(QTestState *s,
>+        const unsigned char *Data, size_t Size)
>+{
>+    QVirtioSCSI *scsi = fuzz_qos_obj;
>+    static QVirtioSCSIQueues *queues;
>+
>+    if (fork() == 0) {
>+        if (Size >= sizeof(uint64_t)) {
>+            queues = qvirtio_scsi_init(scsi->vdev, *(uint64_t *)Data);
>+            virtio_scsi_fuzz(s, queues,
>+                             Data + sizeof(uint64_t), Size - sizeof(uint64_t));
>+            flush_events(s);
>+        }
>+        _Exit(0);
>+    } else {
>+        wait(NULL);
>+    }
>+}
>+
>+static void virtio_scsi_pre_fuzz(QTestState *s)
>+{
>+    qos_init_path(s);
>+    counter_shm_init();
>+}
>+
>+static void *virtio_scsi_test_setup(GString *cmd_line, void *arg)
>+{
>+    g_string_append(cmd_line,
>+                    " -drive file=blkdebug::null-co://,"
>+                    "file.image.read-zeroes=on,"
>+                    "if=none,id=dr1,format=raw,file.align=4k "
>+                    "-device scsi-hd,drive=dr1,lun=0,scsi-id=1");
>+    return arg;
>+}
>+
>+
>+static void register_virtio_scsi_fuzz_targets(void)
>+{
>+    fuzz_add_qos_target(&(FuzzTarget){
>+                .name = "virtio-scsi-fuzz",
>+                .description = "Fuzz the virtio-net virtual queues, forking"
>+                                "for each fuzz run",
>+                .pre_vm_init = &counter_shm_init,
>+                .pre_fuzz = &virtio_scsi_pre_fuzz,
>+                .fuzz = virtio_scsi_fork_fuzz,},
>+                "virtio-scsi",
>+                &(QOSGraphTestOptions){.before = virtio_scsi_test_setup}
>+                );
>+
>+    fuzz_add_qos_target(&(FuzzTarget){
>+                .name = "virtio-scsi-flags-fuzz",
>+                .description = "Fuzz the virtio-net virtual queues, forking"
>+                "for each fuzz run (also fuzzes the virtio flags)",
>+                .pre_vm_init = &counter_shm_init,
>+                .pre_fuzz = &virtio_scsi_pre_fuzz,
>+                .fuzz = virtio_scsi_with_flag_fuzz,},
>+                "virtio-scsi",
>+                &(QOSGraphTestOptions){.before = virtio_scsi_test_setup}
>+                );
>+}
>+
>+fuzz_target_init(register_virtio_scsi_fuzz_targets);
>-- 
>2.23.0
>
>

