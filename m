Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2DEC35E02
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0D621927
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMUDtCuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0D621927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZTY-0001lw-4q
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlI-0001nT-8k
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlH-0001Ka-3v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:28 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:54501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlG-0001Gn-TB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:27 -0500
Received: by mail-wm1-x332.google.com with SMTP id z12so2665995wmi.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U33IG0nQfGpQvrbD6qZCIIWsG5daKlCOV2RghJ+gDTs=;
 b=pMUDtCufO3AVeq3RI23yPZ+dz9bzzBNaYkeigQ5b7AjLSdyEB9k1IE4yE6/Bt3DuiG
 ciFln1tFbTvidaYVgSgiDco1eYU1+vQI0LPg2nc0LJ41MmAFhMtxMUCbXHw2s2mEMvVW
 iWQcGLT6Ppl0mlmmdBCJwF5TjZ8Cf7TAcavKkZmr9s853x1sATZhtwYd8OySzvEVc5c3
 fcl9V9ZowrI0UawRXOjCimxKhIZ99zQ/TQnxIFHIl/m2nONfNr7qj9h6JgNKpBcMsctg
 DuFjBepCYjAfpx3x2yVHNz7YSTnCpjAkz2saOFGJVQ78WgpfzPYFtIDyduEUe/NxI0of
 ULkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=U33IG0nQfGpQvrbD6qZCIIWsG5daKlCOV2RghJ+gDTs=;
 b=QT+K+Forf5KfODC5eqazY1c65mIKkZewGU6D7L8izmC+ZpmcPB8VNXaaKXoRMBER19
 dyZUkksZvhKsomAo161mspwxisCjqd0e4/Viseh9MZb1NeHVw5VCHJq+DOMKZ7k9PaYF
 NZff4YgsJucNE3TPZmqpSqmGuQYQLZYNEE7UJo9Xx1EMjACHlblIyOZR71gNM9366ohj
 Znfil6D2X/xPfPnFyFyn6f6j7pGJUK4/W6HhqEdcLU4lyb5UygGOhW2NDVgCccwkfgcB
 Q+C4Yz8KlPDqBqWngzj09gdQUnFM9XHh3KLWf94U/bQQgPM1Q8Z6MeRko4ZLRWlSunGo
 tbIQ==
X-Gm-Message-State: APjAAAXzrKkaxQboiDQi0AveubEXc8wRuITrFNfmk0cggSWhZmblAUVk
 SNSHraLYoMra2F1LE5ixB67ir0k7
X-Google-Smtp-Source: APXvYqzNHALiYH9QmEOgTx0oNpUdfy0Tz6jsSTrX2ny6HlxwZBfozQutN96FA2EGfjohQ7TC/rLuAA==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr5213529wmg.66.1582631545733; 
 Tue, 25 Feb 2020 03:52:25 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 085/136] hw/net: Avoid casting non-const pointer,
 use address_space_write()
Date: Tue, 25 Feb 2020 12:50:15 +0100
Message-Id: <1582631466-13880-85-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The NetReceive prototype gets a const buffer:

  typedef ssize_t (NetReceive)(NetClientState *, const uint8_t *, size_t);

We already have the address_space_write() method to write a const
buffer to an address space. Use it to avoid:

  hw/net/i82596.c: In function ‘i82596_receive’:
  hw/net/i82596.c:644:54: error: passing argument 4 of ‘address_space_rw’ discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/net/dp8393x.c                       |  3 +--
 hw/net/i82596.c                        |  4 ++--
 scripts/coccinelle/exec_rw_const.cocci | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index a134d43..580ae44 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -787,8 +787,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     /* Put packet into RBA */
     DPRINTF("Receive packet at %08x\n", dp8393x_crba(s));
     address = dp8393x_crba(s);
-    address_space_rw(&s->as, address,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)buf, rx_len, 1);
+    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED, buf, rx_len);
     address += rx_len;
     address_space_rw(&s->as, address,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, 4, 1);
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 3a0e1ec..a292984 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -640,8 +640,8 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
             }
             rba = get_uint32(rbd + 8);
             /* printf("rba is 0x%x\n", rba); */
-            address_space_rw(&address_space_memory, rba,
-                MEMTXATTRS_UNSPECIFIED, (void *)buf, num, 1);
+            address_space_write(&address_space_memory, rba,
+                                MEMTXATTRS_UNSPECIFIED, buf, num);
             rba += num;
             buf += num;
             len -= num;
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 7e42682..87897dd 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -9,6 +9,20 @@
            --dir .
 */
 
+// Use address_space_write instead of casting to non-const
+@@
+type T;
+const T *V;
+expression E1, E2, E3, E4;
+@@
+(
+- address_space_rw(E1, E2, E3, (T *)V, E4, 1)
++ address_space_write(E1, E2, E3, V, E4)
+|
+- address_space_rw(E1, E2, E3, (void *)V, E4, 1)
++ address_space_write(E1, E2, E3, V, E4)
+)
+
 // Remove useless cast
 @@
 expression E1, E2, E3, E4;
-- 
1.8.3.1



