Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB00C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9156217F5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ja6bMWCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9156217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibilZ-00082I-Ed
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ibifX-0001qW-3N
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ibifV-0004z9-RE
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:11:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53070
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ibifV-0004yz-OE
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575281461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=puEfc5jF0/P7uJ8jt9sYIJzKomt/3a3r+moaOK4a4pE=;
 b=Ja6bMWCCsIixCmPYlN9bIEH2rxyPq0ucTTI2C3lqF9MyKq5QIFJPPkAPu42ltMZHqc+paa
 BV5z2jLIbgoeMgZt0M58z+UW+nEvdIl//UY5bQ7byxSerrOld3vAS0qReqNAOa3M+KXUlC
 JefOHAu33USHOsbUQgxb7kePxW4pYPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-5azACmADOMKJDqIVff8CFQ-1; Mon, 02 Dec 2019 05:10:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F49E107ACC5;
 Mon,  2 Dec 2019 10:10:55 +0000 (UTC)
Received: from thuth.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68E1719C68;
 Mon,  2 Dec 2019 10:10:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Subject: [PATCH v4 4/6] iotests: Check for the availability of the required
 devices in 267 and 127
Date: Mon,  2 Dec 2019 11:10:37 +0100
Message-Id: <20191202101039.8981-5-thuth@redhat.com>
In-Reply-To: <20191202101039.8981-1-thuth@redhat.com>
References: <20191202101039.8981-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 5azACmADOMKJDqIVff8CFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to enable 127 in the "auto" group, but it only works if
virtio-scsi and scsi-hd are available - which is not the case with
QEMU binaries like qemu-system-tricore for example, so we need a
proper check for the availability of these devices here.

A very similar problem exists in iotest 267 - it has been added to
the "auto" group already, but requires virtio-blk and thus currently
fails with qemu-system-tricore for example. Let's also add aproper
check there.

Signed-off-by: Thomas Huth <thuth@redhat.com>
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
index 170e173c0a..17ac640a83 100755
--- a/tests/qemu-iotests/267
+++ b/tests/qemu-iotests/267
@@ -44,6 +44,8 @@ _supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=3D1
 _unsupported_imgopts 'refcount_bits=3D1[^0-9]'
=20
+_require_devices virtio-blk
+
 do_run_qemu()
 {
     echo Testing: "$@"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 0cc8acc9ed..38e949cf69 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -643,5 +643,19 @@ _require_drivers()
     done
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
2.18.1


