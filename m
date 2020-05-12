Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D023CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB359206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sHEyVSAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB359206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZe7-0004Ib-W6
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <masahiroy@kernel.org>)
 id 1jYZb2-0001E4-PK
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:25:40 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:40237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <masahiroy@kernel.org>)
 id 1jYZb0-0006Tg-EM
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:25:40 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net
 [126.90.202.47]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 04CIP3p4002559;
 Wed, 13 May 2020 03:25:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 04CIP3p4002559
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1589307904;
 bh=iOgYnLRwrRl2woi4+ET+Ay98zar+c7f4HFz1dCiM8KM=;
 h=From:To:Cc:Subject:Date:From;
 b=sHEyVSAFqZuN0p+MgjU5twB48ApRsxYWJl/RSScZHF0tdUNiixCVSuVhUcR+6FpJB
 fFuG6vQPjxHC7uL5wPOEsaaT8WvQih3OCc1cnQbakzUgRPO/Y7YX7mi8z1Q1R6YxyG
 v4VAhJnIGCSm6oexve/jBGG5pf3xSg1+0l+xN20rDy59Xlg9yjZrffzHweRVggdIpC
 F5znlnKc3kJn/DHZQYoV+souuJNCVZ1g9XkY/fkSCYqLIPx7zbO3xhVAnRy6pE2J3s
 KunNW7a2NTJYsBaKs1YvjJUCvSfFYLMc6vsjCNaULfTuaSirMGu0cqHv4HKOXtcWqx
 1bIIdOIYliAag==
X-Nifty-SrcIP: [126.90.202.47]
From: Masahiro Yamada <masahiroy@kernel.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH] qom/object: simplify type_initialize_interface()
Date: Wed, 13 May 2020 03:25:01 +0900
Message-Id: <20200512182501.2300530-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=210.131.2.79;
 envelope-from=masahiroy@kernel.org; helo=conuserg-12.nifty.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 13:31:34
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Masahiro Yamada <masahiroy@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

iface_impl->class is the same as new_iface. Make it more readable.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 qom/object.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 9d1a918e42..75c628591d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -262,8 +262,7 @@ static void type_initialize_interface(TypeImpl *ti, TypeImpl *interface_type,
     new_iface->concrete_class = ti->class;
     new_iface->interface_type = interface_type;
 
-    ti->class->interfaces = g_slist_append(ti->class->interfaces,
-                                           iface_impl->class);
+    ti->class->interfaces = g_slist_append(ti->class->interfaces, new_iface);
 }
 
 static void object_property_free(gpointer data)
-- 
2.25.1


