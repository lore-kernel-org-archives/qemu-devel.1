Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F3BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E12219F6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3w9L0Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E12219F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWu1m-0005Ng-AE
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 22:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWtsK-0001xj-8o
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWtsI-0004oK-IG
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41197
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWtsI-0004ne-D3
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574132897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujtplviA/x8uN9i/qtZrm2+sdifmXmyfmx4eOWXFTso=;
 b=K3w9L0Rpc1WtbKaZZLIzcJpHlwN3SJIhJgWax7Nc1FEL1zXMU8I+7iH75Ds9ihoWE/lDTm
 c6Bv7LHaVK+cKyqsHYx/SzAPeTzjlwzr1h3xKtYLh6V3IpND2RVwg7haAN0pOv98MxQqdK
 Eof6lc0mYry4ZP4DUM2pz1plahdF94E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-v8tF2K64OiGj27LLTKr1gA-1; Mon, 18 Nov 2019 22:08:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7661D2EDA;
 Tue, 19 Nov 2019 03:08:15 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01AC787B1;
 Tue, 19 Nov 2019 03:08:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] tests: More iotest 223 improvements
Date: Mon, 18 Nov 2019 21:07:59 -0600
Message-Id: <20191119030759.24907-11-eblake@redhat.com>
In-Reply-To: <20191119030759.24907-1-eblake@redhat.com>
References: <20191119030759.24907-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: v8tF2K64OiGj27LLTKr1gA-1
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
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Run the core of the test twice, once without iothreads, and again
with, for more coverage of both setups.

Suggested-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20191114213415.23499-5-eblake@redhat.com>
---
 tests/qemu-iotests/223     | 16 ++++++-
 tests/qemu-iotests/223.out | 85 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index b5a80e50bbc1..ea69cd4b8b5e 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -117,10 +117,19 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"qmp_capabili=
ties"}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-add",
   "arguments":{"driver":"qcow2", "node-name":"n",
     "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-blockdev-set-iothread",
-  "arguments":{"node-name":"n", "iothread":"io0"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
   "arguments":{"node":"n", "name":"b"}}' "return"
+
+for attempt in normal iothread; do
+
+echo
+echo "=3D=3D=3D Set up NBD with $attempt access =3D=3D=3D"
+echo
+if [ $attempt =3D iothread ]; then
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-blockdev-set-iothread",
+  "arguments":{"node-name":"n", "iothread":"io0"}}' "return"
+fi
+
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n"}}' "error" # Attempt add without server
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
@@ -180,6 +189,9 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-rem=
ove",
   "arguments":{"name":"n2"}}' "error" # Attempt duplicate clean
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "error" # Agai=
n
+
+done
+
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"
 wait=3Dyes _cleanup_qemu

diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 861ddbd9e0a4..f17559880268 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -28,10 +28,91 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"execute":"blockdev-add", "arguments":{"driver":"IMGFMT", "node-name":"n"=
, "file":{"driver":"file", "filename":"TEST_DIR/t.IMGFMT"}}}
 {"return": {}}
-{"execute":"x-blockdev-set-iothread", "arguments":{"node-name":"n", "iothr=
ead":"io0"}}
-{"return": {}}
 {"execute":"block-dirty-bitmap-disable", "arguments":{"node":"n", "name":"=
b"}}
 {"return": {}}
+
+=3D=3D=3D Set up NBD with normal access =3D=3D=3D
+
+{"execute":"nbd-server-add", "arguments":{"device":"n"}}
+{"error": {"class": "GenericError", "desc": "NBD server not running"}}
+{"execute":"nbd-server-start", "arguments":{"addr":{"type":"unix", "data":=
{"path":"SOCK_DIR/nbd"}}}}
+{"return": {}}
+{"execute":"nbd-server-start", "arguments":{"addr":{"type":"unix", "data":=
{"path":"SOCK_DIR/nbd1"}}}}
+{"error": {"class": "GenericError", "desc": "NBD server already running"}}
+exports available: 0
+{"execute":"nbd-server-add", "arguments":{"device":"n", "bitmap":"b"}}
+{"return": {}}
+{"execute":"nbd-server-add", "arguments":{"device":"nosuch"}}
+{"error": {"class": "GenericError", "desc": "Cannot find device=3Dnosuch n=
or node_name=3Dnosuch"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n"}}
+{"error": {"class": "GenericError", "desc": "NBD server already has export=
 named 'n'"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitm=
ap":"b2"}}
+{"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompati=
ble with readonly export"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitm=
ap":"b3"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'b3' is not found"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "writ=
able":true, "bitmap":"b2"}}
+{"return": {}}
+exports available: 2
+ export: 'n'
+  size:  4194304
+  flags: 0x58f ( readonly flush fua df multi cache )
+  min block: 1
+  opt block: 4096
+  max block: 33554432
+  available meta contexts: 2
+   base:allocation
+   qemu:dirty-bitmap:b
+ export: 'n2'
+  size:  4194304
+  flags: 0xced ( flush fua trim zeroes df cache fast-zero )
+  min block: 1
+  opt block: 4096
+  max block: 33554432
+  available meta contexts: 2
+   base:allocation
+   qemu:dirty-bitmap:b2
+
+=3D=3D=3D Contrast normal status to large granularity dirty-bitmap =3D=3D=
=3D
+
+read 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 524288
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 2097152/2097152 bytes at offset 2097152
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "o=
ffset": OFFSET},
+{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET},
+{ "start": 1048576, "length": 3145728, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET}]
+[{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false},
+{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": tr=
ue, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": =
false}]
+
+=3D=3D=3D Contrast to small granularity dirty-bitmap =3D=3D=3D
+
+[{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true, "of=
fset": OFFSET},
+{ "start": 512, "length": 512, "depth": 0, "zero": false, "data": false},
+{ "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": tru=
e, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": =
false}]
+
+=3D=3D=3D End qemu NBD server =3D=3D=3D
+
+{"execute":"nbd-server-remove", "arguments":{"name":"n"}}
+{"return": {}}
+{"execute":"nbd-server-remove", "arguments":{"name":"n2"}}
+{"return": {}}
+{"execute":"nbd-server-remove", "arguments":{"name":"n2"}}
+{"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
+{"execute":"nbd-server-stop"}
+{"return": {}}
+{"execute":"nbd-server-stop"}
+{"error": {"class": "GenericError", "desc": "NBD server not running"}}
+
+=3D=3D=3D Set up NBD with iothread access =3D=3D=3D
+
+{"execute":"x-blockdev-set-iothread", "arguments":{"node-name":"n", "iothr=
ead":"io0"}}
+{"return": {}}
 {"execute":"nbd-server-add", "arguments":{"device":"n"}}
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
 {"execute":"nbd-server-start", "arguments":{"addr":{"type":"unix", "data":=
{"path":"SOCK_DIR/nbd"}}}}
--=20
2.21.0


