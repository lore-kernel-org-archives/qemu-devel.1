Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A46C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7283220757
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEmZiJLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7283220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwmJ-0005Hk-Jv
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwk8-0003xr-BT
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwk3-0004Q9-UG
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602504951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viKqtW92d35xTJa7T+6wHwnDgQrq/MCwuurOHJMzxPg=;
 b=CEmZiJLtvx2lwYdPbT6lWHxd9/SixnN+om9FKLYjtXKbABspUTn9U1jgI6IRSxfZipMzOW
 7GQS7GWTM5BE2szSzJVGH7ROWZikl1DqWY6vbSPxnBzHzh6HCeXfAoxtJz9w8ZALtlAh+3
 PRgBo3TMyPQCLL4ITJKW4ExKJZxZA/0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-nWtK6a-rOP-4UK03uXTwRQ-1; Mon, 12 Oct 2020 08:15:50 -0400
X-MC-Unique: nWtK6a-rOP-4UK03uXTwRQ-1
Received: by mail-wr1-f71.google.com with SMTP id 33so9156066wrf.22
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=viKqtW92d35xTJa7T+6wHwnDgQrq/MCwuurOHJMzxPg=;
 b=XVaeNbkwjvmurehJnmc2QZw2YnaFrLN+x+vTnWxQ5/MnxtjiwQmssjptQKQ4dB3XgE
 QeJLjftlMxzh9XXIudQHFIjsEz2pRqhqE2tLPkCiycHfXXSOBPu+231Tpa4pI3iAYPXX
 yilb+i1tlmpfh/ub9Q91bWjn9Muu4+Wrt8FdnJZE/evtQs6Tkm3INQoipl9wwyGciSPn
 a7lvPIH4tstAFO06YewYsci5h66dlyb1xZIC1iA0/CJpEE59p7V8YHXKaqRba8lOeTbZ
 tNPUMn2JJzUou02PBZqRwXRjWUToyfNgGjbZ7HiTkH46QdMh7lso1+vE7uDLdTP7cNNF
 leqA==
X-Gm-Message-State: AOAM532FRaYS58Teg1TmbRpGGNGoXH0aka2wCODhzMMwELNhFegMcGH2
 02thUtpSSUND/WIZbo5MVtRD0JjfEhlEcIdmdk7jdLMcSW5EIrbzBxJr2yc2Ew5K6GLlzo7GlV1
 u795Aw35BtCfwfZE=
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr10494752wmj.101.1602504948406; 
 Mon, 12 Oct 2020 05:15:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSTp5oA+ATMwskMLC15+i15T52Bsgl0BpNcXAQsz6ECrlKNn5AKLL7KnqTgukOGhRYBfouZw==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr10494731wmj.101.1602504948134; 
 Mon, 12 Oct 2020 05:15:48 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id s125sm10868074wms.42.2020.10.12.05.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:15:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v2 2/5] qapi: Restrict 'system wakeup/reset/powerdown'
 commands to machine.json
Date: Mon, 12 Oct 2020 14:15:33 +0200
Message-Id: <20201012121536.3381997-3-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Restricting system_wakeup/system_reset/system_powerdown to
machine.json pulls slightly less QAPI-generated code into
user-mode and tools.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json    | 57 -----------------------------------------------
 ui/gtk.c          |  1 +
 ui/cocoa.m        |  1 +
 4 files changed, 59 insertions(+), 57 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 073b1c98b26..55328d4f3ca 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -452,6 +452,63 @@
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
 
+##
+# @system_reset:
+#
+# Performs a hard reset of a guest.
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "system_reset" }
+# <- { "return": {} }
+#
+##
+{ 'command': 'system_reset' }
+
+##
+# @system_powerdown:
+#
+# Requests that a guest perform a powerdown operation.
+#
+# Since: 0.14.0
+#
+# Notes: A guest may or may not respond to this command.  This command
+#        returning does not indicate that a guest has accepted the request or
+#        that it has shut down.  Many guests will respond to this command by
+#        prompting the user in some way.
+# Example:
+#
+# -> { "execute": "system_powerdown" }
+# <- { "return": {} }
+#
+##
+{ 'command': 'system_powerdown' }
+
+##
+# @system_wakeup:
+#
+# Wake up guest from suspend. If the guest has wake-up from suspend
+# support enabled (wakeup-suspend-support flag from
+# query-current-machine), wake-up guest from suspend if the guest is
+# in SUSPENDED state. Return an error otherwise.
+#
+# Since:  1.1
+#
+# Returns:  nothing.
+#
+# Note: prior to 4.0, this command does nothing in case the guest
+#       isn't suspended.
+#
+# Example:
+#
+# -> { "execute": "system_wakeup" }
+# <- { "return": {} }
+#
+##
+{ 'command': 'system_wakeup' }
+
 ##
 # @LostTickPolicy:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 3fe9cc21b4b..90fd862a6cb 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -177,40 +177,6 @@
 ##
 { 'command': 'stop' }
 
-##
-# @system_reset:
-#
-# Performs a hard reset of a guest.
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "system_reset" }
-# <- { "return": {} }
-#
-##
-{ 'command': 'system_reset' }
-
-##
-# @system_powerdown:
-#
-# Requests that a guest perform a powerdown operation.
-#
-# Since: 0.14.0
-#
-# Notes: A guest may or may not respond to this command.  This command
-#        returning does not indicate that a guest has accepted the request or
-#        that it has shut down.  Many guests will respond to this command by
-#        prompting the user in some way.
-# Example:
-#
-# -> { "execute": "system_powerdown" }
-# <- { "return": {} }
-#
-##
-{ 'command': 'system_powerdown' }
-
 ##
 # @memsave:
 #
@@ -318,29 +284,6 @@
 ##
 { 'command': 'x-exit-preconfig', 'allow-preconfig': true }
 
-##
-# @system_wakeup:
-#
-# Wake up guest from suspend. If the guest has wake-up from suspend
-# support enabled (wakeup-suspend-support flag from
-# query-current-machine), wake-up guest from suspend if the guest is
-# in SUSPENDED state. Return an error otherwise.
-#
-# Since:  1.1
-#
-# Returns:  nothing.
-#
-# Note: prior to 4.0, this command does nothing in case the guest
-#       isn't suspended.
-#
-# Example:
-#
-# -> { "execute": "system_wakeup" }
-# <- { "return": {} }
-#
-##
-{ 'command': 'system_wakeup' }
-
 ##
 # @human-monitor-command:
 #
diff --git a/ui/gtk.c b/ui/gtk.c
index b11594d817a..a752aa22be0 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -33,6 +33,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qemu/cutils.h"
 
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 0910b4a7166..f32adc3074f 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -35,6 +35,7 @@
 #include "sysemu/cpu-throttle.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "sysemu/blockdev.h"
 #include "qemu-version.h"
-- 
2.26.2


