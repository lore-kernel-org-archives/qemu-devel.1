Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E551AC5518A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56822074F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfuNEKCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56822074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRu2n-0000b3-SS
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 04:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw6-0005mm-PD
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw4-0002JN-3H
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRtw3-0002Cx-In
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587717826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EC1eBNlA151Lmref6Ha1Xz2fSZDp1v6NUj8i4iaXwd8=;
 b=gfuNEKCCUN3P9QoriNFqTVc+u4+2dillQgmt49gz0WJj7DmeUTBRMY0cwgyHXUaF4nauAb
 /qnzn0rSfFXduTaCjiG7CZTtwrvO6FoXzol0SNm21G5nTh4P02ozcBrDODZQNDt2IsIl+A
 4mRkv826XeHkdWWD6JigUojTBWQY6oQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-Ac1Kzeb-O4Ch8UBAAgrNbw-1; Fri, 24 Apr 2020 04:43:45 -0400
X-MC-Unique: Ac1Kzeb-O4Ch8UBAAgrNbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 856E6107ACF4;
 Fri, 24 Apr 2020 08:43:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EABD510016DA;
 Fri, 24 Apr 2020 08:43:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E921111358C4; Fri, 24 Apr 2020 10:43:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/15] qapi: Assert output visitors see only valid enum
 values
Date: Fri, 24 Apr 2020 10:43:31 +0200
Message-Id: <20200424084338.26803-9-armbru@redhat.com>
In-Reply-To: <20200424084338.26803-1-armbru@redhat.com>
References: <20200424084338.26803-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

output_type_enum() fails when *obj is not a valid value of the enum
type.  Should not happen.  Drop the check, along with its unit tests.
qapi_enum_lookup()'s assertion still guards.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/qapi-visit-core.c              |  9 -------
 tests/test-qobject-output-visitor.c | 39 -----------------------------
 tests/test-string-output-visitor.c  | 19 --------------
 3 files changed, 67 deletions(-)

diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index d4aac206cf..80ca83bcb9 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -341,15 +341,6 @@ static void output_type_enum(Visitor *v, const char *n=
ame, int *obj,
     int value =3D *obj;
     char *enum_str;
=20
-    /*
-     * TODO why is this an error, not an assertion?  If assertion:
-     * delete, and rely on qapi_enum_lookup()
-     */
-    if (value < 0 || value >=3D lookup->size) {
-        error_setg(errp, QERR_INVALID_PARAMETER, name ? name : "null");
-        return;
-    }
-
     enum_str =3D (char *)qapi_enum_lookup(lookup, value);
     visit_type_str(v, name, &enum_str, errp);
 }
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-outpu=
t-visitor.c
index d7761ebf84..1c856d9bd2 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -141,21 +141,6 @@ static void test_visitor_out_enum(TestOutputVisitorDat=
a *data,
     }
 }
=20
-static void test_visitor_out_enum_errors(TestOutputVisitorData *data,
-                                         const void *unused)
-{
-    EnumOne i, bad_values[] =3D { ENUM_ONE__MAX, -1 };
-
-    for (i =3D 0; i < ARRAY_SIZE(bad_values) ; i++) {
-        Error *err =3D NULL;
-
-        visit_type_EnumOne(data->ov, "unused", &bad_values[i], &err);
-        error_free_or_abort(&err);
-        visitor_reset(data);
-    }
-}
-
-
 static void test_visitor_out_struct(TestOutputVisitorData *data,
                                     const void *unused)
 {
@@ -234,26 +219,6 @@ static void test_visitor_out_struct_nested(TestOutputV=
isitorData *data,
     qapi_free_UserDefTwo(ud2);
 }
=20
-static void test_visitor_out_struct_errors(TestOutputVisitorData *data,
-                                           const void *unused)
-{
-    EnumOne bad_values[] =3D { ENUM_ONE__MAX, -1 };
-    UserDefOne u =3D {0};
-    UserDefOne *pu =3D &u;
-    int i;
-
-    for (i =3D 0; i < ARRAY_SIZE(bad_values) ; i++) {
-        Error *err =3D NULL;
-
-        u.has_enum1 =3D true;
-        u.enum1 =3D bad_values[i];
-        visit_type_UserDefOne(data->ov, "unused", &pu, &err);
-        error_free_or_abort(&err);
-        visitor_reset(data);
-    }
-}
-
-
 static void test_visitor_out_list(TestOutputVisitorData *data,
                                   const void *unused)
 {
@@ -821,14 +786,10 @@ int main(int argc, char **argv)
                             &out_visitor_data, test_visitor_out_no_string)=
;
     output_visitor_test_add("/visitor/output/enum",
                             &out_visitor_data, test_visitor_out_enum);
-    output_visitor_test_add("/visitor/output/enum-errors",
-                            &out_visitor_data, test_visitor_out_enum_error=
s);
     output_visitor_test_add("/visitor/output/struct",
                             &out_visitor_data, test_visitor_out_struct);
     output_visitor_test_add("/visitor/output/struct-nested",
                             &out_visitor_data, test_visitor_out_struct_nes=
ted);
-    output_visitor_test_add("/visitor/output/struct-errors",
-                            &out_visitor_data, test_visitor_out_struct_err=
ors);
     output_visitor_test_add("/visitor/output/list",
                             &out_visitor_data, test_visitor_out_list);
     output_visitor_test_add("/visitor/output/any",
diff --git a/tests/test-string-output-visitor.c b/tests/test-string-output-=
visitor.c
index 1be1540767..3bd732222c 100644
--- a/tests/test-string-output-visitor.c
+++ b/tests/test-string-output-visitor.c
@@ -203,19 +203,6 @@ static void test_visitor_out_enum(TestOutputVisitorDat=
a *data,
     }
 }
=20
-static void test_visitor_out_enum_errors(TestOutputVisitorData *data,
-                                         const void *unused)
-{
-    EnumOne i, bad_values[] =3D { ENUM_ONE__MAX, -1 };
-
-    for (i =3D 0; i < ARRAY_SIZE(bad_values) ; i++) {
-        Error *err =3D NULL;
-
-        visit_type_EnumOne(data->ov, "unused", &bad_values[i], &err);
-        error_free_or_abort(&err);
-    }
-}
-
 static void
 output_visitor_test_add(const char *testpath,
                         TestOutputVisitorData *data,
@@ -260,12 +247,6 @@ int main(int argc, char **argv)
                             &out_visitor_data, test_visitor_out_enum, fals=
e);
     output_visitor_test_add("/string-visitor/output/enum-human",
                             &out_visitor_data, test_visitor_out_enum, true=
);
-    output_visitor_test_add("/string-visitor/output/enum-errors",
-                            &out_visitor_data, test_visitor_out_enum_error=
s,
-                            false);
-    output_visitor_test_add("/string-visitor/output/enum-errors-human",
-                            &out_visitor_data, test_visitor_out_enum_error=
s,
-                            true);
     output_visitor_test_add("/string-visitor/output/intList",
                             &out_visitor_data, test_visitor_out_intList, f=
alse);
     output_visitor_test_add("/string-visitor/output/intList-human",
--=20
2.21.1


