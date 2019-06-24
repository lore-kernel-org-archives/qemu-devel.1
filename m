Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7363C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAB820657
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAB820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfTBS-00040V-Vb
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49156)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfSx2-0001g6-Qr
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfSwz-0005Vq-Vv
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfSwv-0005Mp-Pv; Mon, 24 Jun 2019 13:40:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D7043092654;
 Mon, 24 Jun 2019 17:40:13 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9478D608BA;
 Mon, 24 Jun 2019 17:40:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 19:39:33 +0200
Message-Id: <20190624173935.25747-14-mreitz@redhat.com>
In-Reply-To: <20190624173935.25747-1-mreitz@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 24 Jun 2019 17:40:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 13/14] iotests: qcow2's encrypt.format is
 now optional
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the encrypt.format option from the two blockdev-add test cases
for encrypted qcow2 images in 087 to explicitly test that this parameter
is now optional.

Additionally, show that explicitly specifying encrypt.format=3Dauto works
just as well, the same for specifying the correct format
(encrypt.format=3Dluks here), and that specifying the wrong format
(encrypt.format=3Daes) results in an error.

While touching this test case, reduce the LUKS iteration time to 10 so
the test stays reasonably fast.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/087     | 65 +++++++++++++++++++++++---------------
 tests/qemu-iotests/087.out | 26 ++++++++++++++-
 2 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index d6c8613419..0e52dec483 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -149,7 +149,6 @@ run_qemu <<EOF
           "filename": "$TEST_IMG"
       },
       "encrypt": {
-          "format": "aes",
           "key-secret": "sec0"
       }
     }
@@ -161,34 +160,48 @@ echo
 echo =3D=3D=3D Encrypted image LUKS =3D=3D=3D
 echo
=20
-_make_test_img --object secret,id=3Dsec0,data=3D123456 -o encrypt.format=
=3Dluks,encrypt.key-secret=3Dsec0 $size
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "object-add",
-  "arguments": {
-      "qom-type": "secret",
-      "id": "sec0",
-      "props": {
-          "data": "123456"
-      }
-  }
-}
-{ "execute": "blockdev-add",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "node-name": "disk",
-      "file": {
-          "driver": "file",
-          "filename": "$TEST_IMG"
-      },
-      "encrypt": {
-        "format": "luks",
-        "key-secret": "sec0"
+_make_test_img \
+    --object secret,id=3Dsec0,data=3D123456 \
+    -o encrypt.format=3Dluks,encrypt.key-secret=3Dsec0,encrypt.iter-time=
=3D10 \
+    $size
+
+# Adds the qcow2+LUKS image via blockdev-add.
+# First parameter: Optional entry for the 'encrypt' option dict
+function luks_test()
+{
+    run_qemu <<EOF
+    { "execute": "qmp_capabilities" }
+    { "execute": "object-add",
+      "arguments": {
+          "qom-type": "secret",
+          "id": "sec0",
+          "props": {
+              "data": "123456"
+          }
       }
     }
-  }
-{ "execute": "quit" }
+    { "execute": "blockdev-add",
+      "arguments": {
+          "driver": "$IMGFMT",
+          "node-name": "disk",
+          "file": {
+              "driver": "file",
+              "filename": "$TEST_IMG"
+          },
+          "encrypt": {
+            $1
+            "key-secret": "sec0"
+          }
+        }
+      }
+    { "execute": "quit" }
 EOF
+}
+
+luks_test ''                    # Implicit encrypt.format=3Dauto
+luks_test '"format": "auto",'   # Explicit encrypt.format=3Dauto
+luks_test '"format": "luks",'   # Explicit encrypt.format=3Dluks
+luks_test '"format": "aes",'    # Explicit encrypt.format=3Daes (wrong)
=20
 echo
 echo =3D=3D=3D Missing driver =3D=3D=3D
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 2d92ea847b..6c1d83519b 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -46,7 +46,7 @@ QMP_VERSION
=20
 =3D=3D=3D Encrypted image LUKS =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encrypt.fo=
rmat=3Dluks encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encrypt.fo=
rmat=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -55,6 +55,30 @@ QMP_VERSION
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
=20
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Header reported 'luks' encr=
yption format but options specify 'aes'"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
=20
 =3D=3D=3D Missing driver =3D=3D=3D
=20
--=20
2.21.0


