Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982DBC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B982070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="awrYB+pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B982070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Ho-0006qF-Nf
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38981)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs78N-00065q-7S
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs78L-0005oZ-Qc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:19 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs787-0004cW-5I; Mon, 29 Jul 2019 11:00:04 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 4794296F7B;
 Mon, 29 Jul 2019 14:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZpK81fx6XE6l/hSz0P+ZXfNWB1SeCveyVlCABZgJXM=;
 b=awrYB+plsm/s1OUAh71fZsCFNeOTQlRJ94w7TtDaxiE+zjOSuPzd+4CeCL+TAw8u0nX+JN
 PkihqvzUFORvIH/fSU5AmppUFLp8TCN1EeFzIiV7mBr0GRgHoZ/1meTGs3V33tQQm0U0uK
 VKxAni9gyWJMGKWQaq695l8GIdLJZh4=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:34 +0200
Message-Id: <20190729145654.14644-14-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZpK81fx6XE6l/hSz0P+ZXfNWB1SeCveyVlCABZgJXM=;
 b=p10ovgey+ZrA/kyoa3sGWCEakO/1MBPiGKeeFmd5ZqgygKwbJlgtlFB2Yv1YYI1XBGvrVi
 x8alyAqLqp3DQ+32oPXq548hY4aTRveBkgq3/IcEAUTJyuLQoLTDGmSug1HYjKwmcoJx4U
 6TUzHYpcEreZzrj6ArIVwwdIl1ggxoA=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412348; a=rsa-sha256; cv=none;
 b=BF1AhShircbwJ/VrxaEilrM087++KSwVoDpybRm7LvYf0nDiszqk9sCE7WY5RXk+9d51LC
 8iKf9unfHNYhktw0JI6Puf7JwZBL5dBtRsY6RXZf5xNb/DCXixNDpMTYArlPIVcBo7JGID
 t4f7gzMXG1cSoGS0OZj0InBM4FBYGcY=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 13/33] hw/scsi/: remove qdev/qbus_reset_all
 call
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace deprecated qdev/bus_reset_all by device/bus_reset_warm.

This does not impact the behavior.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/scsi/lsi53c895a.c  | 4 ++--
 hw/scsi/megasas.c     | 2 +-
 hw/scsi/mptsas.c      | 8 ++++----
 hw/scsi/spapr_vscsi.c | 2 +-
 hw/scsi/virtio-scsi.c | 6 +++---
 hw/scsi/vmw_pvscsi.c  | 4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 10468c1ec1..19197d1fc8 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1861,7 +1861,7 @@ static void lsi_reg_writeb(LSIState *s, int offset,=
 uint8_t val)
         }
         if (val & LSI_SCNTL1_RST) {
             if (!(s->sstat0 & LSI_SSTAT0_RST)) {
-                qbus_reset_all(BUS(&s->bus));
+                bus_reset_warm(BUS(&s->bus));
                 s->sstat0 |=3D LSI_SSTAT0_RST;
                 lsi_script_scsi_interrupt(s, LSI_SIST0_RST, 0);
             }
@@ -1919,7 +1919,7 @@ static void lsi_reg_writeb(LSIState *s, int offset,=
 uint8_t val)
             lsi_execute_script(s);
         }
         if (val & LSI_ISTAT0_SRST) {
-            qdev_reset_all(DEVICE(s));
+            device_reset_warm(DEVICE(s));
         }
         break;
     case 0x16: /* MBOX0 */
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 0c4399930a..68c5538865 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -1438,7 +1438,7 @@ static int megasas_cluster_reset_ld(MegasasState *s=
, MegasasCmd *cmd)
         MegasasCmd *tmp_cmd =3D &s->frames[i];
         if (tmp_cmd->req && tmp_cmd->req->dev->id =3D=3D target_id) {
             SCSIDevice *d =3D tmp_cmd->req->dev;
-            qdev_reset_all(&d->qdev);
+            device_reset_warm(&d->qdev);
         }
     }
     return MFI_STAT_OK;
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 3f94d5ab55..9ae1ebc0f3 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -519,7 +519,7 @@ reply_maybe_async:
             reply.ResponseCode =3D MPI_SCSITASKMGMT_RSP_TM_INVALID_LUN;
             goto out;
         }
-        qdev_reset_all(&sdev->qdev);
+        device_reset_warm(&sdev->qdev);
         break;
=20
     case MPI_SCSITASKMGMT_TASKTYPE_TARGET_RESET:
@@ -535,13 +535,13 @@ reply_maybe_async:
         QTAILQ_FOREACH(kid, &s->bus.qbus.children, sibling) {
             sdev =3D SCSI_DEVICE(kid->child);
             if (sdev->channel =3D=3D 0 && sdev->id =3D=3D req->TargetID)=
 {
-                qdev_reset_all(kid->child);
+                device_reset_warm(kid->child);
             }
         }
         break;
=20
     case MPI_SCSITASKMGMT_TASKTYPE_RESET_BUS:
-        qbus_reset_all(BUS(&s->bus));
+        bus_reset_warm(BUS(&s->bus));
         break;
=20
     default:
@@ -804,7 +804,7 @@ static void mptsas_soft_reset(MPTSASState *s)
     s->intr_mask =3D MPI_HIM_DIM | MPI_HIM_RIM;
     mptsas_update_interrupt(s);
=20
-    qbus_reset_all(BUS(&s->bus));
+    bus_reset_warm(BUS(&s->bus));
     s->intr_status =3D 0;
     s->intr_mask =3D save_mask;
=20
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 0e491c911d..39c6067f48 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -855,7 +855,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
                 break;
             }
=20
-            qdev_reset_all(&d->qdev);
+            device_reset_warm(&d->qdev);
             break;
=20
         case SRP_TSK_ABORT_TASK_SET:
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 8b9e5e2b49..fcf9e3dbde 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -317,7 +317,7 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSC=
SIReq *req)
             goto incorrect_lun;
         }
         s->resetting++;
-        qdev_reset_all(&d->qdev);
+        device_reset_warm(&d->qdev);
         s->resetting--;
         break;
=20
@@ -367,7 +367,7 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSC=
SIReq *req)
         QTAILQ_FOREACH(kid, &s->bus.qbus.children, sibling) {
              d =3D SCSI_DEVICE(kid->child);
              if (d->channel =3D=3D 0 && d->id =3D=3D target) {
-                qdev_reset_all(&d->qdev);
+                device_reset_warm(&d->qdev);
              }
         }
         s->resetting--;
@@ -697,7 +697,7 @@ static void virtio_scsi_reset(VirtIODevice *vdev)
=20
     assert(!s->dataplane_started);
     s->resetting++;
-    qbus_reset_all(BUS(&s->bus));
+    bus_reset_warm(BUS(&s->bus));
     s->resetting--;
=20
     vs->sense_size =3D VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index cda3fc96a0..40fcf808a7 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -441,7 +441,7 @@ static void
 pvscsi_reset_adapter(PVSCSIState *s)
 {
     s->resetting++;
-    qbus_reset_all(BUS(&s->bus));
+    bus_reset_warm(BUS(&s->bus));
     s->resetting--;
     pvscsi_process_completion_queue(s);
     assert(QTAILQ_EMPTY(&s->pending_queue));
@@ -849,7 +849,7 @@ pvscsi_on_cmd_reset_bus(PVSCSIState *s)
     trace_pvscsi_on_cmd_arrived("PVSCSI_CMD_RESET_BUS");
=20
     s->resetting++;
-    qbus_reset_all(BUS(&s->bus));
+    bus_reset_warm(BUS(&s->bus));
     s->resetting--;
     return PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
 }
--=20
2.22.0


