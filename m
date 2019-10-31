Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE323CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 11:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770602083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 11:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZQIssuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770602083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ8Tm-0002c2-J4
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 07:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iQ8G2-00073X-Ew
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 07:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iQ8Fz-0001nb-NR
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 07:04:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25788
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iQ8Fz-0001mh-Ih
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 07:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572519887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPRLFbCJccTOvXyTPo0tJhBis+rOHsKo89Mmev9hxIc=;
 b=HZQIssuRrH5DMTEaV5UguSL/woYQAE9CQejKEqOuK+aQ4Oe3blPzohcsWrNxJJSOkpJLOU
 aK5kRy+orMLch8epudV3NWwXH13UVMOw1KFfKuzAQ/+YOFc99sWyz1p7P9IZkjuwcsaA60
 mGelcPkP2U41ONfpeT5T4y5p36zDMIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-cIBWizBaOzKVcK2tNft3jg-1; Thu, 31 Oct 2019 07:04:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48C371800D6B;
 Thu, 31 Oct 2019 11:04:41 +0000 (UTC)
Received: from probe.redhat.com (ovpn-121-17.rdu2.redhat.com [10.10.121.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83A2960BEC;
 Thu, 31 Oct 2019 11:03:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 9/9] hd-geo-test: Add tests for lchs override
Date: Thu, 31 Oct 2019 06:59:04 -0400
Message-Id: <20191031105904.12194-10-jsnow@redhat.com>
In-Reply-To: <20191031105904.12194-1-jsnow@redhat.com>
References: <20191031105904.12194-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: cIBWizBaOzKVcK2tNft3jg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Arbel Moshe <arbel.moshe@oracle.com>, Laszlo Ersek <lersek@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Sam Eiderman <shmuel.eiderman@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sam Eiderman <sameid@google.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Add QTest tests to check the logical geometry override option.

The tests in hd-geo-test are out of date - they only test IDE and do not
test interesting MBRs.

Creating qcow2 disks with specific size and MBR layout is currently
unused - we only use a default empty MBR.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Signed-off-by: Sam Eiderman <sameid@google.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/hd-geo-test.c    | 551 +++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |   2 +-
 2 files changed, 552 insertions(+), 1 deletion(-)

diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 62eb624726..7e86c5416c 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -17,7 +17,12 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qemu/bswap.h"
+#include "qapi/qmp/qlist.h"
 #include "libqtest.h"
+#include "libqos/fw_cfg.h"
+#include "libqos/libqos.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
=20
 #define ARGV_SIZE 256
=20
@@ -388,6 +393,537 @@ static void test_ide_drive_cd_0(void)
     qtest_quit(qts);
 }
=20
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
+static MBRpartitions empty_mbr =3D { {false, 0, 0, 0, 0, 0, 0, 0, 0},
+                                   {false, 0, 0, 0, 0, 0, 0, 0, 0},
+                                   {false, 0, 0, 0, 0, 0, 0, 0, 0},
+                                   {false, 0, 0, 0, 0, 0, 0, 0, 0} };
+
+static char *create_qcow2_with_mbr(MBRpartitions mbr, uint64_t sectors)
+{
+    const char *template =3D "/tmp/qtest.XXXXXX";
+    char *raw_path =3D strdup(template);
+    char *qcow2_path =3D strdup(template);
+    char cmd[100 + 2 * PATH_MAX];
+    uint8_t buf[512];
+    int i, ret, fd, offset;
+    uint64_t qcow2_size =3D sectors * 512;
+    uint8_t status, parttype, head, sector, cyl;
+    char *qemu_img_path;
+    char *qemu_img_abs_path;
+
+    offset =3D 0xbe;
+
+    for (i =3D 0; i < 4; i++) {
+        status =3D mbr[i].active ? 0x80 : 0x00;
+        g_assert(mbr[i].head < 256);
+        g_assert(mbr[i].sector < 64);
+        g_assert(mbr[i].cyl < 1024);
+        head =3D mbr[i].head;
+        sector =3D mbr[i].sector + ((mbr[i].cyl & 0x300) >> 2);
+        cyl =3D mbr[i].cyl & 0xff;
+
+        buf[offset + 0x0] =3D status;
+        buf[offset + 0x1] =3D head;
+        buf[offset + 0x2] =3D sector;
+        buf[offset + 0x3] =3D cyl;
+
+        parttype =3D 0;
+        g_assert(mbr[i].end_head < 256);
+        g_assert(mbr[i].end_sector < 64);
+        g_assert(mbr[i].end_cyl < 1024);
+        head =3D mbr[i].end_head;
+        sector =3D mbr[i].end_sector + ((mbr[i].end_cyl & 0x300) >> 2);
+        cyl =3D mbr[i].end_cyl & 0xff;
+
+        buf[offset + 0x4] =3D parttype;
+        buf[offset + 0x5] =3D head;
+        buf[offset + 0x6] =3D sector;
+        buf[offset + 0x7] =3D cyl;
+
+        (*(uint32_t *)&buf[offset + 0x8]) =3D cpu_to_le32(mbr[i].start_sec=
t);
+        (*(uint32_t *)&buf[offset + 0xc]) =3D cpu_to_le32(mbr[i].nr_sects)=
;
+
+        offset +=3D 0x10;
+    }
+
+    fd =3D mkstemp(raw_path);
+    g_assert(fd);
+    close(fd);
+
+    fd =3D open(raw_path, O_WRONLY);
+    g_assert(fd >=3D 0);
+    ret =3D write(fd, buf, sizeof(buf));
+    g_assert(ret =3D=3D sizeof(buf));
+    close(fd);
+
+    fd =3D mkstemp(qcow2_path);
+    g_assert(fd);
+    close(fd);
+
+    qemu_img_path =3D getenv("QTEST_QEMU_IMG");
+    g_assert(qemu_img_path);
+    qemu_img_abs_path =3D realpath(qemu_img_path, NULL);
+    g_assert(qemu_img_abs_path);
+
+    ret =3D snprintf(cmd, sizeof(cmd),
+                   "%s convert -f raw -O qcow2 %s %s > /dev/null",
+                   qemu_img_abs_path,
+                   raw_path, qcow2_path);
+    g_assert((0 < ret) && (ret <=3D sizeof(cmd)));
+    ret =3D system(cmd);
+    g_assert(ret =3D=3D 0);
+
+    ret =3D snprintf(cmd, sizeof(cmd),
+                   "%s resize %s %" PRIu64 " > /dev/null",
+                   qemu_img_abs_path,
+                   qcow2_path, qcow2_size);
+    g_assert((0 < ret) && (ret <=3D sizeof(cmd)));
+    ret =3D system(cmd);
+    g_assert(ret =3D=3D 0);
+
+    free(qemu_img_abs_path);
+
+    unlink(raw_path);
+    free(raw_path);
+
+    return qcow2_path;
+}
+
+#define BIOS_GEOMETRY_MAX_SIZE 10000
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
+    char *buf =3D g_malloc0(BIOS_GEOMETRY_MAX_SIZE);
+    char *cur;
+    GList *results =3D NULL, *cur_result;
+    CHSResult *r;
+    int i;
+    int res;
+    bool found;
+
+    qfw_cfg_get_file(fw_cfg, "bios-geometry", buf, BIOS_GEOMETRY_MAX_SIZE)=
;
+
+    for (cur =3D buf; *cur; cur++) {
+        if (*cur =3D=3D '\n') {
+            *cur =3D '\0';
+        }
+    }
+    cur =3D buf;
+
+    while (strlen(cur)) {
+
+        r =3D g_malloc0(sizeof(*r));
+        r->dev_path =3D g_malloc0(strlen(cur) + 1);
+        res =3D sscanf(cur, "%s %" PRIu32 " %" PRIu32 " %" PRIu32,
+                     (char *)r->dev_path,
+                     &(r->chs.c), &(r->chs.h), &(r->chs.s));
+
+        g_assert(res =3D=3D 4);
+
+        results =3D g_list_prepend(results, r);
+
+        cur +=3D strlen(cur) + 1;
+    }
+
+    i =3D 0;
+
+    while (expected[i].dev_path) {
+        found =3D false;
+        cur_result =3D results;
+        while (cur_result) {
+            r =3D cur_result->data;
+            if (!strcmp(r->dev_path, expected[i].dev_path) &&
+                !memcmp(&(r->chs), &(expected[i].chs), sizeof(r->chs))) {
+                found =3D true;
+                break;
+            }
+            cur_result =3D g_list_next(cur_result);
+        }
+        g_assert(found);
+        g_free((char *)((CHSResult *)cur_result->data)->dev_path);
+        g_free(cur_result->data);
+        results =3D g_list_delete_link(results, cur_result);
+        i++;
+    }
+
+    g_assert(results =3D=3D NULL);
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
+    TestArgs *args =3D g_malloc0(sizeof(*args));
+    args->argv =3D g_new0(char *, ARGV_SIZE);
+    args->argc =3D append_arg(args->argc, args->argv,
+                            ARGV_SIZE, g_strdup("-nodefaults"));
+    args->drives =3D g_new0(char *, MAX_DRIVES);
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
+    img_file_name =3D create_qcow2_with_mbr(mbr, sectors);
+
+    args->drives[args->n_drives] =3D img_file_name;
+    ret =3D snprintf(part, sizeof(part),
+                   "-drive file=3D%s,if=3Dnone,format=3Dqcow2,id=3Ddisk%d"=
,
+                   img_file_name, args->n_drives);
+    g_assert((0 < ret) && (ret <=3D sizeof(part)));
+    args->argc =3D append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(=
part));
+    args->n_drives++;
+}
+
+static void add_ide_disk(TestArgs *args,
+                         int drive_idx, int bus, int unit, int c, int h, i=
nt s)
+{
+    char part[300];
+    int ret;
+
+    ret =3D snprintf(part, sizeof(part),
+                   "-device ide-hd,drive=3Ddisk%d,bus=3Dide.%d,unit=3D%d,"
+                   "lcyls=3D%d,lheads=3D%d,lsecs=3D%d",
+                   drive_idx, bus, unit, c, h, s);
+    g_assert((0 < ret) && (ret <=3D sizeof(part)));
+    args->argc =3D append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(=
part));
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
+    ret =3D snprintf(part, sizeof(part),
+                   "-device %s,id=3Dscsi%d,bus=3D%s,addr=3D%d",
+                   type, args->n_scsi_controllers, bus, addr);
+    g_assert((0 < ret) && (ret <=3D sizeof(part)));
+    args->argc =3D append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(=
part));
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
+    ret =3D snprintf(part, sizeof(part),
+                   "-device scsi-hd,id=3Dscsi-disk%d,drive=3Ddisk%d,"
+                   "bus=3Dscsi%d.0,"
+                   "channel=3D%d,scsi-id=3D%d,lun=3D%d,"
+                   "lcyls=3D%d,lheads=3D%d,lsecs=3D%d",
+                   args->n_scsi_disks, drive_idx, bus, channel, scsi_id, l=
un,
+                   c, h, s);
+    g_assert((0 < ret) && (ret <=3D sizeof(part)));
+    args->argc =3D append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(=
part));
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
+    ret =3D snprintf(part, sizeof(part),
+                   "-device virtio-blk-pci,id=3Dvirtio-disk%d,"
+                   "drive=3Ddisk%d,bus=3D%s,addr=3D%d,"
+                   "lcyls=3D%d,lheads=3D%d,lsecs=3D%d",
+                   args->n_virtio_disks, drive_idx, bus, addr, c, h, s);
+    g_assert((0 < ret) && (ret <=3D sizeof(part)));
+    args->argc =3D append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(=
part));
+    args->n_virtio_disks++;
+}
+
+static void test_override(TestArgs *args, CHSResult expected[])
+{
+    QTestState *qts;
+    char *joined_args;
+    QFWCFG *fw_cfg;
+    int i;
+
+    joined_args =3D g_strjoinv(" ", args->argv);
+
+    qts =3D qtest_init(joined_args);
+    fw_cfg =3D pc_fw_cfg_init(qts);
+
+    read_bootdevices(fw_cfg, expected);
+
+    g_free(joined_args);
+    qtest_quit(qts);
+
+    g_free(fw_cfg);
+
+    for (i =3D 0; i < args->n_drives; i++) {
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
+    TestArgs *args =3D create_args();
+    CHSResult expected[] =3D {
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
+    TestArgs *args =3D create_args();
+    CHSResult expected[] =3D {
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
+    TestArgs *args =3D create_args();
+    CHSResult expected[] =3D {
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
+    TestArgs *args =3D create_args();
+    CHSResult expected[] =3D {
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
+    TestArgs *args =3D create_args();
+    CHSResult expected[] =3D {
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_ide_disk(args, 0, 1, 1, 0, 0, 0);
+    test_override(args, expected);
+}
+
+static void test_override_scsi_hot_unplug(void)
+{
+    QTestState *qts;
+    char *joined_args;
+    QFWCFG *fw_cfg;
+    QDict *response;
+    int i;
+    TestArgs *args =3D create_args();
+    CHSResult expected[] =3D {
+        {"/pci@i0cf8/scsi@2/channel@0/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@2/channel@0/disk@1,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    CHSResult expected2[] =3D {
+        {"/pci@i0cf8/scsi@2/channel@0/disk@1,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_scsi_controller(args, "virtio-scsi-pci", "pci.0", 2);
+    add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
+    add_scsi_disk(args, 1, 0, 0, 1, 0, 20, 20, 20);
+
+    joined_args =3D g_strjoinv(" ", args->argv);
+
+    qts =3D qtest_init(joined_args);
+    fw_cfg =3D pc_fw_cfg_init(qts);
+
+    read_bootdevices(fw_cfg, expected);
+
+    /* unplug device an restart */
+    response =3D qtest_qmp(qts,
+                         "{ 'execute': 'device_del',"
+                         "  'arguments': {'id': 'scsi-disk0' }}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+    response =3D qtest_qmp(qts,
+                         "{ 'execute': 'system_reset', 'arguments': { }}")=
;
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+
+    qtest_qmp_eventwait(qts, "RESET");
+
+    read_bootdevices(fw_cfg, expected2);
+
+    g_free(joined_args);
+    qtest_quit(qts);
+
+    g_free(fw_cfg);
+
+    for (i =3D 0; i < args->n_drives; i++) {
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
+    QTestState *qts;
+    char *joined_args;
+    QFWCFG *fw_cfg;
+    QDict *response;
+    int i;
+    TestArgs *args =3D create_args();
+    CHSResult expected[] =3D {
+        {"/pci@i0cf8/scsi@2/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@3/disk@0,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    CHSResult expected2[] =3D {
+        {"/pci@i0cf8/scsi@3/disk@0,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_virtio_disk(args, 0, "pci.0", 2, 10000, 120, 30);
+    add_virtio_disk(args, 1, "pci.0", 3, 20, 20, 20);
+
+    joined_args =3D g_strjoinv(" ", args->argv);
+
+    qts =3D qtest_init(joined_args);
+    fw_cfg =3D pc_fw_cfg_init(qts);
+
+    read_bootdevices(fw_cfg, expected);
+
+    /* unplug device an restart */
+    response =3D qtest_qmp(qts,
+                         "{ 'execute': 'device_del',"
+                         "  'arguments': {'id': 'virtio-disk0' }}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+    response =3D qtest_qmp(qts,
+                         "{ 'execute': 'system_reset', 'arguments': { }}")=
;
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+
+    qtest_qmp_eventwait(qts, "RESET");
+
+    read_bootdevices(fw_cfg, expected2);
+
+    g_free(joined_args);
+    qtest_quit(qts);
+
+    g_free(fw_cfg);
+
+    for (i =3D 0; i < args->n_drives; i++) {
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
@@ -413,6 +949,21 @@ int main(int argc, char **argv)
     qtest_add_func("hd-geo/ide/device/mbr/chs", test_ide_device_mbr_chs);
     qtest_add_func("hd-geo/ide/device/user/chs", test_ide_device_user_chs)=
;
     qtest_add_func("hd-geo/ide/device/user/chst", test_ide_device_user_chs=
t);
+    if (have_qemu_img()) {
+        qtest_add_func("hd-geo/override/ide", test_override_ide);
+        qtest_add_func("hd-geo/override/scsi", test_override_scsi);
+        qtest_add_func("hd-geo/override/scsi_2_controllers",
+                       test_override_scsi_2_controllers);
+        qtest_add_func("hd-geo/override/virtio_blk", test_override_virtio_=
blk);
+        qtest_add_func("hd-geo/override/zero_chs", test_override_zero_chs)=
;
+        qtest_add_func("hd-geo/override/scsi_hot_unplug",
+                       test_override_scsi_hot_unplug);
+        qtest_add_func("hd-geo/override/virtio_hot_unplug",
+                       test_override_virtio_hot_unplug);
+    } else {
+        g_test_message("QTEST_QEMU_IMG not set or qemu-img missing; "
+                       "skipping hd-geo/override/* tests");
+    }
=20
     ret =3D g_test_run();
=20
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c79402ab75..728d802dbd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -794,7 +794,7 @@ tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-o=
bj-y)
 tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-img$(E=
XESUF)
 tests/ipmi-kcs-test$(EXESUF): tests/ipmi-kcs-test.o
 tests/ipmi-bt-test$(EXESUF): tests/ipmi-bt-test.o
-tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
+tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o $(libqos-obj-y)
 tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-y)
 tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
 tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
--=20
2.21.0


