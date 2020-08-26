Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B00C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2CC20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEbaxHGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2CC20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAub8-0004Uk-Hy
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAuZT-0003Nd-S3
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:30:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32373
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAuZQ-0005l6-F7
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598445027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DBRh+ePWetLMiemrM/QWce8ZqrbAkS5va6EvLPwALZs=;
 b=jEbaxHGeR59uHXnWhECmAJSNrLj6AYbTJLfOrko8NZ+0mXiHu57SXIKHRcNYH5i1SeFk/+
 7NW8BLrZ9t530Yt6tnCy+TVVsUX+fDruZl0E+CITfurU1sqddI7o1aGsC0Uxt6oncoV8v6
 XnyeTvMIVEZc9ip5dJ+Lx150T9Hcq9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-q0r-OpwbMj2jQ1D79P6WEA-1; Wed, 26 Aug 2020 08:30:23 -0400
X-MC-Unique: q0r-OpwbMj2jQ1D79P6WEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FFA81074649;
 Wed, 26 Aug 2020 12:30:21 +0000 (UTC)
Received: from work-vm (ovpn-114-48.ams2.redhat.com [10.36.114.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D0875FCA2;
 Wed, 26 Aug 2020 12:30:18 +0000 (UTC)
Date: Wed, 26 Aug 2020 13:30:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Edmondson <dme@dme.org>
Subject: Re: [PATCH v5 06/12] migration/dirtyrate: Record hash results for
 each sampled page
Message-ID: <20200826123016.GA2727@work-vm>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-7-git-send-email-zhengchuan@huawei.com>
 <m2eentlogl.fsf@dme.org>
MIME-Version: 1.0
In-Reply-To: <m2eentlogl.fsf@dme.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:16:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: alex.chen@huawei.com, berrange@redhat.com, zhang.zhanghailiang@huawei.com,
 quintela@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 Chuan Zheng <zhengchuan@huawei.com>, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Edmondson (dme@dme.org) wrote:
> On Monday, 2020-08-24 at 17:14:34 +08, Chuan Zheng wrote:
> 
> > Record hash results for each sampled page, crc32 is taken to calculate
> > hash results for each sampled 4K-page.
> >
> > Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> > Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> > ---
> >  migration/dirtyrate.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  migration/dirtyrate.h |  15 ++++++
> >  2 files changed, 151 insertions(+)
> >
> > diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> > index f6a94d8..66de426 100644
> > --- a/migration/dirtyrate.c
> > +++ b/migration/dirtyrate.c
> > @@ -10,6 +10,7 @@
> >   * See the COPYING file in the top-level directory.
> >   */
> >  
> > +#include <zlib.h>
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> >  #include "crypto/hash.h"
> > @@ -66,6 +67,141 @@ static void update_dirtyrate(uint64_t msec)
> >      DirtyStat.dirty_rate = dirtyrate;
> >  }
> >  
> > +/*
> > + * get hash result for the sampled memory with length of 4K byte in ramblock,
> > + * which starts from ramblock base address.
> > + */
> > +static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
> > +                                      uint64_t vfn)
> > +{
> > +    struct iovec iov_array;
> 
> There's no need for an iovec now that crc32() is being used.
> 
> > +    uint32_t crc;
> > +
> > +    iov_array.iov_base = info->ramblock_addr +
> > +                         vfn * DIRTYRATE_SAMPLE_PAGE_SIZE;
> > +    iov_array.iov_len = DIRTYRATE_SAMPLE_PAGE_SIZE;
> > +
> > +    crc = crc32(0, iov_array.iov_base, iov_array.iov_len);
> > +
> > +    return crc;
> > +}
> > +
> > +static int save_ramblock_hash(struct RamblockDirtyInfo *info)
> > +{
> > +    unsigned int sample_pages_count;
> > +    int i;
> > +    int ret = -1;
> 
> There's no need to initialise "ret".
> 
> > +    GRand *rand = g_rand_new();
> 
> Calling g_rand_new() when the result may not be used (because of the
> various conditions immediately below) seems as though it might waste
> entropy. Could this be pushed down just above the loop? It would even
> get rid of the gotos ;-)
> 
> > +    sample_pages_count = info->sample_pages_count;
> > +
> > +    /* ramblock size less than one page, return success to skip this ramblock */
> > +    if (unlikely(info->ramblock_pages == 0 || sample_pages_count == 0)) {
> > +        ret = 0;
> > +        goto out;
> > +    }
> > +
> > +    info->hash_result = g_try_malloc0_n(sample_pages_count,
> > +                                        sizeof(uint32_t));
> > +    if (!info->hash_result) {
> > +        ret = -1;
> > +        goto out;
> > +    }
> > +
> > +    info->sample_page_vfn = g_try_malloc0_n(sample_pages_count,
> > +                                            sizeof(uint64_t));
> > +    if (!info->sample_page_vfn) {
> > +        g_free(info->hash_result);
> > +        ret = -1;
> > +        goto out;
> > +    }
> > +
> > +    for (i = 0; i < sample_pages_count; i++) {
> > +        info->sample_page_vfn[i] = g_rand_int_range(rand, 0,
> > +                                                    info->ramblock_pages - 1);
> > +        info->hash_result[i] = get_ramblock_vfn_hash(info,
> > +                                                     info->sample_page_vfn[i]);
> > +    }
> > +    ret = 0;
> > +
> > +out:
> > +    g_rand_free(rand);
> > +    return ret;
> > +}
> > +
> > +static void get_ramblock_dirty_info(RAMBlock *block,
> > +                                    struct RamblockDirtyInfo *info,
> > +                                    struct DirtyRateConfig *config)
> > +{
> > +    uint64_t sample_pages_per_gigabytes = config->sample_pages_per_gigabytes;
> > +
> > +    /* Right shift 30 bits to calc block size in GB */
> > +    info->sample_pages_count = (qemu_ram_get_used_length(block) *
> > +                                sample_pages_per_gigabytes) >>
> > +                                DIRTYRATE_PAGE_SHIFT_GB;
> 
> Doing the calculation this way around seems odd. Why was it not:
> 
>     info->sample_pages_count = (qemu_ram_get_used_length(block) >>
>                                 DIRTYRATE_PAGE_SHIFT_GB) *
>                                 sample_pages_per_gigabytes;
> 
> ?

Because that would give 0 for a 0.5GB block

Dave

> > +
> > +    /* Right shift 12 bits to calc page count in 4KB */
> > +    info->ramblock_pages = qemu_ram_get_used_length(block) >>
> > +                           DIRTYRATE_PAGE_SHIFT_KB;
> > +    info->ramblock_addr = qemu_ram_get_host_addr(block);
> > +    strcpy(info->idstr, qemu_ram_get_idstr(block));
> > +}
> > +
> > +static struct RamblockDirtyInfo *
> > +alloc_ramblock_dirty_info(int *block_index,
> > +                          struct RamblockDirtyInfo *block_dinfo)
> > +{
> > +    struct RamblockDirtyInfo *info = NULL;
> > +    int index = *block_index;
> > +
> > +    if (!block_dinfo) {
> > +        index = 0;
> > +        block_dinfo = g_try_new(struct RamblockDirtyInfo, 1);
> > +    } else {
> > +        index++;
> > +        block_dinfo = g_try_realloc(block_dinfo, (index + 1) *
> > +                                    sizeof(struct RamblockDirtyInfo));
> 
> g_try_renew() instead of g_try_realloc()?
> 
> > +    }
> > +    if (!block_dinfo) {
> > +        return NULL;
> > +    }
> > +
> > +    info = &block_dinfo[index];
> > +    *block_index = index;
> > +    memset(info, 0, sizeof(struct RamblockDirtyInfo));
> > +
> > +    return block_dinfo;
> > +}
> > +
> > +static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
> > +                                     struct DirtyRateConfig config,
> > +                                     int *block_index)
> > +{
> > +    struct RamblockDirtyInfo *info = NULL;
> > +    struct RamblockDirtyInfo *dinfo = NULL;
> > +    RAMBlock *block = NULL;
> 
> There's no need to initialise "info" or "block".
> 
> The declaration of "info" could be pushed into the loop.
> 
> > +    int index = 0;
> > +
> > +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> > +        dinfo = alloc_ramblock_dirty_info(&index, dinfo);
> > +        if (dinfo == NULL) {
> > +            return -1;
> > +        }
> > +        info = &dinfo[index];
> > +        get_ramblock_dirty_info(block, info, &config);
> > +        if (save_ramblock_hash(info) < 0) {
> > +            *block_dinfo = dinfo;
> > +            *block_index = index;
> > +            return -1;
> > +        }
> > +    }
> > +
> > +    *block_dinfo = dinfo;
> > +    *block_index = index;
> > +
> > +    return 0;
> > +}
> > +
> >  static void calculate_dirtyrate(struct DirtyRateConfig config)
> >  {
> >      /* todo */
> > diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> > index 9db269d..5050add 100644
> > --- a/migration/dirtyrate.h
> > +++ b/migration/dirtyrate.h
> > @@ -24,6 +24,21 @@
> >   */
> >  #define RAMBLOCK_INFO_MAX_LEN                     256
> >  
> > +/*
> > + * Sample page size 4K as default.
> > + */
> > +#define DIRTYRATE_SAMPLE_PAGE_SIZE                4096
> > +
> > +/*
> > + * Sample page size 4K shift
> > + */
> > +#define DIRTYRATE_PAGE_SHIFT_KB                   12
> > +
> > +/*
> > + * Sample page size 1G shift
> > + */
> > +#define DIRTYRATE_PAGE_SHIFT_GB                   30
> > +
> >  /* Take 1s as default for calculation duration */
> >  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
> >  
> > -- 
> > 1.8.3.1
> 
> dme.
> -- 
> You bring light in.
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


