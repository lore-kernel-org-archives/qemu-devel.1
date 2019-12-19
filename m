Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27D3C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1CA218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mvgtA2Tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1CA218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwKN-0007Lh-Sc
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYk-0001Nb-2c
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYi-0006Ef-C4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:41 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYh-00063D-RS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:40 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130937euoutp01429c451c9fa64301ef4f85cbe918be64~hx8FUUaGp1365313653euoutp01m
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20191219130937euoutp01429c451c9fa64301ef4f85cbe918be64~hx8FUUaGp1365313653euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760977;
 bh=PI0wPpe+6jm84ohj/M3ftXfubfvYXY1DORcCJ5jVwpM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=mvgtA2TrV83phqccxZW+AcYV5lzwLeWQTqw5JjEfsh/TFZim1GMTC9nfYa/F18/eR
 bVi2dDOuO6bi06hCcJIU3yvD9KbhkD6S+ftrrIDnyNuacePruyWzRmIlCt9abS/Fa+
 6N9ezQW84IVIe/ZMLUXyBK3HpX72u/ahF7LUF7ws=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130937eucas1p2e0e790135537b840685161592a765389~hx8FNWrBm1986419864eucas1p2K;
 Thu, 19 Dec 2019 13:09:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id D8.FF.61286.1967BFD5; Thu, 19
 Dec 2019 13:09:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130936eucas1p22abefb644922c11e79b3ebe32d565e57~hx8Emg2u73067530675eucas1p2V;
 Thu, 19 Dec 2019 13:09:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20191219130936eusmtrp13cd9e7c0da5902b6acf98b672784bab7~hx8El1eD22185921859eusmtrp16;
 Thu, 19 Dec 2019 13:09:36 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-4f-5dfb7691aff2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 01.4D.08375.0967BFD5; Thu, 19
 Dec 2019 13:09:36 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130936eusmtip2c5323f02b64c3ca981e923ca81a7d15e~hx8EcANNB2997729977eusmtip2H;
 Thu, 19 Dec 2019 13:09:36 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:36 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:35 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 04/24] nvme: add missing fields in the identify data
 structures
Date: Thu, 19 Dec 2019 14:09:01 +0100
Message-ID: <20191219130921.309264-5-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7oTy37HGtw6q2ixub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ4rJJSc3JLEst
 0rdL4MpYs3k7S8EE0YrJEzUaGB/zdjFyckgImEjs/NXN2sXIxSEksIJR4mPjYRaQhJDAF0aJ
 57fjIRKfGSVufpnFDNOxu+M2E0RiOaPEoZXLmeCqtj2fCTXrDKPE5P0fmCGcXYwSmy9vAxvM
 JqApsf3PfzBbREBaov3qJLAOZoHrQLN+X2QHSQgLhEg8/HWPFcRmEVCVmLtjHSOIzStgJbHw
 xXQmiEPkJbZ++wRWwylgLbGl9zZUjaDEyZlPwBYwA9U0b53NDGFLSBx88QLsIgmBZewS554v
 YYEY5CJx7s5cqO+EJV4d38IOYctInJ7cwwLR0M0o0ffhK1T3DEaJ6cu+s3UxcgA51hJ9Z3Ig
 GhwlmrZPZoQI80nceCsIsZhPYtK26cwQYV6JjjYhiGo1iR1NWxknMCrPQnL2LCRnz0Jy9gJG
 5lWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiByeX0v+OfdjB+vZR0iFGAg1GJh9ch7Xes
 EGtiWXFl7iFGCQ5mJRHe2x0/Y4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5Ykpqd
 mlqQWgSTZeLglGpg9F/rwl/761tQrE/EmS+ld4+WbZjOKsAVuMB/UfRzp/s63KeOBfx5aCdy
 LkbvyZN1lz+F//7A/ve/uPQX+1wdlRVR7HOe3WZacnX7yn2VZg9FuF+mPHdb7PhZfOusOwnr
 xX7bf1j56OaOzGXcJ06fuBWhJx69mfvfPr+zfjlNms9VtVRPq7urSiixFGckGmoxFxUnAgD7
 zxYhKgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7oTyn7HGtx8Y2yxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MtYs3k7S8EE0YrJEzUa
 GB/zdjFyckgImEjs7rjN1MXIxSEksJRR4tmtr4wQCRmJT1c+skPYwhJ/rnWxQRR9ZJS4OquX
 CSQhJHCGUWJmuzNEYhejxKF9h8A62AQ0Jbb/+c8CYosISEu0X53EClLELHAdqOj3RbAiYYEg
 iUvXL4HZLAKqEnN3rANbzStgJbHwxXQmiNXyElu/fWIFsTkFrCW29N5mhNhsJfH450cWiHpB
 iZMzn4DZzED1zVtnM0PYEhIHX7xgnsAoPAtJ2SwkZbOQlC1gZF7FKJJaWpybnltsqFecmFtc
 mpeul5yfu4kRGGHbjv3cvIPx0sbgQ4wCHIxKPLwvk3/HCrEmlhVX5h5ilOBgVhLhvd3xM1aI
 NyWxsiq1KD++qDQntfgQoynQcxOZpUST84HRn1cSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
 sSQ1OzW1ILUIpo+Jg1OqgTFTzeWOe6CAVC370wq+3YJ98YcfxG9xSVvPuS78Xcmvh7dLGZkM
 /Yp+LN7xvqZtfX3p6sAl2rPV/0U9zOgtNGu4djL5dJPNxik/WLtWn167ap2C+luOtIg5ZdmC
 /9im8kcYCndFSO9zPH1zT2t33iaTuWmbc+ovPmfsLGuX35gQcDH83+71l5RYijMSDbWYi4oT
 AciTnFjGAgAA
X-CMS-MailID: 20191219130936eucas1p22abefb644922c11e79b3ebe32d565e57
X-Msg-Generator: CA
X-RootMTR: 20191219130936eucas1p22abefb644922c11e79b3ebe32d565e57
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130936eucas1p22abefb644922c11e79b3ebe32d565e57
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130936eucas1p22abefb644922c11e79b3ebe32d565e57@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 210.118.77.11
X-Mailman-Approved-At: Thu, 19 Dec 2019 08:56:47 -0500
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not used by the device model but added for completeness. See NVM Express
1.2.1, Section 5.11 ("Identify command"), Figure 90 and Figure 93.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 include/block/nvme.h | 48 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 8fb941c6537c..d2f65e8fe496 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -543,7 +543,13 @@ typedef struct NvmeIdCtrl {
     uint8_t     ieee[3];
     uint8_t     cmic;
     uint8_t     mdts;
-    uint8_t     rsvd255[178];
+    uint16_t    cntlid;
+    uint32_t    ver;
+    uint32_t    rtd3r;
+    uint32_t    rtd3e;
+    uint32_t    oaes;
+    uint32_t    ctratt;
+    uint8_t     rsvd100[156];
     uint16_t    oacs;
     uint8_t     acl;
     uint8_t     aerl;
@@ -551,10 +557,22 @@ typedef struct NvmeIdCtrl {
     uint8_t     lpa;
     uint8_t     elpe;
     uint8_t     npss;
-    uint8_t     rsvd511[248];
+    uint8_t     avscc;
+    uint8_t     apsta;
+    uint16_t    wctemp;
+    uint16_t    cctemp;
+    uint16_t    mtfa;
+    uint32_t    hmpre;
+    uint32_t    hmmin;
+    uint8_t     tnvmcap[16];
+    uint8_t     unvmcap[16];
+    uint32_t    rpmbs;
+    uint8_t     rsvd316[4];
+    uint16_t    kas;
+    uint8_t     rsvd322[190];
     uint8_t     sqes;
     uint8_t     cqes;
-    uint16_t    rsvd515;
+    uint16_t    maxcmd;
     uint32_t    nn;
     uint16_t    oncs;
     uint16_t    fuses;
@@ -562,8 +580,14 @@ typedef struct NvmeIdCtrl {
     uint8_t     vwc;
     uint16_t    awun;
     uint16_t    awupf;
-    uint8_t     rsvd703[174];
-    uint8_t     rsvd2047[1344];
+    uint8_t     nvscc;
+    uint8_t     rsvd531;
+    uint16_t    acwu;
+    uint8_t     rsvd534[2];
+    uint32_t    sgls;
+    uint8_t     rsvd540[228];
+    uint8_t     subnqn[256];
+    uint8_t     rsvd1024[1024];
     NvmePSD     psd[32];
     uint8_t     vs[1024];
 } NvmeIdCtrl;
@@ -653,13 +677,21 @@ typedef struct NvmeIdNs {
     uint8_t     mc;
     uint8_t     dpc;
     uint8_t     dps;
-
     uint8_t     nmic;
     uint8_t     rescap;
     uint8_t     fpi;
     uint8_t     dlfeat;
-
-    uint8_t     res34[94];
+    uint8_t     rsvd33;
+    uint16_t    nawun;
+    uint16_t    nawupf;
+    uint16_t    nabsn;
+    uint16_t    nabo;
+    uint16_t    nabspf;
+    uint8_t     rsvd46[2];
+    uint8_t     nvmcap[16];
+    uint8_t     rsvd64[40];
+    uint8_t     nguid[16];
+    uint64_t    eui64;
     NvmeLBAF    lbaf[16];
     uint8_t     res192[192];
     uint8_t     vs[3712];
--=20
2.24.1


