Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79FFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07B420702
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH+Bj5y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07B420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqF0K-0001S7-Nf
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jqEzc-00012K-Ek
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:04:04 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:35637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jqEza-0007nN-3J
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:04:03 -0400
Received: by mail-lf1-x144.google.com with SMTP id t74so11199990lff.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WcHxYOTEXYMBE1UenLwKb9De2OfT/g1FSI9QFwULXIs=;
 b=ZH+Bj5y+xl8ezkrPf0sQw2Qo18Mj8yffYdzC1v34hoygx2RYegQkIss+qC0v6aYvTM
 ++Ojitxfwe5/WTorC9H8je93+VFmTZ605Lm/MDlMVL1aQ+3sS0pJVFMkL7l5DzcH3Hjs
 EXZOGX6MPq10oagCtJCHFgIQkTXZ8nZaHRnhFikhqzcCQDGn26RV8Rsdm+SbgoLSqszJ
 W0j/7Y9/XAMXJIf1mbhLO9xv2z/YscdJPNkcAhxZb4C2NiCBmRRCRmYSYGFsFrdSRoia
 YETMzNyNLqs0gmNyB/7eUV2t1AQgwNqg7lt30QrYnShDjm/8utRntAS6BQuvJY2p19oC
 uZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WcHxYOTEXYMBE1UenLwKb9De2OfT/g1FSI9QFwULXIs=;
 b=pKMj5odyVU9P01wQqKt1Lx/NKPrcZbAqBT8F93b1ZPKU1n/aKPbnsp6Im67Jp8A6e4
 QdiYbvo3G2Xj/85IE8iyPuOkg3o/uPuSsFkpRLYpPiq3gPLwYwWZRbYRnd7mI0CVCOuA
 4zP+OznCqQLZFacWkxavR7joV6KyuBxOrUZiV2TwJRekgzaNGe1oZ25D5PDK4401fevX
 2KPanxQSGozD89ursOB/5kaI4ZtafoUachcHXi00c6+48KoVUjAIZwUDKz/iI67+pFQF
 ev+OnKXR8eo/4BVC8dDkTe3BRsbODrIZpI0LxkMhgTPk68Mn+zwHDKO+lfNIfceTZBl6
 NMeg==
X-Gm-Message-State: AOAM530MP+VPNOU++awCpYP3+csC/s3mAnozaGL4Gds/NITmWnKx466/
 fjiJEKb6etdQkgJYgtPXLJswvrSOBufJnw==
X-Google-Smtp-Source: ABdhPJyBiiILsXWYj0/1ya7rrkzalyubnAH7nhHntpXR53tY2n47DmqD4wV/EHregQQ00I/yRnfaUg==
X-Received: by 2002:ac2:54b9:: with SMTP id w25mr11830662lfk.127.1593518638736; 
 Tue, 30 Jun 2020 05:03:58 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id r15sm659157ljd.130.2020.06.30.05.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 05:03:58 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Revert "chardev: fix backend events regression with mux
 chardev"
Date: Tue, 30 Jun 2020 14:03:37 +0200
Message-Id: <20200630120337.608326-1-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=noh4hss@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: pbonzini@redhat.com, Szymon Lukasz <noh4hss@gmail.com>,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit d09c4a47874f30820b08c39ad39bcca9b8cde084.

Seems like the problem described in the above commit is also
fixed by eeaa6715050.

Basically, the current code has the following invariant:
(d->focus == -1 && chr->be == NULL) || (d->focus >= 0 && chr->be == d->backends[d->focus])

So there's no need to add the code for sending events
to the focused frontend because qemu_chr_be_event()
will do that for us.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
---
 chardev/char-mux.c     | 10 ----------
 chardev/char.c         | 18 ++++++------------
 include/chardev/char.h |  1 -
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 46c44af67c..30196d6e91 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -126,15 +126,6 @@ static void mux_chr_send_event(MuxChardev *d, int mux_nr, QEMUChrEvent event)
     }
 }
 
-static void mux_chr_be_event(Chardev *chr, QEMUChrEvent event)
-{
-    MuxChardev *d = MUX_CHARDEV(chr);
-
-    if (d->focus != -1) {
-        mux_chr_send_event(d, d->focus, event);
-    }
-}
-
 static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
 {
     if (d->term_got_escape) {
@@ -382,7 +373,6 @@ static void char_mux_class_init(ObjectClass *oc, void *data)
     cc->chr_write = mux_chr_write;
     cc->chr_accept_input = mux_chr_accept_input;
     cc->chr_add_watch = mux_chr_add_watch;
-    cc->chr_be_event = mux_chr_be_event;
     cc->chr_machine_done = open_muxes;
     cc->chr_update_read_handler = mux_chr_update_read_handlers;
 }
diff --git a/chardev/char.c b/chardev/char.c
index e3051295ac..1041bcc368 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -50,19 +50,10 @@ static Object *get_chardevs_root(void)
     return container_get(object_get_root(), "/chardevs");
 }
 
-static void chr_be_event(Chardev *s, QEMUChrEvent event)
+void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
 {
     CharBackend *be = s->be;
 
-    if (!be || !be->chr_event) {
-        return;
-    }
-
-    be->chr_event(be->opaque, event);
-}
-
-void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
-{
     /* Keep track if the char device is open */
     switch (event) {
         case CHR_EVENT_OPENED:
@@ -78,7 +69,11 @@ void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
         break;
     }
 
-    CHARDEV_GET_CLASS(s)->chr_be_event(s, event);
+    if (!be || !be->chr_event) {
+        return;
+    }
+
+    be->chr_event(be->opaque, event);
 }
 
 /* Not reporting errors from writing to logfile, as logs are
@@ -276,7 +271,6 @@ static void char_class_init(ObjectClass *oc, void *data)
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
     cc->chr_write = null_chr_write;
-    cc->chr_be_event = chr_be_event;
 }
 
 static void char_finalize(Object *obj)
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 00589a6025..d77341605f 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -273,7 +273,6 @@ typedef struct ChardevClass {
     void (*chr_accept_input)(Chardev *chr);
     void (*chr_set_echo)(Chardev *chr, bool echo);
     void (*chr_set_fe_open)(Chardev *chr, int fe_open);
-    void (*chr_be_event)(Chardev *s, QEMUChrEvent event);
     /* Return 0 if succeeded, 1 if failed */
     int (*chr_machine_done)(Chardev *chr);
 } ChardevClass;
-- 
2.27.0


