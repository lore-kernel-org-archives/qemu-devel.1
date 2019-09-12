Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D4DC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 294C62084D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294C62084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PbJ-0006jX-P0
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 09:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8PR3-00037u-8E
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8PR2-0001ZQ-69
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8PQz-0001Y6-Hk; Thu, 12 Sep 2019 09:46:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D64663090FC2;
 Thu, 12 Sep 2019 13:46:52 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 449D8600C4;
 Thu, 12 Sep 2019 13:46:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:46:00 +0200
Message-Id: <20190912134604.22019-19-kwolf@redhat.com>
In-Reply-To: <20190912134604.22019-1-kwolf@redhat.com>
References: <20190912134604.22019-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 12 Sep 2019 13:46:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 18/22] iotests: extended timeout under Valgrind
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

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

As the iotests run longer under the Valgrind, the QEMU_COMM_TIMEOUT is
to be increased in the test cases 028, 183 and 192 when running under
the Valgrind.

Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/028 | 6 +++++-
 tests/qemu-iotests/183 | 9 ++++++++-
 tests/qemu-iotests/192 | 6 +++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 01f495912f..71301ec6e5 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -110,7 +110,11 @@ echo
 qemu_comm_method=3D"monitor"
 _launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
 h=3D$QEMU_HANDLE
-QEMU_COMM_TIMEOUT=3D1
+if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
+    QEMU_COMM_TIMEOUT=3D7
+else
+    QEMU_COMM_TIMEOUT=3D1
+fi
=20
 # Silence output since it contains the disk image path and QEMU's readli=
ne
 # character echoing makes it very hard to filter the output. Plus, there
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index fbe5a99beb..04fb344d08 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -94,8 +94,15 @@ if echo "$reply" | grep "compiled without old-style" >=
 /dev/null; then
     _notrun "migrate -b support not compiled in"
 fi
=20
-QEMU_COMM_TIMEOUT=3D0.1 qemu_cmd_repeat=3D50 silent=3Dyes \
+timeout_comm=3D$QEMU_COMM_TIMEOUT
+if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
+    QEMU_COMM_TIMEOUT=3D4
+else
+    QEMU_COMM_TIMEOUT=3D0.1
+fi
+qemu_cmd_repeat=3D50 silent=3Dyes \
     _send_qemu_cmd $src "{ 'execute': 'query-migrate' }" '"status": "com=
pleted"'
+QEMU_COMM_TIMEOUT=3D$timeout_comm
 _send_qemu_cmd $src "{ 'execute': 'query-status' }" "return"
=20
 echo
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 6193257764..034432272f 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -60,7 +60,11 @@ fi
 qemu_comm_method=3D"monitor"
 _launch_qemu -drive $DRIVE_ARG -incoming defer
 h=3D$QEMU_HANDLE
-QEMU_COMM_TIMEOUT=3D1
+if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
+    QEMU_COMM_TIMEOUT=3D7
+else
+    QEMU_COMM_TIMEOUT=3D1
+fi
=20
 _send_qemu_cmd $h "nbd_server_start unix:$TEST_DIR/nbd" "(qemu)"
 _send_qemu_cmd $h "nbd_server_add -w drive0" "(qemu)"
--=20
2.20.1


