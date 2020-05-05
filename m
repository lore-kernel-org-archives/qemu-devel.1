Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50568C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0946E2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MchuhFk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0946E2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW3xr-000718-7T
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 16:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jW3s7-00046c-59
 for qemu-devel@nongnu.org; Tue, 05 May 2020 16:08:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38569
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jW3s5-0000qM-P3
 for qemu-devel@nongnu.org; Tue, 05 May 2020 16:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588709333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wl53Ohgpnc6YVJxhVrZR8d3WIyUnPbwngJQ6DuOWX+w=;
 b=MchuhFk01oMWjTtNk6ul6QzLpaJ2tShhKlicu12b8xcLLYLrQMG7X3YYytAq19CLQP0lMS
 XO4YhgnpyKsv1d0ef+DYWBHbifWw2tK+RaAkb5qYSQ+VuimWFp0/+WP6UJ9P+Iih6/3Bc8
 zOoeKpPTHfAEtq+AjgYpGTQL3Fi8gpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-Z_VSEm_OPuyLytwXNd4Urg-1; Tue, 05 May 2020 16:08:49 -0400
X-MC-Unique: Z_VSEm_OPuyLytwXNd4Urg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D41A100D11E;
 Tue,  5 May 2020 20:08:48 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A6E763F95;
 Tue,  5 May 2020 20:08:45 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/14] iotests: filter few more luks specific create options
Date: Tue,  5 May 2020 23:08:14 +0300
Message-Id: <20200505200819.5662-10-mlevitsk@redhat.com>
In-Reply-To: <20200505200819.5662-1-mlevitsk@redhat.com>
References: <20200505200819.5662-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 15:23:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows more tests to be able to have same output on both qcow2 luks en=
crypted images
and raw luks images

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/qemu-iotests/087.out       |  6 ++---
 tests/qemu-iotests/134.out       |  2 +-
 tests/qemu-iotests/158.out       |  4 +--
 tests/qemu-iotests/188.out       |  2 +-
 tests/qemu-iotests/189.out       |  4 +--
 tests/qemu-iotests/198.out       |  4 +--
 tests/qemu-iotests/263.out       |  4 +--
 tests/qemu-iotests/274.out       | 46 ++++++++++++++++----------------
 tests/qemu-iotests/284.out       |  6 ++---
 tests/qemu-iotests/common.filter |  6 +++--
 10 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index f23bffbbf1..d5ff53302e 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -34,7 +34,7 @@ QMP_VERSION
=20
 =3D=3D=3D Encrypted image QCow =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don size=3D134217=
728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -46,7 +46,7 @@ QMP_VERSION
=20
 =3D=3D=3D Encrypted image LUKS =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec0 size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -58,7 +58,7 @@ QMP_VERSION
=20
 =3D=3D=3D Missing driver =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don size=3D134217=
728
 Testing: -S
 QMP_VERSION
 {"return": {}}
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index f2878f5f3a..e4733c0b81 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -1,5 +1,5 @@
 QA output created by 134
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don size=3D134217=
728
=20
 =3D=3D reading whole image =3D=3D
 read 134217728/134217728 bytes at offset 0
diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
index fa2294bb85..52ea9a488f 100644
--- a/tests/qemu-iotests/158.out
+++ b/tests/qemu-iotests/158.out
@@ -1,6 +1,6 @@
 QA output created by 158
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT encryption=3Don encrypt.=
key-secret=3Dsec0 size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT encryption=3Don size=3D1=
34217728
=20
 =3D=3D writing whole image =3D=3D
 wrote 134217728/134217728 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 134217728/134217728 bytes at offset 0
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728 backing_file=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don size=3D134217=
728 backing_file=3DTEST_DIR/t.IMGFMT.base
=20
 =3D=3D writing part of a cluster =3D=3D
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
index 4b9aadd51c..5426861b18 100644
--- a/tests/qemu-iotests/188.out
+++ b/tests/qemu-iotests/188.out
@@ -1,5 +1,5 @@
 QA output created by 188
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D16777216
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216
=20
 =3D=3D reading whole image =3D=3D
 read 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/189.out b/tests/qemu-iotests/189.out
index e536d95d53..bc213cbe14 100644
--- a/tests/qemu-iotests/189.out
+++ b/tests/qemu-iotests/189.out
@@ -1,6 +1,6 @@
 QA output created by 189
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT encrypt.format=3Dluks en=
crypt.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D16777216
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D16777216
=20
 =3D=3D writing whole image =3D=3D
 wrote 16777216/16777216 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 16777216/16777216 bytes at offset 0
 read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec1 encrypt.iter-time=3D10 size=3D16777216 backing_file=3DTE=
ST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base
=20
 =3D=3D writing part of a cluster =3D=3D
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index b0f2d417af..acfdf96b0c 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -1,12 +1,12 @@
 QA output created by 198
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT encrypt.format=3Dluks en=
crypt.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D16777216
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D16777216
=20
 =3D=3D writing whole image base =3D=3D
 wrote 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec1 encrypt.iter-time=3D10 size=3D16777216 backing_file=3DTE=
ST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base
=20
 =3D=3D writing whole image layer =3D=3D
 wrote 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/263.out b/tests/qemu-iotests/263.out
index 4cf5c79ed8..54bfbeeff8 100644
--- a/tests/qemu-iotests/263.out
+++ b/tests/qemu-iotests/263.out
@@ -2,7 +2,7 @@ QA output created by 263
=20
 testing LUKS qcow2 encryption
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
 =3D=3D reading the whole image =3D=3D
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -21,7 +21,7 @@ read 982528/982528 bytes at offset 66048
=20
 testing legacy AES qcow2 encryption
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Daes encrypt.=
key-secret=3Dsec0 size=3D1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
 =3D=3D reading the whole image =3D=3D
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
index 9d6fdeb1f7..59de176b99 100644
--- a/tests/qemu-iotests/274.out
+++ b/tests/qemu-iotests/274.out
@@ -1,9 +1,9 @@
 =3D=3D Commit tests =3D=3D
-Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_size=3D=
65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D20=
97152 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=3DT=
EST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D=
16
+Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 cluster_size=3D65536 size=3D104=
8576 backing_file=3DTEST_DIR/PID-base lazy_refcounts=3Doff refcount_bits=3D=
16
=20
-Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=3DT=
EST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 cluster_size=3D65536 size=3D209=
7152 backing_file=3DTEST_DIR/PID-mid lazy_refcounts=3Doff refcount_bits=3D1=
6
=20
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -63,11 +63,11 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D=3D Testing HMP commit (top -> mid) =3D=3D=3D
-Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_size=3D=
65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D20=
97152 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=3DT=
EST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D=
16
+Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 cluster_size=3D65536 size=3D104=
8576 backing_file=3DTEST_DIR/PID-base lazy_refcounts=3Doff refcount_bits=3D=
16
=20
-Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=3DT=
EST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 cluster_size=3D65536 size=3D209=
7152 backing_file=3DTEST_DIR/PID-mid lazy_refcounts=3Doff refcount_bits=3D1=
6
=20
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -92,11 +92,11 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D=3D Testing QMP active commit (top -> mid) =3D=3D=3D
-Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_size=3D=
65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D20=
97152 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=3DT=
EST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D=
16
+Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 cluster_size=3D65536 size=3D104=
8576 backing_file=3DTEST_DIR/PID-base lazy_refcounts=3Doff refcount_bits=3D=
16
=20
-Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=3DT=
EST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 cluster_size=3D65536 size=3D209=
7152 backing_file=3DTEST_DIR/PID-mid lazy_refcounts=3Doff refcount_bits=3D1=
6
=20
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -128,9 +128,9 @@ read 1048576/1048576 bytes at offset 1048576
=20
 =3D=3D Resize tests =3D=3D
 =3D=3D=3D preallocation=3Doff =3D=3D=3D
-Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D6442450944 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D64=
42450944 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D1073741824 backing_file=
=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 cluster_size=3D65536 size=3D107=
3741824 backing_file=3DTEST_DIR/PID-base lazy_refcounts=3Doff refcount_bits=
=3D16
=20
 wrote 65536/65536 bytes at offset 5368709120
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -147,9 +147,9 @@ read 65536/65536 bytes at offset 5368709120
 { "start": 1073741824, "length": 7516192768, "depth": 0, "zero": true, "da=
ta": false}]
=20
 =3D=3D=3D preallocation=3Dmetadata =3D=3D=3D
-Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D34359738368 cluster_siz=
e=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D34=
359738368 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D32212254720 backing_file=
=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 cluster_size=3D65536 size=3D322=
12254720 backing_file=3DTEST_DIR/PID-base lazy_refcounts=3Doff refcount_bit=
s=3D16
=20
 wrote 65536/65536 bytes at offset 33285996544
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -171,9 +171,9 @@ read 65536/65536 bytes at offset 33285996544
 { "start": 34896609280, "length": 536870912, "depth": 0, "zero": true, "da=
ta": false, "offset": 2685075456}]
=20
 =3D=3D=3D preallocation=3Dfalloc =3D=3D=3D
-Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D10485760 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D10=
485760 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D5242880 backing_file=3DT=
EST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D=
16
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 cluster_size=3D65536 size=3D524=
2880 backing_file=3DTEST_DIR/PID-base lazy_refcounts=3Doff refcount_bits=3D=
16
=20
 wrote 65536/65536 bytes at offset 9437184
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -190,9 +190,9 @@ read 65536/65536 bytes at offset 9437184
 { "start": 5242880, "length": 10485760, "depth": 0, "zero": false, "data":=
 true, "offset": 327680}]
=20
 =3D=3D=3D preallocation=3Dfull =3D=3D=3D
-Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D16777216 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D16=
777216 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D8388608 backing_file=3DT=
EST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D=
16
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 cluster_size=3D65536 size=3D838=
8608 backing_file=3DTEST_DIR/PID-base lazy_refcounts=3Doff refcount_bits=3D=
16
=20
 wrote 65536/65536 bytes at offset 11534336
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -209,9 +209,9 @@ read 65536/65536 bytes at offset 11534336
 { "start": 8388608, "length": 4194304, "depth": 0, "zero": false, "data": =
true, "offset": 327680}]
=20
 =3D=3D=3D preallocation=3Doff =3D=3D=3D
-Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D393216 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D39=
3216 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D259072 backing_file=3DTE=
ST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 cluster_size=3D65536 size=3D259=
072 backing_file=3DTEST_DIR/PID-base lazy_refcounts=3Doff refcount_bits=3D1=
6
=20
 wrote 65536/65536 bytes at offset 259072
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -229,9 +229,9 @@ read 65536/65536 bytes at offset 259072
 { "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": fal=
se}]
=20
 =3D=3D=3D preallocation=3Doff =3D=3D=3D
-Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D409600 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D40=
9600 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D262144 backing_file=3DTE=
ST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 cluster_size=3D65536 size=3D262=
144 backing_file=3DTEST_DIR/PID-base lazy_refcounts=3Doff refcount_bits=3D1=
6
=20
 wrote 65536/65536 bytes at offset 344064
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -248,9 +248,9 @@ read 65536/65536 bytes at offset 344064
 { "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": fal=
se}]
=20
 =3D=3D=3D preallocation=3Doff =3D=3D=3D
-Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D524288 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D52=
4288 lazy_refcounts=3Doff refcount_bits=3D16
=20
-Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D262144 backing_file=3DTE=
ST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 cluster_size=3D65536 size=3D262=
144 backing_file=3DTEST_DIR/PID-base lazy_refcounts=3Doff refcount_bits=3D1=
6
=20
 wrote 65536/65536 bytes at offset 446464
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/284.out b/tests/qemu-iotests/284.out
index 48216f5742..a929239302 100644
--- a/tests/qemu-iotests/284.out
+++ b/tests/qemu-iotests/284.out
@@ -2,7 +2,7 @@ QA output created by 284
=20
 testing LUKS qcow2 encryption
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.format=
=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
=20
 =3D=3D cluster size 512
 =3D=3D checking image refcounts =3D=3D
@@ -21,7 +21,7 @@ wrote 1/1 bytes at offset 512
=20
 =3D=3D rechecking image refcounts =3D=3D
 No errors were found on the image.
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.format=
=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
=20
 =3D=3D cluster size 2048
 =3D=3D checking image refcounts =3D=3D
@@ -40,7 +40,7 @@ wrote 1/1 bytes at offset 2048
=20
 =3D=3D rechecking image refcounts =3D=3D
 No errors were found on the image.
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.format=
=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
=20
 =3D=3D cluster size 32768
 =3D=3D checking image refcounts =3D=3D
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.f=
ilter
index 3f8ee3e5f7..bcc4495d52 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -150,8 +150,10 @@ _filter_img_create()
         -e "s# block_state_zero=3D\\(on\\|off\\)##g" \
         -e "s# log_size=3D[0-9]\\+##g" \
         -e "s# refcount_bits=3D[0-9]\\+##g" \
-        -e "s# key-secret=3D[a-zA-Z0-9]\\+##g" \
-        -e "s# iter-time=3D[0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?key-secret=3D[a-zA-Z0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?slot=3D[0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?iter-time=3D[0-9]\\+##g" \
+        -e "s# encrypt\\.format=3D[a-zA-Z0-9]\\+##g" \
         -e "s# force_size=3D\\(on\\|off\\)##g"
 }
=20
--=20
2.17.2


