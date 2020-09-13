Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0896BC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE5021D80
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvWh1E2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE5021D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHY6s-00083u-Oz
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 15:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4o-0004Vb-BW
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4k-0002Gf-Qm
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600026853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQxGCFGFZIPrIS0+25PGhLER6VDhh3qQR1cx3IEfDOs=;
 b=OvWh1E2SclhR32FpmeoBN3WDhsrZYmo5DikkSCOX9aX3ROIixVdFtKCXrO/LhJTkJomRTf
 AkD7vX5OL3SYPkJ4tI5Ndx/Yeys4uqPQVNNEyUThmTC7EC2FfectftAaIQlEvz0/ezsds3
 bSkuLrRZXPQdZBbKRpi9kG17hr3exmE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-H99lLN3XOdKzw5Wm6l4xNg-1; Sun, 13 Sep 2020 15:54:12 -0400
X-MC-Unique: H99lLN3XOdKzw5Wm6l4xNg-1
Received: by mail-wr1-f70.google.com with SMTP id b7so5917312wrn.6
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 12:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fQxGCFGFZIPrIS0+25PGhLER6VDhh3qQR1cx3IEfDOs=;
 b=ZVREblrvQUTlphlrh5zk37UWxYow8vqXp199OWE4Obxdhr/oPLFyzWx56yvc79Evgh
 TVjN6dxwjTSG6pRakvIWc0P9e2LdK65CqVVDRY6HS4cwQFJVC8QT39t2IbCBkg6/CWjC
 AjEqNq0Tz7wP6felE9fH87J+hQ00GS77rgbzo1L0vGyOeno/kt9+yc56EHlc51rYKvgH
 PUmwvRuo2NhQW58Yw6hB7xIkT7XuzH0y3+/N0VfrluWrJ8sUx6LEtt+aSz5reL8cQeM7
 E/Bnill2+EtZXRM8JsgOGuLS21KXtAJnP50DSyVNbT6iGmSa6mwbShdEEFbsbjLKr6It
 gEDQ==
X-Gm-Message-State: AOAM5337tHINaPw+GCNIVYJyazejuxPFEkL8xwO03H76Ew829ne9fAyY
 se1rJ6oax8u0eexzgh7q9DU4SujlX52K4m8G/yvtY9aPHn/y9bDB7f3eoDzaIPpkpAMGJTWR0Bs
 LxElixD1sAEbKRVQ=
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr11600950wmj.5.1600026850768; 
 Sun, 13 Sep 2020 12:54:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiXS9OvI/5tKHzLKENq3JUzOxjJWcGitz9hO833vmqPKAKNMWoQTQs70rRZgMaOSKxa+NGaQ==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr11600940wmj.5.1600026850609; 
 Sun, 13 Sep 2020 12:54:10 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id g12sm16949914wro.89.2020.09.13.12.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 12:54:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 4/8] qapi: Restrict query-vm-generation-id command to
 machine code
Date: Sun, 13 Sep 2020 21:53:44 +0200
Message-Id: <20200913195348.1064154-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200913195348.1064154-1-philmd@redhat.com>
References: <20200913195348.1064154-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 15:53:55
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

Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors, therefore such declarations and definitions are
irrelevant for user-mode emulation.

Restricting the query-vm-generation-id command to machine.json
allows pulling less declarations/definitions to user-mode.

Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 20 ++++++++++++++++++++
 qapi/misc.json    | 21 ---------------------
 hw/acpi/vmgenid.c |  2 +-
 stubs/vmgenid.c   |  2 +-
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 04f0a907c75..dd2815fa670 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -426,6 +426,26 @@
 ##
 { 'command': 'query-target', 'returns': 'TargetInfo' }
 
+##
+# @GuidInfo:
+#
+# GUID information.
+#
+# @guid: the globally unique identifier
+#
+# Since: 2.9
+##
+{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
+
+##
+# @query-vm-generation-id:
+#
+# Show Virtual Machine Generation ID
+#
+# Since: 2.9
+##
+{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
+
 ##
 # @LostTickPolicy:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 7a14c50094d..edcc91e1060 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1479,24 +1479,3 @@
 #
 ##
 { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
-
-##
-# @GuidInfo:
-#
-# GUID information.
-#
-# @guid: the globally unique identifier
-#
-# Since: 2.9
-##
-{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
-
-##
-# @query-vm-generation-id:
-#
-# Show Virtual Machine Generation ID
-#
-# Since: 2.9
-##
-{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
-
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 53db6af75d0..2c8152d5088 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qemu/module.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
index 568e42b0648..bfad656c6cc 100644
--- a/stubs/vmgenid.c
+++ b/stubs/vmgenid.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qerror.h"
 
 GuidInfo *qmp_query_vm_generation_id(Error **errp)
-- 
2.26.2


