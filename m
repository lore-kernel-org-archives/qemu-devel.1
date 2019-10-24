Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F14DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299D920684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqeB74A1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299D920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNb3K-0002MH-BS
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatK-0000xo-2Y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatE-0004pO-67
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20710
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatC-0004le-7U
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxh12PF2cAkgZjSZruCPbNHHQBZtA9Wr9tzr5cDv73c=;
 b=IqeB74A1+LpvuGIM87K3iNyid2Y5dBgVPaRfgMkLO3nuh4fP9MdRhDDUitMhBw9NPQPxAh
 Js1zADBpkFL9jwb44U3hDpXNwffwuAC1gYdIUDkVHo87xstdlD3p//P8DfvCpVDYadvsVO
 9LdDthclPWK9xQ0VoDZOrTKFu/gnP8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-iilQuN2LP_m9y6UiNhJ7Ug-1; Thu, 24 Oct 2019 07:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF427801E5F;
 Thu, 24 Oct 2019 11:02:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C452460C57;
 Thu, 24 Oct 2019 11:02:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 420AD1132D6D; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/19] tests/qapi-schema: Cover alternate documentation
 comments
Date: Thu, 24 Oct 2019 13:02:21 +0200
Message-Id: <20191024110237.30963-4-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: iilQuN2LP_m9y6UiNhJ7Ug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/doc-good.texi | 17 +++++++++++++++++
 tests/qapi-schema/doc-good.json |  8 ++++++++
 tests/qapi-schema/doc-good.out  | 12 ++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.t=
exi
index d6ecdac94f..98aa78e1fb 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -170,6 +170,23 @@ One of @t{"one"}, @t{"two"}
 @end deftp
=20
=20
+
+@deftp {Alternate} Alternate
+
+
+
+@b{Members:}
+@table @asis
+@item @code{i: int}
+an integer
+@code{b} is undocumented
+@item @code{b: boolean}
+Not documented
+@end table
+
+@end deftp
+
+
 @subsection Another subsection
=20
=20
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index 1ae6c3a9da..df50a877e3 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -98,6 +98,14 @@
 { 'union': 'SugaredUnion',
   'data': { 'one': 'Variant1', 'two': { 'type': 'Variant2', 'if': 'IFTWO' =
} } }
=20
+##
+# @Alternate:
+# @i: an integer
+# @b is undocumented
+##
+{ 'alternate': 'Alternate',
+  'data': { 'i': 'int', 'b': 'bool' } }
+
 ##
 # =3D=3D Another subsection
 ##
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t
index a8fc39d288..b0e99f2110 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -42,6 +42,10 @@ object SugaredUnion
     case one: q_obj_Variant1-wrapper
     case two: q_obj_Variant2-wrapper
         if ['IFTWO']
+alternate Alternate
+    tag type
+    case i: int
+    case b: bool
 object q_obj_cmd-arg
     member arg1: int optional=3DFalse
     member arg2: str optional=3DTrue
@@ -133,6 +137,14 @@ doc symbol=3DSugaredUnion
=20
     arg=3Dtype
=20
+doc symbol=3DAlternate
+    body=3D
+
+    arg=3Di
+an integer
+@b is undocumented
+    arg=3Db
+
 doc freeform
     body=3D
 =3D=3D Another subsection
--=20
2.21.0


