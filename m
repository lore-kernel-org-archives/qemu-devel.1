Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24765C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B8920737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxn6Gv4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B8920737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAyye-0000TK-6d
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 13:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAywB-0004ti-ST
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:10:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56062
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAyw9-0005BI-Ia
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598461811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bgWiuKLGgTlmkNLXQyAAFxAMe+7mGI/lp7y5CPPPPo=;
 b=fxn6Gv4yoaGs0CzZ1SfM+FQEDbkLlMvW7sjvowiOKubEo40J14siJZO0Ir9fj0H9eNPRBb
 8c8QB4+OO/015Y9U7PmaM2xVmCEo/7rAI88e0+m7FJZ7O5Kj2SJXUSuU5UqZioNmVp28Qc
 XpNAL6Oh1Q4w47Pqsmuo5Rdw09TM/f0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-HgY4DnyMPa-bh3y12P73FQ-1; Wed, 26 Aug 2020 13:10:09 -0400
X-MC-Unique: HgY4DnyMPa-bh3y12P73FQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7DA410ABDD2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 17:10:08 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D6BF19C58;
 Wed, 26 Aug 2020 17:10:08 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] hda-audio: Set instance_size at base class
Date: Wed, 26 Aug 2020 13:10:03 -0400
Message-Id: <20200826171005.4055015-3-ehabkost@redhat.com>
In-Reply-To: <20200826171005.4055015-1-ehabkost@redhat.com>
References: <20200826171005.4055015-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Setting instance_size correctly at the base class will help us
avoid mistakes when declaring new subclasses.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/audio/hda-codec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index cbd92b72f2..2d16448181 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -898,6 +898,7 @@ static void hda_audio_base_class_init(ObjectClass *klass, void *data)
 static const TypeInfo hda_audio_info = {
     .name          = TYPE_HDA_AUDIO,
     .parent        = TYPE_HDA_CODEC_DEVICE,
+    .instance_size = sizeof(HDAAudioState),
     .class_init    = hda_audio_base_class_init,
     .abstract      = true,
 };
@@ -914,7 +915,6 @@ static void hda_audio_output_class_init(ObjectClass *klass, void *data)
 static const TypeInfo hda_audio_output_info = {
     .name          = "hda-output",
     .parent        = TYPE_HDA_AUDIO,
-    .instance_size = sizeof(HDAAudioState),
     .class_init    = hda_audio_output_class_init,
 };
 
@@ -930,7 +930,6 @@ static void hda_audio_duplex_class_init(ObjectClass *klass, void *data)
 static const TypeInfo hda_audio_duplex_info = {
     .name          = "hda-duplex",
     .parent        = TYPE_HDA_AUDIO,
-    .instance_size = sizeof(HDAAudioState),
     .class_init    = hda_audio_duplex_class_init,
 };
 
@@ -946,7 +945,6 @@ static void hda_audio_micro_class_init(ObjectClass *klass, void *data)
 static const TypeInfo hda_audio_micro_info = {
     .name          = "hda-micro",
     .parent        = TYPE_HDA_AUDIO,
-    .instance_size = sizeof(HDAAudioState),
     .class_init    = hda_audio_micro_class_init,
 };
 
-- 
2.26.2


