Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7400C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B08620665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B08620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53538 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfTBb-0004Ia-Qu
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfSxA-0001j9-Sf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfSwz-0005V1-Lj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfSwl-0004rY-Hm; Mon, 24 Jun 2019 13:40:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32B8E30872EA;
 Mon, 24 Jun 2019 17:39:55 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60894600C0;
 Mon, 24 Jun 2019 17:39:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 19:39:27 +0200
Message-Id: <20190624173935.25747-8-mreitz@redhat.com>
In-Reply-To: <20190624173935.25747-1-mreitz@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 24 Jun 2019 17:39:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 07/14] tests: Test QAPI default values for
 struct members
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a number of tests for how not to specify a default for
an optional struct member, and one rather large test on how to do it
right (in qapi-schema-test.json).

As a side effect, this patch tests the QAPI code generator's integer and
float parsing capability.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/Makefile.include                        | 14 ++++++++++
 tests/qapi-schema/qapi-schema-test.json       | 28 +++++++++++++++++++
 .../struct-member-alternate-default.json      | 10 +++++++
 ...struct-member-bool-wrong-default-type.json |  3 ++
 .../struct-member-enum-invalid-default.json   |  4 +++
 ...struct-member-enum-wrong-default-type.json |  4 +++
 .../struct-member-float-invalid-default.json  |  4 +++
 ...truct-member-float-wrong-default-type.json |  3 ++
 .../struct-member-int-wrong-default-type.json |  3 ++
 .../struct-member-int8-erange-default.json    |  3 ++
 .../struct-member-list-nonempty-default.json  |  4 +++
 .../struct-member-non-optional-default.json   |  3 ++
 .../struct-member-null-default.json           |  6 ++++
 .../struct-member-str-wrong-default-type.json |  3 ++
 .../struct-member-uint8-erange-default.json   |  3 ++
 .../struct-member-uint8-negative-default.json |  3 ++
 tests/qapi-schema/qapi-schema-test.out        | 24 ++++++++++++++++
 .../struct-member-alternate-default.err       |  1 +
 .../struct-member-alternate-default.exit      |  1 +
 .../struct-member-alternate-default.out       |  0
 .../struct-member-bool-wrong-default-type.err |  1 +
 ...struct-member-bool-wrong-default-type.exit |  1 +
 .../struct-member-bool-wrong-default-type.out |  0
 .../struct-member-enum-invalid-default.err    |  1 +
 .../struct-member-enum-invalid-default.exit   |  1 +
 .../struct-member-enum-invalid-default.out    |  0
 .../struct-member-enum-wrong-default-type.err |  1 +
 ...struct-member-enum-wrong-default-type.exit |  1 +
 .../struct-member-enum-wrong-default-type.out |  0
 .../struct-member-float-invalid-default.err   |  1 +
 .../struct-member-float-invalid-default.exit  |  1 +
 .../struct-member-float-invalid-default.out   |  0
 ...struct-member-float-wrong-default-type.err |  1 +
 ...truct-member-float-wrong-default-type.exit |  1 +
 ...struct-member-float-wrong-default-type.out |  0
 .../struct-member-int-wrong-default-type.err  |  1 +
 .../struct-member-int-wrong-default-type.exit |  1 +
 .../struct-member-int-wrong-default-type.out  |  0
 .../struct-member-int8-erange-default.err     |  1 +
 .../struct-member-int8-erange-default.exit    |  1 +
 .../struct-member-int8-erange-default.out     |  0
 .../struct-member-list-nonempty-default.err   |  1 +
 .../struct-member-list-nonempty-default.exit  |  1 +
 .../struct-member-list-nonempty-default.out   |  0
 .../struct-member-non-optional-default.err    |  1 +
 .../struct-member-non-optional-default.exit   |  1 +
 .../struct-member-non-optional-default.out    |  0
 .../struct-member-null-default.err            |  1 +
 .../struct-member-null-default.exit           |  1 +
 .../struct-member-null-default.out            |  0
 .../struct-member-str-wrong-default-type.err  |  1 +
 .../struct-member-str-wrong-default-type.exit |  1 +
 .../struct-member-str-wrong-default-type.out  |  0
 .../struct-member-uint8-erange-default.err    |  1 +
 .../struct-member-uint8-erange-default.exit   |  1 +
 .../struct-member-uint8-erange-default.out    |  0
 .../struct-member-uint8-negative-default.err  |  1 +
 .../struct-member-uint8-negative-default.exit |  1 +
 .../struct-member-uint8-negative-default.out  |  0
 59 files changed, 150 insertions(+)
 create mode 100644 tests/qapi-schema/struct-member-alternate-default.jso=
n
 create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-ty=
pe.json
 create mode 100644 tests/qapi-schema/struct-member-enum-invalid-default.=
json
 create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-ty=
pe.json
 create mode 100644 tests/qapi-schema/struct-member-float-invalid-default=
.json
 create mode 100644 tests/qapi-schema/struct-member-float-wrong-default-t=
ype.json
 create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-typ=
e.json
 create mode 100644 tests/qapi-schema/struct-member-int8-erange-default.j=
son
 create mode 100644 tests/qapi-schema/struct-member-list-nonempty-default=
.json
 create mode 100644 tests/qapi-schema/struct-member-non-optional-default.=
json
 create mode 100644 tests/qapi-schema/struct-member-null-default.json
 create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-typ=
e.json
 create mode 100644 tests/qapi-schema/struct-member-uint8-erange-default.=
json
 create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defaul=
t.json
 create mode 100644 tests/qapi-schema/struct-member-alternate-default.err
 create mode 100644 tests/qapi-schema/struct-member-alternate-default.exi=
t
 create mode 100644 tests/qapi-schema/struct-member-alternate-default.out
 create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-ty=
pe.err
 create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-ty=
pe.exit
 create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-ty=
pe.out
 create mode 100644 tests/qapi-schema/struct-member-enum-invalid-default.=
err
 create mode 100644 tests/qapi-schema/struct-member-enum-invalid-default.=
exit
 create mode 100644 tests/qapi-schema/struct-member-enum-invalid-default.=
out
 create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-ty=
pe.err
 create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-ty=
pe.exit
 create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-ty=
pe.out
 create mode 100644 tests/qapi-schema/struct-member-float-invalid-default=
.err
 create mode 100644 tests/qapi-schema/struct-member-float-invalid-default=
.exit
 create mode 100644 tests/qapi-schema/struct-member-float-invalid-default=
.out
 create mode 100644 tests/qapi-schema/struct-member-float-wrong-default-t=
ype.err
 create mode 100644 tests/qapi-schema/struct-member-float-wrong-default-t=
ype.exit
 create mode 100644 tests/qapi-schema/struct-member-float-wrong-default-t=
ype.out
 create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-typ=
e.err
 create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-typ=
e.exit
 create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-typ=
e.out
 create mode 100644 tests/qapi-schema/struct-member-int8-erange-default.e=
rr
 create mode 100644 tests/qapi-schema/struct-member-int8-erange-default.e=
xit
 create mode 100644 tests/qapi-schema/struct-member-int8-erange-default.o=
ut
 create mode 100644 tests/qapi-schema/struct-member-list-nonempty-default=
.err
 create mode 100644 tests/qapi-schema/struct-member-list-nonempty-default=
.exit
 create mode 100644 tests/qapi-schema/struct-member-list-nonempty-default=
.out
 create mode 100644 tests/qapi-schema/struct-member-non-optional-default.=
err
 create mode 100644 tests/qapi-schema/struct-member-non-optional-default.=
exit
 create mode 100644 tests/qapi-schema/struct-member-non-optional-default.=
out
 create mode 100644 tests/qapi-schema/struct-member-null-default.err
 create mode 100644 tests/qapi-schema/struct-member-null-default.exit
 create mode 100644 tests/qapi-schema/struct-member-null-default.out
 create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-typ=
e.err
 create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-typ=
e.exit
 create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-typ=
e.out
 create mode 100644 tests/qapi-schema/struct-member-uint8-erange-default.=
err
 create mode 100644 tests/qapi-schema/struct-member-uint8-erange-default.=
exit
 create mode 100644 tests/qapi-schema/struct-member-uint8-erange-default.=
out
 create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defaul=
t.err
 create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defaul=
t.exit
 create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defaul=
t.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index db750dd6d0..76dc581096 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -451,6 +451,20 @@ qapi-schema +=3D returns-whitelist.json
 qapi-schema +=3D struct-base-clash-deep.json
 qapi-schema +=3D struct-base-clash.json
 qapi-schema +=3D struct-data-invalid.json
+qapi-schema +=3D struct-member-alternate-default.json
+qapi-schema +=3D struct-member-bool-wrong-default-type.json
+qapi-schema +=3D struct-member-enum-invalid-default.json
+qapi-schema +=3D struct-member-enum-wrong-default-type.json
+qapi-schema +=3D struct-member-float-invalid-default.json
+qapi-schema +=3D struct-member-float-wrong-default-type.json
+qapi-schema +=3D struct-member-int-wrong-default-type.json
+qapi-schema +=3D struct-member-int8-erange-default.json
+qapi-schema +=3D struct-member-list-nonempty-default.json
+qapi-schema +=3D struct-member-non-optional-default.json
+qapi-schema +=3D struct-member-null-default.json
+qapi-schema +=3D struct-member-str-wrong-default-type.json
+qapi-schema +=3D struct-member-uint8-erange-default.json
+qapi-schema +=3D struct-member-uint8-negative-default.json
 qapi-schema +=3D struct-member-invalid-dict.json
 qapi-schema +=3D struct-member-invalid.json
 qapi-schema +=3D trailing-comma-list.json
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index c6d59acc3e..12ae387d46 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -281,3 +281,31 @@
             'cfs1': 'CondFeatureStruct1',
             'cfs2': 'CondFeatureStruct2',
             'cfs3': 'CondFeatureStruct3' } }
+
+# test defaults for optional struct members
+
+{ 'enum': 'TestDefaultEnum',
+  'data': [ 'value1', 'value2', 'value3' ] }
+
+{ 'struct': 'TestDefaultSubStruct',
+  'data': { 'member': 'int' } }
+
+{ 'struct': 'TestDefaultStruct',
+  'data': {
+      '*bool_false': { 'type': 'bool', 'default': false },
+      '*bool_true':  { 'type': 'bool', 'default': true },
+      '*integer':    { 'type': 'int',   'default': -42 },
+      '*int8_low':   { 'type': 'int8',  'default': -0x80 },
+      '*int8_high':  { 'type': 'int8',  'default':  0x7f },
+      '*uint8_high': { 'type': 'uint8', 'default':  0xff },
+      '*size':       { 'type': 'size',  'default':  0xffffffffffffffff }=
,
+      '*fpneg':    { 'type': 'number', 'default': -.375e3 },
+      '*fppos':    { 'type': 'number', 'default': +42. },
+      '*fpposinf': { 'type': 'number', 'default':  inf },
+      '*fpneginf': { 'type': 'number', 'default': -inf },
+      '*fpnan':    { 'type': 'number', 'default': nan },
+      '*str': { 'type': 'str', 'default': 'foo \\=E9=B9=BF"\u007f\b"\'' =
},
+      '*enum_value2': { 'type': 'TestDefaultEnum', 'default': 'value2' }=
,
+      '*list_scalar': { 'type': ['int'], 'default': [] },
+      '*list_struct': { 'type': ['TestDefaultSubStruct'], 'default': [] =
}
+  } }
diff --git a/tests/qapi-schema/struct-member-alternate-default.json b/tes=
ts/qapi-schema/struct-member-alternate-default.json
new file mode 100644
index 0000000000..0441b3af80
--- /dev/null
+++ b/tests/qapi-schema/struct-member-alternate-default.json
@@ -0,0 +1,10 @@
+# Check defaults for unsupported types (alternates, here)
+# TODO: Implement support for alternates, and then add a test where
+#       default=3Dnull so we can see that that is another thing that
+#       should be implemented
+{ 'enum': 'TestEnum', 'data': [ 'value1', 'value2' ] }
+{ 'alternate': 'TestAlt',
+  'data': { 'alt1': 'TestEnum',
+            'alt2': 'null' } }
+{ 'struct': 'Test',
+  'data': { '*member': { 'type': 'TestAlt', 'default': 'value1' } } }
diff --git a/tests/qapi-schema/struct-member-bool-wrong-default-type.json=
 b/tests/qapi-schema/struct-member-bool-wrong-default-type.json
new file mode 100644
index 0000000000..c9f9c45a87
--- /dev/null
+++ b/tests/qapi-schema/struct-member-bool-wrong-default-type.json
@@ -0,0 +1,3 @@
+# Check that booleans do not accept non-booleans
+{ 'struct': 'Test',
+  'data': { '*member': { 'type': 'bool', 'default': 0 } } }
diff --git a/tests/qapi-schema/struct-member-enum-invalid-default.json b/=
tests/qapi-schema/struct-member-enum-invalid-default.json
new file mode 100644
index 0000000000..d5724970be
--- /dev/null
+++ b/tests/qapi-schema/struct-member-enum-invalid-default.json
@@ -0,0 +1,4 @@
+# Check that enum values do not accept anything that is not part of the =
enum
+{ 'enum': 'TestEnum', 'data': [ 'value1', 'value2' ] }
+{ 'struct': 'Test',
+  'data': { '*member': { 'type': 'TestEnum', 'default': 'value3' } } }
diff --git a/tests/qapi-schema/struct-member-enum-wrong-default-type.json=
 b/tests/qapi-schema/struct-member-enum-wrong-default-type.json
new file mode 100644
index 0000000000..98f18b462c
--- /dev/null
+++ b/tests/qapi-schema/struct-member-enum-wrong-default-type.json
@@ -0,0 +1,4 @@
+# Check that enum values do not accept non-strings
+{ 'enum': 'TestEnum', 'data': [ 'value1', 'value2' ] }
+{ 'struct': 'Test',
+  'data': { '*member': { 'type': 'TestEnum', 'default': 0 } } }
diff --git a/tests/qapi-schema/struct-member-float-invalid-default.json b=
/tests/qapi-schema/struct-member-float-invalid-default.json
new file mode 100644
index 0000000000..ba351a91c8
--- /dev/null
+++ b/tests/qapi-schema/struct-member-float-invalid-default.json
@@ -0,0 +1,4 @@
+# This matches our number regex, but it is an invalid float still --
+# test that it is rejected
+{ 'struct': 'Test',
+  'data': { '*member': { 'type': 'number', 'default': 4.42. } } }
diff --git a/tests/qapi-schema/struct-member-float-wrong-default-type.jso=
n b/tests/qapi-schema/struct-member-float-wrong-default-type.json
new file mode 100644
index 0000000000..89b6863307
--- /dev/null
+++ b/tests/qapi-schema/struct-member-float-wrong-default-type.json
@@ -0,0 +1,3 @@
+# Check that floats do not accept non-floats
+{ 'struct': 'Test',
+  'data': { '*member': { 'type': 'number', 'default': 42 } } }
diff --git a/tests/qapi-schema/struct-member-int-wrong-default-type.json =
b/tests/qapi-schema/struct-member-int-wrong-default-type.json
new file mode 100644
index 0000000000..6c6c752176
--- /dev/null
+++ b/tests/qapi-schema/struct-member-int-wrong-default-type.json
@@ -0,0 +1,3 @@
+# Check that integers do not accept non-integers
+{ 'struct': 'Test',
+  'data': { '*member': { 'type': 'int', 'default': 0.0 } } }
diff --git a/tests/qapi-schema/struct-member-int8-erange-default.json b/t=
ests/qapi-schema/struct-member-int8-erange-default.json
new file mode 100644
index 0000000000..a0093bc4b9
--- /dev/null
+++ b/tests/qapi-schema/struct-member-int8-erange-default.json
@@ -0,0 +1,3 @@
+# int8 does not accept out-of-range values
+{ 'struct': 'Test',
+  'data': { '*s8': { 'type': 'int8', 'default': -0x81 } } }
diff --git a/tests/qapi-schema/struct-member-list-nonempty-default.json b=
/tests/qapi-schema/struct-member-list-nonempty-default.json
new file mode 100644
index 0000000000..604692631b
--- /dev/null
+++ b/tests/qapi-schema/struct-member-list-nonempty-default.json
@@ -0,0 +1,4 @@
+# Currently, we do not support nonempty defaults for lists
+# TODO: Implement support
+{ 'struct': 'Test',
+  'data': { '*member': { 'type': ['int'], 'default': [42] } } }
diff --git a/tests/qapi-schema/struct-member-non-optional-default.json b/=
tests/qapi-schema/struct-member-non-optional-default.json
new file mode 100644
index 0000000000..354b34167d
--- /dev/null
+++ b/tests/qapi-schema/struct-member-non-optional-default.json
@@ -0,0 +1,3 @@
+# Only optional members can have defaults
+{ 'struct': 'Test',
+  'data': { 'member': { 'type': 'int', 'default': 42 } } }
diff --git a/tests/qapi-schema/struct-member-null-default.json b/tests/qa=
pi-schema/struct-member-null-default.json
new file mode 100644
index 0000000000..c0cf70b984
--- /dev/null
+++ b/tests/qapi-schema/struct-member-null-default.json
@@ -0,0 +1,6 @@
+# Currently, you cannot give a default for null members, because
+# 'None' is reserved for 'no default'.
+# TODO: Fix that, though it would only really make sense for
+#       alternates (which currently cannot receive defaults either)
+{ 'struct': 'Test',
+  'data': { '*member': { 'type': 'null', 'default': null } } }
diff --git a/tests/qapi-schema/struct-member-str-wrong-default-type.json =
b/tests/qapi-schema/struct-member-str-wrong-default-type.json
new file mode 100644
index 0000000000..d460d3a9b4
--- /dev/null
+++ b/tests/qapi-schema/struct-member-str-wrong-default-type.json
@@ -0,0 +1,3 @@
+# Check that strings do not accept non-strings
+{ 'struct': 'Test',
+  'data': { '*member': { 'type': 'str', 'default': null } } }
diff --git a/tests/qapi-schema/struct-member-uint8-erange-default.json b/=
tests/qapi-schema/struct-member-uint8-erange-default.json
new file mode 100644
index 0000000000..a4fe7fd918
--- /dev/null
+++ b/tests/qapi-schema/struct-member-uint8-erange-default.json
@@ -0,0 +1,3 @@
+# uint8 does not accept out-of-range values
+{ 'struct': 'Test',
+  'data': { '*u8': { 'type': 'uint8', 'default': 0x100 } } }
diff --git a/tests/qapi-schema/struct-member-uint8-negative-default.json =
b/tests/qapi-schema/struct-member-uint8-negative-default.json
new file mode 100644
index 0000000000..62bbf86af9
--- /dev/null
+++ b/tests/qapi-schema/struct-member-uint8-negative-default.json
@@ -0,0 +1,3 @@
+# uint8 does not accept negative values
+{ 'struct': 'Test',
+  'data': { '*u8': { 'type': 'uint8', 'default': -1 } } }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 85d510bc00..724276f5de 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -397,3 +397,27 @@ object q_obj_test-features-arg
     member cfs3: CondFeatureStruct3 optional=3DFalse
 command test-features q_obj_test-features-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+enum TestDefaultEnum
+    member value1
+    member value2
+    member value3
+object TestDefaultSubStruct
+    member member: int optional=3DFalse
+array TestDefaultSubStructList TestDefaultSubStruct
+object TestDefaultStruct
+    member bool_false: bool optional=3DTrue default=3DFalse
+    member bool_true: bool optional=3DTrue default=3DTrue
+    member integer: int optional=3DTrue default=3D-42
+    member int8_low: int8 optional=3DTrue default=3D-128
+    member int8_high: int8 optional=3DTrue default=3D127
+    member uint8_high: uint8 optional=3DTrue default=3D255
+    member size: size optional=3DTrue default=3D18446744073709551615
+    member fpneg: number optional=3DTrue default=3D-375.0
+    member fppos: number optional=3DTrue default=3D42.0
+    member fpposinf: number optional=3DTrue default=3Dinf
+    member fpneginf: number optional=3DTrue default=3D-inf
+    member fpnan: number optional=3DTrue default=3Dnan
+    member str: str optional=3DTrue default=3Dfoo \=E9=B9=BF"=7F=08"'
+    member enum_value2: TestDefaultEnum optional=3DTrue default=3Dvalue2
+    member list_scalar: intList optional=3DTrue default=3D[]
+    member list_struct: TestDefaultSubStructList optional=3DTrue default=
=3D[]
diff --git a/tests/qapi-schema/struct-member-alternate-default.err b/test=
s/qapi-schema/struct-member-alternate-default.err
new file mode 100644
index 0000000000..48314475f9
--- /dev/null
+++ b/tests/qapi-schema/struct-member-alternate-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-alternate-default.json:9: Cannot specify=
 values for type TestAlt (not built-in or an enum)
diff --git a/tests/qapi-schema/struct-member-alternate-default.exit b/tes=
ts/qapi-schema/struct-member-alternate-default.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-alternate-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-alternate-default.out b/test=
s/qapi-schema/struct-member-alternate-default.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-bool-wrong-default-type.err =
b/tests/qapi-schema/struct-member-bool-wrong-default-type.err
new file mode 100644
index 0000000000..a0095e5c83
--- /dev/null
+++ b/tests/qapi-schema/struct-member-bool-wrong-default-type.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-bool-wrong-default-type.json:2: Value '0=
' does not match type bool
diff --git a/tests/qapi-schema/struct-member-bool-wrong-default-type.exit=
 b/tests/qapi-schema/struct-member-bool-wrong-default-type.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-bool-wrong-default-type.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-bool-wrong-default-type.out =
b/tests/qapi-schema/struct-member-bool-wrong-default-type.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-enum-invalid-default.err b/t=
ests/qapi-schema/struct-member-enum-invalid-default.err
new file mode 100644
index 0000000000..6aa3684a28
--- /dev/null
+++ b/tests/qapi-schema/struct-member-enum-invalid-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-enum-invalid-default.json:3: Value 'valu=
e3' does not occur in enum TestEnum
diff --git a/tests/qapi-schema/struct-member-enum-invalid-default.exit b/=
tests/qapi-schema/struct-member-enum-invalid-default.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-enum-invalid-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-enum-invalid-default.out b/t=
ests/qapi-schema/struct-member-enum-invalid-default.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-enum-wrong-default-type.err =
b/tests/qapi-schema/struct-member-enum-wrong-default-type.err
new file mode 100644
index 0000000000..846dad0316
--- /dev/null
+++ b/tests/qapi-schema/struct-member-enum-wrong-default-type.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-enum-wrong-default-type.json:3: Enum val=
ues must be strings, but '0' is no string
diff --git a/tests/qapi-schema/struct-member-enum-wrong-default-type.exit=
 b/tests/qapi-schema/struct-member-enum-wrong-default-type.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-enum-wrong-default-type.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-enum-wrong-default-type.out =
b/tests/qapi-schema/struct-member-enum-wrong-default-type.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-float-invalid-default.err b/=
tests/qapi-schema/struct-member-float-invalid-default.err
new file mode 100644
index 0000000000..1ae241641f
--- /dev/null
+++ b/tests/qapi-schema/struct-member-float-invalid-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-float-invalid-default.json:4:55: "4.42."=
 is not a valid integer or float
diff --git a/tests/qapi-schema/struct-member-float-invalid-default.exit b=
/tests/qapi-schema/struct-member-float-invalid-default.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-float-invalid-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-float-invalid-default.out b/=
tests/qapi-schema/struct-member-float-invalid-default.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-float-wrong-default-type.err=
 b/tests/qapi-schema/struct-member-float-wrong-default-type.err
new file mode 100644
index 0000000000..8f8bf68d23
--- /dev/null
+++ b/tests/qapi-schema/struct-member-float-wrong-default-type.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-float-wrong-default-type.json:2: Value '=
42' does not match type number
diff --git a/tests/qapi-schema/struct-member-float-wrong-default-type.exi=
t b/tests/qapi-schema/struct-member-float-wrong-default-type.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-float-wrong-default-type.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-float-wrong-default-type.out=
 b/tests/qapi-schema/struct-member-float-wrong-default-type.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-int-wrong-default-type.err b=
/tests/qapi-schema/struct-member-int-wrong-default-type.err
new file mode 100644
index 0000000000..a6b93e8403
--- /dev/null
+++ b/tests/qapi-schema/struct-member-int-wrong-default-type.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-int-wrong-default-type.json:2: Value '0.=
0' does not match type int
diff --git a/tests/qapi-schema/struct-member-int-wrong-default-type.exit =
b/tests/qapi-schema/struct-member-int-wrong-default-type.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-int-wrong-default-type.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-int-wrong-default-type.out b=
/tests/qapi-schema/struct-member-int-wrong-default-type.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-int8-erange-default.err b/te=
sts/qapi-schema/struct-member-int8-erange-default.err
new file mode 100644
index 0000000000..e58bf7279c
--- /dev/null
+++ b/tests/qapi-schema/struct-member-int8-erange-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-int8-erange-default.json:2: Value '-129'=
 does not match type int8
diff --git a/tests/qapi-schema/struct-member-int8-erange-default.exit b/t=
ests/qapi-schema/struct-member-int8-erange-default.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-int8-erange-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-int8-erange-default.out b/te=
sts/qapi-schema/struct-member-int8-erange-default.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-list-nonempty-default.err b/=
tests/qapi-schema/struct-member-list-nonempty-default.err
new file mode 100644
index 0000000000..48b6fd61a6
--- /dev/null
+++ b/tests/qapi-schema/struct-member-list-nonempty-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-list-nonempty-default.json:3: Support fo=
r non-empty lists as default values has not been implemented yet: '[42]'
diff --git a/tests/qapi-schema/struct-member-list-nonempty-default.exit b=
/tests/qapi-schema/struct-member-list-nonempty-default.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-list-nonempty-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-list-nonempty-default.out b/=
tests/qapi-schema/struct-member-list-nonempty-default.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-non-optional-default.err b/t=
ests/qapi-schema/struct-member-non-optional-default.err
new file mode 100644
index 0000000000..ba79cb43fa
--- /dev/null
+++ b/tests/qapi-schema/struct-member-non-optional-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-non-optional-default.json:2: 'member' is=
 not optional, so it cannot have a default value
diff --git a/tests/qapi-schema/struct-member-non-optional-default.exit b/=
tests/qapi-schema/struct-member-non-optional-default.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-non-optional-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-non-optional-default.out b/t=
ests/qapi-schema/struct-member-non-optional-default.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-null-default.err b/tests/qap=
i-schema/struct-member-null-default.err
new file mode 100644
index 0000000000..6a37655f3d
--- /dev/null
+++ b/tests/qapi-schema/struct-member-null-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-null-default.json:5: Cannot specify valu=
es for type null
diff --git a/tests/qapi-schema/struct-member-null-default.exit b/tests/qa=
pi-schema/struct-member-null-default.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-null-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-null-default.out b/tests/qap=
i-schema/struct-member-null-default.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-str-wrong-default-type.err b=
/tests/qapi-schema/struct-member-str-wrong-default-type.err
new file mode 100644
index 0000000000..597165e22a
--- /dev/null
+++ b/tests/qapi-schema/struct-member-str-wrong-default-type.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-str-wrong-default-type.json:2: Value 'No=
ne' does not match type str
diff --git a/tests/qapi-schema/struct-member-str-wrong-default-type.exit =
b/tests/qapi-schema/struct-member-str-wrong-default-type.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-str-wrong-default-type.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-str-wrong-default-type.out b=
/tests/qapi-schema/struct-member-str-wrong-default-type.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-uint8-erange-default.err b/t=
ests/qapi-schema/struct-member-uint8-erange-default.err
new file mode 100644
index 0000000000..a870c7074e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-uint8-erange-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-uint8-erange-default.json:2: Value '256'=
 does not match type uint8
diff --git a/tests/qapi-schema/struct-member-uint8-erange-default.exit b/=
tests/qapi-schema/struct-member-uint8-erange-default.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-uint8-erange-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-uint8-erange-default.out b/t=
ests/qapi-schema/struct-member-uint8-erange-default.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-uint8-negative-default.err b=
/tests/qapi-schema/struct-member-uint8-negative-default.err
new file mode 100644
index 0000000000..e17ef38e15
--- /dev/null
+++ b/tests/qapi-schema/struct-member-uint8-negative-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-uint8-negative-default.json:2: Value '-1=
' does not match type uint8
diff --git a/tests/qapi-schema/struct-member-uint8-negative-default.exit =
b/tests/qapi-schema/struct-member-uint8-negative-default.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-uint8-negative-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-uint8-negative-default.out b=
/tests/qapi-schema/struct-member-uint8-negative-default.out
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.21.0


