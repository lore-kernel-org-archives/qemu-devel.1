Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3049BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C38A214F1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AECXpuMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C38A214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQMA-0006yY-Bf
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGQLb-0006XI-0S
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGQLY-0000xV-Rj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599758814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHsrCjqvkXDhUsL0b0Pu3SVVRsK1tcS351L7ViU+iE0=;
 b=AECXpuMs5POUHYY0vz/TXwLeAkixIThHkocMWA4bJPHLif2zQusCTVLK3g+Chiy/BmfPTY
 /neGqS4ZSCddfd+S8rK+Tv5xiR3IeWnN4App/4WXdaRgZ3G+PC+fAB+Rkp4mJ/uyu+YV2m
 P4MbsaszO/o/aoKFnKubSqbSezgSDPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144--LiyqzJ5OW2STVv0HaTlrw-1; Thu, 10 Sep 2020 13:26:50 -0400
X-MC-Unique: -LiyqzJ5OW2STVv0HaTlrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DB871009469;
 Thu, 10 Sep 2020 17:26:49 +0000 (UTC)
Received: from work-vm (ovpn-114-164.phx2.redhat.com [10.3.114.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2A8E60BF4;
 Thu, 10 Sep 2020 17:26:46 +0000 (UTC)
Date: Thu, 10 Sep 2020 18:26:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v7 10/12] migration/dirtyrate: Implement
 calculate_dirtyrate() function
Message-ID: <20200910172644.GL2814@work-vm>
References: <1599661096-127913-1-git-send-email-zhengchuan@huawei.com>
 <1599661096-127913-11-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1599661096-127913-11-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, dme@dme.org,
 quintela@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 alex.chen@huawei.com, ann.zhuangyanying@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> Implement calculate_dirtyrate() function.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/dirtyrate.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 8a30261..2f9ac34 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -162,6 +162,21 @@ static void get_ramblock_dirty_info(RAMBlock *block,
>      strcpy(info->idstr, qemu_ram_get_idstr(block));
>  }
>  
> +static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos, int count)
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
>  static struct RamblockDirtyInfo *
>  alloc_ramblock_dirty_info(int *block_index,
>                            struct RamblockDirtyInfo *block_dinfo)
> @@ -300,8 +315,34 @@ static int compare_page_hash_info(struct RamblockDirtyInfo *info,
>  
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
> -    /* todo */
> -    return;
> +    struct RamblockDirtyInfo *block_dinfo = NULL;
> +    int block_index = 0;
> +    int64_t msec = 0;
> +    int64_t initial_time;
> +
> +    rcu_register_thread();
> +    reset_dirtyrate_stat();
> +    rcu_read_lock();
> +    initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if (record_ramblock_hash_info(&block_dinfo, config, &block_index) < 0) {
> +        goto out;
> +    }
> +    rcu_read_unlock();
> +
> +    msec = config.sample_period_seconds * 1000;
> +    msec = set_sample_page_period(msec, initial_time);
> +
> +    rcu_read_lock();
> +    if (compare_page_hash_info(block_dinfo, block_index) < 0) {
> +        goto out;
> +    }
> +
> +    update_dirtyrate(msec);
> +
> +out:
> +    rcu_read_unlock();
> +    free_ramblock_dirty_info(block_dinfo, block_index + 1);
> +    rcu_unregister_thread();
>  }
>  
>  void *get_dirtyrate_thread(void *arg)
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


