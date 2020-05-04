Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78800C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417E52073B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XogL0blC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417E52073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVb2r-00020w-Cj
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVb18-0008T3-7E
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:20:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVb17-0002xS-04
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588598416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3YhEutn5Gr/M75I/d8hXtmluiCIKB8Wvue/f0SwLZYw=;
 b=XogL0blCNzQFwv9+Q9kRksRAccRnWLXyvl2jQ7vBRnlD/7fVNLRug/VRV9bqs4962wMPMV
 mrPscbK3nfWfT3DmOTEpeOeDrIRl7kghn5gvCTqMVx4vxS32Z7haiZFNbnSptnDjbC/I8l
 GSjz2oFDfnVeliZPqt2Ms1hm/foiKBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-IsSV7J_7Mc6XEP-z3UWwqw-1; Mon, 04 May 2020 09:20:14 -0400
X-MC-Unique: IsSV7J_7Mc6XEP-z3UWwqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A7887BB8;
 Mon,  4 May 2020 13:20:06 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7387563F65;
 Mon,  4 May 2020 13:20:01 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] Fix iotest 153
Date: Mon,  4 May 2020 16:19:59 +0300
Message-Id: <20200504131959.9533-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
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
but this test uses it.
Since this test only tries to do a dry-run run of qemu-img amend,
replace the -o "" with dummy -o "size=3D$size".

Fixes: f62514b3def5fb2acbef64d0e053c0c31fa45aff

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/153     |  2 +-
 tests/qemu-iotests/153.out | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 2b13111768..cf961d3609 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -122,7 +122,7 @@ for opts1 in "" "read-only=3Don" "read-only=3Don,force-=
share=3Don"; do
         _run_cmd $QEMU_IMG check       $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG compare     $L "${TEST_IMG}" "${TEST_IMG}"
         _run_cmd $QEMU_IMG map         $L "${TEST_IMG}"
-        _run_cmd $QEMU_IMG amend -o "" $L "${TEST_IMG}"
+        _run_cmd $QEMU_IMG amend -o "size=3D$size" $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG commit      $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG resize      $L "${TEST_IMG}" $size
         _run_cmd $QEMU_IMG rebase      $L "${TEST_IMG}" -b "${TEST_IMG}.ba=
se"
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index f7464dd8d3..b2a90caa6b 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -56,7 +56,7 @@ _qemu_img_wrapper map TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
-_qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D32M TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
@@ -118,7 +118,7 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/=
t.qcow2
=20
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
=20
-_qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D32M -U TEST_DIR/t.qcow2
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
@@ -187,7 +187,7 @@ _qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.q=
cow2
=20
 _qemu_img_wrapper map TEST_DIR/t.qcow2
=20
-_qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D32M TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
@@ -241,7 +241,7 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/=
t.qcow2
=20
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
=20
-_qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D32M -U TEST_DIR/t.qcow2
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
@@ -303,7 +303,7 @@ _qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.q=
cow2
=20
 _qemu_img_wrapper map TEST_DIR/t.qcow2
=20
-_qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D32M TEST_DIR/t.qcow2
=20
 _qemu_img_wrapper commit TEST_DIR/t.qcow2
=20
@@ -345,7 +345,7 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/=
t.qcow2
=20
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
=20
-_qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
+_qemu_img_wrapper amend -o size=3D32M -U TEST_DIR/t.qcow2
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
--=20
2.17.2


