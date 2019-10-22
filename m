Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EEACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEAC2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETfJnLhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEAC2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMoW4-0006k7-C4
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 03:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iMoUT-0005Ep-Pl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iMoUS-0005Gm-LP
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:22:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52195
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iMoUS-0005GM-IJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571728920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ChAKUyJC7iiVoJsEwLh+lO4vhVCdqQ6OROJITLpnBN8=;
 b=ETfJnLhH+xb4e5j2QyGWJtQOWP67JwFbG/Mt6CEPs8EnofkAzl5nmeiqOu7SdEJJ62n9MF
 mXoYZHKCLWma9RDawjFvlQZQaJfuAwcyEmVGFP5HkE2keDQvOFPgN3XS8DjUzBtXWiIyE1
 eDLSR7gnyOgJ3hJd06myuuiOgXr3ZyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-gw2Cj09lNzKv0Qp_yfy4mA-1; Tue, 22 Oct 2019 03:21:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67AAD800D57;
 Tue, 22 Oct 2019 07:21:57 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C2DC2965D;
 Tue, 22 Oct 2019 07:21:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH v3 4/6] iotests: Skip "make check-block" if QEMU does not
 support virtio-blk
Date: Tue, 22 Oct 2019 09:21:33 +0200
Message-Id: <20191022072135.11188-5-thuth@redhat.com>
In-Reply-To: <20191022072135.11188-1-thuth@redhat.com>
References: <20191022072135.11188-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: gw2Cj09lNzKv0Qp_yfy4mA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next patch is going to add some python-based tests to the "auto"
group, and these tests require virtio-blk to work properly. Running
iotests without virtio-blk likely does not make too much sense anyway,
so instead of adding a check for the availability of virtio-blk to each
and every test (which does not sound very appealing), let's rather add
a check for this at the top level in the check-block.sh script instead
(so that it is possible to run "make check" without the "check-block"
part for qemu-system-tricore for example).

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/check-block.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/check-block.sh b/tests/check-block.sh
index 679aedec50..e9e2978818 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -26,10 +26,24 @@ if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/dev/=
null ; then
     exit 0
 fi
=20
-if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
+if [ -n "$QEMU_PROG" ]; then
+    qemu_prog=3D"$QEMU_PROG"
+else
+    for binary in *-softmmu/qemu-system-* ; do
+        if [ -x "$binary" ]; then
+            qemu_prog=3D"$binary"
+            break
+        fi
+    done
+fi
+if [ -z "$qemu_prog" ]; then
     echo "No qemu-system binary available =3D=3D> Not running the qemu-iot=
ests."
     exit 0
 fi
+if ! "$qemu_prog" -M none -device help | grep -q virtio-blk >/dev/null 2>&=
1 ; then
+    echo "$qemu_prog does not support virtio-blk =3D=3D> Not running the q=
emu-iotests."
+    exit 0
+fi
=20
 if ! command -v bash >/dev/null 2>&1 ; then
     echo "bash not available =3D=3D> Not running the qemu-iotests."
--=20
2.18.1


