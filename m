Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975D5C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA9324677
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVEWv8Nx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA9324677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomK0-0007VW-Hc
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ioldV-0005FZ-Ri
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ioldU-00013V-Hn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:58:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45012
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ioldU-00013G-Dn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578391132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGaxt7S0LgnE+RWHbixBkCw6KNKbOW7a/NWJjQrCC/s=;
 b=VVEWv8Nx8yeDTENkICAuJK9ziqPfVyyqsdO3DwiXqBFsiTg81ZP/YpF1siX1ShFpcLczz2
 4YjskowPqkcXlM/GwBhCbw023CmwA73m76In9Pp+uxR27enhEKDSZ+Bm1wIzCQmR88fkTm
 7ibiDzDsWV1HAlEWmCe6biLqpfyOVoQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-pPRjFe_bMWS6X6Q9Xaf1wA-1; Tue, 07 Jan 2020 04:58:51 -0500
Received: by mail-wm1-f72.google.com with SMTP id o24so1779470wmh.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 01:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ipv/eoA8st4pkPe0NHevCXpF6nMYSBmo05/clUGxufc=;
 b=pxbfCJry9iKlbskBCOfhH0XEBck5nQpa2G9PmpctwYLtnQhc8k3Jhz1F0Fm8bwCP9H
 kDI6sN+c00TraUpwy++kPgJdNIRSx3Ma/fvlWMxKpoWZCHFF2Z6OiDAQZ+VsvDguZ6BD
 nOfnXw9SKbKe0tK4X+E1lYmNpbqxO7hcHAbrVW4/LTD9Fo4SS5yuHyTT2G2RAz0KLuWi
 od2YC2TC1e/EYm/Xq7eQKT+PlM1YEcWKLi5o2aiQEWMtDdFgjW7HXjSyNPDMQJMMu/cO
 D996Q50Cf1kX/EkvIv4fcZUTB4RmTBW+qE+m6v7D+6mInAbzGJxMaoD2+Vu3X0UdcICM
 jt0w==
X-Gm-Message-State: APjAAAVYQmhw4FCgOXjEuAHNCCMSabbyqVLp9v3hapsSXvcULIEPsk45
 BhnUYYGKKQKVlpClEBKlmX3spP90MQkroNoyUc7ccAEhtl9XhM6BKnojJqqV1i9df0zxOxCz80+
 h2tSy+0PUU9gKCuw=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr38816016wmj.117.1578391129463; 
 Tue, 07 Jan 2020 01:58:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqznM70om4LZ6ytUCJD4AlFATYUabhqjS2w0dpP+bB7Oosb54s5LgY1hrVTzT0H7wBFc03sSSA==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr38815993wmj.117.1578391129172; 
 Tue, 07 Jan 2020 01:58:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id t5sm74681116wrr.35.2020.01.07.01.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 01:58:48 -0800 (PST)
Subject: Re: [RFC PATCH 14/14] hw/intc/Kconfig: Let APIC select IOAPIC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-15-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8291aad-ff1c-1ead-e311-b096514c16af@redhat.com>
Date: Tue, 7 Jan 2020 10:58:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191231183216.6781-15-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: pPRjFe_bMWS6X6Q9Xaf1wA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
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
> apic_eoi() calls ioapic_eoi_broadcast(), so APIC has to
> select the IOAPIC Kconfig.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>=20
> RFC because I'm not sure the design is correct (meanwhile the fix is, how=
ever).

Just add a comment like "# for ioapic_eoi_broadcast()".  If anybody
wants to drop it, they can add a stub.

Paolo

> ---
>  hw/intc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index a189d6fedd..82748ae13d 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -24,6 +24,7 @@ config APIC
>      bool
>      select MSI_NONBROKEN
>      select I8259
> +    select IOAPIC
> =20
>  config ARM_GIC_KVM
>      bool
>=20


