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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24067C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CC52068D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTNA2YW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CC52068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHq8A-00046e-Ml
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kHpxQ-0002ng-UZ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:59:53 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kHpxP-0006hS-3x
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:59:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id c10so146377otm.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+fxPjWhWw9rCiKslAPm/IPugGR3BNEcKE9dbW5kne50=;
 b=ZTNA2YW4c8IahKPRe2Q9H5uiTZXs3qwlUt+W4IQHVLZ8jnnfiKcJe3MrzfnISl+i25
 H0c8uS3SQpU3wYpQAj5eva3RJEzax1DsS0HLlHvudUVc2TS1kZ+s5GqHALdWFJaUBLoL
 S+olI/GvZf42OWVL2/MZbwfqNr2giSrsT/NSM+UTCi6PsTd75uyW+nPoccFB7jcdPPQN
 Vh8jq3fvja2vBZ9CJO/Qs1mXLsVtRo1wpTvOgoNvRtkgm/zhkBx8wfIU2m+lyWI/sTWm
 0wPSb+f0p24uXlcYYrjfvxQnM8bV3geOn8KcbEBfdKFyWP0sC8eclq9GU7mMMA0/PP9t
 GUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+fxPjWhWw9rCiKslAPm/IPugGR3BNEcKE9dbW5kne50=;
 b=oZBqKe9cmYnHdzyoeCyjD1eZBO+q+8hKTI+UPS0YIekYcZzZ6/+Wn3aLS+whojrU2f
 uN3BPGDEwJIBI58D7sLHJS6r9A9MAkSnjNDodE2RN6PwXSWowfez3AUv8uIQy0zFrC5Z
 s801ioCjVB92HmG0frgRGkSFckLpxU4hOHYloWmH4oJNtt4Q/4gkDQdXsZ5QT953+lbv
 zY5vR4MMplkEgVmBTQQPhLqhYwM0hgUZVfcRVsk6xqMiGrYxXUqHyCG96EVVJuSHXQaT
 DKRQ2iTc1EsHC7BvBQHlA9dbx+BHhvPa69sxscZhdgWtOkDahPJWfndT3V/KEQtovtSe
 I6JQ==
X-Gm-Message-State: AOAM5311dy66nfG99+t3yabP4EO216K0l+DqhcjDzskBBqPTw7b1JW8G
 xoqb1kRRd9zHfMkOvqAhZ03K3Y8nxesBrDloBfw=
X-Google-Smtp-Source: ABdhPJy8fr/NmMc3J6Y9NvhkVnQ4F+D2jXBXbhi0xBGez2azvuBGbo4ZalsG+JvRF4IlV7LM6OKElj/ATiQQis9dIY8=
X-Received: by 2002:a05:6830:2302:: with SMTP id
 u2mr9014988ote.181.1600095589566; 
 Mon, 14 Sep 2020 07:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <1600074185-91624-1-git-send-email-zhengchuan@huawei.com>
 <1600074185-91624-7-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600074185-91624-7-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 14 Sep 2020 22:59:13 +0800
Message-ID: <CAKXe6SJN=qHd=aqwMgRX6OvaPdfrKYJa_n14c7xL7uQLSb=rzw@mail.gmail.com>
Subject: Re: [PATCH v8 06/12] migration/dirtyrate: Record hash results for
 each sampled page
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
> Record hash results for each sampled page, crc32 is taken to calculate
> hash results for each sampled length in TARGET_PAGE_SIZE.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> ---
>  migration/dirtyrate.c | 111 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 111 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index cf2d560..beb18cb 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -10,6 +10,7 @@
>   * See the COPYING file in the top-level directory.
>   */
>
> +#include <zlib.h>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> @@ -68,6 +69,116 @@ static void update_dirtyrate(uint64_t msec)
>      DirtyStat.dirty_rate =3D dirtyrate;
>  }
>
> +/*
> + * get hash result for the sampled memory with length of TARGET_PAGE_SIZ=
E
> + * in ramblock, which starts from ramblock base address.
> + */
> +static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
> +                                      uint64_t vfn)
> +{
> +    uint32_t crc;
> +
> +    crc =3D crc32(0, (info->ramblock_addr +
> +                vfn * TARGET_PAGE_SIZE), TARGET_PAGE_SIZE);
> +
> +    return crc;
> +}
> +
> +static bool save_ramblock_hash(struct RamblockDirtyInfo *info)
> +{
> +    unsigned int sample_pages_count;
> +    int i;
> +    GRand *rand;
> +
> +    sample_pages_count =3D info->sample_pages_count;
> +
> +    /* ramblock size less than one page, return success to skip this ram=
block */
> +    if (unlikely(info->ramblock_pages =3D=3D 0 || sample_pages_count =3D=
=3D 0)) {
> +        return true;
> +    }
> +
> +    info->hash_result =3D g_try_malloc0_n(sample_pages_count,
> +                                        sizeof(uint32_t));
> +    if (!info->hash_result) {
> +        return false;
> +    }
> +
> +    info->sample_page_vfn =3D g_try_malloc0_n(sample_pages_count,
> +                                            sizeof(uint64_t));
> +    if (!info->sample_page_vfn) {
> +        g_free(info->hash_result);
> +        return false;
> +    }
> +
> +    rand  =3D g_rand_new();
> +    for (i =3D 0; i < sample_pages_count; i++) {
> +        info->sample_page_vfn[i] =3D g_rand_int_range(rand, 0,
> +                                                    info->ramblock_pages=
 - 1);
> +        info->hash_result[i] =3D get_ramblock_vfn_hash(info,
> +                                                     info->sample_page_v=
fn[i]);
> +    }
> +    g_rand_free(rand);
> +
> +    return true;
> +}
> +
> +static void get_ramblock_dirty_info(RAMBlock *block,
> +                                    struct RamblockDirtyInfo *info,
> +                                    struct DirtyRateConfig *config)
> +{
> +    uint64_t sample_pages_per_gigabytes =3D config->sample_pages_per_gig=
abytes;
> +
> +    /* Right shift 30 bits to calc ramblock size in GB */
> +    info->sample_pages_count =3D (qemu_ram_get_used_length(block) *
> +                                sample_pages_per_gigabytes) >> 30;
> +    /* Right shift TARGET_PAGE_BITS to calc page count */
> +    info->ramblock_pages =3D qemu_ram_get_used_length(block) >>
> +                           TARGET_PAGE_BITS;
> +    info->ramblock_addr =3D qemu_ram_get_host_addr(block);
> +    strcpy(info->idstr, qemu_ram_get_idstr(block));
> +}
> +
> +static bool record_ramblock_hash_info(struct RamblockDirtyInfo **block_d=
info,
> +                                      struct DirtyRateConfig config,
> +                                      int *block_index)
> +{
> +    struct RamblockDirtyInfo *info =3D NULL;
> +    struct RamblockDirtyInfo *dinfo =3D NULL;
> +    RAMBlock *block =3D NULL;
> +    int total_index =3D 0;

Maybe 'total_count' better?

> +    int index =3D 0;
> +    bool ret =3D true;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        total_index++;
> +    }
> +
> +    dinfo =3D g_try_malloc0_n(total_index, sizeof(struct RamblockDirtyIn=
fo));
> +    if (dinfo =3D=3D NULL) {
> +        total_index =3D 0;

No need to set 'total_index'.
In the end use the 'index'.

> +        ret =3D false;
> +        goto out;
> +    }
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (index >=3D total_index) {
> +            break;
> +        }
> +        info =3D &dinfo[index];
> +        get_ramblock_dirty_info(block, info, &config);
> +        if (!save_ramblock_hash(info)) {
> +            ret =3D false;
> +            goto out;
> +        }
> +        index++;
> +    }
> +
> +out:
> +    *block_index =3D total_index;

Here 'total_index' should be 'index'?

In general I think this two iteration version is more understandable
that last one.

Thanks,
Li Qiang

> +    *block_dinfo =3D dinfo;
> +    return ret;
> +}
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> --
> 1.8.3.1
>

