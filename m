Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A8FC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1390C223AC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0FnZH95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1390C223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzQT-0004ET-0a
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOs-0002T6-7m
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOp-0006cB-9H
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=7py8/BqSRsB8PFotGN4dp1fcL9wxowisE7ZbOTCvJQs=;
 b=T0FnZH95nVSnQIVllOAZgHoIiNFMB2q9ORHqrMSoSn1tWlGwhiJguehWG3TXNOQowBM9gH
 QvBx9iRb+ykG7v5GJHYg0xeUTBoGUArL9vmwrLuugFyUKm48aSJdp9jnQc9c5AdIsITc7+
 UZwDn5ZBghMoNWfuvTNtlEIZdWHEZTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-MqbfGWHMPYqtKODVByZVCA-1; Mon, 26 Oct 2020 06:06:44 -0400
X-MC-Unique: MqbfGWHMPYqtKODVByZVCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E934800D53;
 Mon, 26 Oct 2020 10:06:43 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 238398B846;
 Mon, 26 Oct 2020 10:06:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/31] accel: Add xen CpusAccel using dummy-cpus
Date: Mon, 26 Oct 2020 11:06:06 +0100
Message-Id: <20201026100632.212530-6-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Andryuk <jandryuk@gmail.com>

Xen was broken by commit 1583a3898853 ("cpus: extract out qtest-specific
code to accel/qtest").  Xen relied on qemu_init_vcpu() calling
qemu_dummy_start_vcpu() in the default case, but that was replaced by
g_assert_not_reached().

Add a minimal "CpusAccel" for Xen using the dummy-cpus implementation
used by qtest.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Message-Id: <20201013140511.5681-4-jandryuk@gmail.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 accel/meson.build   | 1 +
 accel/xen/xen-all.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/accel/meson.build b/accel/meson.build
index 9a417396bd..b26cca227a 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -12,3 +12,4 @@ dummy_ss.add(files(
 ))
 
 specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: dummy_ss)
+specific_ss.add_all(when: ['CONFIG_XEN'], if_true: dummy_ss)
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 60b971d0a8..878a4089d9 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -16,6 +16,7 @@
 #include "hw/xen/xen_pt.h"
 #include "chardev/char.h"
 #include "sysemu/accel.h"
+#include "sysemu/cpus.h"
 #include "sysemu/xen.h"
 #include "sysemu/runstate.h"
 #include "migration/misc.h"
@@ -153,6 +154,10 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
     }
 }
 
+const CpusAccel xen_cpus = {
+    .create_vcpu_thread = dummy_start_vcpu_thread,
+};
+
 static int xen_init(MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -180,6 +185,9 @@ static int xen_init(MachineState *ms)
      * opt out of system RAM being allocated by generic code
      */
     mc->default_ram_id = NULL;
+
+    cpus_register_accel(&xen_cpus);
+
     return 0;
 }
 
-- 
2.18.2


