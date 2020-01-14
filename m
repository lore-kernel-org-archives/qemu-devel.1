Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CED8C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1717324656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFPbcvvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1717324656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irPiq-0005ls-2Y
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 12:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irPi7-0005EL-Un
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:10:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irPi3-0008M6-Qf
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:10:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53214
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irPi3-0008Lc-MS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579021830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+ZYtFCXDDg/9vE2XlDX94PBAkRln6CzZAI1Bq5000E=;
 b=hFPbcvvN9nOsFjPaD2sfcYui/QjCJBq0xx66kaS2ojg2cL2Sxbf0hmAF8nvLvJg8U8tUHN
 GCnSKoIRl12LovsUiJZbDXO18GgTe5ZUXsgzHYiEn6YVP3ZxbhtY3adn67F0it/Jo6yQcp
 glt7pywogW6MJFS+WhUxLVZ7Sdku640=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-rG6Og5C-N1WzVzG2o-ScsA-1; Tue, 14 Jan 2020 12:10:29 -0500
Received: by mail-wr1-f70.google.com with SMTP id f10so6782987wro.14
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 09:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G+ZYtFCXDDg/9vE2XlDX94PBAkRln6CzZAI1Bq5000E=;
 b=czXgZAtzCxCXn0+dh+ghXuw6cnTPTye/wSlX4fzEhhfAJIipCGDjJrnwJk8HTtEy/3
 wiSxEo0rbnC/DXlFumKcKstab+P5iKOhyXH5q6rlvao9dVVGjRBZ8dl7/rfRVGr6nRZi
 KCwL36oVevGVYZB44sWjk2jwn7QkPKdm2ro1bU/Il16u/Ke/ATJ+AvoPrYwfnsmtIHoW
 djV/RvgCHypH7+ZMqMfq0XO23+bqkL2dbqndpU9y+PErizEy5P9sNFBzbjcNR3ibqsLm
 R6aVbh1ZCffhwECG3n0VJde0BclyHh1wdMNE1ytwXReHeELqzEV9rFuywpQBb7/MqKDx
 srIA==
X-Gm-Message-State: APjAAAXGbjN5OW3e0OZXwbvsoUjA+6JiH9AuyT94hW5BuvGIaxdzAuzx
 RvZUWWNE/kKktG1ik/kPFHLWClh48q3wzYk6C8KIjRANzjxVW3sg9styOmxXSwKXPjqWZffLJ6z
 KP2/Ib40p2mcHu4E=
X-Received: by 2002:adf:c54e:: with SMTP id s14mr27567189wrf.385.1579021828164; 
 Tue, 14 Jan 2020 09:10:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzlIPr3Kxhwju5YZUOU2/2VKoVdbopXtXeqtoDfIXsylrvqvyouTJsADRJDVeRRtGlWLu6MAg==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr27567168wrf.385.1579021827941; 
 Tue, 14 Jan 2020 09:10:27 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id v8sm19428738wrw.2.2020.01.14.09.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 09:10:27 -0800 (PST)
Subject: Re: [PATCH] hw/vfio: Move the IGD quirk code to a separate file
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20200114161757.28831-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c82afcab-8f0b-d6ed-af40-0611b178f910@redhat.com>
Date: Tue, 14 Jan 2020 18:10:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114161757.28831-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: rG6Og5C-N1WzVzG2o-ScsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 5:17 PM, Thomas Huth wrote:
> The IGD quirk code defines a separate device, the so-called
> "vfio-pci-igd-lpc-bridge" which shows up as a user-creatable
> device in all QEMU binaries that include the vfio code. This
> is a little bit unfortunate for two reasons: First, this device
> is completely useless in binaries like qemu-system-s390x.
> Second we also would like to disable it in downstream RHEL
> which currently requires some extra patches there since the
> device does not have a proper Kconfig-style switch yet.
> 
> So it would be good if the device could be disabled more easily,
> thus let's move the code to a separate file instead and introduce
> a proper Kconfig switch for it which gets only enabled by default
> if we also have CONFIG_PC_PCI enabled.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/vfio/Kconfig       |   5 +
>   hw/vfio/Makefile.objs |   1 +
>   hw/vfio/igd.c         | 616 ++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci-quirks.c  | 614 +----------------------------------------
>   hw/vfio/pci.h         |  17 ++
>   5 files changed, 642 insertions(+), 611 deletions(-)
>   create mode 100644 hw/vfio/igd.c
> 
> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
> index f0eaa75ce7..7cdba0560a 100644
> --- a/hw/vfio/Kconfig
> +++ b/hw/vfio/Kconfig
> @@ -36,3 +36,8 @@ config VFIO_AP
>       default y
>       select VFIO
>       depends on LINUX && S390_CCW_VIRTIO
> +
> +config VFIO_IGD
> +    bool
> +    default y if PC_PCI

With the details from Alex here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg663667.html

I'm tempted to use:

     default y if XEN
     depends on PC_PCI

Watch out the Xen Kconfig seems fragile, yesterday using --enable-xen 
--disable-tcg I hit this build error:

   LINK    i386-softmmu/qemu-system-i386
/usr/bin/ld: hw/xen/xen_pt.o: in function 
`xen_igd_passthrough_isa_bridge_create':
/home/phil/source/qemu/hw/xen/xen_pt.c:701: undefined reference to 
`igd_passthrough_isa_bridge_create'

> +    depends on VFIO_PCI
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index abad8b818c..9bb1c09e84 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -5,3 +5,4 @@ obj-$(CONFIG_VFIO_PLATFORM) += platform.o
>   obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
>   obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
>   obj-$(CONFIG_VFIO_AP) += ap.o
> +obj-$(CONFIG_VFIO_IGD) += igd.o


