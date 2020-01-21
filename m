Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BC9C33CAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582E122522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="Ql5g2rIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582E122522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itlgY-0006qR-32
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 00:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1itleu-0005Wk-Qb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1itleq-0002Q0-MI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:01:00 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:46700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1itlep-0002OI-Of
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:00:56 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
 by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 00L4uUtq048852; Mon, 20 Jan 2020 21:00:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding; s=20180706;
 bh=hEWTjc6JDqms3K/wqphEWcg9jPoxwXVxuA5KFJNu6Gw=;
 b=Ql5g2rIMdyVzeuRnGqPzfGzWLZvyhoFmlRLZTIqIHk9reItb9mDvbOTO7ScYCkob6qd6
 PpuC7xtDUm1ke4RoUbG5OAsa0NeawxpNf1/auzhRaJPtHyhnUL7X0D/Cbdu2bq1E5Gro
 c3JKM0XYlaXZ7Ru4rzNAXusTMSNLGDQkV/YFR8bOIVrvAcZb3UK8IRPRDm0h6wcWexCl
 Oc8/eufH5H+/06Z/0ktQp7oyOKrHJehMthQdGRY+mlRO20AwrP2/nGbrjom9AU0tI8Q7
 J77/BVTvH0J7vZnQuftvmtvcxlN+pAIX1j6d49N1wBrGu8iF4/YI4l+qmwxOs0o0HzC3 Bw== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com
 [17.40.76.7])
 by nwk-aaemail-lapp03.apple.com with ESMTP id 2xmk4ngc8w-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 20 Jan 2020 21:00:54 -0800
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q4F00CTRXXGNA00@ma1-mtap-s03.corp.apple.com>; Mon,
 20 Jan 2020 21:00:53 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q4F00C00XDY2N00@nwk-mmpp-sz11.apple.com>; Mon,
 20 Jan 2020 21:00:53 -0800 (PST)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: 6bafeb6ba5f729e40cc01f5a119f334f
X-Va-R-CD: cac07a16fc6dc0c9fc1da97720dc20a9
X-Va-CD: 0
X-Va-ID: 637f91f8-9ecf-4337-bb19-504789c3f07e
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 6bafeb6ba5f729e40cc01f5a119f334f
X-V-R-CD: cac07a16fc6dc0c9fc1da97720dc20a9
X-V-CD: 0
X-V-ID: 5b8f5845-4146-485b-896f-b0eeddda09d1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2020-01-20_10:,, signatures=0
Received: from pontoon.com (unknown [17.234.97.123]) by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q4F005Q7XXG3520@nwk-mmpp-sz11.apple.com>; Mon,
 20 Jan 2020 21:00:52 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH v2 1/2] vnc: fix VNC artifacts
Date: Mon, 20 Jan 2020 21:00:51 -0800
Message-id: <c28241e087b10b4561468b7dae47fe63381df259.1579582674.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
In-reply-to: <cover.1579582674.git.dirty@apple.com>
References: <cover.1579582674.git.dirty@apple.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2020-01-20_10:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.68
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

Patch de3f7de7f4e257ce44cdabb90f5f17ee99624557 was too simplistic in its
implementation: it didn't account for the ZLIB z_stream mutating with
each compression.  Because of the mutation, simply resetting the output
buffer's offset wasn't sufficient to "rewind" the operation.  The mutated
z_stream would generate future zlib blocks which referred to symbols in
past blocks which weren't sent.  This would lead to artifacting.

This reverts commit de3f7de7f4e257ce44cdabb90f5f17ee99624557.

Fixes: <de3f7de7f4e257> ("vnc: allow fall back to RAW encoding")
Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 ui/vnc.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 4100d6e404..3e8d1f1207 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -898,8 +898,6 @@ int vnc_raw_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
 int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
 {
     int n = 0;
-    bool encode_raw = false;
-    size_t saved_offs = vs->output.offset;
 
     switch(vs->vnc_encoding) {
         case VNC_ENCODING_ZLIB:
@@ -922,24 +920,10 @@ int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
             n = vnc_zywrle_send_framebuffer_update(vs, x, y, w, h);
             break;
         default:
-            encode_raw = true;
+            vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_RAW);
+            n = vnc_raw_send_framebuffer_update(vs, x, y, w, h);
             break;
     }
-
-    /* If the client has the same pixel format as our internal buffer and
-     * a RAW encoding would need less space fall back to RAW encoding to
-     * save bandwidth and processing power in the client. */
-    if (!encode_raw && vs->write_pixels == vnc_write_pixels_copy &&
-        12 + h * w * VNC_SERVER_FB_BYTES <= (vs->output.offset - saved_offs)) {
-        vs->output.offset = saved_offs;
-        encode_raw = true;
-    }
-
-    if (encode_raw) {
-        vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_RAW);
-        n = vnc_raw_send_framebuffer_update(vs, x, y, w, h);
-    }
-
     return n;
 }
 
-- 
2.24.0


