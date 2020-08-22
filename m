Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11B5C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACA6206B5
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhyKjQET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACA6206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9UYR-00027z-Na
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 10:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9UVX-0007yK-Ul
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:28:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9UVW-0003EC-6v
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598106512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQe3QmceCc/tiRIrUidZfVVvAGh31Rv4ZDjVDhX3dPk=;
 b=dhyKjQET/nTiFDb3P6JVZ0AsiUb03rdkoOucoJZzlNLAD4995t2q7VJ7lGymT6JsBbBXZ8
 pfS2HWcUcKklbCyRMpc6mg9XJtZ2LBQZxFtgwxZ9FIatXQl/5pyIadY2BxF+Q49UvYLo2z
 tNLgTEqPO+r6shnyYyo/cy46H1eMcNY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-E0r9JirnPNGgrYQlMjgQNQ-1; Sat, 22 Aug 2020 10:28:30 -0400
X-MC-Unique: E0r9JirnPNGgrYQlMjgQNQ-1
Received: by mail-wr1-f72.google.com with SMTP id e12so1760110wra.13
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 07:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mQe3QmceCc/tiRIrUidZfVVvAGh31Rv4ZDjVDhX3dPk=;
 b=FwGvkWpl6wRqX72pyRuGn6vtjVCk74xRLssFUMBohMcVZVFKU6FuszDTCEE4jO92VJ
 lSihciQ6wFU0TIfyi96srd5UdzGlnUwnhtFEQvYSj0CdJsduoCtNf7ROaL9yo2EHI7iZ
 mbubnm/0VZkqdYayfWSM+IsZWig+sj236m7/SHmyMazHfaLLjHw9RxXWRLqNOodSc2A9
 HQtSczEbsHkPHvEA4EM4GCPakQ953/J6UObqweeD6R2+9BGAtmF1cfWf6lf4Sy9pfs9g
 GbuUsDzNCCtnFbQ66lyJy8dubabXKG2gE9EScyZy+XaoZbFLFe8dJY8LKVv/X/2FgTEc
 pApA==
X-Gm-Message-State: AOAM532OCwAZzqX3AtEESAlyPIgNUKvxoDkRTUP2yLg9CPpj+gUJiZSz
 2zNFb3Teg4ysBKEL/4zLMO2JT8G0oHprVV70vPQxDsneA5ZnmVzoAkGiefJijSPI3dqpuUfY3+b
 4Nj+Iq5MDD1RPfiw=
X-Received: by 2002:a1c:283:: with SMTP id 125mr8972510wmc.12.1598106509463;
 Sat, 22 Aug 2020 07:28:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaVN7dnbDmUJdjo97lChf1n2TBXjc+C5nifIFmPd4ikNVUf2yLTl89cgSlTNG3inH8AVEKdg==
X-Received: by 2002:a1c:283:: with SMTP id 125mr8972496wmc.12.1598106509291;
 Sat, 22 Aug 2020 07:28:29 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b14sm11434171wrj.93.2020.08.22.07.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2020 07:28:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] hw/isa/superio: Do not enforce class_size when
 inherited from parent
Date: Sat, 22 Aug 2020 16:28:16 +0200
Message-Id: <20200822142816.1318214-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200822142816.1318214-1-philmd@redhat.com>
References: <20200822142816.1318214-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 10:28:32
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

When a class inherits from an abstract parent, its class_size
is already initialized to its parent size. If the class is not
extended, it is pointless to set the class_size field again.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/isa/smc37c669-superio.c | 1 -
 hw/isa/vt82c686.c          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
index 9e59dc16039..18cdc641e13 100644
--- a/hw/isa/smc37c669-superio.c
+++ b/hw/isa/smc37c669-superio.c
@@ -103,7 +103,6 @@ static void smc37c669_class_init(ObjectClass *klass, void *data)
 static const TypeInfo smc37c669_type_info = {
     .name          = TYPE_SMC37C669_SUPERIO,
     .parent        = TYPE_ISA_SUPERIO,
-    .class_size    = sizeof(ISASuperIOClass),
     .class_init    = smc37c669_class_init,
 };
 
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index a4b84d405d0..49f2b21cebe 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -533,7 +533,6 @@ static void vt82c686b_superio_class_init(ObjectClass *klass, void *data)
 static const TypeInfo via_superio_info = {
     .name          = TYPE_VT82C686B_SUPERIO,
     .parent        = TYPE_ISA_SUPERIO,
-    .class_size    = sizeof(ISASuperIOClass),
     .class_init    = vt82c686b_superio_class_init,
 };
 
-- 
2.26.2


