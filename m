Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21612C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC41F216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC41F216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38769 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSljD-0001Ev-4s
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:05:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlhB-0008TZ-6I
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlhA-0002Fv-4S
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSlh9-0002FY-Su; Mon, 20 May 2019 13:03:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22566307CDF0;
	Mon, 20 May 2019 17:03:27 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DB8B60BF3;
	Mon, 20 May 2019 17:03:26 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:02:10 +0200
Message-Id: <20190520170302.13643-3-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 20 May 2019 17:03:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/54] s390-bios: Skip bootmap signature entries
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org,
	Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Newer versions of zipl have the ability to write signature entries to the=
 boot
script for secure boot. We don't yet support secure boot, but we need to =
skip
over signature entries while reading the boot script in order to maintain=
 our
ability to boot guest operating systems that have a secure bootloader.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Message-Id: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
 pc-bios/s390-ccw/bootmap.h | 10 ++++++----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 7aef65ab6712..d13b7cbd1597 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -254,7 +254,14 @@ static void run_eckd_boot_script(block_number_t bmt_=
block_nr,
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(block_nr, sec, "Cannot read Boot Map Script");
=20
-    for (i =3D 0; bms->entry[i].type =3D=3D BOOT_SCRIPT_LOAD; i++) {
+    for (i =3D 0; bms->entry[i].type =3D=3D BOOT_SCRIPT_LOAD ||
+                bms->entry[i].type =3D=3D BOOT_SCRIPT_SIGNATURE; i++) {
+
+        /* We don't support secure boot yet, so we skip signature entrie=
s */
+        if (bms->entry[i].type =3D=3D BOOT_SCRIPT_SIGNATURE) {
+            continue;
+        }
+
         address =3D bms->entry[i].address.load_address;
         block_nr =3D eckd_block_num(&bms->entry[i].blkptr.xeckd.bptr.chs=
);
=20
@@ -489,7 +496,15 @@ static void zipl_run(ScsiBlockPtr *pte)
=20
     /* Load image(s) into RAM */
     entry =3D (ComponentEntry *)(&header[1]);
-    while (entry->component_type =3D=3D ZIPL_COMP_ENTRY_LOAD) {
+    while (entry->component_type =3D=3D ZIPL_COMP_ENTRY_LOAD ||
+           entry->component_type =3D=3D ZIPL_COMP_ENTRY_SIGNATURE) {
+
+        /* We don't support secure boot yet, so we skip signature entrie=
s */
+        if (entry->component_type =3D=3D ZIPL_COMP_ENTRY_SIGNATURE) {
+            entry++;
+            continue;
+        }
+
         zipl_load_segment(entry);
=20
         entry++;
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index a085212077e4..94f53a5f1e30 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -98,8 +98,9 @@ typedef struct ScsiMbr {
 #define ZIPL_COMP_HEADER_IPL    0x00
 #define ZIPL_COMP_HEADER_DUMP   0x01
=20
-#define ZIPL_COMP_ENTRY_LOAD    0x02
-#define ZIPL_COMP_ENTRY_EXEC    0x01
+#define ZIPL_COMP_ENTRY_EXEC      0x01
+#define ZIPL_COMP_ENTRY_LOAD      0x02
+#define ZIPL_COMP_ENTRY_SIGNATURE 0x03
=20
 typedef struct XEckdMbr {
     uint8_t magic[4];   /* =3D=3D "xIPL"        */
@@ -117,8 +118,9 @@ typedef struct BootMapScriptEntry {
     BootMapPointer blkptr;
     uint8_t pad[7];
     uint8_t type;   /* =3D=3D BOOT_SCRIPT_* */
-#define BOOT_SCRIPT_EXEC 0x01
-#define BOOT_SCRIPT_LOAD 0x02
+#define BOOT_SCRIPT_EXEC      0x01
+#define BOOT_SCRIPT_LOAD      0x02
+#define BOOT_SCRIPT_SIGNATURE 0x03
     union {
         uint64_t load_address;
         uint64_t load_psw;
--=20
2.20.1


