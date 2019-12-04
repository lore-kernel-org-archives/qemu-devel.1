Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622BCC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBAE2084B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doDqupIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBAE2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWvL-0000uh-6l
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icWrO-0007NX-OP
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icWrN-0008Ss-6J
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:46:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29741
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icWrM-0008Rp-QR
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575474395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTXssPse7UZyktj9whmk8xhBp0q1OIis1hguSo9ilPs=;
 b=doDqupInRrzyHr+FG8/NSPKAG+iltP9pst5qSVas3ntJGCN2yyvIToLDHA3se8Wdbj4xK+
 3kiirBen3SfRZ5OsA2xES3zh9nXij4owNOESnKXHLDJdy5tpyziZtOeqs5ncmiaWVWJ4EX
 KPf7a5S+wTFcooxTcOyIgjAcDyO/FpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-OUeeyZm6O_yVg9RHYos1Dw-1; Wed, 04 Dec 2019 10:46:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76BF71005509;
 Wed,  4 Dec 2019 15:46:33 +0000 (UTC)
Received: from thuth.com (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BA6A600C8;
 Wed,  4 Dec 2019 15:46:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] iotests: Provide a function for checking the creation
 of huge files
Date: Wed,  4 Dec 2019 16:46:12 +0100
Message-Id: <20191204154618.23560-2-thuth@redhat.com>
In-Reply-To: <20191204154618.23560-1-thuth@redhat.com>
References: <20191204154618.23560-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: OUeeyZm6O_yVg9RHYos1Dw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-block@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Eric Auger <eric.auger@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some tests create huge (but sparse) files, and to be able to run those
tests in certain limited environments (like CI containers), we have to
check for the possibility to create such files first. Thus let's introduce
a common function to check for large files, and replace the already
existing checks in the iotests 005 and 220 with this function.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.18.1


