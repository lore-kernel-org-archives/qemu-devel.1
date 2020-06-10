Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF72DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964FA2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1RI7aB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964FA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisMl-00030G-Np
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisK3-0006h2-7s
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:26:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38788
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisK2-000861-H3
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAMCwY6Ii66tK0+En6xfr/Bb9/oeXHnOnpsD9bdoRBE=;
 b=a1RI7aB/tJOlfQnnBXHEduIcK9qiTjWgAn7y2hZegsoy7nXywdVwCUli1soSaaHt2RWfnA
 u18U7XInxHcF6IeX5wo2klC1UxMMpdO8oSKyKQflvukiXtXnCFHtEmmLU1MnDGgf0pQKp/
 /7xCUPzMhBXHnhCKEkZ1C7EljuFy+Gw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-BjeTEsDRP46juaoPMxZRNg-1; Wed, 10 Jun 2020 00:26:39 -0400
X-MC-Unique: BjeTEsDRP46juaoPMxZRNg-1
Received: by mail-wr1-f70.google.com with SMTP id a4so511375wrp.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kAMCwY6Ii66tK0+En6xfr/Bb9/oeXHnOnpsD9bdoRBE=;
 b=QDi0XnVrYiGi+V9r7A8bcWdTK+LQR9xT4M8jC8tuqtfwkNMwA0QXVvyidrk49rN9Nk
 yqfnjSXxrS34h+zM7FoFbWhz2SCORwkw7skva3IqOBNlDJ0F2b5aPxjBabooPwdUGZmZ
 +ipsVGlcgdO0A3Y6r9Jaab5Bq7opbUz8TN9LcdY08YCY5fnzXH3KLtYghiXDxZcJGCat
 hOJdV0gUOG4oK3mUn0expEx5DmnGbIlYBVz4tYHoJJsKENOJtXVHPvGLq5E+rnE1gEHX
 nS7ZBOlLr0HMGNC3tWgUaLRgf8G2GJxWIE77jEspN9UIpCtUQHkK3nQF76kCyi89OioG
 6UYg==
X-Gm-Message-State: AOAM5303H4r5jbusPE8elJtjtwxi3Fwv2xOCUQhnRYWO8w2CCP3YYu0S
 TQsxsAzrXQylOsUwKvZfo9B84PG86k7qotDkk2+W9ZAwUNLp3JV2EaBi8ikE1s72eIDs5RPt3yI
 5+wel/7V1BUCo6VE=
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr1178105wmd.138.1591763198270; 
 Tue, 09 Jun 2020 21:26:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxE+k/V767keuhJMpVDjKtFN8IN6kE2WOu7A38f/lGYQ+LmMaxK6YmOew4MpyLDj5EUCUNGg==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr1178096wmd.138.1591763198011; 
 Tue, 09 Jun 2020 21:26:38 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id y5sm6509410wrs.63.2020.06.09.21.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:26:37 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:26:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/56] diffs-allowed: add the SRAT AML to diffs-allowed
Message-ID: <20200610042613.1459309-3-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vishal Verma <vishal.l.verma@intel.com>

In anticipation of a change to the SRAT generation in qemu, add the AML
file to diffs-allowed.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Message-Id: <20200606000911.9896-2-vishal.l.verma@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..e8f2766a63 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/SRAT.dimmpxm",
+"tests/data/acpi/q35/SRAT.dimmpxm",
+"tests/data/acpi/virt/SRAT.memhp",
-- 
MST


