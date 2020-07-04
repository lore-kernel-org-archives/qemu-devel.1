Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8015DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FEB20747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJtFnGqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FEB20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn0q-0004Ub-Vr
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvF-0002mB-Tr
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25722
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvD-0001Le-LF
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJ+ftu7sRo4+D1GoB2r1H/Xv24+UlICQh28kpGHM9w0=;
 b=VJtFnGqmm2IV3Ey1zh3sNKc4LWqsdEXyn2dcusm9zEdZaxvuCPYam60owRVCRTeeXaV98I
 ZpNV07++G73AhNUbAbC35ns5zT8EkuUfC1ReSnkIqf+JaMPVgltuv7sZGvjNU9W9xZuczv
 AKSNMIj0DU9xm+4eVzMlXP0US1Cdncw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-QhwGETBPMHqkzuRtaSVdDQ-1; Sat, 04 Jul 2020 14:29:53 -0400
X-MC-Unique: QhwGETBPMHqkzuRtaSVdDQ-1
Received: by mail-wm1-f72.google.com with SMTP id t18so40173223wmj.5
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rJ+ftu7sRo4+D1GoB2r1H/Xv24+UlICQh28kpGHM9w0=;
 b=jpHBLJMxPuo6RjUQtWa6U0eU+GLdwqCFSTfVqbEMlaPlsVeOXzLxexzCH110QBcLVT
 /6GP1d7IXfKuPfY4gb9cUXccqiz1iFkssT50xAFDBAbFlQHAFHElJ1hijfBNE37v03M2
 pzV7Q90/W9fr50+o3xXIlri9JrRuJuGjMA8gcpnVwzzhHcweFPp/tv+C2hW5R/+Q2lDG
 lyrvBHjE4UaUNYVWsWL42YlVJQHk74NJ4mqitdrP/TRsTHHwG2xhAcMaWLkKpuPu+mXz
 kRW6Jw8U0fMDLS9B0+mfdchOIkWIBnCvgeXmSKxdIhi0ohMNAa42gxlBzoZBcJ62AWqu
 3shA==
X-Gm-Message-State: AOAM531oTbJ5cF00b3tQ4P7M+Tvsp0qtAOQNbySj8pcr9kOyoNkk4f17
 D2JTmGaW7IVp1luxB8OubcEGluNgkGk4Xsq1ig8QXDGKIpk98wZeRz5QPeIzS7rjcYuKsKvWfkl
 s1I6ckm6px8QWAnw=
X-Received: by 2002:a7b:ce97:: with SMTP id q23mr42520261wmj.89.1593887392065; 
 Sat, 04 Jul 2020 11:29:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypgywOX2uW7oB0F+xcHYZ5odIW5/4MTbqD/5w4NaF9NjLbUW8fLrM47A0wWgS7hsnuWLFz/g==
X-Received: by 2002:a7b:ce97:: with SMTP id q23mr42520250wmj.89.1593887391917; 
 Sat, 04 Jul 2020 11:29:51 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 c11sm16765277wmb.45.2020.07.04.11.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:29:51 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:29:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/41] target/i386: sev: Use ram_block_discard_disable()
Message-ID: <20200704182750.1088103-11-mst@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
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
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

AMD SEV will pin all guest memory, mark discarding of RAM broken. At the
time this is called, we cannot have anyone active that relies on discards
to work properly - let's still implement error handling.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-8-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 target/i386/sev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index d273174ad3..f100a53231 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -680,6 +680,12 @@ sev_guest_init(const char *id)
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
 
+    ret = ram_block_discard_disable(true);
+    if (ret) {
+        error_report("%s: cannot disable RAM discard", __func__);
+        return NULL;
+    }
+
     sev = lookup_sev_guest_info(id);
     if (!sev) {
         error_report("%s: '%s' is not a valid '%s' object",
@@ -751,6 +757,7 @@ sev_guest_init(const char *id)
     return sev;
 err:
     sev_guest = NULL;
+    ram_block_discard_disable(false);
     return NULL;
 }
 
-- 
MST


