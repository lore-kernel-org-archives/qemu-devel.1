Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1028DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11832073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hij5AyNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11832073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjy2-0005dl-Uq
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjps-0001kR-0A
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56521
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpm-0007j7-7P
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592922213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IpQdIDYRI9rDAfEJnDjAPnlyvVTzWRcK7FLnYnoivYU=;
 b=hij5AyNFngJdGBhHhP55BSzdLCMwMU5Rc4valObUq2p1mUWrYSbpQNfH8bc84STWBPF6d7
 bMYY0unCP7+LZHpBrjB7jTC495h3c6R/BYCikXyFIx3noQv3/FKLv0VJMSmHTohflNQOWr
 9hLUpknuIlB92q88zMSUF8BOcqKse9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-9fVrayLmM5GLJC10HRe3Sg-1; Tue, 23 Jun 2020 10:23:30 -0400
X-MC-Unique: 9fVrayLmM5GLJC10HRe3Sg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1BD664AD0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 14:23:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57C327CCC0;
 Tue, 23 Jun 2020 14:23:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D6BC1138474; Tue, 23 Jun 2020 16:23:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] fdc: Deprecate configuring floppies with -global isa-fdc
Date: Tue, 23 Jun 2020 16:23:16 +0200
Message-Id: <20200623142326.2349416-7-armbru@redhat.com>
In-Reply-To: <20200623142326.2349416-1-armbru@redhat.com>
References: <20200623142326.2349416-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deprecate

    -global isa-fdc.driveA=...
    -global isa-fdc.driveB=...

in favour of

    -device floppy,unit=0,drive=...
    -device floppy,unit=1,drive=...

Same for the other floppy controller devices.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Message-Id: <20200622094227.1271650-7-armbru@redhat.com>
---
 docs/qdev-device-use.txt   | 13 ++++---------
 docs/system/deprecated.rst | 26 ++++++++++++++++++++++++++
 hw/block/fdc.c             | 17 +++++++++++++++++
 tests/qemu-iotests/172.out | 30 ++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index cc53e97dcd..3d781be547 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -104,15 +104,10 @@ The -device argument differs in detail for each type of drive:
 
 * if=floppy
 
-  -global isa-fdc.driveA=DRIVE-ID
-  -global isa-fdc.driveB=DRIVE-ID
+  -device floppy,unit=UNIT,drive=DRIVE-ID
 
-  This is -global instead of -device, because the floppy controller is
-  created automatically, and we want to configure that one, not create
-  a second one (which isn't possible anyway).
-
-  Without any -global isa-fdc,... you get an empty driveA and no
-  driveB.  You can use -nodefaults to suppress the default driveA, see
+  Without any -device floppy,... you get an empty unit 0 and no unit
+  1.  You can use -nodefaults to suppress the default unit 0, see
   "Default Devices".
 
 * if=virtio
@@ -385,7 +380,7 @@ some DEVNAMEs:
 
     default device      suppressing DEVNAMEs
     CD-ROM              ide-cd, ide-drive, ide-hd, scsi-cd, scsi-hd
-    isa-fdc's driveA    floppy, isa-fdc
+    floppy              floppy, isa-fdc
     parallel            isa-parallel
     serial              isa-serial
     VGA                 VGA, cirrus-vga, isa-vga, isa-cirrus-vga,
diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 3a255591c3..6f8bf19d37 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -164,6 +164,32 @@ previously available ``-tb-size`` option.
 Use ``-display sdl,show-cursor=on`` or
  ``-display gtk,show-cursor=on`` instead.
 
+``Configuring floppies with ``-global``
+'''''''''''''''''''''''''''''''''''''''
+
+Use ``-device floppy,...`` instead:
+::
+
+    -global isa-fdc.driveA=...
+    -global sysbus-fdc.driveA=...
+    -global SUNW,fdtwo.drive=...
+
+become
+::
+
+    -device floppy,unit=0,drive=...
+
+and
+::
+
+    -global isa-fdc.driveB=...
+    -global sysbus-fdc.driveB=...
+
+become
+::
+
+    -device floppy,unit=1,drive=...
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index d1f7722cff..7e143cbab0 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2528,6 +2528,7 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
     DeviceState *dev;
     BlockBackend *blk;
     Error *local_err = NULL;
+    const char *fdc_name, *drive_suffix;
 
     for (i = 0; i < MAX_FD; i++) {
         drive = &fdctrl->drives[i];
@@ -2542,10 +2543,26 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
             continue;
         }
 
+        fdc_name = object_get_typename(OBJECT(fdc_dev));
+        drive_suffix = !strcmp(fdc_name, "SUNW,fdtwo") ? "" : i ? "B" : "A";
+        warn_report("warning: property %s.drive%s is deprecated",
+                    fdc_name, drive_suffix);
+        error_printf("Use -device floppy,unit=%d,drive=... instead.\n", i);
+
         dev = qdev_new("floppy");
         qdev_prop_set_uint32(dev, "unit", i);
         qdev_prop_set_enum(dev, "drive-type", fdctrl->qdev_for_drives[i].type);
 
+        /*
+         * Hack alert: we move the backend from the floppy controller
+         * device to the floppy device.  We first need to detach the
+         * controller, or else floppy_create()'s qdev_prop_set_drive()
+         * will die when it attaches floppy device.  We also need to
+         * take another reference so that blk_detach_dev() doesn't
+         * free blk while we still need it.
+         *
+         * The hack is probably a bad idea.
+         */
         blk_ref(blk);
         blk_detach_dev(blk, fdc_dev);
         fdctrl->qdev_for_drives[i].blk = NULL;
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 340dbd39cb..778406e4bf 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -383,6 +383,8 @@ sd0: [not inserted]
 === Using -drive if=none and -global ===
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
+QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
+Use -device floppy,unit=0,drive=... instead.
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -423,6 +425,8 @@ sd0: [not inserted]
 
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
+QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
+Use -device floppy,unit=1,drive=... instead.
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -463,6 +467,10 @@ sd0: [not inserted]
 
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -global isa-fdc.driveB=none1
+QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
+Use -device floppy,unit=0,drive=... instead.
+QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
+Use -device floppy,unit=1,drive=... instead.
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -661,6 +669,8 @@ sd0: [not inserted]
 === Mixing -fdX and -global ===
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0
+QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
+Use -device floppy,unit=1,drive=... instead.
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -717,6 +727,8 @@ sd0: [not inserted]
 
 
 Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0
+QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
+Use -device floppy,unit=0,drive=... instead.
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -773,9 +785,13 @@ sd0: [not inserted]
 
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0
+QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
+Use -device floppy,unit=0,drive=... instead.
 QEMU_PROG: Floppy unit 0 is in use
 
 Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0
+QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
+Use -device floppy,unit=1,drive=... instead.
 QEMU_PROG: Floppy unit 1 is in use
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global floppy.drive=none0
@@ -1177,6 +1193,8 @@ QEMU_PROG: -device floppy,drive=none0,unit=0: Floppy unit 0 is in use
 === Mixing -global and -device ===
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -device floppy,drive=none1
+QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
+Use -device floppy,unit=0,drive=... instead.
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -1233,6 +1251,8 @@ sd0: [not inserted]
 
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=1
+QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
+Use -device floppy,unit=0,drive=... instead.
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -1289,6 +1309,8 @@ sd0: [not inserted]
 
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1
+QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
+Use -device floppy,unit=1,drive=... instead.
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -1345,6 +1367,8 @@ sd0: [not inserted]
 
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=0
+QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
+Use -device floppy,unit=1,drive=... instead.
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -1441,9 +1465,13 @@ sd0: [not inserted]
 
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=0
+QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
+Use -device floppy,unit=0,drive=... instead.
 QEMU_PROG: -device floppy,drive=none1,unit=0: Floppy unit 0 is in use
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=1
+QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
+Use -device floppy,unit=1,drive=... instead.
 QEMU_PROG: -device floppy,drive=none1,unit=1: Floppy unit 1 is in use
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global floppy.drive=none0 -device floppy,drive=none1,unit=0
@@ -1512,6 +1540,8 @@ QEMU_PROG: -device floppy,drive=floppy0: Property 'floppy.drive' can't find valu
 === Too many floppy drives ===
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -drive if=none,file=TEST_DIR/t.qcow2.3 -global isa-fdc.driveB=none0 -device floppy,drive=none1
+QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
+Use -device floppy,unit=1,drive=... instead.
 QEMU_PROG: -device floppy,drive=none1: Can't create floppy unit 2, bus supports only 2 units
 
 
-- 
2.26.2


