Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27131C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096612054F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXGVCZM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096612054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYzB0-0001Au-3q
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 17:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8F-0006re-Ip
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34531
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8E-0005a5-5w
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589406096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXoCwbk+3HXyEFBiiOU0vwvD6R17WSdenHb1GicYPzY=;
 b=dXGVCZM8SuMtSgKjgdZR1uhxlQugFnlfStQxsPiMET4xQiBsHR0CpmD9eJG/YyJL4KEWiJ
 QAGviX6LiokLaY+Tc2SQoPCT/moOXOYX6p3GG3yxrn2EoXeqZtCRo66+FsUorem/y6jMRf
 1cbC4FMzapqqzZF12PP0/RzFcP6svvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-fMQ1shCZOFaNvBsxlgv9Pw-1; Wed, 13 May 2020 17:41:33 -0400
X-MC-Unique: fMQ1shCZOFaNvBsxlgv9Pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD834801503;
 Wed, 13 May 2020 21:41:32 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BEB21C94D;
 Wed, 13 May 2020 21:41:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC WIP 1/6] iotests: type hint wip
Date: Wed, 13 May 2020 17:41:25 -0400
Message-Id: <20200513214130.15375-2-jsnow@redhat.com>
In-Reply-To: <20200513214130.15375-1-jsnow@redhat.com>
References: <20200513214130.15375-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 6c0e781af7..27c477c8a7 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -90,7 +90,7 @@
 luks_default_key_secret_opt = 'key-secret=keysec0'
 
 
-def qemu_img(*args):
+def qemu_img(*args) -> int:
     '''Run qemu-img and return the exit code'''
     devnull = open('/dev/null', 'r+')
     exitcode = subprocess.call(qemu_img_args + list(args),
@@ -113,24 +113,24 @@ def ordered_qmp(qmsg, conv_keys=True):
         return od
     return qmsg
 
-def qemu_img_create(*args):
-    args = list(args)
+def qemu_img_create(*args: str) -> int:
+    qargs = list(args)
 
     # default luks support
-    if '-f' in args and args[args.index('-f') + 1] == 'luks':
-        if '-o' in args:
-            i = args.index('-o')
-            if 'key-secret' not in args[i + 1]:
-                args[i + 1].append(luks_default_key_secret_opt)
-                args.insert(i + 2, '--object')
-                args.insert(i + 3, luks_default_secret_object)
+    if '-f' in qargs and qargs[qargs.index('-f') + 1] == 'luks':
+        if '-o' in qargs:
+            i = qargs.index('-o')
+            if 'key-secret' not in qargs[i + 1]:
+                qargs[i + 1].append(luks_default_key_secret_opt)
+                qargs.insert(i + 2, '--object')
+                qargs.insert(i + 3, luks_default_secret_object)
         else:
-            args = ['-o', luks_default_key_secret_opt,
-                    '--object', luks_default_secret_object] + args
+            qargs = ['-o', luks_default_key_secret_opt,
+                     '--object', luks_default_secret_object] + qargs
 
-    args.insert(0, 'create')
+    qargs.insert(0, 'create')
 
-    return qemu_img(*args)
+    return qemu_img(*qargs)
 
 def qemu_img_verbose(*args):
     '''Run qemu-img without suppressing its output and return the exit code'''
-- 
2.21.1


