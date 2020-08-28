Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F2C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5059520665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSb0CICb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5059520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBZVC-0000BV-IQ
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 04:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRV-0000aA-Sx
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:09:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20428
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRS-0003RR-1q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598602136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5y2VjtPVE1Av1o0uG6hgmniru7Si3R0syXMBys/8m9U=;
 b=dSb0CICbFgkuetis6mSqmXamLYywnis9wVd/bZd3UEy/djFhflEJeRvGqgWOwToCRhSgbr
 xXm9PC71wILTv4NUrQRGILMMfcXChmHIIsCMMjshHrABr6IuvlnTuwrxiPOy5F3Xf7++jY
 xq2tWArhEkuHylJ3zUQE+EEIKr/gLhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-yoDTmO7gMtmGiccsiUe0hg-1; Fri, 28 Aug 2020 04:08:53 -0400
X-MC-Unique: yoDTmO7gMtmGiccsiUe0hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D518F10082E5;
 Fri, 28 Aug 2020 08:08:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 711B17A21E;
 Fri, 28 Aug 2020 08:08:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 95C5F31FC5; Fri, 28 Aug 2020 10:08:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] usb: fix setup_len init (CVE-2020-14364)
Date: Fri, 28 Aug 2020 10:08:45 +0200
Message-Id: <20200828080845.28287-19-kraxel@redhat.com>
In-Reply-To: <20200828080845.28287-1-kraxel@redhat.com>
References: <20200828080845.28287-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 01:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Store calculated setup_len in a local variable, verify it, and only
write it to the struct (USBDevice->setup_len) in case it passed the
sanity checks.

This prevents other code (do_token_{in,out} functions specifically)
from working with invalid USBDevice->setup_len values and overrunning
the USBDevice->setup_buf[] buffer.

Fixes: CVE-2020-14364
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-id: 20200825053636.29648-1-kraxel@redhat.com
---
 hw/usb/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 5abd128b6bc5..5234dcc73fea 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -129,6 +129,7 @@ void usb_wakeup(USBEndpoint *ep, unsigned int stream)
 static void do_token_setup(USBDevice *s, USBPacket *p)
 {
     int request, value, index;
+    unsigned int setup_len;
 
     if (p->iov.size != 8) {
         p->status = USB_RET_STALL;
@@ -138,14 +139,15 @@ static void do_token_setup(USBDevice *s, USBPacket *p)
     usb_packet_copy(p, s->setup_buf, p->iov.size);
     s->setup_index = 0;
     p->actual_length = 0;
-    s->setup_len   = (s->setup_buf[7] << 8) | s->setup_buf[6];
-    if (s->setup_len > sizeof(s->data_buf)) {
+    setup_len = (s->setup_buf[7] << 8) | s->setup_buf[6];
+    if (setup_len > sizeof(s->data_buf)) {
         fprintf(stderr,
                 "usb_generic_handle_packet: ctrl buffer too small (%d > %zu)\n",
-                s->setup_len, sizeof(s->data_buf));
+                setup_len, sizeof(s->data_buf));
         p->status = USB_RET_STALL;
         return;
     }
+    s->setup_len = setup_len;
 
     request = (s->setup_buf[0] << 8) | s->setup_buf[1];
     value   = (s->setup_buf[3] << 8) | s->setup_buf[2];
@@ -259,26 +261,28 @@ static void do_token_out(USBDevice *s, USBPacket *p)
 static void do_parameter(USBDevice *s, USBPacket *p)
 {
     int i, request, value, index;
+    unsigned int setup_len;
 
     for (i = 0; i < 8; i++) {
         s->setup_buf[i] = p->parameter >> (i*8);
     }
 
     s->setup_state = SETUP_STATE_PARAM;
-    s->setup_len   = (s->setup_buf[7] << 8) | s->setup_buf[6];
     s->setup_index = 0;
 
     request = (s->setup_buf[0] << 8) | s->setup_buf[1];
     value   = (s->setup_buf[3] << 8) | s->setup_buf[2];
     index   = (s->setup_buf[5] << 8) | s->setup_buf[4];
 
-    if (s->setup_len > sizeof(s->data_buf)) {
+    setup_len = (s->setup_buf[7] << 8) | s->setup_buf[6];
+    if (setup_len > sizeof(s->data_buf)) {
         fprintf(stderr,
                 "usb_generic_handle_packet: ctrl buffer too small (%d > %zu)\n",
-                s->setup_len, sizeof(s->data_buf));
+                setup_len, sizeof(s->data_buf));
         p->status = USB_RET_STALL;
         return;
     }
+    s->setup_len = setup_len;
 
     if (p->pid == USB_TOKEN_OUT) {
         usb_packet_copy(p, s->data_buf, s->setup_len);
-- 
2.27.0


