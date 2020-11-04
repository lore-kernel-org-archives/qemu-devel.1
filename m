Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F9FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403282074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJba+MEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403282074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKOW-0003nj-7x
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIm-0003FI-O0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIf-00065Z-8S
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604502132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ph4CmqhsXQa5cO2TzGtnNzpPtWhA4pyxk7zpC8CUIlU=;
 b=ZJba+MEytOo6sQUo+kZNdf5Vk/5OHSRaMDCd8Quz/PBeDRcNgoMTXMNGZRkm3PIrVNK2pa
 KkA+Auc1HW8VK1xxsx2o+YjdWZe1ES/y18ke5tdU+hH0Qw6lGsb9GX5YeQLiKXhxdQ6oT6
 eonCWwBuCOL96DxYOGckfmH9pbESr3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-bpZBZmHeNcKbs5TxJxcBbw-1; Wed, 04 Nov 2020 10:02:09 -0500
X-MC-Unique: bpZBZmHeNcKbs5TxJxcBbw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8972C64151
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 15:02:07 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DA4419C4F
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 15:02:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] qtest: escape device name in device-introspect-test
Date: Wed,  4 Nov 2020 10:01:53 -0500
Message-Id: <20201104150153.541326-21-pbonzini@redhat.com>
In-Reply-To: <20201104150153.541326-1-pbonzini@redhat.com>
References: <20201104150153.541326-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

device-introspect-test uses HMP, so it should escape the device name
properly.  Because of this, a few devices that had commas in their
names were escaping testing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/device-introspect-test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index 9f22340ee5..bbec166dbc 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -104,7 +104,8 @@ static QList *device_type_list(QTestState *qts, bool abstract)
 static void test_one_device(QTestState *qts, const char *type)
 {
     QDict *resp;
-    char *help;
+    char *help, *escaped;
+    GRegex *comma;
 
     g_test_message("Testing device '%s'", type);
 
@@ -113,8 +114,13 @@ static void test_one_device(QTestState *qts, const char *type)
                type);
     qobject_unref(resp);
 
-    help = qtest_hmp(qts, "device_add \"%s,help\"", type);
+    comma = g_regex_new(",", 0, 0, NULL);
+    escaped = g_regex_replace_literal(comma, type, -1, 0, ",,", 0, NULL);
+    g_regex_unref(comma);
+
+    help = qtest_hmp(qts, "device_add \"%s,help\"", escaped);
     g_free(help);
+    g_free(escaped);
 }
 
 static void test_device_intro_list(void)
-- 
2.26.2


