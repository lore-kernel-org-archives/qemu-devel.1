Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68302C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F362068E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CXJ5wxZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F362068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfb5-00055A-Gr
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCfaE-0004Fb-6j
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:54:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCfaB-0000o5-2v
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:54:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8U6vS074844;
 Mon, 31 Aug 2020 08:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=gmVQmB4M0pINRty9rw69x0NlNcmK11c4D0WgFW6r/54=;
 b=CXJ5wxZjSp2rkS4saP0Q5+07NqZ7DmjSQobu+h/iXSkCtxRViZgaTSwQMiJUkLYvG/Gg
 7eaK9azMOlbD5ZAjrhuZSeCuwgYTWucWLV+/baxqYsWdxCEFV6dFYCxBlgVGshUIw+Hu
 0oJrF4bwUEoGBL4+SySPH7qYUITLQ+LFYhWfXUjSPdyVa34jxjWMQEexQE0jmHdMPWry
 nJ0BM0DzyS6Dl+shWPjIi+k8vD00EBxfe2+0Jj16ttImF1xVHQq4+BsZxGjW5VF5/JfM
 1sOmHlp5w5I3jORTvD0Dc91mbNBSakmQ9KKNA7DECPJdWE9fzFWsJrg5oklUXLK/gKsG ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 337qrhc5u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 31 Aug 2020 08:54:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8UuGr126715;
 Mon, 31 Aug 2020 08:54:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 3380spq5bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2020 08:54:20 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07V8sFFs015049;
 Mon, 31 Aug 2020 08:54:16 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 31 Aug 2020 01:54:15 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id d0669410;
 Mon, 31 Aug 2020 08:54:12 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v6 01/12] migration/dirtyrate: setup up query-dirtyrate
 framwork
In-Reply-To: <1598669577-76914-2-git-send-email-zhengchuan@huawei.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <1598669577-76914-2-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Mon, 31 Aug 2020 09:54:12 +0100
Message-ID: <m2lfhvci17.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 suspectscore=2 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310051
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=david.edmondson@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 04:54:28
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

On Saturday, 2020-08-29 at 10:52:46 +08, Chuan Zheng wrote:

> Add get_dirtyrate_thread() functions to setup query-dirtyrate
> framework.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Modulo the question below...

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  migration/dirtyrate.c | 38 ++++++++++++++++++++++++++++++++++++++
>  migration/dirtyrate.h | 29 +++++++++++++++++++++++++++++
>  migration/meson.build |  2 +-
>  3 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644 migration/dirtyrate.c
>  create mode 100644 migration/dirtyrate.h
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> new file mode 100644
> index 0000000..44d673a
> --- /dev/null
> +++ b/migration/dirtyrate.c
> @@ -0,0 +1,38 @@
> +/*
> + * Dirtyrate implement code
> + *
> + * Copyright (c) 2017-2020 HUAWEI TECHNOLOGIES CO.,LTD.

Idle query, given that I'm not a lawyer, has this code really been
around since 2017?

> + *
> + * Authors:
> + *  Chuan Zheng <zhengchuan@huawei.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "qemu/config-file.h"
> +#include "exec/memory.h"
> +#include "exec/ramblock.h"
> +#include "exec/target_page.h"
> +#include "qemu/rcu_queue.h"
> +#include "qapi/qapi-commands-migration.h"
> +#include "migration.h"
> +#include "dirtyrate.h"
> +
> +static void calculate_dirtyrate(struct DirtyRateConfig config)
> +{
> +    /* todo */
> +    return;
> +}
> +
> +void *get_dirtyrate_thread(void *arg)
> +{
> +    struct DirtyRateConfig config = *(struct DirtyRateConfig *)arg;
> +
> +    calculate_dirtyrate(config);
> +
> +    return NULL;
> +}
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> new file mode 100644
> index 0000000..5be9714
> --- /dev/null
> +++ b/migration/dirtyrate.h
> @@ -0,0 +1,29 @@
> +/*
> + *  Dirtyrate common functions
> + *
> + *  Copyright (c) 2020 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + *  Authors:
> + *  Chuan Zheng <zhengchuan@huawei.com>
> + *
> + *  This work is licensed under the terms of the GNU GPL, version 2 or later.
> + *  See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_MIGRATION_DIRTYRATE_H
> +#define QEMU_MIGRATION_DIRTYRATE_H
> +
> +/*
> + * Sample 512 pages per GB as default.
> + * TODO: Make it configurable.
> + */
> +#define DIRTYRATE_DEFAULT_SAMPLE_PAGES            512
> +
> +struct DirtyRateConfig {
> +    uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
> +    int64_t sample_period_seconds; /* time duration between two sampling */
> +};
> +
> +void *get_dirtyrate_thread(void *arg);
> +#endif
> +
> diff --git a/migration/meson.build b/migration/meson.build
> index ac8ff14..b5b71c8 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -37,4 +37,4 @@ softmmu_ss.add(when: ['CONFIG_RDMA', rdma], if_true: files('rdma.c'))
>  softmmu_ss.add(when: 'CONFIG_LIVE_BLOCK_MIGRATION', if_true: files('block.c'))
>  softmmu_ss.add(when: 'CONFIG_ZSTD', if_true: [files('multifd-zstd.c'), zstd])
>  
> -specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('ram.c'))
> +specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('dirtyrate.c', 'ram.c'))
> -- 
> 1.8.3.1

dme.
-- 
Tonight I'm gonna bury that horse in the ground.

