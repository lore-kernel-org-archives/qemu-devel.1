Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C51CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB5D206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIFvZO77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB5D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k318Q-0006zj-0z
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k317M-000635-Is
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:52:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k317J-0004Fm-K9
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596563568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qgLp9d1Pw62/3CGIeyC8KJC+ubkZ9pj0aU69kdBj1S8=;
 b=DIFvZO77pXSwlpu0Vj+kZuespXzn4yc7ukOInoFTJ0uaksJzy4klns1VU4IZbUvyWQflTj
 B1wVFhkpMKgBDZqcR9MM+aEJw3yvtYaBGTmCxvAfFyLzMC9cfCWFMkQMgLo3ifqJngLJrw
 Fs8LP9YZvVsN7GLfRvdys8Y+6M4kL/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-JIbaqD6qNOmRDc6_8xlwkQ-1; Tue, 04 Aug 2020 13:52:46 -0400
X-MC-Unique: JIbaqD6qNOmRDc6_8xlwkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 435601005510;
 Tue,  4 Aug 2020 17:52:45 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DBD65D9F7;
 Tue,  4 Aug 2020 17:52:43 +0000 (UTC)
Date: Tue, 4 Aug 2020 18:52:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 6/8] migration/dirtyrate: Implement
 get_sample_gap_period() and block_sample_gap_period()
Message-ID: <20200804175240.GI2659@work-vm>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-7-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1595646669-109310-7-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> Implement get_sample_gap_period() and block_sample_gap_period() to
> sleep specific time between sample actions.
> 
> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 28 ++++++++++++++++++++++++++++
>  migration/dirtyrate.h |  6 +++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 7badc53..00abfa7 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -295,10 +295,38 @@ static void set_dirty_rate_stage(CalculatingDirtyRateStage ratestage)
>      calculating_dirty_rate_stage = ratestage;
>  }
>  
> +static int64_t block_sample_gap_period(int64_t msec, int64_t initial_time)
> +{
> +    int64_t current_time;
> +
> +    current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if ((current_time - initial_time) >= msec) {
> +        msec = current_time - initial_time;
> +    } else {
> +        g_usleep((msec + initial_time - current_time) * 1000);
> +    }

OK, so I think this is for sleeping in your own thread?
Since it's bounded at about 60s that's not too bad

> +    return msec;
> +}
> +
> +static int64_t get_sample_gap_period(struct dirtyrate_config config)
> +{
> +    int64_t msec;
> +
> +    msec = config.sample_period_seconds * 1000;
> +    if (msec <= MIN_FETCH_DIRTYRATE_TIME_MSEC || msec > MAX_FETCH_DIRTYRATE_TIME_MSEC) {
> +        msec = DEFAULT_FETCH_DIRTYRATE_TIME_MSEC;
> +    }
> +    return msec;
> +}
> +
>  void *get_dirtyrate_thread(void *arg)
>  {
>      struct dirtyrate_config config = *(struct dirtyrate_config *)arg;
>      int64_t msec = 0;
> +
> +    /* max period is 60 seconds */
> +    msec = get_sample_gap_period(config);

(I'm not sure I understood where the config was set?)

>      set_dirty_rate_stage(CAL_DIRTY_RATE_ING);
>  
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 4d9b3b8..5aef2d7 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -14,12 +14,16 @@
>  #define QEMU_MIGRATION_DIRTYRATE_H
>  
>  /* take 256 pages per GB for cal dirty rate */
> -#define DIRTYRATE_DEFAULT_SAMPLE_PAGES    256
> +#define DIRTYRATE_DEFAULT_SAMPLE_PAGES  256

Not for this patch.

>  #define DIRTYRATE_SAMPLE_PAGE_SIZE      4096
>  #define DIRTYRATE_PAGE_SIZE_SHIFT       12
>  #define BLOCK_INFO_MAX_LEN              256
>  #define PAGE_SIZE_SHIFT                 20
>  
> +#define MIN_FETCH_DIRTYRATE_TIME_MSEC        0
> +#define MAX_FETCH_DIRTYRATE_TIME_MSEC        60000
> +#define DEFAULT_FETCH_DIRTYRATE_TIME_MSEC    1000
> +
>  struct dirtyrate_config {
>      uint64_t sample_pages_per_gigabytes;
>      int64_t sample_period_seconds;
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


