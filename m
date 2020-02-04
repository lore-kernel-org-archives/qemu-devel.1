Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A55C3F68F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E406217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CeW/VlgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E406217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuto-0005zK-D3
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusY-0003qf-3T
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusW-000749-Rv
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:22 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35215)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusW-000733-MM
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:20 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095218euoutp01fb49ad508c4fc5212169cbacc876237e~wKkOHZpWZ3058130581euoutp01o
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095218euoutp01fb49ad508c4fc5212169cbacc876237e~wKkOHZpWZ3058130581euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809938;
 bh=CYzVWBRewW39DzSgniDwrmwdzmk/VOs1qnKbidWVVb0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=CeW/VlgP1Cb05anxt/C75QH6XwaiVin/S386B7XW8uVGUC7MAlbE4EpwRKMMKkwCQ
 70Co103FaGwvZZMaAZGN+VgZ8m1oCxflKGJ/BDiwozM36FVmD3/y/fP6nPw8muKkv2
 xejiSc4uQDdFt7rdGiKxMGxx1cQ4jSB5YNWj1as8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204095218eucas1p26b3377669f4f645274dd7e91380a572e~wKkN0A-sF1140011400eucas1p2m;
 Tue,  4 Feb 2020 09:52:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 96.EB.60679.2DE393E5; Tue,  4
 Feb 2020 09:52:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095218eucas1p25d4623d82b1b7db3e555f3b27ca19763~wKkNlR4hu1214112141eucas1p2j;
 Tue,  4 Feb 2020 09:52:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095218eusmtrp2f62677d74807585b0b9c1843426edd47~wKkNkrNoz0487104871eusmtrp2O;
 Tue,  4 Feb 2020 09:52:18 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-18-5e393ed23d57
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id FF.5A.07950.2DE393E5; Tue,  4
 Feb 2020 09:52:18 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095218eusmtip1c634f8efeae4084202802300016b644a~wKkNfA5Fq2623026230eusmtip1g;
 Tue,  4 Feb 2020 09:52:18 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:17 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:17 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 04/26] nvme: add missing fields in the identify data
 structures
Date: Tue, 4 Feb 2020 10:51:46 +0100
Message-ID: <20200204095208.269131-5-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3a3u+tqcp2WBw2kGWJKWlpwzZCCkBF+COyTkLXyMiU3ZVct
 7YMvmcvF1PyQNnOaSdasIE2bS2ZKOEXbfMEhFmUoMa10oZbhy3J7LPx2zv/8/s/5H3goQvJQ
 EERlqHJYtUqeKSVF/M7+P7bDYwlxqUcsZfuY9koNYnp6fwmY6j4HYppHWcYwFcroFzQkY9WZ
 +KeEMpvJLpS1GctJ2UdHNymbdbTzZIuWCfKcIEV0Mo3NzMhj1dEJl0TpVSONguyqvdeLmwYE
 RWhGrEU+FNDHYKl/jqdFIkpCP0HQ2jJK4mYZwbeVRQI3SwimW9f4WkR5LW83IrHegmB+3IX+
 Q8YRzbZjCEGDfYmPmy4EzkkLz7ORpA/B63U331MH0MGgmagWeCCCXkNQX3yX9Az86fOwWrPu
 hfj0QfjU2eLVxfQJKF4wC3D0EKgrHvLqPnQ89BgHeJjxg8H7s14vscXc7KgjcA3Q63R64wFt
 FsLniTYhPugMmHUMftMf5q2vhLjeD+6uBh7m7yCocK1sm2sR1Dz+TWJzPFQMZ2LDaXjzVcfD
 si9M/vDDe32hurOGwLIYbpdJMB0GppIOVIVC9TtS63ek1u9I3YgIIwpkczmlguViVOy1KE6u
 5HJViqgrWco2tPVxhjatyyZkXr/ch2gKSfeIB98zqRKBPI/LV/YhoAhpgNgeHZcqEafJ8wtY
 ddZFdW4my/WhYIovDRTHNs1dkNAKeQ57lWWzWfW/KY/yCSpC9aKkGuO9tfAIrVt5XBGiHS4f
 fdArL7A1SAYfdfeajDzdWLhLGvnyafKXjUJr+lRPbZLjhW0RvdtdWbZrzvazkGv7cNanMvHA
 92fSmOTyzfHpeMI1m1JSkS6+MeMclYaVmizxt6hEg8E9pcywp6y6Dc2rXGlw7fzzEhEXa5Ly
 uXT50QhCzcn/AiwiK080AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7qX7CzjDFbP4LDY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GRMu
 LGAtmCBa0bjoBGsD42PeLkYODgkBE4kDf7W7GDk5hASWMkq8aQkBsSUEZCQ+XfnIDmELS/y5
 1sXWxcgFVPORUaJrx2tGiIbTjBIbdmdCJHYySsyavpwZJMEmoCmx/c9/FhBbREBaov3qJFYQ
 m1ngN6PEn75AEFtYIEji1MzjTCA2i4CKxL1ty9lAbF4BK4nGd7tYITbLS8xuPA0W5xSwlti/
 6gQTyNFCQDWtR7khygUlTs58wgIxXl6ieetsZghbQuLgixfMExiFZyEpm4WkbBaSsgWMzKsY
 RVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC423bsZ9bdjB2vQs+xCjAwajEw6vhaBEnxJpYVlyZ
 e4hRgoNZSYT3vL5lnBBvSmJlVWpRfnxRaU5q8SFGU6DfJjJLiSbnA1NBXkm8oamhuYWlobmx
 ubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxiNserap6t1XHC1ePDTi9N3A3B/CKBpV
 e6fDompat9PZD78E/L7elrx/sHni83aewA4n/biwJdc1vwhWfXb9M5WVRVn1rJFdbGdnycRe
 fxEey0Mu4kuOmLe4rY/Ttbat4tdSeBcb62OwxvjY/kmPj5R1bz8yq9+04knFBcl+rs07Yidf
 /z9XiaU4I9FQi7moOBEA4lYZjs0CAAA=
X-CMS-MailID: 20200204095218eucas1p25d4623d82b1b7db3e555f3b27ca19763
X-Msg-Generator: CA
X-RootMTR: 20200204095218eucas1p25d4623d82b1b7db3e555f3b27ca19763
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095218eucas1p25d4623d82b1b7db3e555f3b27ca19763
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095218eucas1p25d4623d82b1b7db3e555f3b27ca19763@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
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
2.25.0


