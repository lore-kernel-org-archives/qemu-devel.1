Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E1BC433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 07:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9369207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 07:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtL07gwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9369207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRVu1-0007tU-Ua
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 03:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRVsy-0006CW-2J
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 03:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRVst-0003GL-CC
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 03:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602401710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nqq9WXlOV9+QZ91BW/WxEh1wTlCTvfPI2ol0WEsH7YE=;
 b=JtL07gwNAVYInVq6jFp33ZgdkIT6I1+xnIrnGayQE2RQevLsdVUhS0EwgPzhUmg9Y80e8v
 LWwF52QbWKDlolnHFXTmq/2qxSFJEMUFK26MvmO3gh7ceJ8ifwpxbMxwfdcKe0tOWik0pe
 BlfGodIoqKn3oMnZ+MSk1A+8QfEAE+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326--0ojqNL2MzW48740habyuA-1; Sun, 11 Oct 2020 03:35:07 -0400
X-MC-Unique: -0ojqNL2MzW48740habyuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC6E3835B67;
 Sun, 11 Oct 2020 07:35:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B63561177;
 Sun, 11 Oct 2020 07:35:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1838E1132946; Sun, 11 Oct 2020 09:35:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/7] test-keyval: Demonstrate misparse of ',
 ' with implied key
Date: Sun, 11 Oct 2020 09:35:00 +0200
Message-Id: <20201011073505.1185335-3-armbru@redhat.com>
In-Reply-To: <20201011073505.1185335-1-armbru@redhat.com>
References: <20201011073505.1185335-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 00:55:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test for "val,,ue" with implied key.  Documentation says this
should parse as implied key with value "val", then fail.  The code
parses it as implied key with value "val,ue", then succeeds.  The next
commit will fix it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-keyval.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index e331a84149..f02bdf7029 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -182,6 +182,13 @@ static void test_keyval_parse(void)
     error_free_or_abort(&err);
     g_assert(!qdict);
 
+    /* Implied key's value can't have comma (qemu_opts_parse(): it can) */
+    /* BUG: it can */
+    qdict = keyval_parse("val,,ue", "implied", &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "val,ue");
+    qobject_unref(qdict);
+
     /* Empty key is not an implied key */
     qdict = keyval_parse("=val", "implied", &err);
     error_free_or_abort(&err);
-- 
2.26.2


