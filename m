Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54ADC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01EE20716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hf+zbKp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01EE20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIzJ-0003bc-RA
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnIyK-0001V5-OL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:42:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32065
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnIyI-0003uy-D3
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592818953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aw31jIz2mSQv5BNOzPXaSEpsoM6C8DcxjzeZc2mr4w=;
 b=Hf+zbKp88UugZGQxx4outbtls1rIJfRsiMTPj627UBii7rY8CKzH6CzNCBBOrS/w97iZLh
 inxbDq+0ZW3kCNl4Dkedmn9nuovwaXnnsc9kqvwvQwvgslxt92W6JHz2IPCotcj+3KGPQ2
 UDALhl7utAIWfYGhfQlBHqB95nFiexE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-hRcrR13GPpO3wOaPs0tKYw-1; Mon, 22 Jun 2020 05:42:30 -0400
X-MC-Unique: hRcrR13GPpO3wOaPs0tKYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92C2B835B40;
 Mon, 22 Jun 2020 09:42:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5799E7167F;
 Mon, 22 Jun 2020 09:42:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C12EE1138470; Mon, 22 Jun 2020 11:42:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/16] iotests/172: Cover empty filename and multiple use
 of drives
Date: Mon, 22 Jun 2020 11:42:13 +0200
Message-Id: <20200622094227.1271650-3-armbru@redhat.com>
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


