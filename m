Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEE9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3CC12080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdGpmDk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CC12080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAuVz-0001cw-4n
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAuV9-0001Ci-BP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:26:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAuV7-0005Hu-Rr
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:26:03 -0400
Received: by mail-oi1-x241.google.com with SMTP id d189so880958oig.12
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TFFlo8E1SdYI0QV4T1bf1+0/GADx5ROdVez4Qs9xttM=;
 b=sdGpmDk6uYvD+s/qBpu1yg1LDb8u98i5LWD7BcvpqOK0bWUu/Hgf51VrKR46kLjZTe
 VtjAVLWg/HA7d9J4FbpwNcaGOHEEKusLNAMebcw0dkpZ7wuoxxyFRXsQ2GJiOCiokf3B
 +T1KVr9UieHVQbr5cGtbXBiEZ5jAHRQbj4qM0LlRPtUOReJ1j6VvwcZgm5e2f7etD9LY
 g886wg3Li7TN8Hm2txPU87ZVxKn9cIthQT2rzwiu8at/bXUlXlJ3N1e2n3UK5YClUDW0
 6Do4hydoW6snluqhGbJkWYAD+6Kxi4Ai/is7VUJCQrHl7xJhfFTPth++uTsNHPxi3ONH
 XczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TFFlo8E1SdYI0QV4T1bf1+0/GADx5ROdVez4Qs9xttM=;
 b=o+7vospqSWNb52qn2JiHjF1gKgvE23A3qEnQNqW6xwnQIVhBhlBdYz0mrPQAdpJnh8
 5RbPXGWLchhFqbN+QSU9IIWM8DDxTe+SbAuk3vPMEv7AXQx6ivH5la687ko2e/7IqXEQ
 WGy0C6Bc7Uwds+szD9AVyhpJTHcSM1ZCzRUz49f769HwfRv1neTU0JrG193s5iccpzUE
 pJ51AA6DGkKoinE3zruxmu6uLN6rCgbq9KdNwoQFZ5cN+ZOanQtsw+LG2wPNFSlmJYaW
 hbXcVhh+RwagPfZX3lzZsnmj5OYM6882wHrKIHGj0xWqd5WFORBKduH4JDpP1oa7dI9Y
 GaNA==
X-Gm-Message-State: AOAM5308DoOKsBRpWf6GgKTRKbM3VBSnRJ9w9kxR6Viv5wxLzabgutU1
 mCuqhjfQsezWUiedUn4ctZL3YoCnGTAZ1GX15pQ=
X-Google-Smtp-Source: ABdhPJzytAmsz28zfKeDij65XyXNKncz4lw579UgHHymwF9d+YEuzF7gvpTwy7zW5nRCloEcBekV9/oKTlb2h0ZVTPk=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr3967125oif.56.1598444760535; 
 Wed, 26 Aug 2020 05:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-8-pannengyuan@huawei.com>
In-Reply-To: <20200814160241.7915-8-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 20:25:24 +0800
Message-ID: <CAKXe6SKO-NHr6YJ9Tmgy-pR2womYBXB5zWvgZXVmRUDg2Jnw_A@mail.gmail.com>
Subject: Re: [PATCH 07/12] target/i386/cpu: Fix memleak in
 x86_cpu_class_check_missing_features
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:38=E5=86=99=E9=81=93=EF=BC=9A
>
> 'err' forgot to free in x86_cpu_class_check_missing_features error path.
> Fix that.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 588f32e136..4678aac0b4 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4872,6 +4872,7 @@ static void x86_cpu_class_check_missing_features(X8=
6CPUClass *xcc,
>          new->value =3D g_strdup("type");
>          *next =3D new;
>          next =3D &new->next;
> +        error_free(err);
>      }
>
>      x86_cpu_filter_features(xc, false);
> --
> 2.18.2
>
>

