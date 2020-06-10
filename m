Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E990C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E617120734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdgE2wGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E617120734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiscp-00019t-V6
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKy-0008V4-9I
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKx-0008IX-Fb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11YzbNhHFtGTHcpUmTTeopy8tsF4jxxnFLUzlloWLDM=;
 b=fdgE2wGz2Xd5o2S5xyItIpAEl0PnJ/S5SFUs0dSbuO0aCWyIDWNaXXXJ/9TZ+6Ct+9VvFN
 nPALQw08sI946zV25bqznCU05CeDCThnZ4mK49Kiveqb3+ABMZbwYbkaGpfGb2gFD+wAm9
 4WaQNhmGul5sfv97WfVWCPwmt6eKEcM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-tYhF77pNNlWQBP6xPFNniw-1; Wed, 10 Jun 2020 00:27:36 -0400
X-MC-Unique: tYhF77pNNlWQBP6xPFNniw-1
Received: by mail-wr1-f71.google.com with SMTP id c14so503471wrm.15
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=11YzbNhHFtGTHcpUmTTeopy8tsF4jxxnFLUzlloWLDM=;
 b=TXLHqJ+SWbZurfjtjFNlhEX5BJ1iE3InGGjx6n6kazERukSE5G09airucniRwe4Q97
 tAgSd3pasUZyNP6d3gJczBoLKODspOvJw9Z8PVSYgoMjb8cUZyFrpMkMpWcWrVmDTdmY
 vgXJUOziNgSq1W/89VVJrr3KLmC7aD9uOpoa9kftZfNIlHCN1/xfLFcPpaD4JD0FlWa4
 RBDlk3x2bb8GU1rMAUGr2nf3FMWblSx2mIbWX/5WXUBYPsnp49yYBB/ENZ0emKFX9bsv
 Kcjlhob5Zu/3+HLRZ9ZvLFIOeA0WAX6Ko5BQc0xclQRgyHTETKWEwavYWuNoK6dkpl8N
 +nSw==
X-Gm-Message-State: AOAM530Ihv/aHyLYtyJa/ykAyoCjP1fbIsHsSGondo+j38TsNz++I8Tm
 NJDMjixb63Glb0kE9v3Z0hedMdLm9zvvOqJdBgsRpKC27wWXDXVAKzlwHhGcO0lZFCEVB2Vje5G
 6zf8Mm2DIr4MHNp0=
X-Received: by 2002:a5d:6087:: with SMTP id w7mr1448487wrt.158.1591763255131; 
 Tue, 09 Jun 2020 21:27:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH/R0H1Yn1QXu55fk3L4uF2hDXWBaf5Pl3/mpGD+cyPzBv+HPuJnUktpq718maViwt1BXcPA==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr1448470wrt.158.1591763254960; 
 Tue, 09 Jun 2020 21:27:34 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id a81sm5310455wmd.25.2020.06.09.21.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:34 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/56] MAINTAINERS: Fix the classification of
 bios-tables-test-allowed-diff.h
Message-ID: <20200610042613.1459309-28-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
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


