Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0FFC2BBC7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A36A20784
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtjQUi91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A36A20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMZA2-0002qf-Lt
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jMZ8i-00016C-4m
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jMZ8g-0003cF-Pz
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28299
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jMZ8g-0003aq-M9
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586446245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Ic+DfQ5DkGWSU3nvML24mnF+9TJHSI7N3BN4jDm3zE=;
 b=ZtjQUi91VRH/qyB2WvcyJysaz4VqaldG31VYaCU/crCFijf+LWCZErVYPciMxuWL6zr1V0
 21R4Q4IO/kX5yIJQrSDFN43haSqL4cV0pZ7ySq1WBL60vqeqbqrnE6Wep8dX/JQW+Xd2GV
 iTJ8OLoZngh9rIeIvmDtZBtZRm51uWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-EF5HrFwLN8mQVnXpHYRH4A-1; Thu, 09 Apr 2020 11:30:43 -0400
X-MC-Unique: EF5HrFwLN8mQVnXpHYRH4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5FFC1005509;
 Thu,  9 Apr 2020 15:30:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B023D5C296;
 Thu,  9 Apr 2020 15:30:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3640211384A9; Thu,  9 Apr 2020 17:30:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 1/8] tests-qemu-opts: Cover has_help_option(),
 qemu_opt_has_help_opt()
Date: Thu,  9 Apr 2020 17:30:34 +0200
Message-Id: <20200409153041.17576-2-armbru@redhat.com>
In-Reply-To: <20200409153041.17576-1-armbru@redhat.com>
References: <20200409153041.17576-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

The two turn out to be inconsistent for "a,b,,help".  Test case
marked /* BUG */.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qemu-opts.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index ef96e84aed..0efe93b45e 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -728,6 +728,43 @@ static void test_opts_parse_size(void)
     qemu_opts_reset(&opts_list_02);
 }
=20
+static void test_has_help_option(void)
+{
+    static const struct {
+        const char *params;
+        /* expected value of has_help_option() */
+        bool expect_has_help_option;
+        /* expected value of qemu_opt_has_help_opt() with implied=3Dfalse =
*/
+        bool expect_opt_has_help_opt;
+        /* expected value of qemu_opt_has_help_opt() with implied=3Dtrue *=
/
+        bool expect_opt_has_help_opt_implied;
+    } test[] =3D {
+        { "help", true, true, false },
+        { "helpme", false, false, false },
+        { "a,help", true, true, true },
+        { "a=3D0,help,b", true, true, true },
+        { "help,b=3D1", true, true, false },
+        { "a,b,,help", false /* BUG */, true, true },
+    };
+    int i;
+    QemuOpts *opts;
+
+    for (i =3D 0; i < ARRAY_SIZE(test); i++) {
+        g_assert_cmpint(has_help_option(test[i].params),
+                        =3D=3D, test[i].expect_has_help_option);
+        opts =3D qemu_opts_parse(&opts_list_03, test[i].params, false,
+                               &error_abort);
+        g_assert_cmpint(qemu_opt_has_help_opt(opts),
+                        =3D=3D, test[i].expect_opt_has_help_opt);
+        qemu_opts_del(opts);
+        opts =3D qemu_opts_parse(&opts_list_03, test[i].params, true,
+                               &error_abort);
+        g_assert_cmpint(qemu_opt_has_help_opt(opts),
+                        =3D=3D, test[i].expect_opt_has_help_opt_implied);
+        qemu_opts_del(opts);
+    }
+}
+
 static void append_verify_list_01(QemuOptDesc *desc, bool with_overlapping=
)
 {
     int i =3D 0;
@@ -990,6 +1027,7 @@ int main(int argc, char *argv[])
     g_test_add_func("/qemu-opts/opts_parse/bool", test_opts_parse_bool);
     g_test_add_func("/qemu-opts/opts_parse/number", test_opts_parse_number=
);
     g_test_add_func("/qemu-opts/opts_parse/size", test_opts_parse_size);
+    g_test_add_func("/qemu-opts/has_help_option", test_has_help_option);
     g_test_add_func("/qemu-opts/append_to_null", test_opts_append_to_null)=
;
     g_test_add_func("/qemu-opts/append", test_opts_append);
     g_test_add_func("/qemu-opts/to_qdict/basic", test_opts_to_qdict_basic)=
;
--=20
2.21.1


