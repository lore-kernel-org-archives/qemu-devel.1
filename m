Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0FEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29203206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3qzReUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29203206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsBr-0001tg-Dl
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxsB4-0000ix-8d
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:19:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxsB2-0002Yg-OS
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595337563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNzbI9utSY5TYVTak6sCapo8DHgXPnOsnOEA+QtC6FI=;
 b=C3qzReUvUSnYoXNijKeQKzk5GDAjRUraBb7gbLr+nv7K7/7B0/yala1H7FbGj4WNWIR74t
 j+D6FOmx8K/eW/WtIpvP9lbfTpX8Fvt5fkVW0opXLnNa6HRvFp/ld1GTgySW8A8WgR6tMs
 a+ibuOsqM4JDJpTmGJNovN8bF1C9tng=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-nfT9V4gaNzaheQRPrE1AnA-1; Tue, 21 Jul 2020 09:19:20 -0400
X-MC-Unique: nfT9V4gaNzaheQRPrE1AnA-1
Received: by mail-wr1-f72.google.com with SMTP id z1so13041289wrn.18
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 06:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GNzbI9utSY5TYVTak6sCapo8DHgXPnOsnOEA+QtC6FI=;
 b=pEq/399uHyeMQ2j/uCuBD4XqZmok4UlUeaZSTpPfFZ4wU7jJ2JyFSZYUxokBF9wzAM
 DKXVniEWlrwSc+g1sJX+pLUp9IgYxEgBoxKjS2sYra2gGPGfQLvFhFOT0P2dTowdhJXH
 7q8cOz2j+HNSxsO1i1X4d3zJynPHe0jdMMY2XvH+CJd9CCIVu2RpAM2ZmCVS59txP/pe
 wy6x/Nfh4ZSNrgkDinHmuMa6Mez9JW8QET/DSJsgPBz95bP8xmuK5+fSKE2ad/uqAECg
 FvCuRa0N50y9K4r0SJN22WTs7x9Dck9HvVNur3EWNtXSre6l1v5LbF48JdlbWYvF11C8
 PU6g==
X-Gm-Message-State: AOAM533r9RSR2LqddP/dYjd+4/WyXvsYxVFDneS/ypwoyTVTqlEOAGhU
 P05C12Wi4I2FMnoYeKzoLy9lOHaoDHxew0a1ckK2XJNs0vEBufWkHZDqZhsnPbJ1V166qykL3Fs
 5TH1XmgJK//vL4ZA=
X-Received: by 2002:a1c:2e10:: with SMTP id u16mr3892313wmu.121.1595337559303; 
 Tue, 21 Jul 2020 06:19:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhYxqqLSwgyj3XM2IpAAXAzOnKPNwo7AVH9/4u5IydCTKn1X0dvi6XwEqJsJPiR4Om/vmUDA==
X-Received: by 2002:a1c:2e10:: with SMTP id u16mr3892302wmu.121.1595337559110; 
 Tue, 21 Jul 2020 06:19:19 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c15sm3355721wme.23.2020.07.21.06.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 06:19:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/nvram/fw_cfg: Simplify fw_cfg_add_from_generator()
 error propagation
Date: Tue, 21 Jul 2020 15:19:10 +0200
Message-Id: <20200721131911.27380-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200721131911.27380-1-philmd@redhat.com>
References: <20200721131911.27380-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document FWCfgDataGeneratorClass::get_data() return NULL
on error, and non-NULL on success. This allow us to simplify
fw_cfg_add_from_generator(). Since we don't need a local
variable to propagate the error, we can remove the ERRP_GUARD()
macro.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/nvram/fw_cfg.h | 4 +++-
 hw/nvram/fw_cfg.c         | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 11feae3177..bbcf405649 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -32,7 +32,9 @@ typedef struct FWCfgDataGeneratorClass {
      * @obj: the object implementing this interface
      * @errp: pointer to a NULL-initialized error object
      *
-     * Returns: reference to a byte array containing the data.
+     * Returns: reference to a byte array containing the data on success,
+     *          or NULL on error.
+     *
      * The caller should release the reference when no longer
      * required.
      */
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 3b1811d3bf..dfa1f2012a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1035,7 +1035,6 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
 void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
                                const char *gen_id, Error **errp)
 {
-    ERRP_GUARD();
     FWCfgDataGeneratorClass *klass;
     GByteArray *array;
     Object *obj;
@@ -1053,7 +1052,7 @@ void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
     }
     klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
     array = klass->get_data(obj, errp);
-    if (*errp) {
+    if (!array) {
         return;
     }
     size = array->len;
-- 
2.21.3


