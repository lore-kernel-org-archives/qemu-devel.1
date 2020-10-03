Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E30C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59C1206C1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2gVCk5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59C1206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOlgN-0001lS-Ts
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlfJ-0000zz-NE
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:49:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlfI-00042O-66
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:49:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id j2so5215583wrx.7
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N/XHuTYoUVTEHJUq0hcnsiyI1FEyMh7TUSpvqUeVj58=;
 b=N2gVCk5Vis5ao5lQbQgHuhJGwBkE/5l0Jrq1hDcR4WIta5THX9KLOKEU1Eq/uqHUEZ
 0ueOYOJOQmY+5KzK7BoN7nLEX4/5rc3P9Yq6QAbmrvR+Gv9ehvR8hD3DcChXV1y4dudW
 w6cjeNtBT0gNOKrPUDFBjYW/vI8XKsghKlLXh72ST1SNf4BZ4GSYSGNGTj0LvP/AwvX3
 oarNcdaIRsMkSt5LYgCQaaqNkDfugWD9R2AaVKFE/bi2be0HKsMGdQZ9ipvzMICKVXJI
 XNCFwZ2DhMZymEYxb59PXG+QMKf+/2Jw59RwS2VZtS90DIHlce4dChwaAVyoAHFMZEG1
 NWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=N/XHuTYoUVTEHJUq0hcnsiyI1FEyMh7TUSpvqUeVj58=;
 b=rmi5dPEwtHUy/quaxrYCpedktcCVvGI+WGQp8UkPG5UfkafA/Asqg81NmkkowjwxCO
 3/nR746IT8ZeUeN54ygcGzNoDGf0ii7wmq+i9ME2CVKuzzltap5FZetCwWzO3IAD058X
 DmCoWz6Fv4Vm3I0CUKbOam1PWd28t14SqOIF++b4u+9ALo5v0rNvT2NTQWEENhc9g292
 bGzFFqmu43cpDUYmFvFn5XFb+hbVudhoYP7a/nU9rK9Avvg139gHaoBAln1vfOpfQoTN
 p0nZ89ZfH3JSfkqBjBxGGFRJ6v/WE7OgwBzZuAZaSqQ5K93YyH3zQMqmJ+CQM5RIJLxV
 W6qQ==
X-Gm-Message-State: AOAM530cVCm6+UllgklASTPWEkQZsvFaVKocBmpnSPjn1YmG94FSeJg6
 w1pgLS9xSimg/UkV1M06/wD+Ugj87LI=
X-Google-Smtp-Source: ABdhPJynm3oi1fhv3YF2kb1JpWRXK7yqS45casH4zdSmG1P5r7lINnBnu6uVBnHxmS2WltC2LfMlOg==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr3060245wrb.292.1601747386219; 
 Sat, 03 Oct 2020 10:49:46 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id u8sm6010828wmj.45.2020.10.03.10.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2020 10:49:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Subject: [PATCH] linux-user/elfload: Avoid leaking interp_name using GLib
 memory API
Date: Sat,  3 Oct 2020 19:49:44 +0200
Message-Id: <20201003174944.1972444-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix an unlikely memory leak in load_elf_image().

Fixes: bf858897b7 ("linux-user: Re-use load_elf_image for the main binary.")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/elfload.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f6022fd704..1a3150df7c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2584,13 +2584,13 @@ static void load_elf_image(const char *image_name, int image_fd,
                 info->brk = vaddr_em;
             }
         } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
-            char *interp_name;
+            g_autofree char *interp_name = NULL;
 
             if (*pinterp_name) {
                 errmsg = "Multiple PT_INTERP entries";
                 goto exit_errmsg;
             }
-            interp_name = malloc(eppnt->p_filesz);
+            interp_name = g_malloc(eppnt->p_filesz);
             if (!interp_name) {
                 goto exit_perror;
             }
@@ -2609,7 +2609,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                 errmsg = "Invalid PT_INTERP entry";
                 goto exit_errmsg;
             }
-            *pinterp_name = interp_name;
+            *pinterp_name = g_steal_pointer(&interp_name);
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
@@ -2961,7 +2961,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     if (elf_interpreter) {
         info->load_bias = interp_info.load_bias;
         info->entry = interp_info.entry;
-        free(elf_interpreter);
+        g_free(elf_interpreter);
     }
 
 #ifdef USE_ELF_CORE_DUMP
-- 
2.26.2


