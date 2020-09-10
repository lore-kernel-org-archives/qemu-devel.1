Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FA3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBC82076C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEua+2bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBC82076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGNYh-0007h0-Jm
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 10:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kGNY9-0007EA-RQ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:27:45 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kGNY7-0007e5-MC
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:27:45 -0400
Received: by mail-oi1-x243.google.com with SMTP id t76so6072302oif.7
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Yo6FoeJ8JgGmOCuTEbOd1fN1DhEY7OyYBQ45lu4dhfE=;
 b=kEua+2bvRz10D6KkOYpJhAPyJWVmUXrRfdtpMzgzXB+8LAxqTt47z99S+aD7TjkUEb
 ocr+O8XAiVr2dmSmU3uHDcu++HZdbVaKteSNpk4BXF7A++Jp+eBAhbMrBwiDeeq3CD30
 y289boeFX3QiLW15p6D0vGTWF+a+oaDcLktn9IXZFQlrcV9QdOffHOuICF8qCaylvc7r
 Fyo755Xcw5jRKJCEAUG7gtX2F6aPrLZzSyfrWv6soJbNPIRw8XP3uAv+CdbXau32i0bu
 T4qgMvv7sBSm++u329TckM8nyY1oWq8RzT+cQw2qpRkJoTuUXWTonKAhhzhc8L2THflc
 wlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Yo6FoeJ8JgGmOCuTEbOd1fN1DhEY7OyYBQ45lu4dhfE=;
 b=EbtpzLHFKUC4TQrm0/hLkLoxrv+8rANps6sp1xohNh+A4+PjVfg/qH1rvooPa1V7zg
 xIeWiaoKv6B+7cst/mdyATNY+dCbSEbULZe3A6jBBIhs90MGhHB+iC835j4bsSOBiqn/
 Q/jXRcDMR8vrQ7fSuu/JnFJDq1/MsnjQhirLGLKzFV/krOkSJOaLEFuX79YTl+wYZWxB
 PxZ+WO/t8Wlfc9BbetSdgZEX97ESyWUFhD1zZo1I6PqrEBON9dccs2z9p2+1doKnxTcf
 ZRA3rbp4OIb4heRrBgd3czn+16pqNDfglWIHm40cksMfM2pYZGQyBBy2p365cQkm0ila
 TTHQ==
X-Gm-Message-State: AOAM531FhWN6mQldjCjD+XS9FXnYwlr5vK0orDsOs0vPH0vBbFPpaq9Y
 +Q/kQ5S8T3hpSPT91xdegITxJGzrMAPyhY4dk7U=
X-Google-Smtp-Source: ABdhPJwlSm+xeaPPFx3VGmCj/e3H2Qnq1DZG/sKwkdVhLOxxZccA8HloiFWRqQR6EsiHu3PbFTyMXf0d4uuesoZI78A=
X-Received: by 2002:aca:b454:: with SMTP id d81mr178468oif.150.1599748062287; 
 Thu, 10 Sep 2020 07:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <1599661096-127913-1-git-send-email-zhengchuan@huawei.com>
 <1599661096-127913-12-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1599661096-127913-12-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Sep 2020 22:27:06 +0800
Message-ID: <CAKXe6SLGySEt+S_c8311nXkeUjkBnKcwzCyXrovoR2xmk=nQ3g@mail.gmail.com>
Subject: Re: [PATCH v7 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, dme@dme.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>,
 ann.zhuangyanying@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:14=E5=86=99=E9=81=93=EF=BC=9A
>
> Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could =
be called
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> ---
>  migration/dirtyrate.c | 62 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  qapi/migration.json   | 50 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 2f9ac34..e9e9e35 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -61,6 +61,24 @@ static int dirtyrate_set_state(int *state, int old_sta=
te, int new_state)
>      }
>  }
>
> +static struct DirtyRateInfo *query_dirty_rate_info(void)
> +{
> +    int64_t dirty_rate =3D DirtyStat.dirty_rate;
> +    struct DirtyRateInfo *info =3D g_malloc0(sizeof(DirtyRateInfo));
> +
> +    if (CalculatingState =3D=3D DIRTY_RATE_STATUS_MEASURED) {

Should we use atomic read 'CalculatingState'? The qmp thread maybe run
with the sampled thread.

> +        info->dirty_rate =3D dirty_rate;
> +    } else {
> +        info->dirty_rate =3D -1;
> +    }
> +
> +    info->status =3D CalculatingState;
> +    info->start_time =3D DirtyStat.start_time;
> +    info->calc_time =3D DirtyStat.calc_time;
> +
> +    return info;
> +}
> +


>  static void reset_dirtyrate_stat(void)
>  {
>      DirtyStat.total_dirty_samples =3D 0;
> @@ -331,6 +349,8 @@ static void calculate_dirtyrate(struct DirtyRateConfi=
g config)
>
>      msec =3D config.sample_period_seconds * 1000;
>      msec =3D set_sample_page_period(msec, initial_time);
> +    DirtyStat.start_time =3D initial_time / 1000;
> +    DirtyStat.calc_time =3D msec / 1000;
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
> +     * If the dirty rate is already being measured, don't attempt to sta=
rt.
> +     */
> +    if (CalculatingState =3D=3D DIRTY_RATE_STATUS_MEASURING) {

atomic read?

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
> +    ret =3D dirtyrate_set_state(&CalculatingState, CalculatingState,
> +                              DIRTY_RATE_STATUS_UNSTARTED);
> +    if (ret =3D=3D -1) {
> +        error_setg(errp, "init dirty rate calculation state failed.");
> +        return;
> +    }
> +
> +    config.sample_period_seconds =3D calc_time;
> +    config.sample_pages_per_gigabytes =3D DIRTYRATE_DEFAULT_SAMPLE_PAGES=
;
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
>

