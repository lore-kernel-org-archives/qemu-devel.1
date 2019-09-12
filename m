Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EE4C4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9662084D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9662084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PXD-0001bj-6l
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 09:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8PQy-00032d-UW
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8PQx-0001Wm-Hn
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8PQu-0001Tw-3F; Thu, 12 Sep 2019 09:46:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3CF64308A9E2;
 Thu, 12 Sep 2019 13:46:47 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30B34600C4;
 Thu, 12 Sep 2019 13:46:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:45:57 +0200
Message-Id: <20190912134604.22019-16-kwolf@redhat.com>
In-Reply-To: <20190912134604.22019-1-kwolf@redhat.com>
References: <20190912134604.22019-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 12 Sep 2019 13:46:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/22] iotests: exclude killed processes from
 running under Valgrind
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

 The Valgrind tool fails to manage its termination in multi-threaded
 processes when they raise the signal SIGKILL. The bug has been reported
 to the Valgrind maintainers and was registered as the bug #409141:
 https://bugs.kde.org/show_bug.cgi?id=3D409141
 Let's exclude such test cases from running under the Valgrind until a
 new version with the bug fix is released because checking for the
 memory issues is covered by other test cases.

Suggested-by: John Snow <jsnow@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/039       |  5 +++++
 tests/qemu-iotests/061       |  2 ++
 tests/qemu-iotests/137       |  1 +
 tests/qemu-iotests/common.rc | 12 ++++++++++--
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 7c730d94a7..325da63a4c 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -65,6 +65,7 @@ echo "=3D=3D Creating a dirty image file =3D=3D"
 IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don"
 _make_test_img $size
=20
+_NO_VALGRIND \
 $QEMU_IO -c "write -P 0x5a 0 512" \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
     | _filter_qemu_io
@@ -100,6 +101,7 @@ echo "=3D=3D Opening a dirty image read/write should =
repair it =3D=3D"
 IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don"
 _make_test_img $size
=20
+_NO_VALGRIND \
 $QEMU_IO -c "write -P 0x5a 0 512" \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
     | _filter_qemu_io
@@ -118,6 +120,7 @@ echo "=3D=3D Creating an image file with lazy_refcoun=
ts=3Doff =3D=3D"
 IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Doff"
 _make_test_img $size
=20
+_NO_VALGRIND \
 $QEMU_IO -c "write -P 0x5a 0 512" \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
     | _filter_qemu_io
@@ -151,6 +154,7 @@ echo "=3D=3D Changing lazy_refcounts setting at runti=
me =3D=3D"
 IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Doff"
 _make_test_img $size
=20
+_NO_VALGRIND \
 $QEMU_IO -c "reopen -o lazy-refcounts=3Don" \
          -c "write -P 0x5a 0 512" \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
@@ -163,6 +167,7 @@ _check_test_img
 IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don"
 _make_test_img $size
=20
+_NO_VALGRIND \
 $QEMU_IO -c "reopen -o lazy-refcounts=3Doff" \
          -c "write -P 0x5a 0 512" \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index d7dbd7e2c7..4eac5b83bd 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -73,6 +73,7 @@ echo
 echo "=3D=3D=3D Testing dirty version downgrade =3D=3D=3D"
 echo
 IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don" _make_test_img 64M
+_NO_VALGRIND \
 $QEMU_IO -c "write -P 0x2a 0 128k" -c flush \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 | _filter_qemu_i=
o
 $PYTHON qcow2.py "$TEST_IMG" dump-header
@@ -107,6 +108,7 @@ echo
 echo "=3D=3D=3D Testing dirty lazy_refcounts=3Doff =3D=3D=3D"
 echo
 IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don" _make_test_img 64M
+_NO_VALGRIND \
 $QEMU_IO -c "write -P 0x2a 0 128k" -c flush \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 | _filter_qemu_i=
o
 $PYTHON qcow2.py "$TEST_IMG" dump-header
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 0c3d2a1cf0..089821da0c 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -130,6 +130,7 @@ echo
=20
 # Whether lazy-refcounts was actually enabled can easily be tested: Chec=
k if
 # the dirty bit is set after a crash
+_NO_VALGRIND \
 $QEMU_IO \
     -c "reopen -o lazy-refcounts=3Don,overlap-check=3Dblubb" \
     -c "write -P 0x5a 0 512" \
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index f574d22ea5..51c57dbfe0 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -78,7 +78,7 @@ _qemu_proc_exec()
 {
     local VALGRIND_LOGFILE=3D"$1"
     shift
-    if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
+    if [[ "${VALGRIND_QEMU}" =3D=3D "y" && "${NO_VALGRIND}" !=3D "y" ]];=
 then
         exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcod=
e=3D99 "$@"
     else
         exec "$@"
@@ -89,7 +89,7 @@ _qemu_proc_valgrind_log()
 {
     local VALGRIND_LOGFILE=3D"$1"
     local RETVAL=3D"$2"
-    if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
+    if [[ "${VALGRIND_QEMU}" =3D=3D "y" && "${NO_VALGRIND}" !=3D "y" ]];=
 then
         if [ $RETVAL =3D=3D 99 ]; then
             cat "${VALGRIND_LOGFILE}"
         fi
@@ -169,6 +169,14 @@ _qemu_vxhs_wrapper()
     return $RETVAL
 }
=20
+# Valgrind bug #409141 https://bugs.kde.org/show_bug.cgi?id=3D409141
+# Until valgrind 3.16+ is ubiquitous, we must work around a hang in
+# valgrind when issuing sigkill. Disable valgrind for this invocation.
+_NO_VALGRIND()
+{
+    NO_VALGRIND=3D"y" "$@"
+}
+
 export QEMU=3D_qemu_wrapper
 export QEMU_IMG=3D_qemu_img_wrapper
 export QEMU_IO=3D_qemu_io_wrapper
--=20
2.20.1


