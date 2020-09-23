Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEFEC4727D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA6D2137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4xe1nsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA6D2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0ok-0000zy-Hv
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0mz-0007j8-M5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0my-000218-2t
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPmHNn4vW8iu/khSTnDPXOa3pRSorw5LCCVbF7XMAIc=;
 b=U4xe1nsQztS1+biIPdWAa+EeAlBe4gMxFFa1S8CwtSH/S1ooDCwRTas8e6BNIXkUF6bNR2
 u5vsj2wpTpPMRy47t9YDR3mq9VFFngwpmValg4UA/R3riVMruS9F4SJ8qHOHUcSmdetSEg
 9RVq5xcHNAcS9so7Wo4OjCX1T+reQjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-FWvEMWfjMuSTsYO557vC4Q-1; Wed, 23 Sep 2020 05:10:08 -0400
X-MC-Unique: FWvEMWfjMuSTsYO557vC4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56F2081CBE7;
 Wed, 23 Sep 2020 09:10:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 803F0702E7;
 Wed, 23 Sep 2020 09:10:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BF1101FCEE; Wed, 23 Sep 2020 11:10:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] audio: handle buf == NULL in put_buffer_out()
Date: Wed, 23 Sep 2020 11:09:53 +0200
Message-Id: <20200923091001.20814-2-kraxel@redhat.com>
In-Reply-To: <20200923091001.20814-1-kraxel@redhat.com>
References: <20200923091001.20814-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker Rümelin <vr_qemu@t-online.de>

With the next patch all audio backends put_buffer_out() functions
have to handle the buf == NULL case, provided the get_buffer_out()
function may return buf = NULL and size > 0.

It turns out that all audio backends get_buffer_out() functions
either can't return buf = NULL or return buf = NULL and size = 0
at the same time. The only exception is the spiceaudio backend
where size may be uninitialized.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200920171729.15861-1-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/spiceaudio.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index b6b5da4812f2..c8d81ba44290 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -135,6 +135,7 @@ static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
             (out->fsize - out->fpos) * hw->info.bytes_per_frame);
     } else {
         audio_rate_start(&out->rate);
+        *size = LINE_OUT_SAMPLES << 2;
     }
     return out->frame + out->fpos;
 }
@@ -143,12 +144,14 @@ static size_t line_out_put_buffer(HWVoiceOut *hw, void *buf, size_t size)
 {
     SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
 
-    assert(buf == out->frame + out->fpos && out->fpos <= out->fsize);
-    out->fpos += size >> 2;
+    if (buf) {
+        assert(buf == out->frame + out->fpos && out->fpos <= out->fsize);
+        out->fpos += size >> 2;
 
-    if (out->fpos == out->fsize) { /* buffer full */
-        spice_server_playback_put_samples(&out->sin, out->frame);
-        out->frame = NULL;
+        if (out->fpos == out->fsize) { /* buffer full */
+            spice_server_playback_put_samples(&out->sin, out->frame);
+            out->frame = NULL;
+        }
     }
 
     return size;
-- 
2.27.0


