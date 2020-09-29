Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C061EC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421F3207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCoUTTUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421F3207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA7N-0007bO-6c
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xi-0003ku-8c
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xe-0001hA-L2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QLwvk9fkTOPvGrodUi3C/eYGo7pFdPB9SJ+itSbjHRk=;
 b=XCoUTTUqU59QtAyQS0ojeIJkwORRWZy+D+ivnqfj2Vs8v8nPPuO4e3ZForVDXL7lX0+14j
 mLt1jXfoKzVzum24GXZjA0F212041NM55AocCeTX5KLgS9YzoSiMYVA0qE2NBfQMZfjNqJ
 a7wdP90RIQMy/goAGW1eGxAwRaI8Qgk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-BZZyN2MWNmWegOmifwxm5g-1; Tue, 29 Sep 2020 03:22:03 -0400
X-MC-Unique: BZZyN2MWNmWegOmifwxm5g-1
Received: by mail-wr1-f72.google.com with SMTP id o6so1364564wrp.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QLwvk9fkTOPvGrodUi3C/eYGo7pFdPB9SJ+itSbjHRk=;
 b=qyHbVglXafFgUunHfvvaLXpAUF4w31omS1j9YZdb6cUC0HTeHNDmx7T9TjH2FBwz8L
 GA+lQrawacGemZpWxzxUQ31pN5mGjJPWKmNtq5uKOuO6+00zHbiaILzzS3aBX79WNOEz
 SQKtXCyqtkIg2e90jYUd3AbqygnVxZ9pt3jy0kAqrhbgvXs90DniumYmkD3jyNLLJAjI
 L46QBl40l7blo39NyRp/aLxJSO/NQthBeXPgpvMfZxAcCRuwU4JNIJU+EswrBgEb8NIY
 22Xzp2yGlLyFkFOVhwjjM4yvz5YU2vlQchnxcA02i8Ix7/kci855bTpTQwHdVBSz3wCI
 JHfQ==
X-Gm-Message-State: AOAM531DzZzLeqHXYD0d8DOks7ovVh3V+q9Kq1J5dVtu8U9fYl+VRJtT
 NEGSs2jXdaRxvjiJtJbInVF239/zyvLSXMekE/RHfSXQuM++mXEKRO/BziTiQC9/CtUlU75slFI
 ZePVWVVZCQpy5g3E=
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr2554705wrq.83.1601364122210; 
 Tue, 29 Sep 2020 00:22:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3WYl/x0vBgTWQbH8yuNw+783BZ5qGir1sop2x3jv6G/OOS/0jk1n7BwMOvNDjDfRqRAcs6Q==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr2554691wrq.83.1601364122058; 
 Tue, 29 Sep 2020 00:22:02 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id m13sm2273771wml.5.2020.09.29.00.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:01 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 25/48] tests: acpi: mark to be changed tables in
 bios-tables-test-allowed-diff
Message-ID: <20200929071948.281157-26-mst@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

... to let tests pass until binary blobs are updated with new AML

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200923094650.1301166-6-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..dba32d5613 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,20 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT",
+"tests/data/acpi/q35/DSDT",
+"tests/data/acpi/q35/DSDT.tis",
+"tests/data/acpi/q35/DSDT.bridge",
+"tests/data/acpi/q35/DSDT.mmio64",
+"tests/data/acpi/q35/DSDT.ipmibt",
+"tests/data/acpi/q35/DSDT.cphp",
+"tests/data/acpi/q35/DSDT.memhp",
+"tests/data/acpi/q35/DSDT.numamem",
+"tests/data/acpi/q35/DSDT.dimmpxm",
+"tests/data/acpi/q35/DSDT.acpihmat",
+"tests/data/acpi/pc/DSDT.bridge",
+"tests/data/acpi/pc/DSDT.ipmikcs",
+"tests/data/acpi/pc/DSDT.cphp",
+"tests/data/acpi/pc/DSDT.memhp",
+"tests/data/acpi/pc/DSDT.numamem",
+"tests/data/acpi/pc/DSDT.dimmpxm",
+"tests/data/acpi/pc/DSDT.acpihmat",
+"tests/data/acpi/pc/DSDT.acpihmat",
-- 
MST


