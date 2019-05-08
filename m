Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC1C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6536D204EC
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6536D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34069 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOJFO-0007wY-JQ
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 05:52:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOJCJ-0004j0-J2
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOJCH-0000BE-IX
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:49:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hOJCG-0000AL-G2; Wed, 08 May 2019 05:49:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C4B7307D95F;
	Wed,  8 May 2019 09:49:07 +0000 (UTC)
Received: from thuth.com (ovpn-116-100.ams2.redhat.com [10.36.116.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C72F55D9C8;
	Wed,  8 May 2019 09:49:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Wed,  8 May 2019 11:48:56 +0200
Message-Id: <20190508094857.21145-3-thuth@redhat.com>
In-Reply-To: <20190508094857.21145-1-thuth@redhat.com>
References: <20190508094857.21145-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 08 May 2019 09:49:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 2/3] s390-bios: Skip bootmap
 signature entries
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
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org,
	armbru@redhat.com
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
index 7aef65ab67..d13b7cbd15 100644
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
index a085212077..94f53a5f1e 100644
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
2.21.0


