Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBFD2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKPXipjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBFD2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itV6d-0007eO-VD
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itV1G-0001P4-At
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itV1E-0000en-W3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:14:58 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itV1E-0000eP-Po
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:14:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id q6so29009871wro.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 03:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yZulub+3tRtZ7IucDhKhlkdof/biHTxJzU/P9fxJO9s=;
 b=zKPXipjweIXi1KJhtXQ/QcA+ZD0NNUS9Xm0hbsURhNMFd+uuUwoms47T/Cw19u/zYx
 +OuQmmoXJbWGVfJq72AlV2Wb+4b8BOeG4AD+FJ9920XDe0lchm2FYv18FhyLt3Nyn4DE
 +JB8EJALV3+WgM2MYfaanrlxIpULWMP6GEE4YVtjKhKgIdoZ1+wITfTj0jjyjQgAYUnV
 fk/MThPGaDNb05fECm3w8zRi9mYRfTyDuM3pVNsx2veMGj6mCtAX05NHeqnvFdNUa8dk
 zYE8r1B76RWDQKnXiMcAZ+fqtfct8kSo2w7Khm3uk1wMo3FagXsxB0yFFT5rA7HKaHhX
 u4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yZulub+3tRtZ7IucDhKhlkdof/biHTxJzU/P9fxJO9s=;
 b=S/zPjQJPJKXeaw9bOIkSq5yNpGAmqYQrDB1ZzkWvClXmPUW/nADw2TwZeSikcS9DLY
 4r0UU6J+ogrVZ6eccH3jwdLafI6GOf0w7JiP/qv1c9+oXFvhNj62t5ESopO3jtl6U5CY
 wHXnMyZXSEA3NEV98SXr1P8zUOO79NYA7iVx76bfFs6fqNe1gmDpBdn5gQqDYXht0wfN
 qzwPf48lPMQ7SuVFfoc0P7Xsklnzu1LWQShzNY3Y6//LahTRa1Z/4HDR6uxZChdKaPP6
 qVmupX1s76zGj/Kj/wS2ZC7ukQ/IFOYxs0A9ZqEbGCFrmj7OfGrQqQIFnEVqEKDYXLKl
 e0ZA==
X-Gm-Message-State: APjAAAUUNtvfrIst8Uh2B7UTqB88YkLkAweoIjUaNVsxwVqaEgq+Zkr+
 5xxktO2hFGLqhJKey+EAEySx/g==
X-Google-Smtp-Source: APXvYqyGtRgFBmgK4o8+LuzFgpTUWqc+VQsEB07HiiebYytOZWY3NtUwbJz77FQ/8qvyN/i0FgMo7A==
X-Received: by 2002:adf:978c:: with SMTP id s12mr17443417wrb.408.1579518895491; 
 Mon, 20 Jan 2020 03:14:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z123sm23381041wme.18.2020.01.20.03.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 03:14:54 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB6D01FF87;
 Mon, 20 Jan 2020 11:14:53 +0000 (GMT)
References: <20200118140619.26333-1-philmd@redhat.com>
 <20200118140619.26333-7-philmd@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 6/6] hw/core/Makefile: Group generic objects versus
 system-mode objects
In-reply-to: <20200118140619.26333-7-philmd@redhat.com>
Date: Mon, 20 Jan 2020 11:14:53 +0000
Message-ID: <874kwq4bwy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> To ease review/modifications of this Makefile, group generic
> objects first, then system-mode specific ones, and finally
> peripherals (which are only used in system-mode).
>
> No logical changes introduced here.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/core/Makefile.objs | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 2fea68ccf7..a522b7297d 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -1,32 +1,32 @@
>  # core qdev-related obj files, also used by *-user:
>  common-obj-y +=3D qdev.o qdev-properties.o
>  common-obj-y +=3D bus.o
> +common-obj-y +=3D cpu.o
> +common-obj-y +=3D hotplug.o
> +common-obj-y +=3D vmstate-if.o
> +# irq.o needed for qdev GPIO handling:

how are IRQs relevant to linux-user? or vmstate and hotplug?

> +common-obj-y +=3D irq.o
> +
>  common-obj-$(CONFIG_SOFTMMU) +=3D reset.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
> -# irq.o needed for qdev GPIO handling:
> -common-obj-y +=3D irq.o
> -common-obj-y +=3D hotplug.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D nmi.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-handler.o
> -common-obj-y +=3D cpu.o
> -common-obj-y +=3D vmstate-if.o
> +common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o
> +common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o
> +common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
> +common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
> +common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
> +common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-cmds.o
> +obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
> +obj-$(CONFIG_SOFTMMU) +=3D numa.o
>=20=20
>  common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
>  common-obj-$(CONFIG_XILINX_AXI) +=3D stream.o
>  common-obj-$(CONFIG_PTIMER) +=3D ptimer.o
> -common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o
> -common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
> -common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
>  common-obj-$(CONFIG_FITLOADER) +=3D loader-fit.o
> -common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o
>  common-obj-$(CONFIG_REGISTER) +=3D register.o
>  common-obj-$(CONFIG_OR_IRQ) +=3D or-irq.o
>  common-obj-$(CONFIG_SPLIT_IRQ) +=3D split-irq.o
>  common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
>  common-obj-$(CONFIG_GENERIC_LOADER) +=3D generic-loader.o
> -common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
> -
> -obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
> -obj-$(CONFIG_SOFTMMU) +=3D numa.o
> -common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-cmds.o


--=20
Alex Benn=C3=A9e

