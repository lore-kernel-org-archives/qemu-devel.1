Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9697DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50646207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxYdTDFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50646207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKMS-00078W-EJ
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKK1-0001JP-Ig
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43575
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKK0-0006db-Q1
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589964208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HM2EzvwT9zl59oqop71KJ2LfsctJLRfA96gEblXv6/k=;
 b=YxYdTDFRZJ8ofb4sTmCmr40q+kqi/kVsCt6nX6zNrH+J9UoS/uhdnwQot6JWsSzU9SlRmz
 aiFaRlpUESzR2K+YtYb/jfTZjn3PLzYTD1lANkLUz/YvD8fMzrgwCibMd6+j+SaBc8yxbZ
 GPlrROZZLo5kJH22w+MU3zXppf3lLvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-cf_TnPAKMce5CGu3MSKyvA-1; Wed, 20 May 2020 04:43:26 -0400
X-MC-Unique: cf_TnPAKMce5CGu3MSKyvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1152100CCC0;
 Wed, 20 May 2020 08:43:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1AED6F7F9;
 Wed, 20 May 2020 08:43:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C906D9D58; Wed, 20 May 2020 10:43:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] ui/gtk: don't pass on win keys without keyboard grab
Date: Wed, 20 May 2020 10:43:14 +0200
Message-Id: <20200520084316.22057-10-kraxel@redhat.com>
In-Reply-To: <20200520084316.22057-1-kraxel@redhat.com>
References: <20200520084316.22057-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker Rümelin <vr_qemu@t-online.de>

Without keyboard grab Windows currently handles the two win keys
and the key events are also sent to the guest. This is undesir-
able. Only one program should handle key events. This patch ap-
plies commit c68f74b02e "win32: do not handle win keys when the
keyboard is not grabbed" from project spice-gtk to ui/gtk.c to
fix this problem.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200516072014.7766-9-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 354dd90e1898..1d51e14bb58d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1095,10 +1095,17 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
     VirtualConsole *vc = opaque;
     int qcode;
 
-#ifdef WIN32
+#ifdef G_OS_WIN32
     /* on windows, we ought to ignore the reserved key event? */
     if (key->hardware_keycode == 0xff)
         return false;
+
+    if (!vc->s->kbd_owner) {
+        if (key->hardware_keycode == VK_LWIN ||
+            key->hardware_keycode == VK_RWIN) {
+            return FALSE;
+        }
+    }
 #endif
 
     if (key->keyval == GDK_KEY_Pause
-- 
2.18.4


