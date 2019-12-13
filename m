Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB5DC2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722B224125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U10MTE07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722B224125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjY6-0004g9-B9
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifjXN-00043f-Qw
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifjXI-0004UC-AC
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:55:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54586
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifjXI-0004TJ-6I
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576238107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARv6mcy281jUa1nbgAjuLfWfQQSOGGA4O9KDT/2tagM=;
 b=U10MTE07/2ymqJaPIfCcIkg8vU7h7S2L78KPEiM5lBqBPyISE4nvAc9Hu7cx4RFKbNORlu
 ETUbK+/xbqaccRHTLLA44DaUVnSW8mDvEVY2wn1zlp/GOE/c8A/P7kzvWqpNAhujUNvlD2
 bC6sbkI3ugCLT8kBnMIAONtADfI6Q64=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-o7R-LI4qNUmRrpC5cZodZA-1; Fri, 13 Dec 2019 06:55:04 -0500
Received: by mail-wr1-f69.google.com with SMTP id i9so2496524wru.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 03:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z1TphYBfZEVPZphlaqakJCWwiVWqp8Gd3XbmpXjBi4I=;
 b=PffXhGIqvUMbgK2a/IpdIkQ/Q1Gvv08LOguZN8j8iErNuBfIBCaIla9wA1LB6DBVef
 bYzSTwpBRCPAdrhDb8oFwTf7kOxkqrWhQ9QS/WuLaKHs7W3+XLPCetTavWKxPsVrW+wn
 lWmIaFQydYdcWHVx8vGP2Tgt8sUxtwCQmirW7imHixNonM8V0dQcx7zgm8fMvhzJeX5P
 /KYzLFFi0EDWljKqToT0pQtjsRsVftI/OAqprkN5FmXae5qELKYRzmpsO+D1i1/3pXyS
 MSXq67N0Jigeyk0xUjLnnITHRk/bfGf9d6j5LUmPsomxDvxKpvvKChkZktgB6WVf3w1R
 lyIg==
X-Gm-Message-State: APjAAAVtD3LjLhtMny/pz+QIiRsEtFroBa8HPfeJNDOsrWVHo1hU7IoF
 72apW9vOLYPeTOLWUNsqhINnS4GL9Ed7UY8P5UsWtWGW/EQh61SYHfoCMFd+umx5cMcVVuJu5tm
 C/iizs60sPszPiTw=
X-Received: by 2002:adf:c54e:: with SMTP id s14mr13010791wrf.385.1576238102948; 
 Fri, 13 Dec 2019 03:55:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxp97+/F1/T9RSvc65pPuib8yjdamuaVfF7HAVYD1x+PRiPlaxWvZC+lr5Tc/0mj0ARxgfZCQ==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr13010772wrf.385.1576238102737; 
 Fri, 13 Dec 2019 03:55:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id g2sm9668770wrw.76.2019.12.13.03.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 03:55:02 -0800 (PST)
Subject: Re: [PATCH] hw/i386/pc: Simplify ioapic_init_gsi()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191213111145.11288-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <573a8391-ff5d-601c-e651-75025a1ea026@redhat.com>
Date: Fri, 13 Dec 2019 12:55:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213111145.11288-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: o7R-LI4qNUmRrpC5cZodZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/19 12:11, Philippe Mathieu-Daud=C3=A9 wrote:
> All callers of ioapic_init_gsi() provide a parent. We want new
> uses to follow the same good practice and provide the parent
> name, so do not make this optional: assert the parent name is
> provided, and simplify the code.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/pc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ac08e63604..234945d328 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1488,15 +1488,14 @@ void ioapic_init_gsi(GSIState *gsi_state, const c=
har *parent_name)
>      SysBusDevice *d;
>      unsigned int i;
> =20
> +    assert(parent_name);
>      if (kvm_ioapic_in_kernel()) {
>          dev =3D qdev_create(NULL, TYPE_KVM_IOAPIC);
>      } else {
>          dev =3D qdev_create(NULL, TYPE_IOAPIC);
>      }
> -    if (parent_name) {
> -        object_property_add_child(object_resolve_path(parent_name, NULL)=
,
> -                                  "ioapic", OBJECT(dev), NULL);
> -    }
> +    object_property_add_child(object_resolve_path(parent_name, NULL),
> +                              "ioapic", OBJECT(dev), NULL);
>      qdev_init_nofail(dev);
>      d =3D SYS_BUS_DEVICE(dev);
>      sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
>=20

Queued, thanks.

Paolo


