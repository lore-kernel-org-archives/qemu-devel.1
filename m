Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FFEC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A44E20708
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6I4Z3sH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A44E20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNaKL-0004HE-Vf
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNaIP-0002ZG-7B
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNaIN-0003rQ-1K
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:29:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601465353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0zrZnk/mtyFuALg4bVX3ckcLL+sGEU01fnMcB+jN4s=;
 b=G6I4Z3sHt2enn/3j/p7BgOFpHsjaDzniyYAoEc2a/W10SfCof/DxajpBAUuXhNYBgQm6ER
 qsPGy+X7q6HvqCApcM2Y5G2sGncSxFwoF43W7ffniVz4E0Tuijb+vim0Ud7hQwKQvlTR9K
 7YIg/6/EJIsBRtBRzSIZuFQ35C4pi3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-D_4CfcEoOHy214R0OFv7NA-1; Wed, 30 Sep 2020 07:29:11 -0400
X-MC-Unique: D_4CfcEoOHy214R0OFv7NA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B15880BD66
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 11:29:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFC2019D61;
 Wed, 30 Sep 2020 11:29:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 328459A83; Wed, 30 Sep 2020 13:29:04 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/6] ui/spice-app: don't use qemu_chr_open_spice_port
 directly
Date: Wed, 30 Sep 2020 13:28:59 +0200
Message-Id: <20200930112904.24397-2-kraxel@redhat.com>
In-Reply-To: <20200930112904.24397-1-kraxel@redhat.com>
References: <20200930112904.24397-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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


