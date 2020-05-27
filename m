Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED94FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C3320787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UC18nEU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C3320787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdpAA-00083Z-Rr
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6d-0002bj-Mz
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:00:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6W-0004De-D5
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590559191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUSx1PDDw1vfrD4MhZ65qLeCnCHCsk5cDCIAJTQGhZE=;
 b=UC18nEU921LmCIFPPOHeAgtU/XcY/typVfDynnqgtN+WdGKtKdH8/e6gwLiL+xzIEI6HfT
 Eu/FeUVCkVegJyxZ5KtdV5pw2FQ/AE9gydF6r/o+AVKwiH1Za6zqLUj8U+o4dkLM9z7I4d
 SzhnXq3/K1azcAVOYg6fwHeyG+g7Eh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-fFAaWCihO-GcT31r5XCh-g-1; Wed, 27 May 2020 01:59:48 -0400
X-MC-Unique: fFAaWCihO-GcT31r5XCh-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F3A480183C
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 05:59:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 714321A7D2;
 Wed, 27 May 2020 05:59:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB5B41138611; Wed, 27 May 2020 07:59:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/10] tests/migration: Tighten error checking
Date: Wed, 27 May 2020 07:59:39 +0200
Message-Id: <20200527055945.6774-5-armbru@redhat.com>
In-Reply-To: <20200527055945.6774-1-armbru@redhat.com>
References: <20200527055945.6774-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 22:58:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

migrate_get_socket_address() neglects to check
visit_type_SocketAddressList() failure.  This smells like a leak, but
it actually will crash dereferencing @addrs.  Pass &error_abort to
remove the code smell.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200505101908.6207-5-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qtest/migration-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 2568c9529c..dc3490c9fa 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 
 #include "libqtest.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -301,7 +302,6 @@ static char *migrate_get_socket_address(QTestState *who, const char *parameter)
 {
     QDict *rsp;
     char *result;
-    Error *local_err = NULL;
     SocketAddressList *addrs;
     Visitor *iv = NULL;
     QObject *object;
@@ -310,7 +310,7 @@ static char *migrate_get_socket_address(QTestState *who, const char *parameter)
     object = qdict_get(rsp, parameter);
 
     iv = qobject_input_visitor_new(object);
-    visit_type_SocketAddressList(iv, NULL, &addrs, &local_err);
+    visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
     visit_free(iv);
 
     /* we are only using a single address */
-- 
2.21.3


