Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA2AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73A72065F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfLf5qWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73A72065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYGL-00041Z-WF
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYFi-0003OF-1J
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:15:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30359
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYFg-00029X-4w
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595499298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KiLD1zEU2AfAS4VnBryRi+YF/Kr2iphonwd4vT6ps+w=;
 b=CfLf5qWk2qmoRIBxaYUkiV4qoOpmw2i8GDJ6eRqBxHVH8tikgLHpXYDJ4ss2qaP7Rsd0qJ
 xzPxbbJy4Kpj0nTs6t1CIfnxu7Cxdy+RTuom/EAfptVWTvg8IyuL4cYNuG+XGUtEEy6jvC
 8tztYsg/pIM0uWJWIPLzLKOu2UZM3zk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-SaEtQFEKM5WtuJKi8bpGOg-1; Thu, 23 Jul 2020 06:14:57 -0400
X-MC-Unique: SaEtQFEKM5WtuJKi8bpGOg-1
Received: by mail-wr1-f70.google.com with SMTP id w7so1245876wrt.9
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KiLD1zEU2AfAS4VnBryRi+YF/Kr2iphonwd4vT6ps+w=;
 b=bncU4cma2bp7aRgMAkojWqbGEvgi2NR47pgaURyYTq8rYVVptxVJ/ArPMiuoOf6Tf4
 a1D6Yj1+9ImfW5opKU+0guVmx0UwYOhJ0scuAgT8Q62YCe/7LFPUmA2iz+n7ZkbbsQC1
 lwtTrzt88GJz9E4QsME1qIm5ygmJMDAUpjvBby4ryHBVEQOBcQVD3O3yxkvaqJDdifZe
 gZ6TCBunTGUhS2PmuL6kdXmudl+VoiOBZzsX5EmhpXNh+sSj2DB9D1prQTUmmxzFajKM
 BnSEsJMxCS3OP822FgHU6aUXBQ+WIsFI9xD1Kn5ALR4yfTl0TIsnyYKzCVCutwIR4AyF
 ZlZw==
X-Gm-Message-State: AOAM533ga4RjrLo93BBewboEKqe/w//aHTSxXFhLYEhOjMVMOkOr3edv
 OpPxF/GlzaK49shB+Grw/Gv3xLTUTvt82XWPC7LC8SIO2Gg9RxBXqZVY39yHkKFZ/2Zhn84MDH/
 fWZ28tc8nIRoemLg=
X-Received: by 2002:a1c:3142:: with SMTP id x63mr3400812wmx.62.1595499295891; 
 Thu, 23 Jul 2020 03:14:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqnPEB0nzU4YcwVBdI/Fn4Bf1mwA05mRVm7IBvMyDilGnp0wsSnqE88MuX11qGJermLDpR+g==
X-Received: by 2002:a1c:3142:: with SMTP id x63mr3400795wmx.62.1595499295631; 
 Thu, 23 Jul 2020 03:14:55 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t202sm2998188wmt.20.2020.07.23.03.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 03:14:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] qapi/error: Make error_vprepend() static
Date: Thu, 23 Jul 2020 12:14:53 +0200
Message-Id: <20200723101453.11129-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

error_vprepend() is only used by util/error.c where it is
defined. Make it static to reduce its scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qapi/error.h | 6 ------
 util/error.c         | 6 +++++-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 7932594dce..fa2308dedd 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -384,12 +384,6 @@ void error_propagate(Error **dst_errp, Error *local_err);
 void error_propagate_prepend(Error **dst_errp, Error *local_err,
                              const char *fmt, ...);
 
-/*
- * Prepend some text to @errp's human-readable error message.
- * The text is made by formatting @fmt, @ap like vprintf().
- */
-void error_vprepend(Error *const *errp, const char *fmt, va_list ap);
-
 /*
  * Prepend some text to @errp's human-readable error message.
  * The text is made by formatting @fmt, ... like printf().
diff --git a/util/error.c b/util/error.c
index b6c89d1412..3990b741ff 100644
--- a/util/error.c
+++ b/util/error.c
@@ -121,7 +121,11 @@ void error_setg_file_open_internal(Error **errp,
                               "Could not open '%s'", filename);
 }
 
-void error_vprepend(Error *const *errp, const char *fmt, va_list ap)
+/*
+ * Prepend some text to @errp's human-readable error message.
+ * The text is made by formatting @fmt, @ap like vprintf().
+ */
+static void error_vprepend(Error *const *errp, const char *fmt, va_list ap)
 {
     GString *newmsg;
 
-- 
2.21.3


