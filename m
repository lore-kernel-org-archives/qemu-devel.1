Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F50C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374652081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5uZnv/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374652081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlRg-0004la-7M
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl4N-0002ze-Oh
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:54:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46502
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl4L-0001qL-BM
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VpX9XjFjoE089UEoUCw+lrLKWRiMsf9KCnDg50S3IA=;
 b=d5uZnv/UIiJNeNgsw3CPeQtfFCYzcz3TIXHZUo1frGa/t2IuqwJhBnCPqKEZjjySH+zPlx
 ZRDH9FdA0p2xYCQb35I7FE8YC7AFsUBWxgswFjSk7miccxarGnhoGeFGLvwXpvdSq97BDg
 s/6ZXi0xcD3Qc4SEPsI/4R1VFlMgNy4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Ixa02MTBORG3wSLreoAB2w-1; Fri, 12 Jun 2020 10:51:13 -0400
X-MC-Unique: Ixa02MTBORG3wSLreoAB2w-1
Received: by mail-wr1-f69.google.com with SMTP id z10so4016604wrs.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0VpX9XjFjoE089UEoUCw+lrLKWRiMsf9KCnDg50S3IA=;
 b=ocVLOp45Zl7l877HeBQPYbU5cPLYdkdZcsfprJ4B2WBAmU4m4GDYlxlRfIDRWGLslj
 Tb8xv4P5wzShgcrPQdVq228mp1pHx9Pt+XrhmAn6lcOGh/7VEEg5r5+N4ZFpCyFyA2SE
 Lvi1FPbJQHqWl8rkE4EFG3cHozW97AHL1jLxMMWUZiUgevquvZcOneq1u3lawVCQHpPT
 2OfkKOciL8gC0tDHb6vRZUe22/DW3y8AL2MnWvDIrdIUENWwf1z4rzeM8chWa4cTsgmC
 CH1rtpA+PRSDfkn5i2J66ZAQEzOwAUBE4MFcNJ0v9nMtQNxn7DxD/4pCB+EAOZ/wqqCB
 8u7g==
X-Gm-Message-State: AOAM532plwqAAfnhk9H2R3wg23y7DwFWzkYINgucq9W6BI0rRhokKkoZ
 dRpxpVpSRpcbzK++rkevYvgnJ7EEIs8Xf9MLknUx/ULaCS/CtAKEeJaPSEEvjMaIEcWO+LhiddB
 vDn2e66dLPmek2Sc=
X-Received: by 2002:adf:bac8:: with SMTP id w8mr14837724wrg.47.1591973471769; 
 Fri, 12 Jun 2020 07:51:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy76c6Ne74nOLVQbXVFmcp2t3L7o1MCqmYO2aHq9hdwhZFlOBOOwTZYcXhTGdwNv/JfmmXgZQ==
X-Received: by 2002:adf:bac8:: with SMTP id w8mr14837703wrg.47.1591973471542; 
 Fri, 12 Jun 2020 07:51:11 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id k17sm10624039wrl.54.2020.06.12.07.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:11 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/58] tests/acpi: update expected SRAT files
Message-ID: <20200612141917.9446-5-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
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


