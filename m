Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4095C11D0B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBC720658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3+u+fR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBC720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oUI-00071C-NM
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oSH-00045A-Cj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oSG-0007ic-C7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oSG-0007iQ-2C
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582215215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D/RFWb//vwRXnJ50nvQetO6VIazhkUzCowSW8Gse64g=;
 b=a3+u+fR1U9u7SOTizhpD6XsvgAYLE0BvGt+iKO3GV89LFaqrpZjhz4Z9W5di5+gBaVbtf0
 64JmvbvtpTgldxDBMSlsKW452xMvmFrJcbtfkl5ws0dWL/U6dE9ojD5/dXqnpapk5b+Avn
 FKwXFNDQY1IOBrlLTpGC9QFxCSHH2y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-IRn26HcEMyyuG-rXbjH7Vg-1; Thu, 20 Feb 2020 11:13:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88F38800D4E;
 Thu, 20 Feb 2020 16:13:27 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A76CF87B0A;
 Thu, 20 Feb 2020 16:13:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/18] iotests: Test convert -n -B to backing-less target
Date: Thu, 20 Feb 2020 17:07:08 +0100
Message-Id: <20200220160710.533297-17-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: IRn26HcEMyyuG-rXbjH7Vg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

This must not crash.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200121155915.98232-3-mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/122     | 14 ++++++++++++++
 tests/qemu-iotests/122.out |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index dfa350936f..f7a3ae684a 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -276,6 +276,20 @@ $QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG=
".orig
=20
 $QEMU_IMG compare "$TEST_IMG" "$TEST_IMG".orig
=20
+echo
+echo '=3D=3D=3D -n -B to an image without a backing file =3D=3D=3D'
+echo
+
+# Base for the output
+TEST_IMG=3D"$TEST_IMG".base _make_test_img 64M
+
+# Output that does have $TEST_IMG.base set as its (implicit) backing file
+TEST_IMG=3D"$TEST_IMG".orig _make_test_img 64M
+
+# Convert with -n, which should not confuse -B with "target BDS has a
+# backing file"
+$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -n "$TEST_IMG" "$TEST_IMG=
".orig
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 849b6cc2ef..1a35951a80 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -228,4 +228,9 @@ Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=
=3D67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Images are identical.
+
+=3D=3D=3D -n -B to an image without a backing file =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D67108864
 *** done
--=20
2.24.1


