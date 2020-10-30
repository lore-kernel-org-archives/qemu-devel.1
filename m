Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1602BC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811E92076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLrHeNJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811E92076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVDz-0000Uk-6L
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8R-0003fz-IA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8P-0007FL-UY
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LjrL669fVKay5a5661uPNZ920ikHdDz6ECFPczH1Ej8=;
 b=jLrHeNJC0zHFv45O6NsI0KiwP7Py/37hcgdZP5KAULHxDwfQrDxDoCs3cRdMBqHFUZfBXc
 lftI0GTq3buk9kC99mDJrA/hJX8e6DcWtOr8rDjNiUW8GFdFvadNYPbypaI+PA2FLJma1U
 452EeLlCJkfExs+1ccPCeMlMZE8mKfE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-AyE4HnMfN8iPceiKyCugfg-1; Fri, 30 Oct 2020 10:12:01 -0400
X-MC-Unique: AyE4HnMfN8iPceiKyCugfg-1
Received: by mail-wr1-f71.google.com with SMTP id j15so2705917wrd.16
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LjrL669fVKay5a5661uPNZ920ikHdDz6ECFPczH1Ej8=;
 b=PRNAuLOeHJJk5V6lh6NFw694M5qgud8d4vE+UWghGzWIVQ4h4Xh618xg0Vf5eH0nTF
 XtWGlaJwNQ6yQ067Y4yidN4IDMQBL1Buni/Z13Dv+mAEk0GUQt5+uRXbbKfd30ec1fEJ
 XlINSDF3fG5ebF5dE4cd81LxkEp6i/adGWl89U8DlgJJ1SWYf/T8TsvL6A70sN8Vdr6q
 DCbo9P9lWd2KueliOGQopA3dPfhEgLwAHbs4l47af4UWsscbJ5BUSOczo56N4bq5frBc
 l0ZkWyCAOooAg/GA5UJe11VOEeIkxLelZ31lVZHV87kb46gVrkEd/l6Vo+fpQJMMtQDV
 8uOg==
X-Gm-Message-State: AOAM532VFirQr+A2SCXjK5CTwznV7FDtJDyHAfOh0P+piF539i+SrUTm
 YEOwvOADsc2riDDJDlWmrdZ2YkchgohK7ei59QDCLBvgDsOADNmuihkdEOiCPHY8SkqVc/BqGhb
 fj4X/ZcWPCr4SPYU=
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr3349535wrp.89.1604067119399; 
 Fri, 30 Oct 2020 07:11:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy57ZauUsYn++m5CJUSyedZk/Cr1sXkdcX/CAJFi7ldufNkNgGcLvjG+Er+N352oLtHDrgE5g==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr3349514wrp.89.1604067119254; 
 Fri, 30 Oct 2020 07:11:59 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id h7sm10390978wrt.45.2020.10.30.07.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:11:58 -0700 (PDT)
Date: Fri, 30 Oct 2020 10:11:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/15] acpi/crs: Support ranges > 32b for hosts
Message-ID: <20201030141136.1013521-5-mst@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben.widawsky@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ben Widawsky <ben.widawsky@intel.com>

According to PCIe spec 5.0 Type 1 header space Base Address Registers
are defined by 7.5.1.2.1 Base Address Registers (same as Type 0). The
_CRS region should allow for the same range (up to 64b). Prior to this
change, any host bridge utilizing more than 32b for the BAR would have
the address truncated and likely lead to conflicts when the operating
systems reads the _CRS object.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Message-Id: <20201026193924.985014-2-ben.widawsky@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 98ff9f5cef..4f66642d88 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -786,8 +786,14 @@ static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
                 crs_range_insert(temp_range_set.io_ranges,
                                  range_base, range_limit);
             } else { /* "memory" */
-                crs_range_insert(temp_range_set.mem_ranges,
-                                 range_base, range_limit);
+                uint64_t length = range_limit - range_base + 1;
+                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
+                    crs_range_insert(temp_range_set.mem_ranges, range_base,
+                                     range_limit);
+                } else {
+                    crs_range_insert(temp_range_set.mem_64bit_ranges,
+                                     range_base, range_limit);
+                }
             }
         }
 
-- 
MST


