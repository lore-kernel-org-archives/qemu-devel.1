Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83A5C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1282070B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1282070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSFk-0003kU-G4
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrn-0001Ao-MM
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrl-0001Us-LI
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRre-0001Mx-3S; Tue, 01 Oct 2019 19:47:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlODv074763; Tue, 1 Oct 2019 19:47:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdv2vpsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:27 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlQa4074887;
 Tue, 1 Oct 2019 19:47:26 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdv2vprx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:26 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjmQj032160;
 Tue, 1 Oct 2019 23:47:27 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma01wdc.us.ibm.com with ESMTP id 2v9y57fga6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:27 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlPgt52429262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:25 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42A2128059;
 Tue,  1 Oct 2019 23:47:25 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2716428058;
 Tue,  1 Oct 2019 23:47:25 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:25 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/97] vhost: fix vhost_log size overflow during migration
Date: Tue,  1 Oct 2019 18:45:04 -0500
Message-Id: <20191001234616.7825-26-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Li Hangjing <lihangjing@baidu.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Hangjing <lihangjing@baidu.com>

When a guest which doesn't support multiqueue is migrated with a multi queues
vhost-user-blk deivce, a crash will occur like:

0 qemu_memfd_alloc (name=<value optimized out>, size=562949953421312, seals=<value optimized out>, fd=0x7f87171fe8b4, errp=0x7f87171fe8a8) at util/memfd.c:153
1 0x00007f883559d7cf in vhost_log_alloc (size=70368744177664, share=true) at hw/virtio/vhost.c:186
2 0x00007f88355a0758 in vhost_log_get (listener=0x7f8838bd7940, enable=1) at qemu-2-12/hw/virtio/vhost.c:211
3 vhost_dev_log_resize (listener=0x7f8838bd7940, enable=1) at hw/virtio/vhost.c:263
4 vhost_migration_log (listener=0x7f8838bd7940, enable=1) at hw/virtio/vhost.c:787
5 0x00007f88355463d6 in memory_global_dirty_log_start () at memory.c:2503
6 0x00007f8835550577 in ram_init_bitmaps (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2173
7 ram_init_all (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2192
8 ram_save_setup (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2219
9 0x00007f88357a419d in qemu_savevm_state_setup (f=0x7f88384ce600) at migration/savevm.c:1002
10 0x00007f883579fc3e in migration_thread (opaque=0x7f8837530400) at migration/migration.c:2382
11 0x00007f8832447893 in start_thread () from /lib64/libpthread.so.0
12 0x00007f8832178bfd in clone () from /lib64/libc.so.6

This is because vhost_get_log_size() returns a overflowed vhost-log size.
In this function, it uses the uninitialized variable vqs->used_phys and
vqs->used_size to get the vhost-log size.

Signed-off-by: Li Hangjing <lihangjing@baidu.com>
Reviewed-by: Xie Yongji <xieyongji@baidu.com>
Reviewed-by: Chai Wen <chaiwen@baidu.com>
Message-Id: <20190603061524.24076-1-lihangjing@baidu.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 240e647a14df9677b3a501f7b8b870e40aac3fd5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/vhost.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7f61018f2a..6d3a013f49 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -131,6 +131,11 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
     }
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
+
+        if (!vq->used_phys && !vq->used_size) {
+            continue;
+        }
+
         vhost_dev_sync_region(dev, section, start_addr, end_addr, vq->used_phys,
                               range_get_last(vq->used_phys, vq->used_size));
     }
@@ -168,6 +173,11 @@ static uint64_t vhost_get_log_size(struct vhost_dev *dev)
     }
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
+
+        if (!vq->used_phys && !vq->used_size) {
+            continue;
+        }
+
         uint64_t last = vq->used_phys + vq->used_size - 1;
         log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
     }
-- 
2.17.1


