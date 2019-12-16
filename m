Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FB6C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC712053B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBWD0t3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC712053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igq8P-0007pS-Ge
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 08:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igq7M-0006qH-Do
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igq7L-0001iA-1Y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:08:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igq7K-0001gK-Un
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576501734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vW71febaZ6KqLELxDd277QVRHIP/LeDFnIhgDGUV3kk=;
 b=FBWD0t3K0G0l9pgjzq+IC62/1FhOHgmCChZkPP7DyQJr85CvkYHZn15SitYLO3Bin5stVD
 hZQbwmlJQrujSmHRW5nRdWRRYg3UejU+Y+w25RxxdyPREUZ1nP6EX/GFz+dfXFxeRRch7i
 ZEdNMGs+WLZ3tbKy1RgM/4kPQana3GU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-1tqih71DOXe-8rLA25qJKQ-1; Mon, 16 Dec 2019 08:08:52 -0500
Received: by mail-wr1-f71.google.com with SMTP id z15so3716353wrw.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 05:08:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qVps0ksEeffzPKmQcVs/p+Pjxq+Vz+TDTh2GnN60Xxw=;
 b=A/Nv3aaJjukRwfTHryv1Grk1h/R7G850hCOzwZOhT1i5ikH+u6xxYGW4ktN1Re9rOm
 bzKiPZWAsBJSbv4QKRNin4gqm5tt+GI24L3XkEpZRfG44fC3koee0Xt+ooZOW0wEwIqo
 vNd3t/fc5AItS1OGkSYISkK+GgIe3DDfjXWBcLnjSKzRFxiO6akPBGnoYsXh+EyQfKPo
 2YrA1uyl+HlESQ2YCJTxPM18gKorN67RgvSeTW+BoQZqmVx6TC9ZXYefksqAsHQD11c3
 x+RVLcOQfjeiNdZg9OAknVqh62MoESNHSeDq6kyHMxq4IMNnMS1icoViOMC0TDP6wRNM
 edjg==
X-Gm-Message-State: APjAAAWSrAaZkYFh7VnDAFz0FwO74sSaUTYc9VbhLX8EdR5a1iZu5nJ2
 SHyBQe8GjSFdxIvH61UUMEf99s8vhsHP6QygYhlsQTgZJZ7Yehk6dPD13FjYj+NkcZepScqdnlR
 AyAnXpseLaHqEnXM=
X-Received: by 2002:adf:b648:: with SMTP id i8mr30617232wre.91.1576501731218; 
 Mon, 16 Dec 2019 05:08:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5r6BjWyq15DIgwSERvxbOhPXbbbeovtPSwMIC0Ga4pAhcnI6btOTfyyoXbuuWBe0pFwLUzg==
X-Received: by 2002:adf:b648:: with SMTP id i8mr30617202wre.91.1576501731026; 
 Mon, 16 Dec 2019 05:08:51 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id x11sm21078428wmg.46.2019.12.16.05.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 05:08:50 -0800 (PST)
Subject: Re: [PATCH 03/12] hw/i386/pc: Remove obsolete pc_pci_device_init()
 declaration
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191213161753.8051-1-philmd@redhat.com>
 <20191213161753.8051-4-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39ca6020-193e-294b-2845-f5bab35609ef@redhat.com>
Date: Mon, 16 Dec 2019 14:08:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213161753.8051-4-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: 1tqih71DOXe-8rLA25qJKQ-1
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/19 17:17, Philippe Mathieu-Daud=C3=A9 wrote:
> In commit 1454509726 we removed the pc_pci_device_init()
> deprecated function and its calls, but we forgot to remove
> its prototype. Do that now.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/i386/pc.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 9866dfbd60..bc7d855aaa 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -211,7 +211,6 @@ void pc_cmos_init(PCMachineState *pcms,
>                    BusState *ide0, BusState *ide1,
>                    ISADevice *s);
>  void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)=
;
> -void pc_pci_device_init(PCIBus *pci_bus);
> =20
>  typedef void (*cpu_set_smm_t)(int smm, void *arg);
> =20
>=20

Queued, thanks.

Paolo


