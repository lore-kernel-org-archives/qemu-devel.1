Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596DFC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 10:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEB420729
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 10:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjJnLokI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEB420729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kacxQ-0005k4-G3
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 05:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1kacws-0005JP-Eu
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 05:56:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1kacwq-0005g1-BT
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 05:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604573814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZqIH+9Hw3cw0MS/CqZluoRm1gWD3ILVjGDMEQqYVTjI=;
 b=WjJnLokIsjwx75SwZNG+4syjg8+h05aR4k1vZFMPQIG6u/zWtssQwiskXrqxO1q+2pXn4g
 OEa9vlu9s/w91AcoD3otsyuasVG9u11IwxpChTsXzK0CyTg6tAqB7xdv3DAgJy+IAUPoOg
 uhzckTin0trnIdlAGRW4PCAQl+oW5N0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-8I531HTAPymnAZ5s7G0kBw-1; Thu, 05 Nov 2020 05:56:39 -0500
X-MC-Unique: 8I531HTAPymnAZ5s7G0kBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A53D81006C92;
 Thu,  5 Nov 2020 10:56:37 +0000 (UTC)
Received: from f32-work.redhat.com (unknown [10.40.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4A326CE54;
 Thu,  5 Nov 2020 10:56:35 +0000 (UTC)
From: Mauro Matteo Cascella <mcascell@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] net/e1000e_core: make sure RDH never exceeds RDT in
 e1000e_ring_advance()
Date: Thu,  5 Nov 2020 11:56:16 +0100
Message-Id: <20201105105616.327593-1-mcascell@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mcascell@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: mcascell@redhat.com, dmitry.fleytman@gmail.com, gaoning.pgn@antgroup.com,
 jasowang@redhat.com, lersek@redhat.com, 330cjfdn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The e1000e_write_packet_to_guest() function iterates over a set of
receive descriptors by advancing rx descriptor head register (RDH) from
its initial value to rx descriptor tail register (RDT). The check in
e1000e_ring_empty() is responsible for detecting whether RDH has reached
RDT, terminating the loop if that's the case. Additional checks have
been added in the past to deal with bogus values submitted by the guest
to prevent possible infinite loop. This is done by "wrapping around" RDH
at some point and detecting whether it assumes the original value during
the loop.

However, when e1000e is configured to use the packet split feature, RDH is
incremented by two instead of one, as the packet split descriptors are
32 bytes while regular descriptors are 16 bytes. A malicious or buggy
guest may set RDT to an odd value and transmit only null RX descriptors.
This corner case would prevent RDH from ever matching RDT, leading to an
infinite loop. This patch adds a check in e1000e_ring_advance() to make
sure RDH does never exceed RDT.

This issue was independently reported by Gaoning Pan (Zhejiang University)
and Cheolwoo Myung.

Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Reported-by: Gaoning Pan <gaoning.pgn@antgroup.com>
Reported-by: Cheolwoo Myung <330cjfdn@gmail.com>
---
References:
https://git.qemu.org/?p=qemu.git;a=commit;h=dd793a74882477ca38d49e191110c17dfe
https://git.qemu.org/?p=qemu.git;a=commit;h=4154c7e03fa55b4cf52509a83d50d6c09d743b7
http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf

 hw/net/e1000e_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index bcd186cac5..4c4d14b6ed 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -831,6 +831,10 @@ e1000e_ring_advance(E1000ECore *core, const E1000E_RingInfo *r, uint32_t count)
 {
     core->mac[r->dh] += count;
 
+    if (core->mac[r->dh] > core->mac[r->dt]) {
+        core->mac[r->dh] = core->mac[r->dt];
+    }
+
     if (core->mac[r->dh] * E1000_RING_DESC_LEN >= core->mac[r->dlen]) {
         core->mac[r->dh] = 0;
     }
-- 
2.26.2


