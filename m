Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A13FC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C327A206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xDSpnjJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C327A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZlt-0007Iv-Ru
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZiq-0003Cd-Kc; Wed, 30 Sep 2020 06:52:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZio-0000jX-U4; Wed, 30 Sep 2020 06:52:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAn9ce038455;
 Wed, 30 Sep 2020 10:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=d2lmXsb3uk0OfiEKbY6Kf2dBMbt07cy4/L2FGKqbXcA=;
 b=xDSpnjJhPMygu29DFTf6JYIacLAMdU5VAe5oZ4EM5V6YI6S/x+2B/K7oX7+Y5wircZ/q
 Gd9Db4yqoN5AQ3RLcQ4vIXB0aCPUlHm5vLm0DZL3rkXZQhz4bSXVSSjTKEcLL6SQKwnO
 pHan9Kh5YuIiMuuk2sCTPiO3dSFfTP9cDYq4+E5RmN8/7wS+3/trO2TlbFhuIoGrKZQv
 0z5UaYxwaGVsTsL9oWA6HwQ2esAsX4tlFh5uCoaUVsp7HDdy3Am56hg+gJRiUTzYWe4f
 W7+Cbemv/CDnRuuYU2MwCGWeqvH9lxxbUoILxm89hx4Coc2d1TYZcnwLfK670deuwpX3 fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 33sx9n7r5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:52:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAoSAs039407;
 Wed, 30 Sep 2020 10:52:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 33tfhyxh8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:52:22 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UAqMLc017820;
 Wed, 30 Sep 2020 10:52:22 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:52:21 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 083983e0;
 Wed, 30 Sep 2020 10:52:20 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 05/14] tricore/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-6-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-6-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:52:19 +0100
Message-ID: <m2wo0bpme4.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=1
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300087
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=david.edmondson@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 06:51:12
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-09-30 at 17:53:12 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target/tricore.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/s390x/ioinst.c      | 2 +-
>  target/tricore/csfr.def    | 2 +-
>  target/tricore/translate.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index a412926..c576d85 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -279,7 +279,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
>          /*
>           * As operand exceptions have a lower priority than access exceptions,
>           * we check whether the memory area is writeable (injecting the
> -         * access execption if it is not) first.
> +         * access exception if it is not) first.
>           */
>          if (!s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib))) {
>              s390_program_interrupt(env, PGM_OPERAND, ra);
> diff --git a/target/tricore/csfr.def b/target/tricore/csfr.def
> index ff004cb..cdfaf1d 100644
> --- a/target/tricore/csfr.def
> +++ b/target/tricore/csfr.def
> @@ -1,4 +1,4 @@
> -/* A(ll) access permited
> +/* A(ll) access permitted
>     R(ead only) access
>     E(nd init protected) access
>  
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 7752630..c9c420d 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -397,7 +397,7 @@ static inline void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
>  #undef E
>  
>  #define R(ADDRESS, REG, FEATURE) /* don't gen writes to read-only reg,
> -                                    since no execption occurs */
> +                                    since no exception occurs */
>  #define A(ADDRESS, REG, FEATURE) R(ADDRESS, REG, FEATURE)                \
>      case ADDRESS:                                                        \
>          if (has_feature(ctx, FEATURE)) {                             \
> -- 
> 2.26.2.windows.1

dme.
-- 
If I could buy my reasoning, I'd pay to lose.

