Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9391C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431CF23BCD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p/vmDzAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431CF23BCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDul-0007qa-Am
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNDtk-0006yk-S5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:34:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNDti-00079R-G6
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:34:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TBXxYi189651;
 Tue, 29 Sep 2020 11:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=umwCqdhj75KSLfQbD3cwHqPreckllFJ+itCYa6/fJbk=;
 b=p/vmDzAieCqRytosi8cwG9ROCwPrnwyZjnp7agF87bFzWMehbC0bMZIKfodZq6ZAFJ94
 wILcrc3AH/qItJLKqtHC1CcB/jbyhH26rGXUJPzJNBAzwYc2pyMbKBXPgSYAtFGgBiyq
 RVrTbpybBnxqBIwONda7OVC6MHp96dR6KQghsZXymzQ1Y0E1NUwzuF8bUp2Ul6oJN3gw
 3xAF0dpQnSEfcsx4wP1Eahsw2XMcs8C+ztA01rXArHoz+iWkGhEzxxVTY3lZ2V7S0tXv
 CvfTHjMwdZa4G/PpPtMx1yJhLKASPoLWbY7CqXqnen7Xvn07xAIeImADJf3ikryHP4bB Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 33su5at8kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Sep 2020 11:34:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TBUpsM173345;
 Tue, 29 Sep 2020 11:34:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 33uv2dre69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2020 11:34:03 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08TBY2lQ003973;
 Tue, 29 Sep 2020 11:34:02 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 29 Sep 2020 04:34:01 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id e50176b4;
 Tue, 29 Sep 2020 11:33:58 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v2 1/2] migration/dirtyrate: record start_time and
 calc_time while at the measuring state
In-Reply-To: <1601350938-128320-2-git-send-email-zhengchuan@huawei.com>
References: <1601350938-128320-1-git-send-email-zhengchuan@huawei.com>
 <1601350938-128320-2-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Tue, 29 Sep 2020 12:33:58 +0100
Message-ID: <m2imbwrf4p.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=1 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=1
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290103
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=david.edmondson@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 07:34:17
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: alex.chen@huawei.com, wanghao232@huawei.com, zhang.zhanghailiang@huawei.com,
 xiexiangyou@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tuesday, 2020-09-29 at 11:42:17 +08, Chuan Zheng wrote:

> Querying could include both the start-time and the calc-time while at the measuring
> state, allowing a caller to determine when they should expect to come back looking
> for a result.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  migration/dirtyrate.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 68577ef..40e41e7 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -83,14 +83,14 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
>      return info;
>  }
>  
> -static void reset_dirtyrate_stat(void)
> +static void init_dirtyrate_stat(int64_t start_time, int64_t calc_time)
>  {
>      DirtyStat.total_dirty_samples = 0;
>      DirtyStat.total_sample_count = 0;
>      DirtyStat.total_block_mem_MB = 0;
>      DirtyStat.dirty_rate = -1;
> -    DirtyStat.start_time = 0;
> -    DirtyStat.calc_time = 0;
> +    DirtyStat.start_time = start_time;
> +    DirtyStat.calc_time = calc_time;
>  }
>  
>  static void update_dirtyrate_stat(struct RamblockDirtyInfo *info)
> @@ -335,7 +335,6 @@ static void calculate_dirtyrate(struct DirtyRateConfig config)
>      int64_t initial_time;
>  
>      rcu_register_thread();
> -    reset_dirtyrate_stat();
>      rcu_read_lock();
>      initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      if (!record_ramblock_hash_info(&block_dinfo, config, &block_count)) {
> @@ -365,6 +364,8 @@ void *get_dirtyrate_thread(void *arg)
>  {
>      struct DirtyRateConfig config = *(struct DirtyRateConfig *)arg;
>      int ret;
> +    int64_t start_time;
> +    int64_t calc_time;
>  
>      ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_UNSTARTED,
>                                DIRTY_RATE_STATUS_MEASURING);
> @@ -373,6 +374,10 @@ void *get_dirtyrate_thread(void *arg)
>          return NULL;
>      }
>  
> +    start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
> +    calc_time = config.sample_period_seconds;
> +    init_dirtyrate_stat(start_time, calc_time);
> +
>      calculate_dirtyrate(config);
>  
>      ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_MEASURING,
> -- 
> 1.8.3.1

dme.
-- 
No proper time of day.

