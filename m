Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1236FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57792067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Txt5NJVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57792067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7dqG-0006Sr-3H
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 08:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1k7dpH-0005C2-LN
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1k7dpF-0003fg-RK
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597665677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSC2eOKE0NQbqwjE3v+4TyCChUK9VcdeLXUZxTLG/Js=;
 b=Txt5NJVcHoSc+RXN6JUrEEXkwWIWcluUdD4rP6DUc0EcNwlD77hr97Iz6jKty1EQ4rTxB9
 dTRGaFTW+kQ+ldb3cQ2MmUjpsB5tDM4b0Ot9s8OOL7C+8NZZQSP3oHd1KU53Lbu2jX1qKO
 SaQYRelxpiK216yegVpKSjPm33Um3oQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-z-S0Ko5GNMiKc5SfnJScbA-1; Mon, 17 Aug 2020 08:01:13 -0400
X-MC-Unique: z-S0Ko5GNMiKc5SfnJScbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94D0051AF
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 12:01:12 +0000 (UTC)
Received: from localhost (unknown [10.36.110.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 580A35D9D2;
 Mon, 17 Aug 2020 12:01:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] ui: add getter for UIInfo
Date: Mon, 17 Aug 2020 16:00:54 +0400
Message-Id: <20200817120056.56751-3-marcandre.lureau@redhat.com>
In-Reply-To: <20200817120056.56751-1-marcandre.lureau@redhat.com>
References: <20200817120056.56751-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following patch is going to introduce extra fields / details to
UIInfo. Add a getter and keep the current values, instead of memset(0)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c       | 7 +++++++
 ui/spice-display.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index 0579be792f..2a0d191d4e 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1513,6 +1513,13 @@ bool dpy_ui_info_supported(QemuConsole *con)
     return con->hw_ops->ui_info != NULL;
 }
 
+const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con)
+{
+    assert(con != NULL);
+
+    return &con->ui_info;
+}
+
 int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info)
 {
     assert(con != NULL);
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 19632fdf6c..625d9232b9 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -672,7 +672,7 @@ static int interface_client_monitors_config(QXLInstance *sin,
         return 1;
     }
 
-    memset(&info, 0, sizeof(info));
+    info = *dpy_get_ui_info(ssd->dcl.con);
 
     if (mc->num_of_monitors == 1) {
         /*
-- 
2.26.2


