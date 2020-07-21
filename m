Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B48C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9B52073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLG4sU7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9B52073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsQi-0007Yk-0D
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxsPp-0006ci-MO
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:34:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21751
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxsPo-0004Vv-3V
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595338479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=zuKvytfWXGiwndSHk/NMfe56Nu4ILWa74wDdEtF0UAw=;
 b=CLG4sU7uR2XqzKg8HzykdGQ0E/+xb0tR261xPjWr0hEZDKI7TwD1dAWgYzsph9BqI4pk1K
 F6YT2QWoR4jHNUibsSmplCqGZYdALvStmslhUqar2OyRL0bAJ7Ohxba/X7lW0/V1ZJBEJN
 jrqjwbet9TtUsUmwrzcSVq5Z5qHu88M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-S_TchI1rMCew8G1q8SfGsw-1; Tue, 21 Jul 2020 09:34:36 -0400
X-MC-Unique: S_TchI1rMCew8G1q8SfGsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B990D91273;
 Tue, 21 Jul 2020 13:34:35 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-193.pek2.redhat.com
 [10.72.12.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 153AC87B01;
 Tue, 21 Jul 2020 13:34:33 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 2/2] hw/net/xgmac: Fix buffer overflow in xgmac_enet_send()
Date: Tue, 21 Jul 2020 21:34:27 +0800
Message-Id: <1595338467-19556-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1595338467-19556-1-git-send-email-jasowang@redhat.com>
References: <1595338467-19556-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Mauro Matteo Cascella <mcascell@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mauro Matteo Cascella <mcascell@redhat.com>

A buffer overflow issue was reported by Mr. Ziming Zhang, CC'd here. It
occurs while sending an Ethernet frame due to missing break statements
and improper checking of the buffer size.

Reported-by: Ziming Zhang <ezrakiez@gmail.com>
Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/xgmac.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 574dd47..5bf1b61 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -220,21 +220,31 @@ static void xgmac_enet_send(XgmacState *s)
         }
         len = (bd.buffer1_size & 0xfff) + (bd.buffer2_size & 0xfff);
 
+        /*
+         * FIXME: these cases of malformed tx descriptors (bad sizes)
+         * should probably be reported back to the guest somehow
+         * rather than simply silently stopping processing, but we
+         * don't know what the hardware does in this situation.
+         * This will only happen for buggy guests anyway.
+         */
         if ((bd.buffer1_size & 0xfff) > 2048) {
             DEBUGF_BRK("qemu:%s:ERROR...ERROR...ERROR... -- "
                         "xgmac buffer 1 len on send > 2048 (0x%x)\n",
                          __func__, bd.buffer1_size & 0xfff);
+            break;
         }
         if ((bd.buffer2_size & 0xfff) != 0) {
             DEBUGF_BRK("qemu:%s:ERROR...ERROR...ERROR... -- "
                         "xgmac buffer 2 len on send != 0 (0x%x)\n",
                         __func__, bd.buffer2_size & 0xfff);
+            break;
         }
-        if (len >= sizeof(frame)) {
+        if (frame_size + len >= sizeof(frame)) {
             DEBUGF_BRK("qemu:%s: buffer overflow %d read into %zu "
-                        "buffer\n" , __func__, len, sizeof(frame));
+                        "buffer\n" , __func__, frame_size + len, sizeof(frame));
             DEBUGF_BRK("qemu:%s: buffer1.size=%d; buffer2.size=%d\n",
                         __func__, bd.buffer1_size, bd.buffer2_size);
+            break;
         }
 
         cpu_physical_memory_read(bd.buffer1_addr, ptr, len);
-- 
2.5.0


