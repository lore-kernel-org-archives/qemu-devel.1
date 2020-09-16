Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23778C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46122080C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5VUhBNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46122080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISzt-00013o-QS
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kISyO-00088P-UB
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kISyN-0007JO-7w
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600245566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KG6ddk9BmUKE/8hK+BnmD/IZ/5/3gjQQ8fBejRRv0ws=;
 b=d5VUhBNZDToHxZbRjQHqHkHaOEdee11z+fwsQCV6hhPHRTmXu6uJgUK3QhGiYv9SCZD3/n
 BQo3yXju0o2r0Km0yJUTrUjZ5x36ok/SQBcgG1m/FjwkTWWmWxXCTu8c9h8uonzXCiaZIO
 AyYl8nEpohANVW6Z6zID99R9cRg1TXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-mtYjLHY1MSOWv8yIoKv8-w-1; Wed, 16 Sep 2020 04:39:24 -0400
X-MC-Unique: mtYjLHY1MSOWv8yIoKv8-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A27EB800FFF
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 08:39:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C7447512E;
 Wed, 16 Sep 2020 08:39:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AD0509D5A; Wed, 16 Sep 2020 10:39:13 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] chardev: build spice chardevs as module
Date: Wed, 16 Sep 2020 10:39:13 +0200
Message-Id: <20200916083913.11902-3-kraxel@redhat.com>
In-Reply-To: <20200916083913.11902-1-kraxel@redhat.com>
References: <20200916083913.11902-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
index 34772e7d87eb..86781c207f7d 100644
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
index 54e88d031004..a16ea8ab7c24 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -32,7 +32,6 @@ libchardev = static_library('chardev', chardev_ss.sources() + genh,
 chardev = declare_dependency(link_whole: libchardev)
 
 softmmu_ss.add(files('chardev-sysemu.c', 'msmouse.c', 'wctablet.c', 'testdev.c'))
-softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
 
 chardev_modules = {}
 
@@ -42,4 +41,10 @@ if config_host.has_key('CONFIG_BRLAPI')
   chardev_modules += { 'baum': module_ss }
 endif
 
+if config_host.has_key('CONFIG_SPICE')
+  module_ss = ss.source_set()
+  module_ss.add(when: [spice], if_true: [files('spice.c'), spice])
+  chardev_modules += { 'spice': module_ss }
+endif
+
 modules += { 'chardev': chardev_modules }
-- 
2.27.0


