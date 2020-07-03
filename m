Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349ADC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0301E2084C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FP0EXywQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0301E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHeI-0003NR-6m
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbx-0006ms-Gi
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44760
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbu-0004OA-V1
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+xCzX5pjcy148tNCg3zvK7ruz7b/+qmBTdtfJlorfws=;
 b=FP0EXywQPYve3andIja13grksnTH+92dSXSij0ZnnrdYOFyB54YLam3HMwCQXQpem1nT1L
 pmhmC0d07mHcUy7P2TLXAtJkkdmPxjCXmjz7oCHWGCKBnQ/jM4put3iV7cvVsKXfOP8IdU
 g5r0bq4rcUYPhA6f+JHRwy12VfCH18U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-vmMN7A47MDmRCQJFHrgEbg-1; Fri, 03 Jul 2020 05:03:52 -0400
X-MC-Unique: vmMN7A47MDmRCQJFHrgEbg-1
Received: by mail-wm1-f71.google.com with SMTP id f68so16189767wmf.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+xCzX5pjcy148tNCg3zvK7ruz7b/+qmBTdtfJlorfws=;
 b=WQyAF8ZUGyUX/lK8aDcgcDz+NDsyxlTrn1BJ6KmNGRt4Lt9U9L2EkxVGlCzi1Hl9Qt
 HrqZeB6lrTwWSzsPgwNFk8dS3UPNgMh6BlAdreCjQW/IlMt75ZEDKueMiDZ600j3UXCr
 /w6E6lQay3KWsTYgp5gKdbNDTUc8DsvdP0mJiGekjt4Ab8tlxZ3K2S6edmYsEzrqLDZt
 +gs7c/8NnfktnwXrQ/LGk/W5vne7AnGfKyB8MypDOFmg0kqNJPdXXeUEMEjA8TOZNYcN
 IekeN/rVKpBVteHQY8haEnV4BtqacD6rhvrk2AgIl1GI2EyosOeSFbmNvoXjc47tjRZa
 LnBw==
X-Gm-Message-State: AOAM532A5NRCSsv8eB8NCgcxGi0QEzqPIJos4BsB95FiU7OWlSbR1ocy
 wYgWovmDvHry1G4BgDdJrU7Mkz4KAfGUVgK/sEUUJcOZq2qnN6+b8E/U4GyuIfqi0iL7kwrox+T
 9caRStRrP1HMw2PI=
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr34465110wmi.19.1593767030947; 
 Fri, 03 Jul 2020 02:03:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH6CgeufSo9JwIW+9iWhgBDRu9Y5rZ/6J6Jir103NVXBTOiQlnZIXgjcjYMvIQK8/q4Sijiw==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr34465084wmi.19.1593767030736; 
 Fri, 03 Jul 2020 02:03:50 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 r1sm13030791wrt.73.2020.07.03.02.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:03:50 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:03:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/41] accel/kvm: Convert to ram_block_discard_disable()
Message-ID: <20200703090252.368694-8-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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


