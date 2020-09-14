Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5B6C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA4521973
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZzW3ZUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA4521973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqK8-0006OV-3x
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kHq6p-0002a6-9Y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:09:35 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kHq6n-0000au-IP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:09:34 -0400
Received: by mail-oi1-x244.google.com with SMTP id a3so233304oib.4
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OjHqdqrYuhQh8zlptYgxFterOENPs+MEZ3lL7NKZu0c=;
 b=EZzW3ZUVdWSTAOG2RcJgA2wC4yHNEXk5nA5eQF0D5ecbXbjw6vtUT6PkJGy6huLlw/
 35kaAQTcMTyfiqwQCsQLjJzDhkfxdRIlbWvALUSFFLdHtMf5CbTjx/oUtOD4PluchdDY
 TZZPkxreAJbRxZD5JRcT3gu4GW3qn9IER4gUeJpTlg6hBrO2aB7/7StlHE21BmYFobkw
 elvyVp9Lbb5DVVnwLTk5FY3DSb9W6ePrnA6kcEeOTdWr3Fs9LIE/9FGgqf5UFlJ+LgMW
 AIixltiQweKFJhxPTjkK5rsHD83rOFl1U4xkO9rZx7KNyfD6TCBPrAyCZ7HoWTeTcSKR
 15og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OjHqdqrYuhQh8zlptYgxFterOENPs+MEZ3lL7NKZu0c=;
 b=RldvRvZb0K9/lftElpy4Bis8S7mx+H0TpUTL0I/vX5Dag0xt0cLcJGxB5PD8IDBiLd
 TAu4TL79HE/SZlABxvgKUd30Wfl+C6Z3mUAhKZA7f2obfKZt8Zs/94AoEPE7Hb0eNm9h
 PL3/BJkNuZtSjV0ecDsGGwq/QijjBoHhDtVZqbbcP0qOK6Kh+IevtBvnAsuoAC3bFQ/o
 hSH2rFhh+8Ty4uZ+JldkE0BrTiS+PrBaaXtVrFjjDjXpGpCD18Nl/zKjQK6NFUvuItFX
 NJP7WO47klAWG5tGVieVHnGpN2ZueddcTmZ4BpJwGmfk/wzon2vRHYNy7l9nvs/A/vkP
 addg==
X-Gm-Message-State: AOAM533YFijGhOuX2D5dGwNhB4pOZMwbbn9n8LT2ySMi54qassMq+SM3
 WjkPNsnNPb6DhMN8Cmxh/Tn2aMGLw4otVAGVbTw=
X-Google-Smtp-Source: ABdhPJyEA3Ob3XGEZ8fin+DJ96Gbtk+XFt/Um0QL0eMQM2Lql9C/uTaGNwZQQ1SJkkkW6639iaWD/gkeS85K/TvRD6E=
X-Received: by 2002:aca:e155:: with SMTP id y82mr8992056oig.56.1600096171719; 
 Mon, 14 Sep 2020 08:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <1600074185-91624-1-git-send-email-zhengchuan@huawei.com>
 <1600074185-91624-8-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600074185-91624-8-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 14 Sep 2020 23:08:55 +0800
Message-ID: <CAKXe6S+zSw9kMQOerNXpacx8dMc0z-mruMZWxjGPs6RP0Yb20g@mail.gmail.com>
Subject: Re: [PATCH v8 07/12] migration/dirtyrate: Compare page hash results
 for recorded sampled page
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

Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Compare page hash results for recorded sampled page.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/dirtyrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index beb18cb..e836474 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -179,6 +179,69 @@ out:
>      return ret;
>  }
>
> +static void calc_page_dirty_rate(struct RamblockDirtyInfo *info)
> +{
> +    uint32_t crc;
> +    int i;
> +
> +    for (i =3D 0; i < info->sample_pages_count; i++) {
> +        crc =3D get_ramblock_vfn_hash(info, info->sample_page_vfn[i]);
> +        if (crc !=3D info->hash_result[i]) {
> +            info->sample_dirty_count++;
> +        }
> +    }
> +}
> +
> +static struct RamblockDirtyInfo *
> +find_page_matched(RAMBlock *block, int count,
> +                  struct RamblockDirtyInfo *infos)
> +{
> +    int i;
> +    struct RamblockDirtyInfo *matched;
> +
> +    for (i =3D 0; i < count; i++) {
> +        if (!strcmp(infos[i].idstr, qemu_ram_get_idstr(block))) {
> +            break;
> +        }
> +    }
> +
> +    if (i =3D=3D count) {
> +        return NULL;
> +    }
> +
> +    if (infos[i].ramblock_addr !=3D qemu_ram_get_host_addr(block) ||
> +        infos[i].ramblock_pages !=3D
> +            (qemu_ram_get_used_length(block) >> TARGET_PAGE_BITS)) {
> +        return NULL;
> +    }
> +
> +    matched =3D &infos[i];
> +
> +    return matched;
> +}
> +
> +static int compare_page_hash_info(struct RamblockDirtyInfo *info,
> +                                  int block_index)

Also 'block_count'?

> +{
> +    struct RamblockDirtyInfo *block_dinfo =3D NULL;
> +    RAMBlock *block =3D NULL;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        block_dinfo =3D find_page_matched(block, block_index + 1, info);
> +        if (block_dinfo =3D=3D NULL) {
> +            continue;
> +        }
> +        calc_page_dirty_rate(block_dinfo);
> +        update_dirtyrate_stat(block_dinfo);
> +    }
> +
> +    if (DirtyStat.total_sample_count =3D=3D 0) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> --
> 1.8.3.1
>

