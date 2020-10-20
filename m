Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C753C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824E62223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A57luXZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824E62223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUlvJ-00032f-6O
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 03:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUlud-0002WK-7e
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUlub-0007ST-7G
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603178304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5whCByInRohaD/N1ToYjA9G/lEurrwTJDsyTjoPr9rE=;
 b=A57luXZdV2KOyVY6mA5SJUKAGznGCNN4uZ9l3uzxReSCyeC4OwS5OKFePaMHa8GLXLR8HV
 nyLTahPhqIg4cna5hwHLXl7P1D4Q4pvn3nGuPZ4vlwTZ2m5MTQr2nXEBB9FI45u/H3KnHO
 HBHkl86TBalG4UNiXBRJelDrZoTuVvQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-0mRm4wZyMHqWR-ukn66BLA-1; Tue, 20 Oct 2020 03:18:20 -0400
X-MC-Unique: 0mRm4wZyMHqWR-ukn66BLA-1
Received: by mail-wr1-f70.google.com with SMTP id r8so431127wrp.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 00:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5whCByInRohaD/N1ToYjA9G/lEurrwTJDsyTjoPr9rE=;
 b=NgQ/3FwTIQKluAZeKEYstPjHktCR8sGqjHApyOa3dMomcc5Q2+qAXlhZTZzcTWBiuO
 /TkK0IC5AbgyOUaGu8DAZaOOaHfIKxYFkh799020rBsNxzdPCsPZqFlts7OK5zk+ctKr
 US1YzTFstASZyCM55BsiByIaP0ZE0h2GmbRvZME3CNfX9m7Z3ylJ8Nww/fbxYWwmq0ug
 fhWCeqVCJN8MhnyxYVnrybe2HBd76dP+2drqR/pkrq+fTsPcM5JOiWWQ3C5svHKNgiPz
 ErHZcsm+KMSsDVBBupSS7SofQt15Yhnbd8m5cu4tip2H8pLjTSn5qJOqj6/q5V79yMQj
 ZT9A==
X-Gm-Message-State: AOAM531xA7uCJkHcKlnLbMU+5wqA1IfMlcw8g7o7PaK3CJy/skuN0265
 Hu+DfDSJoJHXRhncIjhUaXKUo6rMpZexyeQ9wl3dGNpAT8HOmcB5d5uJSxnkVIPYLGUWsgNb9xM
 VSDMCFz/pzeYOvyA=
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr1883332wrw.132.1603178298971; 
 Tue, 20 Oct 2020 00:18:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdU/uWVLGNSkBkyhZ22V9UVC+Mu2WAZkZXJrezce/VH84UAu99quPoYeLWvLtarW2+W9Tiyw==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr1883292wrw.132.1603178298650; 
 Tue, 20 Oct 2020 00:18:18 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s5sm1276665wmc.3.2020.10.20.00.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 00:18:17 -0700 (PDT)
Subject: Re: [PATCH v2] migration: using trace_ to replace DPRINTF
To: Bihong Yu <yubihong@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <1603176121-750-1-git-send-email-yubihong@huawei.com>
 <961ca8e2-edf1-fe11-d46e-ac276668d5af@redhat.com>
 <4b9655cf-f6fb-e1ab-148d-2b88d71a59a8@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6cb6b4d-c0d0-5dab-479b-d778716ff67d@redhat.com>
Date: Tue, 20 Oct 2020 09:18:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <4b9655cf-f6fb-e1ab-148d-2b88d71a59a8@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: alex.chen@huawei.com, zhengchuan@huawei.com, wanghao232@huawei.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 9:07 AM, Bihong Yu wrote:
> 
> 
> On 2020/10/20 14:54, Philippe Mathieu-Daudé wrote:
>> On 10/20/20 8:42 AM, Bihong Yu wrote:
>>> Signed-off-by: Bihong Yu <yubihong@huawei.com>
>>> ---
>>>    migration/block.c      | 36 ++++++++++++++++++------------------
>>>    migration/page_cache.c | 13 +++----------
>>>    migration/trace-events | 13 +++++++++++++
>>>    3 files changed, 34 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/migration/block.c b/migration/block.c
>>> index 273392b..1e76a9f 100644
>>> --- a/migration/block.c
>>> +++ b/migration/block.c
>>> @@ -26,6 +26,7 @@
>>>    #include "qemu-file.h"
>>>    #include "migration/vmstate.h"
>>>    #include "sysemu/block-backend.h"
>>> +#include "trace.h"
>>>      #define BLK_MIG_BLOCK_SIZE           (1 << 20)
>>>    #define BDRV_SECTORS_PER_DIRTY_CHUNK (BLK_MIG_BLOCK_SIZE >> BDRV_SECTOR_BITS)
>>> @@ -434,10 +435,9 @@ static int init_blk_migration(QEMUFile *f)
>>>            block_mig_state.total_sector_sum += sectors;
>>>              if (bmds->shared_base) {
>>> -            DPRINTF("Start migration for %s with shared base image\n",
>>> -                    bdrv_get_device_name(bs));
>>> +            trace_init_blk_migration_shared(bdrv_get_device_name(bs));
>>>            } else {
>>> -            DPRINTF("Start full migration for %s\n", bdrv_get_device_name(bs));
>>> +            trace_init_blk_migration_full(bdrv_get_device_name(bs));
>>>            }
>>>              QSIMPLEQ_INSERT_TAIL(&block_mig_state.bmds_list, bmds, entry);
>>> @@ -592,7 +592,7 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
>>>        return (bmds->cur_dirty >= bmds->total_sectors);
>>>      error:
>>> -    DPRINTF("Error reading sector %" PRId64 "\n", sector);
>>> +    trace_mig_save_device_dirty(sector);
>>>        g_free(blk->buf);
>>>        g_free(blk);
>>>        return ret;
>>> @@ -628,9 +628,9 @@ static int flush_blks(QEMUFile *f)
>>>        BlkMigBlock *blk;
>>>        int ret = 0;
>>>    -    DPRINTF("%s Enter submitted %d read_done %d transferred %d\n",
>>> -            __func__, block_mig_state.submitted, block_mig_state.read_done,
>>> -            block_mig_state.transferred);
>>> +    trace_flush_blks("Enter", block_mig_state.submitted,
>>> +                     block_mig_state.read_done,
>>> +                     block_mig_state.transferred);
>>>          blk_mig_lock();
>>>        while ((blk = QSIMPLEQ_FIRST(&block_mig_state.blk_list)) != NULL) {
>>> @@ -656,9 +656,9 @@ static int flush_blks(QEMUFile *f)
>>>        }
>>>        blk_mig_unlock();
>>>    -    DPRINTF("%s Exit submitted %d read_done %d transferred %d\n", __func__,
>>> -            block_mig_state.submitted, block_mig_state.read_done,
>>> -            block_mig_state.transferred);
>>> +    trace_flush_blks("Exit", block_mig_state.submitted,
>>> +                     block_mig_state.read_done,
>>> +                     block_mig_state.transferred);
>>>        return ret;
>>>    }
>>>    @@ -727,8 +727,8 @@ static int block_save_setup(QEMUFile *f, void *opaque)
>>>    {
>>>        int ret;
>>>    -    DPRINTF("Enter save live setup submitted %d transferred %d\n",
>>> -            block_mig_state.submitted, block_mig_state.transferred);
>>> +    trace_migration_block_save("setup", block_mig_state.submitted,
>>> +                               block_mig_state.transferred);
>>>          qemu_mutex_lock_iothread();
>>>        ret = init_blk_migration(f);
>>> @@ -759,8 +759,8 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
>>>        int64_t last_ftell = qemu_ftell(f);
>>>        int64_t delta_ftell;
>>>    -    DPRINTF("Enter save live iterate submitted %d transferred %d\n",
>>> -            block_mig_state.submitted, block_mig_state.transferred);
>>> +    trace_migration_block_save("iterate", block_mig_state.submitted,
>>> +                               block_mig_state.transferred);
>>>          ret = flush_blks(f);
>>>        if (ret) {
>>> @@ -825,8 +825,8 @@ static int block_save_complete(QEMUFile *f, void *opaque)
>>>    {
>>>        int ret;
>>>    -    DPRINTF("Enter save live complete submitted %d transferred %d\n",
>>> -            block_mig_state.submitted, block_mig_state.transferred);
>>> +    trace_migration_block_save("complete", block_mig_state.submitted,
>>> +                               block_mig_state.transferred);
>>>          ret = flush_blks(f);
>>>        if (ret) {
>>> @@ -851,7 +851,7 @@ static int block_save_complete(QEMUFile *f, void *opaque)
>>>        /* report completion */
>>>        qemu_put_be64(f, (100 << BDRV_SECTOR_BITS) | BLK_MIG_FLAG_PROGRESS);
>>>    -    DPRINTF("Block migration completed\n");
>>> +    trace_migration_block_save_complete();
>>>          qemu_put_be64(f, BLK_MIG_FLAG_EOS);
>>>    @@ -884,7 +884,7 @@ static void block_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
>>>            pending = max_size + BLK_MIG_BLOCK_SIZE;
>>>        }
>>>    -    DPRINTF("Enter save live pending  %" PRIu64 "\n", pending);
>>> +    trace_migration_block_save_pending(pending);
>>>        /* We don't do postcopy */
>>>        *res_precopy_only += pending;
>>>    }
>>> diff --git a/migration/page_cache.c b/migration/page_cache.c
>>> index 775582f..d554efa 100644
>>> --- a/migration/page_cache.c
>>> +++ b/migration/page_cache.c
>>> @@ -18,14 +18,7 @@
>>>    #include "qapi/error.h"
>>>    #include "qemu/host-utils.h"
>>>    #include "page_cache.h"
>>> -
>>> -#ifdef DEBUG_CACHE
>>> -#define DPRINTF(fmt, ...) \
>>> -    do { fprintf(stdout, "cache: " fmt, ## __VA_ARGS__); } while (0)
>>> -#else
>>> -#define DPRINTF(fmt, ...) \
>>> -    do { } while (0)
>>> -#endif
>>> +#include "trace.h"
>>>      /* the page in cache will not be replaced in two cycles */
>>>    #define CACHED_PAGE_LIFETIME 2
>>> @@ -75,7 +68,7 @@ PageCache *cache_init(int64_t new_size, size_t page_size, Error **errp)
>>>        cache->num_items = 0;
>>>        cache->max_num_items = num_pages;
>>>    -    DPRINTF("Setting cache buckets to %" PRId64 "\n", cache->max_num_items);
>>> +    trace_cache_init(cache->max_num_items);
>>>          /* We prefer not to abort if there is no memory */
>>>        cache->page_cache = g_try_malloc((cache->max_num_items) *
>>> @@ -169,7 +162,7 @@ int cache_insert(PageCache *cache, uint64_t addr, const uint8_t *pdata,
>>>        if (!it->it_data) {
>>>            it->it_data = g_try_malloc(cache->page_size);
>>>            if (!it->it_data) {
>>> -            DPRINTF("Error allocating page\n");
>>> +            trace_cache_insert();
>>>                return -1;
>>>            }
>>>            cache->num_items++;
>>> diff --git a/migration/trace-events b/migration/trace-events
>>> index 338f38b..094dbe4 100644
>>> --- a/migration/trace-events
>>> +++ b/migration/trace-events
>>> @@ -325,3 +325,16 @@ get_ramblock_vfn_hash(const char *idstr, uint64_t vfn, uint32_t crc) "ramblock n
>>>    calc_page_dirty_rate(const char *idstr, uint32_t new_crc, uint32_t old_crc) "ramblock name: %s, new crc: %" PRIu32 ", old crc: %" PRIu32
>>>    skip_sample_ramblock(const char *idstr, uint64_t ramblock_size) "ramblock name: %s, ramblock size: %" PRIu64
>>>    find_page_matched(const char *idstr) "ramblock %s addr or size changed"
>>> +
>>> +# block.c
>>> +init_blk_migration_shared(const char *blk_device_name) "Start migration for %s with shared base image"
>>> +init_blk_migration_full(const char *blk_device_name) "Start full migration for %s"
>>> +mig_save_device_dirty(int64_t sector) "Error reading sector %" PRId64
>>> +flush_blks(const char *action, int submitted, int read_done, int transferred) "%s submitted %d read_done %d transferred %d"
>>
>> When using tracing, you usually start with a global pattern,
>> then slowly remove events until tracing the particular one
>> interesting you. As these all belong to the same subsystem,
>> please use "migration_block_" prefix for all.
> 
> All migration block file trace function need add "migration_block_"? Such as:
> migration_block_init_blk_migration_shared()

   -> migration_block_init_shared

> migration_block_init_blk_migration_full()

   -> migration_block_init_full

> ...
> 
>>
>>> +migration_block_save(const char *mig_stage, int submitted, int transferred) "Enter save live %s submitted %d transferred %d"
>>> +migration_block_save_complete(void) "Block migration completed"
>>> +migration_block_save_pending(uint64_t pending) "Enter save live pending  %" PRIu64
>>
>> These are good.
>>
>>> +
>>> +# page_cache.c
>>> +cache_init(int64_t max_num_items) "Setting cache buckets to %" PRId64
>>> +cache_insert(void) "Error allocating page"
>>
>> Please use "migration_block_" prefix here too.
> 
> Do you mean using "migration_" prefix? Such as:
> migration_cache_init()
> migration_cache_insert()
> ...

Yes ;) Or even:

  - migration_pagecache_init
  - migration_pagecache_insert

> 
>>
>> Regards,
>>
>> Phil.
>>
>> .
> 


