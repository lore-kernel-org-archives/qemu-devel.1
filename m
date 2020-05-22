Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF98C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB38220679
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACeaS2sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB38220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAkR-00052I-2W
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAh5-0007Nb-8n
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAh4-0002Wm-FU
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590165525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=az8pj3ArsVB5H8vNRsyPhpcnKHlQHKIjS7ekh/fQInY=;
 b=ACeaS2smVVrwamTw73kT5FBCrLV3k8+StfXYXn7cVYPdW4XdYMAx35Ys7EFzC4zCFYZ8wY
 qXUJV0lkMw4f1o/LBMnVdLCjxxCgpVT/5XUObEmhcU8QeuflQ9HWaBFI6mSXL3PdOO+pdB
 zbjFo56MHG47jtLJIU+4ioC60Zuf6mg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-2zpiFFjLOk2LK5srTZbgow-1; Fri, 22 May 2020 12:38:43 -0400
X-MC-Unique: 2zpiFFjLOk2LK5srTZbgow-1
Received: by mail-wr1-f72.google.com with SMTP id h6so3744703wrx.4
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=az8pj3ArsVB5H8vNRsyPhpcnKHlQHKIjS7ekh/fQInY=;
 b=U8PmKLD1cWTxJUXp47dg4c6IURAuOg7mNLQ5iQGMyjaIH6MQbTkJ3kU6OAml8tHj7d
 dAXJRyihU72ODOhHNUnToJPPPpMDs1CNNM/2KCMPv1Tfoxz0eIDLouya7VL9Sopqin18
 EHHtN9SlSfUGvZYxZYwULDSlikv5hWF2wp9zVkMJP3v1L0y9Zb8ufq/A6iJWEre+1Nv7
 ng2LttLMbeRGtMwF3zR5H+zFoAdFvhcYJlTaaAmjOhE8sIXUhqBenRaEvK42GK7WAGF8
 XSoDU2W7ipSl/zrf0cUzuu89/oMOi9KJbP7a/Iz3PgzIstD0WYR3z4C1J/clD7sdAbsT
 4FCA==
X-Gm-Message-State: AOAM530CzHfkJobWwd4SCg4Cc4m9ngVwKLFDe7Z/8C5w7Avnq3127mwS
 sM17oTSLpWKAI4Qyju1Vn2nxvzByG/qsiUvYkGjwogRXjN/xOTGtdVTaqFj63uQSRSs2zB93r10
 ir2drJp+EevN20/s=
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr15150111wme.177.1590165521670; 
 Fri, 22 May 2020 09:38:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvIaTtKMFh7HlwRvGKT72YdFGv34yXyjnOQyJpc5k6PKe+opSSoNomaK1nTqMZSfcy7N4tuQ==
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr15150101wme.177.1590165521535; 
 Fri, 22 May 2020 09:38:41 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z132sm11026086wmc.29.2020.05.22.09.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:38:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/11] accel/Kconfig: Add the TCG selector
Date: Fri, 22 May 2020 18:37:57 +0200
Message-Id: <20200522163759.11480-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522163759.11480-1-philmd@redhat.com>
References: <20200522163759.11480-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:11:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expose the CONFIG_TCG selector to let minikconf.py uses it.

When building with --disable-tcg build, this helps to deselect
devices that are TCG-dependent.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile      | 1 +
 accel/Kconfig | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 648757f79a..f8a45e1379 100644
--- a/Makefile
+++ b/Makefile
@@ -405,6 +405,7 @@ endif
 MINIKCONF_ARGS = \
     $(CONFIG_MINIKCONF_MODE) \
     $@ $*/config-devices.mak.d $< $(MINIKCONF_INPUTS) \
+    CONFIG_TCG=$(CONFIG_TCG) \
     CONFIG_KVM=$(CONFIG_KVM) \
     CONFIG_SPICE=$(CONFIG_SPICE) \
     CONFIG_IVSHMEM=$(CONFIG_IVSHMEM) \
diff --git a/accel/Kconfig b/accel/Kconfig
index c21802bb49..2ad94a3839 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -1,3 +1,6 @@
+config TCG
+    bool
+
 config KVM
     bool
 
-- 
2.21.3


