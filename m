Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A06C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10CA2072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VF5aIB/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10CA2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIsc-0000Km-6Y
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izIro-0008Ls-NV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izIrm-000050-Bv
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:29:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izIrk-0008Dt-Jo
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:29:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015BSqpB002759;
 Wed, 5 Feb 2020 11:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=H0m28/G+iP7KK622uUqXCV2hCVJhcn5Avdwa+E5RIiA=;
 b=VF5aIB/koeHyxn/j2a8e3lM+5FkwgexDmQ2pZkzMQYDrCODDnRbsq4VY+eJHGq3XeodD
 ND1wQUCH7pZU2Su8pUsNuu0quw7IOwktEqXw/Hob/RmfkUvbumw/d+bqjXo1TFD5l0vZ
 yb5s/x0D5cKEfl+VGqkGj5dfWTKv/UozF5NYr4B6SQQOL2Q13dBdmaVFYPcC8BVo/lqc
 jC+jpc6S3U7TNYhMsjnmFsdOar/A/yrS85ZBWCkJHNGbOHCj7pFGevNdP504uFqfFkhT
 xd2JGLxlNur9aDRjcLTSZPZa2KouHAPi6hLBKwyr7nt3iinfGcBFz7CTxkuUthYoehdD pQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2xykbpacy7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:29:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015BSmGw027271;
 Wed, 5 Feb 2020 11:29:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2xymusgqnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:29:03 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015BT2Cd015617;
 Wed, 5 Feb 2020 11:29:02 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 03:29:02 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 68CA457D712A;
 Wed,  5 Feb 2020 11:28:58 +0000 (GMT)
Date: Wed, 5 Feb 2020 11:28:57 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 03/21] fuzz: add FUZZ_TARGET module type
Message-ID: <20200205112857.f65tpiiw2rsxmkyx@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-4-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-4-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050093
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:13AM +0000, Bulekov, Alexander wrote:
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> include/qemu/module.h | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/include/qemu/module.h b/include/qemu/module.h
>index 65ba596e46..684753d808 100644
>--- a/include/qemu/module.h
>+++ b/include/qemu/module.h
>@@ -46,6 +46,7 @@ typedef enum {
>     MODULE_INIT_TRACE,
>     MODULE_INIT_XEN_BACKEND,
>     MODULE_INIT_LIBQOS,
>+    MODULE_INIT_FUZZ_TARGET,
>     MODULE_INIT_MAX
> } module_init_type;
>
>@@ -56,7 +57,8 @@ typedef enum {
> #define xen_backend_init(function) module_init(function, \
>                                                MODULE_INIT_XEN_BACKEND)
> #define libqos_init(function) module_init(function, MODULE_INIT_LIBQOS)
>-
>+#define fuzz_target_init(function) module_init(function, \
>+                                               MODULE_INIT_FUZZ_TARGET)
> #define block_module_load_one(lib) module_load_one("block-", lib)
> #define ui_module_load_one(lib) module_load_one("ui-", lib)
> #define audio_module_load_one(lib) module_load_one("audio-", lib)
>-- 
>2.23.0
>
>

