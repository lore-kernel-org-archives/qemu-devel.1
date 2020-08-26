Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282B2C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF8D2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="MKyoFrgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF8D2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsZ8-0002kq-AA
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsYb-0002Ji-0q
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:21:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsYZ-0005mk-Hl
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:21:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id y3so1243579wrl.4
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=zXL/1sCKFSi4hhJv+kESIXc0FE3OLJASPPYXp8jyUik=;
 b=MKyoFrgcTLDaKsMHU30ya8kVBwSQwgihDCXqCFe3UKzGKe/d8GOZ/0p67uW9rxXI6w
 LtZrtn75QlydsSmeSNymUppUTe5yjjjGyCwHMvFc1EfK3yHgggbXxX1bs1r9kDKVeunH
 7Ene5TboPB/zCNlwZlfDUGnghmA//Cp0DKZUVHIsYK33ciDyyE0boSFxV8GemrVTz4yO
 s7JSi8VKt+G9PFgRdmDhTWW1X3kCphYkv84PDtF6veA4CHkvFPyDmWU+e0B00YtCJ+Oa
 VDrm7/6glrUSldjUOPPpB7U0K72e8V6UphCk1igIZzO76a8rcj3Tgntf1qDoyU7Tc4sR
 9LNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=zXL/1sCKFSi4hhJv+kESIXc0FE3OLJASPPYXp8jyUik=;
 b=LA1C1rmvGObT35ZWpMjJDUt2tX1KTnrMSKoRq6RDLrUPBmEjSZqG10RsqzS0WH+cEi
 wVnDkSPw9+Bk1+xYPF+BWB8MUcqu+ieNiiwnBVe1JJfaJPPDjo8x79pF9lxkhC961yT9
 ZqFmQcMg8wQoiEVDobVa2vsN5puAy/Bz9eV/NK5ig1xS4Dy3BSKQbcliDLEIZqmF2N31
 F7P74DNWXFaMnMb54m2eZl0qt75oY7SLxliN+uWunbwmLtlUO5YyLmJKthCxn/QkXPaa
 SpBCQb+53t//krjTXC+GpC5YM+bIRFRHykssJK6qJ4kt6lAQtnm+A672oepPfkTD7LYL
 qZJQ==
X-Gm-Message-State: AOAM5320d8SXEEIaLDC+77lGkus5PgnNJsklsSde57CZOJDqVVsBGFq6
 ezfRqsdzsAK00Ld/lqD0Oos73A==
X-Google-Smtp-Source: ABdhPJxJqKXUv6BqOeghRd8Wbn19nO8hLZpcZ63ZXpgP5nF95MGcf/2hLW1RaRpNauRbXxPDKHqBNA==
X-Received: by 2002:adf:e647:: with SMTP id b7mr15927178wrn.220.1598437285900; 
 Wed, 26 Aug 2020 03:21:25 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id y16sm5222541wrr.83.2020.08.26.03.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 03:21:25 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 6df1ca1e;
 Wed, 26 Aug 2020 10:21:24 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 10/12] migration/dirtyrate: Implement
 calculate_dirtyrate() function
In-Reply-To: <1598260480-64862-11-git-send-email-zhengchuan@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-11-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 26 Aug 2020 11:21:24 +0100
Message-ID: <m2zh6hk8rf.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::444;
 envelope-from=dme@dme.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, 2020-08-24 at 17:14:38 +08, Chuan Zheng wrote:

> Implement calculate_dirtyrate() function.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index d1c0a78..9f52f5f 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -171,6 +171,21 @@ static void get_ramblock_dirty_info(RAMBlock *block,
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
> @@ -316,8 +331,34 @@ static int compare_page_hash_info(struct RamblockDirtyInfo *info,
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
> +    initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    rcu_read_lock();

Page dirtying that happens while acquiring the lock will not be
accounted for, but is within the time window. Could we store the time
after acquiring the lock?

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

Is it necessary to hold the lock across update_dirtyrate()?

> +    free_ramblock_dirty_info(block_dinfo, block_index + 1);
> +    rcu_unregister_thread();
>  }
>  
>  void *get_dirtyrate_thread(void *arg)
> -- 
> 1.8.3.1

dme.
-- 
There's someone in my head but it's not me.

