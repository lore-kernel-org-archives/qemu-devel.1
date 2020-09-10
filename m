Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AF4C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A6520795
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZkNxuHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A6520795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPRF-0000XJ-1n
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGPQW-0007nu-Ui
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:28:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50641
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGPQV-0008Sy-3M
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599755278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhMqLavMwtt4BmZA1JtlTXG3HZGCHmn/dbFwH9fSdeo=;
 b=JZkNxuHIzC82w7PxUt5sMTPwyqp3P9rPjTbcevH9OaN7/mWTneviAnWLTAhL4MIXIRYzrc
 8exhWekh2XuYPWcOIiYGJB9pehodan7Wyw6wwBCuaUkuEaTX15wrPvLQbmMiEjpXI2UrFt
 HyhhQlW2triNz7qIe8V0G1Y4B6EmOu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-EanmpS9kNdiff-RnoxWECw-1; Thu, 10 Sep 2020 12:27:56 -0400
X-MC-Unique: EanmpS9kNdiff-RnoxWECw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9F1A805723;
 Thu, 10 Sep 2020 16:27:54 +0000 (UTC)
Received: from work-vm (ovpn-114-164.phx2.redhat.com [10.3.114.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42ECA100238C;
 Thu, 10 Sep 2020 16:27:52 +0000 (UTC)
Date: Thu, 10 Sep 2020 17:27:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v7 04/12] migration/dirtyrate: Add dirtyrate statistics
 series functions
Message-ID: <20200910162749.GI2814@work-vm>
References: <1599661096-127913-1-git-send-email-zhengchuan@huawei.com>
 <1599661096-127913-5-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1599661096-127913-5-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, dme@dme.org,
 quintela@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 alex.chen@huawei.com, ann.zhuangyanying@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> Add dirtyrate statistics functions to record/update dirtyrate info.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/dirtyrate.c | 32 ++++++++++++++++++++++++++++++++
>  migration/dirtyrate.h | 12 ++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 0a3350a..5911ff0 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -23,6 +23,7 @@
>  #include "dirtyrate.h"
>  
>  static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
> +static struct DirtyRateStat DirtyStat;
>  
>  static int dirtyrate_set_state(int *state, int old_state, int new_state)
>  {
> @@ -34,6 +35,37 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
>      }
>  }
>  
> +static void reset_dirtyrate_stat(void)
> +{
> +    DirtyStat.total_dirty_samples = 0;
> +    DirtyStat.total_sample_count = 0;
> +    DirtyStat.total_block_mem_MB = 0;
> +    DirtyStat.dirty_rate = 0;
> +    DirtyStat.start_time = 0;
> +    DirtyStat.calc_time = 0;
> +}
> +
> +static void update_dirtyrate_stat(struct RamblockDirtyInfo *info)
> +{
> +    DirtyStat.total_dirty_samples += info->sample_dirty_count;
> +    DirtyStat.total_sample_count += info->sample_pages_count;
> +    /* size of total pages in MB */
> +    DirtyStat.total_block_mem_MB += (info->ramblock_pages *
> +                                     TARGET_PAGE_SIZE) >> 20;
> +}
> +
> +static void update_dirtyrate(uint64_t msec)
> +{
> +    uint64_t dirtyrate;
> +    uint64_t total_dirty_samples = DirtyStat.total_dirty_samples;
> +    uint64_t total_sample_count = DirtyStat.total_sample_count;
> +    uint64_t total_block_mem_MB = DirtyStat.total_block_mem_MB;
> +
> +    dirtyrate = total_dirty_samples * total_block_mem_MB *
> +                1000 / (total_sample_count * msec);
> +
> +    DirtyStat.dirty_rate = dirtyrate;
> +}
>  
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 479e222..a3ee305 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -42,6 +42,18 @@ struct RamblockDirtyInfo {
>      uint32_t *hash_result; /* array of hash result for sampled pages */
>  };
>  
> +/*
> + * Store calculation statistics for each measure.
> + */
> +struct DirtyRateStat {
> +    uint64_t total_dirty_samples; /* total dirty sampled page */
> +    uint64_t total_sample_count; /* total sampled pages */
> +    uint64_t total_block_mem_MB; /* size of total sampled pages in MB */
> +    int64_t dirty_rate; /* dirty rate in MB/s */
> +    int64_t start_time; /* calculation start time in units of second */
> +    int64_t calc_time; /* time duration of two sampling in units of second */
> +};
> +
>  void *get_dirtyrate_thread(void *arg);
>  #endif
>  
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


