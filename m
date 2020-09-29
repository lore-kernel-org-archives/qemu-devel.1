Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FD6C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A36A2076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UT8RBj4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A36A2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAS6-0001Ku-5W
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yV-0004kb-MJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yT-0001pv-PJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EwyTgJhF8AsAZniyWeG1vWRLhBKt2xIBZcMYKHj90t8=;
 b=UT8RBj4kDOfsqthHfTE0TNxH5yxrirUUlROjIHNyAbN1W23lSWxsoCHYwkPlDiUHeoG3fR
 3a9pBhnJ4bbHsmpNsHsKkjnXcE2LU4X66K00EkcmkF62I4eXMWBlN6GWTK7ZOMF3oVefaX
 buaVbyZdKeAscT9DiyFwWF4f5BExqm4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-mmF7LP3-OHGSXzdmeMKBWg-1; Tue, 29 Sep 2020 03:22:50 -0400
X-MC-Unique: mmF7LP3-OHGSXzdmeMKBWg-1
Received: by mail-wr1-f72.google.com with SMTP id b7so1370089wrn.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EwyTgJhF8AsAZniyWeG1vWRLhBKt2xIBZcMYKHj90t8=;
 b=E86LYuJ5T4TDZAu8L6r9b1PJaPis3SdHqmAQMCaElb0mFEgVae3hOHvyszsYZgL94q
 SfjUvZaOFFrjy77I6dJTV5rDgONg19UKGQgx6L7KxCTjEaARqnjglkQoVTsXTCYhyPJM
 NeX7zKdjTYYZIFowgtI+Dn5q5hrG/jbOpvwcaaCeouM/Mjegs+IolzOhWMUSm72jggrD
 Zld77JSVIsC+aksqaYH4h4iySYstoPvoI+tPVF3w535s1VubJSOFiHX4QRDufR4Ao7RF
 ejKpg2j8Mq7MI+u2JRzLcdzCoXWTF1Jj5Bb9V/H5oogFN8KCkOSNgltipEMPAn8CHNv0
 Rd0A==
X-Gm-Message-State: AOAM531jV00AmG705IYxXJ48kBYsli0Dmvhcl+33w3x+E+nWZFK66/D1
 yAvXe5cP9qu0zaUi9E8UsqRUEUkQnveVoUDXD84nBIH4b9StYGE1SSF9a4YvO/wnQ1FuIyqgnwz
 doiNBwa1B+FJ1jAE=
X-Received: by 2002:a1c:152:: with SMTP id 79mr2945736wmb.90.1601364169030;
 Tue, 29 Sep 2020 00:22:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWGe8SiLZwmAmLrcBwJsfS8YoKCViOh0q3oz66YCPj387mJiU6cp3wXRFzNFPEsrwMHqL2oA==
X-Received: by 2002:a1c:152:: with SMTP id 79mr2945720wmb.90.1601364168877;
 Tue, 29 Sep 2020 00:22:48 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id c14sm4698033wrv.12.2020.09.29.00.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:48 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 43/48] Add ACPI DSDT tables for q35 that are being updated
 by the next patch
Message-ID: <20200929071948.281157-44-mst@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
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
Cc: Ani Sinha <ani@anisinha.ca>, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ani Sinha <ani@anisinha.ca>

The following patch ("piix4: don't reserve hw resources when
hotplug is off globally") modifies certain ACPI tables for q35 machines.
This patch adds those table names to tests/qtest/bios-tables-test-allowed-diff.h
so that unit tests continue to pass and bisection is not broken.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200918084111.15339-10-ani@anisinha.ca>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..631703142c 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,11 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT",
+"tests/data/acpi/q35/DSDT.acpihmat",
+"tests/data/acpi/q35/DSDT.bridge",
+"tests/data/acpi/q35/DSDT.cphp",
+"tests/data/acpi/q35/DSDT.dimmpxm",
+"tests/data/acpi/q35/DSDT.ipmibt",
+"tests/data/acpi/q35/DSDT.memhp",
+"tests/data/acpi/q35/DSDT.mmio64",
+"tests/data/acpi/q35/DSDT.numamem",
+"tests/data/acpi/q35/DSDT.tis",
-- 
MST


