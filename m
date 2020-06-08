Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F98DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6CE206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzpW6kLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6CE206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEMU-0006f2-3w
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jiEHN-0006lB-HV
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:41:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26443
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jiEHM-0002GB-Fm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591609275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhQtkXhlC8dUwGXVWm5YbWUi1cc6/Q2m6ZCQZhaM8Og=;
 b=HzpW6kLpbiNQbP//1AEBWH+J2yblBHaQIRoKl8W2ASjJ0CEWkS5JxwV4HbFIQzg53gDgVu
 AmbXf5LMyqHAsEzy/nOG42cnzaaGgGK9OmSElYB5Hwl26rtYd1t/8MumKGXPZs5asMYs7Q
 aCzPC14TBwGXPWw1sdzrcYnDD08pDH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-nXe5NNnZOj2FL4J2vdRDcA-1; Mon, 08 Jun 2020 05:41:12 -0400
X-MC-Unique: nXe5NNnZOj2FL4J2vdRDcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3221CBFC4;
 Mon,  8 Jun 2020 09:41:11 +0000 (UTC)
Received: from starship.redhat.com (unknown [10.35.206.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D2391CA;
 Mon,  8 Jun 2020 09:41:05 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 09/14] iotests: filter few more luks specific create options
Date: Mon,  8 Jun 2020 12:40:25 +0300
Message-Id: <20200608094030.670121-10-mlevitsk@redhat.com>
In-Reply-To: <20200608094030.670121-1-mlevitsk@redhat.com>
References: <20200608094030.670121-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows more tests to be able to have same output on both qcow2 luks encrypted images
and raw luks images

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/087.out       | 6 +++---
 tests/qemu-iotests/134.out       | 2 +-
 tests/qemu-iotests/158.out       | 4 ++--
 tests/qemu-iotests/188.out       | 2 +-
 tests/qemu-iotests/189.out       | 4 ++--
 tests/qemu-iotests/198.out       | 4 ++--
 tests/qemu-iotests/263.out       | 4 ++--
 tests/qemu-iotests/284.out       | 6 +++---
 tests/qemu-iotests/common.filter | 6 ++++--
 9 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index f23bffbbf1..d5ff53302e 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -34,7 +34,7 @@ QMP_VERSION
 
 === Encrypted image QCow ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on encrypt.key-secret=sec0 size=134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on size=134217728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -46,7 +46,7 @@ QMP_VERSION
 
 === Encrypted image LUKS ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 size=134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -58,7 +58,7 @@ QMP_VERSION
 
 === Missing driver ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on encrypt.key-secret=sec0 size=134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on size=134217728
 Testing: -S
 QMP_VERSION
 {"return": {}}
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index f2878f5f3a..e4733c0b81 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -1,5 +1,5 @@
 QA output created by 134
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on encrypt.key-secret=sec0 size=134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on size=134217728
 
 == reading whole image ==
 read 134217728/134217728 bytes at offset 0
diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
index fa2294bb85..52ea9a488f 100644
--- a/tests/qemu-iotests/158.out
+++ b/tests/qemu-iotests/158.out
@@ -1,6 +1,6 @@
 QA output created by 158
 == create base ==
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT encryption=on encrypt.key-secret=sec0 size=134217728
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT encryption=on size=134217728
 
 == writing whole image ==
 wrote 134217728/134217728 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 134217728/134217728 bytes at offset 0
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on encrypt.key-secret=sec0 size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encryption=on size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
 
 == writing part of a cluster ==
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
index 4b9aadd51c..5426861b18 100644
--- a/tests/qemu-iotests/188.out
+++ b/tests/qemu-iotests/188.out
@@ -1,5 +1,5 @@
 QA output created by 188
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=16777216
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216
 
 == reading whole image ==
 read 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/189.out b/tests/qemu-iotests/189.out
index e536d95d53..bc213cbe14 100644
--- a/tests/qemu-iotests/189.out
+++ b/tests/qemu-iotests/189.out
@@ -1,6 +1,6 @@
 QA output created by 189
 == create base ==
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=16777216
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216
 
 == writing whole image ==
 wrote 16777216/16777216 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 16777216/16777216 bytes at offset 0
 read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10 size=16777216 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base
 
 == writing part of a cluster ==
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index 7714995c02..4b800e70db 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -1,12 +1,12 @@
 QA output created by 198
 == create base ==
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=16777216
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216
 
 == writing whole image base ==
 wrote 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10 size=16777216 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base
 
 == writing whole image layer ==
 wrote 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/263.out b/tests/qemu-iotests/263.out
index 4cf5c79ed8..54bfbeeff8 100644
--- a/tests/qemu-iotests/263.out
+++ b/tests/qemu-iotests/263.out
@@ -2,7 +2,7 @@ QA output created by 263
 
 testing LUKS qcow2 encryption
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 == reading the whole image ==
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -21,7 +21,7 @@ read 982528/982528 bytes at offset 66048
 
 testing legacy AES qcow2 encryption
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=aes encrypt.key-secret=sec0 size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 == reading the whole image ==
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/284.out b/tests/qemu-iotests/284.out
index 1855369c56..a929239302 100644
--- a/tests/qemu-iotests/284.out
+++ b/tests/qemu-iotests/284.out
@@ -2,7 +2,7 @@ QA output created by 284
 
 testing LUKS qcow2 encryption
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 
 == cluster size 512
 == checking image refcounts ==
@@ -21,7 +21,7 @@ wrote 1/1 bytes at offset 512
 
 == rechecking image refcounts ==
 No errors were found on the image.
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 
 == cluster size 2048
 == checking image refcounts ==
@@ -40,7 +40,7 @@ wrote 1/1 bytes at offset 2048
 
 == rechecking image refcounts ==
 No errors were found on the image.
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 
 == cluster size 32768
 == checking image refcounts ==
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 03e4f71808..99472f3acf 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -150,8 +150,10 @@ _filter_img_create()
         -e "s# block_state_zero=\\(on\\|off\\)##g" \
         -e "s# log_size=[0-9]\\+##g" \
         -e "s# refcount_bits=[0-9]\\+##g" \
-        -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
-        -e "s# iter-time=[0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?key-secret=[a-zA-Z0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?iter-time=[0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?slot=[0-9]\\+##g" \
+        -e "s# encrypt\\.format=[a-zA-Z0-9]\\+##g" \
         -e "s# force_size=\\(on\\|off\\)##g" \
         -e "s# compression_type=[a-zA-Z0-9]\\+##g"
 }
-- 
2.25.4


