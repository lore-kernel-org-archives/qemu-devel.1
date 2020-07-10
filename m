Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A4CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD1E20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YROEE9A8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD1E20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpEH-0001yi-KI
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1jtpDE-0000xU-3v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:20:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60221
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1jtpDB-0003b2-MO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594372852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bRh1CyXwAmDj04p/JeBnKfYqsXVQ4dytq9QvwnTG3/g=;
 b=YROEE9A8KxdINa1aMrUavN2wvRNLnQYqvqyBLRJmmuMI866tUwwwXmHEcgABjG5HQeLp3y
 kJeuSBU/1f8MWAQjCN4IuMWL9NbBxJuaLfvgJEShy7NlDI37qIQj6e7kc2/9wD1Vs5Ljw8
 NqQJFDj6mpAKogfslXYrM7MiUUmHBh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-JVDeHd0wOMWe_4ylTSyYCQ-1; Fri, 10 Jul 2020 05:20:50 -0400
X-MC-Unique: JVDeHd0wOMWe_4ylTSyYCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADDD61B2C981;
 Fri, 10 Jul 2020 09:20:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03B3B7EF93;
 Fri, 10 Jul 2020 09:20:47 +0000 (UTC)
From: Mauro Matteo Cascella <mcascell@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/net/xgmac: Fix buffer overflow in xgmac_enet_send()
Date: Fri, 10 Jul 2020 11:19:41 +0200
Message-Id: <20200710091940.641296-1-mcascell@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mcascell@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: robh@kernel.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 peter.maydell@linaro.org, jasowang@redhat.com, qemu-arm@nongnu.org,
 ezrakiez@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A buffer overflow issue was reported by Mr. Ziming Zhang, CC'd here. It
occurs while sending an Ethernet frame due to missing break statements
and improper checking of the buffer size.

Reported-by: Ziming Zhang <ezrakiez@gmail.com>
Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
---
 hw/net/xgmac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 574dd47b41..b872afbb1a 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -224,17 +224,20 @@ static void xgmac_enet_send(XgmacState *s)
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
2.26.2


