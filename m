Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D95C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3914E2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjfdTcna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3914E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnk0B-0000Ad-Dz
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjps-0001lR-FI
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54280
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpm-0007jO-KK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592922213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRYO5Kp2/Cqw5IF/GTlj3GcMJBhYHOwBjK3oiYKcEs8=;
 b=YjfdTcna9anQDpBij6zBR8xczbz/RTVJZqjKxjWzuHzj5rrUCGLVddsTvJVCB8BpQftXzb
 Vwl+gyKm0RSeOGc49vZeFiXeS9yVDTXCBwFDWz3AWe36FvF6oM90FM4S7Mu+hCUgJhwufn
 s2E9GLk9gxZh0m7Ns7EfCSyyAYIUnUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-iG3rxjJFPBiXyGW4ANaZSA-1; Tue, 23 Jun 2020 10:23:30 -0400
X-MC-Unique: iG3rxjJFPBiXyGW4ANaZSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0882464AD2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 14:23:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE72E5D9DA
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 14:23:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 39CA31138470; Tue, 23 Jun 2020 16:23:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] iotests/172: Cover empty filename and multiple use of
 drives
Date: Tue, 23 Jun 2020 16:23:12 +0200
Message-Id: <20200623142326.2349416-3-armbru@redhat.com>
In-Reply-To: <20200623142326.2349416-1-armbru@redhat.com>
References: <20200623142326.2349416-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200622094227.1271650-3-armbru@redhat.com>
---
 tests/qemu-iotests/172     | 12 +++++++++
 tests/qemu-iotests/172.out | 50 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 19c2516cf8..714c7527b4 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -111,6 +111,7 @@ echo === Using -fda/-fdb options ===
 check_floppy_qtree -fda "$TEST_IMG"
 check_floppy_qtree -fdb "$TEST_IMG"
 check_floppy_qtree -fda "$TEST_IMG" -fdb "$TEST_IMG.2"
+check_floppy_qtree -fdb ""
 
 
 echo
@@ -198,6 +199,17 @@ check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IM
 check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" \
                    -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=1
 
+echo
+echo
+echo === Attempt to use drive twice ===
+
+# if=none
+check_floppy_qtree -drive if=none -device floppy,drive=none0 -device floppy -device floppy,drive=none0
+# if=floppy
+check_floppy_qtree -fda "" -device floppy,drive=floppy0
+# default if=floppy (not found, because it's created later)
+check_floppy_qtree -device floppy,drive=floppy0
+
 echo
 echo
 echo === Too many floppy drives ===
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index a315866e17..0665cdcb51 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -187,6 +187,44 @@ sd0: [not inserted]
 (qemu) quit
 
 
+Testing: -fdb 
+
+          dev: isa-fdc, id ""
+            iobase = 1008 (0x3f0)
+            irq = 6 (0x6)
+            dma = 2 (0x2)
+            driveA = ""
+            driveB = ""
+            check_media_rate = true
+            fdtypeA = "auto"
+            fdtypeB = "auto"
+            fallback = "288"
+            isa irq 6
+            bus: floppy-bus.0
+              type floppy-bus
+              dev: floppy, id ""
+                unit = 1 (0x1)
+                drive = "floppy1"
+                logical_block_size = 512 (0x200)
+                physical_block_size = 512 (0x200)
+                min_io_size = 0 (0x0)
+                opt_io_size = 0 (0x0)
+                discard_granularity = 4294967295 (0xffffffff)
+                write-cache = "auto"
+                share-rw = false
+                drive-type = "288"
+              dev: floppy, id ""
+                unit = 0 (0x0)
+                drive = "floppy0"
+                logical_block_size = 512 (0x200)
+                physical_block_size = 512 (0x200)
+                min_io_size = 0 (0x0)
+                opt_io_size = 0 (0x0)
+                discard_granularity = 4294967295 (0xffffffff)
+                write-cache = "auto"
+                share-rw = false
+                drive-type = "288"
+
 
 === Using -drive options ===
 
@@ -1407,6 +1445,18 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
 QEMU_PROG: -device floppy,drive=none1,unit=1: Floppy unit 1 is in use
 
 
+=== Attempt to use drive twice ===
+
+Testing: -drive if=none -device floppy,drive=none0 -device floppy -device floppy,drive=none0
+QEMU_PROG: -device floppy,drive=none0: Drive 'none0' is already in use by another device
+
+Testing: -fda  -device floppy,drive=floppy0
+QEMU_PROG: -device floppy,drive=floppy0: Drive 'floppy0' is already in use because it has been automatically connected to another device (did you need 'if=none' in the drive options?)
+
+Testing: -device floppy,drive=floppy0
+QEMU_PROG: -device floppy,drive=floppy0: Property 'floppy.drive' can't find value 'floppy0'
+
+
 === Too many floppy drives ===
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -drive if=none,file=TEST_DIR/t.qcow2.3 -global isa-fdc.driveB=none0 -device floppy,drive=none1
-- 
2.26.2


