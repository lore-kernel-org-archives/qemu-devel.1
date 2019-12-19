Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8844CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56077206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IV+HsRqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56077206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwSf-0001ON-SE
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYm-0001TQ-R9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYj-0006Jy-Rh
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYj-0006Fe-9z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:41 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130939euoutp0133952596f82501bf1f18008d2465205a~hx8HPkHna1327713277euoutp01y
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20191219130939euoutp0133952596f82501bf1f18008d2465205a~hx8HPkHna1327713277euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760979;
 bh=FJgBsP4niZXtmHBkIg8Zp3iXBAnhFys7NaMTVC75fyo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=IV+HsRqktv96pdYovhSyVl7w5hmJ30CyGYEp8ecekZysoy2zX4stmFfe82LLjXdEr
 iBcJ+gZrMkSIek7UaGEJNRAa47RqoazGnZjCT2auFAhQCy/NigyQJjxa2kKEu4TqGa
 RoXU/hxk8DbqQ7xDiM9YRk6jES+86+amQHt2heB8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130939eucas1p24c6bf9e85fd1819348fc7d7f1cf2f099~hx8HHSpOZ0341303413eucas1p2v;
 Thu, 19 Dec 2019 13:09:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id D4.05.60679.3967BFD5; Thu, 19
 Dec 2019 13:09:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130939eucas1p2234cbe31c7a027e6ccf1b4ceafd19c30~hx8Gpv6A_1986019860eucas1p2E;
 Thu, 19 Dec 2019 13:09:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130939eusmtrp238a61a1eb3309aa5fe1afc41ddaa2a3a~hx8GpKdQf3097130971eusmtrp2-;
 Thu, 19 Dec 2019 13:09:39 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-d1-5dfb76938fa2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id D2.4D.08375.3967BFD5; Thu, 19
 Dec 2019 13:09:39 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130939eusmtip250063af71795420badab1320ab0ca1cd~hx8GjFXZk2680126801eusmtip2Q;
 Thu, 19 Dec 2019 13:09:39 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:38 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:37 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 07/24] nvme: add support for the abort command
Date: Thu, 19 Dec 2019 14:09:04 +0100
Message-ID: <20191219130921.309264-8-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRD16263S2PL0pIwAaOmKEYM4BVThagkHjX6w98mRVZYgdgW0uUQ
 f3Ek5RKQArbWM3iAEDWcVgImVKQKhIpKIXKYYFGEKETuFEW2i4Z/M/Pem3kzGRKTmYT+ZIIu
 mdHraI2CEONNHUs9IaWpbvXuBds2ZX1xDlIabU6kfNDLKO98ClRafuYQSnuhFT9KqOqq8wjV
 kLOFULmc9QLV1Ms+4ix+ThwRy2gSUhl92OFocbyjpEeUNCO/nPXEjGWgCu98RJJA7YesmuB8
 JCZlVBUCy+RdAZ/MInD0XhfyyQyCkbJ2PB95eRTDAwaCByoRXJ11YP9Zj2unBRxLRnUjmOcU
 HNCMoHPxFcYBBLUTni+veFr5UgGQ02f0zMCofgQ2d6+IA+RUJNR/7vB0wqnt0O8yecQS6hBM
 3bILeB9boHH+l5CLvahwaCgcRDzHB97ecHkGYKuc7MabGB8DtI2Pe6wCVS2C3LFJxDc6BubW
 ubXl5DBhbxDx8SZYecGfA6gCBEXTc2tqMwLTowWCP2A4FHVreEEkdNlHcL4shYEfPvxgKRib
 uAW4sgRyDTKeHQTWrEZ0DQVa1tm2rLNtWWf7HsKqkR+TwmrjGHavjkkLZWktm6KLC41J1Nah
 1Xfp+mOftaLm5Qs2RJFIsVEyHuNWy4R0KpuutSEgMYWvZDB3SS2TxNLpVxh94nl9ioZhbSiA
 xBV+kn0V39UyKo5OZi4xTBKj/4cKSC//DJR9ZPTbw7Z3hrFYA7OhNPJ3+bBf9nH9QcNCa8+A
 3BjdeTtKdcoME3RNxeQH76XKE2f05ZkG6a7Xb2rCIu5by6UXd7z3L9Bu/jiUnkSqw4pPdiy6
 MkuqnAGqqebagtKWvFHd1wxdQlZQmUHrmDn99EvIimnoAOHTvjXKXfVsmU1T4Gw8vScY07P0
 XxQ57bwqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7qTy37HGrxZy26xub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Ms4P/Ece8Fn4YqmtTOY
 GxgX8XcxcnJICJhI3L3RxtbFyMUhJLCUUeLGhC+sEAkZiU9XPrJD2MISf651sYHYQgIfGSV+
 zleHaDjDKNH88yozRGIXo8Sf9mAQm01AU2L7n/8sILaIgLRE+9VJrCANzALXGSUO/b4INlVY
 wFFi8/1jTCA2i4CqxPUn08EG8QpYSbyfc5wJYrO8xNZvn8Au4hSwltjSe5sRYpmVxOOfH1kg
 6gUlTs58AmYzA9U3b53NDGFLSBx88YJ5AqPwLCRls5CUzUJStoCReRWjSGppcW56brGhXnFi
 bnFpXrpecn7uJkZghG079nPzDsZLG4MPMQpwMCrx8L5M/h0rxJpYVlyZe4hRgoNZSYT3dsfP
 WCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OB0Z/Xkm8oamhuYWlobmxubGZhZI4b4fAwRgh
 gfTEktTs1NSC1CKYPiYOTqkGxtx1Bz9fD6y51js1b8+XiB9/eAIZ9k06GeMZsqlnu+FPkcoA
 16SWoxpS/u9+bzGT3ru28u408WcVLF+/vF9dfyXlbMsv8YeztfZPUN/46lhGcuVSL6fsMJW4
 o7XqOsVzTFqNXDic1/dNfdlWpLn7z6uvYlmv+nPmC+vvXj6vLfGWUn6eatAiDyWW4oxEQy3m
 ouJEAANtyzfGAgAA
X-CMS-MailID: 20191219130939eucas1p2234cbe31c7a027e6ccf1b4ceafd19c30
X-Msg-Generator: CA
X-RootMTR: 20191219130939eucas1p2234cbe31c7a027e6ccf1b4ceafd19c30
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130939eucas1p2234cbe31c7a027e6ccf1b4ceafd19c30
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130939eucas1p2234cbe31c7a027e6ccf1b4ceafd19c30@eucas1p2.samsung.com>
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

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.1 ("Abort command").

The Abort command is a best effort command; for now, the device always
fails to abort the given command.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a41ebf578f04..d41ea5beab08 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -731,6 +731,18 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *=
cmd)
     }
 }
=20
+static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    uint16_t sqid =3D le32_to_cpu(cmd->cdw10) & 0xffff;
+
+    req->cqe.result =3D 1;
+    if (nvme_check_sqid(n, sqid)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
 {
     trace_nvme_dev_setfeat_timestamp(ts);
@@ -848,6 +860,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         trace_nvme_dev_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
+
     return NVME_SUCCESS;
 }
=20
@@ -864,6 +877,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
         return nvme_create_cq(n, cmd);
     case NVME_ADM_CMD_IDENTIFY:
         return nvme_identify(n, cmd);
+    case NVME_ADM_CMD_ABORT:
+        return nvme_abort(n, cmd, req);
     case NVME_ADM_CMD_SET_FEATURES:
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
@@ -1377,6 +1392,19 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
     id->ieee[2] =3D 0xb3;
     id->ver =3D cpu_to_le32(NVME_SPEC_VER);
     id->oacs =3D cpu_to_le16(0);
+
+    /*
+     * Because the controller always completes the Abort command immedia=
tely,
+     * there can never be more than one concurrently executing Abort com=
mand,
+     * so this value is never used for anything. Note that there can eas=
ily be
+     * many Abort commands in the queues, but they are not considered
+     * "executing" until processed by nvme_abort.
+     *
+     * The specification recommends a value of 3 for Abort Command Limit=
 (four
+     * concurrently outstanding Abort commands), so lets use that though=
 it is
+     * inconsequential.
+     */
+    id->acl =3D 3;
     id->frmw =3D 7 << 1;
     id->lpa =3D 1 << 0;
     id->sqes =3D (0x6 << 4) | 0x6;
--=20
2.24.1


