Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966B5C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DF820885
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3tZPCem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DF820885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ol4-0004vQ-Nu
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8okJ-0003bx-Hg
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8okH-00055S-QV
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597945980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HhjhJF6qhS27aV/aCVRcDtXGZlBke2hkm6kP4GJ6rJE=;
 b=F3tZPCemxIH+DVIjuneWzlEhp+NsOw8+QqMkPTi0MZFIohWFAA/pUccfdCwx+LT0z+6yaG
 CMpmohQM0qP51t+t1RoG+ASW1fgFylgOUtjkBExo1dE/v4RRo0soBLl61Ncy7sjgnrauj4
 KEtQr15Xirtkqw8LVm14FFPjUM/WiSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-CikgbTkzPe2sNwwZjsVPfw-1; Thu, 20 Aug 2020 13:52:57 -0400
X-MC-Unique: CikgbTkzPe2sNwwZjsVPfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5258B1DE05;
 Thu, 20 Aug 2020 17:52:56 +0000 (UTC)
Received: from work-vm (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8343B5C1CF;
 Thu, 20 Aug 2020 17:52:54 +0000 (UTC)
Date: Thu, 20 Aug 2020 18:52:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 08/10] migration/dirtyrate: Implement
 get_sample_page_period() and block_sample_page_period()
Message-ID: <20200820175252.GP2664@work-vm>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-9-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1597634433-18809-9-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:00:23
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
> Implement get_sample_page_period() and set_sample_page_period() to
> sleep specific time between sample actions.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 24 ++++++++++++++++++++++++
>  migration/dirtyrate.h |  2 ++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 6f30f67..4bbfcc3 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -28,6 +28,30 @@ CalculatingDirtyRateState CalculatingState = CAL_DIRTY_RATE_INIT;
>  static unsigned long int qcrypto_hash_len = QCRYPTO_HASH_LEN;
>  static struct DirtyRateStat dirty_stat;
>  
> +static int64_t set_sample_page_period(int64_t msec, int64_t initial_time)
> +{
> +    int64_t current_time;
> +
> +    current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if ((current_time - initial_time) >= msec) {
> +        msec = current_time - initial_time;
> +    } else {
> +        g_usleep((msec + initial_time - current_time) * 1000);
> +    }
> +
> +    return msec;
> +}
> +
> +static int64_t get_sample_page_period(int64_t sec)
> +{
> +    if (sec <= MIN_FETCH_DIRTYRATE_TIME_SEC ||
> +        sec > MAX_FETCH_DIRTYRATE_TIME_SEC) {
> +        sec = DEFAULT_FETCH_DIRTYRATE_TIME_SEC;
> +    }
> +
> +    return sec;
> +}
> +

This is OK I think, but it does seem a bit complicated for just
waiting for a time.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  static int dirty_rate_set_state(int new_state)
>  {
>      int old_state = CalculatingState;
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index fce2e3b..86d8fa0 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -38,6 +38,8 @@
>  
>  /* Take 1s as default for calculation duration */
>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
> +#define MIN_FETCH_DIRTYRATE_TIME_SEC              0
> +#define MAX_FETCH_DIRTYRATE_TIME_SEC              60
>  
>  struct DirtyRateConfig {
>      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


