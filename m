Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AAAC00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADAF20726
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjG0OV7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADAF20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKaF-0005En-CX
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXo-0003Kn-F2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXn-0001D2-Be
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKXn-0001CR-5M
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:51 -0500
Received: by mail-wm1-x343.google.com with SMTP id f4so94078wmj.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cA2iDpQolGtGjsKYpqIIZsLwkl3s5m793VU3l0S5tY0=;
 b=BjG0OV7KCOZquhmVDFRSgzJqTGOSGIwB3GKU0kpQqbnbGtu5oD2oFoCbhMl/wg9byc
 UidwY/BWjFJ9x5O7WmfBse6kIjJDpmo5wHpI6V2F5/wUxzUitm3GXqxqW5P/OsWPzASO
 Kfz2mG61/OGiHHPaW1bh1wB/CVRunklZ8f+JpuyGtMP7SnCm8Qy5qy/7vVml1zXijQfq
 DxDn4bcAww5wbaS8UWEAdLUHJAhm36x9MrzKqW3zgoMNgwKVVbNq36i+uDlHpTSBC6PR
 EHjaOQVQGS2aEAMhLY44PbTrY4+beio3I93cr6h4Q75fU0bDZ07bGtEGq2K4P95Bie8k
 aMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cA2iDpQolGtGjsKYpqIIZsLwkl3s5m793VU3l0S5tY0=;
 b=uBQ7OVuUqUglAlTjky0f4AmtZzMZ/v+nCsVdgiGGa4twOoB2tT0nQVPru5ImUJAkQi
 kfQ02VQJc6ESyIbZuytmFtAGvuv4t1Z6TYdgL3FnytXCbIcQraCvYlOmD7qN84cm8h+R
 iGoQUwzrKC2AkI5WBMPmEUttWHLT2/6EK8xNdaCvMylmkoYrekd5LQSNvjKB/B5ElxUH
 nTVuQs4a8nIdF5HSRGq8riQSlemuuBH0z7su3TGla/8eKSC3A8GfiPu7+IVprJZl9Mda
 utfdL3ZuZEXd3mWhT3ofklJxfrvumZAGYvZcj1w535bDTTvege09JPXZqdrl5fe+U9MQ
 WLZg==
X-Gm-Message-State: APjAAAXIdgDkl2ZM0Xsh8A9T6dupPfXt+8McqiJFGYpyLsdMi8vmqI4J
 NSfuxPbyJFgxzrNxvq9UwamC34KF
X-Google-Smtp-Source: APXvYqz8fySJwzvZLlv5q/aAsgI5L59Bx7gaPgkw7B9IJChsbbKdoCg9S41b7EzTHsJdlUA22ik5Rw==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr24181637wml.115.1575903709437; 
 Mon, 09 Dec 2019 07:01:49 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.01.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:01:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/18] vl: move icount configuration earlier
Date: Mon,  9 Dec 2019 16:01:29 +0100
Message-Id: <1575903705-12925-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: thuth@redhat.com, elmarco@redhat.com
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
index 6a65a64..f69fea1 100644
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
@@ -4165,6 +4171,8 @@ int main(int argc, char **argv, char **envp)
      * Note: uses machine properties such as kernel-irqchip, must run
      * after machine_set_property().
      */
+    qemu_opts_foreach(qemu_find_opts("icount"),
+                      do_configure_icount, NULL, &error_fatal);
     configure_accelerator(current_machine, argv[0]);
 
     /*
@@ -4250,13 +4258,9 @@ int main(int argc, char **argv, char **envp)
     qemu_spice_init();
 
     cpu_ticks_init();
-    if (icount_opts) {
-        if (!tcg_enabled()) {
-            error_report("-icount is not allowed with hardware virtualization");
-            exit(1);
-        }
-        configure_icount(icount_opts, &error_abort);
-        qemu_opts_del(icount_opts);
+    if (!tcg_enabled() && use_icount) {
+        error_report("-icount is not allowed with hardware virtualization");
+        exit(1);
     }
 
     if (tcg_enabled()) {
-- 
1.8.3.1



