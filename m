Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB58C4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E28220897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPKIO6bN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E28220897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAHv-0007i2-KR
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9y8-0004KD-F2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9y4-0001mH-5i
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FFSe8S+d7sfyg/qRmOaCuy2aqdJJ66OVOFjNgQL5r2g=;
 b=cPKIO6bN/daQe7SHG873lP5w+LogGS+mhVzoUYC4BwzCdQ/xA5vvLLwvpngbhHW+bDXee5
 UdwYXhlz2IXWIhWDo1YX9oTmi9pULNO2RlzauwNAFDmbZ1huwd/Z76K/XejYj9FWzIW1OK
 kSWreMrqKZBMpoKIFftG/HUTwu55D8o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-1o8DDa_dMvK6dCtegbW8sg-1; Tue, 29 Sep 2020 03:22:29 -0400
X-MC-Unique: 1o8DDa_dMvK6dCtegbW8sg-1
Received: by mail-wm1-f70.google.com with SMTP id m19so1454750wmg.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FFSe8S+d7sfyg/qRmOaCuy2aqdJJ66OVOFjNgQL5r2g=;
 b=HxOMlbNXgT0Gv4WWw/o5FekVd1Wz1s2A5jab2aTMIvVglzX05XNbk+fX0tZenc7zUH
 Jfg9obu3Z83eQ1cufIQusscfPxj3PWuSYmqnLYm/z4NU6DGICi9MHVHSQb5SW6/77lXW
 V+sPW6MB6PZqtDponSiT87VI3x1YN9ComHJiPGO4pf9nZRkU4OMcVRlWW7T3vmrjyvys
 w+9DZVCd5I7kYkALs1YQpC0iyT5ApXGWkskCTOOfpDKXFkILYyft9Ny/5Km9be9H8fAl
 QUcAQSku4A95y5ahd6+8Ms1tBeT4t5z+tD5Fy+yOb57OYCY69yzWfbDcyyOUfDCNpO4w
 +awA==
X-Gm-Message-State: AOAM5309DE6ZjkSUkHnromjgA2TwxEEacHuWlPRIEfllF3IgvwkVIaqb
 NXck/ANxj9YRLGfwmYOslY29N4HwEwA+dvvICIQp0gpVWhX86DOghUNR//2AN9+Ysp6Yn32OM5t
 y5v4Z52GWaPXMhH8=
X-Received: by 2002:adf:e74d:: with SMTP id c13mr2460377wrn.45.1601364148151; 
 Tue, 29 Sep 2020 00:22:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTruZnO4rFJhXVLkLMPvLRqZSt46cAvWatLRa9X6ObWqp6xcT8Yrg1d1H92SB0riVZ+W6/zw==
X-Received: by 2002:adf:e74d:: with SMTP id c13mr2460362wrn.45.1601364147985; 
 Tue, 29 Sep 2020 00:22:27 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id h2sm4662989wrp.69.2020.09.29.00.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:27 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 35/48] tests/acpi: mark addition of table DSDT.roothp for
 unit testing root pci hotplug
Message-ID: <20200929071948.281157-36-mst@redhat.com>
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

A new binary acpi table tests/data/acpi/pc/DSDT.roothp is added in order to
unit test the feature flag that can disable/enable root pci bus hotplug on
i440fx. This feature was added with the commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on
the root bus")

This change documents the fact that this new file addition was made as a part
of the unit test change.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200918084111.15339-2-ani@anisinha.ca>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..ac864fc982 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.roothp",
-- 
MST


