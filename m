Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A0BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA08F2070E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgOdGKzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA08F2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXXg0-0007z7-VH
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 18:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXXbx-0004FC-B4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 18:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXXbo-0006Mn-1C
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 18:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603838306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUjL2Gu1+ZkJAvO18SrcBjPI/d2YCaNB9oHXYUG9keo=;
 b=CgOdGKzCtqGTQya7NJdH237kUh0sFZ3DsyB8OM6xFzHBoSQl30kflHweTVnDUopExWEQpA
 r2YCGXYVmtR7JsfbVZ4y0qkHFHz32oCOLH0T1MUpVIuhhVZMpir2aszs33oh67GQSSTT3x
 Zb7N/QSzA8P+Eu5HvKKm+Whe18wjsLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-2q4UceLAPICtS2BvMgZncg-1; Tue, 27 Oct 2020 18:38:23 -0400
X-MC-Unique: 2q4UceLAPICtS2BvMgZncg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CD1B803F69;
 Tue, 27 Oct 2020 22:38:22 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A6C55B4AC;
 Tue, 27 Oct 2020 22:38:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] python: add pytest and tests
Date: Tue, 27 Oct 2020 18:38:11 -0400
Message-Id: <20201027223815.159802-2-jsnow@redhat.com>
In-Reply-To: <20201027223815.159802-1-jsnow@redhat.com>
References: <20201027223815.159802-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 17:59:21
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Try using pytest to manage our various tests; even though right now
they're only invoking binaries and not really running any python-native
code.

Create tests/, and add test_lint.py which calls out to mypy, flake8,
pylint and isort to enforce the standards in this directory.

Add pytest to the setup.cfg development dependencies; add a pytest
configuration section as well; run it in verbose mode.

Finally, add pytest to the Pipfile environment and lock the new
dependencies. (Note, this also updates an unrelated dependency; but the
only way to avoid this is to pin that dependency at a lower version --
which there is no reason to do at present.)

Provided you have the right development dependencies (mypy, flake8,
isort, pylint, and now pytest) You should be able to run "pytest" from
the python folder to run all of these linters with the correct
arguments.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/Pipfile.lock       | 71 ++++++++++++++++++++++++++++++++++++---
 python/setup.cfg          |  5 +++
 python/tests/test_lint.py | 28 +++++++++++++++
 3 files changed, 99 insertions(+), 5 deletions(-)
 create mode 100644 python/tests/test_lint.py

diff --git a/python/Pipfile.lock b/python/Pipfile.lock
index 05077475d750..105ffbc09a8e 100644
--- a/python/Pipfile.lock
+++ b/python/Pipfile.lock
@@ -30,6 +30,14 @@
             "markers": "python_version >= '3.5'",
             "version": "==2.4.2"
         },
+        "attrs": {
+            "hashes": [
+                "sha256:26b54ddbbb9ee1d34d5d3668dd37d6cf74990ab23c828c2888dccdceee395594",
+                "sha256:fce7fc47dfc976152e82d53ff92fa0407700c21acd20886a13777a0d20e655dc"
+            ],
+            "markers": "python_version >= '2.7' and python_version not in '3.0, 3.1, 3.2, 3.3'",
+            "version": "==20.2.0"
+        },
         "flake8": {
             "hashes": [
                 "sha256:749dbbd6bfd0cf1318af27bf97a14e28e5ff548ef8e5b1566ccfb25a11e7c839",
@@ -46,6 +54,13 @@
             "markers": "python_version < '3.8'",
             "version": "==2.0.0"
         },
+        "iniconfig": {
+            "hashes": [
+                "sha256:011e24c64b7f47f6ebd835bb12a743f2fbe9a26d4cecaa7f53bc4f35ee9da8b3",
+                "sha256:bc3af051d7d14b2ee5ef9969666def0cd1a000e121eaea580d4a313df4b37f32"
+            ],
+            "version": "==1.1.1"
+        },
         "isort": {
             "hashes": [
                 "sha256:dcab1d98b469a12a1a624ead220584391648790275560e1a43e54c5dceae65e7",
@@ -115,6 +130,30 @@
             ],
             "version": "==0.4.3"
         },
+        "packaging": {
+            "hashes": [
+                "sha256:4357f74f47b9c12db93624a82154e9b120fa8293699949152b22065d556079f8",
+                "sha256:998416ba6962ae7fbd6596850b80e17859a5753ba17c32284f67bfff33784181"
+            ],
+            "markers": "python_version >= '2.7' and python_version not in '3.0, 3.1, 3.2, 3.3'",
+            "version": "==20.4"
+        },
+        "pluggy": {
+            "hashes": [
+                "sha256:15b2acde666561e1298d71b523007ed7364de07029219b604cf808bfa1c765b0",
+                "sha256:966c145cd83c96502c3c3868f50408687b38434af77734af1e9ca461a4081d2d"
+            ],
+            "markers": "python_version >= '2.7' and python_version not in '3.0, 3.1, 3.2, 3.3'",
+            "version": "==0.13.1"
+        },
+        "py": {
+            "hashes": [
+                "sha256:366389d1db726cd2fcfc79732e75410e5fe4d31db13692115529d34069a043c2",
+                "sha256:9ca6883ce56b4e8da7e79ac18787889fa5206c79dcc67fb065376cd2fe03f342"
+            ],
+            "markers": "python_version >= '2.7' and python_version not in '3.0, 3.1, 3.2, 3.3'",
+            "version": "==1.9.0"
+        },
         "pycodestyle": {
             "hashes": [
                 "sha256:2295e7b2f6b5bd100585ebcb1f616591b652db8a741695b3d8f5d28bdc934367",
@@ -139,6 +178,22 @@
             "markers": "python_version >= '3.5'",
             "version": "==2.6.0"
         },
+        "pyparsing": {
+            "hashes": [
+                "sha256:c203ec8783bf771a155b207279b9bccb8dea02d8f0c9e5f8ead507bc3246ecc1",
+                "sha256:ef9d7589ef3c200abe66653d3f1ab1033c3c419ae9b9bdb1240a85b024efc88b"
+            ],
+            "markers": "python_version >= '2.6' and python_version not in '3.0, 3.1, 3.2, 3.3'",
+            "version": "==2.4.7"
+        },
+        "pytest": {
+            "hashes": [
+                "sha256:7a8190790c17d79a11f847fba0b004ee9a8122582ebff4729a082c109e81a4c9",
+                "sha256:8f593023c1a0f916110285b6efd7f99db07d59546e3d8c36fc60e2ab05d3be92"
+            ],
+            "markers": "python_version >= '3.5'",
+            "version": "==6.1.1"
+        },
         "qemu": {
             "editable": true,
             "path": "."
@@ -148,7 +203,7 @@
                 "sha256:30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259",
                 "sha256:8b74bedcbbbaca38ff6d7491d76f2b06b3592611af620f8426e82dddb04a5ced"
             ],
-            "markers": "python_version >= '2.7' and python_version not in '3.0, 3.1, 3.2'",
+            "markers": "python_version >= '2.7' and python_version not in '3.0, 3.1, 3.2, 3.3'",
             "version": "==1.15.0"
         },
         "toml": {
@@ -162,9 +217,11 @@
             "hashes": [
                 "sha256:0666aa36131496aed8f7be0410ff974562ab7eeac11ef351def9ea6fa28f6355",
                 "sha256:0c2c07682d61a629b68433afb159376e24e5b2fd4641d35424e462169c0a7919",
+                "sha256:0d8110d78a5736e16e26213114a38ca35cb15b6515d535413b090bd50951556d",
                 "sha256:249862707802d40f7f29f6e1aad8d84b5aa9e44552d2cc17384b209f091276aa",
                 "sha256:24995c843eb0ad11a4527b026b4dde3da70e1f2d8806c99b7b4a7cf491612652",
                 "sha256:269151951236b0f9a6f04015a9004084a5ab0d5f19b57de779f908621e7d8b75",
+                "sha256:3742b32cf1c6ef124d57f95be609c473d7ec4c14d0090e5a5e05a15269fb4d0c",
                 "sha256:4083861b0aa07990b619bd7ddc365eb7fa4b817e99cf5f8d9cf21a42780f6e01",
                 "sha256:498b0f36cc7054c1fead3d7fc59d2150f4d5c6c56ba7fb150c013fbc683a8d2d",
                 "sha256:4e3e5da80ccbebfff202a67bf900d081906c358ccc3d5e3c8aea42fdfdfd51c1",
@@ -173,16 +230,20 @@
                 "sha256:73d785a950fc82dd2a25897d525d003f6378d1cb23ab305578394694202a58c3",
                 "sha256:8c8aaad94455178e3187ab22c8b01a3837f8ee50e09cf31f1ba129eb293ec30b",
                 "sha256:8ce678dbaf790dbdb3eba24056d5364fb45944f33553dd5869b7580cdbb83614",
+                "sha256:92c325624e304ebf0e025d1224b77dd4e6393f18aab8d829b5b7e04afe9b7a2c",
                 "sha256:aaee9905aee35ba5905cfb3c62f3e83b3bec7b39413f0a7f19be4e547ea01ebb",
+                "sha256:b52ccf7cfe4ce2a1064b18594381bccf4179c2ecf7f513134ec2f993dd4ab395",
                 "sha256:bcd3b13b56ea479b3650b82cabd6b5343a625b0ced5429e4ccad28a8973f301b",
                 "sha256:c9e348e02e4d2b4a8b2eedb48210430658df6951fa484e59de33ff773fbd4b41",
                 "sha256:d205b1b46085271b4e15f670058ce182bd1199e56b317bf2ec004b6a44f911f6",
                 "sha256:d43943ef777f9a1c42bf4e552ba23ac77a6351de620aa9acf64ad54933ad4d34",
                 "sha256:d5d33e9e7af3b34a40dc05f498939f0ebf187f07c385fd58d591c533ad8562fe",
+                "sha256:d648b8e3bf2fe648745c8ffcee3db3ff903d0817a01a12dd6a6ea7a8f4889072",
+                "sha256:fac11badff8313e23717f3dada86a15389d0708275bddf766cca67a84ead3e91",
                 "sha256:fc0fea399acb12edbf8a628ba8d2312f583bdbdb3335635db062fa98cf71fca4",
                 "sha256:fe460b922ec15dd205595c9b5b99e2f056fd98ae8f9f56b888e7a17dc2b757e7"
             ],
-            "markers": "implementation_name == 'cpython' and python_version < '3.8'",
+            "markers": "python_version < '3.8' and implementation_name == 'cpython'",
             "version": "==1.4.1"
         },
         "typing-extensions": {
@@ -201,11 +262,11 @@
         },
         "zipp": {
             "hashes": [
-                "sha256:16522f69653f0d67be90e8baa4a46d66389145b734345d68a257da53df670903",
-                "sha256:c1532a8030c32fd52ff6a288d855fe7adef5823ba1d26a29a68fd6314aa72baa"
+                "sha256:102c24ef8f171fd729d46599845e95c7ab894a4cf45f5de11a44cc7444fb1108",
+                "sha256:ed5eee1974372595f9e416cc7bbeeb12335201d8081ca8a0743c954d4446e5cb"
             ],
             "markers": "python_version >= '3.6'",
-            "version": "==3.3.1"
+            "version": "==3.4.0"
         }
     }
 }
diff --git a/python/setup.cfg b/python/setup.cfg
index 503384f0c920..cb696291ba38 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -25,6 +25,7 @@ devel =
     isort >= 5.0.5
     mypy >= 0.770
     pylint >= 2.6.0
+    pytest >= 3.0.0
 
 
 [flake8]
@@ -72,3 +73,7 @@ include_trailing_comma=True
 line_length=72
 lines_after_imports=2
 multi_line_output=3
+
+[tool:pytest]
+addopts = -v
+console_output_style = count
diff --git a/python/tests/test_lint.py b/python/tests/test_lint.py
new file mode 100644
index 000000000000..38fefa01c667
--- /dev/null
+++ b/python/tests/test_lint.py
@@ -0,0 +1,28 @@
+import subprocess
+
+
+def _external_test(command_line: str) -> None:
+    args = command_line.split(' ')
+    try:
+        subprocess.run(args, check=True)
+    except subprocess.CalledProcessError as err:
+        # Re-contextualize to avoid pytest showing error context inside
+        # the subprocess module itself
+        raise Exception("'{:s}' returned {:d}".format(
+            ' '.join(args), err.returncode)) from None
+
+
+def test_isort() -> None:
+    _external_test('isort -c qemu')
+
+
+def test_flake8() -> None:
+    _external_test('flake8')
+
+
+def test_pylint() -> None:
+    _external_test('pylint qemu')
+
+
+def test_mypy() -> None:
+    _external_test('mypy -p qemu')
-- 
2.26.2


