Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C37C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C446F20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6aBA58B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C446F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpC0-0004Iu-EL
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDoR1-0004oo-3H
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDoQz-0001B8-VN
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20562
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDoQz-00010q-NJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584360089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfpaJ5Wss4aHzGmNHTua/cMpD1oC/uXgC8diSHVBL7Y=;
 b=X6aBA58BL91KReBExiT+oZyMX7z+qfWe+iRcXkmy6exvtKycB8NFpTwDD9+OixDgmFWqyw
 6gN6M9WKiEAZi/WJQ1RydTSWo01TmvEc40DmuArVlUI9knZDcKbaP38YfdFHVG84Yg3PhA
 aP4T7WVj8qIgyXsgiptAwjD0m8qk0qQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-5FkrKCdiPViipX57j5W0-w-1; Mon, 16 Mar 2020 08:01:27 -0400
X-MC-Unique: 5FkrKCdiPViipX57j5W0-w-1
Received: by mail-wm1-f69.google.com with SMTP id z26so4820734wmk.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dHYBOvMZhp1yGgRvopFKO+/8EMIkCFlQoodx2YbRmac=;
 b=JjpoISIksDRhqAC+ZHiLV43vtWqH5yf8mtJCtwj2jxs7GWfr4QhL+1/pA+4g9Ft/FK
 3CS1W96wXO1UfS+29CfNvdsOszBZg1s0NePPLuN+gsV1fmfPUiOyd3a6wE7Isyhf5+ql
 NW6tZGMhokVXObpq1301ahcKeiNaWGUVqOXZNukJN9AMod9ZcipAXU/2e2v2RZ/dAuHn
 ARrIkDCdG7J0aSunGVmoSFo4LDoPNV6uPORc2cK8DuSn83lM6LFejNlwybspoJfuYbzP
 SPaOo1SjxYDIzMapLF1ZEzzd5WGEEEKKY4LCFRVeDGQ+KRj9uqmxKXv5Uoi7ChEQOsYJ
 3qKw==
X-Gm-Message-State: ANhLgQ3PHNz2NqE+EWRJxPbBFbNz1m6zPfp7jh6qboXD9uEoMvgRitMr
 Zbf2jdXUJ3vV9nUS+u6R2KFa031JDoFMUEfrv7iPaNeByl7YGrmKk8EvMDti3XSfQPg0AHK7qC8
 Tcp1BAV5z++Qn0Do=
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr28321363wmj.170.1584360086074; 
 Mon, 16 Mar 2020 05:01:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs7gTIKJUtuP0gnWLV5S19Srnqr1Leagw9X2YDVmolUK0tMyzlDHibU2ovJj5AeklAYaoNDvA==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr28321342wmj.170.1584360085845; 
 Mon, 16 Mar 2020 05:01:25 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id c5sm25935142wma.3.2020.03.16.05.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:01:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/11] accel/Kconfig: Extract accel selectors into their own
 config
Date: Mon, 16 Mar 2020 13:00:44 +0100
Message-Id: <20200316120049.11225-7-philmd@redhat.com>
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
X-Received-From: 205.139.110.61
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

Move the accel selectors from the global Kconfig.host to their
own Kconfig file.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile      | 1 +
 Kconfig.host  | 7 -------
 accel/Kconfig | 6 ++++++
 3 files changed, 7 insertions(+), 7 deletions(-)
 create mode 100644 accel/Kconfig

diff --git a/Makefile b/Makefile
index d83a94bc53..d1e2ec10e7 100644
--- a/Makefile
+++ b/Makefile
@@ -419,6 +419,7 @@ MINIKCONF_ARGS =3D \
     CONFIG_PVRDMA=3D$(CONFIG_PVRDMA)
=20
 MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host \
+                   $(SRC_PATH)/accel/Kconfig \
                    $(SRC_PATH)/hw/Kconfig
 MINIKCONF_DEPS =3D $(MINIKCONF_INPUTS) \
                  $(wildcard $(SRC_PATH)/hw/*/Kconfig)
diff --git a/Kconfig.host b/Kconfig.host
index 55136e037d..a6d871c399 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -2,9 +2,6 @@
 # down to Kconfig.  See also MINIKCONF_ARGS in the Makefile:
 # these two need to be kept in sync.
=20
-config KVM
-    bool
-
 config LINUX
     bool
=20
@@ -31,10 +28,6 @@ config VHOST_KERNEL
     bool
     select VHOST
=20
-config XEN
-    bool
-    select FSDEV_9P if VIRTFS
-
 config VIRTFS
     bool
=20
diff --git a/accel/Kconfig b/accel/Kconfig
new file mode 100644
index 0000000000..c21802bb49
--- /dev/null
+++ b/accel/Kconfig
@@ -0,0 +1,6 @@
+config KVM
+    bool
+
+config XEN
+    bool
+    select FSDEV_9P if VIRTFS
--=20
2.21.1


