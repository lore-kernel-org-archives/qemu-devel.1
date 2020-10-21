Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AD0C388EC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 03:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9E82242E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 03:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3TnwpLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9E82242E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV4v1-00088b-Jy
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 23:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV4s6-0004II-C2
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 23:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV4s3-0001Y6-6B
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 23:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603251182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvCBLHwDCjYXjJa2+mcg+A8fGqoFuq64vG+oZlIMljY=;
 b=X3TnwpLyNsLsxG/zBva/D3Lv4NZCgQtsT9YMb21gevMBhPOxSof4129UR20q+g1sT68lrm
 MoDKecgGAQiwvcT2UF+7oxlMvQ8wi72ggd5kHVyfZYvnGsMXkw90UPHSRX41G2BjdCFGHy
 itfR/BkSQ6YMjWm/EYSqxz0k0tSRyJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-ueGxpkrANViWT3ypMO-0EQ-1; Tue, 20 Oct 2020 23:33:00 -0400
X-MC-Unique: ueGxpkrANViWT3ypMO-0EQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 427281074656;
 Wed, 21 Oct 2020 03:32:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC83575123;
 Wed, 21 Oct 2020 03:32:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BA5B112991E; Wed, 21 Oct 2020 05:32:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] qapi: Restrict 'system wakeup/reset/powerdown' commands to
 machine.json
Date: Wed, 21 Oct 2020 05:32:54 +0200
Message-Id: <20201021033257.2126624-3-armbru@redhat.com>
In-Reply-To: <20201021033257.2126624-1-armbru@redhat.com>
References: <20201021033257.2126624-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:40:15
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Restricting system_wakeup/system_reset/system_powerdown to
machine.json pulls slightly less QAPI-generated code into
user-mode and tools.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201012121536.3381997-3-philmd@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
index 3fe9cc21b4..90fd862a6c 100644
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


