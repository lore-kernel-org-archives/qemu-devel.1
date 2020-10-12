Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946D9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E653820708
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpBuij37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E653820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwrY-0002NU-OI
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwkG-00041Z-Hs
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwkE-0004UM-4X
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602504960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVbl2qcLfPZK8dPLUOsl+/Lzy6Uv2A5ihgqCUULlvlE=;
 b=EpBuij37qpzP/DyVOeClt5swhn4kaKok96oOx0IywUVrqRDx7Gi92tpfkjIuSYlqaPVL1F
 nac3f8Ry/hk5yDZPp32Dv2PoBkDZbYQv1XMa1tubiYkDyHEfcgRd2FAydHVHKk2lIIHhwi
 afLJl6B1+i/YGm6uIQyWdwmuWgs4OV4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-QAs74YAKOfCphPfQNfARPw-1; Mon, 12 Oct 2020 08:15:59 -0400
X-MC-Unique: QAs74YAKOfCphPfQNfARPw-1
Received: by mail-wm1-f72.google.com with SMTP id r19so5689087wmh.9
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eVbl2qcLfPZK8dPLUOsl+/Lzy6Uv2A5ihgqCUULlvlE=;
 b=WokAjQMeWpy8cfSl2AMtwLFjIkwPa+Y6FtFPh0XgOEp7jz3qegEWMZqjxsxtJBERDX
 dvWib2UV9a98jJOu0v8G6jy4kly/SfzLtZApKBRKsTLo7Lvj68O/IdelmYpBd1tf5LGh
 xAjlaifoKvOGPq8eCzi7QCuw9TRJed2WRoRXa5ujzlmLnQpm8EdycrHZiWHz3yjuGiub
 HKYB6nG+bC73d08ha93jIb7K1M2UTT4GX4bxbXs9UgA/w4pluB1dgIHrk5UrkOj/C0Z7
 NA+ZmrCYACS9QI1FbuegMon5uaTsFi7sdjQFS4NTXk1Zt74WVG0lCKLTyN5tOzs3rTTZ
 TPCQ==
X-Gm-Message-State: AOAM531ArAFC4hrwPx9PC9gCBrr2+6ZeNVKH9OOagPUXGmASV8VDDZuq
 DnsfnkJxHhXwGXiWoZjLCEd6AAQBH6dwMzvw1uBxzOqW3A5aOMIfY4UjPGPjZ2OlMZfdEnE7wuk
 ZnmApXEYdYvKNeL4=
X-Received: by 2002:adf:ef51:: with SMTP id c17mr31772479wrp.301.1602504957777; 
 Mon, 12 Oct 2020 05:15:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymFeRl3j1aDWUmV0KgxGAEjfscYfHtOnoUSc501uNPKWvhbXQ1OAoLW4eYPA98OGvbNf0HRQ==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr31772466wrp.301.1602504957618; 
 Mon, 12 Oct 2020 05:15:57 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id g83sm22920027wmf.15.2020.10.12.05.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:15:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v2 4/5] qapi: Restrict 'query-kvm' command to machine code
Date: Mon, 12 Oct 2020 14:15:35 +0200
Message-Id: <20201012121536.3381997-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012121536.3381997-1-philmd@redhat.com>
References: <20201012121536.3381997-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restricting query-kvm to machine.json pulls slightly
less QAPI-generated code into user-mode and tools.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 30 ++++++++++++++++++++++++++++++
 qapi/misc.json    | 30 ------------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 5a3bbcae01b..7c9a263778d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -561,6 +561,36 @@
 ##
 { 'command': 'inject-nmi' }
 
+##
+# @KvmInfo:
+#
+# Information about support for KVM acceleration
+#
+# @enabled: true if KVM acceleration is active
+#
+# @present: true if KVM acceleration is built into this executable
+#
+# Since: 0.14.0
+##
+{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
+
+##
+# @query-kvm:
+#
+# Returns information about KVM acceleration
+#
+# Returns: @KvmInfo
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-kvm" }
+# <- { "return": { "enabled": true, "present": true } }
+#
+##
+{ 'command': 'query-kvm', 'returns': 'KvmInfo' }
+
 ##
 # @NumaOptionsType:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 9fa702b0f66..363115c1edb 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -68,36 +68,6 @@
 ##
 { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
-##
-# @KvmInfo:
-#
-# Information about support for KVM acceleration
-#
-# @enabled: true if KVM acceleration is active
-#
-# @present: true if KVM acceleration is built into this executable
-#
-# Since: 0.14.0
-##
-{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
-
-##
-# @query-kvm:
-#
-# Returns information about KVM acceleration
-#
-# Returns: @KvmInfo
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-kvm" }
-# <- { "return": { "enabled": true, "present": true } }
-#
-##
-{ 'command': 'query-kvm', 'returns': 'KvmInfo' }
-
 ##
 # @IOThreadInfo:
 #
-- 
2.26.2


