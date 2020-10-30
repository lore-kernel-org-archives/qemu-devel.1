Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AADC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4EE206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lEKqtB3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4EE206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYV7g-0002rm-8F
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1kYV6K-0001tF-Qd
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:09:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1kYV6I-0006pQ-Mi
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:09:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UE9K3e180356;
 Fri, 30 Oct 2020 14:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uBBxdfos/utwzqMcdShynHcfvBxryRoAMMW/yC1mSpI=;
 b=lEKqtB3Qr/bAQNrwYUfE7BkhoctkkBaXegJbxU7L52PfniZHHu1/cW6Hflk60i+4NDmR
 IDA+qifPyjsrzwUN2DFxRKNMsOqpzIMgTch+uoiF4onGKxtc37XyYgIxl7lEJ5eSME4b
 NzCzR6nLrUFb3iFYWJMpGrGdfNULCOEXYSlWChNaJDb+tqrYulRlpl2hmz5YSmuERA+B
 Rhl3g6xqnPi6vk+czvHZG5oA4L04MWcEOt1NQHglIbbu/mqtkifG50tbtkHz8B+v0la9
 3oztdCYHbtrS93xI5DJcq8HwZgudH6ZsFEbNdXvDzzATpRmpZzHrKBJL9Qw8KFnCFM/P DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 34cc7m9vnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 30 Oct 2020 14:09:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UE6ZEb014980;
 Fri, 30 Oct 2020 14:09:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 34cwur0v40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2020 14:09:28 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09UE9PKc007793;
 Fri, 30 Oct 2020 14:09:25 GMT
Received: from [192.168.0.244] (/70.123.151.170)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 30 Oct 2020 07:09:25 -0700
Subject: Re: [PATCH] migration/dirtyrate: simplify inlcudes in dirtyrate.c
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 dgilbert@redhat.com
References: <1604030281-112946-1-git-send-email-zhengchuan@huawei.com>
From: Mark Kanda <mark.kanda@oracle.com>
Organization: Oracle Corporation
Message-ID: <e19ac83b-dc05-a783-cb30-e09d592f6a8f@oracle.com>
Date: Fri, 30 Oct 2020 09:09:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604030281-112946-1-git-send-email-zhengchuan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300108
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=mark.kanda@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 10:09:46
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: yubihong@huawei.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/2020 10:58 PM, Chuan Zheng wrote:
> Remove redundant blank line which is left by Commit 662770af7c6e8c,
> also take this opportunity to remove redundant includes in dirtyrate.c.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>

Reviewed-by: Mark Kanda <mark.kanda@oracle.com>

> ---
>   migration/dirtyrate.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 8f728d2..ccb9814 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -11,17 +11,12 @@
>    */
>   
>   #include "qemu/osdep.h"
> -
>   #include <zlib.h>
>   #include "qapi/error.h"
>   #include "cpu.h"
> -#include "qemu/config-file.h"
> -#include "exec/memory.h"
>   #include "exec/ramblock.h"
> -#include "exec/target_page.h"
>   #include "qemu/rcu_queue.h"
>   #include "qapi/qapi-commands-migration.h"
> -#include "migration.h"
>   #include "ram.h"
>   #include "trace.h"
>   #include "dirtyrate.h"
> 

