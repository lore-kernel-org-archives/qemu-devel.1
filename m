Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256AEC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8878208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cTBR+Nxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8878208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuA9-0007yM-0B
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hctC1-000744-9x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hctBz-0005rk-Gb
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:05:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hctBt-0005nK-Id; Mon, 17 Jun 2019 11:05:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HF3x6A194676;
 Mon, 17 Jun 2019 15:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=sjPeSH85H7YwPjSGcoXeELaYEDE4MR8f1zSgfJn1kfA=;
 b=cTBR+NxlxSIBDlJ8ADW/XET0Y8IVKDAWzRL564EmJg/m2c3bl+bg2RAT8Dqi2HCDpW33
 srUGgP58SywbibXaY4djHS2/nYNU1TxbLU0dSpGGuiDLeyxfBHDXaK1HBTqk6IgpkmFI
 IP16J7qn8/C6vKNYfIh53GCmYvT4qeAJnm+4evMTHo4bPaBJWPzKRJXFGpIcLUS9jmGL
 B9KokdSeBaawzSf72/NUgRJTE5k8HC59IVWHpynvFqBDCgy+ZImif1GgKpKyb1xjMiDH
 DDEKvSa1xriFJrwSdgKbxQC9U0sv93SMCTHlAucVFPO8uYz/bADoo3zhZhsYr649kTWX fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2t4r3tf5xt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 15:04:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HF3Z4j192210;
 Mon, 17 Jun 2019 15:04:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2t5cpdgasm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 15:04:58 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HF4w9C017506;
 Mon, 17 Jun 2019 15:04:58 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 08:04:58 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Mon, 17 Jun 2019 18:04:19 +0300
Message-Id: <20190617150419.4953-6-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190617150419.4953-1-shmuel.eiderman@oracle.com>
References: <20190617150419.4953-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170136
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [SeaBIOS] [PATCH v2 5/5] geometry: Apply LCHS values
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
introducing a new translation type: "TRANSLATION_MACHINE".

We treat this translation as TRANSLATION_NONE in fill_ata_edd(),
although this does not really matter since now the translation between
physical and logical geometry does not exist.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 src/block.c          | 21 ++++++++++++++++++++-
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
 11 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/src/block.c b/src/block.c
index f73ec18c..ca23a83a 100644
--- a/src/block.c
+++ b/src/block.c
@@ -69,9 +69,17 @@ int create_bounce_buf(void)
  * Disk geometry translation
  ****************************************************************/
 
+static int
+overriden_lchs_supplied(struct drive_s *drive)
+{
+    return drive->lchs.cylinder || drive->lchs.head || drive->lchs.sector;
+}
+
 static u8
 get_translation(struct drive_s *drive)
 {
+    if (overriden_lchs_supplied(drive))
+        return TRANSLATION_MACHINE;
     u8 type = drive->type;
     if (CONFIG_QEMU && type == DTYPE_ATA) {
         // Emulators pass in the translation info via nvram.
@@ -159,6 +167,16 @@ setup_translation(struct drive_s *drive)
                 break;
         }
         break;
+    case TRANSLATION_MACHINE:
+        desc = "overriden";
+        cylinders = drive->lchs.cylinder;
+        heads = drive->lchs.head;
+        if (heads > 255)
+            heads = 255;
+        spt = drive->lchs.sector;
+        if (spt > 63)
+            spt = 63;
+        break;
     }
     // clip to 1024 cylinders in lchs
     if (cylinders > 1024)
@@ -423,7 +441,8 @@ fill_ata_edd(struct segoff_s edd, struct drive_s *drive_gf)
     u16 options = 0;
     if (GET_GLOBALFLAT(drive_gf->type) == DTYPE_ATA) {
         u8 translation = GET_GLOBALFLAT(drive_gf->translation);
-        if (translation != TRANSLATION_NONE) {
+        if ((translation != TRANSLATION_NONE) &&
+            (translation != TRANSLATION_MACHINE)) {
             options |= 1<<3; // CHS translation
             if (translation == TRANSLATION_LBA)
                 options |= 1<<9;
diff --git a/src/block.h b/src/block.h
index f64e8807..12f27eee 100644
--- a/src/block.h
+++ b/src/block.h
@@ -90,6 +90,7 @@ struct drive_s {
 #define TRANSLATION_LBA   1
 #define TRANSLATION_LARGE 2
 #define TRANSLATION_RECHS 3
+#define TRANSLATION_MACHINE 4
 
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


