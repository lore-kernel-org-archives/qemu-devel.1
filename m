Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFF5C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8567E221E3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5848zWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8567E221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQVP-000345-F6
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGQUp-0002eB-Tz
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGQUn-0002Ol-Jx
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599759387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QZ90UF3Fo/14ftAkXVnw+MfPpAU3U/P56ii2p7PheM4=;
 b=g5848zWWvKUXd7sbVn1Az+D0I9akNDKCuVuukdIe1eQcorJsWJSuSpyz2Esk/galbC8LjI
 9sf1XxuweQWGR83MPkvdwcSmlQ5bAF9NhK8UXELlEhnMDDKdSP4CRQ6T0y3sxYBFqNk8Yk
 q6PSiREGvLfzrveAnzXnY08eZ7zsf7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-GeehcD6vPTKs_GsOlFQl_A-1; Thu, 10 Sep 2020 13:36:25 -0400
X-MC-Unique: GeehcD6vPTKs_GsOlFQl_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EA4F64083;
 Thu, 10 Sep 2020 17:36:24 +0000 (UTC)
Received: from work-vm (ovpn-114-164.phx2.redhat.com [10.3.114.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02EF281C4F;
 Thu, 10 Sep 2020 17:36:21 +0000 (UTC)
Date: Thu, 10 Sep 2020 18:36:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>, eblake@redhat.com
Subject: Re: [PATCH v7 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
Message-ID: <20200910173619.GM2814@work-vm>
References: <1599661096-127913-1-git-send-email-zhengchuan@huawei.com>
 <1599661096-127913-12-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1599661096-127913-12-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, dme@dme.org,
 quintela@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 alex.chen@huawei.com, ann.zhuangyanying@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>

THis is looking OK by me,
Eric: are you happy with the qapi stuff now?

Dave

> ---
>  migration/dirtyrate.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  qapi/migration.json   | 50 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 2f9ac34..e9e9e35 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -61,6 +61,24 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
>      }
>  }
>  
> +static struct DirtyRateInfo *query_dirty_rate_info(void)
> +{
> +    int64_t dirty_rate = DirtyStat.dirty_rate;
> +    struct DirtyRateInfo *info = g_malloc0(sizeof(DirtyRateInfo));
> +
> +    if (CalculatingState == DIRTY_RATE_STATUS_MEASURED) {
> +        info->dirty_rate = dirty_rate;
> +    } else {
> +        info->dirty_rate = -1;
> +    }
> +
> +    info->status = CalculatingState;
> +    info->start_time = DirtyStat.start_time;
> +    info->calc_time = DirtyStat.calc_time;
> +
> +    return info;
> +}
> +
>  static void reset_dirtyrate_stat(void)
>  {
>      DirtyStat.total_dirty_samples = 0;
> @@ -331,6 +349,8 @@ static void calculate_dirtyrate(struct DirtyRateConfig config)
>  
>      msec = config.sample_period_seconds * 1000;
>      msec = set_sample_page_period(msec, initial_time);
> +    DirtyStat.start_time = initial_time / 1000;
> +    DirtyStat.calc_time = msec / 1000;
>  
>      rcu_read_lock();
>      if (compare_page_hash_info(block_dinfo, block_index) < 0) {
> @@ -362,3 +382,45 @@ void *get_dirtyrate_thread(void *arg)
>                                DIRTY_RATE_STATUS_MEASURED);
>      return NULL;
>  }
> +
> +void qmp_calc_dirty_rate(int64_t calc_time, Error **errp)
> +{
> +    static struct DirtyRateConfig config;
> +    QemuThread thread;
> +    int ret;
> +
> +    /*
> +     * If the dirty rate is already being measured, don't attempt to start.
> +     */
> +    if (CalculatingState == DIRTY_RATE_STATUS_MEASURING) {
> +        error_setg(errp, "the dirty rate is already being measured.");
> +        return;
> +    }
> +
> +    if (!get_sample_page_period(calc_time)) {
> +        error_setg(errp, "calc-time is out of range[%d, %d].",
> +                         MIN_FETCH_DIRTYRATE_TIME_SEC,
> +                         MAX_FETCH_DIRTYRATE_TIME_SEC);
> +        return;
> +    }
> +
> +    /*
> +     * Init calculation state as unstarted.
> +     */
> +    ret = dirtyrate_set_state(&CalculatingState, CalculatingState,
> +                              DIRTY_RATE_STATUS_UNSTARTED);
> +    if (ret == -1) {
> +        error_setg(errp, "init dirty rate calculation state failed.");
> +        return;
> +    }
> +
> +    config.sample_period_seconds = calc_time;
> +    config.sample_pages_per_gigabytes = DIRTYRATE_DEFAULT_SAMPLE_PAGES;
> +    qemu_thread_create(&thread, "get_dirtyrate", get_dirtyrate_thread,
> +                       (void *)&config, QEMU_THREAD_DETACHED);
> +}
> +
> +struct DirtyRateInfo *qmp_query_dirty_rate(Error **errp)
> +{
> +    return query_dirty_rate_info();
> +}
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 061ff25..4b980a0 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1737,3 +1737,53 @@
>  ##
>  { 'enum': 'DirtyRateStatus',
>    'data': [ 'unstarted', 'measuring', 'measured'] }
> +
> +##
> +# @DirtyRateInfo:
> +#
> +# Information about current dirty page rate of vm.
> +#
> +# @dirty-rate: @dirtyrate describing the dirty page rate of vm
> +#          in units of MB/s.
> +#          If this field return '-1', it means querying is not
> +#          start or not complete.
> +#
> +# @status: status containing dirtyrate query status includes
> +#          'unstarted' or 'measuring' or 'measured'
> +#
> +# @start-time: start time in units of second for calculation
> +#
> +# @calc-time: time in units of second for sample dirty pages
> +#
> +# Since: 5.2
> +#
> +##
> +{ 'struct': 'DirtyRateInfo',
> +  'data': {'dirty-rate': 'int64',
> +           'status': 'DirtyRateStatus',
> +           'start-time': 'int64',
> +           'calc-time': 'int64'} }
> +
> +##
> +# @calc-dirty-rate:
> +#
> +# start calculating dirty page rate for vm
> +#
> +# @calc-time: time in units of second for sample dirty pages
> +#
> +# Since: 5.2
> +#
> +# Example:
> +#   {"command": "calc-dirty-rate", "data": {"calc-time": 1} }
> +#
> +##
> +{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64'} }
> +
> +##
> +# @query-dirty-rate:
> +#
> +# query dirty page rate in units of MB/s for vm
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


