Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB95C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9828E217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THthAhNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9828E217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgnS-0008Sd-NB
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdT-0003KV-FG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdS-00018W-En
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28626
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdS-00017Y-BP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKGF0Ult7NG+tisw2QVtpL2MEf27Olpax01S7X0f72A=;
 b=THthAhNOJs24Gt955RDgvz1xm0zBwV18++LS0WyBzIjzmy4L3kgfJouLnz9XHNq9lYGWCn
 +09PuKMiQ4mDK0uY03A09KUZ5BgvsWDJNG/mIquuOmgK4k242BVyJl+dSu+b4C5O0dWHqy
 1zcS2B3UHNrJf6JlnFr0JzJ84YNBEak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-SoVDdiE3PzOqfXXOxwtbjA-1; Thu, 06 Feb 2020 07:51:53 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFFB418CA24E;
 Thu,  6 Feb 2020 12:51:52 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63FA05DA7C;
 Thu,  6 Feb 2020 12:51:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/17] iotests: Skip Python-based tests if QEMU does not
 support virtio-blk
Date: Thu,  6 Feb 2020 13:51:24 +0100
Message-Id: <20200206125132.594625-10-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: SoVDdiE3PzOqfXXOxwtbjA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We are going to enable some of the python-based tests in the "auto" group,
and these tests require virtio-blk to work properly. Running iotests
without virtio-blk likely does not make too much sense anyway, so instead
of adding a check for the availability of virtio-blk to each and every
test (which does not sound very appealing), let's rather add a check for
this a central spot in the "check" script instead (so that it is still
possible to run "make check" for qemu-system-tricore for example).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 20200121095205.26323-6-thuth@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/check | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 39ed5bc1be..fff5fa956a 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -655,7 +655,15 @@ fi
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
+    else
+        python_unusable_because=3D"Missing virtio-blk in QEMU binary"
+    fi
+else
+    python_unusable_because=3D"Unsupported Python version"
 fi
=20
 default_machine=3D$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//=
p')
@@ -843,7 +851,7 @@ do
                 run_command=3D"$PYTHON $seq"
             else
                 run_command=3D"false"
-                echo "Unsupported Python version" > $seq.notrun
+                echo "$python_unusable_because" > $seq.notrun
             fi
         else
             run_command=3D"./$seq"
--=20
2.24.1


