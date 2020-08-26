Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8022AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B201206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="Wn7ytF5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B201206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsPC-00006r-IL
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsOO-00085L-D0
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:10:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsOM-0004Aq-Kk
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:10:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id q14so1198661wrn.9
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=L5HWJYfB6pDygSM9chcj4L5PnsK9E+tjUJFHOpZtJak=;
 b=Wn7ytF5QijnEdmdfaumBKt94WgZboPvmMPB0PXcHGocmV4WbdYJ/lFnEE6IiZMLO+b
 Aizs1MT6TqXe/1MJb+hNLBh0Ss6QU/OMG3Myb7qodMqvifI5s5j666bSetoqW/WuIYcg
 KdhFN7PeDs7aqPiSXDXB5ZfqErUCzbHU2CI822t0NXP0ff+OKNuWnO7gzFmNfPOwXWUj
 D3Lo3WcbhPewcvZ9MORgg4veVh0Dj5bqeWK+fUOTKS0Qrxfea7UNZZHWELubhzAuHuLN
 neDZz7cyjNoW8Qi1d7ArsHy4yT/tfVmW+Nb0ks3Xi0+YNjxcu39MuVC5IcoBqF0Z/rkJ
 A3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=L5HWJYfB6pDygSM9chcj4L5PnsK9E+tjUJFHOpZtJak=;
 b=B2TyVQ+g7Rflde6IhC4YjM/UB6ff7LnrPs7KYcHTNE0Mbw2f/XdLy0CvU3SLa8RFEg
 0FLmV5yQbBkCG5AedlZFons67JjTesuKfgib1Ofi0cFb2DDw06SErDEKhufJxrasqd8a
 R3N5rwnasRKQHEWIc6hsji+iFr5mp5hkuK4wIjI/lEyV55wXLjg34DI1zy0zulUhOJws
 OtLQXJ1h5U+CheiIZ+Kz0JBcPkUjMjwgwF5M9l8pj+mPHZNEw28GQxS/nsSBM0lwwdYl
 6nNUQ5SkQ24zQ+ywA47406zfcyd0leu/1mNuBoOD2+ZW3f2lC0AVz1AnLrug+RHTdwWP
 TsmA==
X-Gm-Message-State: AOAM530RWXmQSfCh+ZYDWjnAG/SM1NEjcIKhtGyXmUHL6rr2sEn7+qCA
 LyiNcgNYeGjDWG4xNB4/b9RhBXaMGldzC0K4Rn0=
X-Google-Smtp-Source: ABdhPJwlsoQuYEFhZlrEr8YwqEZtpFHxT2LSrAfu6BJQvzh00EWmG5KD8wEttqechqhxXoTgwp06gQ==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr14531018wru.273.1598436648893; 
 Wed, 26 Aug 2020 03:10:48 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id o125sm4822186wma.27.2020.08.26.03.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 03:10:48 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 213f46ba;
 Wed, 26 Aug 2020 10:10:41 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 07/12] migration/dirtyrate: Compare page hash results
 for recorded sampled page
In-Reply-To: <1598260480-64862-8-git-send-email-zhengchuan@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-8-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 26 Aug 2020 11:10:41 +0100
Message-ID: <m2blixlntq.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::441;
 envelope-from=dme@dme.org; helo=mail-wr1-x441.google.com
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

On Monday, 2020-08-24 at 17:14:35 +08, Chuan Zheng wrote:

> Compare page hash results for recorded sampled page.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 66de426..050270d 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -202,6 +202,70 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>      return 0;
>  }
>  
> +static int calc_page_dirty_rate(struct RamblockDirtyInfo *info)

This never fails - could be void?

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
> +
> +    return 0;
> +}
> +
> +static bool find_page_matched(RAMBlock *block, struct RamblockDirtyInfo *infos,
> +                              int count, struct RamblockDirtyInfo **matched)

This might as well just return a struct RamblockDirtyInfo pointer (or NULL).

> +{
> +    int i;
> +
> +    for (i = 0; i < count; i++) {
> +        if (!strcmp(infos[i].idstr, qemu_ram_get_idstr(block))) {
> +            break;
> +        }
> +    }
> +
> +    if (i == count) {
> +        return false;
> +    }
> +
> +    if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
> +        infos[i].ramblock_pages !=
> +            (qemu_ram_get_used_length(block) >> DIRTYRATE_PAGE_SHIFT_KB)) {
> +        return false;
> +    }
> +
> +    *matched = &infos[i];
> +    return true;
> +}
> +
> +static int compare_page_hash_info(struct RamblockDirtyInfo *info,
> +                                  int block_index)
> +{
> +    struct RamblockDirtyInfo *block_dinfo = NULL;
> +    RAMBlock *block = NULL;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        block_dinfo = NULL;
> +        if (!find_page_matched(block, info, block_index + 1, &block_dinfo)) {
> +            continue;
> +        }
> +        if (calc_page_dirty_rate(block_dinfo) < 0) {
> +            return -1;
> +        }
> +        update_dirtyrate_stat(block_dinfo);
> +    }
> +
> +    if (!DirtyStat.total_sample_count) {
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
Sometimes these eyes, forget the face they're peering from.

