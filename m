Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2CFCA9EC1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBD3214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgcnBVf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBD3214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4MY-0002Lc-5h
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3w8-0001sX-4m
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3w6-0001VC-Ty
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42269
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3w6-0001Uf-A6
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTWUKIMC+SzwJJX09S5GxuyIqJgaDZS198wieJIhHR0=;
 b=cgcnBVf5CTZhGHpPzgeYMpJm7z6cy+rk+mxugYZcRZBihjrkcpGvWiyJNPG3960JdKr4y6
 gnhbvATQ1NAq7GYPluKYPYZ7CyHrsdnJx31pEcXDVfbmjkXMjB8/EjuEYZOO9+fGyOadFf
 gqRYczuyZec+X4vpJHLduF71TWVh1UQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-xm5T5vFdMI-RDaS6OFMJLA-1; Mon, 28 Oct 2019 08:15:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3170D5E4;
 Mon, 28 Oct 2019 12:15:45 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB338100194E;
 Mon, 28 Oct 2019 12:15:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 20/69] iotests/143: Create socket in $SOCK_DIR
Date: Mon, 28 Oct 2019 13:14:12 +0100
Message-Id: <20191028121501.15279-21-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xm5T5vFdMI-RDaS6OFMJLA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20191017133155.5327-9-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/143     | 6 +++---
 tests/qemu-iotests/143.out | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index 92249ac8da..f649b36195 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -29,7 +29,7 @@ status=3D1=09# failure is the default!
 _cleanup()
 {
     _cleanup_qemu
-    rm -f "$TEST_DIR/nbd"
+    rm -f "$SOCK_DIR/nbd"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -51,12 +51,12 @@ _send_qemu_cmd $QEMU_HANDLE \
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'nbd-server-start',
        'arguments': { 'addr': { 'type': 'unix',
-                                'data': { 'path': '$TEST_DIR/nbd' }}}}" \
+                                'data': { 'path': '$SOCK_DIR/nbd' }}}}" \
     'return'
=20
 # This should just result in a client error, not in the server crashing
 $QEMU_IO_PROG -f raw -c quit \
-    "nbd+unix:///no_such_export?socket=3D$TEST_DIR/nbd" 2>&1 \
+    "nbd+unix:///no_such_export?socket=3D$SOCK_DIR/nbd" 2>&1 \
     | _filter_qemu_io | _filter_nbd
=20
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index ee71b5aa42..037d34a409 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -1,7 +1,7 @@
 QA output created by 143
 {"return": {}}
 {"return": {}}
-qemu-io: can't open device nbd+unix:///no_such_export?socket=3DTEST_DIR/nb=
d: Requested export not available
+qemu-io: can't open device nbd+unix:///no_such_export?socket=3DSOCK_DIR/nb=
d: Requested export not available
 server reported: export 'no_such_export' not present
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
--=20
2.21.0


