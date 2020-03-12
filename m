Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1343CC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1B7206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AI8YIRvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1B7206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCUGk-000611-VX
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCUG5-0005cK-4J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 16:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCUG3-0008VR-Ls
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 16:16:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCUG3-0008V3-F9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 16:16:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id a25so9206224wrd.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8Tro1z7uTIp12iQuDnwssQFro2Zzq8+IX8DXdBO8SLQ=;
 b=AI8YIRvIjbVTY7oDAMagQPOfSx5jEK2SnxmcDtTszUGceWT9+scIBaU5dOugoZIirE
 uPuscEaLPslrVICKx9MIImg6roh8kF0QrSzt4ixjxBWjBZjgjv0x0MgNesXYP20+EN0P
 P1zZlTGFKD1Uj4LFCBKBwXV8hLEA/0xgq+B6QUxiTePfgyhVDfxAhQO+sL3H7nhuR0nO
 WB022es1Ukuq7LBGaiB7SvcC1M2s936fy4Wx2pIXtbD+D7A6so3OTvTFUEPvh7YeRKkR
 PWmgjXWX3WaPe+yk1QEQhIB67Q6L0kwCSkLepo0a/MSZE+cATR6Ws4E6pERbPd8HOGoq
 DxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8Tro1z7uTIp12iQuDnwssQFro2Zzq8+IX8DXdBO8SLQ=;
 b=ixcSFJAH/GjdU0Qs+Dsf3giluUFkwlQN/SUDZO66STY0OoimQaUPP9ucLBgIdCHmHn
 rotvE+Yhx5+KvFKUju8uYtyqokffgkxKAQwIvCjH82rWhfT9DtBnPAx9hlvUVKemS3GX
 RHZk85St7AvxzB1D4GlPWh5cKvTfW5MgK5UB4zfOPGagTW29UlCBggqyjhDlKANGUTTt
 Ir6xPeRSRWkCn8dsW7eKEt4hW4CyFH1mOm0bhq8w6bFIh/tddi2+K04x59y2vri6vHkz
 YqU2rcVZoeGwofYyF6jCpUgl1PqEvBngMHRZfNyj40lh8k1a8qcoBjdJ2nP9pTN8W4eR
 ggZg==
X-Gm-Message-State: ANhLgQ22MlJ+TPLNJdkpCmKzuLOxnedEKj7M983QhBagxALCiWKsbcj2
 yICX3swVOL7Krp3FcJVImSWIIff28qjoWA==
X-Google-Smtp-Source: ADFU+vthCeejKzA61MkXfTHxhSvXKUVR9Y+eQmmNY/uwaxTRr41gM6/JDzzUUHymmbo9KnHD0LShWA==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr12915859wrt.352.1584044201685; 
 Thu, 12 Mar 2020 13:16:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p16sm4401554wmg.22.2020.03.12.13.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 13:16:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/net/i82596.c: Avoid reading off end of buffer in
 i82596_receive()
Date: Thu, 12 Mar 2020 20:16:38 +0000
Message-Id: <20200312201638.6375-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Helge Deller <deller@gmx.de>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The i82596_receive() function attempts to pass the guest a buffer
which is effectively the concatenation of the data it is passed and a
4 byte CRC value.  However, rather than implementing this as "write
the data; then write the CRC" it instead bumps the length value of
the data by 4, and writes 4 extra bytes from beyond the end of the
buffer, which it then overwrites with the CRC.  It also assumed that
we could always fit all four bytes of the CRC into the final receive
buffer, which might not be true if the CRC needs to be split over two
receive buffers.

Calculate separately how many bytes we need to transfer into the
guest's receive buffer from the source buffer, and how many we need
to transfer from the CRC work.

We add a count 'bufsz' of the number of bytes left in the source
buffer, which we use purely to assert() that we don't overrun.

Spotted by Coverity (CID 1419396) for the specific case when we end
up using a local array as the source buffer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I know Helge has some significant rework of this device planned, but
for 5.0 we need to fix the buffer overrun.

Tested with 'make check' only.
---
 hw/net/i82596.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index fe9f2390a94..2bd5d310367 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -501,7 +501,8 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
     uint32_t rfd_p;
     uint32_t rbd;
     uint16_t is_broadcast = 0;
-    size_t len = sz;
+    size_t len = sz; /* length of data for guest (including CRC) */
+    size_t bufsz = sz; /* length of data in buf */
     uint32_t crc;
     uint8_t *crc_ptr;
     uint8_t buf1[MIN_BUF_SIZE + VLAN_HLEN];
@@ -595,6 +596,7 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
         if (len < MIN_BUF_SIZE) {
             len = MIN_BUF_SIZE;
         }
+        bufsz = len;
     }
 
     /* Calculate the ethernet checksum (4 bytes) */
@@ -627,6 +629,7 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
         while (len) {
             uint16_t buffer_size, num;
             uint32_t rba;
+            size_t bufcount, crccount;
 
             /* printf("Receive: rbd is %08x\n", rbd); */
             buffer_size = get_uint16(rbd + 12);
@@ -639,14 +642,37 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
             }
             rba = get_uint32(rbd + 8);
             /* printf("rba is 0x%x\n", rba); */
-            address_space_write(&address_space_memory, rba,
-                                MEMTXATTRS_UNSPECIFIED, buf, num);
-            rba += num;
-            buf += num;
-            len -= num;
-            if (len == 0) { /* copy crc */
-                address_space_write(&address_space_memory, rba - 4,
-                                    MEMTXATTRS_UNSPECIFIED, crc_ptr, 4);
+            /*
+             * Calculate how many bytes we want from buf[] and how many
+             * from the CRC.
+             */
+            if ((len - num) >= 4) {
+                /* The whole guest buffer, we haven't hit the CRC yet */
+                bufcount = num;
+            } else {
+                /* All that's left of buf[] */
+                bufcount = len - 4;
+            }
+            crccount = num - bufcount;
+
+            if (bufcount > 0) {
+                /* Still some of the actual data buffer to transfer */
+                bufsz -= bufcount;
+                assert(bufsz >= 0);
+                address_space_write(&address_space_memory, rba,
+                                    MEMTXATTRS_UNSPECIFIED, buf, bufcount);
+                rba += bufcount;
+                buf += bufcount;
+                len -= bufcount;
+            }
+
+            /* Write as much of the CRC as fits */
+            if (crccount > 0) {
+                address_space_write(&address_space_memory, rba,
+                                    MEMTXATTRS_UNSPECIFIED, crc_ptr, crccount);
+                rba += crccount;
+                crc_ptr += crccount;
+                len -= crccount;
             }
 
             num |= 0x4000; /* set F BIT */
-- 
2.20.1


