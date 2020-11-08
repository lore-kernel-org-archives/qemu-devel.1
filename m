Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F14C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF77206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5tZPxQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF77206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbraN-0003fl-Bi
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrZR-00034n-BN
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:45:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrZM-0000K1-AN
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQ1UDmwFMkB+mv0qV2lzTI3NvVyFxAW3riXAc5YeNWc=;
 b=c5tZPxQH+mBoheuTvT49b6+B33W3eA1NDcMt3txlD+0cp3w8e9j41dm//8LBAdwBPKN3zx
 jlOdjn72ExRBQ36UFqH3mgFAActmPSB71Dlcrj4mzYnIa681KLSx3Bxsiq46KN9XHdHIEf
 t6PhSH+MHuvHbGSRt90DaYAQAovnIiw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-Rv_r7s9PPs-1AYpcita5Ow-1; Sun, 08 Nov 2020 15:45:45 -0500
X-MC-Unique: Rv_r7s9PPs-1AYpcita5Ow-1
Received: by mail-wr1-f69.google.com with SMTP id b6so3357904wrn.17
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mQ1UDmwFMkB+mv0qV2lzTI3NvVyFxAW3riXAc5YeNWc=;
 b=GR4rJ8xPf3Uz3L6uarfFbQVj9XtU4PIfiQp3vwV+vgPKFLw2YibtI1xrcEK/Wtj1U8
 PD8pYw2Bp+6nl+BhtyDU6T7eXukORgWgQbB2ME0s+rhO63//x4X8Fk51jm8CdwPAlCYo
 xwvZYnsm7263b71i1Y0teTAgbuldO9CCAtnKb7RM5I91uecpCWPxk7iNrIPn6jSBACw/
 HiMXE5cGTK8S4BmR5P3cweMg+Z1Q0n/Dj8LFCOrXmB8pCxw7y0yyv/HEn3Y9SVSAFrJv
 LzKg6pv4yPE1CpOtb+MhRl6a5FlOQkfu+mSd2Ko+MIyfsg4hWdlg6LnJw8LP1RkgNQET
 kFQg==
X-Gm-Message-State: AOAM533SdQGVGYTYsbU5KnbTscfqIsmLwb0Dt0HQmxbGkS3xST/xK5zg
 OF0antP02oVIvBOQr81kV9SKJWPRxZd9RNVy/5OPgJ66f+xyXfpxLLqrjGrrI2yPUvOUX6SJYdw
 P8/YSx4YwC9pQU0I=
X-Received: by 2002:adf:8362:: with SMTP id 89mr14756601wrd.280.1604868344180; 
 Sun, 08 Nov 2020 12:45:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqbR2cLME5tMAFaS6zqdV88bCqMwHdMWRjbXbn1ZbxbP5a4oBp4JHT3JG58/itaflrBByO3Q==
X-Received: by 2002:adf:8362:: with SMTP id 89mr14756573wrd.280.1604868343948; 
 Sun, 08 Nov 2020 12:45:43 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n10sm561471wrv.77.2020.11.08.12.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:45:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v4 01/17] configure: Check vhost-user is available to
 build vhost-user-blk-server
Date: Sun,  8 Nov 2020 21:45:19 +0100
Message-Id: <20201108204535.2319870-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108204535.2319870-1-philmd@redhat.com>
References: <20201108204535.2319870-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 15:45:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check vhost-user is available to build vhost-user-blk-server to fix:

 $ ../configure \
      --disable-vhost-user --enable-vhost-user-blk-server && \
   make qemu-nbd
 ...
 [505/505] Linking target qemu-nbd
 FAILED: qemu-nbd
 cc  -o qemu-nbd qemu-nbd.p/qemu-nbd.c.o -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libblockdev.fa libblock.fa libcrypto.fa libauthz.fa libqom.fa libio.fa -Wl,--no-whole-archive -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -m64 -fstack-protector-strong -Wl,--start-group libqemuutil.a libblockdev.fa libblock.fa libcrypto.fa libauthz.fa libqom.fa libio.fa @block.syms -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0 -pthread -lgnutls -lutil -lm -lgthread-2.0 -lglib-2.0 -lbz2 -lgthread-2.0 -lglib-2.0 -lssh -lrbd -lrados -lcurl -lxml2 -lzstd -lacl -lgfapi -lglusterfs -lgfrpc -lgfxdr -luuid -laio /usr/lib64/libz.so -L/usr/lib64/iscsi -liscsi -lnettle -lgnutls -lpam -Wl,--end-group
 /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_process_vq':
 block/export/vhost-user-blk-server.c:203: undefined reference to `vu_get_queue'
 /usr/bin/ld: block/export/vhost-user-blk-server.c:208: undefined reference to `vu_queue_pop'
 /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_queue_set_started':
 block/export/vhost-user-blk-server.c:228: undefined reference to `vu_get_queue'
 /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_req_complete':
 block/export/vhost-user-blk-server.c:55: undefined reference to `vu_queue_push'
 /usr/bin/ld: block/export/vhost-user-blk-server.c:56: undefined reference to `vu_queue_notify'
 /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_queue_set_started':
 block/export/vhost-user-blk-server.c:229: undefined reference to `vu_set_queue_handler'
 /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `vu_client_trip':
 util/vhost-user-server.c:176: undefined reference to `vu_dispatch'
 /usr/bin/ld: util/vhost-user-server.c:180: undefined reference to `vu_deinit'
 /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `vu_accept':
 util/vhost-user-server.c:291: undefined reference to `vu_init'
 collect2: error: ld returned 1 exit status
 ninja: build stopped: subcommand failed.
 make: *** [Makefile:171: run-ninja] Error 1

Fixes: bc15e44cb21 ("configure: introduce --enable-vhost-user-blk-server")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index 805f7791503..5079ebb416a 100755
--- a/configure
+++ b/configure
@@ -2390,6 +2390,9 @@ fi
 
 # libvhost-user is Linux-only
 test "$vhost_user_blk_server" = "" && vhost_user_blk_server=$linux
+if test "$vhost_user_blk_server" = "yes" && test "$vhost_user" = "no"; then
+  error_exit "--enable-vhost-user-blk-server requires --enable-vhost-user"
+fi
 if test "$vhost_user_blk_server" = "yes" && test "$linux" = "no"; then
   error_exit "--enable-vhost-user-blk-server is only available on Linux"
 fi
-- 
2.26.2


