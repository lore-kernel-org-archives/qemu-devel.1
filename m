Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C23C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C220A20747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZR6PEBea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C220A20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn4E-0002po-2h
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvB-0002jz-J8
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27351
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmv9-0001Kq-3g
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+xCzX5pjcy148tNCg3zvK7ruz7b/+qmBTdtfJlorfws=;
 b=ZR6PEBeaX3eYlW2P3pB2PvvNykjbilmMPabM/8whGM6hNKAfvmxI1POGPB1+fiueLWm/4+
 M9ASU2qiDKV8UApAWhC2TBp6T7IwNth0l41rP5+1BR/lKp46zp6diWhNCiq0LZN9lZTgCx
 uDcUwecOfqS60af44GA+YcLWB+V+cVw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-3bPySYUwMKaRmG9kgSfoKw-1; Sat, 04 Jul 2020 14:29:45 -0400
X-MC-Unique: 3bPySYUwMKaRmG9kgSfoKw-1
Received: by mail-wm1-f69.google.com with SMTP id t18so40173030wmj.5
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+xCzX5pjcy148tNCg3zvK7ruz7b/+qmBTdtfJlorfws=;
 b=Iy4F+tnw8oCFvaEJm41CFMnpuC8dQdj4Jh5BcFxpCvVWEmcqbwp73qFwr2VBfKZ5S2
 BDP6Cr4EGeTUw6YVphRmvUdvT9h6B7hPhKEtG/K1msxpb9jwxG5uUDY2eq9fY/M0gSC5
 shHV+D3PK4XUsMSm2bm+q4GXcBh/7nwLIZPuxFP+Qvx3YJm1RPEDi7Z2rwyDeD+WUdUq
 pRvFT521vgWNlOSlMrZojfBuZPLKGNbwj37vfObMQC7I+S65Hi7wD9PPMoX0h/QY9okY
 AFPorbnqUjF6vuJw/4l/PuV0qy4c/qjGTUmMUVYieo1SDoBlin44NZXEPSU5T8HdWQyJ
 NOuw==
X-Gm-Message-State: AOAM530462Jvp/ypJho0g/+FqjzAD9FlgFWvxJnCGl2aNUDlVAh8oxGN
 UG56eBgWZK9GhJlH6o5+c37owHrY0twjDcKyQ3ZHZBY5P8wfmtrgMov+pdbJDPknmJyCmwkXIRM
 Yq3uLEWQ0xPwSI7A=
X-Received: by 2002:a7b:c5c4:: with SMTP id n4mr41024451wmk.67.1593887383900; 
 Sat, 04 Jul 2020 11:29:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyZyhovHtwPT8kE0hmJqiRfbF25fSUFZBtXZC1AiAdPjMmXjWkRVXCdBx0KDBob2c9vz1Gng==
X-Received: by 2002:a7b:c5c4:: with SMTP id n4mr41024439wmk.67.1593887383699; 
 Sat, 04 Jul 2020 11:29:43 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 s203sm8617891wms.32.2020.07.04.11.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:29:43 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:29:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/41] accel/kvm: Convert to ram_block_discard_disable()
Message-ID: <20200704182750.1088103-8-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Discarding memory does not work as expected. At the time this is called,
we cannot have anyone active that relies on discards to work properly.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-5-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d54a8701d8..ab36fbfa0c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -40,7 +40,6 @@
 #include "trace.h"
 #include "hw/irq.h"
 #include "sysemu/sev.h"
-#include "sysemu/balloon.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
@@ -2229,7 +2228,8 @@ static int kvm_init(MachineState *ms)
 
     s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
     if (!s->sync_mmu) {
-        qemu_balloon_inhibit(true);
+        ret = ram_block_discard_disable(true);
+        assert(!ret);
     }
 
     return 0;
-- 
MST


