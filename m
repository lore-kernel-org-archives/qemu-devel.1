Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B09C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAAC2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cc902VaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAAC2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgH7w-0004Gx-OC
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 20:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH4K-0007Ig-0U
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH4I-0005lh-FZ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591143341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=583S2j3YMQKGNt/T0XBCDg5chZgehw0hbfqAp8GKu0s=;
 b=cc902VaI6tGzZtTlN5qV5SAANLDxmLMa/DC8/k5JNcL2RqphOnQl69IUReiLVuBdl+orZQ
 krMsH9FYRgF6oXbSkqrd2BQmFyn+UexfSGI9owHf9SHdWLIdvBxoe7q0OIGqs6KbN43Nky
 n+OvAE2ifobpV7d33AMinDQKaZTzces=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-NZDuckv0NhibQTYf1RFjbg-1; Tue, 02 Jun 2020 20:15:40 -0400
X-MC-Unique: NZDuckv0NhibQTYf1RFjbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF325107ACF2;
 Wed,  3 Jun 2020 00:15:38 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59DCC78B56;
 Wed,  3 Jun 2020 00:15:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] python/qemu: Add flake8 to pipenv
Date: Tue,  2 Jun 2020 20:15:22 -0400
Message-Id: <20200603001523.18085-7-jsnow@redhat.com>
In-Reply-To: <20200603001523.18085-1-jsnow@redhat.com>
References: <20200603001523.18085-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 20:15:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Versions older than 3.6.0 do not appear to work with either pylint 2.5.0
or the type hint syntax in general.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/Pipfile      |  1 +
 python/Pipfile.lock | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/python/Pipfile b/python/Pipfile
index ddb2b5a5182..fc92038ff7a 100644
--- a/python/Pipfile
+++ b/python/Pipfile
@@ -5,6 +5,7 @@ verify_ssl = true
 
 [dev-packages]
 pylint = "==2.5.0"
+flake8 = ">=3.6.0"
 
 [packages]
 
diff --git a/python/Pipfile.lock b/python/Pipfile.lock
index 250f4ebcad7..95b942bd383 100644
--- a/python/Pipfile.lock
+++ b/python/Pipfile.lock
@@ -1,7 +1,7 @@
 {
     "_meta": {
         "hash": {
-            "sha256": "7815dedfd7481b645389153dd45e9adb82c72956d0efc74d8f087497624b75e4"
+            "sha256": "30d00455625882e5e23868450487697f75d54474f6912091684d570c5c518c11"
         },
         "pipfile-spec": 6,
         "requires": {
@@ -24,6 +24,22 @@
             ],
             "version": "==2.4.1"
         },
+        "flake8": {
+            "hashes": [
+                "sha256:c69ac1668e434d37a2d2880b3ca9aafd54b3a10a3ac1ab101d22f29e29cf8634",
+                "sha256:ccaa799ef9893cebe69fdfefed76865aeaefbb94cb8545617b2298786a4de9a5"
+            ],
+            "index": "pypi",
+            "version": "==3.8.2"
+        },
+        "importlib-metadata": {
+            "hashes": [
+                "sha256:2a688cbaa90e0cc587f1df48bdc97a6eadccdcd9c35fb3f976a09e3b5016d90f",
+                "sha256:34513a8a0c4962bc66d35b359558fd8a5e10cd472d37aec5f66858addef32c1e"
+            ],
+            "markers": "python_version < '3.8'",
+            "version": "==1.6.0"
+        },
         "isort": {
             "hashes": [
                 "sha256:54da7e92468955c4fceacd0c86bd0ec997b0e1ee80d97f67c35a78b719dccab1",
@@ -64,6 +80,20 @@
             ],
             "version": "==0.6.1"
         },
+        "pycodestyle": {
+            "hashes": [
+                "sha256:2295e7b2f6b5bd100585ebcb1f616591b652db8a741695b3d8f5d28bdc934367",
+                "sha256:c58a7d2815e0e8d7972bf1803331fb0152f867bd89adf8a01dfd55085434192e"
+            ],
+            "version": "==2.6.0"
+        },
+        "pyflakes": {
+            "hashes": [
+                "sha256:0d94e0e05a19e57a99444b6ddcf9a6eb2e5c68d3ca1e98e90707af8152c90a92",
+                "sha256:35b2d75ee967ea93b55750aa9edbbf72813e06a66ba54438df2cfac9e3c27fc8"
+            ],
+            "version": "==2.2.0"
+        },
         "pylint": {
             "hashes": [
                 "sha256:588e114e3f9a1630428c35b7dd1c82c1c93e1b0e78ee312ae4724c5e1a1e0245",
@@ -118,6 +148,13 @@
                 "sha256:b62ffa81fb85f4332a4f609cab4ac40709470da05643a082ec1eb88e6d9b97d7"
             ],
             "version": "==1.12.1"
+        },
+        "zipp": {
+            "hashes": [
+                "sha256:aa36550ff0c0b7ef7fa639055d797116ee891440eac1a56f378e2d3179e0320b",
+                "sha256:c599e4d75c98f6798c509911d08a22e6c021d074469042177c8c86fb92eefd96"
+            ],
+            "version": "==3.1.0"
         }
     }
 }
-- 
2.21.3


