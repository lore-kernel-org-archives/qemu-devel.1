Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F02C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A38D20656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmHIi0aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A38D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94lr-0007Q9-AG
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94E0-0002Zn-Nz
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60432
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Du-0001gQ-Cu
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OleJqtNlUM+7xlI0j9Ff4YDnmFmzGCwKeJIp1n6ndQ=;
 b=NmHIi0aqnQuZ7lW/jj7JZJugAeWm1p6BYhU9zIIGje6NFxwf1nfdlI/ohMIVSBCTn97aZQ
 L0Yhq5kt7SCzZiGy4kze8fV/oPlxFBnkQcXfoulgSWm5SCIrIPjlDvd7xTsqiZCdDMZ6CP
 fvGsGPEHPp0nijqCwvyWGPOboizlhL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-ApW56SODOLWH3P6FY7FaYQ-1; Fri, 21 Aug 2020 06:24:36 -0400
X-MC-Unique: ApW56SODOLWH3P6FY7FaYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 172C9191E2A1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB8515C1D0;
 Fri, 21 Aug 2020 10:24:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 079/152] meson: convert replay directory to Meson
Date: Fri, 21 Aug 2020 06:22:16 -0400
Message-Id: <20200821102329.29777-80-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs        |  1 -
 meson.build          |  1 +
 replay/Makefile.objs | 10 ----------
 replay/meson.build   | 12 ++++++++++++
 4 files changed, 13 insertions(+), 11 deletions(-)
 delete mode 100644 replay/Makefile.objs
 create mode 100644 replay/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index e304d92954..cfb2cf2b49 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -68,7 +68,6 @@ common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF
 common-obj-y += hw/
 common-obj-m += hw/
 
-common-obj-y += replay/
 common-obj-y += backends/
 
 common-obj-y += qapi/
diff --git a/meson.build b/meson.build
index 4ff3f7bccb..60313b2eae 100644
--- a/meson.build
+++ b/meson.build
@@ -656,6 +656,7 @@ common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
 subdir('monitor')
+subdir('replay')
 
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
diff --git a/replay/Makefile.objs b/replay/Makefile.objs
deleted file mode 100644
index 939be964a9..0000000000
--- a/replay/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-common-obj-y += replay.o
-common-obj-y += replay-internal.o
-common-obj-y += replay-events.o
-common-obj-y += replay-time.o
-common-obj-y += replay-input.o
-common-obj-y += replay-char.o
-common-obj-y += replay-snapshot.o
-common-obj-y += replay-net.o
-common-obj-y += replay-audio.o
-common-obj-y += replay-random.o
diff --git a/replay/meson.build b/replay/meson.build
new file mode 100644
index 0000000000..8783aea7c8
--- /dev/null
+++ b/replay/meson.build
@@ -0,0 +1,12 @@
+softmmu_ss.add(files(
+  'replay.c',
+  'replay-internal.c',
+  'replay-events.c',
+  'replay-time.c',
+  'replay-input.c',
+  'replay-char.c',
+  'replay-snapshot.c',
+  'replay-net.c',
+  'replay-audio.c',
+  'replay-random.c',
+))
-- 
2.26.2



