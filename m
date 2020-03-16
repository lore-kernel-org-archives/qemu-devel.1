Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0631C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997CB20754
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WldMrYth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997CB20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDqV2-0001rn-Aa
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDoRC-0004st-5S
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDoRA-0003gj-AX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35364
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDoRA-0003Z0-1l
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584360099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HlGkUQINU1XL5BZcdoDWS13ome2PPFT7O4TXXUDcprw=;
 b=WldMrYthIRFkeVin2caijG8AkQlNfcvoRkqOEJga4A62ijCZDHLIot5gE+crsfreotXa2D
 FgvEBUYY2ZLO++7KFA9Tzvtr/l4UpfDTiWzZotnIsmawYswEUXByNnbsgej3670fu0Wltd
 RbstnCX95ZSVyHS0Kl/l0u52n9cnNGM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-vHT4nODjNfarwmfefKbxbg-1; Mon, 16 Mar 2020 08:01:38 -0400
X-MC-Unique: vHT4nODjNfarwmfefKbxbg-1
Received: by mail-wr1-f72.google.com with SMTP id u18so8847725wrn.11
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fXllARJpmIuUPtHipMeTZSkndpZ7FGG8n+mythjRvfc=;
 b=qrd/2G40fALavdYgJVuivn0Johduf1yJUT6/MPnM+adlwsyEFgePGkztUZQ7/s7HMh
 ndUQHWcBARaYkufN1YtzMTyBudz2LO2eu1CIZDkdzKGfQ3BXwkkQJQZdA0N+7Etxdtw7
 N/iOUen9Ls/VGcpLf6Mfv8JkCG9znVr4JhB7BZj7Tv3jHSThaLBWSt2wRqp/xOBy8F5O
 QF18l5zuy7U12x8/J1a3cwV/sfrzhKwrAYYqvKoOLzYy3l+Y0DE+vwb9xUGxnwwTuKIn
 LDJ9Vi4/ujnw5fk2uoQq9JA1z5Wjm3Vc3B3n7wSi0xCXgQ/xwd0rylWI42SlxyA/1Vg9
 3OiQ==
X-Gm-Message-State: ANhLgQ2BE108m4zbCrN3r1NwF0tokhYdWRj71XDYXPRcTnvVNOLYRpSf
 1v/dkcIVeQpY8ITll7J9NpDGufb0VNV8HvxCWaVbpAEmz5fzu34oaUE4wTlX0z3TgDuiP7pc5k/
 UoaasVK2pa3YlBbA=
X-Received: by 2002:a5d:66c2:: with SMTP id k2mr10999575wrw.408.1584360096848; 
 Mon, 16 Mar 2020 05:01:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuDJHiZxwpQzdRJzQb4B10w+dJRi5gbqeE8iLVTMi6greRpAqxzKWoY5v8KNqfA+KRY3TJMJw==
X-Received: by 2002:a5d:66c2:: with SMTP id k2mr10999537wrw.408.1584360096456; 
 Mon, 16 Mar 2020 05:01:36 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id c26sm29139172wmb.8.2020.03.16.05.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:01:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/11] target/Kconfig: Allow targets to use Kconfig
Date: Mon, 16 Mar 2020 13:00:46 +0100
Message-Id: <20200316120049.11225-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316120049.11225-1-philmd@redhat.com>
References: <20200316120049.11225-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow targets to select target-specific Kconfig values.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile       | 6 ++++--
 target/Kconfig | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)
 create mode 100644 target/Kconfig

diff --git a/Makefile b/Makefile
index 1cf9d76ce7..e402c33811 100644
--- a/Makefile
+++ b/Makefile
@@ -421,9 +421,11 @@ MINIKCONF_ARGS =3D \
=20
 MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host \
                    $(SRC_PATH)/accel/Kconfig \
-                   $(SRC_PATH)/hw/Kconfig
+                   $(SRC_PATH)/hw/Kconfig \
+                   $(SRC_PATH)/target/Kconfig
 MINIKCONF_DEPS =3D $(MINIKCONF_INPUTS) \
-                 $(wildcard $(SRC_PATH)/hw/*/Kconfig)
+                 $(wildcard $(SRC_PATH)/hw/*/Kconfig) \
+                 $(wildcard $(SRC_PATH)/target/*/Kconfig)
 MINIKCONF =3D $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
=20
 $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIK=
CONF_DEPS) $(BUILD_DIR)/config-host.mak
diff --git a/target/Kconfig b/target/Kconfig
new file mode 100644
index 0000000000..8b13789179
--- /dev/null
+++ b/target/Kconfig
@@ -0,0 +1 @@
+
--=20
2.21.1


