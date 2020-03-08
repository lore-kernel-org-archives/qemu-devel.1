Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E51BC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5249420828
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2huO8ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5249420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAw0O-0003ud-I5
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 09:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAvzp-0003VC-RN
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAvzo-0005g5-DM
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:29:33 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAvzo-0005fg-6f
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:29:32 -0400
Received: by mail-ot1-x341.google.com with SMTP id i14so7010172otp.5
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 06:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eA/da/NJmclRe3OHd3BG7tE+lVDCxCl45qT6htq7p+k=;
 b=x2huO8ekB2m/hTvIC4kKm4VbFZNVLbV+NUi7Pfn1g7z7hs1yvsc2uzyl0J+66qNQAi
 ZAecnaEzDu/BLa7o+t09kGQ1Y4biP/CtLYeplSZu4X727gsoYFMNnaItpOCcR55s5iEh
 OIssU1WR/c3Ql2CzO3VmqbAERYBacGeDfP1MmUcNZ62fcEcKdBx9Tx30XM/Tn+foItKw
 L0EhAQP+g7VgxQA7HHyOGpR8WBwbjUhMc6z0srLD6dFcSY9qY/nRfSyZDrsO3604xPla
 NBW2NVIS78QMPGNpofS04PnpoJ+MGs+3oNApiuTSxrxhDm9fyiRp08e23dLGt2zkFZBW
 zUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eA/da/NJmclRe3OHd3BG7tE+lVDCxCl45qT6htq7p+k=;
 b=knhyiFFqa/WkDQx6jNRZ0RobbDZFqlGPrziJThXSTVuXDgf/jcm6LITQw71LffSP82
 jO5BF0hjANa+dxZu7hZqCkawEKUwG/aAx8SpgjW0puDB2XoQjhbzs0OmFb8/yl7FSQCk
 uosEUq18hYvRZR61S+hF/VpBBTRhw793UqooYiGkmf3RFf9dICWuIMuKV117lSr+Ta8+
 UXHMVLrux+HQgGynddERJu7Rv1CGBXq6n+QCdWD5l/XV77STp6WWqBzeuFZsifz9/AEy
 H/5rKuDBmG/12fNKxkXyXi5cUZqMQsTXZGKUzxSUC09jv5q1T6lZThUvbSC1EYXEJb7c
 +k/A==
X-Gm-Message-State: ANhLgQ0S2uoFwPBHQI5HR0ZJXQVlLjJS4BfmHmB/Xcu49XNEN1EUtDll
 7BuCbh/r6kcC+SkTeSyC+/b+JAy1kJ9QG4ShZxOYlg==
X-Google-Smtp-Source: ADFU+vtw39iWrXKLmKXJY1JFGEqFjKKW6COZcdXJoIdG6RbIxSWOswdxWXf/z8vW/AzNhGQuMekAMjF2wyVfAnhPMwU=
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr9788880otq.91.1583674170950;
 Sun, 08 Mar 2020 06:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
In-Reply-To: <20200305065422.12707-3-pannengyuan@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 8 Mar 2020 13:29:19 +0000
Message-ID: <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Laurent Vivier <laurent@vivier.eu>, Euler Robot <euler.robot@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 at 06:39, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>
> This patch fix a bug in mac_via where it failed to actually realize devices it was using.
> And move the init codes which inits the mos6522 objects and properties on them from realize()
> into init(). However, we keep qdev_set_parent_bus in realize(), otherwise it will cause
> device-introspect-test test fail. Then do the realize mos6522 device in the mac_vir_realize.
>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---

> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index b7d0012794..4c5ad08805 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -868,24 +868,24 @@ static void mac_via_reset(DeviceState *dev)
>  static void mac_via_realize(DeviceState *dev, Error **errp)
>  {
>      MacVIAState *m = MAC_VIA(dev);
> -    MOS6522State *ms;
>      struct tm tm;
>      int ret;
> +    Error *err = NULL;
>
> -    /* Init VIAs 1 and 2 */
> -    sysbus_init_child_obj(OBJECT(dev), "via1", &m->mos6522_via1,
> -                          sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1);
> +    qdev_set_parent_bus(DEVICE(&m->mos6522_via1), sysbus_get_default());
> +    qdev_set_parent_bus(DEVICE(&m->mos6522_via2), sysbus_get_default());

Rather than manually setting the parent bus, you can use
sysbus_init_child_obj() instead of object_initialize_child() --
it is a convenience function that does both object_initialize_child()
and qdev_set_parent_bus() for you.

> -    sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
> -                          sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
> +    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>
> -    /* Pass through mos6522 output IRQs */
> -    ms = MOS6522(&m->mos6522_via1);
> -    object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
> -                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
> -    ms = MOS6522(&m->mos6522_via2);
> -    object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
> -                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
> +    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>
>      /* Pass through mos6522 input IRQs */
>      qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
> @@ -932,6 +932,7 @@ static void mac_via_init(Object *obj)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>      MacVIAState *m = MAC_VIA(obj);
> +    MOS6522State *ms;
>
>      /* MMIO */
>      memory_region_init(&m->mmio, obj, "mac-via", 2 * VIA_SIZE);
> @@ -948,6 +949,22 @@ static void mac_via_init(Object *obj)
>      /* ADB */
>      qbus_create_inplace((BusState *)&m->adb_bus, sizeof(m->adb_bus),
>                          TYPE_ADB_BUS, DEVICE(obj), "adb.0");
> +
> +    /* Init VIAs 1 and 2 */
> +    object_initialize_child(OBJECT(m), "via1", &m->mos6522_via1,
> +                            sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1,
> +                            &error_abort, NULL);
> +    object_initialize_child(OBJECT(m), "via2", &m->mos6522_via2,
> +                            sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2,
> +                            &error_abort, NULL);
> +
> +    /* Pass through mos6522 output IRQs */
> +    ms = MOS6522(&m->mos6522_via1);
> +    object_property_add_alias(OBJECT(m), "irq[0]", OBJECT(ms),
> +                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);

There's no point in using the MOS6522() cast to get a MOS6522*,
because the only thing you do with it is immediately cast it
to an Object* with the OBJECT() cast. Just use the OBJECT cast directly.

> +    ms = MOS6522(&m->mos6522_via2);
> +    object_property_add_alias(OBJECT(m), "irq[1]", OBJECT(ms),
> +                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
>  }
>
>  static void postload_update_cb(void *opaque, int running, RunState state)

thanks
-- PMM

