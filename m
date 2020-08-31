Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A027EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5958B208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="F4BOfpzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5958B208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfq2-0004CD-HF
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 05:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kCfpU-0003h6-CN
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:10:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kCfpS-0002mz-Tp
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:10:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id e17so4517649wme.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=5OzFI4RLkpdXjDByxRcdVYfducqwJu3a7ZWXjm5337c=;
 b=F4BOfpzDkpmPCJVFUiMc/p1wVCVwQwgJUWVF0TUsdQRv7czO1LXDdeWBCxuLMuQfCa
 KXk2s6CHsIDS5gbBvSaBOEtcwYFGxzgTpUmNSi6bDr3qOJNJa13jezBIcjHZXB5chZvd
 R7TjutJJztN8C6s5qKtm7zWzp9C2CvzUwM9sqDUycIbsqYU7uNylOJyFYe7VJboZ9WAe
 cVI1e26GRUSeN/DZ2B5crIgL8lYyzUUNO5cmruNLuscbp5deIvsTlLxKI9GmKDg7KExq
 jm3tRY7YVdAxkRIfSVIYCTG/1yJVcpGaU8cwTdEDjdAnPFoDRDE/s5jITDtVYmrUv11r
 ovIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=5OzFI4RLkpdXjDByxRcdVYfducqwJu3a7ZWXjm5337c=;
 b=icadWvdwUcI7QUE2XrQHyMmP7+j/X/neIgMcyLPp+D5HlW3/qRK52KDnT+5Ap8O+e7
 7HL9/SkM3lmQOrShR7ECVLe/zumWH5Wm0eOBo082d7y7X5MzXBSYyQ1Mnq3ATs3thz7V
 ABx59a9/x2r2SCQ8IGycj6e6LoOAFEcAhCuWviaaTBZFiMAwKgiokrJYyA4J/0BN7EBb
 Xk+kQZs7/GzFtLJqvDd8+o+QUmBjUW7sF9YBCcDQpRaE06JZY4eeJSeB2YrwBd7bFlzz
 Kn6dcjc9BZI6hbEn9Ut7bUBqcNsqJLFnPgg06Kw3eQK+M3OxW+7T78kPS3+XHqArLKIh
 l7Fw==
X-Gm-Message-State: AOAM532PS6ZNDqk2v+zE9glJHQT/QChymtEz6tZmqFpwStMN6sxrgYUT
 r4COEmW9SsHGU0YI8Mhq8lcC9Q==
X-Google-Smtp-Source: ABdhPJzn0YvPf0NBwPK2G8zYqi9XkA2s+0ju4WQwnJNpvWJM9N1bluE1qz5m/4cuyRNydKXVxuL7Gw==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr501705wmq.92.1598865017159;
 Mon, 31 Aug 2020 02:10:17 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id t4sm11276634wre.30.2020.08.31.02.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 02:10:16 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 9e24171c;
 Mon, 31 Aug 2020 09:10:15 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v6 07/12] migration/dirtyrate: Compare page hash results
 for recorded sampled page
In-Reply-To: <1598669577-76914-8-git-send-email-zhengchuan@huawei.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <1598669577-76914-8-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Mon, 31 Aug 2020 10:10:15 +0100
Message-ID: <m23643chag.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::343;
 envelope-from=dme@dme.org; helo=mail-wm1-x343.google.com
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
Cc: alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 zhang.zhanghailiang@huawei.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Saturday, 2020-08-29 at 10:52:52 +08, Chuan Zheng wrote:

> Compare page hash results for recorded sampled page.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index f4967fd..9cc2cbb 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -193,6 +193,69 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>      return 0;
>  }
>  
> +static void calc_page_dirty_rate(struct RamblockDirtyInfo *info)
> +{
> +    uint32_t crc;
> +    int i;
> +
> +    for (i = 0; i < info->sample_pages_count; i++) {
> +        crc = get_ramblock_vfn_hash(info, info->sample_page_vfn[i]);
> +        if (crc != info->hash_result[i]) {
> +            info->sample_dirty_count++;
> +        }
> +    }
> +}
> +
> +static struct RamblockDirtyInfo *
> +find_page_matched(RAMBlock *block, int count,
> +                  struct RamblockDirtyInfo *infos)
> +{
> +    int i;
> +    struct RamblockDirtyInfo *matched;
> +
> +    for (i = 0; i < count; i++) {
> +        if (!strcmp(infos[i].idstr, qemu_ram_get_idstr(block))) {
> +            break;
> +        }
> +    }
> +
> +    if (i == count) {
> +        return NULL;
> +    }
> +
> +    if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
> +        infos[i].ramblock_pages !=
> +            (qemu_ram_get_used_length(block) >> TARGET_PAGE_BITS)) {
> +        return NULL;
> +    }
> +
> +    matched = &infos[i];
> +
> +    return matched;
> +}
> +
> +static int compare_page_hash_info(struct RamblockDirtyInfo *info,
> +                                  int block_index)
> +{
> +    struct RamblockDirtyInfo *block_dinfo = NULL;
> +    RAMBlock *block = NULL;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        block_dinfo = find_page_matched(block, block_index + 1, info);
> +        if (block_dinfo == NULL) {
> +            continue;
> +        }
> +        calc_page_dirty_rate(block_dinfo);
> +        update_dirtyrate_stat(block_dinfo);
> +    }
> +
> +    if (!DirtyStat.total_sample_count) {

total_sample_count isn't a boolean or pointer - comparing against 0
would be clearer.

> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> -- 
> 1.8.3.1

dme.
-- 
You can't hide from the flipside.

