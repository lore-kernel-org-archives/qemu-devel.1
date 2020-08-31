Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC7FC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04481208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JcYCfxGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04481208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfoc-0002Oi-4R
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 05:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCfnh-0001JL-Ky
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:08:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kCfnf-0002Zl-UD
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:08:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8Snk9165210;
 Mon, 31 Aug 2020 09:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=Was0WEuOTYaxOW+EBlfLK5RfEo3fUlZIZe2MVoKJq4c=;
 b=JcYCfxGIYweaCPLr6WUOwuZDqiGZtocQBX84A9v6VHkavf1JrtbCveSPA+uVekPmHf9Q
 g/P2aKnHrs8NEkkfb4h5R5n5lxlNAbRopjRG5UEDeU/pyCm82hx+mPrl5Ouen8PTeB1O
 mmJFHmIhSBgyZlzNtzZpRkBKXL17qC20gmPu73qVxckIdpr5izU/OiWbufVh69jE2h0f
 8r/PfYil2JeR6Qi/f6PiGzCtkJ5v994DtEisxoJMV7PBbUyk1BqcQWlobT0nNDjxjsVr
 JV9m/+OJ60QY7zE3If/bHg8Fkqo2LefkkxwDpGP2ue5s4g+NvpckF6zGfyMldLHoG6aC EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 337eeqn7bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 31 Aug 2020 09:08:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8V8VZ053310;
 Mon, 31 Aug 2020 09:06:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 3380kkc8f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2020 09:06:05 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07V964ki009072;
 Mon, 31 Aug 2020 09:06:04 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 31 Aug 2020 02:06:04 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 5e251fda;
 Mon, 31 Aug 2020 09:06:02 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v6 03/12] migration/dirtyrate: Add RamblockDirtyInfo to
 store sampled page info
In-Reply-To: <1598669577-76914-4-git-send-email-zhengchuan@huawei.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <1598669577-76914-4-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Mon, 31 Aug 2020 10:06:01 +0100
Message-ID: <m2eennchhi.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310051
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=david.edmondson@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 05:07:21
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

On Saturday, 2020-08-29 at 10:52:48 +08, Chuan Zheng wrote:

> Add RamblockDirtyInfo to store sampled page info of each ramblock.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  migration/dirtyrate.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 5be9714..479e222 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -19,11 +19,29 @@
>   */
>  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES            512
>  
> +/*
> + * Record ramblock idstr
> + */
> +#define RAMBLOCK_INFO_MAX_LEN                     256
> +
>  struct DirtyRateConfig {
>      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
>      int64_t sample_period_seconds; /* time duration between two sampling */
>  };
>  
> +/*
> + * Store dirtypage info for each ramblock.
> + */
> +struct RamblockDirtyInfo {
> +    char idstr[RAMBLOCK_INFO_MAX_LEN]; /* idstr for each ramblock */
> +    uint8_t *ramblock_addr; /* base address of ramblock we measure */
> +    uint64_t ramblock_pages; /* ramblock size in TARGET_PAGE_SIZE */
> +    uint64_t *sample_page_vfn; /* relative offset address for sampled page */
> +    uint64_t sample_pages_count; /* count of sampled pages */
> +    uint64_t sample_dirty_count; /* count of dirty pages we measure */
> +    uint32_t *hash_result; /* array of hash result for sampled pages */
> +};
> +
>  void *get_dirtyrate_thread(void *arg);
>  #endif
>  
> -- 
> 1.8.3.1

dme.
-- 
This is the time. This is the record of the time.

