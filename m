Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD636C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8911E20643
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R16DFiKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8911E20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36737 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGO5E-0000mA-Pn
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:25:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNic-0007pQ-Og
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNia-0003WY-Tq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:01:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hGNiY-0003VZ-Vh
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:01:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3GCxRQa038580; Tue, 16 Apr 2019 13:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references : mime-version :
	content-transfer-encoding; s=corp-2018-07-02;
	bh=nzQCwehGS0m8OEqyrIxYTzNMI4+W8+4hirRq2xRSAbo=;
	b=R16DFiKdZ3la1n0XgcEu++bE329aIK4P4gNNgHez4yDp3tg3FvaRltQJGEIILw7HLndH
	D1ndWeWG4cpLvFJHRf7YFTklz/m1+/y63HwSpl9bqIdUCrusnlQmywjrnXPyGZmZt5mh
	6uHnlxT0JSwbDZU4w53jvV+/4v8nfPIfQXKhB88UhbsarTPegqGndH4wsd50Zg8mLhHi
	p1q7kJc3IAJW2aA0LszQsYFp5U0MhCJeBiqVobnlcHyybJhsWYX2nyQ2KzqBqbhzWrg3
	8W/ITfSxDq/VfvA3EJ533YohtRvisohOEqQN9ebddOEbhCxwSU1C+uR2SzBppCFUciN4
	OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 2rvwk3mkj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2019 13:01:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3GCwNwq154506; Tue, 16 Apr 2019 12:59:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 2rubq6ad5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2019 12:59:38 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3GCxcIX007021;
	Tue, 16 Apr 2019 12:59:38 GMT
Received: from spark.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 16 Apr 2019 05:59:37 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 15:59:12 +0300
Message-Id: <20190416125912.44001-4-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125912.44001-1-liran.alon@oracle.com>
References: <20190416125912.44001-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904160088
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904160088
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH v2 3/3] vhost-scsi: Allow user to enable
 migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, stefanha@gmail.com, mtosatti@redhat.com,
	bijan.mottahedeh@oracle.com, Liran Alon <liran.alon@oracle.com>,
	pbonzini@redhat.com, nir.weiner@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125912.oet8ZoOUPBrJeTZGgUJ44aZrZpg14K17f3bOnJXGthA@z>

In order to perform a valid migration of a vhost-scsi device,
the following requirements must be met:
(1) The virtio-scsi device state needs to be saved & loaded.
(2) The vhost backend must be stopped before virtio-scsi device state
is saved:
  (2.1) Sync vhost backend state to virtio-scsi device state.
  (2.2) No further I/O requests are made by vhost backend to target
        SCSI device.
  (2.3) No further guest memory access takes place after VM is stopped.
(3) Requests in-flight to target SCSI device are completed before
    migration handover.
(4) Target SCSI device state needs to be saved & loaded into the
    destination host target SCSI device.

Previous commit ("vhost-scsi: Add VMState descriptor")
add support to save & load the device state using VMState.
This meets requirement (1).

When VM is stopped by migration thread (On Pre-Copy complete), the
following code path is executed:
migration_completion() -> vm_stop_force_state() -> vm_stop() ->
do_vm_stop().

do_vm_stop() calls first pause_all_vcpus() which pause all guest
vCPUs and then call vm_state_notify().
In case of vhost-scsi device, this will lead to the following code path
to be executed:
vm_state_notify() -> virtio_vmstate_change() ->
virtio_set_status() -> vhost_scsi_set_status() -> vhost_scsi_stop().
vhost_scsi_stop() then calls vhost_scsi_clear_endpoint() and
vhost_scsi_common_stop().

vhost_scsi_clear_endpoint() sends VHOST_SCSI_CLEAR_ENDPOINT ioctl to
vhost backend which will reach kernel's vhost_scsi_clear_endpoint()
which process all pending I/O requests and wait for them to complete
(vhost_scsi_flush()). This meets requirement (3).

vhost_scsi_common_stop() will stop the vhost backend.
As part of this stop, dirty-bitmap is synced and vhost backend state is
synced with virtio-scsi device state. As at this point guest vCPUs are
already paused, this meets requirement (2).

At this point we are left with requirement (4) which is target SCSI
device specific and therefore cannot be done by QEMU. Which is the main
reason why vhost-scsi adds a migration blocker.
However, as this can be handled either by an external orchestrator or
by using shared-storage (i.e. iSCSI), there is no reason to limit the
orchestrator from being able to explictly specify it wish to enable
migration even when VM have a vhost-scsi device.

Considering all the above, this commit allows orchestrator to explictly
specify that it is responsbile for taking care of requirement (4) and
therefore vhost-scsi should not add a migration blocker.

Reviewed-by: Nir Weiner <nir.weiner@oracle.com>
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/scsi/vhost-scsi.c                  | 30 ++++++++++++++++++---------
 include/hw/virtio/vhost-scsi-common.h |  1 +
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index eb0cf9e1312f..6b01accf61ad 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -199,13 +199,18 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         goto close_fd;
     }
 
-    error_setg(&vsc->migration_blocker,
-               "vhost-scsi does not support migration");
-    migrate_add_blocker(vsc->migration_blocker, &err);
-    if (err) {
-        error_propagate(errp, err);
-        error_free(vsc->migration_blocker);
-        goto close_fd;
+    if (!vsc->migratable) {
+        error_setg(&vsc->migration_blocker,
+                "vhost-scsi does not support migration in all cases. "
+                "When external environment supports it (Orchestrator migrates "
+                "target SCSI device state or use shared storage over network), "
+                "set 'migratable' property to true to enable migration.");
+        migrate_add_blocker(vsc->migration_blocker, &err);
+        if (err) {
+            error_propagate(errp, err);
+            error_free(vsc->migration_blocker);
+            goto close_fd;
+        }
     }
 
     vsc->dev.nvqs = VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
@@ -230,7 +235,9 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     return;
 
  free_vqs:
-    migrate_del_blocker(vsc->migration_blocker);
+    if (!vsc->migratable) {
+        migrate_del_blocker(vsc->migration_blocker);
+    }
     g_free(vsc->dev.vqs);
  close_fd:
     close(vhostfd);
@@ -243,8 +250,10 @@ static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(dev);
     struct vhost_virtqueue *vqs = vsc->dev.vqs;
 
-    migrate_del_blocker(vsc->migration_blocker);
-    error_free(vsc->migration_blocker);
+    if (!vsc->migratable) {
+        migrate_del_blocker(vsc->migration_blocker);
+        error_free(vsc->migration_blocker);
+    }
 
     /* This will stop vhost backend. */
     vhost_scsi_set_status(vdev, 0);
@@ -268,6 +277,7 @@ static Property vhost_scsi_properties[] = {
     DEFINE_PROP_BIT64("t10_pi", VHostSCSICommon, host_features,
                                                  VIRTIO_SCSI_F_T10_PI,
                                                  false),
+    DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
index 57fb1d87b51d..4eab767ee89f 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -36,6 +36,7 @@ typedef struct VHostSCSICommon {
     int target;
     int lun;
     uint64_t host_features;
+    bool migratable;
 } VHostSCSICommon;
 
 int vhost_scsi_common_start(VHostSCSICommon *vsc);
-- 
2.20.1


