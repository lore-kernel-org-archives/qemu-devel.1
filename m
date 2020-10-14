Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F40C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B33820848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTLk83JF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B33820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSffJ-0006v1-5f
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSfd1-0004zg-36
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSfcy-0003Ll-SU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602677491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0zrZnk/mtyFuALg4bVX3ckcLL+sGEU01fnMcB+jN4s=;
 b=HTLk83JFFUPwCmW+zCCwyGOWbav7feA5zsWAAWy1Yakmy3nXrbihcb/6QUzSXxCfeQcJcM
 5OeBEG/tT2pKdXNdNLptjAN0pi/KpTtaDydqxmo2BFHIlb7b9A2cHN+4HrGZCu+l/J9KwW
 4ABxqw5F9i8FITZzm9vN6vFyT5jsPuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-zuLVuwXEOh2cAqKZOL1CmA-1; Wed, 14 Oct 2020 08:11:30 -0400
X-MC-Unique: zuLVuwXEOh2cAqKZOL1CmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E8A818BE16D
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 12:11:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C94D55D9CD;
 Wed, 14 Oct 2020 12:11:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F3F5F43BFB8; Wed, 14 Oct 2020 14:11:20 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/7] ui/spice-app: don't use qemu_chr_open_spice_port
 directly
Date: Wed, 14 Oct 2020 14:11:15 +0200
Message-Id: <20201014121120.13482-3-kraxel@redhat.com>
In-Reply-To: <20201014121120.13482-1-kraxel@redhat.com>
References: <20201014121120.13482-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Save the parent object's open function pointer in the (new)
VCChardevClass struct instead before overwriting it, so we
can look it up when needed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 ui/spice-app.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 93e105c6ee82..7e0550c79fdd 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -44,11 +44,15 @@ static char *sock_path;
 struct VCChardev {
     SpiceChardev parent;
 };
-typedef struct VCChardev VCChardev;
+
+struct VCChardevClass {
+    ChardevClass parent;
+    void (*parent_open)(Chardev *chr, ChardevBackend *backend,
+                        bool *be_opened, Error **errp);
+};
 
 #define TYPE_CHARDEV_VC "chardev-vc"
-DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
-                         TYPE_CHARDEV_VC)
+OBJECT_DECLARE_TYPE(VCChardev, VCChardevClass, CHARDEV_VC)
 
 static ChardevBackend *
 chr_spice_backend_new(void)
@@ -66,6 +70,7 @@ static void vc_chr_open(Chardev *chr,
                         bool *be_opened,
                         Error **errp)
 {
+    VCChardevClass *vc = CHARDEV_VC_GET_CLASS(chr);
     ChardevBackend *be;
     const char *fqdn = NULL;
 
@@ -80,7 +85,7 @@ static void vc_chr_open(Chardev *chr,
     be = chr_spice_backend_new();
     be->u.spiceport.data->fqdn = fqdn ?
         g_strdup(fqdn) : g_strdup_printf("org.qemu.console.%s", chr->label);
-    qemu_chr_open_spice_port(chr, be, be_opened, errp);
+    vc->parent_open(chr, be, be_opened, errp);
     qapi_free_ChardevBackend(be);
 }
 
@@ -91,8 +96,11 @@ static void vc_chr_set_echo(Chardev *chr, bool echo)
 
 static void char_vc_class_init(ObjectClass *oc, void *data)
 {
+    VCChardevClass *vc = CHARDEV_VC_CLASS(oc);
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
+    vc->parent_open = cc->open;
+
     cc->parse = qemu_chr_parse_vc;
     cc->open = vc_chr_open;
     cc->chr_set_echo = vc_chr_set_echo;
@@ -103,6 +111,7 @@ static const TypeInfo char_vc_type_info = {
     .parent = TYPE_CHARDEV_SPICEPORT,
     .instance_size = sizeof(VCChardev),
     .class_init = char_vc_class_init,
+    .class_size = sizeof(VCChardevClass),
 };
 
 static void spice_app_atexit(void)
-- 
2.27.0


