Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE26C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780DC206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7QE5ZtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780DC206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZeN-0000E5-Hu
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZOK-0003nh-4d
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZOG-0001rJ-2V
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHz4cZNb0+rW5o8P0D9xRx7ShpORlZfgpLRB1CLd2Jg=;
 b=M7QE5ZtVjxyE/F0WBuwQyAqO/MyHVbCMXTjaPc8DmBmWXGGkIt3xemcXLZ/DPGsI2gVE/u
 djN97zwgWKqw1SEXwFQQ9PrV/bOMc2oXCLq3RH6EGGzoo/9bsKm59pWaPStXsC6/a0qHrX
 0zWHzPE2wL4ainDTrsU122ywLVjSb7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-8EoL6nvpN0GsXiv7etBVkw-1; Wed, 17 Jun 2020 10:50:03 -0400
X-MC-Unique: 8EoL6nvpN0GsXiv7etBVkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DAF78730EC;
 Wed, 17 Jun 2020 14:50:02 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71E8E7CAA0;
 Wed, 17 Jun 2020 14:50:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 36/43] qdev-properties: add getter for size32 and blocksize
Date: Wed, 17 Jun 2020 16:49:02 +0200
Message-Id: <20200617144909.192176-37-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Kagan <rvkagan@yandex-team.ru>

Add getter for size32, and use it for blocksize, too.

In its human-readable branch, it reports approximate size in
human-readable units next to the exact byte value, like the getter for
64bit size does.

Adjust the expected test output accordingly.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200528225516.1676602-8-rvkagan@yandex-team.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/core/qdev-properties.c  |  15 +-
 tests/qemu-iotests/172.out | 530 ++++++++++++++++++-------------------
 2 files changed, 278 insertions(+), 267 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index bd4abdc1d1..63d48db70c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -730,6 +730,17 @@ const PropertyInfo qdev_prop_pci_devfn = {
 
 /* --- 32bit unsigned int 'size' type --- */
 
+static void get_size32(Object *obj, Visitor *v, const char *name, void *opaque,
+                       Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
+    uint64_t value = *ptr;
+
+    visit_type_size(v, name, &value, errp);
+}
+
 static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
                        Error **errp)
 {
@@ -763,7 +774,7 @@ static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
 
 const PropertyInfo qdev_prop_size32 = {
     .name  = "size",
-    .get = get_uint32,
+    .get = get_size32,
     .set = set_size32,
     .set_default_value = set_default_value_uint,
 };
@@ -821,7 +832,7 @@ const PropertyInfo qdev_prop_blocksize = {
     .name  = "size",
     .description = "A power of two between " MIN_BLOCK_SIZE_STR
                    " and " MAX_BLOCK_SIZE_STR,
-    .get   = get_uint32,
+    .get   = get_size32,
     .set   = set_blocksize,
     .set_default_value = set_default_value_uint,
 };
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 59cc70aebb..e782c5957e 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -24,11 +24,11 @@ Testing:
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -54,11 +54,11 @@ Testing: -fda TEST_DIR/t.qcow2
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -81,22 +81,22 @@ Testing: -fdb TEST_DIR/t.qcow2
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -119,22 +119,22 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -160,11 +160,11 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -187,22 +187,22 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -225,22 +225,22 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -266,11 +266,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -293,11 +293,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -320,22 +320,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -361,11 +361,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -388,11 +388,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -415,22 +415,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -456,22 +456,22 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -494,22 +494,22 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -532,11 +532,11 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -559,11 +559,11 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -589,22 +589,22 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -627,22 +627,22 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -665,22 +665,22 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -703,22 +703,22 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -750,22 +750,22 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -788,22 +788,22 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -832,22 +832,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -870,22 +870,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -908,22 +908,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -946,22 +946,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -999,11 +999,11 @@ Testing: -device floppy
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = ""
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -1026,11 +1026,11 @@ Testing: -device floppy,drive-type=120
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = ""
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "120"
@@ -1053,11 +1053,11 @@ Testing: -device floppy,drive-type=144
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = ""
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -1080,11 +1080,11 @@ Testing: -device floppy,drive-type=288
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = ""
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -1110,11 +1110,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "120"
@@ -1137,11 +1137,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -1167,11 +1167,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -1194,11 +1194,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
-- 
2.25.4


