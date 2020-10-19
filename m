Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD4BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23943222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGHj1zdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23943222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWEJ-0002Yl-TB
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 10:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kUWCM-0001Xt-PG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kUWCI-0005Xv-Uh
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603117896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G0gcSsiIncszvnbrbMZTJ9bicNWESHvo60K3Msk/IQc=;
 b=LGHj1zdO3u/QMhavb5lpze4OVKR/GifSbrAEg+/JGwUn/YjvKquOMOciEiSHbydmaThrgU
 thBkmcUu64Va0SEUaDSQ3u5j+aHN5Njogj+trTNleANwTX2Dsc4hDNLBHf1w2Gxe4O62KS
 tZIyPRBqHTOzkU3b7Az2oZE9K77fG8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-jgM2dgOgM5q_fJ8y-E9eTQ-1; Mon, 19 Oct 2020 10:31:34 -0400
X-MC-Unique: jgM2dgOgM5q_fJ8y-E9eTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C528210A1134;
 Mon, 19 Oct 2020 14:31:10 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 674B81002C38;
 Mon, 19 Oct 2020 14:31:10 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] travis: Check if docs can be built with multiple Sphinx
 versions
Date: Mon, 19 Oct 2020 10:31:08 -0400
Message-Id: <20201019143109.1034864-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new jobs to .travis.yml to test if docs can be built with
multiple Sphinx versions: 1.6.1, latest 1.x, 2.0.0, and latest
2.x.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 .travis.yml | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 1054ec5d29..f5208301d6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -181,6 +181,43 @@ jobs:
             - perl
 
 
+    # Check we can build docs with multiple Sphinx versions.
+    # We need --sphinx-build=sphinx-build to ensure we use the
+    # sphinx-build binary installed by pip.
+
+    # 1.6.1 is the oldest Sphinx version we support
+    - name: "docs (Sphinx 1.6.1)"
+      env:
+        - CONFIG="--enable-docs --sphinx-build=sphinx-build"
+      install:
+        - pip install -q sphinx==1.6.1
+      script:
+        - make -j${JOBS} sphinxdocs
+    - name: "docs (Sphinx 1.x)"
+      env:
+        - CONFIG="--enable-docs --sphinx-build=sphinx-build"
+      install:
+        # install latest 1.x version
+        - pip install -q 'sphinx>=1.0,<2.0'
+      script:
+        - make -j${JOBS} sphinxdocs
+    - name: "docs (Sphinx 2.0.0)"
+      env:
+        - CONFIG="--enable-docs --sphinx-build=sphinx-build"
+      install:
+        - pip install -q sphinx==2.0.0
+      script:
+        - make -j${JOBS} sphinxdocs
+    - name: "docs (Sphinx 2.x)"
+      env:
+        - CONFIG="--enable-docs --sphinx-build=sphinx-build"
+      install:
+        # install latest 2.x version
+        - pip install -q 'sphinx>=2.0,<3.0'
+      script:
+        - make -j${JOBS} sphinxdocs
+
+
     # Test with Clang for compile portability (Travis uses clang-5.0)
     - name: "Clang (user)"
       env:
-- 
2.28.0


