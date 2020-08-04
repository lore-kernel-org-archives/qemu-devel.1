Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA9DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32D821744
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQyyoL7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32D821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k31Hb-0002Ic-UN
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 14:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k31Gq-0001pg-0O
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:02:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34854
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k31Gn-0005Qi-9J
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596564155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TIXFMc5QJeO/1duWOUzfqv7eRG32nqFkk4T0Ls3JN5k=;
 b=dQyyoL7HLDXA2K9NfGkBTGE2ik1e0o6FLKeHumpq4tLpoak29lb0BkbVV5f2E0umvooYNK
 wtIR1Fs78+0/8nOSiOwBckmRPqoAsSri+XsuGFqnOnefv18sdowUG9WrPv1Y8VPALB+BzW
 /nr/CpoGNrlnexy1QS/CxNotNxTIJTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-_Xga5_EWOQi3sk3guNmHXA-1; Tue, 04 Aug 2020 14:02:32 -0400
X-MC-Unique: _Xga5_EWOQi3sk3guNmHXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FCB7800461;
 Tue,  4 Aug 2020 18:02:30 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95BBE6179C;
 Tue,  4 Aug 2020 18:02:28 +0000 (UTC)
Date: Tue, 4 Aug 2020 19:02:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 8/8] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
Message-ID: <20200804180225.GK2659@work-vm>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-9-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1595646669-109310-9-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
> Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
> by libvirt api.
> 
> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
> ---
>  migration/Makefile.objs |  1 +
>  migration/dirtyrate.c   | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  qapi/migration.json     | 24 ++++++++++++++++++++++++
>  qapi/pragma.json        |  3 ++-
>  4 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/Makefile.objs b/migration/Makefile.objs
> index 0fc619e..12ae98c 100644
> --- a/migration/Makefile.objs
> +++ b/migration/Makefile.objs
> @@ -6,6 +6,7 @@ common-obj-y += qemu-file.o global_state.o
>  common-obj-y += qemu-file-channel.o
>  common-obj-y += xbzrle.o postcopy-ram.o
>  common-obj-y += qjson.o
> +common-obj-y += dirtyrate.o
>  common-obj-y += block-dirty-bitmap.o
>  common-obj-y += multifd.o
>  common-obj-y += multifd-zlib.o
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index d87e16d..5717521 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -31,6 +31,21 @@ CalculatingDirtyRateStage calculating_dirty_rate_stage = CAL_DIRTY_RATE_INIT;
>          INTERNAL_RAMBLOCK_FOREACH(block)                   \
>          if (!qemu_ram_is_migratable(block)) {} else
>  
> +static int64_t get_dirty_rate_info(void)
> +{
> +    int64_t dirty_rate = dirty_stat.dirty_rate;
> +    /*
> +     *    Return dirty_rate only when we get CAL_DIRTY_RATE_END.
> +     *    And we must initial calculating_dirty_rate_stage.
> +     */
> +    if (calculating_dirty_rate_stage == CAL_DIRTY_RATE_END) {
> +        calculating_dirty_rate_stage = CAL_DIRTY_RATE_INIT;
> +        return dirty_rate;

I don't think a 'get' should change state - in particular I think we
should be able to call 'get' multiple times and get the result back.
Also, instead of just returning -1 you should probably give an error;
e.g. 'Still measuring' or 'not yet measured'

> +    }  else {
> +        return -1;
> +    }
> +}
> +
>  static void reset_dirtyrate_stat(void)
>  {
>      dirty_stat.total_dirty_samples = 0;
> @@ -377,3 +392,33 @@ void *get_dirtyrate_thread(void *arg)
>  
>      return NULL;
>  }
> +
> +void qmp_cal_dirty_rate(int64_t value, Error **errp)
> +{
> +    static struct dirtyrate_config dirtyrate_config;
> +    QemuThread thread;
> +
> +    /*
> +     * We don't begin calculating thread only when it's in calculating status.
> +     */
> +    if (calculating_dirty_rate_stage == CAL_DIRTY_RATE_ING) {
> +        return;
> +    }
> +
> +    /*
> +     * If we get CAL_DIRTY_RATE_END here, libvirtd may be restarted at last round,
> +     * we need to initial it.
> +     */
> +    if (calculating_dirty_rate_stage == CAL_DIRTY_RATE_END)
> +        calculating_dirty_rate_stage = CAL_DIRTY_RATE_INIT;

Note please run the patches through scripts/checkpatch.pl - you need
some {'s here and that script tells you about most of these things.

> +    dirtyrate_config.sample_period_seconds = value;

Ah, this is where the config comes from - OK, I think you said there was
a max, so you should probably check that the maximum is sensible here
and give an error if it's not.

Dave

> +    dirtyrate_config.sample_pages_per_gigabytes = sample_pages_per_gigabytes;
> +    qemu_thread_create(&thread, "get_dirtyrate", get_dirtyrate_thread,
> +                       (void *)&dirtyrate_config, QEMU_THREAD_DETACHED);
> +}
> +
> +int64_t qmp_get_dirty_rate(Error **errp)
> +{
> +    return get_dirty_rate_info();
> +}
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d500055..59f35bb 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1621,3 +1621,27 @@
>  ##
>  { 'event': 'UNPLUG_PRIMARY',
>    'data': { 'device-id': 'str' } }
> +
> +##
> +# @cal_dirty_rate:
> +#
> +# start calculating dirty rate for vm
> +#
> +# @value: time for sample dirty pages
> +#
> +# Since: 5.1
> +#
> +# Example:
> +#   {"command": "cal_dirty_rate", "data": {"value": 1} }
> +#
> +##
> +{ 'command': 'cal_dirty_rate', 'data': {'value': 'int64'} }

I'm OK with abbreviating 'calculate' but prefer calc.

> +##
> +# @get_dirty_rate:
> +#
> +# get dirty rate for vm
> +#
> +# Since: 5.1
> +##
> +{ 'command': 'get_dirty_rate', 'returns': 'int64' }
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index cffae27..ecd294b 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -10,7 +10,8 @@
>          'query-migrate-cache-size',
>          'query-tpm-models',
>          'query-tpm-types',
> -        'ringbuf-read' ],
> +        'ringbuf-read',
> +        'get_dirty_rate' ],
>      'name-case-whitelist': [
>          'ACPISlotType',             # DIMM, visible through query-acpi-ospm-status
>          'CpuInfoMIPS',              # PC, visible through query-cpu
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


