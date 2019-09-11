Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2183ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9218520863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1dC051L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9218520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82hM-0004Xl-5t
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1i82fx-0003Iv-TR
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1i82fx-00025i-13
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:28:49 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:33210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1i82fw-00025J-Rm
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:28:48 -0400
Received: by mail-ed1-x52f.google.com with SMTP id o9so20683401edq.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 06:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V1495VjBr5Eee/kq6x6EHhYczJaWW3yVjCdU/LV7Ty4=;
 b=u1dC051LW77bp9B23kRV6AmfNSzZIwY/X9BYF2a6TDEKc1AeTGHez/Kl7AMII19QMV
 1ECJN244Q9y5QOvl0JcryTbTpMY2XM+fueQOZLhMlVvoULrTdLvqJ8BFxIdvA/QOPQwS
 2JDO0bhu/0AT8kOg0n6XkNuQXXMrzzf1ReMXQmDQAuEftQIqghKDFif3neBwQ43lNuGC
 pOw0robJ2T0N+DHPpDe14PCK+21g9zJEajzJPZmSOnaq/N7ZL7hyG0qQOF2KJw7WRDmV
 anDpsFPoElyTxOmpRY5Oe7IQgFdb6X4RSe+foX5Agidqs7rA14C2jb9xKtqyXpljpCfW
 3isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V1495VjBr5Eee/kq6x6EHhYczJaWW3yVjCdU/LV7Ty4=;
 b=cEgHL2NTmY9X6zWPFoPxj46/XfaTNEjm3wc87YUnkBxO5QSMql5uitzWRDse6UA0Fo
 ZbTu9HQ9efhkXEQmjpg6MNhku4XhRNoQE24aj/NTYb1v8a+zKFUl5VYehZDLyqEI9GJm
 3o2nKqMO1PSiu0mnMPBg5i0a6FcfMc6wXwO3uVWKaoaaS7xtB1uiaeIX3pgepQbFq4cf
 wgdVTuG+CubTJ5dTZ7ZTjEoInqRTSP3QF75+fdN9RokHIEdjO5AHlgSbOkQERI+uzVVu
 VoyNWWzXIBa5H60xVrPBgf+yuZCulmCqlW7RuRXeN+jVwMZoSDJV0QqIgkN+gxTNnEUX
 qNMQ==
X-Gm-Message-State: APjAAAUsb1dLtBeJbwIQx0Lm2Ncs2rzqux9hiVhDNPC22afwXjsHJlu0
 sNDVOsBJVEbPnEaqDGZ7PSiiHKDD
X-Google-Smtp-Source: APXvYqz/zsLNxS3uISJ4ENjDI6gz6yqweEDYUKpv3fPJd3m3hDB+9uFfrQIG3F4redSfZZ9VB4qmOg==
X-Received: by 2002:a17:906:aad2:: with SMTP id
 kt18mr29677939ejb.201.1568208527577; 
 Wed, 11 Sep 2019 06:28:47 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id l1sm4152298edc.11.2019.09.11.06.28.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Sep 2019 06:28:46 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 13:28:38 +0000
Message-Id: <20190911132839.23336-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190911132839.23336-1-richard.weiyang@gmail.com>
References: <20190911132839.23336-1-richard.weiyang@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::52f
Subject: [Qemu-devel] [PATCH V2 1/2] migration/qemu-file: remove check on
 writev_buffer in qemu_put_compression_data
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

The check of writev_buffer is in qemu_fflush, which means it is not
harmful if it is NULL.

And removing it will make the code consistent since all other
add_to_iovec() is called without the check.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/qemu-file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index e33c46764f..47f16d0e54 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -761,9 +761,7 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
     }
 
     qemu_put_be32(f, blen);
-    if (f->ops->writev_buffer) {
-        add_to_iovec(f, f->buf + f->buf_index, blen, false);
-    }
+    add_to_iovec(f, f->buf + f->buf_index, blen, false);
     f->buf_index += blen;
     if (f->buf_index == IO_BUF_SIZE) {
         qemu_fflush(f);
-- 
2.15.1


