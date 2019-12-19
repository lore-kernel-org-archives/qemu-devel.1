Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A132AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B44C21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tTY0xOrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B44C21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwQn-0006tK-VS
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZ4-0001op-FO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYz-0007Bq-AD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:00 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYy-0006TS-9G
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:56 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130944euoutp01a4996be70cd208bfb2800b06bab4c489~hx8L3O_CE1365313653euoutp01u
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20191219130944euoutp01a4996be70cd208bfb2800b06bab4c489~hx8L3O_CE1365313653euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760984;
 bh=TwQqS06Dok4+bJ9ce/50NwsiOMqeoqY3Hk/wQTL1iTg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=tTY0xOrMsaSAF6Fpv+qnwAHne2DHgYXWV/k8ujBiVv3K+NleSwSVYIP9jS4kfxd8O
 Uq/420vlK9Lw/W4bRTKXU6THZy0fTbpwB+jWwvcdW2xkAGN1b2O7KIImGhGQPZs8ac
 giE/bt435ZvO9VtNDqFBZrtu2kc07QeM//S4XjE0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130944eucas1p24a5806578e98fa43d0316bce20ed9a9c~hx8LmRu2f2199221992eucas1p2L;
 Thu, 19 Dec 2019 13:09:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 0D.FF.61286.8967BFD5; Thu, 19
 Dec 2019 13:09:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130944eucas1p2090d2b62171699cd0aa44df8e9f98727~hx8LRoBFX0341303413eucas1p21;
 Thu, 19 Dec 2019 13:09:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130944eusmtrp2b1439aacf4540a53bffa414d0d3ff4eb~hx8LRAsZY3120131201eusmtrp2B;
 Thu, 19 Dec 2019 13:09:43 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-66-5dfb7698b468
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 3A.BE.07950.7967BFD5; Thu, 19
 Dec 2019 13:09:43 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130943eusmtip1b597b63fa1c8b228670ce63c5b7a5855~hx8LAmvK92084020840eusmtip17;
 Thu, 19 Dec 2019 13:09:43 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:43 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:42 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 14/24] nvme: make sure ncqr and nsqr is valid
Date: Thu, 19 Dec 2019 14:09:11 +0100
Message-ID: <20191219130921.309264-15-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7ozyn7HGuydKWGxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ4rJJSc3JLEst
 0rdL4Mp4/zS74BdbxZTnHA2M81i7GDk5JARMJCYf+sHWxcjFISSwglHi6aVuZgjnC6PE35m/
 2UGqhAQ+M0q0fXGC6Zi99RM7RNFyRompR59AOUBFe+dPZYJwzjBKbFx5A2rWLkaJm8u+MIL0
 swloSmz/858FxBYRkJZovzqJFaSIWeA6o8Sh3xfBFgoLOEhMOzsd7EQWAVWJA9+vMIPYvALW
 Ei+X3mWEOEReYuu3T2A1nEDxLb23GSFqBCVOznwCtoAZqKZ562xmCFtC4uCLF2AXSQisYpdY
 23+BHWKQi8ScWa+ZIWxhiVfHt0DFZST+75zPBNHQzSjR9+ErVPcMRonpy74DQ40DyLGW6DuT
 A9HgKHH+20d2iDCfxI23ghCL+SQmbZvODBHmlehoE4KoVpPY0bSVcQKj8iwkZ89CcvYsJGcv
 YGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZhaTv87/mkH49dLSYcYBTgYlXh4HdJ+
 xwqxJpYVV+YeYpTgYFYS4b3d8TNWiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp
 2ampBalFMFkmDk6pBsZILvloJ+HuFufHK4/KClXE71nU9vCr8LEPAjmXT02RbXtfPX3+olsz
 11w7FeU3cV7tp1ITpyvcep5prvcbtY8Ev8uYotv+y+/ArKV7egKnts2/EXTokCx3w2xXhUOM
 h6MLpdiid15d795z2kBCuHjqF6/VT/xq5rBobl3lN794WucRVrdLt1OVWIozEg21mIuKEwGi
 C2+tKQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xu7rTy37HGsz/Y2axub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt4/zS74BdbxZTnHA2M
 81i7GDk5JARMJGZv/cTexcjFISSwlFFi45SPTBAJGYlPVz6yQ9jCEn+udbFBFH1klDj94RYz
 SEJI4AyjxKQFnBCJXYwS+7asBOtmE9CU2P7nPwuILSIgLdF+dRIrSBGzwHVGiUO/L4KNFRZw
 kJh2djrYHSwCqhIHvl8Bm8orYC3xculdRojV8hJbv30Cq+EEim/pvc0IsdlK4vHPjywQ9YIS
 J2c+AbOZgeqbt85mhrAlJA6+eME8gVF4FpKyWUjKZiEpW8DIvIpRJLW0ODc9t9hIrzgxt7g0
 L10vOT93EyMwvrYd+7llB2PXu+BDjAIcjEo8vA5pv2OFWBPLiitzDzFKcDArifDe7vgZK8Sb
 klhZlVqUH19UmpNafIjRFOi5icxSosn5wNjPK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5Y
 kpqdmlqQWgTTx8TBKdXAyB615Ovfy/xRK9LSzFziFx7v3nV7stKkRKbvzQIblNdtcZM8Nn/u
 OVmRCfWN5evrf31h3z0/8SvnvGsWCszXD9h/XsJjlfJWQyHlmXHIi2TNy/6z7OPmrOj7sWRp
 tEy62saXT1rmb+gt+F+Sd8km8eNj28tzX6/9FVg21dax/PrU6WHnNTfWeCuxFGckGmoxFxUn
 AgBaAQLNxQIAAA==
X-CMS-MailID: 20191219130944eucas1p2090d2b62171699cd0aa44df8e9f98727
X-Msg-Generator: CA
X-RootMTR: 20191219130944eucas1p2090d2b62171699cd0aa44df8e9f98727
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130944eucas1p2090d2b62171699cd0aa44df8e9f98727
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130944eucas1p2090d2b62171699cd0aa44df8e9f98727@eucas1p2.samsung.com>
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

0xffff is not an allowed value for NCQR and NSQR in Set Features on
Number of Queues.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fbf6a52c7103..040dec234714 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1131,6 +1131,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
+        if ((dw11 & 0xffff) =3D=3D 0xffff || ((dw11 >> 16) & 0xffff) =3D=
=3D 0xffff) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
         trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
             ((dw11 >> 16) & 0xFFFF) + 1, n->params.num_queues - 1,
             n->params.num_queues - 1);
--=20
2.24.1


