Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38975C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5874212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Av7nTMRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5874212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSi92-0004Zj-LV
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrV-0001X6-UY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrU-00065s-7W
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602686079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWjQysrYOaHc0J+Ywk9vnzN0RJrHKyUS+u1YAOIyPAE=;
 b=Av7nTMRzirlGhTMo/pDGCio4erNM/YDHtFEoP3R8wBt32EBT4WTq5CNGFqTvO8unO/gKWh
 i54q2sdlengxJJDwftXoA+XJ2bsGpeo/WgbDg3xB1lefbyZtAKS//+wHceUIMoVV2vy1Z0
 rG2bfARkwVDn4wHM4mhGjtacqkeiFwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-FBA9x-GHNtq7MKoU3jDQBg-1; Wed, 14 Oct 2020 10:34:35 -0400
X-MC-Unique: FBA9x-GHNtq7MKoU3jDQBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC32B18765B7;
 Wed, 14 Oct 2020 14:34:33 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2915875131;
 Wed, 14 Oct 2020 14:34:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/10] can-host-socketcan: Fix crash when 'if' option is not set
Date: Wed, 14 Oct 2020 10:34:15 -0400
Message-Id: <20201014143415.240472-11-ehabkost@redhat.com>
In-Reply-To: <20201014143415.240472-1-ehabkost@redhat.com>
References: <20201014143415.240472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix the following crash:

  $ qemu-system-x86_64 -object can-host-socketcan,id=obj0
  Segmentation fault (core dumped)

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Message-Id: <20201008202713.1416823-3-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 net/can/can_socketcan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index 92b1f79385..4b68f60c6b 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -194,6 +194,11 @@ static void can_host_socketcan_connect(CanHostState *ch, Error **errp)
     struct sockaddr_can addr;
     struct ifreq ifr;
 
+    if (!c->ifname) {
+        error_setg(errp, "'if' property not set");
+        return;
+    }
+
     /* open socket */
     s = qemu_socket(PF_CAN, SOCK_RAW, CAN_RAW);
     if (s < 0) {
-- 
2.28.0


