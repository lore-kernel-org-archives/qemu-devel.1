Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7FEC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267FF2081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGmdHvfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267FF2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomOh-0005qg-7Q
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iolfV-0005lT-Lx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iolfU-0001pD-8i
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:00:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iolfU-0001oq-4x
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578391255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8wUBPjTJ1dygY4lgTlyXDryvNu9KcidWawrLd/Hi8A=;
 b=HGmdHvfg+FLnbmisAGi+STDUNCc80jNPJoUIld8QP9taMgaq+fJugo/S7Oj6SkBx1svyTE
 I1IeUQznzBEYVj0lUqplDoWLzDbq8vsGOixaxgM+dhFWoK7367l72hOy2M7dCH+Q494Ev/
 exfaXBeFuA0m4NXyEKZRyJ50mlwn5xE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-dhDmY_71P4et0mN2PyQ4oQ-1; Tue, 07 Jan 2020 05:00:54 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so19051132wrm.18
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FnZH1mOTI6S6trRWtwkB8lo9YA4/dfg4wGgJnrEExHw=;
 b=jIyNH7ueiCpzJAx8UBqlKvczwSyrIlgFySmHzG283gFggryoTEBSFUf6x1GhDnLmbf
 t9WGL2fRL8GlXfXWiSAOJ2+6UevU0F8e+W4lRe4vDQKu9+4WOenpgWVEEYytd9RKnk3f
 olIeiKs4B40U1oNw/goXUXk57M8t9/E1tajGvIf8YvwIwik+NIwJqhYyJ2YG4WC3sJsR
 HtyG71iA66z1rijpCXzcTfUFpltq8eMEOy9IO3GQQC5L9dAYBwwHbKctWWMezpROYK1G
 6UPDUAEsNjpxTpyT2STnUV91frZiQg+zgU1/suFwnho4gnErvvbKI4/xzUbjyI1C8NRG
 eZJQ==
X-Gm-Message-State: APjAAAVMbLve19dDyOvScgv+Qs3YRkx4AzOzw68VBCTJhKG9AVIb7Vk0
 +FQ1KvxYzo7vsRKPmOBOrswY0WjDMor4VBEzsc5eqwQx6lps0lhP/TigSuXRwY/dbbTy2UXazbK
 qDoHGAycrtAjUc/U=
X-Received: by 2002:a5d:458d:: with SMTP id p13mr62372507wrq.314.1578391253227; 
 Tue, 07 Jan 2020 02:00:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzoevhckqjGJT3m7DvQUqJbJbNJj3yzVAlsWvbkOQy4Pwogb9D4lrWbHDH1NPepVhEk51c5mw==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr62372481wrq.314.1578391253019; 
 Tue, 07 Jan 2020 02:00:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id h2sm81728798wrt.45.2020.01.07.02.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:00:52 -0800 (PST)
Subject: Re: [PATCH 04/14] hw/i386: Restrict fw_cfg to the PC machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-5-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <972f23b6-60f2-7f5b-5090-1baf9c8105c4@redhat.com>
Date: Tue, 7 Jan 2020 11:00:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191231183216.6781-5-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: dhDmY_71P4et0mN2PyQ4oQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/12/19 19:32, Philippe Mathieu-Daud=C3=A9 wrote:
> Only the PC-based machines use the fw_cfg device. In particular,
> the MicroVM machine does not use it. Only compile/link it when
> machines require it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Sergio Lopez <slp@redhat.com>
> ---
>  hw/i386/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 6ebb6d0cf0..48f2693546 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -5,7 +5,7 @@ obj-$(CONFIG_PC) +=3D pc.o pc_sysfw.o
>  obj-$(CONFIG_I440FX) +=3D pc_piix.o
>  obj-$(CONFIG_Q35) +=3D pc_q35.o
>  obj-$(CONFIG_MICROVM) +=3D microvm.o
> -obj-y +=3D fw_cfg.o
> +obj-$(CONFIG_PC) +=3D fw_cfg.o
>  obj-$(CONFIG_X86_IOMMU) +=3D x86-iommu.o
>  obj-$(CONFIG_VTD) +=3D intel_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) +=3D amd_iommu.o
>=20

It does use it, it calls fw_cfg_init_io_dma.

Paolo


