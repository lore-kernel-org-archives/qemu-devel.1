Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E87C3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C5120674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Aqfd4DSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C5120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywSz-0004Xo-6G
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQH-0008KU-Ng
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQB-00007i-A2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:17 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQA-0008PZ-Ns
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:10 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204113106euoutp01ec75b1651519749f0e1199d109dca10e~wL6fAC49g1797417974euoutp01r
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 11:31:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204113106euoutp01ec75b1651519749f0e1199d109dca10e~wL6fAC49g1797417974euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580815866;
 bh=ibNqqK8kMJTR6I/8H1P2J6EA3/WKQtaT/ZbDNoeJndI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Aqfd4DSAJImERZUZDRiRpHJS7cEn6EgKdBWTc2jPhY8/q9ihzvJTuk+HBFlh7oglZ
 N5QyTxZ2EcDU3uCvrUpHs0PPGeZzIvoHoipw5i6m+F5Yb/TIlRPkGy/ztKITIcSgAA
 Cp6MVq6ZV8GP2Q7s1EWRZvjdAMg0lb8Toy+RQrhA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204113106eucas1p13e363f2494c18906ee275c5151d8b7d1~wL6e1a7iw0258702587eucas1p1-;
 Tue,  4 Feb 2020 11:31:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 11.10.60698.AF5593E5; Tue,  4
 Feb 2020 11:31:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113106eucas1p2cf218553048c75f5a8b7771cde90f5f1~wL6eo3BV10478604786eucas1p2C;
 Tue,  4 Feb 2020 11:31:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200204113106eusmtrp1ffe5da8837d5c18144dfda89f0007f07~wL6eoVMm32102721027eusmtrp11;
 Tue,  4 Feb 2020 11:31:06 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-5b-5e3955fa463b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 37.AC.08375.AF5593E5; Tue,  4
 Feb 2020 11:31:06 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113105eusmtip22c663d39e14f5f41623b9eaf9917cafb~wL6eTCcnj1895218952eusmtip2Y;
 Tue,  4 Feb 2020 11:31:05 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC 3/9] memory: Hack - use shared memory when possible
Date: Tue,  4 Feb 2020 12:30:45 +0100
Message-Id: <1580815851-28887-4-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djPc7q/Qi3jDHo2KFjsufCYzWL/tn+s
 FnPOPGCxON67g8WBxePOtT1sHk+ubWbyOPhuD5PH+31X2QJYorhsUlJzMstSi/TtErgyVh7q
 Yin4zlYxb/VGxgbGnyxdjJwcEgImEvtu7GfqYuTiEBJYwSjRumciI4TzhVFi49RXrBDOZ0aJ
 yVeOssK0HHq5gwUisZxR4tTqG2xwLZOfLGIHqWITUJPYeeQzI4gtIiAp8bvrNDOIzSyQIfF8
 VjeYLSzgKNH59wfYISwCqhI/Hu4BGsTBwSsQIPHoUBzEMjmJm+c6wco5BQIl3u+ZBHarhMBl
 Nonbm/azQRS5SPw7tIAJwhaWeHV8CzuELSNxenIP1KP1Ei13dkA1dzBK9K2cDtVsLfFlw1IW
 kMXMApoS63fpQ4QdJXZdWMkOEpYQ4JO48VYQ4nw+iUnbpjNDhHklOtqEIKr1JLqf3GSC2bqs
 8RELRImHRMcJJUjoLGGU6L0zhW0Co/wshF0LGBlXMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn
 525iBEb/6X/Hv+5g3Pcn6RCjAAejEg+vhqNFnBBrYllxZe4hRgkOZiUR3vP6lnFCvCmJlVWp
 RfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MJ54V3mRJYDjA8+rvFOn
 rNQLvoTtSnT4zj+RaWLZXyMxTtdwhZnis7/nvGLWm9TuYS+f5HtkWtLqa6k7eD19nSYfN/yz
 6NOTOWZbA+TOyE0S4CgtdknMuj7hpIuKUsTSx/MVuzT3pwksdw/x2tUb+HyXWIPhYrZj5zaa
 bW9uO3clhz9I82o4jxJLcUaioRZzUXEiAB6A6PP6AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t/xe7q/Qi3jDL7cFLLYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlrDzUxVLwna1i3uqNjA2MP1m6GDk5
 JARMJA693AFkc3EICSxllPj99DEbREJG4sfpNVC2sMSfa11sEEWfGCVWH3zGDJJgE1CT2Hnk
 MyOILSIgKfG76zRYnFkgS2Ln7PtMILawgKNE598fYNtYBFQlfjzcAzSIg4NXIEDi0aE4iPly
 EjfPdYK1cgoESrzfMwmsVQio5MKuWewTGPkWMDKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93E
 CAzGbcd+bt7BeGlj8CFGAQ5GJR7eC3YWcUKsiWXFlbmHGCU4mJVEeM/rW8YJ8aYkVlalFuXH
 F5XmpBYfYjQFumkis5Rocj4wUvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQW
 wfQxcXBKNTB2+T28wif/1n3XCb7yiUUXtHetVL2k4iGwrOb3vcsB/4562/G2nnHjuHXotdnd
 CdMMvQ3O3dg5wcGswmlqUugew3bB+m4dzbD+BBUunrQCkZnL26b5fZCL9DNjLOZpuqp+0l5f
 WuRt3M11J2s7t3a9irliU7VMJ+DW9vM3X3a06pU0q7ndmavEUpyRaKjFXFScCADRsg9SXAIA
 AA==
X-CMS-MailID: 20200204113106eucas1p2cf218553048c75f5a8b7771cde90f5f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204113106eucas1p2cf218553048c75f5a8b7771cde90f5f1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204113106eucas1p2cf218553048c75f5a8b7771cde90f5f1
References: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200204113106eucas1p2cf218553048c75f5a8b7771cde90f5f1@eucas1p2.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 hw/core/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 0d1b4be..02fd7f5 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -785,8 +785,8 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
     if (mem_path) {
 #ifdef __linux__
         Error *err = NULL;
-        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
-                                         mem_path, &err);
+        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0,
+                                         RAM_SHARED, mem_path, &err);
         if (err) {
             error_report_err(err);
             if (mem_prealloc) {
-- 
2.7.4


