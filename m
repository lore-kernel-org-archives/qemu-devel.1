Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE159C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B7122D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dZj5RMiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B7122D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Lci-0003NQ-Mk
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1B-0005YE-Pi
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1A-0000FJ-MJ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:53 -0400
Received: from ozlabs.org ([203.11.71.1]:54309)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L1A-0008SJ-BX; Wed, 21 Aug 2019 03:26:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjG0Cslz9sR2; Wed, 21 Aug 2019 17:25:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372354;
 bh=swC+cfrA6RL8IRtZkusa0ebY3i0bciClde+gKNL4MyE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dZj5RMiGCyDjmfPw6sqioOvZ4jsGPWsmbN7kQViYxzzbr+i+KbF+/KWhoQBGSCLA3
 eoyu7depvcs9OPsTufgBUDH1quQsr4BQkF0DQjRqB4FAgQfj4KBBgRawcu+35AkUeV
 yB+cX+e1OZwaSb+sdSkihhhpK1M4ZEZMmjeta1JI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:30 +1000
Message-Id: <20190821072542.23090-31-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 30/42] i386: use machine class ->wakeup method
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, groug@kaod.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

Move the i386 suspend_wakeup logic out of the fallback path, and into
the new ->wakeup method.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20190722061752.22114-1-npiggin@gmail.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/i386/pc.c | 8 ++++++++
 vl.c         | 2 --
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 95edbbfe9e..98581fe0c2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2834,6 +2834,13 @@ static void pc_machine_reset(MachineState *machine=
)
     }
 }
=20
+static void pc_machine_wakeup(MachineState *machine)
+{
+    cpu_synchronize_all_states();
+    pc_machine_reset(machine);
+    cpu_synchronize_all_post_reset();
+}
+
 static CpuInstanceProperties
 pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
@@ -2946,6 +2953,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     mc->block_default_type =3D IF_IDE;
     mc->max_cpus =3D 255;
     mc->reset =3D pc_machine_reset;
+    mc->wakeup =3D pc_machine_wakeup;
     hc->pre_plug =3D pc_machine_device_pre_plug_cb;
     hc->plug =3D pc_machine_device_plug_cb;
     hc->unplug_request =3D pc_machine_device_unplug_request_cb;
diff --git a/vl.c b/vl.c
index 09aa18cb35..8e5af7501f 100644
--- a/vl.c
+++ b/vl.c
@@ -1568,8 +1568,6 @@ static void qemu_system_wakeup(void)
=20
     if (mc && mc->wakeup) {
         mc->wakeup(current_machine);
-    } else {
-        qemu_system_reset(SHUTDOWN_CAUSE_NONE);
     }
 }
=20
--=20
2.21.0


