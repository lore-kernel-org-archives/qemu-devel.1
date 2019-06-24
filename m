Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043B3C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA4320657
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA4320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfTEK-00083p-U0
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfSww-0001YC-Us
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfSwv-0005MX-3U
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfSwn-0004vB-MX; Mon, 24 Jun 2019 13:40:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7CCE3162912;
 Mon, 24 Jun 2019 17:39:57 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DF9F600C0;
 Mon, 24 Jun 2019 17:39:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 19:39:28 +0200
Message-Id: <20190624173935.25747-9-mreitz@redhat.com>
In-Reply-To: <20190624173935.25747-1-mreitz@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 24 Jun 2019 17:39:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 08/14] tests: Add QAPI optional
 discriminator tests
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

There already is an optional discriminator test, although it also noted
the discriminator name itself as optional.  This already gives us one
error test case, to which this patch adds one other, namely whether that
using an optional discriminator requires the respective field to have a
default value.

Furthermore, a passing test case is added to qapi-schema-test.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/Makefile.include                                |  3 ++-
 ...-optional-discriminator-invalid-specification.json | 11 +++++++++++
 ...flat-union-optional-discriminator-no-default.json} |  5 +++--
 tests/qapi-schema/qapi-schema-test.json               | 10 ++++++++++
 ...n-optional-discriminator-invalid-specification.err |  1 +
 ...optional-discriminator-invalid-specification.exit} |  0
 ...-optional-discriminator-invalid-specification.out} |  0
 .../flat-union-optional-discriminator-no-default.err  |  1 +
 .../flat-union-optional-discriminator-no-default.exit |  1 +
 .../flat-union-optional-discriminator-no-default.out  |  0
 .../qapi-schema/flat-union-optional-discriminator.err |  1 -
 tests/qapi-schema/qapi-schema-test.out                |  9 +++++++++
 12 files changed, 38 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.json
 rename tests/qapi-schema/{flat-union-optional-discriminator.json =3D> fl=
at-union-optional-discriminator-no-default.json} (68%)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.err
 rename tests/qapi-schema/{flat-union-optional-discriminator.exit =3D> fl=
at-union-optional-discriminator-invalid-specification.exit} (100%)
 rename tests/qapi-schema/{flat-union-optional-discriminator.out =3D> fla=
t-union-optional-discriminator-invalid-specification.out} (100%)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.out
 delete mode 100644 tests/qapi-schema/flat-union-optional-discriminator.e=
rr

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 76dc581096..3202ddab10 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -398,7 +398,8 @@ qapi-schema +=3D flat-union-invalid-branch-key.json
 qapi-schema +=3D flat-union-invalid-discriminator.json
 qapi-schema +=3D flat-union-invalid-if-discriminator.json
 qapi-schema +=3D flat-union-no-base.json
-qapi-schema +=3D flat-union-optional-discriminator.json
+qapi-schema +=3D flat-union-optional-discriminator-invalid-specification=
.json
+qapi-schema +=3D flat-union-optional-discriminator-no-default.json
 qapi-schema +=3D flat-union-string-discriminator.json
 qapi-schema +=3D funny-char.json
 qapi-schema +=3D ident-with-escape.json
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-=
specification.json b/tests/qapi-schema/flat-union-optional-discriminator-=
invalid-specification.json
new file mode 100644
index 0000000000..d20a2cd295
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specifi=
cation.json
@@ -0,0 +1,11 @@
+# For using optional discriminators, only the field in the base struct
+# must be marked optional, not the discriminator name itself
+{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
+{ 'struct': 'Base',
+  'data': { '*switch': { 'type': 'Enum', 'default': 'one' } } }
+{ 'struct': 'Branch', 'data': { 'name': 'str' } }
+{ 'union': 'MyUnion',
+  'base': 'Base',
+  'discriminator': '*switch',
+  'data': { 'one': 'Branch',
+            'two': 'Branch' } }
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json b/t=
ests/qapi-schema/flat-union-optional-discriminator-no-default.json
similarity index 68%
rename from tests/qapi-schema/flat-union-optional-discriminator.json
rename to tests/qapi-schema/flat-union-optional-discriminator-no-default.=
json
index 08a8f7ef8b..31ebb85afb 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.json
+++ b/tests/qapi-schema/flat-union-optional-discriminator-no-default.json
@@ -1,10 +1,11 @@
-# we require the discriminator to be non-optional
+# Using an optional discriminator requires the respective field to
+# have a default
 { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
 { 'struct': 'Base',
   'data': { '*switch': 'Enum' } }
 { 'struct': 'Branch', 'data': { 'name': 'str' } }
 { 'union': 'MyUnion',
   'base': 'Base',
-  'discriminator': '*switch',
+  'discriminator': 'switch',
   'data': { 'one': 'Branch',
             'two': 'Branch' } }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 12ae387d46..0f4b123a82 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -104,6 +104,16 @@
 { 'struct': 'UserDefC',
   'data': { 'string1': 'str', 'string2': 'str' } }
=20
+# for testing unions with an optional discriminator
+{ 'union': 'UserDefFlatUnion3',
+  'base': { '*enum1': { 'type': 'EnumOne', 'default': 'value1' } },
+  'discriminator': 'enum1',
+  'data': { 'value1' : 'UserDefA',
+            'value2' : 'UserDefB',
+            'value3' : 'UserDefB'
+            # 'value4' defaults to empty
+  } }
+
 # for testing use of 'number' within alternates
 { 'alternate': 'AltEnumBool', 'data': { 'e': 'EnumOne', 'b': 'bool' } }
 { 'alternate': 'AltEnumNum', 'data': { 'e': 'EnumOne', 'n': 'number' } }
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-=
specification.err b/tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.err
new file mode 100644
index 0000000000..cbf154e726
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specifi=
cation.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-optional-discriminator-invalid-specificatio=
n.json:7: Discriminator of flat union 'MyUnion' does not allow optional n=
ame '*switch'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.exit b/t=
ests/qapi-schema/flat-union-optional-discriminator-invalid-specification.=
exit
similarity index 100%
rename from tests/qapi-schema/flat-union-optional-discriminator.exit
rename to tests/qapi-schema/flat-union-optional-discriminator-invalid-spe=
cification.exit
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.out b/te=
sts/qapi-schema/flat-union-optional-discriminator-invalid-specification.o=
ut
similarity index 100%
rename from tests/qapi-schema/flat-union-optional-discriminator.out
rename to tests/qapi-schema/flat-union-optional-discriminator-invalid-spe=
cification.out
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-no-defau=
lt.err b/tests/qapi-schema/flat-union-optional-discriminator-no-default.e=
rr
new file mode 100644
index 0000000000..5a022a0bc7
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-no-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-optional-discriminator-no-default.json:7: O=
ptional discriminator 'switch' has no default value
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-no-defau=
lt.exit b/tests/qapi-schema/flat-union-optional-discriminator-no-default.=
exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-no-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-no-defau=
lt.out b/tests/qapi-schema/flat-union-optional-discriminator-no-default.o=
ut
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err b/te=
sts/qapi-schema/flat-union-optional-discriminator.err
deleted file mode 100644
index aaabedb3bd..0000000000
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/flat-union-optional-discriminator.json:6: Discriminato=
r of flat union 'MyUnion' does not allow optional name '*switch'
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 724276f5de..3729736747 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -96,6 +96,15 @@ alternate UserDefAlternate
 object UserDefC
     member string1: str optional=3DFalse
     member string2: str optional=3DFalse
+object q_obj_UserDefFlatUnion3-base
+    member enum1: EnumOne optional=3DTrue default=3Dvalue1
+object UserDefFlatUnion3
+    base q_obj_UserDefFlatUnion3-base
+    tag enum1
+    case value1: UserDefA
+    case value2: UserDefB
+    case value3: UserDefB
+    case value4: q_empty
 alternate AltEnumBool
     tag type
     case e: EnumOne
--=20
2.21.0


