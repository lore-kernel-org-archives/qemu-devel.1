Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52545C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1161A2146E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGcIXsWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1161A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ejV-0000dY-7P
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 19:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ehM-0006DL-Sg
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ehK-000353-VR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:49:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58324
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ehK-000344-Sa
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583369350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjETIBQNzsyZ+xRKKECdXFIBvuCR8b8nsZGdNL5G0cQ=;
 b=SGcIXsWFx38Rw9p3RdgS5rlMvU7HNrupyB2bOdVuXpsygYPuLUyCrVl6/1C0h27SunKwpO
 WhO5n4JfR/iBnUPrG4MabQrB/8QWe/sq2XL4/Fx5j0SWE6t44WuXVjfwauJjDRMtBD6RBQ
 8uiImk2mgo4UU5fk8zMIEJoCtsKx04s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-PPdQ8kBlM6SCWGzZ-SyncQ-1; Wed, 04 Mar 2020 19:49:09 -0500
X-MC-Unique: PPdQ8kBlM6SCWGzZ-SyncQ-1
Received: by mail-wm1-f71.google.com with SMTP id j130so1433890wmj.9
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 16:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ix/W8AfQRhp1de4p5m7tRDcjdb+HvfRtvsCyJ6jZ204=;
 b=NBNeX20ko0rPG9lNApAuS4vTVdM3heGeHdIpV7z5fHTlpk7HBqi7S2okheV7f6Ir5Y
 9BBmO4FBvqXrbRWxCfAebyLgi2gRYcMEHW5a7jRsmlySRC7oG1j0awo6djz8TY5FCeqv
 RUw6FnDTBcnVOtQk+qD7MjxTc0h0zt52ZVEboyVUGFMPiywcrl2U7mAvuQ69AN50IXFk
 YaQmP6xllG2m7BP4/tfta6rThqxi/wl+1vKMxyF5SFp1qxmC3yYL0oUdOPNDoLmzlmWh
 Qgdlx/IETh6eHEZVf+lWGxUnnTVKdq3PUJZ/66ohsx/IKDEiJS4PJz7AhVkujqfSm+XB
 +2OQ==
X-Gm-Message-State: ANhLgQ0dX1Wi9gdGtZCdDKCf0MNRm9TWBLGH/sVn1ulxM3aFqUQdosmH
 brteD4dYN70N58n7DVcFSAf3B2WwSANZ6uW40d20tw8STDXMKijp+Yt5p3KELt6ssoTwj4oIQ2i
 hRKfvLGZ9CxlxGXA=
X-Received: by 2002:adf:aa9e:: with SMTP id h30mr6965776wrc.288.1583369347614; 
 Wed, 04 Mar 2020 16:49:07 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuXDgM4HSebXJGn832stjAWZU4tJW+9+FOFNtO829vUKDOFLVxkA8AQPdRL8cceKajnF7zyZg==
X-Received: by 2002:adf:aa9e:: with SMTP id h30mr6965754wrc.288.1583369347474; 
 Wed, 04 Mar 2020 16:49:07 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id w9sm3321715wrn.35.2020.03.04.16.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 16:49:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] Makefile: Let the 'help' target list the tools targets
Date: Thu,  5 Mar 2020 01:48:55 +0100
Message-Id: <20200305004855.9665-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305004855.9665-1-philmd@redhat.com>
References: <20200305004855.9665-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

List the name of the tool targets when calling 'make help':

  $ make help
  [...]
  Tools targets:
    qemu-ga                        - Build qemu-ga tool
    qemu-keymap                    - Build qemu-keymap tool
    elf2dmp                        - Build elf2dmp tool
    ivshmem-client                 - Build ivshmem-client tool
    ivshmem-server                 - Build ivshmem-server tool
    qemu-nbd                       - Build qemu-nbd tool
    qemu-img                       - Build qemu-img tool
    qemu-io                        - Build qemu-io tool
    qemu-edid                      - Build qemu-edid tool
    fsdev/virtfs-proxy-helper      - Build virtfs-proxy-helper tool
    scsi/qemu-pr-helper            - Build qemu-pr-helper tool

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index a9ede4f428..4a1d3e2a79 100644
--- a/Makefile
+++ b/Makefile
@@ -1240,6 +1240,11 @@ endif
 =09=09$(foreach t, $(TARGET_DIRS), \
 =09=09$(call print-help-run,$(t)/all,Build for $(t));) \
 =09=09echo '')
+=09@$(if $(TOOLS), \
+=09=09echo 'Tools targets:'; \
+=09=09$(foreach t, $(TOOLS), \
+=09=09$(call print-help-run,$(t),Build $(shell basename $(t)) tool);) \
+=09=09echo '')
 =09@echo  'Cleaning targets:'
 =09$(call print-help,clean,Remove most generated files but keep the config=
)
 ifdef CONFIG_GCOV
--=20
2.21.1


