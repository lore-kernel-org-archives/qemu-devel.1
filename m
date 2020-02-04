Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC79C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59851217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ssGUW1Uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59851217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuv6-0001FM-ET
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusd-0003wx-49
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusb-0007Cs-EL
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:26 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusb-0007Ad-8A
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:25 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095224euoutp02cbf3c3a2c0f11c3019ddc0a51bd2cad3~wKkTVZS1D2814728147euoutp02g
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204095224euoutp02cbf3c3a2c0f11c3019ddc0a51bd2cad3~wKkTVZS1D2814728147euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809944;
 bh=quJB2ET9bbzj9exQHBxGy9hli2rkimvX54Z5sqlRx0s=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=ssGUW1UhG6ijjQnh8hn8vUEwd9OrKl7O1NepFZkhIPskgRTjLNeIQFO4eMC/fTfTI
 shRs1thEHaKNUMrKG14ZdhD9YAPOKf49MKE5vgJeyWszVn5MPu6ipuZESq/81ZKGge
 QfAuBQBsGXTy5SQKJ6JOOJFwpP7MhClDNaIP8jfU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095224eucas1p125ddf42fc498747155adb8cdab9249be~wKkTO6UcX0922209222eucas1p12;
 Tue,  4 Feb 2020 09:52:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 53.EF.60698.8DE393E5; Tue,  4
 Feb 2020 09:52:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095223eucas1p2b24d674e4b201c13a5fffc6853520d9b~wKkS4nsRW0112201122eucas1p2T;
 Tue,  4 Feb 2020 09:52:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095223eusmtrp2ad9978840b130232b6e29dc31b5c2bc7~wKkS3-5vt0485704857eusmtrp2t;
 Tue,  4 Feb 2020 09:52:23 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-fb-5e393ed8bb93
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 65.CC.08375.7DE393E5; Tue,  4
 Feb 2020 09:52:23 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095223eusmtip27db01f1792eac4411d90af73575dceba~wKkSs00R02738327383eusmtip2R;
 Tue,  4 Feb 2020 09:52:23 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:23 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:22 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 13/26] nvme: additional tracing
Date: Tue, 4 Feb 2020 10:51:55 +0100
Message-ID: <20200204095208.269131-14-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7o37CzjDPpncVps7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1igum5TUnMyy1CJ9uwSujNYFsxgLWmUrun9NZWtg3CXRxcjJISFgIrFw7kGmLkYuDiGBFYwS
 f3/sZoFwvjBKnDq5E8r5zCjR0nqHGablz6vPjBCJ5YwSf/73MsJVfezqZoZwTjNKPHq/G6xF
 SGAno8SdnfwgNpuApsT2P/9ZQGwRAWmJ9quTWEEamAV+M0rMbZzIBpIQFjCSeHb8JTuIzSKg
 InHq33KwOK+AtcSd85dZIO6Ql5jdeBoszgkU37/qBBNEjaDEyZlPwGqYgWqat85mhrAlJA6+
 eAH1wzZ2iUOP7CFsF4lF93exQtjCEq+Ob2GHsGUk/u+cDw4aCYFuRom+D1+ZIZwZjBLTl30H
 2swB5FhL9J3JgWhwlJh48iozRJhP4sZbQYi9fBKTtk2HCvNKdLQJQVSrSexo2so4gVF5FpKr
 ZyG5ehaSqxcwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITDin/x3/uoNx35+kQ4wC
 HIxKPLwajhZxQqyJZcWVuYcYJTiYlUR4z+tbxgnxpiRWVqUW5ccXleakFh9ilOZgURLnNV70
 MlZIID2xJDU7NbUgtQgmy8TBKdXAmPag2M/gbxFHfUrWRY1v4p9tlT5MmzFBYHHrCqGjxVvk
 c32PRr4uTGh/eP0E5+sd8Q1tK8xCZ0985MJvaXxRS9y6MSBOKF7s+RYh08gUDYana67U2ria
 sQfcfVzHJSy8OGbOOcG+SzIekkaPXk3oebDNpOTh1Jt7tqzcuKiE/VDCG77dyrI7lViKMxIN
 tZiLihMB8na9RTQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7rX7SzjDLof6Fhs7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jNYF
 sxgLWmUrun9NZWtg3CXRxcjJISFgIvHn1WdGEFtIYCmjRNufaIi4jMSnKx/ZIWxhiT/Xutgg
 aj4ySmx4qdjFyAVkn2aUuLZsPRuEs5NRov3fbbAqNgFNie1//rOA2CIC0hLtVyexgtjMAr8Z
 Jf70BYLYwgJGEs+OvwTbwCKgInHq33KwXl4Ba4k75y+zQGyWl5jdeBoszgkU37/qBFMXIwfQ
 MiuJ1qPcEOWCEidnPmGBGC8v0bx1NjOELSFx8MUL5gmMwrOQlM1CUjYLSdkCRuZVjCKppcW5
 6bnFhnrFibnFpXnpesn5uZsYgRG37djPzTsYL20MPsQowMGoxMN7wc4iTog1say4MvcQowQH
 s5II73l9yzgh3pTEyqrUovz4otKc1OJDjKZAv01klhJNzgcmg7ySeENTQ3MLS0NzY3NjMwsl
 cd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYw+ab7J6aahr04wnUxc6nj13sdZbrWON2bMiRcw
 swmYsfdwMrNt8FkjmUtqM2rn+SqXBxgz7kmV/+9czT5RvojxkGMV52/D+X0v2MTe98zs1u84
 YDBp46nbT0Vnb7YtXL/o3sGYafv2Hbq2/ZlXet5jj66JTQt5JwY5yss2yKiL2Lz7Xy0XWqTE
 UpyRaKjFXFScCAA53K4IzgIAAA==
X-CMS-MailID: 20200204095223eucas1p2b24d674e4b201c13a5fffc6853520d9b
X-Msg-Generator: CA
X-RootMTR: 20200204095223eucas1p2b24d674e4b201c13a5fffc6853520d9b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095223eucas1p2b24d674e4b201c13a5fffc6853520d9b
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095223eucas1p2b24d674e4b201c13a5fffc6853520d9b@eucas1p2.samsung.com>
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

Add a trace call for nvme_enqueue_req_completion.

Also, streamline nvme_identify_ns and nvme_identify_ns_list. They do not
need to repeat the command, it is already in the trace name.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 8 +++++---
 hw/block/trace-events | 5 +++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3267ee2de47a..30c5b3e7a67d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -320,6 +320,8 @@ static void nvme_post_cqes(void *opaque)
 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req=
)
 {
     assert(cq->cqid =3D=3D req->sq->cqid);
+    trace_nvme_dev_enqueue_req_completion(nvme_cid(req), cq->cqid,
+        req->status);
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
@@ -895,7 +897,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIde=
ntify *c)
         prp1, prp2);
 }
=20
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
 {
     static const int data_len =3D 4 * KiB;
     uint32_t min_nsid =3D le32_to_cpu(c->nsid);
@@ -905,7 +907,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nvm=
eIdentify *c)
     uint16_t ret;
     int i, j =3D 0;
=20
-    trace_nvme_dev_identify_nslist(min_nsid);
+    trace_nvme_dev_identify_ns_list(min_nsid);
=20
     list =3D g_malloc0(data_len);
     for (i =3D 0; i < n->num_namespaces; i++) {
@@ -932,7 +934,7 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *c=
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
2.25.0


