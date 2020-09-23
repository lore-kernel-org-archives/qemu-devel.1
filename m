Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EA2C4727D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D36F214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaIYY8Zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D36F214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0qV-0004Tx-Ca
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0n1-0007jm-9W
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0mz-00021M-Jy
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=miyIlc08Uqjo9uTYNRdj0lv8hh2b6A33x0o9HQh2RxI=;
 b=JaIYY8Zx+y4UtBajxRr3L5Mte9E9xjSuP8unYNRE4bjATM2OYr6/EX4EDcwWZIuv1b0WzY
 mJhDlBCRwKrUeFo8CMXo2feDeiULXKdYm3QlRKlE39bbIXeXwzfmL2oVQ0HqAC2FzgaWFd
 ExJk8pLFSG+t2+rN4pdQLBohufYklB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-TYPRBHd2OdCY94kqUdJZZw-1; Wed, 23 Sep 2020 05:10:09 -0400
X-MC-Unique: TYPRBHd2OdCY94kqUdJZZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0B4F800475;
 Wed, 23 Sep 2020 09:10:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D2D05C5B0;
 Wed, 23 Sep 2020 09:10:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DC2B8204A1; Wed, 23 Sep 2020 11:10:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] audio: align audio_generic_read with audio_pcm_hw_run_in
Date: Wed, 23 Sep 2020 11:09:56 +0200
Message-Id: <20200923091001.20814-5-kraxel@redhat.com>
In-Reply-To: <20200923091001.20814-1-kraxel@redhat.com>
References: <20200923091001.20814-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
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

The function audio_generic_read should work exactly like
audio_pcm_hw_run_in. It's a very similar function working
on a different buffer.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200920171729.15861-4-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index d5891e1928bc..5c47a036028c 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1495,12 +1495,23 @@ size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
 
 size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
 {
-    void *src = hw->pcm_ops->get_buffer_in(hw, &size);
+    size_t total = 0;
 
-    memcpy(buf, src, size);
-    hw->pcm_ops->put_buffer_in(hw, src, size);
+    while (total < size) {
+        size_t src_size = size - total;
+        void *src = hw->pcm_ops->get_buffer_in(hw, &src_size);
 
-    return size;
+        if (src_size == 0) {
+            hw->pcm_ops->put_buffer_in(hw, src, src_size);
+            break;
+        }
+
+        memcpy((char *)buf + total, src, src_size);
+        hw->pcm_ops->put_buffer_in(hw, src, src_size);
+        total += src_size;
+    }
+
+    return total;
 }
 
 static int audio_driver_init(AudioState *s, struct audio_driver *drv,
-- 
2.27.0


