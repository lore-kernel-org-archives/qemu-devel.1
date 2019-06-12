Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F784C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1298420866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hetaC1v2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1298420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59792 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb2Cc-0008Dq-8L
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46745)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hb24l-0001RY-Bq
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hb1w4-00055w-E6
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:01:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hb1vo-0004Uf-0s; Wed, 12 Jun 2019 08:00:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CBsKuM096692;
 Wed, 12 Jun 2019 12:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=HeClDaNlhSlrH2DGXwHKIi01pxw6OyJgboxWVGdUh3U=;
 b=hetaC1v2qhob0kF7EVWGFxNI/vK5MGQTYn1gITcOa4AbMW/yw+dRhygIFZ3Mznib0fNb
 1LGyhKFHnbeCHlI9YH0CP5dyRaxm1ancz/sGFmz9ruWJjVtUxp5ojShSrFWcIOZAKxpX
 eHbITA4qWyQa2yNkcXK+Hbg2Qm8eE+YXibAOaREmsbxO6R2qdKWQAR0vXH4UXGZ9XiST
 VCAQQ5wKke9GsUnJ9IYzaRE9dJfaLIfF3xuCQCbt9vg/67OUPIs8S2gAwMsItpajpjd3
 gktNqU4rHxYXQOxZJwFA78fY0oWQmPmcPcSGMXOCPvT0Z7WZVSPRbDapVkPJqUdO8kDe 9A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2t04ettx39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 12:00:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CC0C44003094;
 Wed, 12 Jun 2019 12:00:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2t0p9ru221-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 12:00:22 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5CC0MPS020910;
 Wed, 12 Jun 2019 12:00:22 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 05:00:21 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 12 Jun 2019 14:59:39 +0300
Message-Id: <20190612115939.23825-9-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [QEMU] [PATCH v2 8/8] hd-geo-test: Add tests for lchs
 override
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

Add QTest tests to check the logical geometry override option.

The tests in hd-geo-test are out of date - they only test IDE and do not
test interesting MBRs.

I added a few helper functions which will make adding more tests easier.

QTest's fw_cfg helper functions support only legacy fw_cfg, so I had to
read the new fw_cfg layout on my own.

Creating qcow2 disks with specific size and MBR layout is currently
unused - we only use a default empty MBR.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 tests/Makefile.include |   2 +-
 tests/hd-geo-test.c    | 565 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 566 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 46a36c2c95..55ea165ed4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -765,7 +765,7 @@ tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-obj-y)
 tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-img$(EXESUF)
 tests/ipmi-kcs-test$(EXESUF): tests/ipmi-kcs-test.o
 tests/ipmi-bt-test$(EXESUF): tests/ipmi-bt-test.o
-tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
+tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o $(libqos-obj-y)
 tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-y)
 tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
 tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 62eb624726..08eafeb81a 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -17,7 +17,11 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qemu/bswap.h"
+#include "qapi/qmp/qlist.h"
 #include "libqtest.h"
+#include "libqos/fw_cfg.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
 
 #define ARGV_SIZE 256
 
@@ -388,6 +392,557 @@ static void test_ide_drive_cd_0(void)
     qtest_quit(qts);
 }
 
+typedef struct {
+    bool active;
+    uint32_t head;
+    uint32_t sector;
+    uint32_t cyl;
+    uint32_t end_head;
+    uint32_t end_sector;
+    uint32_t end_cyl;
+    uint32_t start_sect;
+    uint32_t nr_sects;
+} MBRpartitions[4];
+
+static MBRpartitions empty_mbr = { {false, 0, 0, 0, 0, 0, 0, 0, 0},
+                                   {false, 0, 0, 0, 0, 0, 0, 0, 0},
+                                   {false, 0, 0, 0, 0, 0, 0, 0, 0},
+                                   {false, 0, 0, 0, 0, 0, 0, 0, 0} };
+
+static char *create_qcow2_with_mbr(MBRpartitions mbr, uint64_t sectors)
+{
+    const char *template = "/tmp/qtest.XXXXXX";
+    char *raw_path = strdup(template);
+    char *qcow2_path = strdup(template);
+    char cmd[100 + 2 * PATH_MAX];
+    uint8_t buf[512];
+    int i, ret, fd, offset;
+    uint64_t qcow2_size = sectors * 512;
+    uint8_t status, parttype, head, sector, cyl;
+
+    offset = 0xbe;
+
+    for (i = 0; i < 4; i++) {
+        status = mbr[i].active ? 0x80 : 0x00;
+        g_assert(mbr[i].head < 256);
+        g_assert(mbr[i].sector < 64);
+        g_assert(mbr[i].cyl < 1024);
+        head = mbr[i].head;
+        sector = mbr[i].sector + ((mbr[i].cyl & 0x300) >> 2);
+        cyl = mbr[i].cyl & 0xff;
+
+        buf[offset + 0x0] = status;
+        buf[offset + 0x1] = head;
+        buf[offset + 0x2] = sector;
+        buf[offset + 0x3] = cyl;
+
+        parttype = 0;
+        g_assert(mbr[i].end_head < 256);
+        g_assert(mbr[i].end_sector < 64);
+        g_assert(mbr[i].end_cyl < 1024);
+        head = mbr[i].end_head;
+        sector = mbr[i].end_sector + ((mbr[i].end_cyl & 0x300) >> 2);
+        cyl = mbr[i].end_cyl & 0xff;
+
+        buf[offset + 0x4] = parttype;
+        buf[offset + 0x5] = head;
+        buf[offset + 0x6] = sector;
+        buf[offset + 0x7] = cyl;
+
+        (*(uint32_t *)&buf[offset + 0x8]) = cpu_to_le32(mbr[i].start_sect);
+        (*(uint32_t *)&buf[offset + 0xc]) = cpu_to_le32(mbr[i].nr_sects);
+
+        offset += 0x10;
+    }
+
+    fd = mkstemp(raw_path);
+    g_assert(fd);
+    close(fd);
+
+    fd = open(raw_path, O_WRONLY);
+    g_assert(fd >= 0);
+    ret = write(fd, buf, sizeof(buf));
+    g_assert(ret == sizeof(buf));
+    close(fd);
+
+    fd = mkstemp(qcow2_path);
+    g_assert(fd);
+    close(fd);
+
+    ret = snprintf(cmd, sizeof(cmd),
+                   "$QTEST_QEMU_IMG convert -f raw -O qcow2 %s %s > /dev/null",
+                   raw_path, qcow2_path);
+    g_assert((0 < ret) && (ret <= sizeof(cmd)));
+    ret = system(cmd);
+    g_assert(ret == 0);
+
+    ret = snprintf(cmd, sizeof(cmd),
+                   "$QTEST_QEMU_IMG resize %s %" PRIu64 " > /dev/null",
+                   qcow2_path, qcow2_size);
+    g_assert((0 < ret) && (ret <= sizeof(cmd)));
+    ret = system(cmd);
+    g_assert(ret == 0);
+
+    unlink(raw_path);
+    free(raw_path);
+
+    return qcow2_path;
+}
+
+struct QemuCfgFile {
+    uint32_t  size;        /* file size */
+    uint16_t  select;      /* write this to 0x510 to read it */
+    uint16_t  reserved;
+    char name[56];
+};
+
+static uint16_t find_fw_cfg_file(QFWCFG *fw_cfg,
+                                 const char *filename)
+{
+    struct QemuCfgFile qfile;
+    uint32_t count, e;
+    uint16_t select;
+
+    count = qfw_cfg_get_u32(fw_cfg, FW_CFG_FILE_DIR);
+    count = be32_to_cpu(count);
+    for (select = 0, e = 0; e < count; e++) {
+        qfw_cfg_read_data(fw_cfg, &qfile, sizeof(qfile));
+        if (!strcmp(filename, qfile.name)) {
+            select = be16_to_cpu(qfile.select);
+        }
+    }
+
+    return select;
+}
+
+static void read_fw_cfg_file(QFWCFG *fw_cfg,
+                             const char *filename,
+                             void *data,
+                             size_t len)
+{
+    uint16_t select = find_fw_cfg_file(fw_cfg, filename);
+
+    g_assert(select);
+
+    qfw_cfg_get(fw_cfg, select, data, len);
+}
+
+#define BOOTDEVICES_MAX_SIZE 10000
+
+typedef struct {
+    uint32_t c;
+    uint32_t h;
+    uint32_t s;
+} CHS;
+
+typedef struct {
+    const char *dev_path;
+    CHS chs;
+} CHSResult;
+
+static void read_bootdevices(QFWCFG *fw_cfg, CHSResult expected[])
+{
+    uint32_t info_size;
+    char *buf = g_malloc0(BOOTDEVICES_MAX_SIZE);
+    void *cur;
+    char *name;
+    CHS *chs;
+    GList *results = NULL, *cur_result;
+    CHSResult *r;
+    int i;
+    bool found;
+
+    read_fw_cfg_file(fw_cfg, "bootdevices", buf, BOOTDEVICES_MAX_SIZE);
+
+    cur = buf;
+
+    info_size = *((uint32_t *)cur);
+
+    g_assert(info_size >= sizeof(*chs));
+
+    cur += 4;
+
+    while (strlen(cur)) {
+        name = cur;
+        chs = cur + strlen(cur) + 1;
+
+        r = g_malloc0(sizeof(*r));
+        r->dev_path = name;
+        r->chs = *chs;
+
+        results = g_list_prepend(results, r);
+
+        cur += strlen(cur) + 1 + info_size;
+    }
+
+    i = 0;
+
+    while (expected[i].dev_path) {
+        found = false;
+        cur_result = results;
+        while (cur_result) {
+            r = cur_result->data;
+            if (!strcmp(r->dev_path, expected[i].dev_path) &&
+                !memcmp(&(r->chs), &(expected[i].chs), sizeof(r->chs))) {
+                found = true;
+                break;
+            }
+            cur_result = g_list_next(cur_result);
+        }
+        g_assert(found);
+        g_free(cur_result->data);
+        results = g_list_delete_link(results, cur_result);
+        i++;
+    }
+
+    g_assert(results == NULL);
+
+    g_free(buf);
+}
+
+#define MAX_DRIVES 30
+
+typedef struct {
+    char **argv;
+    int argc;
+    char **drives;
+    int n_drives;
+    int n_scsi_disks;
+    int n_scsi_controllers;
+    int n_virtio_disks;
+} TestArgs;
+
+static TestArgs *create_args(void)
+{
+    TestArgs *args = g_malloc0(sizeof(*args));
+    args->argv = g_new0(char *, ARGV_SIZE);
+    args->argc = append_arg(args->argc, args->argv,
+                            ARGV_SIZE, g_strdup("-nodefaults"));
+    args->drives = g_new0(char *, MAX_DRIVES);
+    return args;
+}
+
+static void add_drive_with_mbr(TestArgs *args,
+                               MBRpartitions mbr, uint64_t sectors)
+{
+    char *img_file_name;
+    char part[300];
+    int ret;
+
+    g_assert(args->n_drives < MAX_DRIVES);
+
+    img_file_name = create_qcow2_with_mbr(mbr, sectors);
+
+    args->drives[args->n_drives] = img_file_name;
+    ret = snprintf(part, sizeof(part),
+                   "-drive file=%s,if=none,format=qcow2,id=disk%d",
+                   img_file_name, args->n_drives);
+    g_assert((0 < ret) && (ret <= sizeof(part)));
+    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
+    args->n_drives++;
+}
+
+static void add_ide_disk(TestArgs *args,
+                         int drive_idx, int bus, int unit, int c, int h, int s)
+{
+    char part[300];
+    int ret;
+
+    ret = snprintf(part, sizeof(part),
+                   "-device ide-hd,drive=disk%d,bus=ide.%d,unit=%d,"
+                   "lcyls=%d,lheads=%d,lsecs=%d",
+                   drive_idx, bus, unit, c, h, s);
+    g_assert((0 < ret) && (ret <= sizeof(part)));
+    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
+}
+
+static void add_scsi_controller(TestArgs *args,
+                                const char *type,
+                                const char *bus,
+                                int addr)
+{
+    char part[300];
+    int ret;
+
+    ret = snprintf(part, sizeof(part),
+                   "-device %s,id=scsi%d,bus=%s,addr=%d",
+                   type, args->n_scsi_controllers, bus, addr);
+    g_assert((0 < ret) && (ret <= sizeof(part)));
+    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
+    args->n_scsi_controllers++;
+}
+
+static void add_scsi_disk(TestArgs *args,
+                          int drive_idx, int bus,
+                          int channel, int scsi_id, int lun,
+                          int c, int h, int s)
+{
+    char part[300];
+    int ret;
+
+    ret = snprintf(part, sizeof(part),
+                   "-device scsi-hd,id=scsi-disk%d,drive=disk%d,"
+                   "bus=scsi%d.0,"
+                   "channel=%d,scsi-id=%d,lun=%d,"
+                   "lcyls=%d,lheads=%d,lsecs=%d",
+                   args->n_scsi_disks, drive_idx, bus, channel, scsi_id, lun,
+                   c, h, s);
+    g_assert((0 < ret) && (ret <= sizeof(part)));
+    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
+    args->n_scsi_disks++;
+}
+
+static void add_virtio_disk(TestArgs *args,
+                            int drive_idx, const char *bus, int addr,
+                            int c, int h, int s)
+{
+    char part[300];
+    int ret;
+
+    ret = snprintf(part, sizeof(part),
+                   "-device virtio-blk-pci,id=virtio-disk%d,"
+                   "drive=disk%d,bus=%s,addr=%d,"
+                   "lcyls=%d,lheads=%d,lsecs=%d",
+                   args->n_virtio_disks, drive_idx, bus, addr, c, h, s);
+    g_assert((0 < ret) && (ret <= sizeof(part)));
+    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
+    args->n_virtio_disks++;
+}
+
+static void test_override(TestArgs *args, CHSResult expected[])
+{
+    char *joined_args;
+    QFWCFG *fw_cfg;
+    int i;
+
+    joined_args = g_strjoinv(" ", args->argv);
+
+    qtest_start(joined_args);
+    fw_cfg = pc_fw_cfg_init(global_qtest);
+
+    read_bootdevices(fw_cfg, expected);
+
+    g_free(joined_args);
+    qtest_end();
+
+    g_free(fw_cfg);
+
+    for (i = 0; i < args->n_drives; i++) {
+        unlink(args->drives[i]);
+        free(args->drives[i]);
+    }
+    g_free(args->drives);
+    g_strfreev(args->argv);
+    g_free(args);
+}
+
+static void test_override_ide(void)
+{
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/ide@1,1/drive@0/disk@0", {10000, 120, 30} },
+        {"/pci@i0cf8/ide@1,1/drive@0/disk@1", {9000, 120, 30} },
+        {"/pci@i0cf8/ide@1,1/drive@1/disk@0", {0, 1, 1} },
+        {"/pci@i0cf8/ide@1,1/drive@1/disk@1", {1, 0, 0} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_ide_disk(args, 0, 0, 0, 10000, 120, 30);
+    add_ide_disk(args, 1, 0, 1, 9000, 120, 30);
+    add_ide_disk(args, 2, 1, 0, 0, 1, 1);
+    add_ide_disk(args, 3, 1, 1, 1, 0, 0);
+    test_override(args, expected);
+}
+
+static void test_override_scsi(void)
+{
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/scsi@3/channel@0/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@3/channel@0/disk@1,0", {9000, 120, 30} },
+        {"/pci@i0cf8/scsi@3/channel@0/disk@2,0", {1, 0, 0} },
+        {"/pci@i0cf8/scsi@3/channel@0/disk@3,0", {0, 1, 0} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_scsi_controller(args, "lsi53c895a", "pci.0", 3);
+    add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
+    add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
+    add_scsi_disk(args, 2, 0, 0, 2, 0, 1, 0, 0);
+    add_scsi_disk(args, 3, 0, 0, 3, 0, 0, 1, 0);
+    test_override(args, expected);
+}
+
+static void test_override_scsi_2_controllers(void)
+{
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/scsi@3/channel@0/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@3/channel@0/disk@1,0", {9000, 120, 30} },
+        {"/pci@i0cf8/scsi@4/channel@0/disk@0,1", {1, 0, 0} },
+        {"/pci@i0cf8/scsi@4/channel@0/disk@1,2", {0, 1, 0} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_scsi_controller(args, "lsi53c895a", "pci.0", 3);
+    add_scsi_controller(args, "virtio-scsi-pci", "pci.0", 4);
+    add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
+    add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
+    add_scsi_disk(args, 2, 1, 0, 0, 1, 1, 0, 0);
+    add_scsi_disk(args, 3, 1, 0, 1, 2, 0, 1, 0);
+    test_override(args, expected);
+}
+
+static void test_override_virtio_blk(void)
+{
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/scsi@3/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@4/disk@0,0", {9000, 120, 30} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_virtio_disk(args, 0, "pci.0", 3, 10000, 120, 30);
+    add_virtio_disk(args, 1, "pci.0", 4, 9000, 120, 30);
+    test_override(args, expected);
+}
+
+static void test_override_zero_chs(void)
+{
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_ide_disk(args, 0, 1, 1, 0, 0, 0);
+    test_override(args, expected);
+}
+
+static void test_override_scsi_hot_unplug(void)
+{
+    char *joined_args;
+    QFWCFG *fw_cfg;
+    QDict *response;
+    int i;
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/scsi@2/channel@0/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@2/channel@0/disk@1,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    CHSResult expected2[] = {
+        {"/pci@i0cf8/scsi@2/channel@0/disk@1,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_scsi_controller(args, "virtio-scsi-pci", "pci.0", 2);
+    add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
+    add_scsi_disk(args, 1, 0, 0, 1, 0, 20, 20, 20);
+
+    joined_args = g_strjoinv(" ", args->argv);
+
+    qtest_start(joined_args);
+    fw_cfg = pc_fw_cfg_init(global_qtest);
+
+    read_bootdevices(fw_cfg, expected);
+
+    /* unplug device an restart */
+    response = qmp("{ 'execute': 'device_del',"
+                   "  'arguments': {'id': 'scsi-disk0' }}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+    response = qmp("{ 'execute': 'system_reset', 'arguments': { }}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+
+    qtest_qmp_eventwait(global_qtest, "RESET");
+
+    read_bootdevices(fw_cfg, expected2);
+
+    g_free(joined_args);
+    qtest_end();
+
+    g_free(fw_cfg);
+
+    for (i = 0; i < args->n_drives; i++) {
+        unlink(args->drives[i]);
+        free(args->drives[i]);
+    }
+    g_free(args->drives);
+    g_strfreev(args->argv);
+    g_free(args);
+}
+
+static void test_override_virtio_hot_unplug(void)
+{
+    char *joined_args;
+    QFWCFG *fw_cfg;
+    QDict *response;
+    int i;
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/scsi@2/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@3/disk@0,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    CHSResult expected2[] = {
+        {"/pci@i0cf8/scsi@3/disk@0,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_virtio_disk(args, 0, "pci.0", 2, 10000, 120, 30);
+    add_virtio_disk(args, 1, "pci.0", 3, 20, 20, 20);
+
+    joined_args = g_strjoinv(" ", args->argv);
+
+    qtest_start(joined_args);
+    fw_cfg = pc_fw_cfg_init(global_qtest);
+
+    read_bootdevices(fw_cfg, expected);
+
+    /* unplug device an restart */
+    response = qmp("{ 'execute': 'device_del',"
+                   "  'arguments': {'id': 'virtio-disk0' }}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+    response = qmp("{ 'execute': 'system_reset', 'arguments': { }}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+
+    qtest_qmp_eventwait(global_qtest, "RESET");
+
+    read_bootdevices(fw_cfg, expected2);
+
+    g_free(joined_args);
+    qtest_end();
+
+    g_free(fw_cfg);
+
+    for (i = 0; i < args->n_drives; i++) {
+        unlink(args->drives[i]);
+        free(args->drives[i]);
+    }
+    g_free(args->drives);
+    g_strfreev(args->argv);
+    g_free(args);
+}
+
 int main(int argc, char **argv)
 {
     Backend i;
@@ -413,6 +968,16 @@ int main(int argc, char **argv)
     qtest_add_func("hd-geo/ide/device/mbr/chs", test_ide_device_mbr_chs);
     qtest_add_func("hd-geo/ide/device/user/chs", test_ide_device_user_chs);
     qtest_add_func("hd-geo/ide/device/user/chst", test_ide_device_user_chst);
+    qtest_add_func("hd-geo/override/ide", test_override_ide);
+    qtest_add_func("hd-geo/override/scsi", test_override_scsi);
+    qtest_add_func("hd-geo/override/scsi_2_controllers",
+                   test_override_scsi_2_controllers);
+    qtest_add_func("hd-geo/override/virtio_blk", test_override_virtio_blk);
+    qtest_add_func("hd-geo/override/zero_chs", test_override_zero_chs);
+    qtest_add_func("hd-geo/override/scsi_hot_unplug",
+                   test_override_scsi_hot_unplug);
+    qtest_add_func("hd-geo/override/virtio_hot_unplug",
+                   test_override_virtio_hot_unplug);
 
     ret = g_test_run();
 
-- 
2.13.3


