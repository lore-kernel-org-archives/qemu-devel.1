Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D19C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8A6217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8A6217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDslf-00004u-Jq
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iDqaQ-0001UP-SZ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iDqa5-00061x-4W
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iDqa4-00061C-LZ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E43C511A14;
 Fri, 27 Sep 2019 13:46:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0630600C6;
 Fri, 27 Sep 2019 13:46:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6DCEF11386A6; Fri, 27 Sep 2019 15:46:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/26] qapi: Prefix frontend errors with an "in definition"
 line
Date: Fri, 27 Sep 2019 15:46:17 +0200
Message-Id: <20190927134639.4284-5-armbru@redhat.com>
In-Reply-To: <20190927134639.4284-1-armbru@redhat.com>
References: <20190927134639.4284-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 27 Sep 2019 13:46:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We take pains to include the offending expression in error messages,
e.g.

    tests/qapi-schema/alternate-any.json:2: alternate 'Alt' member 'one' =
cannot use type 'any'

But not always:

    tests/qapi-schema/enum-if-invalid.json:2: 'if' condition must be a st=
ring or a list of strings

Instead of improving them one by one, report the offending expression
whenever it is known, like this:

    tests/qapi-schema/enum-if-invalid.json: In enum 'TestIfEnum':
    tests/qapi-schema/enum-if-invalid.json:2: 'if' condition must be a st=
ring or a list of strings

Error messages that mention the offending expression become a bit
redundant, e.g.

    tests/qapi-schema/alternate-any.json: In alternate 'Alt':
    tests/qapi-schema/alternate-any.json:2: alternate 'Alt' member 'one' =
cannot use type 'any'

I'll take care of that later in this series.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py                            | 15 ++++++++++++++-
 tests/qapi-schema/alternate-any.err               |  1 +
 tests/qapi-schema/alternate-array.err             |  1 +
 tests/qapi-schema/alternate-branch-if-invalid.err |  1 +
 tests/qapi-schema/alternate-clash.err             |  1 +
 .../alternate-conflict-bool-string.err            |  1 +
 tests/qapi-schema/alternate-conflict-dict.err     |  1 +
 .../qapi-schema/alternate-conflict-enum-bool.err  |  1 +
 tests/qapi-schema/alternate-conflict-enum-int.err |  1 +
 .../qapi-schema/alternate-conflict-num-string.err |  1 +
 tests/qapi-schema/alternate-conflict-string.err   |  1 +
 tests/qapi-schema/alternate-empty.err             |  1 +
 tests/qapi-schema/alternate-invalid-dict.err      |  1 +
 tests/qapi-schema/alternate-nested.err            |  1 +
 tests/qapi-schema/alternate-unknown.err           |  1 +
 tests/qapi-schema/args-alternate.err              |  1 +
 tests/qapi-schema/args-any.err                    |  1 +
 tests/qapi-schema/args-array-empty.err            |  1 +
 tests/qapi-schema/args-array-unknown.err          |  1 +
 tests/qapi-schema/args-boxed-anon.err             |  1 +
 tests/qapi-schema/args-boxed-string.err           |  1 +
 tests/qapi-schema/args-int.err                    |  1 +
 tests/qapi-schema/args-invalid.err                |  1 +
 tests/qapi-schema/args-member-array-bad.err       |  1 +
 tests/qapi-schema/args-member-case.err            |  1 +
 tests/qapi-schema/args-member-unknown.err         |  1 +
 tests/qapi-schema/args-name-clash.err             |  1 +
 tests/qapi-schema/args-union.err                  |  1 +
 tests/qapi-schema/args-unknown.err                |  1 +
 tests/qapi-schema/bad-base.err                    |  1 +
 tests/qapi-schema/bad-data.err                    |  1 +
 tests/qapi-schema/base-cycle-direct.err           |  1 +
 tests/qapi-schema/base-cycle-indirect.err         |  1 +
 tests/qapi-schema/doc-bad-symbol.err              |  1 +
 tests/qapi-schema/enum-bad-member.err             |  1 +
 tests/qapi-schema/enum-bad-name.err               |  1 +
 tests/qapi-schema/enum-bad-prefix.err             |  1 +
 tests/qapi-schema/enum-clash-member.err           |  1 +
 tests/qapi-schema/enum-dict-member-unknown.err    |  1 +
 tests/qapi-schema/enum-if-invalid.err             |  1 +
 tests/qapi-schema/enum-member-case.err            |  1 +
 tests/qapi-schema/enum-wrong-data.err             |  1 +
 tests/qapi-schema/event-boxed-empty.err           |  1 +
 tests/qapi-schema/event-member-invalid-dict.err   |  1 +
 tests/qapi-schema/event-nest-struct.err           |  1 +
 tests/qapi-schema/features-bad-type.err           |  1 +
 tests/qapi-schema/features-duplicate-name.err     |  1 +
 tests/qapi-schema/features-if-invalid.err         |  1 +
 tests/qapi-schema/features-missing-name.err       |  1 +
 tests/qapi-schema/features-name-bad-type.err      |  1 +
 tests/qapi-schema/features-no-list.err            |  1 +
 tests/qapi-schema/features-unknown-key.err        |  1 +
 tests/qapi-schema/flat-union-array-branch.err     |  1 +
 tests/qapi-schema/flat-union-bad-base.err         |  1 +
 .../qapi-schema/flat-union-bad-discriminator.err  |  1 +
 tests/qapi-schema/flat-union-base-any.err         |  1 +
 tests/qapi-schema/flat-union-base-union.err       |  1 +
 tests/qapi-schema/flat-union-clash-member.err     |  1 +
 .../flat-union-discriminator-bad-name.err         |  1 +
 tests/qapi-schema/flat-union-empty.err            |  1 +
 .../flat-union-inline-invalid-dict.err            |  1 +
 tests/qapi-schema/flat-union-inline.err           |  1 +
 tests/qapi-schema/flat-union-int-branch.err       |  1 +
 .../qapi-schema/flat-union-invalid-branch-key.err |  1 +
 .../flat-union-invalid-discriminator.err          |  1 +
 .../flat-union-invalid-if-discriminator.err       |  1 +
 tests/qapi-schema/flat-union-no-base.err          |  1 +
 .../flat-union-optional-discriminator.err         |  1 +
 .../flat-union-string-discriminator.err           |  1 +
 .../nested-struct-data-invalid-dict.err           |  1 +
 tests/qapi-schema/nested-struct-data.err          |  1 +
 tests/qapi-schema/reserved-enum-q.err             |  1 +
 tests/qapi-schema/reserved-member-has.err         |  1 +
 tests/qapi-schema/reserved-member-q.err           |  1 +
 tests/qapi-schema/reserved-member-u.err           |  1 +
 tests/qapi-schema/reserved-member-underscore.err  |  1 +
 tests/qapi-schema/returns-alternate.err           |  1 +
 tests/qapi-schema/returns-array-bad.err           |  1 +
 tests/qapi-schema/returns-dict.err                |  1 +
 tests/qapi-schema/returns-unknown.err             |  1 +
 tests/qapi-schema/returns-whitelist.err           |  1 +
 tests/qapi-schema/struct-base-clash-deep.err      |  1 +
 tests/qapi-schema/struct-base-clash.err           |  1 +
 tests/qapi-schema/struct-data-invalid.err         |  1 +
 tests/qapi-schema/struct-member-if-invalid.err    |  1 +
 tests/qapi-schema/struct-member-invalid-dict.err  |  1 +
 tests/qapi-schema/struct-member-invalid.err       |  1 +
 tests/qapi-schema/union-base-empty.err            |  1 +
 tests/qapi-schema/union-base-no-discriminator.err |  1 +
 tests/qapi-schema/union-branch-case.err           |  1 +
 tests/qapi-schema/union-branch-if-invalid.err     |  1 +
 tests/qapi-schema/union-branch-invalid-dict.err   |  1 +
 tests/qapi-schema/union-clash-branches.err        |  1 +
 tests/qapi-schema/union-empty.err                 |  1 +
 tests/qapi-schema/union-invalid-base.err          |  1 +
 tests/qapi-schema/union-optional-branch.err       |  1 +
 tests/qapi-schema/union-unknown.err               |  1 +
 97 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 5843f3eeb2..f0e7d5ad34 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -64,6 +64,12 @@ class QAPISourceInfo(object):
         self.fname =3D fname
         self.line =3D line
         self.parent =3D parent
+        self.defn_meta =3D None
+        self.defn_name =3D None
+
+    def set_defn(self, meta, name):
+        self.defn_meta =3D meta
+        self.defn_name =3D name
=20
     def next_line(self):
         info =3D copy.copy(self)
@@ -73,6 +79,12 @@ class QAPISourceInfo(object):
     def loc(self):
         return '%s:%d' % (self.fname, self.line)
=20
+    def in_defn(self):
+        if self.defn_name:
+            return "%s: In %s '%s':\n" % (self.fname,
+                                          self.defn_meta, self.defn_name=
)
+        return ''
+
     def include_path(self):
         ret =3D ''
         parent =3D self.parent
@@ -82,7 +94,7 @@ class QAPISourceInfo(object):
         return ret
=20
     def __str__(self):
-        return self.include_path() + self.loc()
+        return self.include_path() + self.in_defn() + self.loc()
=20
=20
 class QAPIError(Exception):
@@ -1127,6 +1139,7 @@ def check_exprs(exprs):
         normalize_if(expr)
         name =3D expr[meta]
         add_name(name, info, meta)
+        info.set_defn(meta, name)
         if doc and doc.symbol !=3D name:
             raise QAPISemError(info, "Definition of '%s' follows documen=
tation"
                                " for '%s'" % (name, doc.symbol))
diff --git a/tests/qapi-schema/alternate-any.err b/tests/qapi-schema/alte=
rnate-any.err
index aaa0154731..177a11cc12 100644
--- a/tests/qapi-schema/alternate-any.err
+++ b/tests/qapi-schema/alternate-any.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-any.json: In alternate 'Alt':
 tests/qapi-schema/alternate-any.json:2: Alternate 'Alt' member 'one' can=
not use type 'any'
diff --git a/tests/qapi-schema/alternate-array.err b/tests/qapi-schema/al=
ternate-array.err
index 7b930c64ab..f16f266c76 100644
--- a/tests/qapi-schema/alternate-array.err
+++ b/tests/qapi-schema/alternate-array.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-array.json: In alternate 'Alt':
 tests/qapi-schema/alternate-array.json:5: Member 'two' of alternate 'Alt=
' cannot be an array
diff --git a/tests/qapi-schema/alternate-branch-if-invalid.err b/tests/qa=
pi-schema/alternate-branch-if-invalid.err
index f1d6c10e00..8684829aca 100644
--- a/tests/qapi-schema/alternate-branch-if-invalid.err
+++ b/tests/qapi-schema/alternate-branch-if-invalid.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-branch-if-invalid.json: In alternate 'Alt':
 tests/qapi-schema/alternate-branch-if-invalid.json:2: 'if' condition ' '=
 makes no sense
diff --git a/tests/qapi-schema/alternate-clash.err b/tests/qapi-schema/al=
ternate-clash.err
index 604d8495eb..426ff6a7c4 100644
--- a/tests/qapi-schema/alternate-clash.err
+++ b/tests/qapi-schema/alternate-clash.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-clash.json: In alternate 'Alt1':
 tests/qapi-schema/alternate-clash.json:7: 'a_b' (branch of Alt1) collide=
s with 'a-b' (branch of Alt1)
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.err b/tests=
/qapi-schema/alternate-conflict-bool-string.err
index e52fee7620..edfd36b7ad 100644
--- a/tests/qapi-schema/alternate-conflict-bool-string.err
+++ b/tests/qapi-schema/alternate-conflict-bool-string.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-conflict-bool-string.json: In alternate 'Alt=
':
 tests/qapi-schema/alternate-conflict-bool-string.json:2: Alternate 'Alt'=
 member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-dict.err b/tests/qapi-s=
chema/alternate-conflict-dict.err
index 0f411f4faf..61ae93273a 100644
--- a/tests/qapi-schema/alternate-conflict-dict.err
+++ b/tests/qapi-schema/alternate-conflict-dict.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-conflict-dict.json: In alternate 'Alt':
 tests/qapi-schema/alternate-conflict-dict.json:6: Alternate 'Alt' member=
 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-bool.err b/tests/q=
api-schema/alternate-conflict-enum-bool.err
index 0dfc00242d..b006d1efbc 100644
--- a/tests/qapi-schema/alternate-conflict-enum-bool.err
+++ b/tests/qapi-schema/alternate-conflict-enum-bool.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-conflict-enum-bool.json: In alternate 'Alt':
 tests/qapi-schema/alternate-conflict-enum-bool.json:4: Alternate 'Alt' m=
ember 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-int.err b/tests/qa=
pi-schema/alternate-conflict-enum-int.err
index 2cc8e7b9aa..817b5c0191 100644
--- a/tests/qapi-schema/alternate-conflict-enum-int.err
+++ b/tests/qapi-schema/alternate-conflict-enum-int.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-conflict-enum-int.json: In alternate 'Alt':
 tests/qapi-schema/alternate-conflict-enum-int.json:4: Alternate 'Alt' me=
mber 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-num-string.err b/tests/=
qapi-schema/alternate-conflict-num-string.err
index 5ba3827dd1..abc188e0a6 100644
--- a/tests/qapi-schema/alternate-conflict-num-string.err
+++ b/tests/qapi-schema/alternate-conflict-num-string.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-conflict-num-string.json: In alternate 'Alt'=
:
 tests/qapi-schema/alternate-conflict-num-string.json:2: Alternate 'Alt' =
member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-string.err b/tests/qapi=
-schema/alternate-conflict-string.err
index fe2f188295..77ccd80cd7 100644
--- a/tests/qapi-schema/alternate-conflict-string.err
+++ b/tests/qapi-schema/alternate-conflict-string.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-conflict-string.json: In alternate 'Alt':
 tests/qapi-schema/alternate-conflict-string.json:2: Alternate 'Alt' memb=
er 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-empty.err b/tests/qapi-schema/al=
ternate-empty.err
index 86dbc666eb..9daac031e4 100644
--- a/tests/qapi-schema/alternate-empty.err
+++ b/tests/qapi-schema/alternate-empty.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-empty.json: In alternate 'Alt':
 tests/qapi-schema/alternate-empty.json:2: Alternate 'Alt' cannot have em=
pty 'data'
diff --git a/tests/qapi-schema/alternate-invalid-dict.err b/tests/qapi-sc=
hema/alternate-invalid-dict.err
index 631d46628e..701db8cdce 100644
--- a/tests/qapi-schema/alternate-invalid-dict.err
+++ b/tests/qapi-schema/alternate-invalid-dict.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-invalid-dict.json: In alternate 'Alt':
 tests/qapi-schema/alternate-invalid-dict.json:2: Key 'type' is missing f=
rom member 'two' of alternate 'Alt'
diff --git a/tests/qapi-schema/alternate-nested.err b/tests/qapi-schema/a=
lternate-nested.err
index 4d1187e60e..4ab5328025 100644
--- a/tests/qapi-schema/alternate-nested.err
+++ b/tests/qapi-schema/alternate-nested.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-nested.json: In alternate 'Alt2':
 tests/qapi-schema/alternate-nested.json:4: Member 'nested' of alternate =
'Alt2' cannot use alternate type 'Alt1'
diff --git a/tests/qapi-schema/alternate-unknown.err b/tests/qapi-schema/=
alternate-unknown.err
index dea45dc730..5bd473325e 100644
--- a/tests/qapi-schema/alternate-unknown.err
+++ b/tests/qapi-schema/alternate-unknown.err
@@ -1 +1,2 @@
+tests/qapi-schema/alternate-unknown.json: In alternate 'Alt':
 tests/qapi-schema/alternate-unknown.json:2: Member 'unknown' of alternat=
e 'Alt' uses unknown type 'MissingType'
diff --git a/tests/qapi-schema/args-alternate.err b/tests/qapi-schema/arg=
s-alternate.err
index 3086eae56b..915f5d463b 100644
--- a/tests/qapi-schema/args-alternate.err
+++ b/tests/qapi-schema/args-alternate.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-alternate.json: In command 'oops':
 tests/qapi-schema/args-alternate.json:3: 'data' for command 'oops' canno=
t use alternate type 'Alt'
diff --git a/tests/qapi-schema/args-any.err b/tests/qapi-schema/args-any.=
err
index bf9b5e0730..8c4f9aeef4 100644
--- a/tests/qapi-schema/args-any.err
+++ b/tests/qapi-schema/args-any.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-any.json: In command 'oops':
 tests/qapi-schema/args-any.json:2: 'data' for command 'oops' cannot use =
built-in type 'any'
diff --git a/tests/qapi-schema/args-array-empty.err b/tests/qapi-schema/a=
rgs-array-empty.err
index cb7ed33b3f..fb95f0c4de 100644
--- a/tests/qapi-schema/args-array-empty.err
+++ b/tests/qapi-schema/args-array-empty.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-array-empty.json: In command 'oops':
 tests/qapi-schema/args-array-empty.json:2: Member 'empty' of 'data' for =
command 'oops': array type must contain single type name
diff --git a/tests/qapi-schema/args-array-unknown.err b/tests/qapi-schema=
/args-array-unknown.err
index cd7a0f98d7..c88a5612b2 100644
--- a/tests/qapi-schema/args-array-unknown.err
+++ b/tests/qapi-schema/args-array-unknown.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-array-unknown.json: In command 'oops':
 tests/qapi-schema/args-array-unknown.json:2: Member 'array' of 'data' fo=
r command 'oops' uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/args-boxed-anon.err b/tests/qapi-schema/ar=
gs-boxed-anon.err
index f24f345218..27460e6c07 100644
--- a/tests/qapi-schema/args-boxed-anon.err
+++ b/tests/qapi-schema/args-boxed-anon.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-boxed-anon.json: In command 'foo':
 tests/qapi-schema/args-boxed-anon.json:2: 'data' for command 'foo' shoul=
d be a type name
diff --git a/tests/qapi-schema/args-boxed-string.err b/tests/qapi-schema/=
args-boxed-string.err
index d326b48aef..f284406f0f 100644
--- a/tests/qapi-schema/args-boxed-string.err
+++ b/tests/qapi-schema/args-boxed-string.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-boxed-string.json: In command 'foo':
 tests/qapi-schema/args-boxed-string.json:2: 'data' for command 'foo' can=
not use built-in type 'str'
diff --git a/tests/qapi-schema/args-int.err b/tests/qapi-schema/args-int.=
err
index dc1d2504ff..419268186e 100644
--- a/tests/qapi-schema/args-int.err
+++ b/tests/qapi-schema/args-int.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-int.json: In command 'oops':
 tests/qapi-schema/args-int.json:2: 'data' for command 'oops' cannot use =
built-in type 'int'
diff --git a/tests/qapi-schema/args-invalid.err b/tests/qapi-schema/args-=
invalid.err
index bfb2e4133e..212c2076fc 100644
--- a/tests/qapi-schema/args-invalid.err
+++ b/tests/qapi-schema/args-invalid.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-invalid.json: In command 'foo':
 tests/qapi-schema/args-invalid.json:1: 'data' for command 'foo' should b=
e an object or type name
diff --git a/tests/qapi-schema/args-member-array-bad.err b/tests/qapi-sch=
ema/args-member-array-bad.err
index 881b4d954f..81e1e95523 100644
--- a/tests/qapi-schema/args-member-array-bad.err
+++ b/tests/qapi-schema/args-member-array-bad.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-member-array-bad.json: In command 'oops':
 tests/qapi-schema/args-member-array-bad.json:2: Member 'member' of 'data=
' for command 'oops': array type must contain single type name
diff --git a/tests/qapi-schema/args-member-case.err b/tests/qapi-schema/a=
rgs-member-case.err
index 19c4426601..725ba16192 100644
--- a/tests/qapi-schema/args-member-case.err
+++ b/tests/qapi-schema/args-member-case.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-member-case.json: In command 'no-way-this-will-ge=
t-whitelisted':
 tests/qapi-schema/args-member-case.json:2: 'Arg' (parameter of no-way-th=
is-will-get-whitelisted) should not use uppercase
diff --git a/tests/qapi-schema/args-member-unknown.err b/tests/qapi-schem=
a/args-member-unknown.err
index f6f82828ce..9d43e54ca9 100644
--- a/tests/qapi-schema/args-member-unknown.err
+++ b/tests/qapi-schema/args-member-unknown.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-member-unknown.json: In command 'oops':
 tests/qapi-schema/args-member-unknown.json:2: Member 'member' of 'data' =
for command 'oops' uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/args-name-clash.err b/tests/qapi-schema/ar=
gs-name-clash.err
index d953e8d241..eeb4e1b4dd 100644
--- a/tests/qapi-schema/args-name-clash.err
+++ b/tests/qapi-schema/args-name-clash.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-name-clash.json: In command 'oops':
 tests/qapi-schema/args-name-clash.json:4: 'a_b' (parameter of oops) coll=
ides with 'a-b' (parameter of oops)
diff --git a/tests/qapi-schema/args-union.err b/tests/qapi-schema/args-un=
ion.err
index f8ad223dde..30a1534b4c 100644
--- a/tests/qapi-schema/args-union.err
+++ b/tests/qapi-schema/args-union.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-union.json: In command 'oops':
 tests/qapi-schema/args-union.json:3: 'data' for command 'oops' cannot us=
e union type 'Uni'
diff --git a/tests/qapi-schema/args-unknown.err b/tests/qapi-schema/args-=
unknown.err
index 4d91ec869f..cb835d7489 100644
--- a/tests/qapi-schema/args-unknown.err
+++ b/tests/qapi-schema/args-unknown.err
@@ -1 +1,2 @@
+tests/qapi-schema/args-unknown.json: In command 'oops':
 tests/qapi-schema/args-unknown.json:2: 'data' for command 'oops' uses un=
known type 'NoSuchType'
diff --git a/tests/qapi-schema/bad-base.err b/tests/qapi-schema/bad-base.=
err
index 154274bdd3..fdfd288f5c 100644
--- a/tests/qapi-schema/bad-base.err
+++ b/tests/qapi-schema/bad-base.err
@@ -1 +1,2 @@
+tests/qapi-schema/bad-base.json: In struct 'MyType':
 tests/qapi-schema/bad-base.json:3: 'base' for struct 'MyType' cannot use=
 union type 'Union'
diff --git a/tests/qapi-schema/bad-data.err b/tests/qapi-schema/bad-data.=
err
index 8523ac4f46..8ef6bbd2b5 100644
--- a/tests/qapi-schema/bad-data.err
+++ b/tests/qapi-schema/bad-data.err
@@ -1 +1,2 @@
+tests/qapi-schema/bad-data.json: In command 'oops':
 tests/qapi-schema/bad-data.json:2: 'data' for command 'oops' cannot be a=
n array
diff --git a/tests/qapi-schema/base-cycle-direct.err b/tests/qapi-schema/=
base-cycle-direct.err
index 9c68f6543d..52c21bc2b8 100644
--- a/tests/qapi-schema/base-cycle-direct.err
+++ b/tests/qapi-schema/base-cycle-direct.err
@@ -1 +1,2 @@
+tests/qapi-schema/base-cycle-direct.json: In struct 'Loopy':
 tests/qapi-schema/base-cycle-direct.json:2: Object Loopy contains itself
diff --git a/tests/qapi-schema/base-cycle-indirect.err b/tests/qapi-schem=
a/base-cycle-indirect.err
index fc92fe47f8..1f60cd78f6 100644
--- a/tests/qapi-schema/base-cycle-indirect.err
+++ b/tests/qapi-schema/base-cycle-indirect.err
@@ -1 +1,2 @@
+tests/qapi-schema/base-cycle-indirect.json: In struct 'Base1':
 tests/qapi-schema/base-cycle-indirect.json:2: Object Base1 contains itse=
lf
diff --git a/tests/qapi-schema/doc-bad-symbol.err b/tests/qapi-schema/doc=
-bad-symbol.err
index 8472030c79..375cdff939 100644
--- a/tests/qapi-schema/doc-bad-symbol.err
+++ b/tests/qapi-schema/doc-bad-symbol.err
@@ -1 +1,2 @@
+tests/qapi-schema/doc-bad-symbol.json: In command 'foo':
 tests/qapi-schema/doc-bad-symbol.json:6: Definition of 'foo' follows doc=
umentation for 'food'
diff --git a/tests/qapi-schema/enum-bad-member.err b/tests/qapi-schema/en=
um-bad-member.err
index 211db9e6fc..49e4160dc4 100644
--- a/tests/qapi-schema/enum-bad-member.err
+++ b/tests/qapi-schema/enum-bad-member.err
@@ -1 +1,2 @@
+tests/qapi-schema/enum-bad-member.json: In enum 'MyEnum':
 tests/qapi-schema/enum-bad-member.json:2: Member of enum 'MyEnum' requir=
es a string name
diff --git a/tests/qapi-schema/enum-bad-name.err b/tests/qapi-schema/enum=
-bad-name.err
index 26a09f84ad..3af7345792 100644
--- a/tests/qapi-schema/enum-bad-name.err
+++ b/tests/qapi-schema/enum-bad-name.err
@@ -1 +1,2 @@
+tests/qapi-schema/enum-bad-name.json: In enum 'MyEnum':
 tests/qapi-schema/enum-bad-name.json:3: Member of enum 'MyEnum' uses inv=
alid name 'not\possible'
diff --git a/tests/qapi-schema/enum-bad-prefix.err b/tests/qapi-schema/en=
um-bad-prefix.err
index 399f5f7af5..383ebaea7e 100644
--- a/tests/qapi-schema/enum-bad-prefix.err
+++ b/tests/qapi-schema/enum-bad-prefix.err
@@ -1 +1,2 @@
+tests/qapi-schema/enum-bad-prefix.json: In enum 'MyEnum':
 tests/qapi-schema/enum-bad-prefix.json:2: Enum 'MyEnum' requires a strin=
g for 'prefix'
diff --git a/tests/qapi-schema/enum-clash-member.err b/tests/qapi-schema/=
enum-clash-member.err
index 8238d2e807..26944f5e06 100644
--- a/tests/qapi-schema/enum-clash-member.err
+++ b/tests/qapi-schema/enum-clash-member.err
@@ -1 +1,2 @@
+tests/qapi-schema/enum-clash-member.json: In enum 'MyEnum':
 tests/qapi-schema/enum-clash-member.json:2: 'one_two' (value of MyEnum) =
collides with 'one-two' (value of MyEnum)
diff --git a/tests/qapi-schema/enum-dict-member-unknown.err b/tests/qapi-=
schema/enum-dict-member-unknown.err
index 7fd9c032bf..02952f472a 100644
--- a/tests/qapi-schema/enum-dict-member-unknown.err
+++ b/tests/qapi-schema/enum-dict-member-unknown.err
@@ -1,2 +1,3 @@
+tests/qapi-schema/enum-dict-member-unknown.json: In enum 'MyEnum':
 tests/qapi-schema/enum-dict-member-unknown.json:2: Unknown key 'bad-key'=
 in member of enum 'MyEnum'
 Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/enum-if-invalid.err b/tests/qapi-schema/en=
um-if-invalid.err
index 54c3cf887b..db9eb45b25 100644
--- a/tests/qapi-schema/enum-if-invalid.err
+++ b/tests/qapi-schema/enum-if-invalid.err
@@ -1 +1,2 @@
+tests/qapi-schema/enum-if-invalid.json: In enum 'TestIfEnum':
 tests/qapi-schema/enum-if-invalid.json:2: 'if' condition must be a strin=
g or a list of strings
diff --git a/tests/qapi-schema/enum-member-case.err b/tests/qapi-schema/e=
num-member-case.err
index 5d689e92d5..f6c872d3bf 100644
--- a/tests/qapi-schema/enum-member-case.err
+++ b/tests/qapi-schema/enum-member-case.err
@@ -1 +1,2 @@
+tests/qapi-schema/enum-member-case.json: In enum 'NoWayThisWillGetWhitel=
isted':
 tests/qapi-schema/enum-member-case.json:4: 'Value' (value of NoWayThisWi=
llGetWhitelisted) should not use uppercase
diff --git a/tests/qapi-schema/enum-wrong-data.err b/tests/qapi-schema/en=
um-wrong-data.err
index 11b43471cf..4ab0c44e48 100644
--- a/tests/qapi-schema/enum-wrong-data.err
+++ b/tests/qapi-schema/enum-wrong-data.err
@@ -1 +1,2 @@
+tests/qapi-schema/enum-wrong-data.json: In enum 'MyEnum':
 tests/qapi-schema/enum-wrong-data.json:2: Enum 'MyEnum' requires an arra=
y for 'data'
diff --git a/tests/qapi-schema/event-boxed-empty.err b/tests/qapi-schema/=
event-boxed-empty.err
index 68ec6f2d2b..6ccbdf7b22 100644
--- a/tests/qapi-schema/event-boxed-empty.err
+++ b/tests/qapi-schema/event-boxed-empty.err
@@ -1 +1,2 @@
+tests/qapi-schema/event-boxed-empty.json: In event 'FOO':
 tests/qapi-schema/event-boxed-empty.json:2: Use of 'boxed' requires 'dat=
a'
diff --git a/tests/qapi-schema/event-member-invalid-dict.err b/tests/qapi=
-schema/event-member-invalid-dict.err
index 1a57fa29b0..9981a48b81 100644
--- a/tests/qapi-schema/event-member-invalid-dict.err
+++ b/tests/qapi-schema/event-member-invalid-dict.err
@@ -1 +1,2 @@
+tests/qapi-schema/event-member-invalid-dict.json: In event 'EVENT_A':
 tests/qapi-schema/event-member-invalid-dict.json:1: Key 'type' is missin=
g from member 'a' of 'data' for event 'EVENT_A'
diff --git a/tests/qapi-schema/event-nest-struct.err b/tests/qapi-schema/=
event-nest-struct.err
index 5a42701b8f..2dd57f1784 100644
--- a/tests/qapi-schema/event-nest-struct.err
+++ b/tests/qapi-schema/event-nest-struct.err
@@ -1 +1,2 @@
+tests/qapi-schema/event-nest-struct.json: In event 'EVENT_A':
 tests/qapi-schema/event-nest-struct.json:1: Member 'a' of 'data' for eve=
nt 'EVENT_A' should be a type name
diff --git a/tests/qapi-schema/features-bad-type.err b/tests/qapi-schema/=
features-bad-type.err
index 5fb95c2f90..a08485387a 100644
--- a/tests/qapi-schema/features-bad-type.err
+++ b/tests/qapi-schema/features-bad-type.err
@@ -1 +1,2 @@
+tests/qapi-schema/features-bad-type.json: In struct 'FeatureStruct0':
 tests/qapi-schema/features-bad-type.json:1: Feature of struct FeatureStr=
uct0 requires a string name
diff --git a/tests/qapi-schema/features-duplicate-name.err b/tests/qapi-s=
chema/features-duplicate-name.err
index c0a4cccae6..0ebec8e4b0 100644
--- a/tests/qapi-schema/features-duplicate-name.err
+++ b/tests/qapi-schema/features-duplicate-name.err
@@ -1 +1,2 @@
+tests/qapi-schema/features-duplicate-name.json: In struct 'FeatureStruct=
0':
 tests/qapi-schema/features-duplicate-name.json:1: 'foo' (feature of Feat=
ureStruct0) collides with 'foo' (feature of FeatureStruct0)
diff --git a/tests/qapi-schema/features-if-invalid.err b/tests/qapi-schem=
a/features-if-invalid.err
index 295800b4fc..90f4119ae7 100644
--- a/tests/qapi-schema/features-if-invalid.err
+++ b/tests/qapi-schema/features-if-invalid.err
@@ -1 +1,2 @@
+tests/qapi-schema/features-if-invalid.json: In struct 'Stru':
 tests/qapi-schema/features-if-invalid.json:2: 'if' condition must be a s=
tring or a list of strings
diff --git a/tests/qapi-schema/features-missing-name.err b/tests/qapi-sch=
ema/features-missing-name.err
index 4f1d2715aa..d445936b0c 100644
--- a/tests/qapi-schema/features-missing-name.err
+++ b/tests/qapi-schema/features-missing-name.err
@@ -1 +1,2 @@
+tests/qapi-schema/features-missing-name.json: In struct 'FeatureStruct0'=
:
 tests/qapi-schema/features-missing-name.json:1: Key 'name' is missing fr=
om feature of struct FeatureStruct0
diff --git a/tests/qapi-schema/features-name-bad-type.err b/tests/qapi-sc=
hema/features-name-bad-type.err
index 8a3eecb972..cc4bd33e7f 100644
--- a/tests/qapi-schema/features-name-bad-type.err
+++ b/tests/qapi-schema/features-name-bad-type.err
@@ -1 +1,2 @@
+tests/qapi-schema/features-name-bad-type.json: In struct 'FeatureStruct0=
':
 tests/qapi-schema/features-name-bad-type.json:1: Feature of struct Featu=
reStruct0 requires a string name
diff --git a/tests/qapi-schema/features-no-list.err b/tests/qapi-schema/f=
eatures-no-list.err
index 61ed68612b..663d9cd158 100644
--- a/tests/qapi-schema/features-no-list.err
+++ b/tests/qapi-schema/features-no-list.err
@@ -1 +1,2 @@
+tests/qapi-schema/features-no-list.json: In struct 'FeatureStruct0':
 tests/qapi-schema/features-no-list.json:1: Struct 'FeatureStruct0' requi=
res an array for 'features'
diff --git a/tests/qapi-schema/features-unknown-key.err b/tests/qapi-sche=
ma/features-unknown-key.err
index a1d693030d..2aeca4c1a6 100644
--- a/tests/qapi-schema/features-unknown-key.err
+++ b/tests/qapi-schema/features-unknown-key.err
@@ -1,2 +1,3 @@
+tests/qapi-schema/features-unknown-key.json: In struct 'FeatureStruct0':
 tests/qapi-schema/features-unknown-key.json:1: Unknown key 'colour' in f=
eature of struct FeatureStruct0
 Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/flat-union-array-branch.err b/tests/qapi-s=
chema/flat-union-array-branch.err
index 8ea91eadb2..13b4e60658 100644
--- a/tests/qapi-schema/flat-union-array-branch.err
+++ b/tests/qapi-schema/flat-union-array-branch.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-array-branch.json: In union 'TestUnion':
 tests/qapi-schema/flat-union-array-branch.json:8: Member 'value1' of uni=
on 'TestUnion' cannot be an array
diff --git a/tests/qapi-schema/flat-union-bad-base.err b/tests/qapi-schem=
a/flat-union-bad-base.err
index bee24a217a..ae8adc3947 100644
--- a/tests/qapi-schema/flat-union-bad-base.err
+++ b/tests/qapi-schema/flat-union-bad-base.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-bad-base.json: In union 'TestUnion':
 tests/qapi-schema/flat-union-bad-base.json:8: 'string' (member of TestTy=
peA) collides with 'string' (base of TestUnion)
diff --git a/tests/qapi-schema/flat-union-bad-discriminator.err b/tests/q=
api-schema/flat-union-bad-discriminator.err
index c38cc8e4df..9b3746343f 100644
--- a/tests/qapi-schema/flat-union-bad-discriminator.err
+++ b/tests/qapi-schema/flat-union-bad-discriminator.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-bad-discriminator.json: In union 'TestUnion=
':
 tests/qapi-schema/flat-union-bad-discriminator.json:11: Discriminator of=
 flat union 'TestUnion' requires a string name
diff --git a/tests/qapi-schema/flat-union-base-any.err b/tests/qapi-schem=
a/flat-union-base-any.err
index 646f1c9cd1..039b9a68b9 100644
--- a/tests/qapi-schema/flat-union-base-any.err
+++ b/tests/qapi-schema/flat-union-base-any.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-base-any.json: In union 'TestUnion':
 tests/qapi-schema/flat-union-base-any.json:8: 'base' for union 'TestUnio=
n' cannot use built-in type 'any'
diff --git a/tests/qapi-schema/flat-union-base-union.err b/tests/qapi-sch=
ema/flat-union-base-union.err
index f138395e45..93ab91378f 100644
--- a/tests/qapi-schema/flat-union-base-union.err
+++ b/tests/qapi-schema/flat-union-base-union.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-base-union.json: In union 'TestUnion':
 tests/qapi-schema/flat-union-base-union.json:14: 'base' for union 'TestU=
nion' cannot use union type 'UnionBase'
diff --git a/tests/qapi-schema/flat-union-clash-member.err b/tests/qapi-s=
chema/flat-union-clash-member.err
index 2adf69755a..48e939db19 100644
--- a/tests/qapi-schema/flat-union-clash-member.err
+++ b/tests/qapi-schema/flat-union-clash-member.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-clash-member.json: In union 'TestUnion':
 tests/qapi-schema/flat-union-clash-member.json:11: 'name' (member of Bra=
nch1) collides with 'name' (member of Base)
diff --git a/tests/qapi-schema/flat-union-discriminator-bad-name.err b/te=
sts/qapi-schema/flat-union-discriminator-bad-name.err
index 7238d126ca..72dc328bad 100644
--- a/tests/qapi-schema/flat-union-discriminator-bad-name.err
+++ b/tests/qapi-schema/flat-union-discriminator-bad-name.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-discriminator-bad-name.json: In union 'MyUn=
ion':
 tests/qapi-schema/flat-union-discriminator-bad-name.json:7: Discriminato=
r of flat union 'MyUnion' does not allow optional name '*switch'
diff --git a/tests/qapi-schema/flat-union-empty.err b/tests/qapi-schema/f=
lat-union-empty.err
index fedbc0d1cf..3fa79a6a47 100644
--- a/tests/qapi-schema/flat-union-empty.err
+++ b/tests/qapi-schema/flat-union-empty.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-empty.json: In union 'Union':
 tests/qapi-schema/flat-union-empty.json:4: Union 'Union' has no branches
diff --git a/tests/qapi-schema/flat-union-inline-invalid-dict.err b/tests=
/qapi-schema/flat-union-inline-invalid-dict.err
index 9c4c45b7f0..3716c02a9b 100644
--- a/tests/qapi-schema/flat-union-inline-invalid-dict.err
+++ b/tests/qapi-schema/flat-union-inline-invalid-dict.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-inline-invalid-dict.json: In union 'TestUni=
on':
 tests/qapi-schema/flat-union-inline-invalid-dict.json:7: Key 'type' is m=
issing from member 'value1' of union 'TestUnion'
diff --git a/tests/qapi-schema/flat-union-inline.err b/tests/qapi-schema/=
flat-union-inline.err
index 2333358d28..0a7a94b03f 100644
--- a/tests/qapi-schema/flat-union-inline.err
+++ b/tests/qapi-schema/flat-union-inline.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-inline.json: In union 'TestUnion':
 tests/qapi-schema/flat-union-inline.json:7: Member 'value1' of union 'Te=
stUnion' should be a type name
diff --git a/tests/qapi-schema/flat-union-int-branch.err b/tests/qapi-sch=
ema/flat-union-int-branch.err
index faf01573b7..075751bcf6 100644
--- a/tests/qapi-schema/flat-union-int-branch.err
+++ b/tests/qapi-schema/flat-union-int-branch.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-int-branch.json: In union 'TestUnion':
 tests/qapi-schema/flat-union-int-branch.json:8: Member 'value1' of union=
 'TestUnion' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.err b/tests/=
qapi-schema/flat-union-invalid-branch-key.err
index ccf72d2dfe..a4d0e3ee66 100644
--- a/tests/qapi-schema/flat-union-invalid-branch-key.err
+++ b/tests/qapi-schema/flat-union-invalid-branch-key.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-invalid-branch-key.json: In union 'TestUnio=
n':
 tests/qapi-schema/flat-union-invalid-branch-key.json:13: Discriminator v=
alue 'value_wrong' is not found in enum 'TestEnum'
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.err b/tes=
ts/qapi-schema/flat-union-invalid-discriminator.err
index 495d5a520e..ca9a413dae 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-invalid-discriminator.json: In union 'TestU=
nion':
 tests/qapi-schema/flat-union-invalid-discriminator.json:10: Discriminato=
r 'enum_wrong' is not a member of 'base'
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.err b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.err
index cc5c3fb80b..c06307db98 100644
--- a/tests/qapi-schema/flat-union-invalid-if-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-invalid-if-discriminator.json: In union 'Te=
stUnion':
 tests/qapi-schema/flat-union-invalid-if-discriminator.json:10: The discr=
iminator 'enum1' for union TestUnion must not be conditional
diff --git a/tests/qapi-schema/flat-union-no-base.err b/tests/qapi-schema=
/flat-union-no-base.err
index 841c93b554..6e2035495c 100644
--- a/tests/qapi-schema/flat-union-no-base.err
+++ b/tests/qapi-schema/flat-union-no-base.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-no-base.json: In union 'TestUnion':
 tests/qapi-schema/flat-union-no-base.json:9: Flat union 'TestUnion' must=
 have a base
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err b/te=
sts/qapi-schema/flat-union-optional-discriminator.err
index 45f5407c34..db268fffaa 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ b/tests/qapi-schema/flat-union-optional-discriminator.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-optional-discriminator.json: In union 'MyUn=
ion':
 tests/qapi-schema/flat-union-optional-discriminator.json:7: Discriminato=
r 'switch' is not a member of 'base'
diff --git a/tests/qapi-schema/flat-union-string-discriminator.err b/test=
s/qapi-schema/flat-union-string-discriminator.err
index 200016bd5c..9bca7082bb 100644
--- a/tests/qapi-schema/flat-union-string-discriminator.err
+++ b/tests/qapi-schema/flat-union-string-discriminator.err
@@ -1 +1,2 @@
+tests/qapi-schema/flat-union-string-discriminator.json: In union 'TestUn=
ion':
 tests/qapi-schema/flat-union-string-discriminator.json:13: Discriminator=
 'kind' must be of enumeration type
diff --git a/tests/qapi-schema/nested-struct-data-invalid-dict.err b/test=
s/qapi-schema/nested-struct-data-invalid-dict.err
index 5bd364e8d9..4d9c9b491a 100644
--- a/tests/qapi-schema/nested-struct-data-invalid-dict.err
+++ b/tests/qapi-schema/nested-struct-data-invalid-dict.err
@@ -1 +1,2 @@
+tests/qapi-schema/nested-struct-data-invalid-dict.json: In command 'foo'=
:
 tests/qapi-schema/nested-struct-data-invalid-dict.json:2: Key 'type' is =
missing from member 'a' of 'data' for command 'foo'
diff --git a/tests/qapi-schema/nested-struct-data.err b/tests/qapi-schema=
/nested-struct-data.err
index da767bade2..74d44ab111 100644
--- a/tests/qapi-schema/nested-struct-data.err
+++ b/tests/qapi-schema/nested-struct-data.err
@@ -1 +1,2 @@
+tests/qapi-schema/nested-struct-data.json: In command 'foo':
 tests/qapi-schema/nested-struct-data.json:2: Member 'a' of 'data' for co=
mmand 'foo' should be a type name
diff --git a/tests/qapi-schema/reserved-enum-q.err b/tests/qapi-schema/re=
served-enum-q.err
index e1c3480ee2..e3eecd29dc 100644
--- a/tests/qapi-schema/reserved-enum-q.err
+++ b/tests/qapi-schema/reserved-enum-q.err
@@ -1 +1,2 @@
+tests/qapi-schema/reserved-enum-q.json: In enum 'Foo':
 tests/qapi-schema/reserved-enum-q.json:4: Member of enum 'Foo' uses inva=
lid name 'q-Unix'
diff --git a/tests/qapi-schema/reserved-member-has.err b/tests/qapi-schem=
a/reserved-member-has.err
index e755771446..2c6d0418db 100644
--- a/tests/qapi-schema/reserved-member-has.err
+++ b/tests/qapi-schema/reserved-member-has.err
@@ -1 +1,2 @@
+tests/qapi-schema/reserved-member-has.json: In command 'oops':
 tests/qapi-schema/reserved-member-has.json:5: Member of 'data' for comma=
nd 'oops' uses reserved name 'has-a'
diff --git a/tests/qapi-schema/reserved-member-q.err b/tests/qapi-schema/=
reserved-member-q.err
index f3d5dd7818..eaabe579bc 100644
--- a/tests/qapi-schema/reserved-member-q.err
+++ b/tests/qapi-schema/reserved-member-q.err
@@ -1 +1,2 @@
+tests/qapi-schema/reserved-member-q.json: In struct 'Foo':
 tests/qapi-schema/reserved-member-q.json:4: Member of 'data' for struct =
'Foo' uses invalid name 'q-unix'
diff --git a/tests/qapi-schema/reserved-member-u.err b/tests/qapi-schema/=
reserved-member-u.err
index 87d42296cc..b01629da29 100644
--- a/tests/qapi-schema/reserved-member-u.err
+++ b/tests/qapi-schema/reserved-member-u.err
@@ -1 +1,2 @@
+tests/qapi-schema/reserved-member-u.json: In struct 'Oops':
 tests/qapi-schema/reserved-member-u.json:7: Member of 'data' for struct =
'Oops' uses reserved name 'u'
diff --git a/tests/qapi-schema/reserved-member-underscore.err b/tests/qap=
i-schema/reserved-member-underscore.err
index 65ff0da8ce..6089cc1d3b 100644
--- a/tests/qapi-schema/reserved-member-underscore.err
+++ b/tests/qapi-schema/reserved-member-underscore.err
@@ -1 +1,2 @@
+tests/qapi-schema/reserved-member-underscore.json: In struct 'Oops':
 tests/qapi-schema/reserved-member-underscore.json:4: Member of 'data' fo=
r struct 'Oops' uses invalid name '_oops'
diff --git a/tests/qapi-schema/returns-alternate.err b/tests/qapi-schema/=
returns-alternate.err
index dfbb419cac..b98cf84cef 100644
--- a/tests/qapi-schema/returns-alternate.err
+++ b/tests/qapi-schema/returns-alternate.err
@@ -1 +1,2 @@
+tests/qapi-schema/returns-alternate.json: In command 'oops':
 tests/qapi-schema/returns-alternate.json:3: 'returns' for command 'oops'=
 cannot use alternate type 'Alt'
diff --git a/tests/qapi-schema/returns-array-bad.err b/tests/qapi-schema/=
returns-array-bad.err
index 138095ccde..6295ba89c0 100644
--- a/tests/qapi-schema/returns-array-bad.err
+++ b/tests/qapi-schema/returns-array-bad.err
@@ -1 +1,2 @@
+tests/qapi-schema/returns-array-bad.json: In command 'oops':
 tests/qapi-schema/returns-array-bad.json:2: 'returns' for command 'oops'=
: array type must contain single type name
diff --git a/tests/qapi-schema/returns-dict.err b/tests/qapi-schema/retur=
ns-dict.err
index eb2d0c4661..7329b9526f 100644
--- a/tests/qapi-schema/returns-dict.err
+++ b/tests/qapi-schema/returns-dict.err
@@ -1 +1,2 @@
+tests/qapi-schema/returns-dict.json: In command 'oops':
 tests/qapi-schema/returns-dict.json:2: 'returns' for command 'oops' shou=
ld be a type name
diff --git a/tests/qapi-schema/returns-unknown.err b/tests/qapi-schema/re=
turns-unknown.err
index 1f43e3ac9f..cbece00bd2 100644
--- a/tests/qapi-schema/returns-unknown.err
+++ b/tests/qapi-schema/returns-unknown.err
@@ -1 +1,2 @@
+tests/qapi-schema/returns-unknown.json: In command 'oops':
 tests/qapi-schema/returns-unknown.json:2: 'returns' for command 'oops' u=
ses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/returns-whitelist.err b/tests/qapi-schema/=
returns-whitelist.err
index b2ba7a9deb..1ccd7d8de2 100644
--- a/tests/qapi-schema/returns-whitelist.err
+++ b/tests/qapi-schema/returns-whitelist.err
@@ -1 +1,2 @@
+tests/qapi-schema/returns-whitelist.json: In command 'no-way-this-will-g=
et-whitelisted':
 tests/qapi-schema/returns-whitelist.json:14: 'returns' for command 'no-w=
ay-this-will-get-whitelisted' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/struct-base-clash-deep.err b/tests/qapi-sc=
hema/struct-base-clash-deep.err
index e2d7943f21..53e9bb108e 100644
--- a/tests/qapi-schema/struct-base-clash-deep.err
+++ b/tests/qapi-schema/struct-base-clash-deep.err
@@ -1 +1,2 @@
+tests/qapi-schema/struct-base-clash-deep.json: In struct 'Sub':
 tests/qapi-schema/struct-base-clash-deep.json:10: 'name' (member of Sub)=
 collides with 'name' (member of Base)
diff --git a/tests/qapi-schema/struct-base-clash.err b/tests/qapi-schema/=
struct-base-clash.err
index c52f33d27b..bf94eee8b3 100644
--- a/tests/qapi-schema/struct-base-clash.err
+++ b/tests/qapi-schema/struct-base-clash.err
@@ -1 +1,2 @@
+tests/qapi-schema/struct-base-clash.json: In struct 'Sub':
 tests/qapi-schema/struct-base-clash.json:5: 'name' (member of Sub) colli=
des with 'name' (member of Base)
diff --git a/tests/qapi-schema/struct-data-invalid.err b/tests/qapi-schem=
a/struct-data-invalid.err
index 4bf5bcc255..a88754869f 100644
--- a/tests/qapi-schema/struct-data-invalid.err
+++ b/tests/qapi-schema/struct-data-invalid.err
@@ -1 +1,2 @@
+tests/qapi-schema/struct-data-invalid.json: In struct 'foo':
 tests/qapi-schema/struct-data-invalid.json:1: 'data' for struct 'foo' sh=
ould be an object or type name
diff --git a/tests/qapi-schema/struct-member-if-invalid.err b/tests/qapi-=
schema/struct-member-if-invalid.err
index bfd65db97b..e8ad02b9fc 100644
--- a/tests/qapi-schema/struct-member-if-invalid.err
+++ b/tests/qapi-schema/struct-member-if-invalid.err
@@ -1 +1,2 @@
+tests/qapi-schema/struct-member-if-invalid.json: In struct 'Stru':
 tests/qapi-schema/struct-member-if-invalid.json:2: 'if' condition must b=
e a string or a list of strings
diff --git a/tests/qapi-schema/struct-member-invalid-dict.err b/tests/qap=
i-schema/struct-member-invalid-dict.err
index 6a765bc668..e8b0ee72e0 100644
--- a/tests/qapi-schema/struct-member-invalid-dict.err
+++ b/tests/qapi-schema/struct-member-invalid-dict.err
@@ -1 +1,2 @@
+tests/qapi-schema/struct-member-invalid-dict.json: In struct 'foo':
 tests/qapi-schema/struct-member-invalid-dict.json:2: Key 'type' is missi=
ng from member '*a' of 'data' for struct 'foo'
diff --git a/tests/qapi-schema/struct-member-invalid.err b/tests/qapi-sch=
ema/struct-member-invalid.err
index 69a326d450..466c1af1d0 100644
--- a/tests/qapi-schema/struct-member-invalid.err
+++ b/tests/qapi-schema/struct-member-invalid.err
@@ -1 +1,2 @@
+tests/qapi-schema/struct-member-invalid.json: In struct 'foo':
 tests/qapi-schema/struct-member-invalid.json:1: Member 'a' of 'data' for=
 struct 'foo' should be a type name
diff --git a/tests/qapi-schema/union-base-empty.err b/tests/qapi-schema/u=
nion-base-empty.err
index 9453720ede..1e24341819 100644
--- a/tests/qapi-schema/union-base-empty.err
+++ b/tests/qapi-schema/union-base-empty.err
@@ -1 +1,2 @@
+tests/qapi-schema/union-base-empty.json: In union 'TestUnion':
 tests/qapi-schema/union-base-empty.json:5: Discriminator 'type' is not a=
 member of 'base'
diff --git a/tests/qapi-schema/union-base-no-discriminator.err b/tests/qa=
pi-schema/union-base-no-discriminator.err
index 8b7a24260f..fa9343fb8e 100644
--- a/tests/qapi-schema/union-base-no-discriminator.err
+++ b/tests/qapi-schema/union-base-no-discriminator.err
@@ -1 +1,2 @@
+tests/qapi-schema/union-base-no-discriminator.json: In union 'TestUnion'=
:
 tests/qapi-schema/union-base-no-discriminator.json:11: Simple union 'Tes=
tUnion' must not have a base
diff --git a/tests/qapi-schema/union-branch-case.err b/tests/qapi-schema/=
union-branch-case.err
index 11521901d8..8e81a2d0b6 100644
--- a/tests/qapi-schema/union-branch-case.err
+++ b/tests/qapi-schema/union-branch-case.err
@@ -1 +1,2 @@
+tests/qapi-schema/union-branch-case.json: In union 'NoWayThisWillGetWhit=
elisted':
 tests/qapi-schema/union-branch-case.json:2: 'Branch' (branch of NoWayThi=
sWillGetWhitelisted) should not use uppercase
diff --git a/tests/qapi-schema/union-branch-if-invalid.err b/tests/qapi-s=
chema/union-branch-if-invalid.err
index 607edee382..b49cf9b664 100644
--- a/tests/qapi-schema/union-branch-if-invalid.err
+++ b/tests/qapi-schema/union-branch-if-invalid.err
@@ -1 +1,2 @@
+tests/qapi-schema/union-branch-if-invalid.json: In union 'Uni':
 tests/qapi-schema/union-branch-if-invalid.json:4: 'if' condition '' make=
s no sense
diff --git a/tests/qapi-schema/union-branch-invalid-dict.err b/tests/qapi=
-schema/union-branch-invalid-dict.err
index 89f9b36791..5b8b68432c 100644
--- a/tests/qapi-schema/union-branch-invalid-dict.err
+++ b/tests/qapi-schema/union-branch-invalid-dict.err
@@ -1 +1,2 @@
+tests/qapi-schema/union-branch-invalid-dict.json: In union 'UnionInvalid=
Branch':
 tests/qapi-schema/union-branch-invalid-dict.json:2: Key 'type' is missin=
g from member 'integer' of union 'UnionInvalidBranch'
diff --git a/tests/qapi-schema/union-clash-branches.err b/tests/qapi-sche=
ma/union-clash-branches.err
index e5b21135bb..145efebd9f 100644
--- a/tests/qapi-schema/union-clash-branches.err
+++ b/tests/qapi-schema/union-clash-branches.err
@@ -1 +1,2 @@
+tests/qapi-schema/union-clash-branches.json: In union 'TestUnion':
 tests/qapi-schema/union-clash-branches.json:4: 'a_b' (branch of TestUnio=
n) collides with 'a-b' (branch of TestUnion)
diff --git a/tests/qapi-schema/union-empty.err b/tests/qapi-schema/union-=
empty.err
index d4241a38a2..75f2fa9f21 100644
--- a/tests/qapi-schema/union-empty.err
+++ b/tests/qapi-schema/union-empty.err
@@ -1 +1,2 @@
+tests/qapi-schema/union-empty.json: In union 'Union':
 tests/qapi-schema/union-empty.json:2: Union 'Union' has no branches
diff --git a/tests/qapi-schema/union-invalid-base.err b/tests/qapi-schema=
/union-invalid-base.err
index 03d7b97a93..be908709d2 100644
--- a/tests/qapi-schema/union-invalid-base.err
+++ b/tests/qapi-schema/union-invalid-base.err
@@ -1 +1,2 @@
+tests/qapi-schema/union-invalid-base.json: In union 'TestUnion':
 tests/qapi-schema/union-invalid-base.json:8: 'base' for union 'TestUnion=
' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/union-optional-branch.err b/tests/qapi-sch=
ema/union-optional-branch.err
index 3ada1334dc..09320416ad 100644
--- a/tests/qapi-schema/union-optional-branch.err
+++ b/tests/qapi-schema/union-optional-branch.err
@@ -1 +1,2 @@
+tests/qapi-schema/union-optional-branch.json: In union 'Union':
 tests/qapi-schema/union-optional-branch.json:2: Member of union 'Union' =
does not allow optional name '*a'
diff --git a/tests/qapi-schema/union-unknown.err b/tests/qapi-schema/unio=
n-unknown.err
index 54fe456f9c..7c6cabb8cc 100644
--- a/tests/qapi-schema/union-unknown.err
+++ b/tests/qapi-schema/union-unknown.err
@@ -1 +1,2 @@
+tests/qapi-schema/union-unknown.json: In union 'Union':
 tests/qapi-schema/union-unknown.json:2: Member 'unknown' of union 'Union=
' uses unknown type 'MissingType'
--=20
2.21.0


