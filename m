Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0B1C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0370B206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne4m0Pxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0370B206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIE2O-0006p9-Ud
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDyz-000527-Qh
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:39:05 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDyw-000707-Sh
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:39:05 -0400
Received: by mail-oi1-x244.google.com with SMTP id x14so4559834oic.9
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7fR/xUrmHNmVq3wFsBDcdAcVPQ5tgeB92AIGmyTdl00=;
 b=ne4m0Pxyn7sD1xZYLwUxiAiFG4KoNom9eaMAyJgmLkd65MwQ7+ASv+HdcWQ4s0biYZ
 fMLO5lVFQmD9Ozmb4zmHnQw4X9DbdrTQllQTpZK/t/vhItJRTFAuQ2afwyUktAYROwIM
 /3c3PItV2BX9Ee1n/Wn57MZXQFMTj82AcGEte/0przZxqDhT6Pc8QQQx3ZyZE7V7wujR
 HS3hbboqBaMMPW1f5XvMBsY+Mwn6RfT2Lgika3oFEyVG0eWYbh654ciazqZxx65PYzgF
 0U/zNJK80kX49EN8HpLg5DiOyFW/3UW3ZwwmsXkdO3aYzltGgg2ui0HL5wl9NpAvJjfV
 EHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7fR/xUrmHNmVq3wFsBDcdAcVPQ5tgeB92AIGmyTdl00=;
 b=Od3k7oiD4LgzLFEHX0AD+vCYKmijc7DG3WOnFIrVqp8/ut3iBcbMltetEIfZxpweeS
 dnReHpuhHRf18ejr4a4VgX40eWOObUQ6u+HhvMzULXESaG1tKE8iKYNF2MqOu5HU99d2
 RNJXZtoH7E8462EONc5biQHq6P3zw4LHTbs3vbNgVi7QD0RhiyWMF13mULSloT2swCRh
 Oxgtcf4A5s5hF/yXJrvfrNfQNhLBGSjzV9SSBVkhRRX0oBA1vb7R23rZtp0Pr3j67j4A
 RGveiuhpANAM7nIL9kKoxkMw4sEIZd+ndhREuC70JjhXBDwBKr02apHh+R51G+qnkRy/
 ZssQ==
X-Gm-Message-State: AOAM531CtHNe9wlRJNuXjNBw846x2wnf7mCezf9FsKvW5B+GJOSFIJm7
 BJLKB939Jyr1c0QiGgl8G7H5vnBneYzwbO5EAJQ=
X-Google-Smtp-Source: ABdhPJz1k4sV/MMvcKWTKvMPySkoZXx2baaP4g4VbTRoCUa3dnfHIkytx/GYFWICBKcKIQ+/JNaO67m9PwDKq5CPbRM=
X-Received: by 2002:aca:904:: with SMTP id 4mr180861oij.97.1600187941808; Tue,
 15 Sep 2020 09:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
 <1600137887-58739-11-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600137887-58739-11-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 00:38:25 +0800
Message-ID: <CAKXe6SLzR5yDUK7QcP4BmRy06E9vLtgtswkHMFqwQiueQw=oUg@mail.gmail.com>
Subject: Re: [PATCH v9 10/12] migration/dirtyrate: Implement
 calculate_dirtyrate() function
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x244.google.com
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
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, yuxiating@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Implement calculate_dirtyrate() function.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  migration/dirtyrate.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index bcff10e..af02647 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -162,6 +162,21 @@ static void get_ramblock_dirty_info(RAMBlock *block,
>      strcpy(info->idstr, qemu_ram_get_idstr(block));
>  }
>
> +static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos, in=
t count)
> +{
> +    int i;
> +
> +    if (!infos) {
> +        return;
> +    }
> +
> +    for (i =3D 0; i < count; i++) {
> +        g_free(infos[i].sample_page_vfn);
> +        g_free(infos[i].hash_result);
> +    }
> +    g_free(infos);
> +}
> +
>  static bool skip_sample_ramblock(RAMBlock *block)
>  {
>      /*
> @@ -287,8 +302,34 @@ static bool compare_page_hash_info(struct RamblockDi=
rtyInfo *info,
>
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
> -    /* todo */
> -    return;
> +    struct RamblockDirtyInfo *block_dinfo =3D NULL;
> +    int block_count =3D 0;
> +    int64_t msec =3D 0;
> +    int64_t initial_time;
> +
> +    rcu_register_thread();
> +    reset_dirtyrate_stat();
> +    rcu_read_lock();
> +    initial_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if (!record_ramblock_hash_info(&block_dinfo, config, &block_count)) =
{
> +        goto out;
> +    }
> +    rcu_read_unlock();
> +
> +    msec =3D config.sample_period_seconds * 1000;
> +    msec =3D set_sample_page_period(msec, initial_time);
> +
> +    rcu_read_lock();
> +    if (!compare_page_hash_info(block_dinfo, block_count)) {
> +        goto out;
> +    }
> +
> +    update_dirtyrate(msec);
> +
> +out:
> +    rcu_read_unlock();
> +    free_ramblock_dirty_info(block_dinfo, block_count);
> +    rcu_unregister_thread();
>  }
>
>  void *get_dirtyrate_thread(void *arg)
> --
> 1.8.3.1
>

