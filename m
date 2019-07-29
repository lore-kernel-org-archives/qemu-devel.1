Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150EBC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75EB216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDjKgQ00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75EB216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53919 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7ZF-0002PO-Pr
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44006)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7QH-0007yL-JK
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7QG-0000vr-GJ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:49 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7QG-0000uj-AF; Mon, 29 Jul 2019 11:18:48 -0400
Received: by mail-pf1-x442.google.com with SMTP id 19so28198437pfa.4;
 Mon, 29 Jul 2019 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BVYr/4pg99TlxLJVHvYszPgNvVkW6Z+EpbJ9hRlTzFI=;
 b=bDjKgQ00T+8PMCE5hDNRKI9eCk8wLWrxaGUOXC2DELJ1BAsGDo174Djz2pa/eXa4M8
 VcZylvNEUx7a67cBGofgRlVMWXNDtKcuaSmkEknhEbCNG5leAf1uaN6Qg05MUCTz/w42
 2/kxwjtnqLvxSfRpDkaKeYIRaGr2myjFJwk+pZCyoTOgVqwY1K3BVdSxEcGHZl25t0bd
 xYGdu5xOrnuvdt7/Lf2BSj5c0WfDS4HwohRXG58fz50Kq51gzSFTrkJ7kzc+MIvNqY3n
 RDHlVgnFY2ol+c0fS/T8+7TJ3hgJA9JXz3DCmVKGtz5aIjXwlQ8CefhCgvEW7WucaurP
 qZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BVYr/4pg99TlxLJVHvYszPgNvVkW6Z+EpbJ9hRlTzFI=;
 b=fC91AxhorPYe+pmgZr0PVBjWs/zUzYy029EtW1IV4s4UVfFMyVLgj28n3xpJRy/CGi
 dZP8DRORzB5urGOMoQKF26zkb55tBVUCCYkxVPkIFxT3HjOXmr7p6/NHZKusHlGLxrwG
 mLFSfbwXdooSOEIJU2Mx3kj0PZJr+C3U8WyMMB//Giq6MSnTPg2815AWIXBzZyskDRzz
 FIRZbYKouvf4Ms0w3dK4dhU2ZeomQrk8yPsT0VeypAqBs040gZcm6lrtjRf0/P38f/92
 3cMNn6pHEfxZFhXLvfCXl993vg5Z/afcgE4noDhz3z6vJ54ZMGSWnexwoIVhjKdOYZ8m
 cpTw==
X-Gm-Message-State: APjAAAWcdhFv/DGh35s2ppDD/InL1aTstsZMNVMtKIgN3Od5DhPCq9OP
 VZ9bvu0IwsGBe+7S/1F+VogsdIL37Luu8Q==
X-Google-Smtp-Source: APXvYqwlDBdmo52sqKsmBRdBCq8JZVXRa0gTzUUJfscl1iLHpvEd1yxDSSkjRP5jz1/M81XaKEdqOA==
X-Received: by 2002:a63:eb51:: with SMTP id
 b17mr101771750pgk.384.1564413526870; 
 Mon, 29 Jul 2019 08:18:46 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.18.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:18:46 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:47 +0530
Message-Id: <20190729151651.21306-12-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729151651.21306-1-mehta.aaru20@gmail.com>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 11/15] qemu-io: adds option to use aio engine
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
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
 qemu-io.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index f64eca6940..6568f0c369 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -130,7 +130,8 @@ static void open_help(void)
 " -C, -- use copy-on-read\n"
 " -n, -- disable host cache, short for -t none\n"
 " -U, -- force shared permissions\n"
-" -k, -- use kernel AIO implementation (on Linux only)\n"
+" -k, -- use kernel AIO implementation (Linux only, prefer use of -i)\n"
+" -i, -- use AIO mode (threads, native or io_uring)"
 " -t, -- use the given cache mode for the image\n"
 " -d, -- use the given discard mode for the image\n"
 " -o, -- options to be given to the block driver"
@@ -172,7 +173,7 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     QDict *opts;
     bool force_share = false;
 
-    while ((c = getopt(argc, argv, "snCro:kt:d:U")) != -1) {
+    while ((c = getopt(argc, argv, "snCro:kit:d:U")) != -1) {
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
@@ -567,6 +578,11 @@ int main(int argc, char **argv)
             break;
         case 'k':
             flags |= BDRV_O_NATIVE_AIO;
+        case 'i':
+            if (bdrv_parse_aio(optarg, &flags) < 0) {
+                error_report("Invalid aio option: %s", optarg);
+                exit(1);
+            }
             break;
         case 't':
             if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0) {
-- 
2.21.0


