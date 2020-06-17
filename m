Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE86AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8BB20CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PskrZ16J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8BB20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVdV-0008KT-Nv
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlVcR-0006Mn-0U
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlVcL-0002rm-Pa
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592390909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JeLCn0lDrN52b1nmtuGqj498yZlBEJPzm3iAoxTHi2Q=;
 b=PskrZ16J/J53SXHQSENoaERf4ixM7KXIoRc1izkSsgpXUAw1Zyu3FKEo1qFBmtzno7ilD4
 dqeXZzeBN2gXgP3bF2w+KVDNkkzwPzb+2Ln+0Jc5pVrw+kn6TLI0VEKwFu6Kgs9okU/vPa
 nY+r8kAjIwMVH/sph+j8tvSMLLMo8O8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-HlIHTzYqMx-e8oARPDMvDg-1; Wed, 17 Jun 2020 06:48:27 -0400
X-MC-Unique: HlIHTzYqMx-e8oARPDMvDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C3BFE919;
 Wed, 17 Jun 2020 10:48:26 +0000 (UTC)
Received: from localhost (ovpn-113-111.ams2.redhat.com [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E80A410013D6;
 Wed, 17 Jun 2020 10:48:25 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/5] iotests.py: Add skip_for_formats() decorator
Date: Wed, 17 Jun 2020 12:48:18 +0200
Message-Id: <20200617104822.27525-2-mreitz@redhat.com>
In-Reply-To: <20200617104822.27525-1-mreitz@redhat.com>
References: <20200617104822.27525-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes, we want to skip some test methods for certain formats.  This
decorator allows that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/118        |  7 +++----
 tests/qemu-iotests/iotests.py | 13 +++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index adc8a848b5..2350929fd8 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -683,11 +683,10 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
         except OSError:
             pass
 
+    # We need backing file support
+    @iotests.skip_for_formats(('vpc', 'parallels', 'qcow', 'vdi', 'vmdk', 'raw',
+                               'vhdx'))
     def test_snapshot_and_commit(self):
-        # We need backing file support
-        if iotests.imgfmt != 'qcow2' and iotests.imgfmt != 'qed':
-            return
-
         result = self.vm.qmp('blockdev-snapshot-sync', device='drive0',
                                                        snapshot_file=new_img,
                                                        format=iotests.imgfmt)
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index f20d90f969..92c08b9dc6 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1103,6 +1103,19 @@ def skip_if_unsupported(required_formats=(), read_only=False):
         return func_wrapper
     return skip_test_decorator
 
+def skip_for_formats(formats: Sequence[str] = ()):
+    '''Skip Test Decorator
+       Skips the test for the given formats'''
+    def skip_test_decorator(func):
+        def func_wrapper(test_case: QMPTestCase, *args: List[Any],
+                         **kwargs: Dict[str, Any]) -> None:
+            if imgfmt in formats:
+                test_case.case_skip(f'{test_case}: Skipped for format {imgfmt}')
+            else:
+                func(test_case, *args, **kwargs)
+        return func_wrapper
+    return skip_test_decorator
+
 def skip_if_user_is_root(func):
     '''Skip Test Decorator
        Runs the test only without root permissions'''
-- 
2.26.2


