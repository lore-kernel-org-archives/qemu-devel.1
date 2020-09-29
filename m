Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A61C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB1C207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URoAfhEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB1C207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA17-0007Y9-Hc
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9wn-0002Jb-6d
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9wl-0001Xv-Ci
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hYvdz2qitSdqwuTuePQGMPUpQ1ZwS4Y5kaurOk3sFU=;
 b=URoAfhEUUBaJWMDXZ4G+b3cogb1ShTocxfJMbbou9hsK2G4rNgvfxWGERbL0Myg1WdahLY
 Mw4/4DkLRNbKIyydH3dJCUc6gns+keWOaO+lljlhUnDjQsgCTVvp5tyaUrUJ76JpJCd9t7
 WF8xE21jQpTpY+KgZvwfca3hvD13qHs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-XShBTN8UOuGp6WfF4OSzow-1; Tue, 29 Sep 2020 03:21:07 -0400
X-MC-Unique: XShBTN8UOuGp6WfF4OSzow-1
Received: by mail-wr1-f72.google.com with SMTP id a2so1359292wrp.8
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5hYvdz2qitSdqwuTuePQGMPUpQ1ZwS4Y5kaurOk3sFU=;
 b=dkQEJO4yvFKIVK4ejh3oDzyo1FNsn7GK3OxJowxLWHTfjNECeGxOzA0ORHt2xtMA0X
 0CcyhENh9H+7QxW60f12UavmO/pabshGg3ks/kNEx3loLk9CcKf0Lysf78+z/rxpQYRZ
 SR/oephUDt7d2A6myxwFmiayebV13RUi/tEMMkZdDkhyjzOiT4mHbzI6OZcNaYFqfJnI
 s2Hx8hSLO5U4UeMFuKGlmVsw2OgKo5mXaMIJhU3svgNJofGEgTA3MJ/vz/fnnRr+kf9E
 +t/mjz7JZ8d69Ls0/bEj3LDyQHaYcrjYJwSnZv+apigaQ0q5r7s33cexpEjoSL9uVPIl
 h8ig==
X-Gm-Message-State: AOAM530zzVdP4Nr21n8Srho4j53qbOCMtFpXyXIvAJKRoXcoP0PRXWYs
 pciSNeYVsLBTRYejfcEyCrz8jGSfceTttaUSQBXtIQurjD/L3SAJuY04wEX0SdRmy3EhVFe9fAC
 7gILScU+R+gwEZ0U=
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr2874662wmj.166.1601364066062; 
 Tue, 29 Sep 2020 00:21:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw038PMrUfQxrZwp6QqdMJLGtJUZqHHI00XqSVIWGDSl2KecsY0CfXYohRowwBaNwOwM4torg==
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr2874640wmj.166.1601364065867; 
 Tue, 29 Sep 2020 00:21:05 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id x16sm4634190wrq.62.2020.09.29.00.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:05 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 05/48] pc: fix
 auto_enable_numa_with_memhp/auto_enable_numa_with_memdev for the 5.0 machine
Message-ID: <20200929071948.281157-6-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Unfortunately, a typo sneeked in: we want to set
auto_enable_numa_with_memdev to false, not auto_enable_numa_with_memhp.

Cc: qemu-stable@nongnu.org # v5.1
Fixes: 195784a0cfad (numa: Auto-enable NUMA when any memory devices are possible)
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200820094828.30348-1-david@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 622d039717..e1c415f57d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -382,7 +382,7 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
     m->numa_mem_supported = true;
     compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
-    m->auto_enable_numa_with_memhp = false;
+    m->auto_enable_numa_with_memdev = false;
 }
 
 DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
-- 
MST


