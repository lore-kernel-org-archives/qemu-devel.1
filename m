Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A20C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321EF2137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dm9mPrDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321EF2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0qV-0004Vh-5O
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0n0-0007jg-VV
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0my-00021I-T7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnSTnTrhv6Es+jAHFfSChZVlDhkfCwsAKM+1T7vyOHY=;
 b=dm9mPrDJ1+U3gsybeWO2y7BUn6aQHhc0DpiYjDcexoaEK5sVbYn93MNFqMx1ZDXm7Rr8Hh
 /zaYO0ICC8+ctCDOkPqdLWhKeWNYZB0EhHyVHgSQ4dNGuqYZ3vda2Z3NDoRQQSrysinmvW
 7g8+SN8uumVzs6TZFg6YQ95nISdRPic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-H6vZys00Nkuuf8Iqdwaajg-1; Wed, 23 Sep 2020 05:10:10 -0400
X-MC-Unique: H6vZys00Nkuuf8Iqdwaajg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 237CAAD687;
 Wed, 23 Sep 2020 09:10:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F99273692;
 Wed, 23 Sep 2020 09:10:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 01F0231E63; Wed, 23 Sep 2020 11:10:02 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] audio: align audio_generic_write with audio_pcm_hw_run_out
Date: Wed, 23 Sep 2020 11:09:58 +0200
Message-Id: <20200923091001.20814-7-kraxel@redhat.com>
In-Reply-To: <20200923091001.20814-1-kraxel@redhat.com>
References: <20200923091001.20814-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

The function audio_generic_write should work exactly like
audio_pcm_hw_run_out. It's a very similar function working on a
different buffer.

This patch significantly reduces the number of drop-outs with
the DirectSound backend. To hear the difference start qemu with
-audiodev dsound,id=audio0,out.mixing-engine=off and play a
song in the guest with and without this patch.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200920171729.15861-6-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 341edc4d0012..8587e3d15225 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1484,12 +1484,34 @@ size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
 
 size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
 {
-    size_t dst_size, copy_size;
-    void *dst = hw->pcm_ops->get_buffer_out(hw, &dst_size);
-    copy_size = MIN(size, dst_size);
+    size_t total = 0;
 
-    memcpy(dst, buf, copy_size);
-    return hw->pcm_ops->put_buffer_out(hw, dst, copy_size);
+    while (total < size) {
+        size_t dst_size = size - total;
+        size_t copy_size, proc;
+        void *dst = hw->pcm_ops->get_buffer_out(hw, &dst_size);
+
+        if (dst_size == 0) {
+            break;
+        }
+
+        copy_size = MIN(size - total, dst_size);
+        if (dst) {
+            memcpy(dst, (char *)buf + total, copy_size);
+        }
+        proc = hw->pcm_ops->put_buffer_out(hw, dst, copy_size);
+        total += proc;
+
+        if (proc == 0 || proc < copy_size) {
+            break;
+        }
+    }
+
+    if (hw->pcm_ops->run_buffer_out) {
+        hw->pcm_ops->run_buffer_out(hw);
+    }
+
+    return total;
 }
 
 size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
-- 
2.27.0


