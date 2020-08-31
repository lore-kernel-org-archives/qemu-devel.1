Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59924C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9752073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QSF45/Zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9752073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfuK-000711-Bh
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 05:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCftS-0006A6-Vk
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:14:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCftR-0003Ot-9V
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:14:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8U4v7036332;
 Mon, 31 Aug 2020 09:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=ykio6Yfs/LEDqGI4oYnthvY5mVRVwUjbCQxUOon0HqQ=;
 b=QSF45/ZutNxdp6yQ+JMO0hofYPj7J9owjSgm+QM2VqD5XQYBUXCA7GutOt0Y/5MGJjyZ
 UaVPEZg98o/NWncBnO/J/9wnc8iz8sWuSy8vHzpyMxxuogUyM2Hho3GDgHO+IQiouo7M
 lXZkU7Hg0OuhhGDleTpyBnDF5N0DwRu8Kgx+zPbo86k7NsVXrVr6pXs1hGV4kHhGTk3/
 JtPXOeshGIrYI+eCb98lnCrHBrc9hpqIH+u25b/zo3Sewn/3hchbmxg2abGBRcXrBC6X
 4TqbLDz/0zBEsGMcdlKkeOiM6LypguqvXEo7sa9dNTWaGmElbr2cVQCboaahpg+odI6U 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 337eykw728-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 31 Aug 2020 09:14:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8TeqG170934;
 Mon, 31 Aug 2020 09:12:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 3380xuf996-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2020 09:12:16 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07V9CFBr016031;
 Mon, 31 Aug 2020 09:12:15 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 31 Aug 2020 02:12:14 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 619efd25;
 Mon, 31 Aug 2020 09:12:12 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v6 08/12] migration/dirtyrate: skip sampling ramblock
 with size below MIN_RAMBLOCK_SIZE
In-Reply-To: <1598669577-76914-9-git-send-email-zhengchuan@huawei.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <1598669577-76914-9-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Mon, 31 Aug 2020 10:12:12 +0100
Message-ID: <m2zh6bb2mr.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=1
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

On Saturday, 2020-08-29 at 10:52:53 +08, Chuan Zheng wrote:

> In order to sample real RAM, skip ramblock with size below MIN_RAMBLOCK_SIZE
> which is set as 128M.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>

Minor wordsmithing below, but...

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  migration/dirtyrate.c | 19 +++++++++++++++++++
>  migration/dirtyrate.h |  5 +++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 9cc2cbb..420fc59 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -164,6 +164,19 @@ alloc_ramblock_dirty_info(int *block_index,
>      return block_dinfo;
>  }
>  
> +static bool skip_sample_ramblock(RAMBlock *block)
> +{
> +    /*
> +     * Consider ramblock with size larger than 128M is what we
> +     * want to sample.

"Sample only blocks larger than MIN_RAMBLOCK_SIZE."

> +     */
> +    if (qemu_ram_get_used_length(block) < (MIN_RAMBLOCK_SIZE << 10)) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>                                       struct DirtyRateConfig config,
>                                       int *block_index)
> @@ -174,6 +187,9 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>      int index = 0;
>  
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (skip_sample_ramblock(block)) {
> +            continue;
> +        }
>          dinfo = alloc_ramblock_dirty_info(&index, dinfo);
>          if (dinfo == NULL) {
>              return -1;
> @@ -241,6 +257,9 @@ static int compare_page_hash_info(struct RamblockDirtyInfo *info,
>      RAMBlock *block = NULL;
>  
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (skip_sample_ramblock(block)) {
> +            continue;
> +        }
>          block_dinfo = find_page_matched(block, block_index + 1, info);
>          if (block_dinfo == NULL) {
>              continue;
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index a3ee305..faaf9da 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -24,6 +24,11 @@
>   */
>  #define RAMBLOCK_INFO_MAX_LEN                     256
>  
> +/*
> + * Minimum RAMBlock size to sample, in megabytes.
> + */
> +#define MIN_RAMBLOCK_SIZE                         128
> +
>  struct DirtyRateConfig {
>      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
>      int64_t sample_period_seconds; /* time duration between two sampling */
> -- 
> 1.8.3.1

dme.
-- 
Jane was in her turtle neck, I was much happier then.

