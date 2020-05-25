Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF34C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0E42073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vq8TqF+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0E42073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEku-0002TL-LO
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEgu-0005IT-HU
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEgt-0006fd-Iz
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590419219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhbiaGeyOZtfxUrFs0y2evFWTskfzhbIggYBhtmEIh4=;
 b=Vq8TqF+EK+7iyvlGipcCeLsxd3MbONpBw7KW5tFFWmWfTopPVmOKKI5YngA7wazQLqPKr/
 z9RBUuG/LEBiE9fckzDCdgoBMglSf7V7kCFCjjT6J1Msz9xFve9j3IF90xyAtij2b6bcoc
 Sbz5od0cffGRF/hv6R4S5sVjwlqhCJM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-8U0aNm0zO_yyWMeS8GXg_A-1; Mon, 25 May 2020 11:06:57 -0400
X-MC-Unique: 8U0aNm0zO_yyWMeS8GXg_A-1
Received: by mail-ej1-f72.google.com with SMTP id pj20so6451662ejb.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bhbiaGeyOZtfxUrFs0y2evFWTskfzhbIggYBhtmEIh4=;
 b=RQ8C/YFEHjaumcBEKnI4qfDH/h0yT/jLTa+NWgk6bbEE02qQCpN3d3xeYaz5RHH2py
 7ZP42qdwjoY/diRNq/3g+zRVGTWMYbKOkmPk3fosa1XqDxJ6xMkinUU/rt/STeK70GB+
 Pc71wjI/AskD9zUtASnzSpkQAjrfi7hUT2lrtSxIYCP4mi1HLfnMh2rUZIbfX9nzpaYo
 O1RlBYiE4s/RKm0WniXfuNP3zNQP8I0Q4XGVhJOCnDwcaZ+w+eu4I6RWEhAig5D+QJsZ
 ULlHNmH2ixN6Rym4bEgfse/T2w/7MPS/DfJxFrOAyzEaAtXODjXy4X0vLYxRGu/DJ9uJ
 sokA==
X-Gm-Message-State: AOAM532GYRo3LT03nx7dwE2x2Osd0Ro448FytYRy4IfDJ8ePH/2jLlP9
 Agnbp9vEFevcAuWad8WbJ4ZisnnHpS6xvOQ8ga+OJV0+rZpTNhq96kCprWVV5AME1OMv9NVjeGA
 zDwM/0YssyuDTNEs=
X-Received: by 2002:a05:6402:74b:: with SMTP id
 p11mr15980622edy.229.1590419216134; 
 Mon, 25 May 2020 08:06:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvhJpAjrRfrPSZwdTOZC8MoK+C+sa55Wt4PJCaq4WMkmLvzC4IP1N1ijqlXxjpvvMRUhRupA==
X-Received: by 2002:a05:6402:74b:: with SMTP id
 p11mr15980592edy.229.1590419215906; 
 Mon, 25 May 2020 08:06:55 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id l11sm15933206edw.55.2020.05.25.08.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 08:06:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/9] qapi/misc: Restrict LostTickPolicy enum to machine code
Date: Mon, 25 May 2020 17:06:33 +0200
Message-Id: <20200525150640.30879-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525150640.30879-1-philmd@redhat.com>
References: <20200525150640.30879-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:28:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ben Warren <ben@skyportsystems.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json            | 32 ++++++++++++++++++++++++++++++++
 qapi/misc.json               | 32 --------------------------------
 include/hw/rtc/mc146818rtc.h |  2 +-
 hw/core/qdev-properties.c    |  1 +
 hw/i386/kvm/i8254.c          |  2 +-
 5 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 1fe31d374c..ca7d58f0c9 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -421,6 +421,38 @@
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
index 99b90ac80b..2c48ffaa62 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -7,38 +7,6 @@
 
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
index 3713181b56..9cd04f379a 100644
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
index cc924815da..dacf91c877 100644
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
index 876f5aa6fa..22ba6149b5 100644
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
2.21.3


