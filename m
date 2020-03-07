Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1487BC10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 10:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC807206D5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 10:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMXZZa7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC807206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAWt7-0002j4-0o
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 05:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jAWrz-00026L-Vk
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 05:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jAWry-0002yF-Q2
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 05:39:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jAWry-0002rD-Ja; Sat, 07 Mar 2020 05:39:46 -0500
Received: by mail-wr1-x441.google.com with SMTP id v9so5235607wrf.10;
 Sat, 07 Mar 2020 02:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TmYE89S1PG0f8Ul1HiItJ+u0Ybcnre9qw8rMFV2zRK0=;
 b=RMXZZa7Ou4Oq1JG3kj4HrjkrjMGqHwIj10uZrHuUJVqr7JA31MhxAh0qZARU9yxIO/
 qx3lDdQOSCTBcxUUiQCvb5QknNe8RxGVA0r0pXj+4Htjb+rYRJk3ZKml03ERu5Eb2Jpl
 HnZBWzNnN0an0YgYDP4COk24owxGJhy5AS6+kyc7aqRJA/D9k8GWc3ArtgbHh1imX6iQ
 jr43bMf9c+U5nuvqilyyQ9BtpiWT+vMaxIknc9J7hUnpegGKqhKIzY7U2NK8uLcCrvbk
 IDWjs5U8rCKQ6LY+ptDBybkyvdH1Tc8ef3/Q/y1g7YD86rSfEi4jEelc0Hwydkj2PjoS
 NX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TmYE89S1PG0f8Ul1HiItJ+u0Ybcnre9qw8rMFV2zRK0=;
 b=h8vOZqL2cGSNVgn4aNgkum2EVOu9u1n5VzNgJVgxLdwqOFQUqMxIzubcbE+TQykbUk
 niA3kLxJXHcpDxZq/uwC38p99ve5BV9JY5AAPph8w3cuokMmZeo8AphcJbgHzJEusGJk
 WJdMbWWFNfDExuWbbJPktCduZsJ96pJOm6UhA6q+EgSnjHrk00A1W1zU4G7mMUqZQ2Bk
 021Fzau7IQ0sj4XPCBO5iPBLaXV1VIG7g8Xy79GUeIp9lkCN9m/FB/ntywXGNZt1P5j9
 tnHzRlzCdK2gODMP3Wfve9mCyYZAS7saAuEUODVuccFiBYY8IlkPscKaRTc3gck8obGB
 CtnA==
X-Gm-Message-State: ANhLgQ1JlTSS9A0UcTL4SZhYRNnJr9AfLBVSvzet3jMhFtOmEOmGsy4k
 0svErnYV3Yc06Mz2zYbnjzQMD//hpScq+aaO/Gg=
X-Google-Smtp-Source: ADFU+vvgQF4PKbf0oG/+TWv1ZDUD0CkOoc80OnKZ9Zfe9PpMvSiDE608hIeq1R3WdInPtGsT4EoE7RHwLEf/u/3xEfI=
X-Received: by 2002:adf:9e8b:: with SMTP id a11mr8929283wrf.32.1583577585084; 
 Sat, 07 Mar 2020 02:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20200307030756.5913-1-pannengyuan@huawei.com>
In-Reply-To: <20200307030756.5913-1-pannengyuan@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 7 Mar 2020 11:39:32 +0100
Message-ID: <CAJ+F1C+6QSYBhO_M+Vqps4XvOujnV+Wbq6o9Q+qUmC5Z0dmxSQ@mail.gmail.com>
Subject: Re: [PATCH] core/qdev: fix memleak in qdev_get_gpio_out_connector()
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu trival <qemu-trivial@nongnu.org>,
 QEMU <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sat, Mar 7, 2020 at 3:53 AM Pan Nengyuan <pannengyuan@huawei.com> wrote:
>
> Fix a memory leak in qdev_get_gpio_out_connector().
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

good catch,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  hw/core/qdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 3937d1eb1a..85f062def7 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -557,7 +557,7 @@ void qdev_connect_gpio_out_named(DeviceState *dev, co=
nst char *name, int n,
>
>  qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name,=
 int n)
>  {
> -    char *propname =3D g_strdup_printf("%s[%d]",
> +    g_autofree char *propname =3D g_strdup_printf("%s[%d]",
>                                       name ? name : "unnamed-gpio-out", n=
);
>
>      qemu_irq ret =3D (qemu_irq)object_property_get_link(OBJECT(dev), pro=
pname,
> --
> 2.18.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

