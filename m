Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA908C432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94DE217F5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoULo5Ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94DE217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibild-00088C-JX
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ibifb-0001xM-0K
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ibifZ-00051f-Va
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:11:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42457
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ibifZ-00051P-Rx
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575281465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sSaJ5Yo6VbNBzWtV5Wh3mBfYOPEEqnlgqFoIqQwA2w=;
 b=KoULo5JiOZR71nFNST4pKMLLeSdfbGmpVTi9CAm9prqAkziIRMU7VApe2THB81e3J4XeDr
 w/bzzPQU1cbOLZkYGsoKY07c7N4Kg7xK6ddAelwvO2hYzahxr+2A7vSurHjcGaRHohyPyU
 NkSmpzOga0Y+DKdzPItaRVakGP0MxJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-D7qeQ5J6OOOLmZnbCMbWMA-1; Mon, 02 Dec 2019 05:10:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D332800D4C;
 Mon,  2 Dec 2019 10:10:57 +0000 (UTC)
Received: from thuth.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC93F19C68;
 Mon,  2 Dec 2019 10:10:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Subject: [PATCH v4 5/6] iotests: Skip Python-based tests if QEMU does not
 support virtio-blk
Date: Mon,  2 Dec 2019 11:10:38 +0100
Message-Id: <20191202101039.8981-6-thuth@redhat.com>
In-Reply-To: <20191202101039.8981-1-thuth@redhat.com>
References: <20191202101039.8981-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: D7qeQ5J6OOOLmZnbCMbWMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to enable some of the python-based tests in the "auto" group,
and these tests require virtio-blk to work properly. Running iotests
without virtio-blk likely does not make too much sense anyway, so instead
of adding a check for the availability of virtio-blk to each and every
test (which does not sound very appealing), let's rather add a check for
this a central spot in the "check" script instead (so that it is still
possible to run "make check" for qemu-system-tricore for example).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/check | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 90970b0549..bce3035d5a 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -642,7 +642,11 @@ fi
 python_usable=3Dfalse
 if $PYTHON -c 'import sys; sys.exit(0 if sys.version_info >=3D (3,6) else =
1)'
 then
-    python_usable=3Dtrue
+    # Our python framework also requires virtio-blk
+    if "$QEMU_PROG" -M none -device help | grep -q virtio-blk >/dev/null 2=
>&1
+    then
+        python_usable=3Dtrue
+    fi
 fi
=20
 default_machine=3D$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//=
p')
@@ -830,7 +834,7 @@ do
                 run_command=3D"$PYTHON $seq"
             else
                 run_command=3D"false"
-                echo "Unsupported Python version" > $seq.notrun
+                echo "Unsupported Python version or missing virtio-blk" > =
$seq.notrun
             fi
         else
             run_command=3D"./$seq"
--=20
2.18.1


