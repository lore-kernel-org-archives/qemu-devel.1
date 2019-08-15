Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC723C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B05206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWNFLa7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B05206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyGiX-0007Ta-88
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyGhm-0006i8-66
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyGhk-0004jI-0r
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:26:18 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hyGhj-0004j7-S1
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:26:15 -0400
Received: by mail-oi1-x243.google.com with SMTP id h21so2173592oie.7
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=rzlo2IKqvRh/2TWDcBI+1R7leqT4DxjZkROLbDrg3i8=;
 b=NWNFLa7jKX9lvKABVGvXEbldRp2p/G5v6kpiLLRaTta0O7+omxmJ4b+v6fSm/2yCvN
 7S9vUJWQ6Vy5BBKefDYGkUa/n8tt9lQWBwvVhCdVvHn1VHYWC9SSNg1EvGgygGp6CGnK
 ZRMcfDimfvIPxAKe9rQrSunEFjB2Zm+8kLtEKrhmQe8tZpQrraCtzm8ioHdHvmUq71eD
 ua9jIsllPF1BdXX2FGk3DfMxzu0kuYQYmFX/LlKNuzBgtnyA+/GDTYqs308lss7jPgFj
 A/R9jNuZstUmrrH4Hy3b/r0jgnA82HgSp4FsbHqbbp+F9nnTG1Tz7uDdI257fElnDH3e
 iQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=rzlo2IKqvRh/2TWDcBI+1R7leqT4DxjZkROLbDrg3i8=;
 b=srMWscxqQCviQHty52cgi8kOSvfOt4p+RgKWchZrKGMBkRde8g5BnOFAKjEdDrkcmP
 x5nJLhiAUqiZGak7KXkRBj/5a6zSOrxMLLF5XfW89HEnGU7qbWbjFlQVt453Mn3Ozvsa
 msAekk6zBP96/Y38DK5fjP5gZ3IW4g89IUBFzXu/cuenxln5/mVzDyxnBflQdCnk39s2
 TEP+JfrwsQ7M03UbD65WVD1BgzpWko/FT2S7ObT28ZsL4Q7iFHjd0amc2U0UhUg3vy6c
 fEaVzTORAIKflB9JwIV14ZEfz+E/bOBXRtbce2HOGZI8vCGObcXwoflje9p++6Q9g5VK
 jg8A==
X-Gm-Message-State: APjAAAUd87a2q7ax1klbFock5jMI72e5yGE2djpbBtBKMQidqqLClgoC
 RsupVys3KoUUBkB6HzmpCXxkCfXfbGF0e9ereHI=
X-Google-Smtp-Source: APXvYqz1kbP8q1PFkngG1RvzBS54yiFgLb7BbLvgOiFfONTcP+TB9muhaq7cgS31zc2Yeo+hmMlw8M/d2648ONEf5cw=
X-Received: by 2002:aca:b254:: with SMTP id b81mr1747370oif.53.1565879174956; 
 Thu, 15 Aug 2019 07:26:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 07:26:14
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 07:26:14
 -0700 (PDT)
In-Reply-To: <20190815021857.19526-11-vandersonmr2@gmail.com>
References: <20190815021857.19526-1-vandersonmr2@gmail.com>
 <20190815021857.19526-11-vandersonmr2@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 15 Aug 2019 16:26:14 +0200
Message-ID: <CAL1e-=jTfUidZmHQy0kpjZk49FDAvX91y8SM3FDyHmPyG7qKrA@mail.gmail.com>
To: vandersonmr <vandersonmr2@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v5 10/10] linux-user: dumping hot TBs at
 the end of the execution
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.08.2019. 04.37, "vandersonmr" <vandersonmr2@gmail.com> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> dumps, in linux-user mode, the hottest TBs if -d tb_stats is used.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> --

Hi, Vanderson,

Can you please provide an illustrative example of the dump output, within
the commit message?

Thanks,
Aleksandar

>  linux-user/exit.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index bdda720553..7226104959 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -28,6 +28,10 @@ extern void __gcov_dump(void);
>
>  void preexit_cleanup(CPUArchState *env, int code)
>  {
> +    if (tb_stats_collection_enabled()) {
> +        dump_tbs_info(max_num_hot_tbs_to_dump, SORT_BY_HOTNESS, false);
> +    }
> +
>  #ifdef TARGET_GPROF
>          _mcleanup();
>  #endif
> --
> 2.22.0
>
>
