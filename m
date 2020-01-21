Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107C1C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD59122522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="QaoStADe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD59122522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itlgV-0006oZ-Ie
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 00:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1itlev-0005Wo-1S
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1itleq-0002QI-Tk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:01:00 -0500
Received: from ma1-aaemail-dr-lapp02.apple.com ([17.171.2.68]:39990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1itleq-0002Ph-OO
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:00:56 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp02.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 00L4us9d034026; Mon, 20 Jan 2020 21:00:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding; s=20180706;
 bh=JFPmgaeVABwyWdqH4RuK3Au9clG7Zn5BaxauzwN/gPM=;
 b=QaoStADeXYiapVGfsgYYD2Qg78MNTNRnbKT12vls7/MFUe+P3WShBxS48kBxFxiZvPi3
 gize9nCHcyQaC/rRQQYi/q25IaC8+xENzJ1XHqNMsRDXbQkziaEyA1smpo/+aa5820he
 LAAL4XrBdzVHJs/t8NQgpyoYIGy6WoFoboBA7xAAx5eJ7UnI6HxWLXRHMsK9LhLPfUyp
 earoMoDlpawoWfQD4gUGZccRZjNVx6UGXIDibJXuyiIM8zJlWH1qTszGVMmCtBRm/EW4
 aOa1sjUMdrcxOwKvIRHkwalqGO8sB5MFgm2G22kW/FLsdB1KElAZq8VwDNSemWnMKtoG 7A== 
Received: from mr2-mtap-s01.rno.apple.com (mr2-mtap-s01.rno.apple.com
 [17.179.226.133])
 by ma1-aaemail-dr-lapp02.apple.com with ESMTP id 2xkyjwyt1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 20 Jan 2020 21:00:56 -0800
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by mr2-mtap-s01.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q4F00AWIXXJKS00@mr2-mtap-s01.rno.apple.com>; Mon,
 20 Jan 2020 21:00:55 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q4F00C00XDY2N00@nwk-mmpp-sz11.apple.com>; Mon,
 20 Jan 2020 21:00:55 -0800 (PST)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: 433386c88cf43ea6207a58d758087b4e
X-Va-R-CD: 7beb1aa80d24fa7d920ea2e100cfdd16
X-Va-CD: 0
X-Va-ID: 260262cc-baff-471d-981f-e2f1a8e810cb
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 433386c88cf43ea6207a58d758087b4e
X-V-R-CD: 7beb1aa80d24fa7d920ea2e100cfdd16
X-V-CD: 0
X-V-ID: 0b6789e1-4d10-4ca2-869c-6ff14a3e96ec
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2020-01-20_10:,, signatures=0
Received: from pontoon.com (unknown [17.234.97.123]) by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q4F005Q7XXG3520@nwk-mmpp-sz11.apple.com>; Mon,
 20 Jan 2020 21:00:53 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH v2 2/2] vnc: prioritize ZRLE compression over ZLIB
Date: Mon, 20 Jan 2020 21:00:52 -0800
Message-id: <b5d129895d08a90d0a2a6183b95875bacfa998b8.1579582674.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
In-reply-to: <cover.1579582674.git.dirty@apple.com>
References: <cover.1579582674.git.dirty@apple.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2020-01-20_10:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.171.2.68
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
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

In my investigation, ZRLE always compresses better than ZLIB so
prioritize ZRLE over ZLIB, even if the client hints that ZLIB is
preferred.

zlib buffer is always reset in zrle_compress_data(), so using offset to
calculate next_out and avail_out is useless.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 ui/vnc-enc-zrle.c |  4 ++--
 ui/vnc.c          | 11 +++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index 17fd28a2e2..b4f71e32cf 100644
--- a/ui/vnc-enc-zrle.c
+++ b/ui/vnc-enc-zrle.c
@@ -98,8 +98,8 @@ static int zrle_compress_data(VncState *vs, int level)
     /* set pointers */
     zstream->next_in = vs->zrle->zrle.buffer;
     zstream->avail_in = vs->zrle->zrle.offset;
-    zstream->next_out = vs->zrle->zlib.buffer + vs->zrle->zlib.offset;
-    zstream->avail_out = vs->zrle->zlib.capacity - vs->zrle->zlib.offset;
+    zstream->next_out = vs->zrle->zlib.buffer;
+    zstream->avail_out = vs->zrle->zlib.capacity;
     zstream->data_type = Z_BINARY;
 
     /* start encoding */
diff --git a/ui/vnc.c b/ui/vnc.c
index 3e8d1f1207..1d7138a3a0 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2071,8 +2071,15 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             break;
 #endif
         case VNC_ENCODING_ZLIB:
-            vs->features |= VNC_FEATURE_ZLIB_MASK;
-            vs->vnc_encoding = enc;
+            /*
+             * VNC_ENCODING_ZRLE compresses better than VNC_ENCODING_ZLIB.
+             * So prioritize ZRLE, even if the client hints that it prefers
+             * ZLIB.
+             */
+            if ((vs->features & VNC_FEATURE_ZRLE_MASK) == 0) {
+                vs->features |= VNC_FEATURE_ZLIB_MASK;
+                vs->vnc_encoding = enc;
+            }
             break;
         case VNC_ENCODING_ZRLE:
             vs->features |= VNC_FEATURE_ZRLE_MASK;
-- 
2.24.0


