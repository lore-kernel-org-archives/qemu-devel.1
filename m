Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1262CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58BF2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyY1cu0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58BF2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jishD-0006qi-T2
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisNe-00041r-9c
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:30:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisNc-00005l-92
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tIipyy3cxji7TSg5TkYgKmMY4wP6xoAvP6GDwENCxXs=;
 b=EyY1cu0+3xIU/NMykOyvbAJGqHqUileY9L19eOfPW2udM6PR2qT1JdU8D+5m0EdzjodsNr
 f6V89TZogZRTozL5rL1zYk60x+RH6zaBI6Py8ssz5zMX4eIq7os+yfdnehBKOcdBFQz5OM
 kqTsyb3PjGdI71dbSPJZ+r2/qEUH9tU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-kBnmDtfCMtexo2fsqYToyQ-1; Wed, 10 Jun 2020 00:26:45 -0400
X-MC-Unique: kBnmDtfCMtexo2fsqYToyQ-1
Received: by mail-wr1-f70.google.com with SMTP id e1so514510wrm.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tIipyy3cxji7TSg5TkYgKmMY4wP6xoAvP6GDwENCxXs=;
 b=DLs9JBhue+QOcD7DwYLV24x/f53chwJsbqGbLrMJpjSy17MgOqwx7gYjelx+d7H1OZ
 CyuMmroiYTCch/EQA9xOsVeli5QihOA/go23Wwxdf0MdYP3QW1gWadWzjJm2TK9IpL59
 XPj7TRSoMauPgRqYuVvQUbEDRPvTBQWADaKVQ4sQeBsnh7mdzmKSiOcYLoQb2Wd9AGoa
 jFQajJzebAmyKKZnVpCFY0RFQ+gHjx4kzzrqX4d5CnQQWyF5ikV8VEiVYJgiDvrrtBIG
 P8G/cwe6OV2PhGm2b/ymvl66h4ej2WirVI/PiVNbMfVe8n1XgUZm4TCoVx+MihVOmFLI
 pJDw==
X-Gm-Message-State: AOAM530AUhaLd3mq0BDa3oEezxuXzKFz2FRwwNbJCdVQ1Rsfhe7/ovMA
 GUV6Esbs0lHnIsxTeJIys+fpjYywNDkxISUKpyOADuBCTVjVEp0+OsKQ9mNuLcR8NnwmIYv3PIL
 VBGKVtYy1hnyHeng=
X-Received: by 2002:a5d:49c5:: with SMTP id t5mr1354101wrs.18.1591763204799;
 Tue, 09 Jun 2020 21:26:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwofrngvDI/YxgzblJK8T3STEFk+Ndr9320XBj4cKg4kPHwyASkuvXulyuNgYy8+2ebVQ5AhQ==
X-Received: by 2002:a5d:49c5:: with SMTP id t5mr1354094wrs.18.1591763204647;
 Tue, 09 Jun 2020 21:26:44 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id s8sm6442887wrg.50.2020.06.09.21.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:26:44 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:26:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/56] qtest: allow DSDT acpi table changes
Message-ID: <20200610042613.1459309-6-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20200515150421.25479-2-kraxel@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
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
-- 
MST


