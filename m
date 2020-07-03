Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5A8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D56720836
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtY1QITD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D56720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHjL-0005tw-Dy
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcj-0000Dt-Oy
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51497
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHch-0004Ux-TF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=60yJhhl8dxn2TqcFbclvoZcJECXRC60a4szFbHzWcWo=;
 b=FtY1QITDIGg9thjUK+O5IPK53SPx3P7TAqt9ZJneEcWaRfAVqaQTYn6b/YZK/Sgx8jNLkU
 7YYuzDokBKT7ACQ37n4e2+WimmEHkYnnUZ+ueH2vE5sZpPU+djN8ClXHJzTv3OSQUlfckv
 juk2lV5uAjlBTJphPG98wioEKUbbUck=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-xHZ4uCk0MxeHYfyFjXEjmQ-1; Fri, 03 Jul 2020 05:04:41 -0400
X-MC-Unique: xHZ4uCk0MxeHYfyFjXEjmQ-1
Received: by mail-wr1-f69.google.com with SMTP id y18so11473134wrq.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=60yJhhl8dxn2TqcFbclvoZcJECXRC60a4szFbHzWcWo=;
 b=lDrTNt2j6mupFukEJykhxWLAZ2quRtjilGx8v3Lu32R/+wZEvMqTOHKHBBCoX9TRgB
 SW42hOHQ+d9ThBgUb1w9C5Q3CpWWBcuIVFpYjsbT2z26ycSVes44ervzXZw6N3fQRkGR
 nGLP9/ITyxCJMoo4cRUnJbfcZ+1czOYhjMzT50aah/HYohn6spb0aRda6321PpC79kue
 pmovCR/u9TRLx5Pv1DhTam0nnkF04/kZ1K8i/TxyRaZquTUU1gGJrvkT9IBQ0Bti6r9H
 QZYmJkEsfAGz3s4q6cefz4OZBOr2WUfj6US3rp6lBxI3605nqXZKSTJKE5HWyPfVad/G
 3Rww==
X-Gm-Message-State: AOAM5310S+yTcm5eLKloTpAOSCth47P3T1Qo9Iw9jBQyEuPBDD2eylbn
 dV7d5FqmJ2PL0mNYtqByL5QHKkKDiYABD1eCL5O+3UYJ6NejzpqBrOc+k9pZ5i91VGY1KRBCljt
 r6ALq4lVSJUMsKvw=
X-Received: by 2002:adf:e948:: with SMTP id m8mr36629162wrn.398.1593767080010; 
 Fri, 03 Jul 2020 02:04:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkC3UKolfnEOb4uXIMxFZe2mf7pVOLgDQpuEJfxfHRhhm0v34ckTl6xU5fu8YL/gjd/WIxMA==
X-Received: by 2002:adf:e948:: with SMTP id m8mr36629139wrn.398.1593767079711; 
 Fri, 03 Jul 2020 02:04:39 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 s8sm13408268wru.38.2020.07.03.02.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:39 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/41] tests/acpi: remove stale allowed tables
Message-ID: <20200703090252.368694-26-mst@redhat.com>
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
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

Fixes: 93dd625f8bf7 ("tests/acpi: update expected data files")
Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-Id: <20200629140938.17566-2-drjones@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 8992f1f12b..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,19 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.bridge",
-"tests/data/acpi/pc/DSDT.cphp",
-"tests/data/acpi/pc/DSDT.dimmpxm",
-"tests/data/acpi/pc/DSDT.ipmikcs",
-"tests/data/acpi/pc/DSDT.memhp",
-"tests/data/acpi/pc/DSDT.numamem",
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/q35/DSDT.acpihmat",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT.dimmpxm",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.numamem",
-"tests/data/acpi/q35/DSDT.tis",
-- 
MST


