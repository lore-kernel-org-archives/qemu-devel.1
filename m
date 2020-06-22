Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61823C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3D3206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zo+ph4V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3D3206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJ4m-0004oE-DL
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnIyV-0001x4-VI
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:42:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31368
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnIyL-0003xI-Hq
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592818956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kH+hi5yUqUayhk5cEMDm64N69EOnffyXDQvM0/Phrho=;
 b=Zo+ph4V5cv1TjKBGgSjCkEuFylBxARyWnck9HM3a3gz68udsIOXEMxrQEqweaL73EfiY/1
 bsGiosgWcKyDZiLZsDR2l47hfltPwlczZheg6JY6OD2Pp2LD0F6qgnfx3W3SEZS1xw2gfK
 Vj8DCcnW5eaVvrRImpc5N60NyR+uikk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-ASeyQAZQMVGO-Ta571Nqwg-1; Mon, 22 Jun 2020 05:42:32 -0400
X-MC-Unique: ASeyQAZQMVGO-Ta571Nqwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95348835B41;
 Mon, 22 Jun 2020 09:42:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39AC071683;
 Mon, 22 Jun 2020 09:42:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 020281138479; Mon, 22 Jun 2020 11:42:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/16] qdev: Reject drive property override
Date: Mon, 22 Jun 2020 11:42:22 +0200
Message-Id: <20200622094227.1271650-12-armbru@redhat.com>
In-Reply-To: <20200622094227.1271650-1-armbru@redhat.com>
References: <20200622094227.1271650-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qdev_prop_set_drive() screws up when the property already has a
non-null value: it neglects to release the old value.  Both the old
and the new backend become attached to the same device.

Example (taken from iotest 172): -fda ... -drive if=none,... -global
floppy.drive=none0.

Special case: attempting to use the same backend both times fails.
Example (also from iotest 172): -fda ... -global floppy.drive=floppy0.

Yet another example: -device with multiple drive=... (but not
device_add, which silently drops all but the last duplicate property).

Perhaps drive property override could be made to work.  Perhaps it
should.  I can't afford the time to figure this out now.  What I can
do is reject usage that leaves backends in unhealthy states.  For what
it's worth, we've long done the same for netdev properties.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties-system.c |  8 +++
 tests/qemu-iotests/172.out       | 88 ++------------------------------
 2 files changed, 11 insertions(+), 85 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 3f84309b7e..6b5fc59901 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -98,6 +98,14 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    /*
+     * TODO Should this really be an error?  If no, the old value
+     * needs to be released before we store the new one.
+     */
+    if (!check_prop_still_unset(dev, name, *ptr, str, errp)) {
+        return;
+    }
+
     if (!*str) {
         g_free(str);
         *ptr = NULL;
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 778406e4bf..cca2894af0 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -795,48 +795,7 @@ Use -device floppy,unit=1,drive=... instead.
 QEMU_PROG: Floppy unit 1 is in use
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global floppy.drive=none0
-
-          dev: isa-fdc, id ""
-            iobase = 1008 (0x3f0)
-            irq = 6 (0x6)
-            dma = 2 (0x2)
-            driveA = ""
-            driveB = ""
-            check_media_rate = true
-            fdtypeA = "auto"
-            fdtypeB = "auto"
-            fallback = "288"
-            isa irq 6
-            bus: floppy-bus.0
-              type floppy-bus
-              dev: floppy, id ""
-                unit = 0 (0x0)
-                drive = "floppy0"
-                logical_block_size = 512 (512 B)
-                physical_block_size = 512 (512 B)
-                min_io_size = 0 (0 B)
-                opt_io_size = 0 (0 B)
-                discard_granularity = 4294967295 (4 GiB)
-                write-cache = "auto"
-                share-rw = false
-                drive-type = "144"
-floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[15]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/unattached/device[15]
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[22]
-    Removable device: not locked, tray closed
-
-sd0: [not inserted]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+QEMU_PROG: -global floppy.drive=... conflicts with drive=floppy0
 
 
 === Mixing -fdX and -device ===
@@ -1475,48 +1434,7 @@ Use -device floppy,unit=1,drive=... instead.
 QEMU_PROG: -device floppy,drive=none1,unit=1: Floppy unit 1 is in use
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global floppy.drive=none0 -device floppy,drive=none1,unit=0
-
-          dev: isa-fdc, id ""
-            iobase = 1008 (0x3f0)
-            irq = 6 (0x6)
-            dma = 2 (0x2)
-            driveA = ""
-            driveB = ""
-            check_media_rate = true
-            fdtypeA = "auto"
-            fdtypeB = "auto"
-            fallback = "288"
-            isa irq 6
-            bus: floppy-bus.0
-              type floppy-bus
-              dev: floppy, id ""
-                unit = 0 (0x0)
-                drive = "none1"
-                logical_block_size = 512 (512 B)
-                physical_block_size = 512 (512 B)
-                min_io_size = 0 (0 B)
-                opt_io_size = 0 (0 B)
-                discard_granularity = 4294967295 (4 GiB)
-                write-cache = "auto"
-                share-rw = false
-                drive-type = "144"
-none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[0]
-    Cache mode:       writeback
-
-none1 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[0]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[21]
-    Removable device: not locked, tray closed
-
-sd0: [not inserted]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+QEMU_PROG: -device floppy,drive=none1,unit=0: -global floppy.drive=... conflicts with drive=none1
 
 
 === Attempt to use drive twice ===
@@ -1531,7 +1449,7 @@ Testing: -fda  -device floppy,drive=floppy0
 QEMU_PROG: -device floppy,drive=floppy0: Drive 'floppy0' is already in use because it has been automatically connected to another device (did you need 'if=none' in the drive options?)
 
 Testing: -fda  -global floppy.drive=floppy0
-QEMU_PROG: Drive 'floppy0' is already in use because it has been automatically connected to another device (did you need 'if=none' in the drive options?)
+QEMU_PROG: -global floppy.drive=... conflicts with drive=floppy0
 
 Testing: -device floppy,drive=floppy0
 QEMU_PROG: -device floppy,drive=floppy0: Property 'floppy.drive' can't find value 'floppy0'
-- 
2.26.2


