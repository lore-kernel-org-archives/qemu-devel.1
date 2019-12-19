Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AC6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436A121D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MOA7ZV2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436A121D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwNM-0002ag-RD
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZ5-0001pY-2a
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYy-00077C-Jb
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:59 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47887)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYx-0006Os-9G
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130942euoutp0144d894a8cf8dcee690cbcf467a4ab36c~hx8KO5NBG1365113651euoutp01p
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20191219130942euoutp0144d894a8cf8dcee690cbcf467a4ab36c~hx8KO5NBG1365113651euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760983;
 bh=pTWeiVtEFseh5VQCbXF6daE/MyhWCFL3uAf2YIjweyk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=MOA7ZV2qw895rpRFoU85CbV2g8W7oCfrUT0gMtlZQD45FZhRhj6f7DfI3qjzfzpAa
 84LRKHRFz6ZAe7yemFl09QzZg6nwtMQWUJN1FKx1WCcYToQSA1H8Vk3AKE5C0tKdT3
 v2+UbvW+6QOGj48JSU3oMzYFhkd6gODOl1r2/vAE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20191219130942eucas1p17de62d1e59be2417e86d51e8260931fd~hx8KDVdQ_1798017980eucas1p10;
 Thu, 19 Dec 2019 13:09:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.FF.61286.6967BFD5; Thu, 19
 Dec 2019 13:09:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130942eucas1p1de5bbf57c675e3ea20cd0892e7e03c77~hx8J0Vz8L1177211772eucas1p1-;
 Thu, 19 Dec 2019 13:09:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130942eusmtrp266dfd29a681d33af81a7b43005614914~hx8Jz0lNn3097130971eusmtrp2T;
 Thu, 19 Dec 2019 13:09:42 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-60-5dfb76963ef8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 26.4D.08375.6967BFD5; Thu, 19
 Dec 2019 13:09:42 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130942eusmtip10ae42255147baeab46601e64b1489ab7~hx8Jnvq_22687626876eusmtip1K;
 Thu, 19 Dec 2019 13:09:42 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:41 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:41 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 12/24] nvme: add missing mandatory features
Date: Thu, 19 Dec 2019 14:09:09 +0100
Message-ID: <20191219130921.309264-13-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7rTyn7HGpw6pmexub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ4rJJSc3JLEst
 0rdL4Mq4dvQoS0GLccXZ66tYGxj/qHcxcnJICJhIXD/xnK2LkYtDSGAFo8T+A5+ZQBJCAl8Y
 Jeacs4FIfGaU6G3+xAbTcWX9OXaIxHJGieM7F7LAVd27vQfKOcMosffZYVaIWbsYJVb+LgSx
 2QQ0Jbb/+c8CYosISEu0X53ECtLALHCdUeLQ74vsIAlhATuJdz++MYPYLAKqEt+eHAKzeQWs
 JTpu32WCuENeYuu3T2ALOIHiW3pvM0LUCEqcnPkEbAEzUE3z1tnMELaExMEXL5hBlkkIrGKX
 +Pt2JTPEIBeJp10boZ4Tlnh1fAs7hC0j8X/nfCaIhm5Gib4PX6G6ZzBKTF/2HaiDA8ixlug7
 kwNhOkpc/lIBYfJJ3HgrCLGXT2LStunMEGFeiY42IYjpahI7mrYyTmBUnoXk6llIrp6F5OoF
 jMyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPL6X/HP+1g/Hop6RCjAAejEg+vQ9rv
 WCHWxLLiytxDjBIczEoivLc7fsYK8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1
 OzW1ILUIJsvEwSnVwOgt7VXLKzLJQ/Sogdr2K+u51gn5RmkWblw0TTQp6+Oi5sDJNi0n9mzJ
 bT5lpeDTGeD9siz6Xbw9g6wUv55qv6R91JX9pzobN2fzVPDZ3Zp47LbulF9iT+pebi2YI+a4
 zz1F442sFfv7ss06q3UOTbUQdM+cO2fpAtXH+7ZeenvWsT/o29KVB5RYijMSDbWYi4oTAUGF
 SPMpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7rTyn7HGjxukrLY3N/OaDHp0DVG
 iyUXUy3m3VK2mPWunc3ieO8OFgc2j02rOtk87lzbw+bx5NpmJo/3+66yBbBE6dkU5ZeWpCpk
 5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVcO3qUpaDFuOLs9VWs
 DYx/1LsYOTkkBEwkrqw/x97FyMUhJLCUUWLD2j8sEAkZiU9XPrJD2MISf651sUEUfWSUmP//
 M5RzhlHiz+ZdzBDOLkaJe3PmgLWwCWhKbP/zH2yUiIC0RPvVSawgRcwC1xklDv2+CFYkLGAn
 8e7HN2YQm0VAVeLbk0NgNq+AtUTH7btMELvlJbZ++8QKYnMCxbf03mYEsYUErCQe//zIAlEv
 KHFy5hMwmxmovnnrbGYIW0Li4IsXzBMYhWchKZuFpGwWkrIFjMyrGEVSS4tz03OLDfWKE3OL
 S/PS9ZLzczcxAqNs27Gfm3cwXtoYfIhRgINRiYf3ZfLvWCHWxLLiytxDjBIczEoivLc7fsYK
 8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wAeSVxBuaGppbWBqaG5sbm1koifN2CByMERJI
 TyxJzU5NLUgtgulj4uCUamCM8n6wKGRug4iS/Zb7L/a+KeuX2dTftnTq1GW7bzfNKbWsj+05
 vOHIm+q1l4SCtn42qJu0s+TYNVkm5tuN2/bf0F65nSnubEdauvOWztsPWbdbzcpZOjugaI+2
 1eUjd4KmhK3efdR7TfT07AzhkIPLWefNcl4rc0NwyWehetMfM58+XCPkVcJ7QImlOCPRUIu5
 qDgRANDmB8HIAgAA
X-CMS-MailID: 20191219130942eucas1p1de5bbf57c675e3ea20cd0892e7e03c77
X-Msg-Generator: CA
X-RootMTR: 20191219130942eucas1p1de5bbf57c675e3ea20cd0892e7e03c77
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130942eucas1p1de5bbf57c675e3ea20cd0892e7e03c77
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130942eucas1p1de5bbf57c675e3ea20cd0892e7e03c77@eucas1p1.samsung.com>
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

Add support for returning a resonable response to Get/Set Features of
mandatory features.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 58 ++++++++++++++++++++++++++++++++++++++++---
 hw/block/trace-events |  2 ++
 include/block/nvme.h  |  3 ++-
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 113b64ea1843..3d870ac55984 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1003,9 +1003,18 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtr=
l *n, NvmeCmd *cmd)
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
     uint32_t result;
=20
+    trace_nvme_dev_getfeat(nvme_cid(req), dw10);
+
     switch (dw10) {
+    case NVME_ARBITRATION:
+        result =3D cpu_to_le32(n->features.arbitration);
+        break;
+    case NVME_POWER_MANAGEMENT:
+        result =3D cpu_to_le32(n->features.power_mgmt);
+        break;
     case NVME_TEMPERATURE_THRESHOLD:
         result =3D 0;
=20
@@ -1026,6 +1035,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
             break;
         }
=20
+        break;
+    case NVME_ERROR_RECOVERY:
+        result =3D cpu_to_le32(n->features.err_rec);
         break;
     case NVME_VOLATILE_WRITE_CACHE:
         result =3D blk_enable_write_cache(n->conf.blk);
@@ -1038,6 +1050,19 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
         break;
     case NVME_TIMESTAMP:
         return nvme_get_feature_timestamp(n, cmd);
+    case NVME_INTERRUPT_COALESCING:
+        result =3D cpu_to_le32(n->features.int_coalescing);
+        break;
+    case NVME_INTERRUPT_VECTOR_CONF:
+        if ((dw11 & 0xffff) > n->params.num_queues) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        result =3D cpu_to_le32(n->features.int_vector_config[dw11 & 0xff=
ff]);
+        break;
+    case NVME_WRITE_ATOMICITY:
+        result =3D cpu_to_le32(n->features.write_atomicity);
+        break;
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         result =3D cpu_to_le32(n->features.async_config);
         break;
@@ -1073,6 +1098,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
+    trace_nvme_dev_setfeat(nvme_cid(req), dw10, dw11);
+
     switch (dw10) {
     case NVME_TEMPERATURE_THRESHOLD:
         if (NVME_TEMP_TMPSEL(dw11)) {
@@ -1113,6 +1140,13 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config =3D dw11;
         break;
+    case NVME_ARBITRATION:
+    case NVME_POWER_MANAGEMENT:
+    case NVME_ERROR_RECOVERY:
+    case NVME_INTERRUPT_COALESCING:
+    case NVME_INTERRUPT_VECTOR_CONF:
+    case NVME_WRITE_ATOMICITY:
+        return NVME_FEAT_NOT_CHANGABLE | NVME_DNR;
     default:
         trace_nvme_dev_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1686,6 +1720,21 @@ static void nvme_init_state(NvmeCtrl *n)
     n->temperature =3D NVME_TEMPERATURE;
     n->features.temp_thresh_hi =3D le16_to_cpu(n->id_ctrl.wctemp);
     n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+
+    /*
+     * There is no limit on the number of commands that the controller m=
ay
+     * launch at one time from a particular Submission Queue.
+     */
+    n->features.arbitration =3D 0x7;
+
+    n->features.int_vector_config =3D g_malloc0_n(n->params.num_queues,
+        sizeof(*n->features.int_vector_config));
+
+    /* disable coalescing (not supported) */
+    for (int i =3D 0; i < n->params.num_queues; i++) {
+        n->features.int_vector_config[i] =3D i | (1 << 16);
+    }
+
     n->aer_reqs =3D g_new0(NvmeRequest *, n->params.aerl + 1);
 }
=20
@@ -1779,15 +1828,17 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->nn =3D cpu_to_le32(n->num_namespaces);
     id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP=
);
=20
+
+    if (blk_enable_write_cache(n->conf.blk)) {
+        id->vwc =3D 1;
+    }
+
     strcpy((char *) id->subnqn, "nqn.2019-08.org.qemu:");
     pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
=20
     id->psd[0].mp =3D cpu_to_le16(0x9c4);
     id->psd[0].enlat =3D cpu_to_le32(0x10);
     id->psd[0].exlat =3D cpu_to_le32(0x4);
-    if (blk_enable_write_cache(n->conf.blk)) {
-        id->vwc =3D 1;
-    }
=20
     n->bar.cap =3D 0;
     NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
@@ -1858,6 +1909,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->cq);
     g_free(n->sq);
     g_free(n->aer_reqs);
+    g_free(n->features.int_vector_config);
=20
     if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 3952c36774cf..4cf39961989d 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -41,6 +41,8 @@ nvme_dev_del_cq(uint16_t cqid) "deleted completion queu=
e, sqid=3D%"PRIu16""
 nvme_dev_identify_ctrl(void) "identify controller"
 nvme_dev_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
 nvme_dev_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%=
"PRIu16""
+nvme_dev_getfeat(uint16_t cid, uint32_t fid) "cid %"PRIu16" fid 0x%"PRIx=
32""
+nvme_dev_setfeat(uint16_t cid, uint32_t fid, uint32_t val) "cid %"PRIu16=
" fid 0x%"PRIx32" val 0x%"PRIx32""
 nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write=
 cache, result=3D%s"
 nvme_dev_getfeat_numq(int result) "get feature number of queues, result=3D=
%d"
 nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "reque=
sted cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D=
%d"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index a24be047a311..09419ed499d0 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -445,7 +445,8 @@ enum NvmeStatusCodes {
     NVME_FW_REQ_RESET           =3D 0x010b,
     NVME_INVALID_QUEUE_DEL      =3D 0x010c,
     NVME_FID_NOT_SAVEABLE       =3D 0x010d,
-    NVME_FID_NOT_NSID_SPEC      =3D 0x010f,
+    NVME_FEAT_NOT_CHANGABLE     =3D 0x010e,
+    NVME_FEAT_NOT_NSID_SPEC     =3D 0x010f,
     NVME_FW_REQ_SUSYSTEM_RESET  =3D 0x0110,
     NVME_CONFLICTING_ATTRS      =3D 0x0180,
     NVME_INVALID_PROT_INFO      =3D 0x0181,
--=20
2.24.1


