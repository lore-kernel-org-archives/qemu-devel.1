Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5667C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E1920784
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqqTAJcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E1920784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMZA3-0002tE-Ok
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jMZ8l-00019P-Hn
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jMZ8k-0003iZ-D6
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48036
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jMZ8k-0003hs-A5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586446250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOCUd8UN3wzT8fEQwhe54oUKmFBLgPdAHxu8KZRWRng=;
 b=XqqTAJcO90/SnYHrstpLvSgEtVopFBqsWJDUiZvparBCGAK1qn1XT5oxBp9ui521ExOfqr
 PZyY5T17FpknLY6OJ5vYrLA7+HSddS4qamtGqcaaMamoKrCEX68uaB6oI08WnijB8sLWwy
 kP0EVWLckWCtc0freoR8vOK44bAdhTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-0F6hhmfNNkqBsbSD6xP5lQ-1; Thu, 09 Apr 2020 11:30:45 -0400
X-MC-Unique: 0F6hhmfNNkqBsbSD6xP5lQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 694F818FF661;
 Thu,  9 Apr 2020 15:30:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37BCA9D348;
 Thu,  9 Apr 2020 15:30:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 438CA11358B2; Thu,  9 Apr 2020 17:30:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 5/8] qemu-option: Fix has_help_option()'s sloppy
 parsing
Date: Thu,  9 Apr 2020 17:30:38 +0200
Message-Id: <20200409153041.17576-6-armbru@redhat.com>
In-Reply-To: <20200409153041.17576-1-armbru@redhat.com>
References: <20200409153041.17576-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

has_help_option() uses its own parser.  It's inconsistent with
qemu_opts_parse(), as demonstrated by test-qemu-opts case
/qemu-opts/has_help_option.  Fix by reusing the common parser.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qemu-opts.c |  2 +-
 util/qemu-option.c     | 39 +++++++++++++++++++--------------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 27c24bb1a2..58a4ea2408 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -744,7 +744,7 @@ static void test_has_help_option(void)
         { "a,help", true, true, true },
         { "a=3D0,help,b", true, true, true },
         { "help,b=3D1", true, true, false },
-        { "a,b,,help", false /* BUG */, true, true },
+        { "a,b,,help", true, true, true },
     };
     int i;
     QemuOpts *opts;
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 6403e521fc..279f1b3fb3 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -165,26 +165,6 @@ void parse_option_size(const char *name, const char *v=
alue,
     *ret =3D size;
 }
=20
-bool has_help_option(const char *param)
-{
-    const char *p =3D param;
-    bool result =3D false;
-
-    while (*p && !result) {
-        char *value;
-
-        p =3D get_opt_value(p, &value);
-        if (*p) {
-            p++;
-        }
-
-        result =3D is_help_option(value);
-        g_free(value);
-    }
-
-    return result;
-}
-
 bool is_valid_option_list(const char *p)
 {
     char *value =3D NULL;
@@ -890,6 +870,25 @@ static char *opts_parse_id(const char *params)
     return NULL;
 }
=20
+bool has_help_option(const char *params)
+{
+    const char *p;
+    char *name, *value;
+    bool ret;
+
+    for (p =3D params; *p;) {
+        p =3D get_opt_name_value(p, NULL, &name, &value);
+        ret =3D !strcmp(name, "help");
+        g_free(name);
+        g_free(value);
+        if (ret) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 /**
  * Store options parsed from @params into @opts.
  * If @firstname is non-null, the first key=3Dvalue in @params may omit
--=20
2.21.1


