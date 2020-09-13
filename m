Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0567CC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A6121D80
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAw5vGp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A6121D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHY5T-0005OO-CN
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 15:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4Z-00044h-Ap
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4X-0002Ez-Hz
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600026839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfPMayHNm783GOWFtl2CrD6xAn1YPu/97T94zZoINI8=;
 b=aAw5vGp6GTRE7sEUDQhpwqWvYQcHTA9SymQY7X5Jp/EVF8L6/yM10ybyMEAnEz0vQ+gs7F
 ac3Xrs2lVgqW0a+vTZVG3MTDg78H1fUwow7T+kAsQEU5H93q/OFnPh+eRwz5GvPO0HGzfh
 FLyv+V+Zowp6MUBK+Ci6J1MKBLzPL7c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-IocxinBxPTS8dcbQRnbgHA-1; Sun, 13 Sep 2020 15:53:58 -0400
X-MC-Unique: IocxinBxPTS8dcbQRnbgHA-1
Received: by mail-wr1-f69.google.com with SMTP id f18so5908741wrv.19
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 12:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xfPMayHNm783GOWFtl2CrD6xAn1YPu/97T94zZoINI8=;
 b=Edq1jXGHFGdqvKbNg6BGTOnqGCmWO7Gd4a0DcyM4ftJ5gwkjZGLXrW9mv1yial0Ln0
 2UVs2h1t7l2+Vh1KfFlpdSGWswSAMOdOEgIbjg0NSQtmSRx831sxFV27qJY9kC3iW5x0
 JflHooknPArGYyf1qxk07Z2Kq0XQruFZoVE4aECeIkjYRrurj7ksQeKPr6k/73Ml6dEc
 V98N3V/iLF4ZJFoQAYyhvqVhjyHxH7jRYFMNveY5ideg5b31YJAro7zuzQihWq3cg+mm
 n7+UQczjRSCuV/8R/fFgDtzOw3kt/tc/p+kNJba0e0P8FQmk57Dor8ZOo5DGkXoiQ34e
 6yPA==
X-Gm-Message-State: AOAM530L7k6Fkn9noAxRZZSebhJqugvhanbqPuhJQLDP8x9QiTDTB8iq
 QAGs/92xgam0LVjui4lDvLVCUZLWscoOg66pU7o7cWjkYCtGCDUahVFZfRTBGWZSufLSxOJcVca
 UqfrBKzFlhzZQ+x0=
X-Received: by 2002:a5d:4a4a:: with SMTP id v10mr8439112wrs.72.1600026836895; 
 Sun, 13 Sep 2020 12:53:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTYM92yCBaWNnRp/KGzkM4msI3lzvf7tGvxVTeXgkPMoVdDEi5F20yzfkGFgeubr0N6UdJhQ==
X-Received: by 2002:a5d:4a4a:: with SMTP id v10mr8439098wrs.72.1600026836687; 
 Sun, 13 Sep 2020 12:53:56 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id g8sm15347100wmd.12.2020.09.13.12.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 12:53:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 1/8] qapi: Restrict LostTickPolicy enum to machine code
Date: Sun, 13 Sep 2020 21:53:41 +0200
Message-Id: <20200913195348.1064154-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200913195348.1064154-1-philmd@redhat.com>
References: <20200913195348.1064154-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 15:53:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json            | 32 ++++++++++++++++++++++++++++++++
 qapi/misc.json               | 32 --------------------------------
 include/hw/rtc/mc146818rtc.h |  2 +-
 hw/core/qdev-properties.c    |  1 +
 hw/i386/kvm/i8254.c          |  2 +-
 5 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 0ac1880e4a4..b6396aa3fea 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -426,6 +426,38 @@
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
index 8cf6ebe67cb..b21963a176d 100644
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
index e58e006d0d0..eb69182ca33 100644
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
index 098298c78e6..343c824da04 100644
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
index e18fd337fab..40d84734e7f 100644
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


