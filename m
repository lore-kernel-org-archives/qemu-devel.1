Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A734C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304DE207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dD0tLbWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304DE207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8oPC-0005ZL-AZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8oOO-0004zB-PH
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8oOL-0001nN-Fb
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597944619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9AGH79gSCEKZEv/HWnXS1LHzN44MiCuUYW8sLLWd0Vs=;
 b=dD0tLbWte6DNJvqPIUYlL4oh7x9ncJn/npmYARO2296z7A6T+RM+ZFJF6lbxEybWthB7ZO
 xUP+hknva6qprHtutMuPze2QLeiby/DJN1b9Kly3KyjCG6b/XCa8A+fkEN7Cso0vputoiI
 r8yr6Vu7eHNJk5zHTU6sp5XdisGBea0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493--1yUtjXNMyqPrlHUvucmgA-1; Thu, 20 Aug 2020 13:30:15 -0400
X-MC-Unique: -1yUtjXNMyqPrlHUvucmgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 474A11885DBE;
 Thu, 20 Aug 2020 17:30:14 +0000 (UTC)
Received: from work-vm (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02B297A40B;
 Thu, 20 Aug 2020 17:30:11 +0000 (UTC)
Date: Thu, 20 Aug 2020 18:30:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 05/10] migration/dirtyrate: Record hash results for
 each sampled page
Message-ID: <20200820173009.GM2664@work-vm>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-6-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1597634433-18809-6-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:28:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
> Record hash results for each sampled page.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/dirtyrate.h |   7 +++
>  2 files changed, 151 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index c4304ef..62b6f69 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -25,6 +25,7 @@
>  #include "dirtyrate.h"
>  
>  CalculatingDirtyRateState CalculatingState = CAL_DIRTY_RATE_INIT;
> +static unsigned long int qcrypto_hash_len = QCRYPTO_HASH_LEN;

Why do we need this static rather than just using the QCRYPTO_HASH_LEN ?
It's never going to change is it?
(and anyway it's just a MD5 len?)

>  static struct DirtyRateStat dirty_stat;
>  
>  static int dirty_rate_set_state(int new_state)
> @@ -71,6 +72,149 @@ static void update_dirtyrate(uint64_t msec)
>      dirty_stat.dirty_rate = dirty_rate;
>  }
>  
> +/*
> + * get hash result for the sampled memory with length of 4K byte in ramblock,
> + * which starts from ramblock base address.
> + */
> +static int get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
> +                                 unsigned long vfn, uint8_t **md)
> +{
> +    struct iovec iov_array;
> +    int ret = 0;
> +    int nkey = 1;
> +    size_t hash_len = qcrypto_hash_len;
> +
> +    iov_array.iov_base = info->ramblock_addr +
> +                         vfn * DIRTYRATE_SAMPLE_PAGE_SIZE;
> +    iov_array.iov_len = DIRTYRATE_SAMPLE_PAGE_SIZE;
> +
> +    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_MD5,
> +                            &iov_array, nkey,
> +                            md, &hash_len, NULL) < 0) {
> +        ret = -1;
> +    }
> +
> +    return ret;
> +}
> +
> +static int save_ramblock_hash(struct RamblockDirtyInfo *info)
> +{
> +    unsigned int sample_pages_count;
> +    uint8_t *md = NULL;
> +    int i;
> +    int ret = -1;
> +    GRand *rand = g_rand_new();
> +
> +    sample_pages_count = info->sample_pages_count;
> +
> +    /* ramblock size less than one page, return success to skip this ramblock */
> +    if (unlikely(info->ramblock_pages == 0 || sample_pages_count == 0)) {
> +        ret = 0;
> +        goto out;
> +    }
> +
> +    info->hash_result = g_try_malloc0_n(sample_pages_count,
> +                                        sizeof(uint8_t) * qcrypto_hash_len);
> +    if (!info->hash_result) {
> +        ret = -1;
> +        goto out;
> +    }
> +
> +    info->sample_page_vfn = g_try_malloc0_n(sample_pages_count,
> +                                            sizeof(unsigned long));
> +    if (!info->sample_page_vfn) {
> +        g_free(info->hash_result);
> +        ret = -1;
> +        goto out;
> +    }
> +
> +    for (i = 0; i < sample_pages_count; i++) {
> +        md = info->hash_result + i * qcrypto_hash_len;
> +        info->sample_page_vfn[i] = g_rand_int_range(rand, 0,
> +                                                    info->ramblock_pages - 1);
> +        ret = get_ramblock_vfn_hash(info, info->sample_page_vfn[i], &md);
> +        if (ret < 0) {
> +            goto out;
> +        }
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
> +    info->sample_pages_count = (qemu_ram_get_used_length(block)
> +                                * sample_pages_per_gigabytes) >> 30;
> +
> +    /* Right shift 12 bits to calc page count in 4KB */
> +    info->ramblock_pages = qemu_ram_get_used_length(block) >> 12;

Is this really >> 12 ?  Should it actually be 
   / DIRTYRATE_SAMPLE_PAGE_SIZE ?

(and should you need that or just use TARGET_PAGE_SIZE?)

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
> +        block_dinfo = g_try_new(struct RamblockDirtyInfo, 1);
> +        index = 0;
> +    } else {
> +        index++;
> +        block_dinfo = g_try_realloc(block_dinfo, (index + 1) *
> +                                    sizeof(struct RamblockDirtyInfo));
> +    }
> +    if (!block_dinfo) {
> +        return NULL;
> +    }
> +
> +    info = &block_dinfo[index];
> +    memset(info, 0, sizeof(struct RamblockDirtyInfo));
> +
> +    *block_index = index;
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

You should add some trace_ calls at various places to make this easier
to debug.

Dave

> +}
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index af57c80..0812b16 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -20,10 +20,17 @@
>  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES            256
>  
>  /*
> + * Sample page size 4K as default.
> + */
> +#define DIRTYRATE_SAMPLE_PAGE_SIZE                4096
> +
> +/*
>   * Record ramblock idstr
>   */
>  #define RAMBLOCK_INFO_MAX_LEN                     256
>  
> +#define QCRYPTO_HASH_LEN                          16
> +
>  /* Take 1s as default for calculation duration */
>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>  
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


