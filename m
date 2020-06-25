Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5B3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A805E204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yQCcrXmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A805E204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUhE-0008MC-RX
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <menno.lageman@oracle.com>)
 id 1joUBc-0000Yn-Gn; Thu, 25 Jun 2020 11:53:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <menno.lageman@oracle.com>)
 id 1joUBa-0004N8-5i; Thu, 25 Jun 2020 11:53:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PFfrID121320;
 Thu, 25 Jun 2020 15:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=WWD+yA/away82IUzcaJaQRVcStH3zZHe3kgzmO7fxWQ=;
 b=yQCcrXmXbovIB8V7GPP5DtNAdJ26A7hDtaZGE5PoZk4q4yK3v+1vHkJF0wbEClxAYtnQ
 yl5sO5bc/MesZLzryhcjfrA3cJd6iWZIflwQGDKoJU+xOedbWDPJyPSkh52keTGflvPY
 qfevAZj7tOP+gmPtN+xovVc8WwNd5Bzx/pWcbRniadTjO/Zb9FKr1iAEQJ0s+i0Hzmcz
 65V4zUEJIXDZKakQQICWL5dIokfVLKh3GVU26LZVee0gkvePOHUc5LGP5CeJum2DqILN
 acRN2MfBnz71hatByCPyeJNUea7ugEZd2//stAqvXZRN50xZs2K8TSZiRyWSgIImNmsY Yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 31uustsb65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Jun 2020 15:53:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PFcH0G086511;
 Thu, 25 Jun 2020 15:53:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 31uur97m6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 15:53:04 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05PFr3GB018108;
 Thu, 25 Jun 2020 15:53:04 GMT
Received: from maximegalon.us.oracle.com (/10.175.52.78)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 25 Jun 2020 15:53:03 +0000
From: Menno Lageman <menno.lageman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] intel_iommu: "aw-bits" error message still refers to
 "x-aw-bits"
Date: Thu, 25 Jun 2020 17:52:58 +0200
Message-Id: <20200625155258.1452425-1-menno.lageman@oracle.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=1 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250101
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=menno.lageman@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 11:53:05
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 25 Jun 2020 12:23:29 -0400
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 4b49b586c4 ('intel_iommu: remove "x-" prefix for "aw-bits"')
removed the "x-" prefix but but didn't update the error message
accordingly.

Signed-off-by: Menno Lageman <menno.lageman@oracle.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index df7ad254ac15..c56398e99177 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3758,7 +3758,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     /* Currently only address widths supported are 39 and 48 bits */
     if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
         (s->aw_bits != VTD_HOST_AW_48BIT)) {
-        error_setg(errp, "Supported values for x-aw-bits are: %d, %d",
+        error_setg(errp, "Supported values for aw-bits are: %d, %d",
                    VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
         return false;
     }
-- 
2.26.2


