Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDAEC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4136720BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyvSCQLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4136720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOSW-00085b-CT
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPf-000429-Oi
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPc-000822-2n
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599751379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpCgzu6mcK7sdp0O+Mr3gYtNAyvGrtXlO6APHB+3gcE=;
 b=eyvSCQLVsCtjcRXehIuEpxOrwR6m7ZB9jgTcKLqB3MtgW/5TyxGYnDBWzG2dCwAs/hyV9z
 XKgv7fE9chyTadWxwQKRImRpFZ5tgBI2+crHrLb7d3dOeGrry6qSoNoNj/gZ+rft9kMico
 z1PvV4XY+Z3RGe07uejOVkRBU4w1Qe8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-Gw760FUmOCq45HI1lIiOzw-1; Thu, 10 Sep 2020 11:22:56 -0400
X-MC-Unique: Gw760FUmOCq45HI1lIiOzw-1
Received: by mail-wr1-f70.google.com with SMTP id r16so2363227wrm.18
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FpCgzu6mcK7sdp0O+Mr3gYtNAyvGrtXlO6APHB+3gcE=;
 b=FEG0ewVGgy3uC7hHSeADau4CKn+1B3BzaWgXpYDbQ/VAK9xELqPLec0iv4D2DtmiBd
 UTzifg5DlKXJnBUSVMPXqwCcxUJeuQK4C1xmhZX/zisFX4Imw3KswhZQcHDP/8it11yK
 DOOPP/V5vzk3wAXcQ3Iqz4HFT4CJhiR0nmnEQixbzfty9UR4Pm/qk+BX7vHXglEMtHCP
 ZzqSFHIwBc0s1d+0hn53tflc47U3vZ+OHmgckgGJLXqv4E6IjcyvItxCkt3RaabwJakR
 +MyM7MTkTGKColHJoNJK6O9rmA6Oq188KNo5mTpcIpuSPemMtLh0Qd4/rDEl2Yq2ycm8
 B69g==
X-Gm-Message-State: AOAM533zy4X6bdx8GaGzmU3QD9P4+jq/5MtaNJoDwW3mRJ1HtWUG9mjp
 lmv4KzKAyHSKCSPoBB5i8+t5bjTouObLwjbKTjv2zE2Veq2r+GAz00TzN0+t75/Yqt44HFRoCD1
 8Q9+L9LcrQeAvm90=
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr533243wma.46.1599751375382;
 Thu, 10 Sep 2020 08:22:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwr6CNd0m/SY1hOyvPzLF2OzlQ32afRSrbb2eF60n+n9Uco1vzNQkWO2zhsm1dZxnrO/K69kQ==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr533220wma.46.1599751375186;
 Thu, 10 Sep 2020 08:22:55 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t203sm4113524wmg.43.2020.09.10.08.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 08:22:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/9] qapi: Restrict query-vm-generation-id command to
 machine code
Date: Thu, 10 Sep 2020 17:22:21 +0200
Message-Id: <20200910152225.524322-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910152225.524322-1-philmd@redhat.com>
References: <20200910152225.524322-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <rth@twiddle.net>
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 20 ++++++++++++++++++++
 qapi/misc.json    | 21 ---------------------
 hw/acpi/vmgenid.c |  2 +-
 stubs/vmgenid.c   |  2 +-
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 870b8a53f21..ba61e6ccea4 100644
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
index 2df7623d74d..2b26bacaf8f 100644
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


