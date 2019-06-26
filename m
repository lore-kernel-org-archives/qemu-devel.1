Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F295CC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0AFE2133F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4QgfNfeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AFE2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg7LF-0001nX-9o
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56011)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7CW-0000OD-0S
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7CU-00070q-Em
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:38:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hg7CK-0006gf-24; Wed, 26 Jun 2019 08:38:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCYFmU193588;
 Wed, 26 Jun 2019 12:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=vw4u7P5c3vYSIdE8uZiQYXD8b354wZY9HMPyn34IPx8=;
 b=4QgfNfeWxnZfV5DcuA5c/ix57x1LYq8Q4Hz6HBIiS0JY08Brgk9J6P9oPokkYy5wRv/u
 Ma8QSlGCLUeBna1KGqeue3rYdirsDX4XqIqow64IDiAVuc6qWfcTWDjoS3hboIvIRFLg
 Lz1k0jzUBA9xDASYT92KhYMyxtcyeDLFlJ1OL/mwTGXzINfWU8ku/sOMby5Zb2QnUxUx
 LyMfL8t7PvxokVqGBbXpbrJky+zP3ICV2B6DwUjkG3l7KgiKgmBCB2XdlNLUnXyi2SET
 Sim8eNWP14IFreij33CIxFB94iKygiIqPIww6EJCy5d8MIWXCFRJLq++g22OWcRjlpHy Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2t9cyqj0h9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:38:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCbWW7096445;
 Wed, 26 Jun 2019 12:38:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2t9accp1c4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:38:45 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QCcjZp019669;
 Wed, 26 Jun 2019 12:38:45 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Jun 2019 05:38:44 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 26 Jun 2019 15:38:16 +0300
Message-Id: <20190626123816.8907-6-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190626123816.8907-1-shmuel.eiderman@oracle.com>
References: <20190626123816.8907-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260150
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [SeaBIOS] [PATCH v4 5/5] geometry: Apply LCHS values
 for boot devices
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
Cc: liran.alon@oracle.com, shmuel.eiderman@oracle.com, karl.heubaum@oracle.com,
 arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Boot devices which use overriden LCHS values are:

    * ata
    * ahci
    * scsi
        * esp
        * lsi
        * megasas
        * mpt
        * pvscsi
        * virtio
    * virtio-blk

We use these values in get_translation() and setup_translation() by
introducing a new translation type: "TRANSLATION_HOST".

We treat this translation as TRANSLATION_NONE in fill_ata_edd(),
although this does not really matter since now the translation between
physical and logical geometry does not exist.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 src/block.c          | 18 +++++++++++++++++-
 src/block.h          |  1 +
 src/hw/ahci.c        |  1 +
 src/hw/ata.c         |  8 ++++++++
 src/hw/esp-scsi.c    |  2 ++
 src/hw/lsi-scsi.c    |  2 ++
 src/hw/megasas.c     |  1 +
 src/hw/mpt-scsi.c    |  2 ++
 src/hw/pvscsi.c      |  1 +
 src/hw/virtio-blk.c  |  2 ++
 src/hw/virtio-scsi.c |  2 ++
 11 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/src/block.c b/src/block.c
index f73ec18c..1f600b85 100644
--- a/src/block.c
+++ b/src/block.c
@@ -69,9 +69,18 @@ int create_bounce_buf(void)
  * Disk geometry translation
  ****************************************************************/
 
+static int
+host_lchs_supplied(struct drive_s *drive)
+{
+    return (drive->lchs.head <= 255 &&
+            drive->lchs.sector > 0 && drive->lchs.sector <= 63);
+}
+
 static u8
 get_translation(struct drive_s *drive)
 {
+    if (host_lchs_supplied(drive))
+        return TRANSLATION_HOST;
     u8 type = drive->type;
     if (CONFIG_QEMU && type == DTYPE_ATA) {
         // Emulators pass in the translation info via nvram.
@@ -159,6 +168,12 @@ setup_translation(struct drive_s *drive)
                 break;
         }
         break;
+    case TRANSLATION_HOST:
+        desc = "host-supplied";
+        cylinders = drive->lchs.cylinder;
+        heads = drive->lchs.head;
+        spt = drive->lchs.sector;
+        break;
     }
     // clip to 1024 cylinders in lchs
     if (cylinders > 1024)
@@ -423,7 +438,8 @@ fill_ata_edd(struct segoff_s edd, struct drive_s *drive_gf)
     u16 options = 0;
     if (GET_GLOBALFLAT(drive_gf->type) == DTYPE_ATA) {
         u8 translation = GET_GLOBALFLAT(drive_gf->translation);
-        if (translation != TRANSLATION_NONE) {
+        if ((translation != TRANSLATION_NONE) &&
+            (translation != TRANSLATION_HOST)) {
             options |= 1<<3; // CHS translation
             if (translation == TRANSLATION_LBA)
                 options |= 1<<9;
diff --git a/src/block.h b/src/block.h
index f64e8807..c1b8d734 100644
--- a/src/block.h
+++ b/src/block.h
@@ -90,6 +90,7 @@ struct drive_s {
 #define TRANSLATION_LBA   1
 #define TRANSLATION_LARGE 2
 #define TRANSLATION_RECHS 3
+#define TRANSLATION_HOST 4
 
 #define EXTTYPE_FLOPPY 0
 #define EXTTYPE_HD 1
diff --git a/src/hw/ahci.c b/src/hw/ahci.c
index 1746e7a1..97a072a1 100644
--- a/src/hw/ahci.c
+++ b/src/hw/ahci.c
@@ -593,6 +593,7 @@ static int ahci_port_setup(struct ahci_port_s *port)
                               , ata_extract_version(buffer));
         port->prio = bootprio_find_ata_device(ctrl->pci_tmp, pnr, 0);
     }
+    boot_lchs_find_ata_device(ctrl->pci_tmp, pnr, 0, &(port->drive.lchs));
     return 0;
 }
 
diff --git a/src/hw/ata.c b/src/hw/ata.c
index b6e073cf..f788ce71 100644
--- a/src/hw/ata.c
+++ b/src/hw/ata.c
@@ -755,6 +755,10 @@ init_drive_atapi(struct atadrive_s *dummy, u16 *buffer)
         int prio = bootprio_find_ata_device(adrive->chan_gf->pci_tmp,
                                             adrive->chan_gf->chanid,
                                             adrive->slave);
+        boot_lchs_find_ata_device(adrive->chan_gf->pci_tmp,
+                                  adrive->chan_gf->chanid,
+                                  adrive->slave,
+                                  &(adrive->drive.lchs));
         boot_add_cd(&adrive->drive, desc, prio);
     }
 
@@ -805,6 +809,10 @@ init_drive_ata(struct atadrive_s *dummy, u16 *buffer)
     int prio = bootprio_find_ata_device(adrive->chan_gf->pci_tmp,
                                         adrive->chan_gf->chanid,
                                         adrive->slave);
+    boot_lchs_find_ata_device(adrive->chan_gf->pci_tmp,
+                              adrive->chan_gf->chanid,
+                              adrive->slave,
+                              &(adrive->drive.lchs));
     // Register with bcv system.
     boot_add_hd(&adrive->drive, desc, prio);
 
diff --git a/src/hw/esp-scsi.c b/src/hw/esp-scsi.c
index ffd86d0f..cc25f227 100644
--- a/src/hw/esp-scsi.c
+++ b/src/hw/esp-scsi.c
@@ -181,6 +181,8 @@ esp_scsi_add_lun(u32 lun, struct drive_s *tmpl_drv)
 
     char *name = znprintf(MAXDESCSIZE, "esp %pP %d:%d",
                           llun->pci, llun->target, llun->lun);
+    boot_lchs_find_scsi_device(llun->pci, llun->target, llun->lun,
+                               &(llun->drive.lchs));
     int prio = bootprio_find_scsi_device(llun->pci, llun->target, llun->lun);
     int ret = scsi_drive_setup(&llun->drive, name, prio);
     free(name);
diff --git a/src/hw/lsi-scsi.c b/src/hw/lsi-scsi.c
index d5fc3e45..cbaa2acd 100644
--- a/src/hw/lsi-scsi.c
+++ b/src/hw/lsi-scsi.c
@@ -158,6 +158,8 @@ lsi_scsi_add_lun(u32 lun, struct drive_s *tmpl_drv)
     lsi_scsi_init_lun(llun, tmpl_llun->pci, tmpl_llun->iobase,
                       tmpl_llun->target, lun);
 
+    boot_lchs_find_scsi_device(llun->pci, llun->target, llun->lun,
+                               &(llun->drive.lchs));
     char *name = znprintf(MAXDESCSIZE, "lsi %pP %d:%d",
                           llun->pci, llun->target, llun->lun);
     int prio = bootprio_find_scsi_device(llun->pci, llun->target, llun->lun);
diff --git a/src/hw/megasas.c b/src/hw/megasas.c
index d2675804..87b8beec 100644
--- a/src/hw/megasas.c
+++ b/src/hw/megasas.c
@@ -225,6 +225,7 @@ megasas_add_lun(struct pci_device *pci, u32 iobase, u8 target, u8 lun)
         free(mlun);
         return -1;
     }
+    boot_lchs_find_scsi_device(pci, target, lun, &(mlun->drive.lchs));
     name = znprintf(MAXDESCSIZE, "MegaRAID SAS (PCI %pP) LD %d:%d"
                     , pci, target, lun);
     prio = bootprio_find_scsi_device(pci, target, lun);
diff --git a/src/hw/mpt-scsi.c b/src/hw/mpt-scsi.c
index 1faede6a..570b2126 100644
--- a/src/hw/mpt-scsi.c
+++ b/src/hw/mpt-scsi.c
@@ -221,6 +221,8 @@ mpt_scsi_add_lun(u32 lun, struct drive_s *tmpl_drv)
     mpt_scsi_init_lun(llun, tmpl_llun->pci, tmpl_llun->iobase,
                       tmpl_llun->target, lun);
 
+    boot_lchs_find_scsi_device(llun->pci, llun->target, llun->lun,
+                               &(llun->drive.lchs));
     char *name = znprintf(MAXDESCSIZE, "mpt %pP %d:%d",
                           llun->pci, llun->target, llun->lun);
     int prio = bootprio_find_scsi_device(llun->pci, llun->target, llun->lun);
diff --git a/src/hw/pvscsi.c b/src/hw/pvscsi.c
index 9d7d68d8..3e5171ad 100644
--- a/src/hw/pvscsi.c
+++ b/src/hw/pvscsi.c
@@ -273,6 +273,7 @@ pvscsi_add_lun(struct pci_device *pci, void *iobase,
     plun->iobase = iobase;
     plun->ring_dsc = ring_dsc;
 
+    boot_lchs_find_scsi_device(pci, target, lun, &(plun->drive.lchs));
     char *name = znprintf(MAXDESCSIZE, "pvscsi %pP %d:%d", pci, target, lun);
     int prio = bootprio_find_scsi_device(pci, target, lun);
     int ret = scsi_drive_setup(&plun->drive, name, prio);
diff --git a/src/hw/virtio-blk.c b/src/hw/virtio-blk.c
index 88d7e54a..3e615b26 100644
--- a/src/hw/virtio-blk.c
+++ b/src/hw/virtio-blk.c
@@ -183,6 +183,8 @@ init_virtio_blk(void *data)
 
     status |= VIRTIO_CONFIG_S_DRIVER_OK;
     vp_set_status(&vdrive->vp, status);
+
+    boot_lchs_find_pci_device(pci, &vdrive->drive.lchs);
     return;
 
 fail:
diff --git a/src/hw/virtio-scsi.c b/src/hw/virtio-scsi.c
index a87cad88..e1e2f5d4 100644
--- a/src/hw/virtio-scsi.c
+++ b/src/hw/virtio-scsi.c
@@ -121,6 +121,8 @@ virtio_scsi_add_lun(u32 lun, struct drive_s *tmpl_drv)
     virtio_scsi_init_lun(vlun, tmpl_vlun->pci, tmpl_vlun->vp, tmpl_vlun->vq,
                          tmpl_vlun->target, lun);
 
+    boot_lchs_find_scsi_device(vlun->pci, vlun->target, vlun->lun,
+                               &(vlun->drive.lchs));
     int prio = bootprio_find_scsi_device(vlun->pci, vlun->target, vlun->lun);
     int ret = scsi_drive_setup(&vlun->drive, "virtio-scsi", prio);
     if (ret)
-- 
2.13.3


