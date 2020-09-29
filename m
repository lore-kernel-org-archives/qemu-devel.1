Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BB6C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C992076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbhFWeIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C992076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNM82-0003Xw-8O
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM63-0001kV-1i
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM60-0003Sj-Pg
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=by3mjscHzH8BrvrziJQjGxD6sRKUaSNInuuU6bh+wgE=;
 b=TbhFWeImOdJgysY3DdWhHrS/CopOrdIpCsLf+lj20NlPrksi5Ngk/mpeFsO6yhXQ5avFt2
 Mdfojyyzk+bJVXI6GRsS5+t7JNxqFc23dTWzkqpXHRUXxQjZzDBkfTOf+E8+plZyvqeq8C
 kHoYAD/6Q2NQcpedkpYfbPHZDR1NIVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-I6Tb2dknOKuk81D5jRqiuw-1; Tue, 29 Sep 2020 16:19:29 -0400
X-MC-Unique: I6Tb2dknOKuk81D5jRqiuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DC9118BE160;
 Tue, 29 Sep 2020 20:19:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0783D19C4F;
 Tue, 29 Sep 2020 20:19:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F11B11386A0; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/29] qapi: Restrict LostTickPolicy enum to machine code
Date: Tue, 29 Sep 2020 22:18:58 +0200
Message-Id: <20200929201926.2155622-2-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Restricting LostTickPolicy to machine.json pulls slightly less
QAPI-generated code into user-mode.

Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200913195348.1064154-2-philmd@redhat.com>
[Add rationale to commit message]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json            | 32 ++++++++++++++++++++++++++++++++
 qapi/misc.json               | 32 --------------------------------
 include/hw/rtc/mc146818rtc.h |  2 +-
 hw/core/qdev-properties.c    |  1 +
 hw/i386/kvm/i8254.c          |  2 +-
 5 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index d8ed096e9a..8e2164a0b6 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -402,6 +402,38 @@
 ##
 { 'command': 'query-target', 'returns': 'TargetInfo' }
 
+##
+# @LostTickPolicy:
+#
+# Policy for handling lost ticks in timer devices.  Ticks end up getting
+# lost when, for example, the guest is paused.
+#
+# @discard: throw away the missed ticks and continue with future injection
+#           normally.  The guest OS will see the timer jump ahead by a
+#           potentially quite significant amount all at once, as if the
+#           intervening chunk of time had simply not existed; needless to
+#           say, such a sudden jump can easily confuse a guest OS which is
+#           not specifically prepared to deal with it.  Assuming the guest
+#           OS can deal correctly with the time jump, the time in the guest
+#           and in the host should now match.
+#
+# @delay: continue to deliver ticks at the normal rate.  The guest OS will
+#         not notice anything is amiss, as from its point of view time will
+#         have continued to flow normally.  The time in the guest should now
+#         be behind the time in the host by exactly the amount of time during
+#         which ticks have been missed.
+#
+# @slew: deliver ticks at a higher rate to catch up with the missed ticks.
+#        The guest OS will not notice anything is amiss, as from its point
+#        of view time will have continued to flow normally.  Once the timer
+#        has managed to catch up with all the missing ticks, the time in
+#        the guest and in the host should match.
+#
+# Since: 2.0
+##
+{ 'enum': 'LostTickPolicy',
+  'data': ['discard', 'delay', 'slew' ] }
+
 ##
 # @NumaOptionsType:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 8cf6ebe67c..b21963a176 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -8,38 +8,6 @@
 
 { 'include': 'common.json' }
 
-##
-# @LostTickPolicy:
-#
-# Policy for handling lost ticks in timer devices.  Ticks end up getting
-# lost when, for example, the guest is paused.
-#
-# @discard: throw away the missed ticks and continue with future injection
-#           normally.  The guest OS will see the timer jump ahead by a
-#           potentially quite significant amount all at once, as if the
-#           intervening chunk of time had simply not existed; needless to
-#           say, such a sudden jump can easily confuse a guest OS which is
-#           not specifically prepared to deal with it.  Assuming the guest
-#           OS can deal correctly with the time jump, the time in the guest
-#           and in the host should now match.
-#
-# @delay: continue to deliver ticks at the normal rate.  The guest OS will
-#         not notice anything is amiss, as from its point of view time will
-#         have continued to flow normally.  The time in the guest should now
-#         be behind the time in the host by exactly the amount of time during
-#         which ticks have been missed.
-#
-# @slew: deliver ticks at a higher rate to catch up with the missed ticks.
-#        The guest OS will not notice anything is amiss, as from its point
-#        of view time will have continued to flow normally.  Once the timer
-#        has managed to catch up with all the missing ticks, the time in
-#        the guest and in the host should match.
-#
-# Since: 2.0
-##
-{ 'enum': 'LostTickPolicy',
-  'data': ['discard', 'delay', 'slew' ] }
-
 ##
 # @add_client:
 #
diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
index 6224b5276a..5b45b22924 100644
--- a/include/hw/rtc/mc146818rtc.h
+++ b/include/hw/rtc/mc146818rtc.h
@@ -9,7 +9,7 @@
 #ifndef HW_RTC_MC146818RTC_H
 #define HW_RTC_MC146818RTC_H
 
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 #include "hw/isa/isa.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 098298c78e..343c824da0 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -4,6 +4,7 @@
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "qapi/qapi-types-block.h"
+#include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index e18fd337fa..40d84734e7 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include <linux/kvm.h>
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-- 
2.26.2


