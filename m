Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577D0C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2052073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bs6MW6Pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2052073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfvR-0008Ba-Bq
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 05:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCfu5-00071B-Av
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:15:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCfu3-0003Ru-Ax
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:15:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8U4uN036292;
 Mon, 31 Aug 2020 09:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=5LdCJ7z/KA5qMDQ7LkrOYk9v4BYD0pigp9HUo0c3LhY=;
 b=Bs6MW6PtAB2eulViWCRJqajr5JrwhF3JrlE+xjsz2gxj9Rlpro/VjBcBLLN38jm8CuGl
 L/MxCfIXGpV0dADcjlISu8U4FfMOoxxH0uygmwa+FB2fiT6iQy82yVCFBJ/FUBBscJJ2
 yUPXTXxrAL49jsOYSDV4hGQXV+ipPPY2BFx8ROeDbI695IncsCrL/m0O1i5F1M63WpDZ
 696bP0OoCV/hOaoDj3RcVMK4jv32BbSdWsgHNgrAWGVjQhApkmTrg4rjPtvIaxgu91Lb
 QpQW+7i2pXaZEOj6XHzpVdaGuAAUEHSVYhzBnM7LGtWvjPKfleDA0h9rbNfwDV+tBBkM ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 337eykw75m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 31 Aug 2020 09:14:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8UXli122253;
 Mon, 31 Aug 2020 09:14:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 3380wyqmru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2020 09:14:56 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07V9EtOT012876;
 Mon, 31 Aug 2020 09:14:55 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 31 Aug 2020 02:14:55 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 37ca79f8;
 Mon, 31 Aug 2020 09:14:52 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v6 12/12] migration/dirtyrate: Add trace_calls to make
 it easier to debug
In-Reply-To: <1598669577-76914-13-git-send-email-zhengchuan@huawei.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <1598669577-76914-13-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Mon, 31 Aug 2020 10:14:52 +0100
Message-ID: <m2r1rnb2ib.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310051
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=david.edmondson@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 05:07:47
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

On Saturday, 2020-08-29 at 10:52:57 +08, Chuan Zheng wrote:

> Add trace_calls to  make it easier to debug
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  migration/dirtyrate.c  | 9 +++++++++
>  migration/trace-events | 8 ++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index fa1a12d..2a8f4ff 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -22,6 +22,7 @@
>  #include "qapi/qapi-commands-migration.h"
>  #include "migration.h"
>  #include "ram.h"
> +#include "trace.h"
>  #include "dirtyrate.h"
>  
>  static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
> @@ -54,6 +55,7 @@ static bool get_sample_page_period(int64_t sec)
>  static int dirtyrate_set_state(int *state, int old_state, int new_state)
>  {
>      assert(new_state < DIRTY_RATE_STATUS__MAX);
> +    trace_dirtyrate_set_state(DirtyRateStatus_str(new_state));
>      if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
>          return 0;
>      } else {
> @@ -76,6 +78,8 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
>      info->start_time = DirtyStat.start_time;
>      info->calc_time = DirtyStat.calc_time;
>  
> +    trace_query_dirty_rate_info(DirtyRateStatus_str(CalculatingState));
> +
>      return info;
>  }
>  
> @@ -123,6 +127,7 @@ static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
>      crc = crc32(0, (info->ramblock_addr +
>                  vfn * TARGET_PAGE_SIZE), TARGET_PAGE_SIZE);
>  
> +    trace_get_ramblock_vfn_hash(info->idstr, vfn, crc);
>      return crc;
>  }
>  
> @@ -228,6 +233,8 @@ static bool skip_sample_ramblock(RAMBlock *block)
>       * want to sample.
>       */
>      if (qemu_ram_get_used_length(block) < (MIN_RAMBLOCK_SIZE << 10)) {
> +        trace_skip_sample_ramblock(block->idstr,
> +                                   qemu_ram_get_used_length(block));
>          return true;
>      }
>  
> @@ -274,6 +281,7 @@ static void calc_page_dirty_rate(struct RamblockDirtyInfo *info)
>      for (i = 0; i < info->sample_pages_count; i++) {
>          crc = get_ramblock_vfn_hash(info, info->sample_page_vfn[i]);
>          if (crc != info->hash_result[i]) {
> +            trace_calc_page_dirty_rate(info->idstr, crc, info->hash_result[i]);
>              info->sample_dirty_count++;
>          }
>      }
> @@ -299,6 +307,7 @@ find_page_matched(RAMBlock *block, int count,
>      if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
>          infos[i].ramblock_pages !=
>              (qemu_ram_get_used_length(block) >> TARGET_PAGE_BITS)) {
> +        trace_find_page_matched(block->idstr);
>          return NULL;
>      }
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index 4ab0a50..8c2b58f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -312,3 +312,11 @@ dirty_bitmap_load_bits_zeroes(void) ""
>  dirty_bitmap_load_header(uint32_t flags) "flags 0x%x"
>  dirty_bitmap_load_enter(void) ""
>  dirty_bitmap_load_success(void) ""
> +
> +# dirtyrate.c
> +dirtyrate_set_state(const char *new_state) "new state %s"
> +query_dirty_rate_info(const char *new_state) "current state %s"
> +get_ramblock_vfn_hash(const char *idstr, uint64_t vfn, uint32_t crc) "ramblock name: %s, vfn: %"PRIu64 ", crc: %" PRIu32
> +calc_page_dirty_rate(const char *idstr, uint32_t new_crc, uint32_t old_crc) "ramblock name: %s, new crc: %" PRIu32 ", old crc: %" PRIu32
> +skip_sample_ramblock(const char *idstr, uint64_t ramblock_size) "ramblock name: %s, ramblock size: %" PRIu64
> +find_page_matched(const char *idstr) "ramblock %s addr or size changed"
> -- 
> 1.8.3.1

dme.
-- 
All of us, we're going out tonight. We're gonna walk all over your cars.

