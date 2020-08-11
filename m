Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA41BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B84E206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0aHOXO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B84E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5W2Q-0007l3-L6
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5W1I-00064p-Tk
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5W1G-0000bd-Sa
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597159013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgFzM+n3IeTrfcF7OGV45qOrWhRc4BTzy+CQeBkHFKI=;
 b=H0aHOXO6JM5rCHcf7nDbEKEEAO3bGg/wgbb1IUdIBwNgiUxQxBuF9xIdpiMW1TIkyXalx2
 gVEBwp5n4cFTbTUi+/ugq4f7hbDiy2Gj9Et/CotV0FM6ToMRcjCAwDwzed0GykGaQShjbW
 4GgY2MeI5ml4cEik+XrCkCIro/UAXJs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-19uVAJ-SOD6oSMf4tC8LYQ-1; Tue, 11 Aug 2020 11:16:52 -0400
X-MC-Unique: 19uVAJ-SOD6oSMf4tC8LYQ-1
Received: by mail-wm1-f72.google.com with SMTP id c184so790032wme.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PgFzM+n3IeTrfcF7OGV45qOrWhRc4BTzy+CQeBkHFKI=;
 b=MSm6Y2UrJ3ytDoTLG8eLfuxFDWw6LtIGTR2Jk08ozP5/PXWvf7ypFO232+TRlRtlFe
 CDvxOUvtpWGZavZWEXzbCmbmY8LGybguqOTztCi2veZtgf8YaSASxGCt7J2wQcPrhxuK
 owXZJi667rv3tsEAWhYC6uDliPJI7w3uXXB/IaL1OsDU6fbGRHZmSOLVzm0Kz1/S/C2P
 aO1CseWRhbw0Y1+ZIWUCvVHP9yGaFID5UGIeMOCoSntdhMJFiXOwlbxxOeJ2NOynzx7v
 afeQR8C6uTftLk3NfykxMEneJGfncDOYYdTq7uRnFVlviPIe4C5qKMl7Agq5IxQRGdB7
 762w==
X-Gm-Message-State: AOAM531XztSmF6pePlpVPGy6whVLAFWub+T82v2gO0R7MObeU2NWPOjB
 8CAAG0+r93ZsYbuihIuJSb4Ry1JD4Kd5iN7qBrKjmE1qG06me8Lud81V9lCDgSVJrcp+ut3uSQW
 9HxOWVEPnh/u5+78=
X-Received: by 2002:a5d:5710:: with SMTP id a16mr31772929wrv.217.1597159010932; 
 Tue, 11 Aug 2020 08:16:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrBrPflSWsXyTMDezcjP7eZSmQoFDsz+Ze+0rhREkyhpoElcaz1LEtuoet2K0svto0mHXGrw==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr31772913wrv.217.1597159010774; 
 Tue, 11 Aug 2020 08:16:50 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z207sm6247867wmc.2.2020.08.11.08.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 08:16:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/3] hw/i2c: Fix typo in description
Date: Tue, 11 Aug 2020 17:16:41 +0200
Message-Id: <20200811151643.21293-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200811151643.21293-1-philmd@redhat.com>
References: <20200811151643.21293-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 05:47:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the second 'and' introduced in commit 73d5f22ecb
("hw/i2c: Document the I2C qdev helpers").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/i2c/i2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index a9c030a512..f57808851e 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -102,7 +102,7 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
 I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
 
 /**
- * Realize and and drop a reference an I2C slave device
+ * Realize and drop a reference an I2C slave device
  * @dev: I2C slave device to realize
  * @bus: I2C bus to put it on
  * @addr: I2C address of the slave on the bus
-- 
2.21.3


