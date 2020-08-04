Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FC2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5E0206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffL+Nzlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5E0206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k31Cq-0000oO-5N
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k31C3-0000LA-F4
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:57:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47373
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k31C1-0004sF-6b
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596563859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lU8BbCfADSE36bwlBdVX0JWJZbUCWEnZGWrvs3ZpQoc=;
 b=ffL+NzlkkaEke5z/cmGM3l38cIgNDUIHrKBd++LO+Ne0v70P03z/Aj8pqy9xTz8Ds43L93
 4VzYiNMDac2WqqVGD0L/MevaGxeFpBDFuzNlEVO87FAv1zwSO0jA2mLCmYAxX4na1LgQu5
 hM3RKFOlq7CavTESGCDl2EG9DjGJQ4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-kDjamH_zOv6_5Mc2y6grzA-1; Tue, 04 Aug 2020 13:57:37 -0400
X-MC-Unique: kDjamH_zOv6_5Mc2y6grzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3FAC19057A0;
 Tue,  4 Aug 2020 17:57:35 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A3217B903;
 Tue,  4 Aug 2020 17:57:34 +0000 (UTC)
Date: Tue, 4 Aug 2020 18:57:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 7/8] migration/dirtyrate: Implement
 calculate_dirtyrate() function
Message-ID: <20200804175731.GJ2659@work-vm>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-8-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1595646669-109310-8-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
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
> Implement calculate_dirtyrate() function.
> 
> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 53 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 00abfa7..d87e16d 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -161,6 +161,21 @@ alloc_block_dirty_info(int *block_index,
>      return block_dinfo;
>  }
>  
> +static void free_block_dirty_info(struct block_dirty_info *infos, int count)
> +{
> +    int i;
> +
> +    if (!infos) {
> +        return;
> +    }
> +
> +    for (i = 0; i < count; i++) {
> +        g_free(infos[i].sample_page_vfn);
> +        g_free(infos[i].hash_result);
> +    }
> +    g_free(infos);
> +}
> +
>  static int ram_block_skip(RAMBlock *block)
>  {
>      if (!strstr(qemu_ram_get_idstr(block), "ram-node") &&
> @@ -278,12 +293,6 @@ static int compare_block_hash_info(struct block_dirty_info *info, int block_inde
>      return 0;
>  }
>  
> -
> -static void calculate_dirtyrate(struct dirtyrate_config config, int64_t time)
> -{
> -    /* todo */
> -}

Please move this function in the earlier patches so that it's only added
once rather than moved later.

>  /*
>   * There are multithread will write/read *calculating_dirty_rate_stage*,
>   * we can protect only one thread write/read it by libvirt api.
> @@ -320,6 +329,38 @@ static int64_t get_sample_gap_period(struct dirtyrate_config config)
>      return msec;
>  }
>  
> +static void calculate_dirtyrate(struct dirtyrate_config config, int64_t time)
> +{
> +    struct block_dirty_info *block_dinfo = NULL;
> +    int block_index = 0;
> +    int64_t msec = time;
> +    int64_t initial_time;

you might like to add some trace_ calls to make this easier to debug.

Dave

> +    rcu_register_thread();
> +    reset_dirtyrate_stat();
> +    initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    rcu_read_lock();
> +    if (record_block_hash_info(config, &block_dinfo, &block_index) < 0) {
> +        goto out;
> +    }
> +    rcu_read_unlock();
> +
> +    msec = block_sample_gap_period(msec, initial_time);
> +
> +    rcu_read_lock();
> +    if (compare_block_hash_info(block_dinfo, block_index) < 0) {
> +        goto out;
> +    }
> +
> +    update_dirtyrate(msec);
> +
> +out:
> +    rcu_read_unlock();
> +    free_block_dirty_info(block_dinfo, block_index + 1);
> +    rcu_unregister_thread();
> +}
> +
> +
>  void *get_dirtyrate_thread(void *arg)
>  {
>      struct dirtyrate_config config = *(struct dirtyrate_config *)arg;
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


