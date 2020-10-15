Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BD3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EADE22255
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ6/Po9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EADE22255
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT2pO-0002CU-4b
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 08:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kT2lH-0005Qz-PE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kT2lE-0002d6-Dn
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602766415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Pj31xriymNsj9PF/8LSZqHTMJrYN/5EDpbzid4Et3c=;
 b=LQ6/Po9Dk9P5vKH9Lm1WEuHcdDljh8L+fM8OHefpaA1r1CRqoCnPqQLNsUr1UtL0eWMNOj
 RzvWjvjaFkTytYsHUa2T2asZvFahlBdf+/r6VZAr7hXaeE4+uENR1wdZdnOpZqOnG5YCBn
 A5y4wZl4gS6NxvPbTjxC6R8lzdlHydY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-0ZStHlMyN224mkMedXGMiA-1; Thu, 15 Oct 2020 08:53:34 -0400
X-MC-Unique: 0ZStHlMyN224mkMedXGMiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F19918A8234
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 12:53:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D328F76674;
 Thu, 15 Oct 2020 12:53:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F27AD9D0F; Thu, 15 Oct 2020 14:53:22 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] chardev/spice: build spice chardevs as module
Date: Thu, 15 Oct 2020 14:53:22 +0200
Message-Id: <20201015125322.23648-9-kraxel@redhat.com>
In-Reply-To: <20201015125322.23648-1-kraxel@redhat.com>
References: <20201015125322.23648-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20201014121120.13482-8-kraxel@redhat.com
---
 util/module.c       | 2 ++
 chardev/meson.build | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index 4349607ad176..f0ed05fbd06b 100644
--- a/util/module.c
+++ b/util/module.c
@@ -268,6 +268,8 @@ static struct {
     { "virtio-gpu-device",     "hw-", "display-virtio-gpu"    },
     { "vhost-user-gpu",        "hw-", "display-virtio-gpu"    },
     { "chardev-braille",       "chardev-", "baum"             },
+    { "chardev-spicevmc",      "chardev-", "spice"            },
+    { "chardev-spiceport",     "chardev-", "spice"            },
 };
 
 static bool module_loaded_qom_all;
diff --git a/chardev/meson.build b/chardev/meson.build
index dd2699a11b08..859d8b04d480 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -26,7 +26,6 @@ chardev_ss.add(when: 'CONFIG_WIN32', if_true: files(
 chardev_ss = chardev_ss.apply(config_host, strict: false)
 
 softmmu_ss.add(files('chardev-sysemu.c', 'msmouse.c', 'wctablet.c', 'testdev.c'))
-softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
 
 chardev_modules = {}
 
@@ -36,4 +35,10 @@ if config_host.has_key('CONFIG_BRLAPI')
   chardev_modules += { 'baum': module_ss }
 endif
 
+if config_host.has_key('CONFIG_SPICE')
+  module_ss = ss.source_set()
+  module_ss.add(when: [spice], if_true: files('spice.c'))
+  chardev_modules += { 'spice': module_ss }
+endif
+
 modules += { 'chardev': chardev_modules }
-- 
2.27.0


