Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1437EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AFC2192A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MsID3NKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AFC2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv4p-0002g0-0q
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyut0-000526-7v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusy-00083x-K7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:50 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39481)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusy-0007gA-CB
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:48 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095232euoutp02b09c369a2d88b35fbae16c6237d76693~wKkbAR99g2956329563euoutp02E
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204095232euoutp02b09c369a2d88b35fbae16c6237d76693~wKkbAR99g2956329563euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809952;
 bh=UHyRgGcdfxNxRNM+e3WJB+b2SU2Tw2zJU+IRLaeWK7A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=MsID3NKo9BBb/AZyrfHoxktBu8o37Go473sl2GHCn5pnBnCFPMqULgs1iXw136zMA
 ikPhgcShb7g4qk4A2YN0mMnDVPeKJR4HZ6M3oPVWxvpSe6sKgrry6S+q+3Zi3LwNAn
 wPe9Gx6k5DtLwg8Oet7tFlPbmKsgn3wCdEJgJIoA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095232eucas1p10990561767309f9eedad100b7a24041b~wKka4GTAK0251202512eucas1p1i;
 Tue,  4 Feb 2020 09:52:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id B3.FB.60679.0EE393E5; Tue,  4
 Feb 2020 09:52:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095232eucas1p2b3264104447a42882f10edb06608ece5~wKkar-QQ32190021900eucas1p2N;
 Tue,  4 Feb 2020 09:52:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095232eusmtrp2d713ad9c9b74d82bd40093ccbe55ea70~wKkarb9Jp0489204892eusmtrp2a;
 Tue,  4 Feb 2020 09:52:32 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-52-5e393ee0bfee
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id E4.7A.07950.0EE393E5; Tue,  4
 Feb 2020 09:52:32 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095232eusmtip1766203f00e06353569cad65dfe871556~wKkalPGSl3103231032eusmtip1q;
 Tue,  4 Feb 2020 09:52:32 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:31 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:31 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 26/26] nvme: make lba data size configurable
Date: Tue, 4 Feb 2020 10:52:08 +0100
Message-ID: <20200204095208.269131-27-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7oP7CzjDJZfkbDY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGb3nrjEXHOOtOD1jBmMD4weuLkZODgkBE4n9058ydTFycQgJrGCU
 2LJ1NSOE84VRYuqcb2wQzmdGie6W10wwLQ1n2lkhEssZJb59v8gEVzX95Q92COc0o0TzqbtQ
 zk5GiefPD7OA9LMJaEps//MfzBYRkJZovzoJbBazwG9GibmNE9lAEsIC9hIbP+wHOoWDg0VA
 ReL//xCQMK+AtcT/2S3sEHfIS8xuPA1WzgkU37/qBBNEjaDEyZlPwOYzA9U0b53NDGFLSBx8
 8YIZZJeEwC52iYafPSwQg1wkJm9ZxQhhC0u8Or4FaoGMxP+d85kgGroZJfo+fIXqngH06LLv
 bCDXSQCt7juTA9HgKHHh+CVWiDCfxI23ghCL+SQmbZvODBHmlehoE4KoVpPY0bSVcQKj8iwk
 Z89CcvYsJGcvYGRexSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZhyTv87/mUH464/SYcY
 BTgYlXh4T561iBNiTSwrrsw9xCjBwawkwnte3zJOiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/x
 opexQgLpiSWp2ampBalFMFkmDk6pBsb2jsbQniWXb58wePQ+IVOvw8ZffVFA8Ua2U3GaRkzi
 nEeuMHUkfb3K5jeFq/dG5YqvczolO5JX2hxJn7Zi8r7zLhOVWCNv+rnNP3RSiGMZe9PEX41b
 Fj6cFONWva2/INDl6CO1W63xB59zS232q+sUnyvZwL/qzybnVRvmm7iU7X85sfFa2l0lluKM
 REMt5qLiRAAmxG2lNQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7oP7CzjDHa/5bbY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gb3n
 rjEXHOOtOD1jBmMD4weuLkZODgkBE4mGM+2sXYxcHEICSxklVn5awASRkJH4dOUjO4QtLPHn
 WhcbRNFHRomtzd0sEM5pRonfHdcZQaqEBHYySly5ZwdiswloSmz/858FxBYRkJZovzqJFcRm
 FvjNKPGnLxDEFhawl9j4YT9QLwcHi4CKxP//ISBhXgFrif+zW6AWy0vMbjzNBmJzAsX3rzrB
 BFIuJGAl0XqUG6JcUOLkzCcsENPlJZq3zmaGsCUkDr54wTyBUXgWkrJZSMpmISlbwMi8ilEk
 tbQ4Nz232EivODG3uDQvXS85P3cTIzDith37uWUHY9e74EOMAhyMSjy8Go4WcUKsiWXFlbmH
 GCU4mJVEeM/rW8YJ8aYkVlalFuXHF5XmpBYfYjQFem0is5Rocj4wGeSVxBuaGppbWBqaG5sb
 m1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamC0qUlwF9v0MOm2ctx1ftkKNbGeZUzv9Etj
 LimVpN02e/N18gRdgzt79vht7RHqKvC4e73u5nrb5tbKvZ0H9vDXhzCufPbd8cYNdadzRY0f
 ur2Y/ZQPf/zys3/XjSr2A0e9Sue/XS3SY/c0Zdodv1WcDdViC0MnWdRsMd8yJdPf8ezPJ9+z
 14orsRRnJBpqMRcVJwIABJ2T+M4CAAA=
X-CMS-MailID: 20200204095232eucas1p2b3264104447a42882f10edb06608ece5
X-Msg-Generator: CA
X-RootMTR: 20200204095232eucas1p2b3264104447a42882f10edb06608ece5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095232eucas1p2b3264104447a42882f10edb06608ece5
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095232eucas1p2b3264104447a42882f10edb06608ece5@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.c | 2 +-
 hw/block/nvme-ns.h | 4 +++-
 hw/block/nvme.c    | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 0e5be44486f4..981d7101b8f2 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -18,7 +18,7 @@ static int nvme_ns_init(NvmeNamespace *ns)
 {
     NvmeIdNs *id_ns =3D &ns->id_ns;
=20
-    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
+    id_ns->lbaf[0].ds =3D ns->params.lbads;
     id_ns->nuse =3D id_ns->ncap =3D id_ns->nsze =3D
         cpu_to_le64(nvme_ns_nlbas(ns));
=20
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index b564bac25f6d..f1fe4db78b41 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -7,10 +7,12 @@
=20
 #define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
     DEFINE_PROP_DRIVE("drive", _state, blk), \
-    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
+    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0), \
+    DEFINE_PROP_UINT8("lbads", _state, _props.lbads, BDRV_SECTOR_BITS)
=20
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
+    uint8_t  lbads;
 } NvmeNamespaceParams;
=20
 typedef struct NvmeNamespace {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 5fe2e2fe1fa9..67cd8d9d65fe 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2598,6 +2598,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     if (n->namespace.blk) {
         ns =3D &n->namespace;
         ns->params.nsid =3D 1;
+        ns->params.lbads =3D BDRV_SECTOR_BITS;
=20
         if (nvme_ns_setup(n, ns, &local_err)) {
             error_propagate_prepend(errp, local_err, "nvme_ns_setup: ");
--=20
2.25.0


