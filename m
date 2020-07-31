Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03513C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C191720829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zgpu5/sL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C191720829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1SHB-0005Ou-2Z
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 06:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k1SGD-0004Wk-T3
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 06:27:34 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k1SGA-0002NL-D2
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 06:27:33 -0400
Received: by mail-ot1-x344.google.com with SMTP id l27so15124292oti.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 03:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ofkpE+syADo0lAD0QWyshX7H90fo5ohM0wuLikTkg64=;
 b=Zgpu5/sLj8UwqmHLx0uazYSxVB2MXgLuRhMbdzHuRA0GCGMI9TZa6iFJ555tPQJOcS
 grhf06ZfI6a2Pu9J3EEEH1jB5t8NFDx74wPZFxVj05W6E7XiF/XmCx9eidyuRbRUN8md
 VKhgrtmkfkL8hMNFP3y9wOOXNpWst3WC7IFf3jP9hdktclodQb3FwhgfM/YCPT3Fd3qb
 3ebNSGUH40m8AgpqmGuaYuXbflLXxAIUxvBwx4ZLLEa47fRtAqB+h6/Wm9tfZZ83t0ca
 M8dEtRHV81znL3yZIDz/NBgEw2G0UZ4tWA6pqZH+6yOfZFW6O8WapWedWP8OueiBBCPv
 0Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ofkpE+syADo0lAD0QWyshX7H90fo5ohM0wuLikTkg64=;
 b=kC8+JjB8qvIx8gAMZALEvNmrjG2+rSiHDM2x2SjWflxi14e1+z8VtH9NLGPBhvQ+1k
 wUtbnoH2KqT+1C3qjnsvJ101XnxlYObCjPOThhZ4KeZ+USklCSH4TqpgOTRENuwgZqKh
 dnTah+12UiGpSnRDLZKc7HnL0dCMUcGltFVTPbThjvD7cpmDDybmhsg72ldC2js66VjL
 bOnYSU+kmw1pvzeJ5zlkO3fDIlmUJGoesmjH084gireAlCDbblBQFusNfq4oFcv3keiR
 3Ht7Sh84joYFOxmgT8G6FuqKaX0hmbJ2GkC0opIlqCZSQhR4LxMZ5TYxfEs5L1RhTfip
 fQZA==
X-Gm-Message-State: AOAM533KTwAMwzWx9//UCACqaXYyWj/XbdLJHHrCQr1Rffz6zbPuG3LL
 /5xMfPjRTifGSfil1RRxXk7q3kDzp7AXaY4x4Jg=
X-Google-Smtp-Source: ABdhPJweu0dnO8ZAkXrwt3OGc+R5nicGDVBMoyTbgFXTiek42yqwkBDqUtY8WydrWFwnrjGjPhpG9UeHcqb7TONAF2M=
X-Received: by 2002:a9d:2926:: with SMTP id d35mr2238576otb.181.1596191247324; 
 Fri, 31 Jul 2020 03:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200731070604.0c981f41@luklap>
In-Reply-To: <20200731070604.0c981f41@luklap>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 31 Jul 2020 18:26:51 +0800
Message-ID: <CAKXe6SLB9tZVO++OMHQfus-65qMAA3SHusc_WEf5ZvoBaoHe9Q@mail.gmail.com>
Subject: Re: [PATCH] colo-compare: Remove superfluous NULL-pointer checks for
 s->iothread
To: Lukas Straub <lukasstraub2@web.de>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Zhang Chen <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Lukas Straub <lukasstraub2@web.de> =E4=BA=8E2020=E5=B9=B47=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=881:09=E5=86=99=E9=81=93=EF=BC=9A
>
> s->iothread is checked for NULL on object creation in colo_compare_comple=
te,
> so it's guaranteed not to be NULL.
> This resolves a false alert from Coverity (CID 1429969).
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  net/colo-compare.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index cc15f23dea..2c20de1537 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -1442,9 +1442,7 @@ static void colo_compare_finalize(Object *obj)
>          qemu_chr_fe_deinit(&s->chr_notify_dev, false);
>      }
>
> -    if (s->iothread) {
> -        colo_compare_timer_del(s);
> -    }
> +    colo_compare_timer_del(s);
>
>      qemu_bh_delete(s->event_bh);
>
> @@ -1470,9 +1468,7 @@ static void colo_compare_finalize(Object *obj)
>          g_hash_table_destroy(s->connection_track_table);
>      }
>
> -    if (s->iothread) {
> -        object_unref(OBJECT(s->iothread));
> -    }
> +    object_unref(OBJECT(s->iothread));
>
>      g_free(s->pri_indev);
>      g_free(s->sec_indev);
> --
> 2.20.1

