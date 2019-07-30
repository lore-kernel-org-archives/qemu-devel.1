Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638F4C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B14D2087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAL0ShHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B14D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsW8C-0007rk-Eb
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35836)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW30-0005rH-Pf
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW2z-0000PX-KB
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:26 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hsW2z-0000P8-Da; Tue, 30 Jul 2019 13:36:25 -0400
Received: by mail-pf1-x441.google.com with SMTP id b13so30208413pfo.1;
 Tue, 30 Jul 2019 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ipr3iNyxvPc1pw+FEpkLWVBnB0CK9mROZwdZiLP7cbc=;
 b=cAL0ShHQZsLPdL3PFRrNQ17vNpwMi7pb5aJ6MHfW9L0DGYWgLq3IkrFSqczAw0Jet8
 gnHlgUBtDE9tUGDaywSxy+IiIosKd6qqOWG6kNIeBqsjcnU3XsnHqdMNa8y2sYdIe00I
 jSCPwPV1RJuvd3WpYUsVuf1J3RA0ub9FBWINxtdBRqeCPQhd/IJXlgZ4+FAH4AfZidJB
 m8gqn1UL26q+Xjh51ujr2I606s+jd+mGntWlqZBNZwL7/FCUMtD2D/Yz/WWNAF//SEQt
 wuCaMsofIhqijK15HnSX2bp5p9kM6x+8kKQpuvKqDFJBmdc4S/wj/yj3Cf6Uiv/9IuZh
 dZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ipr3iNyxvPc1pw+FEpkLWVBnB0CK9mROZwdZiLP7cbc=;
 b=GW/Q09BrpEtHaB7iZJvhYgLMswTadqR5lyC4LwLGuHTlYS1KTKLymWd0bwRThzJMli
 fV5JggEYZZ49CvSIwgBiNgu4/9p1CjJppwPrb4Vz4HtIfklBrFvurhDVV6jiNLFS9GKq
 7rjioO34Y95IGDedH4a1On2JyZHPosnpedyTIHvmlkzCDmnOwOakCuuCpjjfSS4Wzgxq
 gq3xDHMTbemgiE/9uVswzof4J737QKKukhkN3rcwh/DsguJcm+8JfuYATTFtsybP5MSn
 LXiIe/Sh/ehQUXxtTCnIpIIkl2Ql9wIF+eMDpQIosozMY7Urj8ltxNxE3LIdwFSLcQCR
 Ol6Q==
X-Gm-Message-State: APjAAAXduR0EKBh6p367afi5+kH/6kZinzjFbQPk1m6252tU+ZUja7xG
 SXXAFXh/NVloE7Lfn0M7Pni5lP+3P+oKxA==
X-Google-Smtp-Source: APXvYqxh12DVKX8vkQ9g3bjhtCaX/MJjbIzLvGJhl2gB1qocXPsxfSCkcVLdieKmIcBoy4Hyy2xQRQ==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id
 q10mr117732468pjv.95.1564508184100; 
 Tue, 30 Jul 2019 10:36:24 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id q24sm59122895pjp.14.2019.07.30.10.36.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 10:36:23 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 23:04:36 +0530
Message-Id: <20190730173441.26486-12-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730173441.26486-1-mehta.aaru20@gmail.com>
References: <20190730173441.26486-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v8 11/16] qemu-io: adds option to use aio engine
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 qemu-io.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index f64eca6940..0abb4af134 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -130,7 +130,8 @@ static void open_help(void)
 " -C, -- use copy-on-read\n"
 " -n, -- disable host cache, short for -t none\n"
 " -U, -- force shared permissions\n"
-" -k, -- use kernel AIO implementation (on Linux only)\n"
+" -k, -- use kernel AIO implementation (Linux only, prefer use of -i)\n"
+" -i, -- use AIO mode (threads, native or io_uring)\n"
 " -t, -- use the given cache mode for the image\n"
 " -d, -- use the given discard mode for the image\n"
 " -o, -- options to be given to the block driver"
@@ -172,7 +173,7 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     QDict *opts;
     bool force_share = false;
 
-    while ((c = getopt(argc, argv, "snCro:kt:d:U")) != -1) {
+    while ((c = getopt(argc, argv, "snCro:ki:t:d:U")) != -1) {
         switch (c) {
         case 's':
             flags |= BDRV_O_SNAPSHOT;
@@ -204,6 +205,13 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
                 return -EINVAL;
             }
             break;
+        case 'i':
+            if (bdrv_parse_aio(optarg, &flags) < 0) {
+                error_report("Invalid aio option: %s", optarg);
+                qemu_opts_reset(&empty_opts);
+                return -EINVAL;
+            }
+            break;
         case 'o':
             if (imageOpts) {
                 printf("--image-opts and 'open -o' are mutually exclusive\n");
@@ -291,7 +299,9 @@ static void usage(const char *name)
 "  -n, --nocache        disable host cache, short for -t none\n"
 "  -C, --copy-on-read   enable copy-on-read\n"
 "  -m, --misalign       misalign allocations for O_DIRECT\n"
-"  -k, --native-aio     use kernel AIO implementation (on Linux only)\n"
+"  -k, --native-aio     use kernel AIO implementation\n"
+"                       (Linux only, prefer use of -i)\n"
+"  -i, --aio=MODE       use AIO mode (threads, native or io_uring)\n"
 "  -t, --cache=MODE     use the given cache mode for the image\n"
 "  -d, --discard=MODE   use the given discard mode for the image\n"
 "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
@@ -489,7 +499,7 @@ static QemuOptsList file_opts = {
 int main(int argc, char **argv)
 {
     int readonly = 0;
-    const char *sopt = "hVc:d:f:rsnCmkt:T:U";
+    const char *sopt = "hVc:d:f:rsnCmki:t:T:U";
     const struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -501,6 +511,7 @@ int main(int argc, char **argv)
         { "copy-on-read", no_argument, NULL, 'C' },
         { "misalign", no_argument, NULL, 'm' },
         { "native-aio", no_argument, NULL, 'k' },
+        { "aio", required_argument, NULL, 'i' },
         { "discard", required_argument, NULL, 'd' },
         { "cache", required_argument, NULL, 't' },
         { "trace", required_argument, NULL, 'T' },
@@ -568,6 +579,12 @@ int main(int argc, char **argv)
         case 'k':
             flags |= BDRV_O_NATIVE_AIO;
             break;
+        case 'i':
+            if (bdrv_parse_aio(optarg, &flags) < 0) {
+                error_report("Invalid aio option: %s", optarg);
+                exit(1);
+            }
+            break;
         case 't':
             if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0) {
                 error_report("Invalid cache option: %s", optarg);
-- 
2.21.0


