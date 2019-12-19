Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6F2C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF83227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMvnBkQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF83227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzZq-0008Os-0b
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzXj-000671-EC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzXg-0005Pl-Oc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzXg-0005Jo-IA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FC+5ANwUnUTOhltzSZFm3ttJ4/0HCjiTAYrnNTZpJCE=;
 b=LMvnBkQZ3AN36maydWI8THoNjys3cnhW1a/XphF3vdOSwK8h1r7auORE/CHrxrrc+DSWwi
 4afCPYxDKp+lsss3+LtBIFOU4102oqtbln4qE5jysxQXJIoep9JDdeR0tBFXTyw8FI+gYl
 SJAaHVtGMXKn06BhHW7G2ER4RTdFCBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-aCypv3kqNf6YLYW5L-bihA-1; Thu, 19 Dec 2019 12:24:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3B28DB64;
 Thu, 19 Dec 2019 17:24:48 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE39C620C0;
 Thu, 19 Dec 2019 17:24:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/30] iotests: Provide a function for checking the creation of
 huge files
Date: Thu, 19 Dec 2019 18:24:12 +0100
Message-Id: <20191219172441.7289-2-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: aCypv3kqNf6YLYW5L-bihA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Some tests create huge (but sparse) files, and to be able to run those
tests in certain limited environments (like CI containers), we have to
check for the possibility to create such files first. Thus let's introduce
a common function to check for large files, and replace the already
existing checks in the iotests 005 and 220 with this function.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/005       |  5 +----
 tests/qemu-iotests/220       |  6 ++----
 tests/qemu-iotests/common.rc | 10 ++++++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 58442762fe..b6d03ac37d 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -59,10 +59,7 @@ fi
 # Sanity check: For raw, we require a file system that permits the creatio=
n
 # of a HUGE (but very sparse) file. Check we can create it before continui=
ng.
 if [ "$IMGFMT" =3D "raw" ]; then
-    if ! truncate --size=3D5T "$TEST_IMG"; then
-        _notrun "file system on $TEST_DIR does not support large enough fi=
les"
-    fi
-    rm "$TEST_IMG"
+    _require_large_file 5T
 fi
=20
 echo
diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
index 2d62c5dcac..15159270d3 100755
--- a/tests/qemu-iotests/220
+++ b/tests/qemu-iotests/220
@@ -42,10 +42,8 @@ echo "=3D=3D Creating huge file =3D=3D"
=20
 # Sanity check: We require a file system that permits the creation
 # of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
-if ! truncate --size=3D513T "$TEST_IMG"; then
-    _notrun "file system on $TEST_DIR does not support large enough files"
-fi
-rm "$TEST_IMG"
+_require_large_file 513T
+
 IMGOPTS=3D'cluster_size=3D2M,refcount_bits=3D1' _make_test_img 513T
=20
 echo "=3D=3D Populating refcounts =3D=3D"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 0cc8acc9ed..6f0582c79a 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -643,5 +643,15 @@ _require_drivers()
     done
 }
=20
+# Check that we have a file system that allows huge (but very sparse) file=
s
+#
+_require_large_file()
+{
+    if ! truncate --size=3D"$1" "$TEST_IMG"; then
+        _notrun "file system on $TEST_DIR does not support large enough fi=
les"
+    fi
+    rm "$TEST_IMG"
+}
+
 # make sure this script returns success
 true
--=20
2.20.1


