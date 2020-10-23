Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614EFC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D464D223EA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrdNNnEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D464D223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0Fd-0006PU-Dg
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVzhL-00087m-8m
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVzhF-0007jZ-CT
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603469619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Bax/49ZukJ+CSOiDpXMIq3+Ildi0uQ6XOaI6TRRpgQ=;
 b=hrdNNnEe6ijktNUf6vAWX2sntGUYtbCglh3CxePfluQmiItL+J75eEHGdTybzVq0EiOg/4
 l1WDvzAn+GYVpbEOzdqhTf+n1N8L8RiVfaGZtPVC+pP5tFPvBBX13UsrpftS+yuKiwFlsB
 AEb1mf3ElaZIoA9QMRo4PTPmjGfDuxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-7kWqr2ynOsuOvo6UW93TEw-1; Fri, 23 Oct 2020 12:13:38 -0400
X-MC-Unique: 7kWqr2ynOsuOvo6UW93TEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C39C1087D7F;
 Fri, 23 Oct 2020 16:13:33 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F33F55C1CF;
 Fri, 23 Oct 2020 16:13:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/6] char: Factor out qemu_chr_print_types()
Date: Fri, 23 Oct 2020 18:13:08 +0200
Message-Id: <20201023161312.460406-3-kwolf@redhat.com>
In-Reply-To: <20201023161312.460406-1-kwolf@redhat.com>
References: <20201023161312.460406-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We'll want to call the same from a non-QemuOpts code path.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/chardev/char.h |  1 +
 chardev/char.c         | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index db42f0a8c6..3b91645081 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -212,6 +212,7 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
  */
 void qemu_chr_be_event(Chardev *s, QEMUChrEvent event);
 
+void qemu_chr_print_types(void);
 int qemu_chr_add_client(Chardev *s, int fd);
 Chardev *qemu_chr_find(const char *name);
 
diff --git a/chardev/char.c b/chardev/char.c
index 78553125d3..4d188bfa6f 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -633,6 +633,15 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
     return backend;
 }
 
+void qemu_chr_print_types(void)
+{
+    g_autoptr(GString) str = g_string_new("");
+
+    chardev_name_foreach(help_string_append, str);
+
+    qemu_printf("Available chardev backend types: %s\n", str->str);
+}
+
 Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
                                 Error **errp)
 {
@@ -644,12 +653,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
     char *bid = NULL;
 
     if (name && is_help_option(name)) {
-        GString *str = g_string_new("");
-
-        chardev_name_foreach(help_string_append, str);
-
-        qemu_printf("Available chardev backend types: %s\n", str->str);
-        g_string_free(str, true);
+        qemu_chr_print_types();
         return NULL;
     }
 
-- 
2.28.0


