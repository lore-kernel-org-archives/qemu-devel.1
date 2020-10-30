Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8E6C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776892076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFGmXGmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776892076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVAa-0005QT-Ax
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8N-0003fl-UW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8L-0007F6-F0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=smveN6Rzbijww7fMqUTE3pDIKVjvYutAyE50uFiM4wM=;
 b=QFGmXGmRFpNJXJc5yRhbqwoWjECm69KYbYdC3Os0vRVOZcj0j8+EdtEJvlt/4ljEuJFjEH
 N/IuNV+qo+RRyraVyFzxvF0AdWdcaJiH8Iou9N7qXZg6VHYONyvHN8aPj2MVY/3VOJAiz2
 +VBCWgQufEBl55zuhE1Ij6orzkVhnoE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-XxxoqjE3O2qlh_fdMTNGsw-1; Fri, 30 Oct 2020 10:11:58 -0400
X-MC-Unique: XxxoqjE3O2qlh_fdMTNGsw-1
Received: by mail-wm1-f70.google.com with SMTP id l23so668159wmg.6
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=smveN6Rzbijww7fMqUTE3pDIKVjvYutAyE50uFiM4wM=;
 b=cPVHXXLFQLr7bKiCNokkpQGowsCnrW4Vy3VUh6HmErJy+DgtR+OM8mq3z670s3/vdL
 5+RyJayhGmbF5rfF9jYMgjARZQjD9DSxsQ7K2rdQ04ZTa9JIJrICbFlP+/hWhy9V9cKI
 PSn+rIWv+Gd1wDqDPHht6P+yhdVGoYYNF9f1IVzKEPCQu6rFEZ3rU8AeRdi6l6gLC9xg
 MNMuysEkqEf0R6SReroc/seQOittD9cWRy+GlQXkP9SUDCeg2e5HrNW8kr3hpa3IJrf5
 QNSWXAl3WKihjFTr0JqMcOEMyhSbufLAc07BSWS/jFDmCR07EnV2zQnHgRKjR4+ob/DP
 RHjQ==
X-Gm-Message-State: AOAM531sUoUN8/y2Gfq7FWT3lZCR/A1vFZRHzrOR5mtAAKxHqhNsDWpz
 /z/H9pIrJ0mChpExiKRDotSZ8NjDOWliFyMPpBPg87PbpZNDhsKCrl/+ogdb3lEgpeCizgvLwz9
 /I1BVF8D+nJFFVoc=
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr3727074wrc.276.1604067116803; 
 Fri, 30 Oct 2020 07:11:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAt7GGceYMLbksXnePSKL6GK/AXRaAnEXZdJOoy/uuSfG/o9rgJClybsLY+cbBNl+tNytLUg==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr3727053wrc.276.1604067116638; 
 Fri, 30 Oct 2020 07:11:56 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id o197sm4816442wme.17.2020.10.30.07.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:11:55 -0700 (PDT)
Date: Fri, 30 Oct 2020 10:11:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/15] acpi/crs: Prevent bad ranges for host bridges
Message-ID: <20201030141136.1013521-4-mst@redhat.com>
References: <20201030141136.1013521-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030141136.1013521-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben.widawsky@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ben Widawsky <ben.widawsky@intel.com>

Prevent _CRS resources being quietly chopped off and instead throw an
assertion. _CRS is used by host bridges to declare regions of io and/or
memory that they consume. On some (all?) platforms the host bridge
doesn't have PCI header space and so they need some way to convey the
information.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Message-Id: <20201026193924.985014-1-ben.widawsky@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e3a4bc206c..98ff9f5cef 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -866,6 +866,8 @@ static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
     crs_range_merge(temp_range_set.mem_ranges);
     for (i = 0; i < temp_range_set.mem_ranges->len; i++) {
         entry = g_ptr_array_index(temp_range_set.mem_ranges, i);
+        assert(entry->limit <= UINT32_MAX &&
+               (entry->limit - entry->base + 1) <= UINT32_MAX);
         aml_append(crs,
                    aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
                                     AML_MAX_FIXED, AML_NON_CACHEABLE,
-- 
MST


