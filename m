Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCB0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98224207FC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA40wvnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98224207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k30LE-0008Iu-OV
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k30JE-0006jz-Gw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:01:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k30J9-0005J1-3z
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596560457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qh20odD/rIeRxJAmh+Wmge1s8G/S92GMunCmVMmNXdE=;
 b=EA40wvnv8leHz+24tmY1hiOpF0pdohJeYGBPyW3nt7EE/s9plZhqcEcc4Ndny524ukjGGT
 0PE1rIce6mUz2VjKuQKJZqm/LvyPAOps/qgBiV5QuBNCZ+BvFowseCxNzVT6pNAlKr0VtE
 93EH07wFjMD54VCLhrhk+6haVv5Wp0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-v0GBNxssOv6p2t3B7evdtA-1; Tue, 04 Aug 2020 13:00:41 -0400
X-MC-Unique: v0GBNxssOv6p2t3B7evdtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D78580183C;
 Tue,  4 Aug 2020 17:00:39 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AFC55DA73;
 Tue,  4 Aug 2020 17:00:36 +0000 (UTC)
Date: Tue, 4 Aug 2020 18:00:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 4/8] migration/dirtyrate: Record hash results for
 each ramblock
Message-ID: <20200804170033.GG2659@work-vm>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-5-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1595646669-109310-5-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Record hash results for each ramblock.

Please be careful when talking about 'ramblock' since we already use
that for a chunk of memory in QEMU.

> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/dirtyrate.h |   1 +
>  2 files changed, 158 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 6baf674..45cfc91 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -10,12 +10,27 @@
>   * See the COPYING file in the top-level directory.
>   */
>  
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "crypto/hash.h"
> +#include "crypto/random.h"
> +#include "qemu/config-file.h"
> +#include "exec/memory.h"
> +#include "exec/ramblock.h"
> +#include "exec/target_page.h"
> +#include "qemu/rcu_queue.h"
> +#include "qapi/qapi-commands-migration.h"
> +#include "migration.h"
>  #include "dirtyrate.h"
>  
>  static uint64_t sample_pages_per_gigabytes = DIRTYRATE_DEFAULT_SAMPLE_PAGES;
>  static struct dirtyrate_statistics dirty_stat;
>  CalculatingDirtyRateStage calculating_dirty_rate_stage = CAL_DIRTY_RATE_INIT;
>  
> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> +        INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (!qemu_ram_is_migratable(block)) {} else
> +

Instead of redefining this here, please move the existing definition up
into migration/ram.h ?

>  static void reset_dirtyrate_stat(void)
>  {
>      dirty_stat.total_dirty_samples = 0;
> @@ -44,6 +59,148 @@ static void update_dirtyrate(int64_t msec)
>      dirty_stat.dirty_rate = dirty_rate;
>  }
>  
> +static int get_block_vfn_hash(struct block_dirty_info *info, unsigned long vfn,
> +                              uint8_t **md, size_t *hash_len)
> +{
> +    struct iovec iov_array;
> +    int ret = 0;
> +    int nkey = 1;
> +
> +    iov_array.iov_base = info->block_addr +
> +                         vfn * DIRTYRATE_SAMPLE_PAGE_SIZE;
> +    iov_array.iov_len = DIRTYRATE_SAMPLE_PAGE_SIZE;

I'm a bit confused by how this is working; is 'vfn' an index
in SAMPLE_PAGE_SIZE's rather than individual pages? So this is
going to hash over something the size of a 'DIRTYRATE_SAMPLE_PAGE_SIZE'?

> +    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_MD5,
> +                            &iov_array, nkey,
> +                            md, hash_len, NULL) < 0) {
> +        ret = -1;
> +    }
> +
> +    return ret;
> +}
> +
> +static int save_block_hash(struct block_dirty_info *info)
> +{
> +    unsigned long *rand_buf = NULL;
> +    unsigned int sample_pages_count;
> +    uint8_t *md = NULL;
> +    size_t hash_len;
> +    int i;
> +    int ret = -1;
> +
> +    sample_pages_count = info->sample_pages_count;
> +    /* block size less than one page, return success to skip this block */
> +    if (unlikely(info->block_pages == 0 || sample_pages_count == 0)) {
> +        ret = 0;
> +        goto out;
> +    }
> +
> +    /* use random bytes to pick sample page vfn */
> +    rand_buf = g_malloc0_n(sample_pages_count, sizeof(unsigned long));
> +    /* DEFAULT_READ_RANDOM_MAX_LIMIT 32M,
> +     * can support 4T vm 1024 sample_pages_per_gigabytes
> +     */
> +    ret = qcrypto_random_bytes((unsigned char *)rand_buf,
> +                               sample_pages_count * sizeof(unsigned long),
> +                               NULL);

I think there may be a different way to do this without having to store
the rand_buf.
We already link to glib, and glib has a PRNG; https://developer.gnome.org/glib/stable/glib-Random-Numbers.html
If you create a new prng is g_rand_new() at the start of day, and take a
copy with g_rand_copy(), then you can replay the sequence of random
numbers it generates without actually storing the sequence.
So g_rand_new(), g_rand_copy() and then before you traverse the set of
pages you go and take a copy again and use the copy; it'll give the same
sequence every time.

Note also, because you're allocating a potentially large array,
for this and the hash_result please use g_try_malloc0_n (or g_try_new0)
and fail properly if it returns NULL.

Note we have users with more than 4T of RAM in their VMs, although I
doubt in a single RAMBlock

> +    if (ret) {
> +        ret = -1;
> +        goto out;
> +    }
> +
> +    hash_len = qcrypto_hash_digest_len(QCRYPTO_HASH_ALG_MD5);
> +    info->hash_result = g_malloc0_n(sample_pages_count, sizeof(uint8_t) * hash_len);
> +    info->sample_page_vfn = g_malloc0_n(sample_pages_count, sizeof(unsigned long));
> +
> +    for (i = 0; i < sample_pages_count; i++) {
> +        md = info->hash_result + i * hash_len;
> +        info->sample_page_vfn[i] = rand_buf[i] % info->block_pages;
> +        ret = get_block_vfn_hash(info, info->sample_page_vfn[i], &md, &hash_len);
> +        if (ret < 0) {
> +            goto out;
> +        }
> +    }
> +    ret = 0;
> +out:
> +    g_free(rand_buf);
> +    return ret;
> +}
> +
> +static void get_block_dirty_info(RAMBlock *block, struct block_dirty_info *info,
> +                                 struct dirtyrate_config *config)
> +{
> +    uint64_t sample_pages_per_gigabytes = config->sample_pages_per_gigabytes;
> +
> +    /* Right shift 30 bits to calc block size in GB */
> +    info->sample_pages_count = (qemu_ram_get_used_length(block) * sample_pages_per_gigabytes) >> 30;
> +
> +    info->block_pages = qemu_ram_get_used_length(block) >> DIRTYRATE_PAGE_SIZE_SHIFT;
> +    info->block_addr = qemu_ram_get_host_addr(block);
> +    strcpy(info->idstr, qemu_ram_get_idstr(block));
> +}
> +
> +static struct block_dirty_info *
> +alloc_block_dirty_info(int *block_index,
> +                       struct block_dirty_info *block_dinfo)
> +{
> +    struct block_dirty_info *info = NULL;
> +    int index = *block_index;
> +
> +    if (!block_dinfo) {
> +        block_dinfo = g_new(struct block_dirty_info, 1);
> +        index = 0;
> +    } else {
> +        block_dinfo = g_realloc(block_dinfo, (index + 1) *
> +                                sizeof(struct block_dirty_info));
> +        index++;

I think g_realloc works on a NULL pointer, so you might be able to
simplify.

> +    }
> +    info = &block_dinfo[index];
> +    memset(info, 0, sizeof(struct block_dirty_info));
> +
> +    *block_index = index;
> +    return block_dinfo;
> +}
> +
> +static int ram_block_skip(RAMBlock *block)
> +{
> +    if (!strstr(qemu_ram_get_idstr(block), "ram-node") &&
> +        !strstr(qemu_ram_get_idstr(block), "memdimm")) {
> +        if (strcmp(qemu_ram_get_idstr(block), "mach-virt.ram") ||
> +            strcmp(block->idstr, "pc.ram")) {
> +            return -1;
> +        }
> +    }

We can't tie this to the names you guess that RAMBlocks might have - 
things like 'memdimm' are settable by the caller and can be anything,
so you need to picka  different way of chosing which RAMBlocks to
use; I suggest anything larger than some cutoff size, that's really RAM.

> +    return 0;
> +}
> +
> +static int record_block_hash_info(struct dirtyrate_config config,
> +                                  struct block_dirty_info **block_dinfo, int *block_index)
> +{
> +    struct block_dirty_info *info = NULL;
> +    struct block_dirty_info *dinfo = NULL;
> +    RAMBlock *block = NULL;
> +    int index = 0;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (ram_block_skip(block) < 0) {
> +            continue;
> +        }
> +        dinfo = alloc_block_dirty_info(&index, dinfo);
> +        info = &dinfo[index];
> +        get_block_dirty_info(block, info, &config);
> +        if (save_block_hash(info) < 0) {
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
>  
>  static void calculate_dirtyrate(struct dirtyrate_config config, int64_t time)
>  {
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 2994535..4d9b3b8 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -15,6 +15,7 @@
>  
>  /* take 256 pages per GB for cal dirty rate */
>  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES    256
> +#define DIRTYRATE_SAMPLE_PAGE_SIZE      4096
>  #define DIRTYRATE_PAGE_SIZE_SHIFT       12
>  #define BLOCK_INFO_MAX_LEN              256
>  #define PAGE_SIZE_SHIFT                 20
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


