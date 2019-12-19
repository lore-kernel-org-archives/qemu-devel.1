Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B00C2D0D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1155121D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MA/VnLVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1155121D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwOF-0003Qx-Ib
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZ5-0001pV-2R
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYy-000791-Lu
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:59 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYx-0006R1-IF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:55 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130943euoutp02c5fc9efa12bc54beea5e4982ae62fb0e~hx8LDq5Zl0700607006euoutp02J
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130943euoutp02c5fc9efa12bc54beea5e4982ae62fb0e~hx8LDq5Zl0700607006euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760983;
 bh=MYU0OwqRdBbZsZZBA9ne4go+tCBRq+fqhlYs60wTftk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=MA/VnLVytPZngiUXP0QdSOxa4sOTXdH5EQYBs/SuzgnIvr/RxG2rF9mzJMC9cCcSX
 O06/rSHERq99tTL/PuKyqN2L4AF0pXLarrjszwx1fHZjmqWG/JMUWBFyGEM+x9Ocm4
 a4+HnZFI8BCvsJwMVoJK2uljShRfft27IEbVEwx4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130943eucas1p2277b5f0cf4b1ef6202665a0784193e2c~hx8K4UXYf0340903409eucas1p2H;
 Thu, 19 Dec 2019 13:09:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 08.5F.60698.7967BFD5; Thu, 19
 Dec 2019 13:09:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130943eucas1p1dd4a7fd7ff94ee679832838b5d61f611~hx8KkI3kI1459314593eucas1p1I;
 Thu, 19 Dec 2019 13:09:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130943eusmtrp26fd19e5c83ddcfc37081256834eabc03~hx8KjjOQq3097130971eusmtrp2Y;
 Thu, 19 Dec 2019 13:09:43 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-66-5dfb7697e055
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 67.4D.08375.7967BFD5; Thu, 19
 Dec 2019 13:09:43 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130943eusmtip2330261d2858ca61cf9da4c1444901be9~hx8KWRBJv3240732407eusmtip22;
 Thu, 19 Dec 2019 13:09:43 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:42 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:41 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 13/24] nvme: additional tracing
Date: Thu, 19 Dec 2019 14:09:10 +0100
Message-ID: <20191219130921.309264-14-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7rTy37HGrzboGyxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ4rJJSc3JLEst
 0rdL4Mp49OQ4U0GrbMW17ztYGxh3SXQxcnJICJhIHLy4n7WLkYtDSGAFo8TLfxOYQBJCAl8Y
 JQ7v8IFIfGaUWP+ihQWm496uvWwQieWMEssvHWCCq3r1/C8LhHOGUWLz0a9sELN2MUqs/F0I
 YrMJaEps//MfbJSIgLRE+9VJYMuZBa4zShz6fZEdJCEsYCTx5OxuZhCbRUBV4sThm4xdjBwc
 vALWEi+n1kCcIS+x9dsnVhCbEyi8pfc2I4jNKyAocXLmE7D5zEA1zVtnM0PYEhIHX7xgBtkl
 IbCOXWJ7/zKwmRICLhJrd4ZCzBSWeHV8CzuELSPxf+d8Joj6bkaJvg9foZpnMEpMX/adDaLZ
 WqLvTA5Eg6NEz4F+Fogwn8SNt4IQe/kkJm2bzgwR5pXoaBOCqFaT2NG0lXECo/IsJFfPQnL1
 LCRXL2BkXsUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYWE7/O/51B+O+P0mHGAU4GJV4
 eB3SfscKsSaWFVfmHmKU4GBWEuG93fEzVog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC
 6YklqdmpqQWpRTBZJg5OqQbG9JQbFhHybjIv5h0teqD0wtSOa1qn0TqmnEfBV09mVIbb1cZs
 vHH9wzbLA65h7Q0LJ9/+17DaPKhq5a1dgWV1uzd07lToCIpPiXfx+ZpmNYH7ZDX/nXWle0+t
 PnK6cLunlNak+Jb7EoIL98oc42CTNevi2r78/p/9BsKf+u5cnld1fKW16G52JZbijERDLeai
 4kQA7c4l/SgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xe7rTy37HGnTs5LPY3N/OaDHp0DVG
 iyUXUy3m3VK2mPWunc3ieO8OFgc2j02rOtk87lzbw+bx5NpmJo/3+66yBbBE6dkU5ZeWpCpk
 5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GU8enKcqaBVtuLa9x2s
 DYy7JLoYOTkkBEwk7u3ay9bFyMUhJLCUUaLt0wxmiISMxKcrH9khbGGJP9e6oIo+Mkp8vHGY
 GcI5wyixtG82K4Szi1Hi3pw5YC1sApoS2//8ZwGxRQSkJdqvTgIrYha4zihx6PdFsCJhASOJ
 J2d3g+1jEVCVOHH4JmMXIwcHr4C1xMupNRCr5SW2fvvECmJzAoW39N5mBLGFBKwkHv/8CDaf
 V0BQ4uTMJ2A2M1B989bZzBC2hMTBFy+YJzAKz0JSNgtJ2SwkZQsYmVcxiqSWFuem5xYb6hUn
 5haX5qXrJefnbmIExti2Yz8372C8tDH4EKMAB6MSD+/L5N+xQqyJZcWVuYcYJTiYlUR4b3f8
 jBXiTUmsrEotyo8vKs1JLT7EaAr020RmKdHkfGD855XEG5oamltYGpobmxubWSiJ83YIHIwR
 EkhPLEnNTk0tSC2C6WPi4JRqYGRK/dvU+aY9y7jvUMzcP+c/ejk4tzxfofT3fVnY/MO8eq7c
 JyRZciUcRblDT+/eGMMv+F5CTbt4Q/O9vVFz/PZcOH9Y8tDMw65Pv54xvTnv66kpDyZcMv8p
 w3Y1fcWuELP1spcWcn5r9jbK/sljpqaZ3RDXdEvDet118ZulRw8XLLHmb33X4arEUpyRaKjF
 XFScCADxnUl4xwIAAA==
X-CMS-MailID: 20191219130943eucas1p1dd4a7fd7ff94ee679832838b5d61f611
X-Msg-Generator: CA
X-RootMTR: 20191219130943eucas1p1dd4a7fd7ff94ee679832838b5d61f611
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130943eucas1p1dd4a7fd7ff94ee679832838b5d61f611
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130943eucas1p1dd4a7fd7ff94ee679832838b5d61f611@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 210.118.77.12
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

Add a trace call for nvme_enqueue_req_completion.

Also, streamline nvme_identify_ns and nvme_identify_ns_list. They do not
need to repeat the command, it is already in the trace name.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 8 +++++---
 hw/block/trace-events | 5 +++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3d870ac55984..fbf6a52c7103 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -318,6 +318,8 @@ static void nvme_post_cqes(void *opaque)
 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req=
)
 {
     assert(cq->cqid =3D=3D req->sq->cqid);
+    trace_nvme_dev_enqueue_req_completion(nvme_cid(req), cq->cqid,
+        req->status);
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
@@ -893,7 +895,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIde=
ntify *c)
         prp1, prp2);
 }
=20
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
 {
     static const int data_len =3D 4 * KiB;
     uint32_t min_nsid =3D le32_to_cpu(c->nsid);
@@ -903,7 +905,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nvm=
eIdentify *c)
     uint16_t ret;
     int i, j =3D 0;
=20
-    trace_nvme_dev_identify_nslist(min_nsid);
+    trace_nvme_dev_identify_ns_list(min_nsid);
=20
     list =3D g_malloc0(data_len);
     for (i =3D 0; i < n->num_namespaces; i++) {
@@ -930,7 +932,7 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *c=
md)
     case 0x01:
         return nvme_identify_ctrl(n, c);
     case 0x02:
-        return nvme_identify_nslist(n, c);
+        return nvme_identify_ns_list(n, c);
     default:
         trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 4cf39961989d..f982ec1a3221 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -39,8 +39,8 @@ nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16=
_t vector, uint16_t size,
 nvme_dev_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16=
""
 nvme_dev_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu1=
6""
 nvme_dev_identify_ctrl(void) "identify controller"
-nvme_dev_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
-nvme_dev_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%=
"PRIu16""
+nvme_dev_identify_ns(uint32_t ns) "nsid %"PRIu32""
+nvme_dev_identify_ns_list(uint32_t ns) "nsid %"PRIu32""
 nvme_dev_getfeat(uint16_t cid, uint32_t fid) "cid %"PRIu16" fid 0x%"PRIx=
32""
 nvme_dev_setfeat(uint16_t cid, uint32_t fid, uint32_t val) "cid %"PRIu16=
" fid 0x%"PRIx32" val 0x%"PRIx32""
 nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write=
 cache, result=3D%s"
@@ -54,6 +54,7 @@ nvme_dev_aer(uint16_t cid) "cid %"PRIu16""
 nvme_dev_aer_aerl_exceeded(void) "aerl exceeded"
 nvme_dev_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x=
%"PRIx8""
 nvme_dev_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type=
 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_dev_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t st=
atus) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
 nvme_dev_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "typ=
e 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
 nvme_dev_enqueue_event_noqueue(int queued) "queued %d"
 nvme_dev_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
--=20
2.24.1


