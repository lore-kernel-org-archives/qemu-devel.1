Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B889BC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847BA21E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5Udf9Gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847BA21E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvO1D-00077r-RM
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNwn-00084k-Qf
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNwm-0006TB-OM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:33:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvNwm-0006S3-3P
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:33:52 -0400
Received: by mail-ot1-x341.google.com with SMTP id x21so12656237otq.12
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Km1xqJmdFW3OmzGAQbZzLGpRXzZpw3vkLbE5a8lCoQg=;
 b=C5Udf9GuRBRV9n77JWc9KP4oOujE279iNEHBUnZ0uKtF724gmmGzGOrDd1eMYlQrLR
 B8VBstYLSDyTGQZvaxj69A2BLTE2eABTLi0BOsf+XI2P5nd12HNDCWmJAhxW5zsjAj08
 FuEU5ybtm/TP4/kLpFtZh1HE4YKvb3E/cTa4bn87Jq09whwcEwZhymqgnfhsw6+kheQY
 F/vuWKIdd05rE5UVn86IR+DXNba9qu54By514OnUcspUH9TTV4wKPbPCRsAPjTzq2r3y
 vPslfrJ8E1hclqT6TSh56/G382xPQGuOSyerxFJOZGUEuZnwpg5zCDiENGzrerf7fnqK
 u+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Km1xqJmdFW3OmzGAQbZzLGpRXzZpw3vkLbE5a8lCoQg=;
 b=ue4jfDnLsT6qOftltSJH3Zf0jXzMIrbR1IbJ+SrF7YGdrtK/53UoOSEARz3P6EM3gr
 SOxfZkZ82feoN9qXhmOyq/RURz8nPt4e2Xc6QYW3z3wrHV87GBGGKH+uo6J4947Ks2Xs
 uM4gDEd5UCzma3XHgAEaidaXpgHwcCo9/w1PjfbV+PSqDb3Bx5tnFUlwVCsoe7Jl4rzt
 4bn9m/6JLJgcGgCMKO+kle+K1Ly8hfOj0e6yDmo3eYnJaZk//mGkzU6HYkj9qyTQiEEP
 KDXlenUE830r0JlOmjuTn0dzN8fOG2gAWKgvFNLSQgttDbNk0zzO7tMAJz0Eb5pU+NG3
 iimA==
X-Gm-Message-State: APjAAAV+WvOz1/MYD6DBhL7qE3mjKyMpFUjbEOijUASAszT7p+9qbJek
 5c/njInpIAXaoUNQ8/os8xGVrBRFFEgB2hdKOVXPTQ==
X-Google-Smtp-Source: APXvYqxvY4BCPXpTy1D6TOoVdm+FSlbStoCoiqA2XTodTGNcbywAFgeHo2fBVWknVgHr0WC8Gterd/bOkacZKunuusQ=
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr769271iop.168.1565192031536; 
 Wed, 07 Aug 2019 08:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-30-damien.hedde@greensocs.com>
In-Reply-To: <20190729145654.14644-30-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 16:33:40 +0100
Message-ID: <CAFEAcA-Fr=wGXN5Oeh14gOMgdVDGBa3Lzpj6QNxrRpcJytwELA@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 29/33] hw/misc/zynq_slcr: use standard
 register definition
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wro=
te:
>
> Replace the zynq_slcr registers enum and macros using the
> hw/registerfields.h macros.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/misc/zynq_slcr.c | 472 ++++++++++++++++++++++----------------------
>  1 file changed, 236 insertions(+), 236 deletions(-)
>

Since this patch has been reviewed and it's unrelated to the
reset APIs, I'm going to pull it into target-arm.next, and
then you can stop carrying it around in your patchset
(well, once it's gone into master and you've rebased on that,
which will probably be in a week or two).

thanks
-- PMM

