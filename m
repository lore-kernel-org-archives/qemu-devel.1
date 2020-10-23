Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A9CC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EE320936
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjDH2vjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EE320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVu93-0002og-IZ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 06:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVu4O-0005nD-5d
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVu4I-0001fE-RH
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603447985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dXOzCbNFZsvjSmmSUbRfjfX6roMA8G2yy1EK+HbPaU=;
 b=LjDH2vjEXs++uRpLIzZjH4zhdO1cEbvTE57tS3OKtESGL31kPyIknLaRdkpR23SZmf+PTP
 hiwWC4tvIqqM/IbX1CIYtjdpxB69nj3aqiGTJbg9hqRRuTNzDfb2SEMJIPjAtg8KHthWiK
 /BeYi6upPTQwj/gGG7BQihLvZEeubL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-_cy9PRLoPmmsI3mZG4TtPA-1; Fri, 23 Oct 2020 06:13:03 -0400
X-MC-Unique: _cy9PRLoPmmsI3mZG4TtPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBDB01006CB7;
 Fri, 23 Oct 2020 10:13:02 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D6C66EF41;
 Fri, 23 Oct 2020 10:13:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 5/6] tests/qapi-schema: Flat representation of simple unions
Date: Fri, 23 Oct 2020 12:12:21 +0200
Message-Id: <20201023101222.250147-6-kwolf@redhat.com>
In-Reply-To: <20201023101222.250147-1-kwolf@redhat.com>
References: <20201023101222.250147-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 tests/qapi-schema/meson.build                      |  4 ++++
 tests/qapi-schema/qapi-schema-test.json            | 10 ++++++++++
 tests/qapi-schema/qapi-schema-test.out             | 14 ++++++++++++++
 tests/qapi-schema/union-allow-flat-bad.err         |  2 ++
 tests/qapi-schema/union-allow-flat-bad.json        |  5 +++++
 tests/qapi-schema/union-allow-flat-bad.out         |  0
 .../qapi-schema/union-allow-flat-builtin-type.err  |  2 ++
 .../qapi-schema/union-allow-flat-builtin-type.json |  5 +++++
 .../qapi-schema/union-allow-flat-builtin-type.out  |  0
 tests/qapi-schema/union-clash-member.err           |  2 ++
 tests/qapi-schema/union-clash-member.json          |  6 ++++++
 tests/qapi-schema/union-clash-member.out           |  0
 15 files changed, 62 insertions(+)
 create mode 100644 tests/qapi-schema/flat-union-allow-flat.err
 create mode 100644 tests/qapi-schema/flat-union-allow-flat.json
 create mode 100644 tests/qapi-schema/flat-union-allow-flat.out
 create mode 100644 tests/qapi-schema/union-allow-flat-bad.err
 create mode 100644 tests/qapi-schema/union-allow-flat-bad.json
 create mode 100644 tests/qapi-schema/union-allow-flat-bad.out
 create mode 100644 tests/qapi-schema/union-allow-flat-builtin-type.err
 create mode 100644 tests/qapi-schema/union-allow-flat-builtin-type.json
 create mode 100644 tests/qapi-schema/union-allow-flat-builtin-type.out
 create mode 100644 tests/qapi-schema/union-clash-member.err
 create mode 100644 tests/qapi-schema/union-clash-member.json
 create mode 100644 tests/qapi-schema/union-clash-member.out

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
index 304ef939bd..4973a9b57a 100644
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
@@ -184,12 +185,15 @@ schemas = [
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
+  'union-clash-member.json',
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
diff --git a/tests/qapi-schema/union-clash-member.err b/tests/qapi-schema/union-clash-member.err
new file mode 100644
index 0000000000..7fe51b0285
--- /dev/null
+++ b/tests/qapi-schema/union-clash-member.err
@@ -0,0 +1,2 @@
+union-clash-member.json: In union 'MyUnion':
+union-clash-member.json:4: member 'type' of type 'Branch' collides with member 'type'
diff --git a/tests/qapi-schema/union-clash-member.json b/tests/qapi-schema/union-clash-member.json
new file mode 100644
index 0000000000..cb09cd7d89
--- /dev/null
+++ b/tests/qapi-schema/union-clash-member.json
@@ -0,0 +1,6 @@
+# 'type' is in the implicit base type and clashes with a 'type' member
+# in branches if flat representation is not disabled
+{ 'struct': 'Branch', 'data': { 'type': 'str' } }
+{ 'union': 'MyUnion',
+  'data': { 'one': 'Branch',
+            'two': 'Branch' } }
diff --git a/tests/qapi-schema/union-clash-member.out b/tests/qapi-schema/union-clash-member.out
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.28.0


