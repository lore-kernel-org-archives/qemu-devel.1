Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E54C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFBE22296
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xs8waVsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFBE22296
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNku-0000g0-Dh
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52325)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNkQ-0008Tc-If
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNkP-0008PE-FW
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:21:06 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvNkP-0008Oi-Ah
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:21:05 -0400
Received: by mail-ot1-x343.google.com with SMTP id r21so99791001otq.6
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wMCZbVGi32cLcaIU8X3prpRc8h3j08xiAQ7zMlrbE5Y=;
 b=Xs8waVsUIH9jcHFuq5XEc/S+F28sJjvMFQWWCCIbIbEZzb3QpFGXMOeqynFvZBL+8c
 THhtkyLDHo93i9+r7RkLLjTlPm57K6ei5q7HIH9QHjYD+3vXh9kYXQ+lqMqlUCn6971r
 OSBaJpxTXA4L4prEC5cqkpxMrelHHQ/aNeU7lTVJLdRgR3m1PkUrnMgsLOG9iDT8oF62
 y+Hwyb1kSA0vIinkE3eyNZim3VanWj1xEJPonrVbdyleaX7wPn4BiwAS/8yUkc9ojgct
 UjGXVMe2YyfWFxsSXZjvm3OX27/69IKhLyXdNpFSf632n+wljFVlIvjTUU2sWqByyW+c
 2wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wMCZbVGi32cLcaIU8X3prpRc8h3j08xiAQ7zMlrbE5Y=;
 b=I+aCIH2SNDWHvzRfBtYYSPAbdrqvzMMbcG7lkibMfCn2V8PWFkINiP5M5dnzAN+/eZ
 ct8+8W/Zys3uAfCeOTjoE9AbwVT8V1x9wvC/l62Xa+7caJtP42oLgw87JjAUEYjSBWhO
 tANGDggGvOksP+AQNPoRE6FDVBkAfyUaBufec4KyPMf1EgHPf8PhuxjFxZZI/8E8qq7f
 AWOUFOiw6EQM42+zNPAzBYPbwk0Y8+IWurNVeKVgbdFX4b7W9TV1LrA4RwycdKqnP1P+
 ZggRjmCjmYhQ1mZJxmcE2FvFWdCrA0pq9yWD/r2GIqZypgmy6M2TfQNhFEMZXwV0cHc2
 zdzg==
X-Gm-Message-State: APjAAAWKzHe0BmtIjMneJQ40iQ/6+Vl0OPdc6jrAuinzZ6r+Zz64wRLU
 tnezh+EZGzvhVqjfUcDvsl5JK3qgKEvoFZhnX6YXjQ==
X-Google-Smtp-Source: APXvYqwFDw7jDI++ABGd7FWsACLgFSRR9PC3oQIiVLlVGMPIMi9jmws+xbo4TYDM/OTEg/OjWp0H15ZvJQkHrhrtbQE=
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr708925iop.168.1565191264638; 
 Wed, 07 Aug 2019 08:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-11-damien.hedde@greensocs.com>
In-Reply-To: <20190729145654.14644-11-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 16:20:53 +0100
Message-ID: <CAFEAcA_uKg7iBJ-9yANEaHyS4zqNaESUG0F0Fg20T-DKZ2bofQ@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 10/33] vl.c: remove qbus_reset_all
 registration
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
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
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

On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Replace deprecated qbus_reset_all by resettable_reset_cold_fn for
> the sysbus reset registration.
> This does not impact the behavior.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  vl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/vl.c b/vl.c
> index b426b32134..5a465c8236 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4421,7 +4421,11 @@ int main(int argc, char **argv, char **envp)
>
>      /* TODO: once all bus devices are qdevified, this should be done
>       * when bus is created by qdev.c */
> -    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
> +    /*
> +     * TODO: when we have a main reset container/domain object, use
> +     * it to fully benefit from multi-phase reset
> +     */

Let's be a bit more specific with the todo comment while the
detail is fresh in our minds:

/*
 * TODO: If we had a main 'reset container' that the whole system
 * lived in, we could reset that using the multi-phase reset
 * APIs. For the moment, we just reset the sysbus, which will cause
 * all devices hanging off it (and all their child buses, recursively)
 * to be reset. Note that this will *not* reset any Device objects
 * which are not attached to some part of the qbus tree!
 */

> +    qemu_register_reset(resettable_reset_cold_fn, sysbus_get_default());
>      qemu_run_machine_init_done_notifiers();
>
>      if (rom_check_and_register_reset() != 0) {
> --
> 2.22.0

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

