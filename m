Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15736C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E4F20722
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RDz/oGYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E4F20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLc1-0001sm-05
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFLbO-0001MW-99
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFLbM-00020T-QA
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:38:33 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFLbM-0001tL-8p
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:38:32 -0400
Received: by mail-ot1-x343.google.com with SMTP id 111so6728097oth.13
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zmXwn7ThyhUxdiDoi/tLEV8N4jVj8zB0ymt3kzhW+bw=;
 b=RDz/oGYTrArMCGlNNgYhUZaXNJdlm1UfThuj4kglYjq/JhMaKQ0lRUSgnxo8sHXhFD
 /6ac/Ba5qVEiqJxuVfPWYeUFha8XOph3rQ2OrVMmv0C83kSIt0Zj7+p1mb30v2K/yjph
 0f+5n/N6ORCocnx8jFpPC1GR6tOzE8fd/L/9LnFneGyk2Br/2xiLWDGFXkMUc3xXy+YP
 skcnVdcFpo65MnBfqxHOsMSyJMw03QREC8lJ9bYl1ym/uXdzccYh2YTml1gvnMPxQX65
 9ZHmmOJGlkB0gH2f16FkXbLbEzc06LhFzNMG0y2Qx/wVeu31sWghWR8F3GZx/Yxp28Zd
 LkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zmXwn7ThyhUxdiDoi/tLEV8N4jVj8zB0ymt3kzhW+bw=;
 b=WnFKIRKsgtbXE1qpv+mXpIgvP8vMROU9PgmJH+5yp4KdVoNCZ2AnV+YAIY7cu/b40W
 rQCyMvNuE6UQbwtiWxANtY3deDPhMeDX4nQtDyqVGA9XcLSW7D83z4HZqfpSpzBq3ARd
 dFtTP9EV90zZdNwsoety7vXnwzg1dz1gRcatVo7AQGe/WZ+fQsV3cNTmm/hcsqo8991a
 Ein3LDo6CdebXErycrEhMFE2JaofqXCqvy5xltORGEpduVdlIpGyMqxO2GgAH6wwewh/
 LY9ieT6pqWJLnTR3rxtyN45LKhxA0gDsmoUumlmnzRMEdD/ACOTpaCNjsGsQ40GlBJoB
 ARpw==
X-Gm-Message-State: ANhLgQ1st0cmaBT5cVHVUFL7wyj3jx5/5uQ1iaxSqYYcDlbxTBZolULS
 WylOZ7k84I03wzK24Wb8zM2zN0pyWlA4ZybLaNm6eg==
X-Google-Smtp-Source: ADFU+vvNKFpnJixdjefii6XPn27n+qmTM858prFRTvzTcFq7IlKCd46NwnM8ED6rDH9VNcMfmrv+CLaJRQtqnIfLpHE=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr7354841ota.221.1584725910985; 
 Fri, 20 Mar 2020 10:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
 <20200203061123.59150-7-david@gibson.dropbear.id.au>
In-Reply-To: <20200203061123.59150-7-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 17:38:19 +0000
Message-ID: <CAFEAcA-xQTrC1b=dkdvd0F3NFU26CBjfZKuo76qfH0UKy=+mAQ@mail.gmail.com>
Subject: Re: [PULL 06/35] spapr: Fail CAS if option vector table cannot be
 parsed
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 06:11, David Gibson <david@gibson.dropbear.id.au> wro=
te:
>
> From: Greg Kurz <groug@kaod.org>
>
> Most of the option vector helpers have assertions to check their
> arguments aren't null. The guest can provide an arbitrary address
> for the CAS structure that would result in such null arguments.
> Fail CAS with H_PARAMETER and print a warning instead of aborting
> QEMU.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <157925255250.397143.10855183619366882459.stgit@bahia.lan>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_hcall.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Hi; Coverity points out that this change introduces a
memory leak (CID 1421924):

>
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index f1799b1b70..ffb14641f9 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1703,7 +1703,15 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      ov_table =3D addr;
>
>      ov1_guest =3D spapr_ovec_parse_vector(ov_table, 1);

spapr_ovec_parse_vector() allocates memory...

> +    if (!ov1_guest) {
> +        warn_report("guest didn't provide option vector 1");
> +        return H_PARAMETER;
> +    }
>      ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
> +    if (!ov5_guest) {
> +        warn_report("guest didn't provide option vector 5");
> +        return H_PARAMETER;

...but if we take this early exit code path it is never freed
(via spapr_ovec_cleanup()).

> +    }
>      if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
>          error_report("guest requested hash and radix MMU, which is inval=
id.");
>          exit(EXIT_FAILURE);

All the other error paths in the function either precede
allocation of the vectors or just call exit() rather than
returning, so this is the only leak.

thanks
-- PMM

