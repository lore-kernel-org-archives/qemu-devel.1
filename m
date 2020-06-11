Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB46C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE64E20835
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVPiqc3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE64E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJwr-0004pc-58
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJwG-0004Os-Fz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:56:00 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37117)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJwF-0002nt-Kl
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:56:00 -0400
Received: by mail-wm1-x342.google.com with SMTP id y20so4419476wmi.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 02:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Kz9kFP4bcRW2jorZ6wcYZoZCyWnmxWEVWd7izXqw/F8=;
 b=SVPiqc3BkfTB/nD2fqXWvDZ7w6MvMbqiqRG8fPOw5ZB2iBuol+SYJrR1tMucRRAHtk
 bm8/lsSPZ2e4hZfXZrLXqY3w9PkotsUvOxQgNz0NumX6l1DjtXsimh331D8y9C6XVVwT
 V1DYmD8BnRsMfcA+EU1YqzCi+k4xupdpj6ksIwNJFtN0ucrlA2Ek6UyOKQu7F7fnJF4A
 uUkE9jgjVX0PLeWV49vy+Bdv+K02EiqS/H/AzN9ZOufAvShYf5SV+mzNsmZIuSGTeSlK
 edo/xiRtEZDSVDIlPjwAZEtGRpKca5XIFMDOUM9J+eWZfF039r/JT2+XF8TMMSCf9jn4
 hXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Kz9kFP4bcRW2jorZ6wcYZoZCyWnmxWEVWd7izXqw/F8=;
 b=s9V7HiglStke21HByYII+tMNZ1d/QlBC/dMV69FE09TbS///VDttYiH62Bsc4G9MwW
 AEgeLMqiXEO1Vul8QcNT3NsCVKrg6XIC+iIcFcrDKxbJT7U9hAIAMjNxQTjo8GCAzToB
 Iw9GU1tbOg//lbQCT7hWp21S+rbprC8LJ5JOyF+eDEiXWq2dWdqn1bSFHDPK1gHX3slj
 GsHTZSMakB74K6LRt5YJeTjnzbjYzroZhHxVk+INaNRkPZV5XWoqC+iNdlH1UdRkGOST
 4VtiXnx45DkMJUZ24JiWYBBsAwplvvdhazZr/j1wJX2ivEyKalGlaI64iAWxeSDnZGeC
 UIpw==
X-Gm-Message-State: AOAM5310fbD+YjR/FJl1773eGYZJb4/n8h+tDzt4h64XShImGMXal+BG
 Sa0mhQPD+7rKx+5xLjBb2ehj/K/2jccZ5pVOzkY=
X-Google-Smtp-Source: ABdhPJws/voovOFzADCXZ2oXN+pdboDOQitgpVtnKTaLYsB9WgniS0/jGTdf7jSVzIOvfbE5DYSGexKzBZ+weHDS4EQ=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr7891566wmb.168.1591869352622; 
 Thu, 11 Jun 2020 02:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200611094029.9528-1-aleksandar.qemu.devel@gmail.com>
 <20200611094029.9528-2-aleksandar.qemu.devel@gmail.com>
 <53584e62-70c4-122c-2434-3d55cb16f9a4@redhat.com>
In-Reply-To: <53584e62-70c4-122c-2434-3d55cb16f9a4@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 11 Jun 2020 11:55:39 +0200
Message-ID: <CAHiYmc5iB94MBg_ULktFhCxq+iJvTM869yTQx6pP8=Lv--JPKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Adjust sh4 maintainership
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=87=D0=B5=D1=82, 11. =D1=98=D1=83=D0=BD 2020. =D1=83 11:52 Thomas Huth <=
thuth@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> On 11/06/2020 11.40, Aleksandar Markovic wrote:
> > This patch transfers sh4 sections to Yoshinori Sato, who is
> > best positioned in the community to assume sh4 maintainership.
> > He is the maintainer of the related target rx as well, which
> > means that some synergy between the two targets can be expected
> > in future.
> >
> > Further adjustments, reorganizations, and improvements of sh4
> > sections are left to the future maintainer to be devised and
> > executed, as he deems suitable.
> >
> > Aurelien and Magnus are deleted as maintainers in some sections
> > of the MAINTAINERS file with this patch. However, they will not
> > be deleted from QEMU Hall of Fame, where their names will always
> > remained carved in stone as QEMU pioneers and granddaddies.
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> > Acked-by: Magnus Damm <magnus.damm@gmail.com>
> > Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > ---
> >  MAINTAINERS | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6e7890ce82..7ddb6db38c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -296,7 +296,7 @@ F: tests/tcg/s390x/
> >  L: qemu-s390x@nongnu.org
> >
> >  SH4 TCG CPUs
> > -M: Aurelien Jarno <aurelien@aurel32.net>
> > +M: Yoshinori Sato <ysato@users.sourceforge.jp>
> >  S: Odd Fixes
> >  F: target/sh4/
> >  F: hw/sh4/
> > @@ -1251,14 +1251,14 @@ F: include/hw/riscv/opentitan.h
> >  SH4 Machines
> >  ------------
> >  R2D
> > -M: Magnus Damm <magnus.damm@gmail.com>
> > +M: Yoshinori Sato <ysato@users.sourceforge.jp>
> >  S: Maintained
> >  F: hw/sh4/r2d.c
> >  F: hw/intc/sh_intc.c
> >  F: hw/timer/sh_timer.c
>
> Wrong version of the patch? I think you agreed to change Magnus' line to
> "R:" instead?
>
Sorry, corrected in v3.

>  Thomas
>

