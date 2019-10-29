Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9784CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C21820874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYsEcdJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C21820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOra-00042u-D2
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeM-0005k4-Vf
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOeL-0001NL-G5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54926
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOeL-0001Mm-CP
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4K2pw9yJ4rE0TJ0CRG2LsovM4oBhSjTvDmaaCufiYw=;
 b=OYsEcdJn32uwi8hchvxQWOtkTeu+yvAS/QQtYuJJTsPl0g5r56113imdNp6KhFmybqtxXR
 NcStxho6lgfKP0bXqUlepQEp90gDc7HApEJs/44WkRPTEJ5gJ75gl3RjzaBjZ1Y6wAf/42
 wPSLTW1Hw80KIalCUvLWBBqQgGZaVfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-tSPyS3JtOgmfRhnQjziNng-1; Tue, 29 Oct 2019 06:22:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D258F801E64
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2C32600F0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B37F111326F0; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/19] qapi: Polish reporting of bogus member documentation
Date: Tue, 29 Oct 2019 11:22:27 +0100
Message-Id: <20191029102228.20740-19-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tSPyS3JtOgmfRhnQjziNng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve error messages from

    the following documented members are not in the declaration: a
    the following documented members are not in the declaration: aa, bb

to the more concise

    documented member 'a' does not exist
    documented members 'aa', 'bb' do not exist

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-19-armbru@redhat.com>
---
 scripts/qapi/parser.py                          | 6 ++++--
 tests/qapi-schema/doc-bad-alternate-member.err  | 2 +-
 tests/qapi-schema/doc-bad-boxed-command-arg.err | 2 +-
 tests/qapi-schema/doc-bad-command-arg.err       | 2 +-
 tests/qapi-schema/doc-bad-enum-member.err       | 2 +-
 tests/qapi-schema/doc-bad-event-arg.err         | 2 +-
 tests/qapi-schema/doc-bad-union-member.err      | 2 +-
 7 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index e800876ad1..6c45a00cf4 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -566,5 +566,7 @@ class QAPIDoc(object):
         if bogus:
             raise QAPISemError(
                 self.info,
-                "the following documented members are not in "
-                "the declaration: %s" % ", ".join(bogus))
+                "documented member%s '%s' %s not exist"
+                % ("s" if len(bogus) > 1 else "",
+                   "', '".join(bogus),
+                   "do" if len(bogus) > 1 else "does"))
diff --git a/tests/qapi-schema/doc-bad-alternate-member.err b/tests/qapi-sc=
hema/doc-bad-alternate-member.err
index a1c282f935..d7286bb57c 100644
--- a/tests/qapi-schema/doc-bad-alternate-member.err
+++ b/tests/qapi-schema/doc-bad-alternate-member.err
@@ -1 +1 @@
-doc-bad-alternate-member.json:3: the following documented members are not =
in the declaration: aa, bb
+doc-bad-alternate-member.json:3: documented members 'aa', 'bb' do not exis=
t
diff --git a/tests/qapi-schema/doc-bad-boxed-command-arg.err b/tests/qapi-s=
chema/doc-bad-boxed-command-arg.err
index e1101b1667..7137af3ec9 100644
--- a/tests/qapi-schema/doc-bad-boxed-command-arg.err
+++ b/tests/qapi-schema/doc-bad-boxed-command-arg.err
@@ -1 +1 @@
-doc-bad-boxed-command-arg.json:9: the following documented members are not=
 in the declaration: a
+doc-bad-boxed-command-arg.json:9: documented member 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-command-arg.err b/tests/qapi-schema/=
doc-bad-command-arg.err
index 153ea0330a..18ed076cef 100644
--- a/tests/qapi-schema/doc-bad-command-arg.err
+++ b/tests/qapi-schema/doc-bad-command-arg.err
@@ -1 +1 @@
-doc-bad-command-arg.json:3: the following documented members are not in th=
e declaration: b
+doc-bad-command-arg.json:3: documented member 'b' does not exist
diff --git a/tests/qapi-schema/doc-bad-enum-member.err b/tests/qapi-schema/=
doc-bad-enum-member.err
index dfa1e786d7..7efeb47363 100644
--- a/tests/qapi-schema/doc-bad-enum-member.err
+++ b/tests/qapi-schema/doc-bad-enum-member.err
@@ -1 +1 @@
-doc-bad-enum-member.json:3: the following documented members are not in th=
e declaration: a
+doc-bad-enum-member.json:3: documented member 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-event-arg.err b/tests/qapi-schema/do=
c-bad-event-arg.err
index 114ff4a3c7..d13cacf21f 100644
--- a/tests/qapi-schema/doc-bad-event-arg.err
+++ b/tests/qapi-schema/doc-bad-event-arg.err
@@ -1 +1 @@
-doc-bad-event-arg.json:3: the following documented members are not in the =
declaration: a
+doc-bad-event-arg.json:3: documented member 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-union-member.err b/tests/qapi-schema=
/doc-bad-union-member.err
index 8b9d36eab1..6dd2726a65 100644
--- a/tests/qapi-schema/doc-bad-union-member.err
+++ b/tests/qapi-schema/doc-bad-union-member.err
@@ -1 +1 @@
-doc-bad-union-member.json:3: the following documented members are not in t=
he declaration: a, b
+doc-bad-union-member.json:3: documented members 'a', 'b' do not exist
--=20
2.21.0


