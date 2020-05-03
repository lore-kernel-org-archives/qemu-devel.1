Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E30FC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 16:50:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B52206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 16:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bj/UOBV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B52206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVHpA-0002y2-VA
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 12:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVHoQ-0002Ta-1f
 for qemu-devel@nongnu.org; Sun, 03 May 2020 12:49:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22684
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVHoO-0001Wu-GF
 for qemu-devel@nongnu.org; Sun, 03 May 2020 12:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588524590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l/syZovk2iMl/EmIsQX1A/bHGAy/LxDdgGBUmHwsqaU=;
 b=bj/UOBV7d+89LVpdpL04tR4XnsElFH42LHOwZULD2fkDTwjFY+WJPeMVVPsQBjE6sRMqSY
 zJpNOSyp0NgaQZqoH64Q/qYGaLifTC79ERfc7qX8eBkm/2DUMyxRwdpK6iQ/6Ck/pNqXNO
 Qn/k+16Upmi2gJ7V6xdww9rLS/nXSek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-cNqqT8ekO6m56evs8XF-cg-1; Sun, 03 May 2020 12:49:48 -0400
X-MC-Unique: cNqqT8ekO6m56evs8XF-cg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E54B68014D6;
 Sun,  3 May 2020 16:49:47 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C6B710016DA;
 Sun,  3 May 2020 16:49:45 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Fix iotest 153
Date: Sun,  3 May 2020 19:49:43 +0300
Message-Id: <20200503164943.27215-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/03 12:49:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit f62514b3def5fb2acbef64d0e053c0c31fa45aff made qemu-img reject -o "" =
but this test uses it

Since this test only tries to do a dry-run run of qemu-img amend, replace t=
he -o "" with
dummy -o "size=3D0" since due to the nature of the test, it is not going
to reach the actual amend operation anyway

Fixes: f62514b3def5fb2acbef64d0e053c0c31fa45aff

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/153     |  2 +-
 tests/qemu-iotests/153.out | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 2b13111768..3f5029dd8f 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -122,7 +122,7 @@ for opts1 in "" "read-only=3Don" "read-only=3Don,force-=
share=3Don"; do
         _run_cmd $QEMU_IMG check       $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG compare     $L "${TEST_IMG}" "${TEST_IMG}"
         _run_cmd $QEMU_IMG map         $L "${TEST_IMG}"
-        _run_cmd $QEMU_IMG amend -o "" $L "${TEST_IMG}"
+        _run_cmd $QEMU_IMG amend -o "size=3D0" $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG commit      $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG resize      $L "${TEST_IMG}" $size
         _run_cmd $QEMU_IMG rebase      $L "${TEST_IMG}" -b "${TEST_IMG}.ba=
se"
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index f7464dd8d3..9c01b750e0 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -56,7 +56,7 @@ _qemu_img_wrapper map TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
-_qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D0 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
@@ -118,7 +118,7 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/=
t.qcow2
=20
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
=20
-_qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D0 -U TEST_DIR/t.qcow2
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
@@ -187,7 +187,7 @@ _qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.q=
cow2
=20
 _qemu_img_wrapper map TEST_DIR/t.qcow2
=20
-_qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D0 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
@@ -241,7 +241,7 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/=
t.qcow2
=20
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
=20
-_qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D0 -U TEST_DIR/t.qcow2
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
@@ -303,7 +303,7 @@ _qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.q=
cow2
=20
 _qemu_img_wrapper map TEST_DIR/t.qcow2
=20
-_qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D0 TEST_DIR/t.qcow2
=20
 _qemu_img_wrapper commit TEST_DIR/t.qcow2
=20
@@ -345,7 +345,7 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/=
t.qcow2
=20
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
=20
-_qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D0 -U TEST_DIR/t.qcow2
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
--=20
2.17.2


