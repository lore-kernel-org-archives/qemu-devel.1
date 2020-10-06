Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD5C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A162D20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/w3cQ1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A162D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkxO-00072w-Mw
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPku5-0001s4-SO
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPku1-0005M0-8R
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601982784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y654+qjr2XVjaJo/qs42m3q3chS6kyMAnJkYOWqEyzg=;
 b=X/w3cQ1HqWemS782GKMwdBX/Fkeh3g48SAKkf1rUrPajXKgNGsz0GwuvCawwg2d1IEitJl
 0ljULRvUG9Duud5k642IHfzkq7CEFoqbKJnWLW1/j98zRbA2gOYA7QKRgOyhb+pOLRaiR/
 zb9Zc9IXOe6Z4NofQvuiqzosWrTJv8E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-6zCPwmbAPreGwVHNkZgl_Q-1; Tue, 06 Oct 2020 07:13:02 -0400
X-MC-Unique: 6zCPwmbAPreGwVHNkZgl_Q-1
Received: by mail-wr1-f72.google.com with SMTP id c6so4252409wrt.6
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y654+qjr2XVjaJo/qs42m3q3chS6kyMAnJkYOWqEyzg=;
 b=W7ymvXzCLY4giHp471dpL97C30F1zGnGjK+Vq2lYjqacYnzi9+fNX4tpu7Bkkel+XH
 NJ3fjkh8CUxRYl+nau3fIVqD6iEZgeP80b+u9HsNRd+qs58Io/Y4+xa9ll71nxJo5SWV
 1NyHwDwjxZ+x76p5hL3OnP9YOtm279YlIeNAWlJ6VsSkjJmKRn2/iGqvnyCPJ5Y7P8On
 drbIl+SVXRDi94Mr/bCgx2b1dZbORIAZLnbufXtefdoHe2tI5He8+0+GkpO5G1oaSYjM
 d5RKUibVBYDp8vAKeqqfs8JiMh6KqCmEk6ROceVj/V2U56fQC1hx+S77CPYwX9gjolCl
 RdJA==
X-Gm-Message-State: AOAM532nB1x4dIUu5DoymS3OOV175V80a+DqTAOCKGQKGGaJzUSzXB8/
 iO/7+WJUdpMy/JSU+SZsK2a81oEp5PryWeRm28ltd3EPPL3WsEaIK2cWmE5ixyJpvGUzdiIGV4v
 msUh8pqAIR6sYD9Y=
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr4298712wmd.95.1601982781453; 
 Tue, 06 Oct 2020 04:13:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+OHvtXrF4Cdv6W1e4q+LU5p8CBAVEgIZFh+mebr1bYRGoqWf7HScC+Fo6CvAOizEo66Y1Yg==
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr4298690wmd.95.1601982781233; 
 Tue, 06 Oct 2020 04:13:01 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a5sm4028173wrp.37.2020.10.06.04.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:13:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/10] crypto: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 13:12:17 +0200
Message-Id: <20201006111219.2300921-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006111219.2300921-1-philmd@redhat.com>
References: <20201006111219.2300921-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Be consistent creating all the libraries in the main meson.build file.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 meson.build        | 10 ++++++++++
 crypto/meson.build | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index 70545efd74..5ded67cb76 100644
--- a/meson.build
+++ b/meson.build
@@ -1064,6 +1064,7 @@ block_ss = ss.source_set()
 bsd_user_ss = ss.source_set()
 chardev_ss = ss.source_set()
 common_ss = ss.source_set()
+crypto_ss = ss.source_set()
 io_ss = ss.source_set()
 linux_user_ss = ss.source_set()
 qmp_ss = ss.source_set()
@@ -1329,6 +1330,15 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 # Library dependencies #
 ########################
 
+crypto_ss = crypto_ss.apply(config_host, strict: false)
+libcrypto = static_library('crypto', crypto_ss.sources() + genh,
+                           dependencies: [crypto_ss.dependencies()],
+                           name_suffix: 'fa',
+                           build_by_default: false)
+
+crypto = declare_dependency(link_whole: libcrypto,
+                            dependencies: [authz, qom])
+
 io_ss = io_ss.apply(config_host, strict: false)
 libio = static_library('io', io_ss.sources() + genh,
                        dependencies: [io_ss.dependencies()],
diff --git a/crypto/meson.build b/crypto/meson.build
index f6f5ce1ecd..7f37b5d335 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -1,4 +1,3 @@
-crypto_ss = ss.source_set()
 crypto_ss.add(genh)
 crypto_ss.add(files(
   'afsplit.c',
@@ -52,15 +51,6 @@ if 'CONFIG_GNUTLS' in config_host
 endif
 
 
-crypto_ss = crypto_ss.apply(config_host, strict: false)
-libcrypto = static_library('crypto', crypto_ss.sources() + genh,
-                           dependencies: [crypto_ss.dependencies()],
-                           name_suffix: 'fa',
-                           build_by_default: false)
-
-crypto = declare_dependency(link_whole: libcrypto,
-                            dependencies: [authz, qom])
-
 util_ss.add(files('aes.c'))
 util_ss.add(files('init.c'))
 
-- 
2.26.2


