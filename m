Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6724AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A3C20691
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iz3whja/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A3C20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlCZ-00086I-Cy
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2T-00073q-W2
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49819
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2S-0001Ti-7d
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11YzbNhHFtGTHcpUmTTeopy8tsF4jxxnFLUzlloWLDM=;
 b=iz3whja/RtDc/qe5ayw67DKPd0i6Pmvb1Im+hiyIvQfo/IkvhjmjvmDof6aBQYwGeNJkgO
 pnWnqC//RWX1xFO4TrM1FSWqpWD3Rh1bIK1UtDttZRZcUuhM9FBT4sfpaqLxF+X/qmnlyO
 TYXo2gJxKUUrUf9RHoeOBonlAn6FJ6c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-BpLEKCkiPayozaeyH8ru8A-1; Fri, 12 Jun 2020 10:52:05 -0400
X-MC-Unique: BpLEKCkiPayozaeyH8ru8A-1
Received: by mail-wm1-f71.google.com with SMTP id a7so2034761wmf.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=11YzbNhHFtGTHcpUmTTeopy8tsF4jxxnFLUzlloWLDM=;
 b=mAhF7D/+7R4aTa9tAYv4OS7jwjeDUtYp9YB3rLP3WZO2MlYTRq7GsyR8MnRU0jExEb
 T095iay8fK4z5qqfxqvwU18goPXjNGPn8Ly/xR6CbOk3iSRt1lDKKDJOCKODOXjeS9li
 fDj8O1qRDYWyDGg2NEPhR8wvAhtNn2465NqNYDIUABdpyf8hExYuM4vVM6Ifgzuj6NeR
 tT2qeKIGnBk/b7M7hDPJLIpLldtY7LkHjEEK+gnow3h0JVA1HSIfM+hJ+E6mUkNS4KpN
 //3dZjcqJVn3HC3opRdTcUYj6G4kQ4rF3erlV0VIGrJEIEAmt1h4ELVvehviqNe8mfEh
 89rw==
X-Gm-Message-State: AOAM5301BFavkFqh37JfxFCVLCFX1PMUOki030ZZ6+l/XQ9hF8U9bxND
 cqAm7I9+4bbdCRK1jeK198J2B2XIm5O7OoY6Q4B8GKH6M3kWLmtI4IbZUEfhvvY3+ajv3Xj4dnE
 RSFAZuQz67Of0YPo=
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr15221178wrw.401.1591973524634; 
 Fri, 12 Jun 2020 07:52:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT2Y7OQZIcRitWMshLKHB1qOKOVgd6v7J65CqBD/QTZEX+y0tq0k4SIWxgwJp3KIMzEQ2+Ow==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr15221159wrw.401.1591973524407; 
 Fri, 12 Jun 2020 07:52:04 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id d11sm10575623wrm.64.2020.06.12.07.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:03 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 27/58] MAINTAINERS: Fix the classification of
 bios-tables-test-allowed-diff.h
Message-ID: <20200612141917.9446-28-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The file tests/qtest/bios-tables-test-allowed-diff.h is currently only
assigned to the qtest section according MAINTAINERS. However, this file
normally only gets updated when the ACPI tables changed - something the
qtest maintainers don't have much clue of. Thus this file should rather
be assigned to the ACPI maintainers instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200607052022.12222-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7890ce82..0c5ed09ad5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1531,7 +1531,7 @@ F: hw/acpi/*
 F: hw/smbios/*
 F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
-F: tests/qtest/bios-tables-test.c
+F: tests/qtest/bios-tables-test*
 F: tests/qtest/acpi-utils.[hc]
 F: tests/data/acpi/
 
@@ -2321,6 +2321,7 @@ S: Maintained
 F: qtest.c
 F: accel/qtest.c
 F: tests/qtest/
+X: tests/qtest/bios-tables-test-allowed-diff.h
 
 Device Fuzzing
 M: Alexander Bulekov <alxndr@bu.edu>
-- 
MST


