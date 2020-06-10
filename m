Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD166C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693482072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aASflvE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693482072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisjP-0002Cq-6S
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisNe-00042T-Pa
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:30:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36694
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisNc-0000BL-3g
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VpX9XjFjoE089UEoUCw+lrLKWRiMsf9KCnDg50S3IA=;
 b=aASflvE2B/4xVSQw8whBW4U+S8Wy06Ub52N4ssxt1Gk8O3ZDRLSuwthW9mSnF28vjhQd3y
 F5/vfky4y1MmflbxWPt7hgbhBYHe6B1z6WJz+oHPOMXzp00bhxpkW67hDuWq8o3QHeZePU
 pRJZHx0Ci/VlfgJRcA3Z4ayefhq01Ok=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-D5k5FyhjOGStivvSyvMItg-1; Wed, 10 Jun 2020 00:26:44 -0400
X-MC-Unique: D5k5FyhjOGStivvSyvMItg-1
Received: by mail-wm1-f72.google.com with SMTP id t145so88433wmt.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0VpX9XjFjoE089UEoUCw+lrLKWRiMsf9KCnDg50S3IA=;
 b=jMyfI9V7I2xM4yJvoZTdQbuzWqLavRUhS74a4P/Uj0wafTbe/df9jREqQp8JQv73nR
 dpM23YRGLWR9Ql38BUoEwTyteXHlRlV2vTbgFgWZ+KbFl9zZRQz04RpLdV5vm82eRbKK
 yw8cmL/64eR9rA7zMWeVFtPI4KwwEKlE1sj8vLCwS0VEOnqgMdtvsx5oRh7etPWzjSur
 lc4a8O/OT8L0TqetGCpjxr6lScaplrBcsC0sh+KqrFynvHVkK7xOrLRtG55L3ekYYqfh
 bOH1U+3i/I/JDL06MeWl4d4UFpxnc36kLpSZnY/y/5NTI52zxRkl/khqYLlqUHS8GCJc
 n+9g==
X-Gm-Message-State: AOAM531X8CoxRyREHK2a8zTFokfTUCri1yelQjJO+CXJM3xdVNGU8lrP
 mwEhxWFdiW9ZDQYPKRPf5iyxYmUJfDzE3CzqW5uWBS7DFmXggn1aC/a82IrTZ3V6XxObO+06+uk
 7F3LWymyewFVafXw=
X-Received: by 2002:a05:6000:d:: with SMTP id h13mr1264926wrx.17.1591763202845; 
 Tue, 09 Jun 2020 21:26:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzLfVU0IxGEZhmYSaWskJk35YdUABMRJPA4xA2mywOfYBAlAXVVEm7cVKxbU3PXWtPugCT4Q==
X-Received: by 2002:a05:6000:d:: with SMTP id h13mr1264916wrx.17.1591763202698; 
 Tue, 09 Jun 2020 21:26:42 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id y37sm7199995wrd.55.2020.06.09.21.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:26:42 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:26:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/56] tests/acpi: update expected SRAT files
Message-ID: <20200610042613.1459309-5-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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

Update expected SRAT files for the change to account for NVDIMM NUMA
nodes in the SRAT.

AML diffs:

tests/data/acpi/pc/SRAT.dimmpxm:
Message-Id: <20200606000911.9896-4-vishal.l.verma@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 tests/data/acpi/pc/SRAT.dimmpxm             | Bin 392 -> 392 bytes
 tests/data/acpi/q35/SRAT.dimmpxm            | Bin 392 -> 392 bytes
 tests/data/acpi/virt/SRAT.memhp             | Bin 186 -> 226 bytes
 4 files changed, 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index e8f2766a63..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/SRAT.dimmpxm",
-"tests/data/acpi/q35/SRAT.dimmpxm",
-"tests/data/acpi/virt/SRAT.memhp",
diff --git a/tests/data/acpi/pc/SRAT.dimmpxm b/tests/data/acpi/pc/SRAT.dimmpxm
index f5c0267ea24bb404b6b4e687390140378fbdc3f1..5a13c61b9041c6045c29643bf93a111fb1c0c76a 100644
GIT binary patch
delta 51
scmeBR?qKE$4ss0XU}Rum%-G0fz$nec00kUCF%aN@Pz(&LlS3Je0lmQmhyVZp

delta 51
icmeBR?qKE$4ss0XU}RumY}m+Uz$ndt8%z#mGzI{_tp$hx

diff --git a/tests/data/acpi/q35/SRAT.dimmpxm b/tests/data/acpi/q35/SRAT.dimmpxm
index f5c0267ea24bb404b6b4e687390140378fbdc3f1..5a13c61b9041c6045c29643bf93a111fb1c0c76a 100644
GIT binary patch
delta 51
scmeBR?qKE$4ss0XU}Rum%-G0fz$nec00kUCF%aN@Pz(&LlS3Je0lmQmhyVZp

delta 51
icmeBR?qKE$4ss0XU}RumY}m+Uz$ndt8%z#mGzI{_tp$hx

diff --git a/tests/data/acpi/virt/SRAT.memhp b/tests/data/acpi/virt/SRAT.memhp
index 1b57db2072e7f7e2085c4a427aa31c7383851b71..9a35adb40c6f7cd822e5af37abba8aad033617cb 100644
GIT binary patch
delta 43
rcmdnR_=u4!ILI;N5d#AQbIe4p$wD1K76@=aC<X@BiSc3+=gI;A(y0ha

delta 21
dcmaFFxQmf1ILI+%7Xt$Wv-3o*$rF#t0suzv27~|r

-- 
MST


