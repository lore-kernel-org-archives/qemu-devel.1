Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3685BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:24:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A8A2070A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUP2cRQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A8A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2zkH-0001lS-75
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k2zjG-00012S-MV
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:23:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k2zjE-0008H0-0s
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596558230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7KBIQM35pm7WywADtGfhysH9B9xyR0FUUomJkF+o9ts=;
 b=KUP2cRQuL0nk6QMCAP9YwgcIx+P8hqn99C3m162FN3PdryH1fkcegF6UBbyHAQOO2srBtL
 yw4FBg29aAflIyV9zeHxyV7uXwN4HUNv32vWRtQUrZclgVd3g59vQb0WnxO15+keDbgZXd
 8F8P5An3Zv6FW/ajTjM3K4k0ZYrJYTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-wbPH16eJOOGtYkhKQMvNfA-1; Tue, 04 Aug 2020 12:23:47 -0400
X-MC-Unique: wbPH16eJOOGtYkhKQMvNfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFFA7801A03;
 Tue,  4 Aug 2020 16:23:45 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2088A71769;
 Tue,  4 Aug 2020 16:23:43 +0000 (UTC)
Date: Tue, 4 Aug 2020 17:23:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 1/8] migration/dirtyrate: Add get_dirtyrate_thread()
 function
Message-ID: <20200804162340.GD2659@work-vm>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-2-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1595646669-109310-2-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> From: Zheng Chuan <zhengchuan@huawei.com>
> 
> Add get_dirtyrate_thread() functions
> 
> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/dirtyrate.h | 38 +++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 migration/dirtyrate.c
>  create mode 100644 migration/dirtyrate.h
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> new file mode 100644
> index 0000000..fc652fb
> --- /dev/null
> +++ b/migration/dirtyrate.c
> @@ -0,0 +1,63 @@
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
> +#include "dirtyrate.h"
> +
> +static uint64_t sample_pages_per_gigabytes = DIRTYRATE_DEFAULT_SAMPLE_PAGES;
> +static uint64_t dirty_rate; /* MB/s */
> +CalculatingDirtyRateStage calculating_dirty_rate_stage = CAL_DIRTY_RATE_INIT;
> +
> +static bool calculate_dirtyrate(struct dirtyrate_config config,
> +                        uint64_t *dirty_rate, int64_t time)
> +{
> +    /* todo */
> +    return true;

It would be better to make this return false until you fill it in!

> +}
> +
> +static void set_dirty_rate(uint64_t drate)
> +{
> +    dirty_rate = drate;
> +}
> +
> +/*
> + * There are multithread will write/read *calculating_dirty_rate_stage*,
> + * we can protect only one thread write/read it by libvirt api.
> + * So we don't add mutex_lock to protect it here, but we must calculate
> + * dirty_rate by libvirt api.
> + */
> +static void set_dirty_rate_stage(CalculatingDirtyRateStage ratestage)
> +{
> +    calculating_dirty_rate_stage = ratestage;
> +}

I don't think I understand the threading comment here; when you say the
'libvirt api' do youmean QMP?  Maybe you could do this with an
atomic_cmpxchg like we do in migrate_set_state?

> +
> +void *get_dirtyrate_thread(void *arg)
> +{
> +    struct dirtyrate_config config = *(struct dirtyrate_config *)arg;
> +    uint64_t dirty_rate;
> +    uint64_t hash_dirty_rate;
> +    bool query_succ;
> +    int64_t msec = 0;
> + 
> +    set_dirty_rate_stage(CAL_DIRTY_RATE_ING);
> +
> +    query_succ = calculate_dirtyrate(config, &hash_dirty_rate, msec);
> +    if (!query_succ) {
> +        dirty_rate = 0;
> +    } else {
> +        dirty_rate = hash_dirty_rate;
> +    }
> +
> +    set_dirty_rate(dirty_rate);
> +    set_dirty_rate_stage(CAL_DIRTY_RATE_END);
> +
> +    return NULL;
> +}
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> new file mode 100644
> index 0000000..9a5c228
> --- /dev/null
> +++ b/migration/dirtyrate.h
> @@ -0,0 +1,38 @@
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
> +/* take 256 pages per GB for cal dirty rate */
> +#define DIRTYRATE_DEFAULT_SAMPLE_PAGES    256
> +
> +struct dirtyrate_config {
> +    uint64_t sample_pages_per_gigabytes;
> +    int64_t sample_period_seconds;
> +};
> +
> +/*
> + *  To record calculate dirty_rate status:
> + *  0: initial status, calculating thread is not be created here.
> + *  1: calculating thread is created.
> + *  2: calculating thread is end, we can get result.
> + */
> +typedef enum {
> +    CAL_DIRTY_RATE_INIT  = 0,
> +    CAL_DIRTY_RATE_ING   = 1,

I'm not sure why ING?


> +    CAL_DIRTY_RATE_END   = 2,
> +} CalculatingDirtyRateStage;
> +
> +void *get_dirtyrate_thread(void *arg);
> +#endif
> +
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


