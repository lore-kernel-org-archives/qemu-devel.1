Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31668C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E271E208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yaslxsC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E271E208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfnr-0001KE-19
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 05:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCfn4-0000Rq-23
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:07:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCfn2-0002SL-Ef
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:07:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8UAG2036435;
 Mon, 31 Aug 2020 09:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=9OucBOKZIrghkbGS8d7UaZOfp4BmVpdvfrUfbmC8i0k=;
 b=yaslxsC8mjSPBmCXO+ndvlKdfVXvcTlO8vHsdSY3fp3h7pJJiKNXvC1QB7HuCAapxbwz
 wOvz7zqlBQnstf0tqE+Vr21WywtxWsNSHwUQqCkyF7puLktsQb7bRxkgK1BhmVyixjJ8
 JtRmr8s8vlPMO37ev7oNVLf2ByE2PqF/4peibqPTZUmCSuulrr4f5eD0ZzyzqFDuwfTQ
 pZ8C8jO7589YUtPDFv6asorxudqGlDrccUMk3VwHurZP0UJT2GTRqW44pkX04KtfURhT
 Xw5cRHZDbgkQ3EoL/ZVjxBxyPsfpjSnYGEiR1R/C70aqdqpG10JmFRPajooAOLcBHIjV RA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 337eykw5vf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 31 Aug 2020 09:07:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8UtWB126610;
 Mon, 31 Aug 2020 09:07:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 3380spqjpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2020 09:07:40 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07V97dt3021885;
 Mon, 31 Aug 2020 09:07:39 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 31 Aug 2020 02:07:39 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 2827759b;
 Mon, 31 Aug 2020 09:07:36 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v6 05/12] migration/dirtyrate: move
 RAMBLOCK_FOREACH_MIGRATABLE into ram.h
In-Reply-To: <1598669577-76914-6-git-send-email-zhengchuan@huawei.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <1598669577-76914-6-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Mon, 31 Aug 2020 10:07:36 +0100
Message-ID: <m28sdvchev.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310051
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=david.edmondson@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 05:07:47
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 zhang.zhanghailiang@huawei.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Saturday, 2020-08-29 at 10:52:50 +08, Chuan Zheng wrote:

> RAMBLOCK_FOREACH_MIGRATABLE is need in dirtyrate measure,
> move the existing definition up into migration/ram.h
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  migration/dirtyrate.c |  1 +
>  migration/ram.c       | 11 +----------
>  migration/ram.h       | 10 ++++++++++
>  3 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index fa7a1db..35b5c69 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -20,6 +20,7 @@
>  #include "qemu/rcu_queue.h"
>  #include "qapi/qapi-commands-migration.h"
>  #include "migration.h"
> +#include "ram.h"
>  #include "dirtyrate.h"
>  
>  static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
> diff --git a/migration/ram.c b/migration/ram.c
> index 76d4fee..37ef0da 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -158,21 +158,12 @@ out:
>      return ret;
>  }
>  
> -static bool ramblock_is_ignored(RAMBlock *block)
> +bool ramblock_is_ignored(RAMBlock *block)
>  {
>      return !qemu_ram_is_migratable(block) ||
>             (migrate_ignore_shared() && qemu_ram_is_shared(block));
>  }
>  
> -/* Should be holding either ram_list.mutex, or the RCU lock. */
> -#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
> -    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> -        if (ramblock_is_ignored(block)) {} else
> -
> -#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> -    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> -        if (!qemu_ram_is_migratable(block)) {} else
> -
>  #undef RAMBLOCK_FOREACH
>  
>  int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
> diff --git a/migration/ram.h b/migration/ram.h
> index 2eeaacf..011e854 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -37,6 +37,16 @@ extern MigrationStats ram_counters;
>  extern XBZRLECacheStats xbzrle_counters;
>  extern CompressionStats compression_counters;
>  
> +bool ramblock_is_ignored(RAMBlock *block);
> +/* Should be holding either ram_list.mutex, or the RCU lock. */
> +#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (ramblock_is_ignored(block)) {} else
> +
> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (!qemu_ram_is_migratable(block)) {} else
> +
>  int xbzrle_cache_resize(int64_t new_size, Error **errp);
>  uint64_t ram_bytes_remaining(void);
>  uint64_t ram_bytes_total(void);
> -- 
> 1.8.3.1

dme.
-- 
When you were the brightest star, who were the shadows?

