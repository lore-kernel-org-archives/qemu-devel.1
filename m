Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D68C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A01F208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FJsE9BNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A01F208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfp4-00033G-AM
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 05:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCfoL-0002An-TW
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:09:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCfoJ-0002dY-DW
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:09:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8TwCI074471;
 Mon, 31 Aug 2020 09:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=x3GnABfPtpip29IpGxryM0ve1UwnJQoBuBkgHVnK3Pg=;
 b=FJsE9BNPKs+Bvujkfed2A3oOs12361onnA9is35iqFe2xtLY3cgisSDi71rzs7zqjNU0
 FFrV7f1Yf2lua/yzmpDtimt7aNStY/VuMxyDzTE9MrNtONZjgLqmhI+ByYp8AeHp3wKI
 a3XVsXr735/6x6bmOZVtubRzGDyclasj39PpYiRdoHZ8hbj7b+nvt1U4iV4HXxFnXG6c
 NMtCQ5gLomLDYapoS94VZxGFdVJoIZzhH/yCxNBmKkXeEEt4pxN1RCDOoc2fDrKip/xo
 SeJR4Hqk12T8zWA0HkIg9+eaGlARyYO9N58hbb6Q5O85PL2gv0VWPNkhtT+a6xEeid+T Ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 337qrhc909-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 31 Aug 2020 09:08:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8UuLw126715;
 Mon, 31 Aug 2020 09:08:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 3380spqkpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2020 09:08:58 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07V98v03014509;
 Mon, 31 Aug 2020 09:08:58 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 31 Aug 2020 02:08:57 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id a22c6d32;
 Mon, 31 Aug 2020 09:08:55 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v6 06/12] migration/dirtyrate: Record hash results for
 each sampled page
In-Reply-To: <1598669577-76914-7-git-send-email-zhengchuan@huawei.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <1598669577-76914-7-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Mon, 31 Aug 2020 10:08:54 +0100
Message-ID: <m25z8zchcp.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=5 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310051
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=david.edmondson@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 04:54:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On Saturday, 2020-08-29 at 10:52:51 +08, Chuan Zheng wrote:

> Record hash results for each sampled page, crc32 is taken to calculate
> hash results for each sampled length in TARGET_PAGE_SIZE.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  migration/dirtyrate.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 35b5c69..f4967fd 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -10,6 +10,7 @@
>   * See the COPYING file in the top-level directory.
>   */
>  
> +#include <zlib.h>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> @@ -68,6 +69,130 @@ static void update_dirtyrate(uint64_t msec)
>      DirtyStat.dirty_rate = dirtyrate;
>  }
>  
> +/*
> + * get hash result for the sampled memory with length of TARGET_PAGE_SIZE
> + * in ramblock, which starts from ramblock base address.
> + */
> +static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
> +                                      uint64_t vfn)
> +{
> +    uint32_t crc;
> +
> +    crc = crc32(0, (info->ramblock_addr +
> +                vfn * TARGET_PAGE_SIZE), TARGET_PAGE_SIZE);
> +
> +    return crc;
> +}
> +
> +static int save_ramblock_hash(struct RamblockDirtyInfo *info)
> +{
> +    unsigned int sample_pages_count;
> +    int i;
> +    GRand *rand;
> +
> +    sample_pages_count = info->sample_pages_count;
> +
> +    /* ramblock size less than one page, return success to skip this ramblock */
> +    if (unlikely(info->ramblock_pages == 0 || sample_pages_count == 0)) {
> +        return 0;
> +    }
> +
> +    info->hash_result = g_try_malloc0_n(sample_pages_count,
> +                                        sizeof(uint32_t));
> +    if (!info->hash_result) {
> +        return -1;
> +    }
> +
> +    info->sample_page_vfn = g_try_malloc0_n(sample_pages_count,
> +                                            sizeof(uint64_t));
> +    if (!info->sample_page_vfn) {
> +        g_free(info->hash_result);
> +        return -1;
> +    }
> +
> +    rand  = g_rand_new();
> +    for (i = 0; i < sample_pages_count; i++) {
> +        info->sample_page_vfn[i] = g_rand_int_range(rand, 0,
> +                                                    info->ramblock_pages - 1);
> +        info->hash_result[i] = get_ramblock_vfn_hash(info,
> +                                                     info->sample_page_vfn[i]);
> +    }
> +    g_rand_free(rand);
> +
> +    return 0;
> +}
> +
> +static void get_ramblock_dirty_info(RAMBlock *block,
> +                                    struct RamblockDirtyInfo *info,
> +                                    struct DirtyRateConfig *config)
> +{
> +    uint64_t sample_pages_per_gigabytes = config->sample_pages_per_gigabytes;
> +
> +    /* Right shift 30 bits to calc ramblock size in GB */
> +    info->sample_pages_count = (qemu_ram_get_used_length(block) *
> +                                sample_pages_per_gigabytes) >> 30;
> +    /* Right shift TARGET_PAGE_BITS to calc page count */
> +    info->ramblock_pages = qemu_ram_get_used_length(block) >>
> +                           TARGET_PAGE_BITS;
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
> -- 
> 1.8.3.1

dme.
-- 
Please don't stand so close to me.

