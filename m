Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28308C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB20D20738
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dy+xWQdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB20D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAv9X-0005YF-2t
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAv8a-0004EP-NA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:06:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49542
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAv8Y-0002EL-TG
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598447205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uNK5jhcbpw5zyWw+KpnINndLmxU5aXnh7v/dKW/pb7I=;
 b=dy+xWQdmXNxxrYEP3k57LPmXbzdaB61BEp6xbeyMimmWCbSZ9Gbm+Mhe9JEvUWjKXIiZq8
 eFc+BeVRW0CW7nkpnPlpM4vL6KtVbl4B0KqyIYqhyq8OWTUh8gad1BFlZdMMt3mQDbBRv1
 ibsgRd1KMv+c1/uqwTeYbHyW3H4CjHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-bEgysmJHNpqI4hDnFLUFlw-1; Wed, 26 Aug 2020 09:06:43 -0400
X-MC-Unique: bEgysmJHNpqI4hDnFLUFlw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7D8B189E606
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 13:06:42 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 565D960C0F;
 Wed, 26 Aug 2020 13:06:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] meson: install scripts/qemu-trace-stap
Date: Wed, 26 Aug 2020 17:06:18 +0400
Message-Id: <20200826130622.553318-3-marcandre.lureau@redhat.com>
In-Reply-To: <20200826130622.553318-1-marcandre.lureau@redhat.com>
References: <20200826130622.553318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile            | 3 ---
 meson.build         | 1 +
 scripts/meson.build | 3 +++
 3 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 scripts/meson.build

diff --git a/Makefile b/Makefile
index 16b2ffa7fe..058cf87f54 100644
--- a/Makefile
+++ b/Makefile
@@ -244,9 +244,6 @@ ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 # Needed by "meson install"
 export DESTDIR
 install: all install-datadir install-localstatedir
-ifdef CONFIG_TRACE_SYSTEMTAP
-	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
-endif
 	for s in $(ICON_SIZES); do \
 		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
 		$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_$${s}.png \
diff --git a/meson.build b/meson.build
index f0fe5f8799..6bd66243ee 100644
--- a/meson.build
+++ b/meson.build
@@ -1123,6 +1123,7 @@ if have_tools
   endif
 endif
 
+subdir('scripts')
 subdir('tools')
 subdir('pc-bios')
 subdir('tests')
diff --git a/scripts/meson.build b/scripts/meson.build
new file mode 100644
index 0000000000..e8cc63896d
--- /dev/null
+++ b/scripts/meson.build
@@ -0,0 +1,3 @@
+if 'CONFIG_TRACE_SYSTEMTAP' in config_host
+  install_data('qemu-trace-stap', install_dir: get_option('bindir'))
+endif
-- 
2.26.2


