Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B188D206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMAPpvb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B188D206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRZV-0000xM-UJ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joRQN-0002tO-3E
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:56:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joRQL-0003Gx-5H
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593089772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYiMyhgGreSRjMIeal1RzwAhRK37sLt65WmuhTVhyNw=;
 b=XMAPpvb0HJEVAP+12DS2pUfS8yZWj2evaM1kvjBT5eUBVMwSfMLm0ApDqS2apEcvlhN2zD
 kqs6bTSU/c42t/TchaLDDPkEVOUx2/nwGEEVbnVWCzheWStcC5ka/7KJwAo3u0DM1AQTdy
 kZIDYg7bLgzhA0saK2PSN/X6y6i0U34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-1Ab0RKHkPL67Dsxe023IWg-1; Thu, 25 Jun 2020 08:56:10 -0400
X-MC-Unique: 1Ab0RKHkPL67Dsxe023IWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9FE1800C64;
 Thu, 25 Jun 2020 12:56:09 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 798757932E;
 Thu, 25 Jun 2020 12:56:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 06/19] iotests: Check whether luks works
Date: Thu, 25 Jun 2020 14:55:35 +0200
Message-Id: <20200625125548.870061-7-mreitz@redhat.com>
In-Reply-To: <20200625125548.870061-1-mreitz@redhat.com>
References: <20200625125548.870061-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Whenever running an iotest for the luks format, we should check whether
luks actually really works.

Tests that try to create luks-encrypted qcow2 images should do the same.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/087        | 1 +
 tests/qemu-iotests/178        | 1 +
 tests/qemu-iotests/188        | 1 +
 tests/qemu-iotests/189        | 1 +
 tests/qemu-iotests/198        | 1 +
 tests/qemu-iotests/206        | 1 +
 tests/qemu-iotests/263        | 1 +
 tests/qemu-iotests/284        | 1 +
 tests/qemu-iotests/common.rc  | 3 +++
 tests/qemu-iotests/iotests.py | 5 +++++
 10 files changed, 16 insertions(+)

diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index bdfdad3454..678e748c58 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+_require_working_luks
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 7cf0e27154..f09b27caac 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt raw qcow2
 _supported_proto file
 _supported_os Linux
+_require_working_luks
 
 echo "== Input validation =="
 echo
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index 09b9b6083a..13b225fded 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto generic
 _supported_os Linux
+_require_working_luks
 
 
 size=16M
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index c9ce9d3bed..e6a84b8a3b 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto generic
 _supported_os Linux
+_require_working_luks
 
 
 size=16M
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index fb0d5a29d3..aeb059d5ea 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto generic
 _supported_os Linux
+_require_working_luks
 
 
 size=16M
diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index f42432a838..11bc51f256 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -24,6 +24,7 @@ import iotests
 from iotests import imgfmt
 
 iotests.script_initialize(supported_fmts=['qcow2'])
+iotests.verify_working_luks()
 
 with iotests.FilePath('t.qcow2') as disk_path, \
      iotests.FilePath('t.qcow2.base') as backing_path, \
diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
index d2c030fae9..f598a12899 100755
--- a/tests/qemu-iotests/263
+++ b/tests/qemu-iotests/263
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto generic
 _supported_os Linux
+_require_working_luks
 
 
 size=1M
diff --git a/tests/qemu-iotests/284 b/tests/qemu-iotests/284
index 071e89b33e..9f6c29a79c 100755
--- a/tests/qemu-iotests/284
+++ b/tests/qemu-iotests/284
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto generic
 _supported_os Linux
+_require_working_luks
 
 
 size=1M
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index f3667f48ab..7ac46edc1f 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -605,6 +605,9 @@ _supported_fmt()
     # setting IMGFMT_GENERIC to false.
     for f; do
         if [ "$f" = "$IMGFMT" -o "$f" = "generic" -a "$IMGFMT_GENERIC" = "true" ]; then
+            if [ "$IMGFMT" = "luks" ]; then
+                _require_working_luks
+            fi
             return
         fi
     done
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 039170a8a3..e1ddfcb662 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1010,12 +1010,17 @@ def _verify_image_format(supported_fmts: Sequence[str] = (),
         # similar to
         #   _supported_fmt generic
         # for bash tests
+        if imgfmt == 'luks':
+            verify_working_luks()
         return
 
     not_sup = supported_fmts and (imgfmt not in supported_fmts)
     if not_sup or (imgfmt in unsupported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
 
+    if imgfmt == 'luks':
+        verify_working_luks()
+
 def _verify_protocol(supported: Sequence[str] = (),
                      unsupported: Sequence[str] = ()) -> None:
     assert not (supported and unsupported)
-- 
2.26.2


