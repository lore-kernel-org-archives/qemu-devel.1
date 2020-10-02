Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F05C4727D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC72206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCRe4bWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC72206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLJM-0000ep-1d
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLHg-0007PV-OK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLHf-0005Qf-0r
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601645977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLAVKEu0s8buMQigPSDDQRm3nwhcH7vFMDI5aBMruk4=;
 b=TCRe4bWA5D5qk4tZZo92tIW2337mdbCQMDIbiw/HZoeo8ACP5OnbstRiur8Kw/V1qDrCj6
 ohemv/Z+U+XBTvnFQTMKdxfmlXTyI1rseMlSUVn1b7fx2CZ3OeWHGdjFKBXxUctB82rjEP
 7m8luwKF+Te0VpQfNytYnroRB2iExiY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-DIxfOHCXOYC663QpVHt77w-1; Fri, 02 Oct 2020 09:39:33 -0400
X-MC-Unique: DIxfOHCXOYC663QpVHt77w-1
Received: by mail-wr1-f70.google.com with SMTP id v5so571553wrr.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iLAVKEu0s8buMQigPSDDQRm3nwhcH7vFMDI5aBMruk4=;
 b=WUbe9eaOO3zF2+MJLemGrQXAYWG4UNP0y1LBl8qDJw19GUwzzJ7806HO+XCBvYrA4s
 VAgFGn3YKrzDOPhVYyeQuSEWiRh8en7/zQi6feFSk+4iqdU7dV+I1zFHJ29/TAhxpV9q
 nZrFunFzZdwbS/C1xSoCZzveHkKfhfTKD0ituZ3BnqE21rSmIL0/TQQi6Y8CbbbBP8JV
 qA6lK8uKmWJyOPzHr9FumAQWGQbYFEZ2u/kKiSgn2qWPsjOFtAlI+XoTGvbXJnUjcf7s
 yKdGGnDrtKmn2EeG3hK2Y302TDrnCDIqtsNvNvG+AGqX/exGNVeyGI7zbliKEpUnUCTK
 W+KQ==
X-Gm-Message-State: AOAM53372yPjDQlG2iVa8laB2uXZsLDlXSAuyi/rq90+2AIB21kKOOJm
 PdGoGziQpW2Io2V4WfhuFYkPc8PGLCqQwzsGXdOlOke5/IkRxKmO/iMCnRqV55G59Z2gOY3Lros
 0kFAABmOKKB5qilA=
X-Received: by 2002:a7b:cc02:: with SMTP id f2mr2894074wmh.1.1601645972125;
 Fri, 02 Oct 2020 06:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqQv1qlyQpjgjGTEtLJvUYyUltyIpiDUFPSX1enMbbtlK6dt49SmY4VWfHBJPv80MAhGkeEw==
X-Received: by 2002:a7b:cc02:: with SMTP id f2mr2894034wmh.1.1601645971831;
 Fri, 02 Oct 2020 06:39:31 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 91sm1979455wrq.9.2020.10.02.06.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 06:39:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] qapi: Restrict 'inject-nmi' command to machine code
Date: Fri,  2 Oct 2020 15:39:19 +0200
Message-Id: <20201002133923.1716645-2-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
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

Restricting 'inject-nmi' to machine.json pulls slightly
less QAPI-generated code into user-mode and tools.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 20 ++++++++++++++++++++
 qapi/misc.json    | 20 --------------------
 softmmu/cpus.c    |  1 +
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 756dacb06f..073b1c98b2 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -484,6 +484,26 @@
 { 'enum': 'LostTickPolicy',
   'data': ['discard', 'delay', 'slew' ] }
 
+##
+# @inject-nmi:
+#
+# Injects a Non-Maskable Interrupt into the default CPU (x86/s390) or all CPUs (ppc64).
+# The command fails when the guest doesn't support injecting.
+#
+# Returns:  If successful, nothing
+#
+# Since:  0.14.0
+#
+# Note: prior to 2.1, this command was only supported for x86 and s390 VMs
+#
+# Example:
+#
+# -> { "execute": "inject-nmi" }
+# <- { "return": {} }
+#
+##
+{ 'command': 'inject-nmi' }
+
 ##
 # @NumaOptionsType:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 694d2142f3..37b3e04cec 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -341,26 +341,6 @@
 ##
 { 'command': 'system_wakeup' }
 
-##
-# @inject-nmi:
-#
-# Injects a Non-Maskable Interrupt into the default CPU (x86/s390) or all CPUs (ppc64).
-# The command fails when the guest doesn't support injecting.
-#
-# Returns:  If successful, nothing
-#
-# Since:  0.14.0
-#
-# Note: prior to 2.1, this command was only supported for x86 and s390 VMs
-#
-# Example:
-#
-# -> { "execute": "inject-nmi" }
-# <- { "return": {} }
-#
-##
-{ 'command': 'inject-nmi' }
-
 ##
 # @human-monitor-command:
 #
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index ac8940d52e..bd040d6cdd 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -29,6 +29,7 @@
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
-- 
2.26.2


