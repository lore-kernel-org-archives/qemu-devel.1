Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E4FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A0020848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1Zt8ZtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A0020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfiY-0001OK-MK
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSfd3-00055D-Cj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSfcz-0003NH-Uw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602677493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DkVVvPbH98jkfOWc2FQkYqaHlvp7TtF/IsGGvo49Gyo=;
 b=i1Zt8ZtX0BZWOIHYUoPDyfb/lDWXhfcdEuW+QaYfBhGu1/UU4OnykMdCNSuN5mYEVJT0cf
 tnsrycvEJ8o5OrqFtlARWdwdQN/oBbLxP+AchCy9OhlJ9R9XkRoFjiqEw+WJXYPlnq4hZM
 NfIjmEgr/Nplwwhdip3nOgtyGQL3xoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-DW7HL7qEPsKzk-l6Bxe0og-1; Wed, 14 Oct 2020 08:11:30 -0400
X-MC-Unique: DW7HL7qEPsKzk-l6Bxe0og-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB0D7102090A
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 12:11:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D7086EF67;
 Wed, 14 Oct 2020 12:11:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3B8C231E21; Wed, 14 Oct 2020 14:11:21 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 7/7] chardev/spice: build spice chardevs as module
Date: Wed, 14 Oct 2020 14:11:20 +0200
Message-Id: <20201014121120.13482-8-kraxel@redhat.com>
In-Reply-To: <20201014121120.13482-1-kraxel@redhat.com>
References: <20201014121120.13482-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 util/module.c       | 2 ++
 chardev/meson.build | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index a44ec38d9362..4a5735dfdc76 100644
--- a/util/module.c
+++ b/util/module.c
@@ -264,6 +264,8 @@ static struct {
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


