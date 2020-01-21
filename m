Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD27C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C1121569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adhgYGkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C1121569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvxk-0005Kd-9X
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itvw9-0003rl-Il
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itvw8-0004a8-Ga
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:59:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42086
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itvw8-0004Zs-DF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579622368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5YOvBJzsB/me9wS33tdEezh/VBgVL25dn4DHeAbG1vk=;
 b=adhgYGkPvAiM507NQL1VZXS4N/9rtI3QTsuoqG+m2ewq4ceyki09bADlMWEvxkw+HRMknD
 XF/7kNe8Q+JdIIx/3rSdQbtgmAPEFnNpLpdZbfeK3d3QrOMf3oM+qjUnGu21ubiMx8amXL
 AUDJbzZ2CdLl17LzLvVtKSQIO4mP3Vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-T4PWjjnlNUSL6IX24qmKEw-1; Tue, 21 Jan 2020 10:59:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29321DB35;
 Tue, 21 Jan 2020 15:59:25 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 169008642E;
 Tue, 21 Jan 2020 15:59:23 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] iotests: Test convert -n -B to backing-less target
Date: Tue, 21 Jan 2020 16:59:15 +0100
Message-Id: <20200121155915.98232-3-mreitz@redhat.com>
In-Reply-To: <20200121155915.98232-1-mreitz@redhat.com>
References: <20200121155915.98232-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: T4PWjjnlNUSL6IX24qmKEw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This must not crash.

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


