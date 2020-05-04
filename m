Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7509DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3399A2078C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEi6a0DH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3399A2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcDd-0001rw-B7
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc67-0004tG-P4
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52319
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc66-0005vZ-Tv
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iDOQuTM/GBdioleUH2RjG+5kuhxga2pExwroaaGOjs=;
 b=fEi6a0DHKQyL3UPHo7VCfJGCoX/zqeak8KSFECpgb2WMAovqK7bXTllvLZpFYjI7wC0F3Q
 zDYrx+Bg1AHXsHz3CLblaxsElKjXUB5QHoBdHwqJQZJriULVX/TaiwfpRLS1cajdMZ5EJk
 iHA6HYloy7ceEd9TtUREwCoX81HM1pU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-oDJVTEreMMCkXIoVXpfh2Q-1; Mon, 04 May 2020 10:29:28 -0400
X-MC-Unique: oDJVTEreMMCkXIoVXpfh2Q-1
Received: by mail-wm1-f72.google.com with SMTP id h22so4989525wml.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bmWb41iB+zUkq2ymfjwDCKrhB5rQBk8dgJEafa9xU5M=;
 b=OdNE+bXI1Wohx4gCs2eGrnkijFGcbAF+wUB/HKP3uQ77PCuGnUvGWtY39bS8HlStLx
 a+hVce6NB8RhfcDabDJh/3cCCXtfB4sF7HwVzHlXgg3bzl78D7md/BNJ04dn/3RGoomy
 BItOUxLGvWDFUMQJPXNFKzWJ4+IrZys53pHmtAq9U9rAxW46m50ZtdO+auIcaAURa5Nc
 UDsr2rGkpl9YdXql6vyQUv1sROxzuxEco23/rbaeGvBcmXPGTSohDnLfcAFYAjisB31V
 Zzr9y6UshPbI6xvGqP15dCxoGfXRNNezCcGNnq9EoUO7uHaaPyLLZALqeLnmvSwyObdy
 s9fw==
X-Gm-Message-State: AGi0PuYECZpMLzIg0qCt7FYIXzpHNzXfiakEWHUH0heic3zfT4efrzzo
 GdWxi1PxlU7C+t1dqis8aNXwzMMnVYk2b5Dm9U2OnqWWLogWDVv11MXiR9cFCOSvHiZzv3blVfT
 iIDVO/cEJPALFm+w=
X-Received: by 2002:a1c:770f:: with SMTP id t15mr14616329wmi.178.1588602566620; 
 Mon, 04 May 2020 07:29:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypIi+sLSqRuGbAM7XQfwHGVVQ5B0DEcuadm0ZTFQ8ofpVfwAbUcyiTHaRFWX7ZXSCPCX/f674g==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr14616312wmi.178.1588602566470; 
 Mon, 04 May 2020 07:29:26 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 h16sm21062892wrw.36.2020.05.04.07.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:26 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/29] qtest: allow DSDT acpi table changes
Message-ID: <20200504142814.157589-6-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20200429140003.7336-4-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios=
-tables-test-allowed-diff.h
index dfb8523c8b..6a052c5044 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,18 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT",
+"tests/data/acpi/pc/DSDT.acpihmat",
+"tests/data/acpi/pc/DSDT.bridge",
+"tests/data/acpi/pc/DSDT.cphp",
+"tests/data/acpi/pc/DSDT.dimmpxm",
+"tests/data/acpi/pc/DSDT.ipmikcs",
+"tests/data/acpi/pc/DSDT.memhp",
+"tests/data/acpi/pc/DSDT.numamem",
+"tests/data/acpi/q35/DSDT",
+"tests/data/acpi/q35/DSDT.acpihmat",
+"tests/data/acpi/q35/DSDT.bridge",
+"tests/data/acpi/q35/DSDT.cphp",
+"tests/data/acpi/q35/DSDT.dimmpxm",
+"tests/data/acpi/q35/DSDT.ipmibt",
+"tests/data/acpi/q35/DSDT.memhp",
+"tests/data/acpi/q35/DSDT.mmio64",
+"tests/data/acpi/q35/DSDT.numamem",
--=20
MST


