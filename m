Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CC3C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40359206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkt+/L37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40359206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYm0-0001Wa-7K
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIYkl-0000Wz-2y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:49:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIYki-0008JA-Ub
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:49:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id o8so6964458otl.4
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yoQwZ1yv/zPKg5lJjkoCwnAWXu3hQl29vyl4bu0QTkw=;
 b=Kkt+/L37juJR8SWpE5jU4FX+yRfqRqB0Blc8z7QvnQJ7ip+Qp2Jn3YcBlFu2jZi6jW
 VLvUHqXxteBJEaBeou7Sl+PHm+XCM3kryyWfjiDSYFKq3k1MMKkmhKgi66kTKnWJDA24
 5EqG/K5z0BoozPLB+1mZ5YCCZc+UV/OumCSfTHt4/+Jmj/89k4H+8HaiDizMIiFRkgFl
 IS1inAom9cooD4ECfYCn502xcrHFXcLNtjWyfiW2JOMIsTDf+hAr9luIUDdC0rMfDwpT
 QZazWAUxw2iHwMy26CY73+Xds+rV9UEWWhE57oD4FrqSfEZ3VPdjKXHW73b1CCKRLHF0
 D6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yoQwZ1yv/zPKg5lJjkoCwnAWXu3hQl29vyl4bu0QTkw=;
 b=FHO0uQnwUz8wifRQo5PjIpmindNjs11Qm5hzRSKaVeCSEIU4grycYeY/ahbjouiIqM
 nabXBWVtrygugVnQ8ZkpBABI0sGY1OSprbUHHxjMyccDQMiodgumKpXb0ZGEVEJeN3N+
 0PWtkv71fuDjAJzizXNIpydpq0VZA+TnoUSR3b2J7ibQljviRWklGEnNreW5eipwve1k
 8S617fIJ6pyqnBSmETj5LPhUM7CLYBhUEweUuRlSpW1gMbP2Wg6sNDl7fUPTB5XqRIT9
 uVCqsMimNXnltVpyZ+ouORHwGZEjBOEsTpVR9ZeN0InQ+efYVd2NvBQvhajS5mhvvKFs
 VpRA==
X-Gm-Message-State: AOAM532LDCSSZfZIaD29cfwRBVWvIBUhIduB/0WUc72K4dIL37AK8S26
 ClyfMzyZZ5aiwuM2qB0KCZE25bmdQYbK9tgOC94=
X-Google-Smtp-Source: ABdhPJx9JWPCqCKA+mhzhWlmlKxD5Og3iwXDBnZF+lY9xsSA7LF1Djw6ew71amOSRDX7N8rm8SrGPDKA4r2ZWVxDMjo=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr16224395oti.333.1600267783460; 
 Wed, 16 Sep 2020 07:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
 <1600237327-33618-8-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600237327-33618-8-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 22:49:07 +0800
Message-ID: <CAKXe6SLgL5DkRM6VSF88gc9msW_SPLj-QK56Pi0w9Gp5FE-Q-g@mail.gmail.com>
Subject: Re: [PATCH v10 07/12] migration/dirtyrate: Compare page hash results
 for recorded sampled page
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x344.google.com
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
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Compare page hash results for recorded sampled page.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  migration/dirtyrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 5e6eedf..68561af 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -177,6 +177,69 @@ out:
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
> +find_block_matched(RAMBlock *block, int count,
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
> +static bool compare_page_hash_info(struct RamblockDirtyInfo *info,
> +                                  int block_count)
> +{
> +    struct RamblockDirtyInfo *block_dinfo =3D NULL;
> +    RAMBlock *block =3D NULL;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        block_dinfo =3D find_block_matched(block, block_count, info);
> +        if (block_dinfo =3D=3D NULL) {
> +            continue;
> +        }
> +        calc_page_dirty_rate(block_dinfo);
> +        update_dirtyrate_stat(block_dinfo);
> +    }
> +
> +    if (DirtyStat.total_sample_count =3D=3D 0) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> --
> 1.8.3.1
>

