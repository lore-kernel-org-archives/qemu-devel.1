Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B230C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59EE12067C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0BClAhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EE12067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtJM-00020I-5D
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF0-0004p4-W9
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEz-00079j-Sn
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:02 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEz-00077r-MK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:01 -0500
Received: by mail-wr1-x443.google.com with SMTP id g17so8052716wro.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yver+z01Ad2CgxbNm/G/S9DVzSw0YehnxQ3kmcrkoVo=;
 b=L0BClAhCSyj7NiBVh0sMJtEzUFZK85VVU38/wYVKdDVdhefHQdGIwh4rx0mkP8Z435
 YVPr0/E1lSVvG0ITpi4dQ0sklCvSDcEZLGEhxVj2At6co0fWAE1IEBOq819Jy/NhpPc9
 d/09MU5QfXvaUcG+Fv+hrrEv1jYHzzJOl4pESWPTgGKejsd5AZYZ+pCJS1GwprghIDIn
 e8OhJca5F04yHXVOgqci/m2jZvBEg00Noi2MBscFo9UX6cdYmqgGsCurf/wSfFgcI6LE
 hbNrF9jYz4Txu2GddjtIRRC40SIiv2tMIA4cJnQZsWs3RUvOcEH6vcesthRlqAtFJjIt
 KqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yver+z01Ad2CgxbNm/G/S9DVzSw0YehnxQ3kmcrkoVo=;
 b=d79YdxFTFSA09wmmeoFp0Gy9HufjGty77kxAsv4X1ySR2UAaZOdjxtzrHtYazizZm3
 F9fVoe6BMlS7UjuIhQVqJpM/OHH+2uBLWJK+KHLYzv+TrfUTH6oNnJfCNor7IMKiusuY
 PHNSPuVNhwam8cNP13VhdLyiHYYV0UNc05rf8j291kFHbZ7Gm7MysWQosOXphd+0d6fJ
 /SqW5NaeMe5XUxxs4VCVUGB9sSr/zcS7KaEzT3K2bcgLxhrCNuKp7Xa2H5q3GTE/kLdq
 DwhqMvLgidQEpyZolh05DObwn9/CA0lIYqjPvsgZ3BeODigB7VnTmmpIjZlSJPLxxINF
 iMdA==
X-Gm-Message-State: APjAAAUXYXZ3VRO+rVqctJp9HM3Wu4Fq758kcGwFF3nFAQ8/1BQgCb7c
 IYUjKkXLOBbNWwpYT6TyWevG3DRg
X-Google-Smtp-Source: APXvYqzMAmaYY5Cenkkd+eTM7OvEIdizsYVw28ZUq6Et4+ethQ/b4Kl8bFhSVSjrxZ6uZzZi89qtlQ==
X-Received: by 2002:a5d:6206:: with SMTP id y6mr30349052wru.130.1576513740437; 
 Mon, 16 Dec 2019 08:29:00 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/62] vl: move icount configuration earlier
Date: Mon, 16 Dec 2019 17:27:57 +0100
Message-Id: <1576513726-53700-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Once qemu_tcg_configure is turned into a QOM property setter, it will not
be able to set a default value for mttcg_enabled.  Setting the default will
move to the TCG instance_init function, which currently runs before "-icount"
is processed.

However, it is harmless to do configure_icount for all accelerators; we will
just fail later if a non-TCG accelerator is selected.  So do that.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/vl.c b/vl.c
index c0904b3..60353dc 100644
--- a/vl.c
+++ b/vl.c
@@ -2825,6 +2825,12 @@ static void user_register_global_props(void)
                       global_init_func, NULL, NULL);
 }
 
+static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
+{
+    configure_icount(opts, errp);
+    return 0;
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -4142,6 +4148,8 @@ int main(int argc, char **argv, char **envp)
      * Note: uses machine properties such as kernel-irqchip, must run
      * after machine_set_property().
      */
+    qemu_opts_foreach(qemu_find_opts("icount"),
+                      do_configure_icount, NULL, &error_fatal);
     configure_accelerator(current_machine, argv[0]);
 
     /*
@@ -4227,13 +4235,9 @@ int main(int argc, char **argv, char **envp)
     qemu_spice_init();
 
     cpu_ticks_init();
-    if (icount_opts) {
-        if (!tcg_enabled()) {
-            error_report("-icount is not allowed with hardware virtualization");
-            exit(1);
-        }
-        configure_icount(icount_opts, &error_abort);
-        qemu_opts_del(icount_opts);
+    if (use_icount && !(tcg_enabled() || qtest_enabled())) {
+        error_report("-icount is not allowed with hardware virtualization");
+        exit(1);
     }
 
     if (tcg_enabled()) {
-- 
1.8.3.1



