Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A52C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10CF206B5
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvJKPu54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10CF206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW06H-0002AQ-So
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVzhQ-0008HM-5p
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVzhL-0007kU-0K
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603469624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7IW7p6laPaR5hSZGxFp2gRPwVk8lAybNgDWwcbm1580=;
 b=JvJKPu54ugPMP/5N0uNGHr8mgcNna0iyekF+uYanVr8xhSufAYAnxzIssL/PQa+ucVmhJT
 gv3zY4v20A9dfGjE0XVB5cazRZmx7+TKLzpqsAksrKLstAw5WwpSSNvU96bTjU6mlDHREo
 QCKCfoQ3GM6u5PX/YODIkjrOB3fLKRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-vgbF0J-pNGuviXh7R7ETQQ-1; Fri, 23 Oct 2020 12:13:42 -0400
X-MC-Unique: vgbF0J-pNGuviXh7R7ETQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26631EC502;
 Fri, 23 Oct 2020 16:13:39 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF0E35C1D0;
 Fri, 23 Oct 2020 16:13:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/6] tests/qapi-schema: Flat representation of simple unions
Date: Fri, 23 Oct 2020 18:13:11 +0200
Message-Id: <20201023161312.460406-6-kwolf@redhat.com>
In-Reply-To: <20201023161312.460406-1-kwolf@redhat.com>
References: <20201023161312.460406-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds some test cases related to flat representation of simple
unions and the 'allow-flat' option for union branches.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qapi-schema/flat-union-allow-flat.err        |  2 ++
 tests/qapi-schema/flat-union-allow-flat.json       | 10 ++++++++++
 tests/qapi-schema/flat-union-allow-flat.out        |  0
 tests/qapi-schema/meson.build                      |  5 +++++
 tests/qapi-schema/qapi-schema-test.json            | 10 ++++++++++
 tests/qapi-schema/qapi-schema-test.out             | 14 ++++++++++++++
 tests/qapi-schema/union-allow-flat-bad.err         |  2 ++
 tests/qapi-schema/union-allow-flat-bad.json        |  5 +++++
 tests/qapi-schema/union-allow-flat-bad.out         |  0
 .../qapi-schema/union-allow-flat-builtin-type.err  |  2 ++
 .../qapi-schema/union-allow-flat-builtin-type.json |  5 +++++
 .../qapi-schema/union-allow-flat-builtin-type.out  |  0
 tests/qapi-schema/union-clash-member-data.err      |  2 ++
 tests/qapi-schema/union-clash-member-data.json     |  6 ++++++
 tests/qapi-schema/union-clash-member-data.out      |  0
 tests/qapi-schema/union-clash-member-type.err      |  2 ++
 tests/qapi-schema/union-clash-member-type.json     |  6 ++++++
 tests/qapi-schema/union-clash-member-type.out      |  0
 18 files changed, 71 insertions(+)
 create mode 100644 tests/qapi-schema/flat-union-allow-flat.err
 create mode 100644 tests/qapi-schema/flat-union-allow-flat.json
 create mode 100644 tests/qapi-schema/flat-union-allow-flat.out
 create mode 100644 tests/qapi-schema/union-allow-flat-bad.err
 create mode 100644 tests/qapi-schema/union-allow-flat-bad.json
 create mode 100644 tests/qapi-schema/union-allow-flat-bad.out
 create mode 100644 tests/qapi-schema/union-allow-flat-builtin-type.err
 create mode 100644 tests/qapi-schema/union-allow-flat-builtin-type.json
 create mode 100644 tests/qapi-schema/union-allow-flat-builtin-type.out
 create mode 100644 tests/qapi-schema/union-clash-member-data.err
 create mode 100644 tests/qapi-schema/union-clash-member-data.json
 create mode 100644 tests/qapi-schema/union-clash-member-data.out
 create mode 100644 tests/qapi-schema/union-clash-member-type.err
 create mode 100644 tests/qapi-schema/union-clash-member-type.json
 create mode 100644 tests/qapi-schema/union-clash-member-type.out

diff --git a/tests/qapi-schema/flat-union-allow-flat.err b/tests/qapi-schema/flat-union-allow-flat.err
new file mode 100644
index 0000000000..f3f3d2384b
--- /dev/null
+++ b/tests/qapi-schema/flat-union-allow-flat.err
@@ -0,0 +1,2 @@
+flat-union-allow-flat.json: In union 'MyUnion':
+flat-union-allow-flat.json:6: 'allow-flat' requires simple union
diff --git a/tests/qapi-schema/flat-union-allow-flat.json b/tests/qapi-schema/flat-union-allow-flat.json
new file mode 100644
index 0000000000..114acaad86
--- /dev/null
+++ b/tests/qapi-schema/flat-union-allow-flat.json
@@ -0,0 +1,10 @@
+# Flat unions must not use allow-flat
+{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
+{ 'struct': 'Base',
+  'data': { 'switch': 'Enum' } }
+{ 'struct': 'Branch', 'data': { 'name': 'str' } }
+{ 'union': 'MyUnion',
+  'base': 'Base',
+  'discriminator': 'switch',
+  'data': { 'one': { 'type': 'Branch', 'allow-flat': true },
+            'two': 'Branch' } }
diff --git a/tests/qapi-schema/flat-union-allow-flat.out b/tests/qapi-schema/flat-union-allow-flat.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 304ef939bd..a5138d0c0f 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -103,6 +103,7 @@ schemas = [
   'features-name-bad-type.json',
   'features-no-list.json',
   'features-unknown-key.json',
+  'flat-union-allow-flat.json',
   'flat-union-array-branch.json',
   'flat-union-bad-base.json',
   'flat-union-bad-discriminator.json',
@@ -184,12 +185,16 @@ schemas = [
   'unclosed-list.json',
   'unclosed-object.json',
   'unclosed-string.json',
+  'union-allow-flat-bad.json',
+  'union-allow-flat-builtin-type.json',
   'union-base-empty.json',
   'union-base-no-discriminator.json',
   'union-branch-case.json',
   'union-branch-if-invalid.json',
   'union-branch-invalid-dict.json',
   'union-clash-branches.json',
+  'union-clash-member-data.json',
+  'union-clash-member-type.json',
   'union-empty.json',
   'union-invalid-base.json',
   'union-optional-branch.json',
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 63f92adf68..1c29576ae9 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -110,6 +110,16 @@
 { 'struct': 'UserDefC',
   'data': { 'string1': 'str', 'string2': 'str' } }
 
+{ 'struct': 'UserDefD',
+  'data': { 'type': 'str' } }
+
+{ 'union': 'UserDefSimpleUnion',
+  'data': { 'value1' : {'type': 'UserDefA'},
+            'value2' : 'UserDefB',
+            'value3' : 'UserDefB',
+            'value4' : { 'type': 'UserDefD', 'allow-flat': false }
+  } }
+
 # for testing use of 'number' within alternates
 { 'alternate': 'AltEnumBool', 'data': { 'e': 'EnumOne', 'b': 'bool' } }
 { 'alternate': 'AltEnumNum', 'data': { 'e': 'EnumOne', 'n': 'number' } }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index a4e4051c61..7521e86e9f 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -105,6 +105,20 @@ alternate UserDefAlternate
 object UserDefC
     member string1: str optional=False
     member string2: str optional=False
+object UserDefD
+    member type: str optional=False
+enum UserDefSimpleUnionKind
+    member value1
+    member value2
+    member value3
+    member value4
+object UserDefSimpleUnion
+    member type: UserDefSimpleUnionKind optional=False
+    tag type
+    case value1: UserDefA
+    case value2: UserDefB
+    case value3: UserDefB
+    case value4: UserDefD
 alternate AltEnumBool
     tag type
     case e: EnumOne
diff --git a/tests/qapi-schema/union-allow-flat-bad.err b/tests/qapi-schema/union-allow-flat-bad.err
new file mode 100644
index 0000000000..561fd338e1
--- /dev/null
+++ b/tests/qapi-schema/union-allow-flat-bad.err
@@ -0,0 +1,2 @@
+union-allow-flat-bad.json: In union 'MyUnion':
+union-allow-flat-bad.json:3: 'allow-flat' must be a boolean
diff --git a/tests/qapi-schema/union-allow-flat-bad.json b/tests/qapi-schema/union-allow-flat-bad.json
new file mode 100644
index 0000000000..6e02e8312b
--- /dev/null
+++ b/tests/qapi-schema/union-allow-flat-bad.json
@@ -0,0 +1,5 @@
+# allow-flat must be a boolean
+{ 'struct': 'Branch', 'data': { 'name': 'str' } }
+{ 'union': 'MyUnion',
+  'data': { 'one': { 'type': 'Branch', 'allow-flat': 'maybe' },
+            'two': 'Branch' } }
diff --git a/tests/qapi-schema/union-allow-flat-bad.out b/tests/qapi-schema/union-allow-flat-bad.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/union-allow-flat-builtin-type.err b/tests/qapi-schema/union-allow-flat-builtin-type.err
new file mode 100644
index 0000000000..4163d2426e
--- /dev/null
+++ b/tests/qapi-schema/union-allow-flat-builtin-type.err
@@ -0,0 +1,2 @@
+union-allow-flat-builtin-type.json: In union 'MyUnion':
+union-allow-flat-builtin-type.json:3: branch 'one' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/union-allow-flat-builtin-type.json b/tests/qapi-schema/union-allow-flat-builtin-type.json
new file mode 100644
index 0000000000..21eb25c48a
--- /dev/null
+++ b/tests/qapi-schema/union-allow-flat-builtin-type.json
@@ -0,0 +1,5 @@
+# Can't use built-in types for branches with 'allow-flat': true
+{ 'struct': 'Branch', 'data': { 'name': 'str' } }
+{ 'union': 'MyUnion',
+  'data': { 'one': { 'type': 'int', 'allow-flat': true },
+            'two': 'Branch' } }
diff --git a/tests/qapi-schema/union-allow-flat-builtin-type.out b/tests/qapi-schema/union-allow-flat-builtin-type.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/union-clash-member-data.err b/tests/qapi-schema/union-clash-member-data.err
new file mode 100644
index 0000000000..316003e1b8
--- /dev/null
+++ b/tests/qapi-schema/union-clash-member-data.err
@@ -0,0 +1,2 @@
+union-clash-member-data.json: In union 'MyUnion':
+union-clash-member-data.json:4: member 'data' of type 'Branch' collides with flat representation of branch 'one'
diff --git a/tests/qapi-schema/union-clash-member-data.json b/tests/qapi-schema/union-clash-member-data.json
new file mode 100644
index 0000000000..b908d44372
--- /dev/null
+++ b/tests/qapi-schema/union-clash-member-data.json
@@ -0,0 +1,6 @@
+# For simple union branches, a 'data' member would prevent conversion
+# to flat representation, so we don't want to allow it
+{ 'struct': 'Branch', 'data': { 'data': 'str' } }
+{ 'union': 'MyUnion',
+  'data': { 'one': 'Branch',
+            'two': 'Branch' } }
diff --git a/tests/qapi-schema/union-clash-member-data.out b/tests/qapi-schema/union-clash-member-data.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/union-clash-member-type.err b/tests/qapi-schema/union-clash-member-type.err
new file mode 100644
index 0000000000..34e4b135ec
--- /dev/null
+++ b/tests/qapi-schema/union-clash-member-type.err
@@ -0,0 +1,2 @@
+union-clash-member-type.json: In union 'MyUnion':
+union-clash-member-type.json:4: member 'type' of type 'Branch' collides with member 'type'
diff --git a/tests/qapi-schema/union-clash-member-type.json b/tests/qapi-schema/union-clash-member-type.json
new file mode 100644
index 0000000000..cb09cd7d89
--- /dev/null
+++ b/tests/qapi-schema/union-clash-member-type.json
@@ -0,0 +1,6 @@
+# 'type' is in the implicit base type and clashes with a 'type' member
+# in branches if flat representation is not disabled
+{ 'struct': 'Branch', 'data': { 'type': 'str' } }
+{ 'union': 'MyUnion',
+  'data': { 'one': 'Branch',
+            'two': 'Branch' } }
diff --git a/tests/qapi-schema/union-clash-member-type.out b/tests/qapi-schema/union-clash-member-type.out
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.28.0


