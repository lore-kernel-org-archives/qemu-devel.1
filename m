Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EEDC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C53B205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C53B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48288 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1hb-0001VS-NV
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:08:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1bZ-0004za-G8
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1bX-0002Sc-GT
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:02:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hO1bT-0002QS-AC; Tue, 07 May 2019 11:01:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BCC63001565;
	Tue,  7 May 2019 15:01:58 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DC18A53E20;
	Tue,  7 May 2019 15:01:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:01:51 -0500
Message-Id: <20190507150153.26859-4-eblake@redhat.com>
In-Reply-To: <20190507150153.26859-1-eblake@redhat.com>
References: <20190507150153.26859-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 07 May 2019 15:01:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/5] tests/qemu-iotests: Fix more reference
 output files due to recent qemu-io change
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The output of qemu-io changed recently - most tests have been fixed in
commit 36b9986b08787019ef42 ("tests/qemu-iotests: Fix output of qemu-io
related tests") already, but a qcow1, vmdk, and nbd test were still missi=
ng.

Fixes: 99e98d7c9fc1a1639fad ("qemu-io: Use error_[gs]et_progname()")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190501134127.21104-1-thuth@redhat.com>
[eblake: squash in NBD 083 fixes]
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/059.out |  8 ++---
 tests/qemu-iotests/083.out | 68 +++++++++++++++++++-------------------
 tests/qemu-iotests/092.out | 24 +++++++-------
 3 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 700ad1f2906..f51394ae8e0 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2,15 +2,15 @@ QA output created by 059

 =3D=3D=3D Testing invalid granularity =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.vmdk: Invalid granularity, image may be cor=
rupt
+qemu-io: can't open device TEST_DIR/t.vmdk: Invalid granularity, image m=
ay be corrupt

 =3D=3D=3D Testing too big L2 table size =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.vmdk: L2 table size too big
+qemu-io: can't open device TEST_DIR/t.vmdk: L2 table size too big

 =3D=3D=3D Testing too big L1 table size =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.vmdk: L1 size too big
+qemu-io: can't open device TEST_DIR/t.vmdk: L1 size too big

 =3D=3D=3D Testing monolithicFlat creation and opening =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2147483648 subformat=
=3DmonolithicFlat
@@ -2050,7 +2050,7 @@ wrote 512/512 bytes at offset 10240

 =3D=3D=3D Testing monolithicFlat with internally generated JSON file nam=
e =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 subformat=3D=
monolithicFlat
-can't open: Cannot use relative extent paths with VMDK descriptor file '=
json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driv=
er": "blkdebug", "inject-error.0.event": "read_aio"}'
+qemu-io: can't open: Cannot use relative extent paths with VMDK descript=
or file 'json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT=
"}, "driver": "blkdebug", "inject-error.0.event": "read_aio"}'

 =3D=3D=3D Testing version 3 =3D=3D=3D
 image: TEST_DIR/iotest-version3.IMGFMT
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index 7419722cd7a..eee6dd13794 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -1,43 +1,43 @@
 QA output created by 083
 =3D=3D=3D Check disconnect before neg1 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect after neg1 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 8 neg1 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 16 neg1 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect before export =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect after export =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 4 export =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 12 export =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 16 export =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect before neg2 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D

@@ -45,11 +45,11 @@ read failed: Input/output error

 =3D=3D=3D Check disconnect 8 neg2 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 10 neg2 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect before request =3D=3D=3D

@@ -86,23 +86,23 @@ read 512/512 bytes at offset 0

 =3D=3D=3D Check disconnect before neg-classic =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/

 =3D=3D=3D Check disconnect 8 neg-classic =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/

 =3D=3D=3D Check disconnect 16 neg-classic =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/

 =3D=3D=3D Check disconnect 24 neg-classic =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/

 =3D=3D=3D Check disconnect 28 neg-classic =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/

 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D

@@ -110,43 +110,43 @@ read failed: Input/output error

 =3D=3D=3D Check disconnect before neg1 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect after neg1 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 8 neg1 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 16 neg1 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect before export =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect after export =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 4 export =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 12 export =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 16 export =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect before neg2 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D

@@ -154,11 +154,11 @@ read failed: Input/output error

 =3D=3D=3D Check disconnect 8 neg2 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 10 neg2 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect before request =3D=3D=3D

@@ -195,23 +195,23 @@ read 512/512 bytes at offset 0

 =3D=3D=3D Check disconnect before neg-classic =3D=3D=3D

-can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 8 neg-classic =3D=3D=3D

-can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 16 neg-classic =3D=3D=3D

-can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 24 neg-classic =3D=3D=3D

-can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 28 neg-classic =3D=3D=3D

-can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D

diff --git a/tests/qemu-iotests/092.out b/tests/qemu-iotests/092.out
index 6eda321fc6b..3e799148735 100644
--- a/tests/qemu-iotests/092.out
+++ b/tests/qemu-iotests/092.out
@@ -2,25 +2,25 @@ QA output created by 092

 =3D=3D Invalid cluster size =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and =
64k
-can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and =
64k
-can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and =
64k
-can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and =
64k
+qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between=
 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between=
 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between=
 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between=
 512 and 64k

 =3D=3D Invalid L2 table size =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and=
 64k
-can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and=
 64k
-can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and=
 64k
-can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and=
 64k
+qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be betwee=
n 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be betwee=
n 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be betwee=
n 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be betwee=
n 512 and 64k

 =3D=3D Invalid size =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.qcow: Image too large
-can't open device TEST_DIR/t.qcow: Image too large
+qemu-io: can't open device TEST_DIR/t.qcow: Image too large
+qemu-io: can't open device TEST_DIR/t.qcow: Image too large

 =3D=3D Invalid backing file length =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.qcow: Backing file name too long
-can't open device TEST_DIR/t.qcow: Backing file name too long
+qemu-io: can't open device TEST_DIR/t.qcow: Backing file name too long
+qemu-io: can't open device TEST_DIR/t.qcow: Backing file name too long
 *** done
--=20
2.20.1


