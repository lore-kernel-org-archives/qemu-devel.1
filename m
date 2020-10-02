Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25909C47423
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD25921D24
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uu3UBB/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD25921D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLJO-0000ky-Op
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLHj-0007Ta-RL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLHh-0005Qy-2z
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601645980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbK1m63mIh7G9YoSTt+lY9Rt1IngmCv52ys5F1Xv+Ck=;
 b=Uu3UBB/eBIZLRBxr/GKPc14VcSn2csCaxmXks06WflkrmIpYV2LU+DmKnQ+akzhTI+nipx
 QuR9bXjyODJjqrv8WyqmIQw0oopDoIHWDh/3k5bJcmDoTSjvROhQFa82GfXqqxp+Vhecey
 Cff8hZKjnDACwarcTk8YZGmgaNWQclc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-6rI3QRIqMvGDfNZICdBKgw-1; Fri, 02 Oct 2020 09:39:38 -0400
X-MC-Unique: 6rI3QRIqMvGDfNZICdBKgw-1
Received: by mail-wr1-f70.google.com with SMTP id a10so546799wrw.22
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kbK1m63mIh7G9YoSTt+lY9Rt1IngmCv52ys5F1Xv+Ck=;
 b=DoR0LF5jOPfcpTDeiU1NdzksEWVqbMz27aP+jMYlfLTsCwbdVh1+sPClXwakqzpyFC
 bFuRW7eZuOnk5zJLhjoF6L8nCV2ZJinE5s9j88n5VbIivO8MA0H2lpicsWu8QR6Iwoyt
 ZR7QqTINYL0IYsxrDKn3X84oK3hC1fSWVPjwNTPEdOdXlPrWz9OfzK2Ovta5Ym5fJDzd
 sH7F54ObnnTdMCv0Zbze296qNo2/ZaROiPbpo7YPpq3n1Woz1g9EyxXH4RCY4fqGCVBk
 GeUKfBJyXaE3H7OVfOkVDZpxda+W0IhTfbFWYGoUCbGqdLKUIxrVnBxpxtaT2aQPMpEz
 1Dgg==
X-Gm-Message-State: AOAM530m6v0lbhhlN2MqcE9ppXmoIHi+ro+hwg3SsiQ4iS41LVienKWi
 XkVNY0+AMvPzy+WNFAmLYefwoUqdVcspNYHwUAHdcDF9WhpA+Z6WRnx4wqs+4QG/Ozny/3KsRxE
 xLixl9YccT61Ct4k=
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr3042797wmb.138.1601645977326; 
 Fri, 02 Oct 2020 06:39:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwD/heYmqaLVMQtumsMQOWyseI2hOgaXTBn2HXZs+0th/9VfQZ/6fqWSoQPr8a9Q2Va+FrerA==
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr3042765wmb.138.1601645977099; 
 Fri, 02 Oct 2020 06:39:37 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id r19sm1784306wmh.7.2020.10.02.06.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 06:39:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] qapi: Restrict 'system wakeup/reset/powerdown' commands
 to machine.json
Date: Fri,  2 Oct 2020 15:39:20 +0200
Message-Id: <20201002133923.1716645-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002133923.1716645-1-philmd@redhat.com>
References: <20201002133923.1716645-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restricting system_wakeup/system_reset/system_powerdown to
machine.json pulls slightly less QAPI-generated code into
user-mode and tools.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json    | 57 -----------------------------------------------
 ui/gtk.c          |  1 +
 ui/cocoa.m        |  1 +
 4 files changed, 59 insertions(+), 57 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 073b1c98b2..55328d4f3c 100644
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
index 37b3e04cec..cce2e71e9c 100644
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
index b11594d817..a752aa22be 100644
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
index 0910b4a716..f32adc3074 100644
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


