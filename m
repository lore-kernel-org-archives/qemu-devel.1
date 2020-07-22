Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F889C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041652077D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dereferenced.org header.i=@dereferenced.org header.b="oRZyHuZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041652077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dereferenced.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAVU-00048K-A1
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ariadne@dereferenced.org>)
 id 1jyAUf-0003Kn-S4
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:52:53 -0400
Received: from out1.migadu.com ([91.121.223.63]:25504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ariadne@dereferenced.org>)
 id 1jyAUc-0001lT-C6
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:52:53 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dereferenced.org;
 s=default; t=1595407966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kLA1D6x0UDRsT4mClI4adYPErZ84V5KksCRyuZba0W4=;
 b=oRZyHuZGPNn7PVbX4BC8Jw6Qozpv2RoudiG6UxI5lHNvl7V5fq2ac8gigUy0qkUyfYfRm/
 mH2ssfvZxtEHW5iPErCyJ/KvoU5GeMiv2l6+u56Qeg9Px1HGKr/R6PbM64o7AKazaXPisJ
 6Lpu5Vy+fcxOmaAwQW3CdOIKbLPXJ98=
From: Ariadne Conill <ariadne@dereferenced.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/2] virtio host input: use safe 64-bit time accessors
 for input_event
Date: Wed, 22 Jul 2020 02:52:25 -0600
Message-Id: <20200722085226.11984-1-ariadne@dereferenced.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=91.121.223.63;
 envelope-from=ariadne@dereferenced.org; helo=out1.migadu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 04:52:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Ariadne Conill <ariadne@dereferenced.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 32-bit systems with 64-bit time_t, input_event.time is not
directly accessible.  Instead, we must use input_event_sec and
input_event_usec accessors to set the time values.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 hw/input/virtio-input-host.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index 85daf73f1a..7b81bf09f5 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -193,13 +193,16 @@ static void virtio_input_host_handle_status(VirtIOInput *vinput,
 {
     VirtIOInputHost *vih = VIRTIO_INPUT_HOST(vinput);
     struct input_event evdev;
+    struct timeval tv;
     int rc;
 
-    if (gettimeofday(&evdev.time, NULL)) {
+    if (gettimeofday(&tv, NULL)) {
         perror("virtio_input_host_handle_status: gettimeofday");
         return;
     }
 
+    evdev.input_event_sec = tv.tv_sec;
+    evdev.input_event_usec = tv.tv_usec;
     evdev.type = le16_to_cpu(event->type);
     evdev.code = le16_to_cpu(event->code);
     evdev.value = le32_to_cpu(event->value);
-- 
2.27.0


