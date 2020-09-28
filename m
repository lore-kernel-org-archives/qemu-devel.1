Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C85AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94D3207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bpXDU5cx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94D3207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsEe-0002Av-V9
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kMsDg-0001lO-Uu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:25:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kMsDe-0004Jm-Ou
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:25:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SCEZOM007945;
 Mon, 28 Sep 2020 12:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=iZ69Ry4hS59KYmHlz9DK4dW6sATHC3pXXAc3XSzr31o=;
 b=bpXDU5cxkzmlThDX0nWwr67uuUgAcVS0IsQjsqfaBxMNKqR9ooTPnqRQvqwfHijFCqn5
 kFsBZbpl9grI6S2ISrUvK82DjsyWnGM7iA1Y1G4WsAFP2MYewMyT2qs+gL525fTrWfXl
 NFIEXo1HWIDIzA0DBP060ZQfIG5PW337OV49TScWnoWRYrVmJLjBHLTCrpfykHRvkcio
 3B86z7IetUndFpqAgD8NiorOUTo//TE8hspoM5Q7K8NvSca9Q+OecR96Zbx+ASkPnvEF
 MH+H3fVHYg0fBlt34YhPT2s/saey+/u5hZ6A7elkauKTcryAxLRbWOvEVhR2SKWwNnPE /A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 33su5amrcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Sep 2020 12:25:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SCEkfG074522;
 Mon, 28 Sep 2020 12:23:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 33tf7k8mhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2020 12:23:05 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08SCN3Sq001064;
 Mon, 28 Sep 2020 12:23:04 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 28 Sep 2020 05:23:03 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 0c87074c;
 Mon, 28 Sep 2020 12:23:00 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH] migration/dirtyrate: present dirty rate only when
 querying the rate has completed
In-Reply-To: <1601182520-130450-1-git-send-email-zhengchuan@huawei.com>
References: <1601182520-130450-1-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Mon, 28 Sep 2020 13:23:00 +0100
Message-ID: <m2mu1af5uj.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9757
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=1 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9757
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=1
 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280101
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=david.edmondson@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 08:25:23
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sunday, 2020-09-27 at 12:55:20 +08, Chuan Zheng wrote:

> Make dirty_rate field optional, present dirty rate only when querying
> the rate has completed.
> The qmp results is shown as follow:
> @unstarted:
> {"return":{"status":"unstarted","start-time":0,"calc-time":0},"id":"libvirt-12"}
> @measuring:
> {"return":{"status":"measuring","start-time":0,"calc-time":0},"id":"libvirt-14"}

Not this patch, but the "measuring" state could include both the
start-time and the calc-time, allowing a caller to determine when they
should expect to come back looking for a result.

> @measured:
> {"return":{"status":"measured","dirty-rate":4,"start-time":150146,"calc-time":1},"id":"libvirt-15"}
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>

With the minor wording changes below...

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  migration/dirtyrate.c | 3 +--
>  qapi/migration.json   | 9 ++++-----
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 68577ef..9024b0f 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -69,9 +69,8 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
>      struct DirtyRateInfo *info = g_malloc0(sizeof(DirtyRateInfo));
>  
>      if (qatomic_read(&CalculatingState) == DIRTY_RATE_STATUS_MEASURED) {
> +        info->has_dirty_rate = true;
>          info->dirty_rate = dirty_rate;
> -    } else {
> -        info->dirty_rate = -1;
>      }
>  
>      info->status = CalculatingState;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index ce2216c..6e428f7 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1743,10 +1743,9 @@
>  #
>  # Information about current dirty page rate of vm.
>  #
> -# @dirty-rate: @dirtyrate describing the dirty page rate of vm
> -#          in units of MB/s.
> -#          If this field returns '-1', it means querying has not
> -#          yet started or completed.
> +# @dirty-rate: dirty-rate describing the dirty page rate of vm
> +#              in units of MB/s, present only when querying the
> +#              rate has completed.

How about:

@dirty-rate: an estimate of the dirty page rate of the VM in units of
	     MB/s, present only when estimating the rate has completed.

>  #
>  # @status: status containing dirtyrate query status includes
>  #          'unstarted' or 'measuring' or 'measured'
> @@ -1759,7 +1758,7 @@
>  #
>  ##
>  { 'struct': 'DirtyRateInfo',
> -  'data': {'dirty-rate': 'int64',
> +  'data': {'*dirty-rate': 'int64',
>             'status': 'DirtyRateStatus',
>             'start-time': 'int64',
>             'calc-time': 'int64'} }
> -- 
> 1.8.3.1

dme.
-- 
I used to worry, thought I was goin' mad in a hurry.

