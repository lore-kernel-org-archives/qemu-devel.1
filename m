Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E7EC43467
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C3221481
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFxYTrnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C3221481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIOi-0003IJ-Nr
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJIDa-0000CH-Pe
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:22:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJIDY-0003UF-LD
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600442551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsJ9T03FLpo5/oRUzIMD8dt9gfahzYwEoPIInb5/pLg=;
 b=PFxYTrnDd9wJSzrM5vS/MoZyEMIhf9fv0MLZtwmgES7CHkF26IezVkCArvXHMuq5L1IZfF
 TSahKpPSlCNF74a3pVaL8x8r7Dz9SlT432y08LUeE/ugVNjYXY+qtlI7CBo8tpzzG1L0iu
 agS2uxuFtfWUUinUt1MH1RwL6P3gJ7g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-Z1kPAjUcNHuolcjZrtbbQw-1; Fri, 18 Sep 2020 11:22:16 -0400
X-MC-Unique: Z1kPAjUcNHuolcjZrtbbQw-1
Received: by mail-wm1-f72.google.com with SMTP id l26so1571457wmg.7
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SsJ9T03FLpo5/oRUzIMD8dt9gfahzYwEoPIInb5/pLg=;
 b=sxxlZOSVpy063UEJloSBYnoFLk5w7M7BORMPVzoxim5UjUh+ngfphLBJnPv33+dJWN
 LAyWay4nqzwDzjXzH8XGZHZ3II3HCDyI6DYUIacyFjsIJltQQMVDvhaQyedeg+Jvy1Pg
 x4VYwBgP4OlkhgjhwoEMslQK1tu4sTjaPm/BDATlEQ1EELXbYsUn6n2tnF4twkfrAOma
 FMq0xpTnZmrvrS2lFdYgm4d6yrQBY+Zp6xoAIuvVf29jYDvbqNtkjIqpOXKS3usBX7GD
 U6qz9dNthGQowd5imXf+UMjYpVcnKOwCRK+fDI5vc0jpFN2zP5fRYY/n97mTX1d+rShY
 if9g==
X-Gm-Message-State: AOAM533ek31h7OYc4F/SKYQLVbXFjvVKdxU932+c8jRMqjRxbdPAn0kT
 BVh18bIwYbPdmQBhhnk+YWKV9/Fn1Qjwyoiuiqj0GQDC56O4Itps1yWXRPpLbTr836CLDNACZrp
 TEdqe7i07Eo8qbKY=
X-Received: by 2002:adf:81c6:: with SMTP id 64mr37031754wra.176.1600442534507; 
 Fri, 18 Sep 2020 08:22:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDdirnvEKJHUZ9rncgN/VlrCM7/4hHmSrWx3Ho8whcY8/EY3xim+zmQ/JE5JLx+rtteJWLzw==
X-Received: by 2002:adf:81c6:: with SMTP id 64mr37031742wra.176.1600442534330; 
 Fri, 18 Sep 2020 08:22:14 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l19sm5440401wmi.8.2020.09.18.08.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:22:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] hw/nvram/fw_cfg: fix FWCfgDataGeneratorClass::get_data()
 consumption
Date: Fri, 18 Sep 2020 17:22:07 +0200
Message-Id: <20200918152207.157589-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918152207.157589-1-philmd@redhat.com>
References: <20200918152207.157589-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 08:09:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laszlo Ersek <lersek@redhat.com>

The documentation on g_byte_array_free()
<https://developer.gnome.org/glib/stable/glib-Byte-Arrays.html#g-byte-array-free>
says:

> Returns
>
> the element data if free_segment is FALSE, otherwise NULL. The element
> data should be freed using g_free().

Because we currently call g_byte_array_free() with free_segment=TRUE, we
end up passing data=NULL to fw_cfg_add_file().

On the plus side, fw_cfg_data_read() and fw_cfg_dma_transfer() both deal
with NULL data gracefully: QEMU does not crash when the guest reads such
an item, the guest just gets a properly sized, but zero-filled blob.

However, the bug breaks UEFI HTTPS boot, as the IANA_TLS_CIPHER array,
generated otherwise correctly by the "tls-cipher-suites" object, is in
effect replaced with a zero blob.

Fix the issue by passing free_segment=FALSE to g_byte_array_free():

- the caller (fw_cfg_add_from_generator()) temporarily assumes ownership
  of the generated byte array,

- then ownership of the byte array is transfered to fw_cfg, as
  fw_cfg_add_file() links (not copies) "data" into fw_cfg.

Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Fixes: 3203148917d035b09f71986ac2eaa19a352d6d9d
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200916151510.22767-1-lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index f3a4728288e..0e95d057fd5 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1056,7 +1056,7 @@ bool fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
         return false;
     }
     size = array->len;
-    fw_cfg_add_file(s, filename, g_byte_array_free(array, TRUE), size);
+    fw_cfg_add_file(s, filename, g_byte_array_free(array, FALSE), size);
 
     return true;
 }
-- 
2.26.2


