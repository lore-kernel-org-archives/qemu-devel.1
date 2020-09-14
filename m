Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DEC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D163206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/ROy/fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D163206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHs7D-0002Nv-Pd
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 13:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kHqfo-00073Z-Tb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:45:44 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kHqfn-0006Nx-0t
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:45:44 -0400
Received: by mail-ot1-x343.google.com with SMTP id n61so315043ota.10
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ndBdbCUlHWHHMkKmVLjYKgdILF4aQDlJ2HTR/4+FNHw=;
 b=m/ROy/fgaakazyuvdeAjnYN7yE3mshldOHQwVB4fF6cBRObflE+2WC7rMDdSCLlI5D
 jAKDK6qwq8DYVPXxwZhqNHUbrOFZy6/G5pj5boEgXxk9D0SvdmE8h286516Hq94RAZiR
 N6k9bHY4SO3oG4MJPYOPtGRuxEgXLk3YSEwO2miCqZqYV7SddK/KRnKYVjQjrjRSMt0A
 4T40VNwpAhCj0o6+fUeEFk8WK93YE+pzxAqld4R5RMQDS1zQyZzu6mQfZ7qBCxAPOuQs
 Cbym3K3ZVuttPZnjF6c+lTjkk7sjT5yWL+uT/Xv8hofTgoziPLP6Mn6i/XbVDnw9PvM4
 +rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ndBdbCUlHWHHMkKmVLjYKgdILF4aQDlJ2HTR/4+FNHw=;
 b=VB4Lw64tJj/Z+MGntKrR+484vbZdk1GmqOEpL9LNHD3O4evefgD9dySoaaWKkwP2K4
 hG1Jyd/wvjbte+MU+WDlTArBdOlUHWGU2h4USdipTLI7KEhzkrFp780qb9BSTYIKMPK/
 XFmA4WmDJ4s3cZd+6CYpCcbrBw6reIc/siSzsZKPPHSl4mlQTjvYmeJHwMMm2ks9zNxM
 NdtuGrSBiF/I72at0OP7agezzrzq8rAfEGXyRAG4+QH7s81aJoFn699qhNz2+1cFUHFl
 bDmPpoW5JA/E4ePD+G+0Kcz5dlAyS4mnTd0jznpnxdQQ0RWwwRayYV0oRRPritumJ2kE
 GbEw==
X-Gm-Message-State: AOAM533JZe6UZaf3M6/dnsPXGrgIAmyrwAwBNC0wJnIJJqltUyyzIbu+
 lUIbBhxjXDpKbqqGIz5JPUJUqJo4aa6/XPFg6D4=
X-Google-Smtp-Source: ABdhPJyvbHk2LKR7MPFSN9J0hnsl6F9foAzGpdBpWVg3b42RKfZqoFfqKQGjnwCPfdXJ928tOo2mB4PXqtCji8dXHRY=
X-Received: by 2002:a05:6830:2302:: with SMTP id
 u2mr9150177ote.181.1600098340238; 
 Mon, 14 Sep 2020 08:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <1600074185-91624-1-git-send-email-zhengchuan@huawei.com>
 <1600074185-91624-11-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600074185-91624-11-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 14 Sep 2020 23:45:04 +0800
Message-ID: <CAKXe6S+XO5tEMxVBwdX9r4tyn6jaPUkbR_UM4tPUvJXbwcURTA@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] migration/dirtyrate: Implement
 calculate_dirtyrate() function
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
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

Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Implement calculate_dirtyrate() function.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/dirtyrate.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 6add846..cc31bd1 100644
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
> @@ -289,8 +304,34 @@ static int compare_page_hash_info(struct RamblockDir=
tyInfo *info,
>
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
> -    /* todo */
> -    return;
> +    struct RamblockDirtyInfo *block_dinfo =3D NULL;
> +    int block_index =3D 0;
> +    int64_t msec =3D 0;
> +    int64_t initial_time;
> +
> +    rcu_register_thread();
> +    reset_dirtyrate_stat();
> +    rcu_read_lock();
> +    initial_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if (!record_ramblock_hash_info(&block_dinfo, config, &block_index)) =
{
> +        goto out;
> +    }
> +    rcu_read_unlock();
> +
> +    msec =3D config.sample_period_seconds * 1000;
> +    msec =3D set_sample_page_period(msec, initial_time);
> +
> +    rcu_read_lock();
> +    if (compare_page_hash_info(block_dinfo, block_index) < 0) {
> +        goto out;

It seems the value of 'DirtyRateStat.dirty_rate'  is 0 if this error occurs=
 ?

Maybe we should set the DirtyRateStat.dirty_rate to -1 in
reset_dirtyrate_stat function.
As you say:

+#          If this field return '-1', it means querying is not
+#          start or not complete.

The '0' may confuse the people there is no dirty page.

Thanks,
Li Qiang

> +    }
> +
> +    update_dirtyrate(msec);
> +
> +out:
> +    rcu_read_unlock();
> +    free_ramblock_dirty_info(block_dinfo, block_index);
> +    rcu_unregister_thread();
>  }
>
>  void *get_dirtyrate_thread(void *arg)
> --
> 1.8.3.1
>

