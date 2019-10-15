Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BB5ECE58C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2BE20872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2BE20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKScu-00073S-9C
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 15:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iKSbB-0005TL-60
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iKSb9-0006Va-LD
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:35:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iKSb6-0006Tj-HH; Tue, 15 Oct 2019 15:35:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9C4C83F3C;
 Tue, 15 Oct 2019 19:35:07 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44D9919C4F;
 Tue, 15 Oct 2019 19:35:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] tests: More iotest 223 improvements
Date: Tue, 15 Oct 2019 14:35:03 -0500
Message-Id: <20191015193503.25591-4-eblake@redhat.com>
In-Reply-To: <20191015193503.25591-1-eblake@redhat.com>
References: <20191015193503.25591-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 15 Oct 2019 19:35:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Run the core of the test twice, once without iothreads, and again
with, for more coverage of both setups.

Suggested-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/223     | 16 ++++++-
 tests/qemu-iotests/223.out | 85 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 2ba3d8124b4f..8b43ddb02b2c 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -117,10 +117,19 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"qmp_capabi=
lities"}' "return"
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
@@ -180,6 +189,9 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-r=
emove",
   "arguments":{"name":"n2"}}' "error" # Attempt duplicate clean
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "error" # Ag=
ain
+
+done
+
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"
 wait=3Dyes _cleanup_qemu

diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 8bfc5072ea9d..ed543047956f 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -28,10 +28,91 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"execute":"blockdev-add", "arguments":{"driver":"qcow2", "node-name":"n=
", "file":{"driver":"file", "filename":"TEST_DIR/t.qcow2"}}}
 {"return": {}}
-{"execute":"x-blockdev-set-iothread", "arguments":{"node-name":"n", "iot=
hread":"io0"}}
-{"return": {}}
 {"execute":"block-dirty-bitmap-disable", "arguments":{"node":"n", "name"=
:"b"}}
 {"return": {}}
+
+=3D=3D=3D Set up NBD with normal access =3D=3D=3D
+
+{"execute":"nbd-server-add", "arguments":{"device":"n"}}
+{"error": {"class": "GenericError", "desc": "NBD server not running"}}
+{"execute":"nbd-server-start", "arguments":{"addr":{"type":"unix", "data=
":{"path":"TEST_DIR/nbd"}}}}
+{"return": {}}
+{"execute":"nbd-server-start", "arguments":{"addr":{"type":"unix", "data=
":{"path":"TEST_DIR/nbd1"}}}}
+{"error": {"class": "GenericError", "desc": "NBD server already running"=
}}
+exports available: 0
+{"execute":"nbd-server-add", "arguments":{"device":"n", "bitmap":"b"}}
+{"return": {}}
+{"execute":"nbd-server-add", "arguments":{"device":"nosuch"}}
+{"error": {"class": "GenericError", "desc": "Cannot find device=3Dnosuch=
 nor node_name=3Dnosuch"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n"}}
+{"error": {"class": "GenericError", "desc": "NBD server already has expo=
rt named 'n'"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bi=
tmap":"b2"}}
+{"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompa=
tible with readonly export"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bi=
tmap":"b3"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'b3' is not found"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "wr=
itable":true, "bitmap":"b2"}}
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
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET},
+{ "start": 1048576, "length": 3145728, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET}]
+[{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false=
},
+{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]
+
+=3D=3D=3D Contrast to small granularity dirty-bitmap =3D=3D=3D
+
+[{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true, "=
offset": OFFSET},
+{ "start": 512, "length": 512, "depth": 0, "zero": false, "data": false}=
,
+{ "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": t=
rue, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]
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
+{"execute":"x-blockdev-set-iothread", "arguments":{"node-name":"n", "iot=
hread":"io0"}}
+{"return": {}}
 {"execute":"nbd-server-add", "arguments":{"device":"n"}}
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
 {"execute":"nbd-server-start", "arguments":{"addr":{"type":"unix", "data=
":{"path":"TEST_DIR/nbd"}}}}
--=20
2.21.0


