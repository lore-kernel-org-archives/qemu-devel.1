Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFEBC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7529E2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="xq/HKXQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7529E2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsBb-0002Ik-Oz
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsAx-0001Jr-O8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:57:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsAv-0002Qd-O3
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:57:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id 2so1153145wrj.10
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=OkE4twQNLKQTC4xnPP54Lys5DeFRvKEulNpiBD8kuRM=;
 b=xq/HKXQRFQmBkp/RVTJKh/oPPTZ2A0bJyPL1ev+GiXNQbyhHH2r+aU7yUgMCfAKVyu
 nPYZgt4tIjW2BYIetW+IxbGwKGY8DxbWM/Evzudk44a52MdlBxByXj1ZBIZLlGjdhHTI
 DHlm1bv2CRuhQ/6m8Z+5YKAnA3hSTOU7DjABeilWfP6iq7vvNQxfP0CLU8UUElauWm6Y
 wO7IyogMhFYGtwtxzAT+s8VmQLqQgCLbBt96hqgGBrDOMEEtq8G1tZgMgLfJWQv5ycKE
 twI6Vg/JamoAl/YXjxQn7w0zMe88rGOniNtdDUSUFHJXhVTLvTMlyLlfUkQxLlwEQaUB
 K+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=OkE4twQNLKQTC4xnPP54Lys5DeFRvKEulNpiBD8kuRM=;
 b=NlZPkaOnnGN1S9GWJuzto9g4xQssAnXTE+NPflmc3NUGnelXhI8WdZaYBoGndtl1kj
 ZHz9C1Mk5wMXQ0yKfq85NwE2UiAZwzoNhGTgCQo1Fbg0gwnXjezuJuLRU/UMao9pff+0
 ZO1neFZkHj4nwaDT/wXYH7rtQrNdOMHUlcQTkEiPK6gC7PvdI/i2VcI8EXHrKpaeRgcH
 uWNf6FFq/OnI9a+vKaPxxJ4ZJ8yXPFk1gqF+JupT0Fx32FmWXy2pYjRF6ucp/UhHly2E
 w3k3j8+/N7wydDGdyOhY1YeRL+Ks1hsz3gs0Aylsn9hnpYiU+8BdPXOhPz90hnrZyqEk
 RbxQ==
X-Gm-Message-State: AOAM530Y7CD5ioD8MlEihAv89O23kapEOZL8M4jaUxzV8P/X0A7XraOl
 sfA9oJ5+9Hr6rxoiodnUuHo0GA==
X-Google-Smtp-Source: ABdhPJxlk6MmlFptPWlJvV/QyYlDbzCSQLFNhG6O7EAchzjzXwVcUu6vAIoAkSlY/mkBsIA6Y1A0Rw==
X-Received: by 2002:a5d:6942:: with SMTP id r2mr10765918wrw.76.1598435820087; 
 Wed, 26 Aug 2020 02:57:00 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id u7sm4448972wmb.16.2020.08.26.02.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 02:56:59 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 066483e7;
 Wed, 26 Aug 2020 09:56:58 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 06/12] migration/dirtyrate: Record hash results for
 each sampled page
In-Reply-To: <1598260480-64862-7-git-send-email-zhengchuan@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-7-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 26 Aug 2020 10:56:58 +0100
Message-ID: <m2eentlogl.fsf@dme.org>
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

On Monday, 2020-08-24 at 17:14:34 +08, Chuan Zheng wrote:

> Record hash results for each sampled page, crc32 is taken to calculate
> hash results for each sampled 4K-page.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/dirtyrate.h |  15 ++++++
>  2 files changed, 151 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index f6a94d8..66de426 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -10,6 +10,7 @@
>   * See the COPYING file in the top-level directory.
>   */
>  
> +#include <zlib.h>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "crypto/hash.h"
> @@ -66,6 +67,141 @@ static void update_dirtyrate(uint64_t msec)
>      DirtyStat.dirty_rate = dirtyrate;
>  }
>  
> +/*
> + * get hash result for the sampled memory with length of 4K byte in ramblock,
> + * which starts from ramblock base address.
> + */
> +static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
> +                                      uint64_t vfn)
> +{
> +    struct iovec iov_array;

There's no need for an iovec now that crc32() is being used.

> +    uint32_t crc;
> +
> +    iov_array.iov_base = info->ramblock_addr +
> +                         vfn * DIRTYRATE_SAMPLE_PAGE_SIZE;
> +    iov_array.iov_len = DIRTYRATE_SAMPLE_PAGE_SIZE;
> +
> +    crc = crc32(0, iov_array.iov_base, iov_array.iov_len);
> +
> +    return crc;
> +}
> +
> +static int save_ramblock_hash(struct RamblockDirtyInfo *info)
> +{
> +    unsigned int sample_pages_count;
> +    int i;
> +    int ret = -1;

There's no need to initialise "ret".

> +    GRand *rand = g_rand_new();

Calling g_rand_new() when the result may not be used (because of the
various conditions immediately below) seems as though it might waste
entropy. Could this be pushed down just above the loop? It would even
get rid of the gotos ;-)

> +    sample_pages_count = info->sample_pages_count;
> +
> +    /* ramblock size less than one page, return success to skip this ramblock */
> +    if (unlikely(info->ramblock_pages == 0 || sample_pages_count == 0)) {
> +        ret = 0;
> +        goto out;
> +    }
> +
> +    info->hash_result = g_try_malloc0_n(sample_pages_count,
> +                                        sizeof(uint32_t));
> +    if (!info->hash_result) {
> +        ret = -1;
> +        goto out;
> +    }
> +
> +    info->sample_page_vfn = g_try_malloc0_n(sample_pages_count,
> +                                            sizeof(uint64_t));
> +    if (!info->sample_page_vfn) {
> +        g_free(info->hash_result);
> +        ret = -1;
> +        goto out;
> +    }
> +
> +    for (i = 0; i < sample_pages_count; i++) {
> +        info->sample_page_vfn[i] = g_rand_int_range(rand, 0,
> +                                                    info->ramblock_pages - 1);
> +        info->hash_result[i] = get_ramblock_vfn_hash(info,
> +                                                     info->sample_page_vfn[i]);
> +    }
> +    ret = 0;
> +
> +out:
> +    g_rand_free(rand);
> +    return ret;
> +}
> +
> +static void get_ramblock_dirty_info(RAMBlock *block,
> +                                    struct RamblockDirtyInfo *info,
> +                                    struct DirtyRateConfig *config)
> +{
> +    uint64_t sample_pages_per_gigabytes = config->sample_pages_per_gigabytes;
> +
> +    /* Right shift 30 bits to calc block size in GB */
> +    info->sample_pages_count = (qemu_ram_get_used_length(block) *
> +                                sample_pages_per_gigabytes) >>
> +                                DIRTYRATE_PAGE_SHIFT_GB;

Doing the calculation this way around seems odd. Why was it not:

    info->sample_pages_count = (qemu_ram_get_used_length(block) >>
                                DIRTYRATE_PAGE_SHIFT_GB) *
                                sample_pages_per_gigabytes;

?

> +
> +    /* Right shift 12 bits to calc page count in 4KB */
> +    info->ramblock_pages = qemu_ram_get_used_length(block) >>
> +                           DIRTYRATE_PAGE_SHIFT_KB;
> +    info->ramblock_addr = qemu_ram_get_host_addr(block);
> +    strcpy(info->idstr, qemu_ram_get_idstr(block));
> +}
> +
> +static struct RamblockDirtyInfo *
> +alloc_ramblock_dirty_info(int *block_index,
> +                          struct RamblockDirtyInfo *block_dinfo)
> +{
> +    struct RamblockDirtyInfo *info = NULL;
> +    int index = *block_index;
> +
> +    if (!block_dinfo) {
> +        index = 0;
> +        block_dinfo = g_try_new(struct RamblockDirtyInfo, 1);
> +    } else {
> +        index++;
> +        block_dinfo = g_try_realloc(block_dinfo, (index + 1) *
> +                                    sizeof(struct RamblockDirtyInfo));

g_try_renew() instead of g_try_realloc()?

> +    }
> +    if (!block_dinfo) {
> +        return NULL;
> +    }
> +
> +    info = &block_dinfo[index];
> +    *block_index = index;
> +    memset(info, 0, sizeof(struct RamblockDirtyInfo));
> +
> +    return block_dinfo;
> +}
> +
> +static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
> +                                     struct DirtyRateConfig config,
> +                                     int *block_index)
> +{
> +    struct RamblockDirtyInfo *info = NULL;
> +    struct RamblockDirtyInfo *dinfo = NULL;
> +    RAMBlock *block = NULL;

There's no need to initialise "info" or "block".

The declaration of "info" could be pushed into the loop.

> +    int index = 0;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        dinfo = alloc_ramblock_dirty_info(&index, dinfo);
> +        if (dinfo == NULL) {
> +            return -1;
> +        }
> +        info = &dinfo[index];
> +        get_ramblock_dirty_info(block, info, &config);
> +        if (save_ramblock_hash(info) < 0) {
> +            *block_dinfo = dinfo;
> +            *block_index = index;
> +            return -1;
> +        }
> +    }
> +
> +    *block_dinfo = dinfo;
> +    *block_index = index;
> +
> +    return 0;
> +}
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 9db269d..5050add 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -24,6 +24,21 @@
>   */
>  #define RAMBLOCK_INFO_MAX_LEN                     256
>  
> +/*
> + * Sample page size 4K as default.
> + */
> +#define DIRTYRATE_SAMPLE_PAGE_SIZE                4096
> +
> +/*
> + * Sample page size 4K shift
> + */
> +#define DIRTYRATE_PAGE_SHIFT_KB                   12
> +
> +/*
> + * Sample page size 1G shift
> + */
> +#define DIRTYRATE_PAGE_SHIFT_GB                   30
> +
>  /* Take 1s as default for calculation duration */
>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>  
> -- 
> 1.8.3.1

dme.
-- 
You bring light in.

