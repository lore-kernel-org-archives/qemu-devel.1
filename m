Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E19CCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29439205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoXutIhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29439205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4C9-0006su-EL
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3w3-0001me-BS
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3w2-0001Se-22
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46583
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3w1-0001SO-UC
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZTsLCacB11zcXpx9AAjf3yjkwEckl/Z+NRGF86/q3s=;
 b=SoXutIhNxuKHyJaYlFTe9ZfJ4kzF7lx33D2gvo7F5st8L2/Mqn2vUhTl2Qpqhkm0HpL0f+
 JE6YHJYUPySEkYqct1VvjE7ddY9TSskqxOPsE6hcK47VaKmiHZcF/i6WL/mrUkew4+SdpA
 x2CV34ppQzzVEZqsaa+FIJ0R+eAwq4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-QVBKgQGSPtyuSkhkegl_kQ-1; Mon, 28 Oct 2019 08:15:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25B6C476;
 Mon, 28 Oct 2019 12:15:43 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B40D35D6BB;
 Mon, 28 Oct 2019 12:15:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 19/69] iotests/140: Create socket in $SOCK_DIR
Date: Mon, 28 Oct 2019 13:14:11 +0100
Message-Id: <20191028121501.15279-20-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QVBKgQGSPtyuSkhkegl_kQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20191017133155.5327-8-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/140     | 8 ++++----
 tests/qemu-iotests/140.out | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index b965b1dd5d..8d2ce5d9e3 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -34,7 +34,7 @@ _cleanup()
 {
     _cleanup_qemu
     _cleanup_test_img
-    rm -f "$TEST_DIR/nbd"
+    rm -f "$SOCK_DIR/nbd"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -69,7 +69,7 @@ _send_qemu_cmd $QEMU_HANDLE \
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'nbd-server-start',
        'arguments': { 'addr': { 'type': 'unix',
-                                'data': { 'path': '$TEST_DIR/nbd' }}}}" \
+                                'data': { 'path': '$SOCK_DIR/nbd' }}}}" \
     'return'
=20
 _send_qemu_cmd $QEMU_HANDLE \
@@ -78,7 +78,7 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
=20
 $QEMU_IO_PROG -f raw -r -c 'read -P 42 0 64k' \
-    "nbd+unix:///drv?socket=3D$TEST_DIR/nbd" 2>&1 \
+    "nbd+unix:///drv?socket=3D$SOCK_DIR/nbd" 2>&1 \
     | _filter_qemu_io | _filter_nbd
=20
 _send_qemu_cmd $QEMU_HANDLE \
@@ -87,7 +87,7 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
=20
 $QEMU_IO_PROG -f raw -r -c close \
-    "nbd+unix:///drv?socket=3D$TEST_DIR/nbd" 2>&1 \
+    "nbd+unix:///drv?socket=3D$SOCK_DIR/nbd" 2>&1 \
     | _filter_qemu_io | _filter_nbd
=20
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 67fe44a3e3..2511eb7369 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -8,7 +8,7 @@ wrote 65536/65536 bytes at offset 0
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
-qemu-io: can't open device nbd+unix:///drv?socket=3DTEST_DIR/nbd: Requeste=
d export not available
+qemu-io: can't open device nbd+unix:///drv?socket=3DSOCK_DIR/nbd: Requeste=
d export not available
 server reported: export 'drv' not present
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
--=20
2.21.0


