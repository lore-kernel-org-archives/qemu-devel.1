Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7FAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1661A20684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhNTljLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1661A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuf1N-00080o-Km
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrE-0004n6-UX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrD-00039v-SS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:16 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrD-00036m-LF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:15 -0500
Received: by mail-wr1-x431.google.com with SMTP id y11so3144101wrt.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=360Uym95aAoMIby8JYd5NjrSL14NdJnqbG1F2Mzf77A=;
 b=RhNTljLqhitikAWm2tS9llo5JIdmrqkRL4jDq7KCAI0ehr07sq+U/AqfbG61pRUgAF
 GbStD1Xcn2FETD5k6oDlRbKyxHBqV/4efokPNrHGu7lUbblem+QHla8+3ozjjdgy/aKf
 phAokdouE7yHA7dem9frkP1Y1Zl60FcT9nRycJoiWbW7nIBTAcP24eqprwwgPfzsbZ2R
 eAKOFRe+UWlQvhWL+uXsdLYQd0cTL/+wNLFI6/S6ZSqcy+NMO7b7x1VEGArUq6iRrC+f
 IsWWQui97IcwuT3iok70hIM7UAGIie8VUZ9Us79PKo4PlnLS33yO1lwrVxY9Z7XEEWD2
 zoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=360Uym95aAoMIby8JYd5NjrSL14NdJnqbG1F2Mzf77A=;
 b=l4ZLkClJlzPHgfIrCuuOZzbhTXMo5Qwj9zeERuZqyw/NgZ2xIbGdqBzsPgOW5l1bIv
 Mab4k0sHUFaYAsqNfFCFpcaDbZB9dFGOKFEzuj7omyiRV0D/YqM/J02e1MfTIA/ZTGTb
 0aHh6xVIo+6ob+1nMmPgHjOTFNQX0LqIW9TfOJftpBByQTDDH4qj7Zj0c0hB29kER0Lv
 666DcbX8RsB2e/5Y3OmAXHZtOTyqZGVRYhGDAcdCuxCAqyVPTGZEhOKeo048Eft/PgFe
 BYwl9OtwHZZFJOZz82MRpzyV2BlRufFGZ+Aawv2XPFu34vptbltOQUHmiG1ebLswkxtF
 lEYg==
X-Gm-Message-State: APjAAAUhnZBdm4pXopCUt7sJ8S2WnJjH+Lm1AkoVjumiKxPKnrktQjkz
 gK4awtUiVq7JW4mkwsc56QP62xJg
X-Google-Smtp-Source: APXvYqyKlB0DOGJVXS/h9qceDAvQOY6S6GEsWx+vs9rmhNQmBjpCxzoE3uu71lYuv4dETcEUPOXmFQ==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr17036344wro.194.1579787354289; 
 Thu, 23 Jan 2020 05:49:14 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/59] hw/net/imx_fec: Rewrite fall through comments
Date: Thu, 23 Jan 2020 14:48:12 +0100
Message-Id: <1579787342-27146-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

GCC9 is confused by this comment when building with CFLAG
-Wimplicit-fallthrough=2:

  hw/net/imx_fec.c: In function ‘imx_eth_write’:
  hw/net/imx_fec.c:906:12: error: this statement may fall through [-Werror=implicit-fallthrough=]
    906 |         if (unlikely(single_tx_ring)) {
        |            ^
  hw/net/imx_fec.c:912:5: note: here
    912 |     case ENET_TDAR:     /* FALLTHROUGH */
        |     ^~~~
  cc1: all warnings being treated as errors

Rewrite the comments in the correct place,  using 'fall through'
which is recognized by GCC and static analyzers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191218192526.13845-5-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/imx_fec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index bd99236..c01ce4f 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -909,7 +909,8 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
                           TYPE_IMX_FEC, __func__);
             return;
         }
-    case ENET_TDAR:     /* FALLTHROUGH */
+        /* fall through */
+    case ENET_TDAR:
         if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
             s->regs[index] = ENET_TDAR_TDAR;
             imx_eth_do_tx(s, index);
-- 
1.8.3.1



