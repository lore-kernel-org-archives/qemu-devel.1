Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6D4C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAECD24676
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ4dlH3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAECD24676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKhh-0007iu-S4
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irKYf-000550-Lv
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irKYb-0002wX-NA
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:40:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45376
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irKYb-0002wA-IW
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579002025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ep/mdFe58oIx18pwRhWkg/D1I02FCTVyA7jE4yQkeXs=;
 b=iZ4dlH3XmMCH5+69MmoM4apzb2XCewYhzNRudDyLFoInrFClt+aekrdRaoSZy5CVZ22dYA
 Ys8vRY2w1CKthoSyXvrvTBVvBEeRST6RLjeqyn14IhRzLUEePFw0Fz16QI1MBYdDVVA/YJ
 MFccrIy7x5+suoQiZKB9Q68YUASLJZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-QkwOZzIHNzeHKasIWBBh5g-1; Tue, 14 Jan 2020 06:40:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAADC18CA243;
 Tue, 14 Jan 2020 11:40:21 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D8825DA70;
 Tue, 14 Jan 2020 11:40:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/30] runstate: ignore finishmigrate -> prelaunch transition
Date: Tue, 14 Jan 2020 12:39:02 +0100
Message-Id: <20200114113926.3556-7-quintela@redhat.com>
In-Reply-To: <20200114113926.3556-1-quintela@redhat.com>
References: <20200114113926.3556-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: QkwOZzIHNzeHKasIWBBh5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

Commit 1bd71dce4bf2 tries to prevent a finishmigrate -> prelaunch
transition by exiting at the beginning of the main_loop_should_exit()
function if the state is already finishmigrate.

As the finishmigrate state is set in the migration thread it can
happen concurrently to the function. The migration thread and the
function are normally protected by the iothread mutex and thus the
state should no evolve between the start of the function and its end.

Unfortunately during the function life the lock is released by
pause_all_vcpus() just before the point we need to be sure we are
not in finishmigrate state and if the migration thread is waiting
for the lock it will take the opportunity to change the state
to finishmigrate.

The only way to be sure we are not in the finishmigrate state when
we need is to check the state after the pause_all_vcpus() function.

Fixes: 1bd71dce4bf2 ("runstate: ignore exit request in finish migrate state=
")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 vl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index 158a05ed32..ba3e176094 100644
--- a/vl.c
+++ b/vl.c
@@ -1604,9 +1604,6 @@ static bool main_loop_should_exit(void)
     RunState r;
     ShutdownCause request;
=20
-    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
-        return false;
-    }
     if (preconfig_exit_requested) {
         if (runstate_check(RUN_STATE_PRECONFIG)) {
             runstate_set(RUN_STATE_PRELAUNCH);
@@ -1635,8 +1632,13 @@ static bool main_loop_should_exit(void)
         pause_all_vcpus();
         qemu_system_reset(request);
         resume_all_vcpus();
+        /*
+         * runstate can change in pause_all_vcpus()
+         * as iothread mutex is unlocked
+         */
         if (!runstate_check(RUN_STATE_RUNNING) &&
-                !runstate_check(RUN_STATE_INMIGRATE)) {
+                !runstate_check(RUN_STATE_INMIGRATE) &&
+                !runstate_check(RUN_STATE_FINISH_MIGRATE)) {
             runstate_set(RUN_STATE_PRELAUNCH);
         }
     }
--=20
2.24.1


