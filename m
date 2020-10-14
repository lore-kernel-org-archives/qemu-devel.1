Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5624AC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67E222201
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OetJCyFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67E222201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSi11-00049H-ID
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kShnq-0005Af-88
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:30:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kShno-0005jx-8r
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602685851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovGJrs1jnd6nyptxdbTUMAcVSKBO6qknrsnMsijF2lQ=;
 b=OetJCyFrch6FuQjRReshP05ANISJhN97VymhXhEI6IqFYHXkzHs35YYm+vOcVHKX9hFvBH
 g8S7Ynqk2b3vSbkJ2kLL6OUEFmr1vC+XFcjBuBrSW8SC7+eVxyRZ3nZElmsnk6AmeGYNvL
 L3HC9amI6UyCjlhEDQDF+6GtMLjZY2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-JmUJwwGAMR21iAgY0ur6wQ-1; Wed, 14 Oct 2020 10:30:47 -0400
X-MC-Unique: JmUJwwGAMR21iAgY0ur6wQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4341D10866A8;
 Wed, 14 Oct 2020 14:30:46 +0000 (UTC)
Received: from scv.redhat.com (ovpn-117-231.rdu2.redhat.com [10.10.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABEC776649;
 Wed, 14 Oct 2020 14:30:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/15] python: add mypy to pipenv
Date: Wed, 14 Oct 2020 10:29:54 -0400
Message-Id: <20201014142957.763624-13-jsnow@redhat.com>
In-Reply-To: <20201014142957.763624-1-jsnow@redhat.com>
References: <20201014142957.763624-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

0.730 appears to be about the oldest version that works with the
features we want, including nice human readable output (to make sure
iotest 297 passes), and type-parameterized Popen generics.

0.770, however, supports adding 'strict' to the config file, so require
at least 0.770.

mypy can be run from the python root by typing 'mypy qemu'.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/Pipfile      |  1 +
 python/Pipfile.lock | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/python/Pipfile b/python/Pipfile
index d1f7045f68..51c537b0d1 100644
--- a/python/Pipfile
+++ b/python/Pipfile
@@ -5,6 +5,7 @@ verify_ssl = true
 
 [dev-packages]
 flake8 = ">=3.6.0"
+mypy = ">=0.770"
 pylint = ">=2.6.0"
 
 [packages]
diff --git a/python/Pipfile.lock b/python/Pipfile.lock
index eb5ae75a0c..376f95a6a8 100644
--- a/python/Pipfile.lock
+++ b/python/Pipfile.lock
@@ -1,7 +1,7 @@
 {
     "_meta": {
         "hash": {
-            "sha256": "9f6d4857a6c72ad40fc1ec1e58cdb76f187a2986ac4156f0027e5eb798ec69a9"
+            "sha256": "65f010a8f2e55e9870d2b7e0d8af129516097d23abf2504f396552748b067ade"
         },
         "pipfile-spec": 6,
         "requires": {
@@ -83,6 +83,33 @@
             ],
             "version": "==0.6.1"
         },
+        "mypy": {
+            "hashes": [
+                "sha256:0a0d102247c16ce93c97066443d11e2d36e6cc2a32d8ccc1f705268970479324",
+                "sha256:0d34d6b122597d48a36d6c59e35341f410d4abfa771d96d04ae2c468dd201abc",
+                "sha256:2170492030f6faa537647d29945786d297e4862765f0b4ac5930ff62e300d802",
+                "sha256:2842d4fbd1b12ab422346376aad03ff5d0805b706102e475e962370f874a5122",
+                "sha256:2b21ba45ad9ef2e2eb88ce4aeadd0112d0f5026418324176fd494a6824b74975",
+                "sha256:72060bf64f290fb629bd4a67c707a66fd88ca26e413a91384b18db3876e57ed7",
+                "sha256:af4e9ff1834e565f1baa74ccf7ae2564ae38c8df2a85b057af1dbbc958eb6666",
+                "sha256:bd03b3cf666bff8d710d633d1c56ab7facbdc204d567715cb3b9f85c6e94f669",
+                "sha256:c614194e01c85bb2e551c421397e49afb2872c88b5830e3554f0519f9fb1c178",
+                "sha256:cf4e7bf7f1214826cf7333627cb2547c0db7e3078723227820d0a2490f117a01",
+                "sha256:da56dedcd7cd502ccd3c5dddc656cb36113dd793ad466e894574125945653cea",
+                "sha256:e86bdace26c5fe9cf8cb735e7cedfe7850ad92b327ac5d797c656717d2ca66de",
+                "sha256:e97e9c13d67fbe524be17e4d8025d51a7dca38f90de2e462243ab8ed8a9178d1",
+                "sha256:eea260feb1830a627fb526d22fbb426b750d9f5a47b624e8d5e7e004359b219c"
+            ],
+            "index": "pypi",
+            "version": "==0.790"
+        },
+        "mypy-extensions": {
+            "hashes": [
+                "sha256:090fedd75945a69ae91ce1303b5824f428daf5a028d2f6ab8a299250a846f15d",
+                "sha256:2d82818f5bb3e369420cb3c4060a7970edba416647068eb4c5343488a6c604a8"
+            ],
+            "version": "==0.4.3"
+        },
         "pycodestyle": {
             "hashes": [
                 "sha256:2295e7b2f6b5bd100585ebcb1f616591b652db8a741695b3d8f5d28bdc934367",
@@ -149,6 +176,14 @@
             "markers": "implementation_name == 'cpython' and python_version < '3.8'",
             "version": "==1.4.1"
         },
+        "typing-extensions": {
+            "hashes": [
+                "sha256:7cb407020f00f7bfc3cb3e7881628838e69d8f3fcab2f64742a5e76b2f841918",
+                "sha256:99d4073b617d30288f569d3f13d2bd7548c3a7e4c8de87db09a9d29bb3a4a60c",
+                "sha256:dafc7639cde7f1b6e1acc0f457842a83e722ccca8eef5270af2d74792619a89f"
+            ],
+            "version": "==3.7.4.3"
+        },
         "wrapt": {
             "hashes": [
                 "sha256:b62ffa81fb85f4332a4f609cab4ac40709470da05643a082ec1eb88e6d9b97d7"
-- 
2.26.2


