Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1861C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900A62072D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJzao9mI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900A62072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nBF-0005J3-TZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8nAK-0004OI-Kr
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:11:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42859
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8nAI-0007NI-Ay
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597939904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZa+YCw3W+Vj002yW/z6yiSF4sBXXaDQ7N4HwdV1/kw=;
 b=UJzao9mI8QSPGrRi8FgSROG8GNKMWUnlVXZjs8OWJOxWtFO4qGUWzKLw+Ps4L6NnzOKHbx
 EdbdC125rEtS65cu0C49mtKNfF7unLE5C7sl/Cd+FtPhBYLN1FSye5DkHbf97zQzZhfQ7P
 2eESpdYWHBSqIqZAo12gVmx92gy2O8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-QoYnolcRNACujUwgeKoqyA-1; Thu, 20 Aug 2020 12:11:43 -0400
X-MC-Unique: QoYnolcRNACujUwgeKoqyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BB762FD05;
 Thu, 20 Aug 2020 16:11:41 +0000 (UTC)
Received: from work-vm (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6FCA60BF1;
 Thu, 20 Aug 2020 16:11:39 +0000 (UTC)
Date: Thu, 20 Aug 2020 17:11:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 01/10] migration/dirtyrate: Add get_dirtyrate_thread()
 function
Message-ID: <20200820161137.GI2664@work-vm>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-2-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1597634433-18809-2-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> Add get_dirtyrate_thread() functions
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> ---
>  migration/Makefile.objs |  1 +
>  migration/dirtyrate.c   | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/dirtyrate.h   | 44 ++++++++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+)
>  create mode 100644 migration/dirtyrate.c
>  create mode 100644 migration/dirtyrate.h
> 
> diff --git a/migration/Makefile.objs b/migration/Makefile.objs
> index 0fc619e..12ae98c 100644
> --- a/migration/Makefile.objs
> +++ b/migration/Makefile.objs
> @@ -6,6 +6,7 @@ common-obj-y += qemu-file.o global_state.o
>  common-obj-y += qemu-file-channel.o
>  common-obj-y += xbzrle.o postcopy-ram.o
>  common-obj-y += qjson.o
> +common-obj-y += dirtyrate.o
>  common-obj-y += block-dirty-bitmap.o
>  common-obj-y += multifd.o
>  common-obj-y += multifd-zlib.o
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> new file mode 100644
> index 0000000..bb0ebe9
> --- /dev/null
> +++ b/migration/dirtyrate.c
> @@ -0,0 +1,64 @@
> +/*
> + * Dirtyrate implement code
> + *
> + * Copyright (c) 2017-2020 HUAWEI TECHNOLOGIES CO.,LTD.
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
> +#include "crypto/hash.h"
> +#include "crypto/random.h"
> +#include "qemu/config-file.h"
> +#include "exec/memory.h"
> +#include "exec/ramblock.h"
> +#include "exec/target_page.h"
> +#include "qemu/rcu_queue.h"
> +#include "qapi/qapi-commands-migration.h"
> +#include "migration.h"
> +#include "dirtyrate.h"
> +
> +CalculatingDirtyRateState CalculatingState = CAL_DIRTY_RATE_INIT;
> +
> +static int dirty_rate_set_state(int new_state)
> +{
> +    int old_state = CalculatingState;
> +
> +    if (new_state == old_state) {
> +        return -1;
> +    }
> +
> +    if (atomic_cmpxchg(&CalculatingState, old_state, new_state) != old_state) {
> +        return -1;
> +    }

This is a little unusual; this has removed your comment from v1 about
what you're trying to protect; but not quite being clear about what it's
doing.

I think what you want here is closer to migrate_set_state, ie you
pass what you think the old state is, and the state you want to go to.

> +    return 0;
> +}
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
> +    int ret;
> +
> +    ret = dirty_rate_set_state(CAL_DIRTY_RATE_ACTIVE);

so this would become:
    ret = dirty_rate_set_state(CAL_DIRTY_RATE_INIT,
              CAL_DIRTY_RATE_ACTIVE);

> +    if (ret == -1) {
> +        return NULL;
> +    }
> +
> +    calculate_dirtyrate(config);
> +
> +    ret = dirty_rate_set_state(CAL_DIRTY_RATE_END);
> +
> +    return NULL;
> +}
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> new file mode 100644
> index 0000000..914c363
> --- /dev/null
> +++ b/migration/dirtyrate.h
> @@ -0,0 +1,44 @@
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
> + * Sample 256 pages per GB as default.
> + * TODO: Make it configurable.
> + */
> +#define DIRTYRATE_DEFAULT_SAMPLE_PAGES            256
> +
> +/* Take 1s as default for calculation duration */
> +#define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
> +
> +struct DirtyRateConfig {
> +    uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
> +    int64_t sample_period_seconds; /* time duration between two sampling */
> +};
> +
> +/*
> + *  To record calculate dirty_rate status:
> + *  0: initial status, calculating thread is not be created here.
> + *  1: calculating thread is created.
> + *  2: calculating thread is end, we can get result.
> + */
> +typedef enum {
> +    CAL_DIRTY_RATE_INIT = 0,
> +    CAL_DIRTY_RATE_ACTIVE,
> +    CAL_DIRTY_RATE_END,
> +} CalculatingDirtyRateState;
> +
> +void *get_dirtyrate_thread(void *arg);
> +#endif
> +
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


