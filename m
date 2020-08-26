Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CB9C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0288E20786
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HU6ZdCha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0288E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAuFb-0001F4-8Z
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAuF4-0000oB-RP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAuF2-000393-AN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598443763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K6dlQC+UEBc6TX7un1Ldp5zgqtF8TKc4cu3np/Hfqbc=;
 b=HU6ZdChamyRSqhM0taf41juEwPj9l6C14Sst7zOVIhULYp1a5pR9tfKEddiXNjggw/q3Tc
 54goZ/YF+LPw+iquRQzWmQ8jg3AQrjBJavmY5EiAPaUgEMQuTOdlMLfmhVa7Q7xjtryjvX
 LefDDO3OmP9+cpNCC0bHVErsgpN3N4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-S78txsR5PauXoECpCgyQnQ-1; Wed, 26 Aug 2020 08:09:19 -0400
X-MC-Unique: S78txsR5PauXoECpCgyQnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1297718C5200;
 Wed, 26 Aug 2020 12:09:18 +0000 (UTC)
Received: from work-vm (ovpn-114-48.ams2.redhat.com [10.36.114.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA64160C13;
 Wed, 26 Aug 2020 12:09:15 +0000 (UTC)
Date: Wed, 26 Aug 2020 13:09:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v5 04/12] migration/dirtyrate: Add dirtyrate statistics
 series functions
Message-ID: <20200826120912.GF2726@work-vm>
References: <1598319650-36762-1-git-send-email-zhengchuan@huawei.com>
 <1598319650-36762-5-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1598319650-36762-5-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> Add dirtyrate statistics to record/update dirtyrate info.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> ---
>  migration/dirtyrate.c | 29 +++++++++++++++++++++++++++++
>  migration/dirtyrate.h | 10 ++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 91987c5..0d7163f 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -24,6 +24,7 @@
>  #include "dirtyrate.h"
>  
>  static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
> +static struct DirtyRateStat DirtyStat;
>  
>  static int dirtyrate_set_state(int *state, int old_state, int new_state)
>  {
> @@ -35,6 +36,34 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
>      }
>  }
>  
> +static void reset_dirtyrate_stat(void)
> +{
> +    DirtyStat.total_dirty_samples = 0;
> +    DirtyStat.total_sample_count = 0;
> +    DirtyStat.total_block_mem_MB = 0;
> +    DirtyStat.dirty_rate = 0;
> +}
> +
> +static void update_dirtyrate_stat(struct RamblockDirtyInfo *info)
> +{
> +    DirtyStat.total_dirty_samples += info->sample_dirty_count;
> +    DirtyStat.total_sample_count += info->sample_pages_count;
> +    /* size of 4K pages in MB */
> +    DirtyStat.total_block_mem_MB += info->ramblock_pages / 256;

You need to be consistent with your use of constants, you have
a DIRTYRATE_SAMPLE_PAGE_SIZE in a later patch; so use it rather than
hard coding 256 here.

Dave

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
> +                 1000 / (total_sample_count * msec);
> +
> +    DirtyStat.dirty_rate = dirtyrate;
> +}
>  
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index dc45419..8e25d93 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -45,6 +45,16 @@ struct RamblockDirtyInfo {
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


