Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A8AC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9199220784
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPN7WddY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9199220784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFFo7-0001gL-Pf
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFFnU-00019i-NU
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFFnS-0007x6-D8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:26:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFFnQ-0007vZ-LP
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584703595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MczUGs3t85ue0KUv57pAFvP8kgun8m27r/EjnsOqR+4=;
 b=GPN7WddYQmU/+TK3cvptVLi+4A+4HfGwlmVrJL9Uh60Y8Baeco0Bu3qzvbVTRSmjMM2Vxr
 Ld1JSiybL6LNa1wpIEsv269rqbSgnCpeU5UzaS7wRsxAMlyjbeRUO8srW7CWDqvFso1zsp
 VMY7n9Ese4LT5RA6eN9ZQg5FdXzFVPM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-rKLjxuERO7ikmFRp-vR4eA-1; Fri, 20 Mar 2020 07:26:33 -0400
X-MC-Unique: rKLjxuERO7ikmFRp-vR4eA-1
Received: by mail-ed1-f70.google.com with SMTP id l8so4786818edq.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 04:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7xyVqb2bbfa2Ta/ujzE7VK3fjLYCSEl9LWFSMaeqJA0=;
 b=i2jzcUvNZV4ZEicYhUn93PeEllIU+yQ31Wqr1pxGF57TwPbnh9l5q7fAKb6dZIWNP3
 tnta3v/ZKzbZnDEaazGZzcQ4TbusQJEd4Kj/3HpZS/FDmMWguDUkF8r1fwnEUAu1pck6
 FYA0dAMhuzBCqQnDLyAJJFMj1jR0whw7MbTvxO3I3fFRc9nLPCatRndpVnFx+adH152N
 GSMn3Yql2y92V6J3RU2THNbt/FJ4/27HSmmVmohVELbYhFKfbA/cWoJ62Ic7cI68+gOp
 he6tlB05L8hrRG3K+TuI7sCWpOdBrQ+8AdZrnKsKO8DO597szIitMROVgLkHVH/ND2Yc
 0imQ==
X-Gm-Message-State: ANhLgQ3sDZk1eSjqbmSAYT4feOTTYdQCLIYyKhseOA572Tcwgw6OPM4n
 yBtvY9elrddQdcnR70DKjqw5EJLX5O3hIZszqCw4c9ix7FmVYaarl+4Y/kzgmh/qHgCR7r5QFzZ
 82CLqtCM3mhqwi1k=
X-Received: by 2002:a17:907:271a:: with SMTP id
 w26mr7939092ejk.271.1584703591513; 
 Fri, 20 Mar 2020 04:26:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvmxB2anTO7PgbYn3Hz3U9+XJwHazKJNO1kAipq9rN/pEmPhm0VU9sAFyZw6zV6mueGUg0djA==
X-Received: by 2002:a17:907:271a:: with SMTP id
 w26mr7939071ejk.271.1584703591281; 
 Fri, 20 Mar 2020 04:26:31 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id pk18sm329763ejb.29.2020.03.20.04.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 04:26:30 -0700 (PDT)
Subject: Re: [PATCH] virtio-iommu: depend on PCI
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200320104147.643941-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c4aa30a7-6dca-c3da-9343-45cc6a9b8272@redhat.com>
Date: Fri, 20 Mar 2020 12:26:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320104147.643941-1-pbonzini@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: eric.auger@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 11:41 AM, Paolo Bonzini wrote:
> The virtio-iommu device attaches itself to a PCI bus, so it makes
> no sense to include it unless PCI is supported---and in fact
> compilation fails without this change.
>=20
> Reported-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/virtio/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index d29525b36f..83122424fa 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -12,7 +12,7 @@ config VIRTIO_RNG
>   config VIRTIO_IOMMU
>       bool
>       default y
> -    depends on VIRTIO
> +    depends on PCI && VIRTIO
>  =20
>   config VIRTIO_PCI
>       bool
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I see hw/virtio/virtio-iommu-pci.c apart, what is the difference?


