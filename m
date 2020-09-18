Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFB3C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC88207D3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aChkVy1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC88207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJXF-00043f-G5
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ7a-00053d-ER
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ7U-0005bN-UZ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600446016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hYvdz2qitSdqwuTuePQGMPUpQ1ZwS4Y5kaurOk3sFU=;
 b=aChkVy1GmrpxXFERygWpE8Ys6loRmVFCYvvgpHWS4jRMX2hXcBMQd4IWdsJ0KcvoqO4LhY
 sJLDeU3WtW1cAEynVXocXrpLq2XjXABAs85+9+rRKjIEsFdNW/88rpTWhqFeKTY2zuRQPf
 1q03jo9toEh7ymyLL5rKiC3diFtXMdg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-3_sXm3E5Oz-G1hqbbmqgww-1; Fri, 18 Sep 2020 12:20:14 -0400
X-MC-Unique: 3_sXm3E5Oz-G1hqbbmqgww-1
Received: by mail-wr1-f72.google.com with SMTP id a10so2293602wrw.22
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5hYvdz2qitSdqwuTuePQGMPUpQ1ZwS4Y5kaurOk3sFU=;
 b=eRvq3CUGBokn8GlJgAFgKAf3Groq2r2FLEnpamtrSeTNG6DdQvbvh0TiRomMrsAdES
 Ie+CjHCwJNZtSV/i1zyko3o1jSJTdtU8VLMkEt+ro5eTwhTWxz3q2sxG+aXei6MDR3hx
 5KBajVTqhgPKIVEyoI/PYimTfWf4Ug9aVGPtd3Izrw3akxKRCRPT+ExEqrM2hGAen9eN
 C1SL5+5swiuHzDZJ9joPgH1bNnjTsIRbsB/+TfaX5rhVV4WWzRpfm+YoiIDIWuM4XtLg
 JTJ1bRUKMqZ0gE28Is7NIpJJSihVN5fKCMxS6xg+HcZrXNXA4sfa/33i2TBeD1I+hgEA
 DnKg==
X-Gm-Message-State: AOAM533s6kwom2lRGxyQsHxQkCBIw5wHtqFCJvQEN7ks0jykqpOXlu+s
 2awOywN18L2fTip01YPM3brj/DRP2nZSk9w6rHtZdIgI1s0cBYRhPDwp8u+COJ44LwT/dGuCt1S
 5rMaLXsXJa9e+Sbw=
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr16644737wmd.95.1600446012936; 
 Fri, 18 Sep 2020 09:20:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1ApR7ml4x6BT92Um9hjUsj5pB0B2DKOU7ujzlT8t9p8HNEdkjq7AQtqKVM+LzMsz4LW7kOw==
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr16644719wmd.95.1600446012767; 
 Fri, 18 Sep 2020 09:20:12 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id a5sm5930224wrp.37.2020.09.18.09.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:20:11 -0700 (PDT)
Date: Fri, 18 Sep 2020 12:20:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/15] pc: fix
 auto_enable_numa_with_memhp/auto_enable_numa_with_memdev for the 5.0 machine
Message-ID: <20200918161836.318893-6-mst@redhat.com>
References: <20200918161836.318893-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918161836.318893-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


