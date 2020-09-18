Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB4CC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B881E2388B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQIiQBY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B881E2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJI4w-0005tl-Fn
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHxo-0006V4-US
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHxl-0000Xs-Ay
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600441568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XM7OAmXTOk6Dn4Gfks418JOy4EEvHfub5qqdEwcobzE=;
 b=UQIiQBY4LSGWsR3Sm8O6xKLWsweA+sKYwgK8K7Hdi7+JL2kDpagP/hoquxJs6bb/Y2PiUd
 QSrigaMukSus2CpieYkaC8gvW2YbPHhQAXYm6H6DMaZ7Q/ETSmJgnU6ikQUWJmSRQdmSIw
 72krfuboQ+uYjyFMA0+8Upo6Sh11vI8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-ysKByWEkM4GkSNGHuGr5Bg-1; Fri, 18 Sep 2020 11:06:06 -0400
X-MC-Unique: ysKByWEkM4GkSNGHuGr5Bg-1
Received: by mail-wr1-f70.google.com with SMTP id v12so2240930wrm.9
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XM7OAmXTOk6Dn4Gfks418JOy4EEvHfub5qqdEwcobzE=;
 b=LuGVXhhAX8fXXOk3PNsxF0Xrlhy/5DuUX/EBZlREIYL0tTj7bCfm2yDLxvvYKqS0M5
 1MvYnbVu64wXp8XYfLlntWo2tazKpj1AwFVzjzMpfUK+fJ3q6B0NR5j5YznfqjLE3uIl
 QXd+BkEd8W7wiVenrjc7h1ddxh4G+EiMpze/z+KoxqEwY/TQLhER9TLfNR33OM+5Ujyr
 gPqSLmP2PmqsZwIHZT7W4bA8g2c0AQ7LOgZrc8Y+m0NzpiwKWcRKf2tpxWFBbIoXljvP
 m7tRV/bboTVdrzZNAbVT+CKIB/GHdMzn3JXLhQ1t9PU6m3+/UA/wGNBdgEkSP4O8EDw3
 n+Bw==
X-Gm-Message-State: AOAM530xWPOVvA1PUnjBopZ7ifUUkl0T0DqGhiZxfHV5i4B0FGGYtmaC
 mqDTE2QE+3/0906HujsJQ+y2+RvwXzThwfIvW/m/lJvIvPSPb5cCGGtKFkvoW2RWU4jVd9BBUQ7
 jMKK/zFBB4KZfOCg=
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr15605302wma.43.1600441564895; 
 Fri, 18 Sep 2020 08:06:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzarNa7A1XKUaJ941x5tw5No7cgXMhPmdDp3XgFKqUe7eiisf9aKzOIc+0+Q8yPlGLmqEvlww==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr15605274wma.43.1600441564683; 
 Fri, 18 Sep 2020 08:06:04 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id d83sm5668107wmf.23.2020.09.18.08.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:06:04 -0700 (PDT)
Date: Fri, 18 Sep 2020 11:06:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/15] pc: fix
 auto_enable_numa_with_memhp/auto_enable_numa_with_memdev for the 5.0 machine
Message-ID: <20200918150506.286890-6-mst@redhat.com>
References: <20200918150506.286890-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918150506.286890-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
index 0cb9c18cd4..b95759df60 100644
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


