Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9EDC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481A6217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCfz0yEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481A6217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgl6-0004oR-Fu
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdR-0003Ed-KD
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdQ-000117-HG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdQ-0000zX-E3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fv9iuPe4fOjRmAYC2LNSulU/wbUS6J4liTwKpDL7Qu4=;
 b=CCfz0yEKz/Y2OR/e+6lOZ5ffItL5YSwYKfqLViJEiqxwLabZiG3voDnfK2R5IlqTR9Q4A4
 YkoyWgWjuaqTFehbqpGnoZxsKx56/Zn9PLLdWLzLhqgfo8EIfg8+vJ5wRAQJq9ksAs8qu6
 DY7O5fDoJAewR6gSZXn/sm1A9amAgUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-GBejXUsPOx-0KwxyGXoagw-1; Thu, 06 Feb 2020 07:51:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B79C51005F95;
 Thu,  6 Feb 2020 12:51:50 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5951366834;
 Thu,  6 Feb 2020 12:51:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/17] iotests: Check for the availability of the required
 devices in 267 and 127
Date: Thu,  6 Feb 2020 13:51:23 +0100
Message-Id: <20200206125132.594625-9-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: GBejXUsPOx-0KwxyGXoagw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We are going to enable 127 in the "auto" group, but it only works if
virtio-scsi and scsi-hd are available - which is not the case with
QEMU binaries like qemu-system-tricore for example, so we need a
proper check for the availability of these devices here.

A very similar problem exists in iotest 267 - it has been added to
the "auto" group already, but requires virtio-blk and thus currently
fails with qemu-system-tricore for example. Let's also add aproper
check there.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 20200121095205.26323-5-thuth@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/127       |  2 ++
 tests/qemu-iotests/267       |  2 ++
 tests/qemu-iotests/common.rc | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index b64926ab31..a4fc866038 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -43,6 +43,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
=20
+_require_devices virtio-scsi scsi-hd
+
 IMG_SIZE=3D64K
=20
 _make_test_img $IMG_SIZE
diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
index c296877168..3146273eef 100755
--- a/tests/qemu-iotests/267
+++ b/tests/qemu-iotests/267
@@ -46,6 +46,8 @@ _require_drivers copy-on-read
 # and generally impossible with external data files
 _unsupported_imgopts 'refcount_bits=3D1[^0-9]' data_file
=20
+_require_devices virtio-blk
+
 do_run_qemu()
 {
     echo Testing: "$@"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 9ccde32634..8a6366c09d 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -713,5 +713,19 @@ _require_large_file()
     rm "$TEST_IMG"
 }
=20
+# Check that a set of devices is available in the QEMU binary
+#
+_require_devices()
+{
+    available=3D$($QEMU -M none -device help | \
+                grep ^name | sed -e 's/^name "//' -e 's/".*$//')
+    for device
+    do
+        if ! echo "$available" | grep -q "$device" ; then
+            _notrun "$device not available"
+        fi
+    done
+}
+
 # make sure this script returns success
 true
--=20
2.24.1


