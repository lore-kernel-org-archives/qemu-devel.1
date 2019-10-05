Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67176C47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33786222CA
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lav1iR2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33786222CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsJC-0001Vd-9D
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs5e-0005T3-9c
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs5b-0004Ta-U8
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34831
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs5b-0004TM-NF
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570312787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=as81qNY/8jBNK5sdM7N/UPpLXYBV1axo5JCdlWpRnME=;
 b=Lav1iR2D9TmWQhJyZPtYIbYgeBRjSMzcCoStTB7l46OeiOENQaF/PY5vQR3BKeFttGBGFy
 d2OinDTgjdxOTL4XQDLnfeY/sM1yACk3WP3M730oEgIoEH+7pCg4wsiZJerg2lRm33tXEx
 rz8TUxPN+OfkBGDCvZfq/JYhmxKfnOw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-A9fDCVJlNFOo_f1NYKZ7KA-1; Sat, 05 Oct 2019 17:59:43 -0400
Received: by mail-qt1-f198.google.com with SMTP id o34so10875537qtf.22
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Hg7rvNqDATjoCvchW/YNuYPA53VKP1VfBxpr+nGemAQ=;
 b=hSUQ5MxaT/a3q0aQYir1DPnSuD1gbNvzBPSkiI1b+fbkhDcdJtqProJDBSg3rj18Hb
 SnBb1rNnnpdQjUw3MqfO7kLpw9Gu1U5Ke0S7MfNXZUMWtGDBjpwOp/X+6q/UIIKvIpRV
 8XaykpriCqr/07Sl+BFOW9lvQFoBCrWD2wqjKdYQd1ok8y4jht8uKbVdPL+qxhYeAeVK
 dKsjO3cN75HDtwMMLyvw9GL7SRyaVNYOREOsFNDtHKUa1yEzYOU1JYMtHLAMTjK0vhu/
 f/hguUjyssWoxLffBpAPiKTSqr02eEw9wN6uwUdR9oEtzNpbUa078cQ++BfSB7nW7c1F
 lvQQ==
X-Gm-Message-State: APjAAAXTCE9d3GhDsH91GO/nWAKK9qlKdmqfVcHIQpJvHYFUbocp+c+S
 OIsjMEhOCgHMlSlGC2bBxtFw+c6m2m9G0F7tj5aLc2Q+r0PUg/d1AtmJQvC1+Sq/KQOuBHUHj58
 3HGKAP+JFdPXwvCs=
X-Received: by 2002:aed:3b62:: with SMTP id q31mr23606353qte.246.1570312782165; 
 Sat, 05 Oct 2019 14:59:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/AhIP9a8LJflq7JWs2FUCwVjSD6/DUtzvrUiG6R50C/OKiT8qiPz0E/8M7wwtxBPY8kOlZw==
X-Received: by 2002:aed:3b62:: with SMTP id q31mr23606348qte.246.1570312781966; 
 Sat, 05 Oct 2019 14:59:41 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 m14sm4785888qki.27.2019.10.05.14.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:59:41 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:59:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/19] tests/acpi: add empty files
Message-ID: <20191005215508.28754-13-mst@redhat.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: A9fDCVJlNFOo_f1NYKZ7KA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Needed to make tests pass. Will replace with actual files.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/virt/APIC.memhp   | 0
 tests/data/acpi/virt/APIC.numamem | 0
 tests/data/acpi/virt/DSDT.memhp   | 0
 tests/data/acpi/virt/DSDT.numamem | 0
 tests/data/acpi/virt/FACP.memhp   | 0
 tests/data/acpi/virt/FACP.numamem | 0
 tests/data/acpi/virt/GTDT.memhp   | 0
 tests/data/acpi/virt/GTDT.numamem | 0
 tests/data/acpi/virt/MCFG.memhp   | 0
 tests/data/acpi/virt/MCFG.numamem | 0
 tests/data/acpi/virt/SLIT.memhp   | 0
 tests/data/acpi/virt/SPCR.memhp   | 0
 tests/data/acpi/virt/SPCR.numamem | 0
 tests/data/acpi/virt/SRAT.memhp   | 0
 tests/data/acpi/virt/SRAT.numamem | 0
 15 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/acpi/virt/APIC.memhp
 create mode 100644 tests/data/acpi/virt/APIC.numamem
 create mode 100644 tests/data/acpi/virt/DSDT.memhp
 create mode 100644 tests/data/acpi/virt/DSDT.numamem
 create mode 100644 tests/data/acpi/virt/FACP.memhp
 create mode 100644 tests/data/acpi/virt/FACP.numamem
 create mode 100644 tests/data/acpi/virt/GTDT.memhp
 create mode 100644 tests/data/acpi/virt/GTDT.numamem
 create mode 100644 tests/data/acpi/virt/MCFG.memhp
 create mode 100644 tests/data/acpi/virt/MCFG.numamem
 create mode 100644 tests/data/acpi/virt/SLIT.memhp
 create mode 100644 tests/data/acpi/virt/SPCR.memhp
 create mode 100644 tests/data/acpi/virt/SPCR.numamem
 create mode 100644 tests/data/acpi/virt/SRAT.memhp
 create mode 100644 tests/data/acpi/virt/SRAT.numamem

diff --git a/tests/data/acpi/virt/APIC.memhp b/tests/data/acpi/virt/APIC.me=
mhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/APIC.numamem b/tests/data/acpi/virt/APIC.=
numamem
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.me=
mhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSDT.=
numamem
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/FACP.memhp b/tests/data/acpi/virt/FACP.me=
mhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/FACP.numamem b/tests/data/acpi/virt/FACP.=
numamem
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/GTDT.memhp b/tests/data/acpi/virt/GTDT.me=
mhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/GTDT.numamem b/tests/data/acpi/virt/GTDT.=
numamem
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/MCFG.memhp b/tests/data/acpi/virt/MCFG.me=
mhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/MCFG.numamem b/tests/data/acpi/virt/MCFG.=
numamem
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/SLIT.memhp b/tests/data/acpi/virt/SLIT.me=
mhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/SPCR.memhp b/tests/data/acpi/virt/SPCR.me=
mhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/SPCR.numamem b/tests/data/acpi/virt/SPCR.=
numamem
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/SRAT.memhp b/tests/data/acpi/virt/SRAT.me=
mhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/SRAT.numamem b/tests/data/acpi/virt/SRAT.=
numamem
new file mode 100644
index 0000000000..e69de29bb2
--=20
MST


