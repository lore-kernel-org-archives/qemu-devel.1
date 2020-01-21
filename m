Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6BDC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D58217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a++CnpxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D58217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwc8-000278-2W
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itwbM-0001GO-0v
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itwbI-0003zx-AH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:42:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60762
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itwbI-0003zG-6r
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579624919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZQr3GJu4EloNbDA2o3rszEPhn62VWD7FbqVrGUQdLc=;
 b=a++CnpxB91iZb38ne3mf8x3aXoSU79YLKvZmOp3xrXI2BZARdzLc0sbKAoD6XM0k8S3Llc
 OXWkj56snIAtsrH+ChKWAerK8HbC5whM0ltFkV7Hr6qswz0QG4SDKkJly6w3puO/H8U47U
 BCcrOFhfHKbvPcAZD71JmsJo9lgn3xM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-dhcmcgqwN4uab5ckCNrodA-1; Tue, 21 Jan 2020 11:41:55 -0500
Received: by mail-wm1-f71.google.com with SMTP id q26so584034wmq.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 08:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=50Z4SvxBYXC9Ur5iEhPZHFt5fxBKiuXYxOly19jt+08=;
 b=HSb5X3i5e+g0fvM8tRf4gzRwEvX3JfZB0YkLq36PFusuCVdr7sRss+xIRUxIdwrLZJ
 H61FFvEWiRLSksbQub1MbKwm7pcwk4+WmN9kRXsUABI24U+nJfZClTgFQJVS6vT89tb4
 /rD9CTMFsyMFLEIj/A8tVZPJX4qDTVqUhjd1sZJLAhm983BKabdnCgkY5AHmvsB3KvGb
 RSO9TICzm+wam/UnnHB03ZUSMyIUSA6LgcXhEyt5di7wGTVBLQB+qo0YIt6ttvddD8lN
 jqCC1n0gRdVtF38HwvoNqDgn3QvXI2/QngYQmK3u+yRlo9aBW+ATCTej0iGWjgmHSA35
 O2ew==
X-Gm-Message-State: APjAAAUTAQDHPqnDjD/RUWG2gjRzJD/BkYHOpBn5ECqLD+Qxg3J0Nv/3
 i/NpUKppMSAN6xLofXaCxowN6/dKadN4CSzzYJnoXCaHOMpA/9ch8cLqYs2KTgUoxynHn97WfZo
 3TrtNiIEMCdyi6eM=
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr5265093wml.110.1579624914097; 
 Tue, 21 Jan 2020 08:41:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfF6tXDyMLPEMBHkhw2xOprNxB5uRcWPNI62+6B4YfZ4FR0hQHYnaHFyHAGh5pRvoDRHMpug==
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr5265070wml.110.1579624913800; 
 Tue, 21 Jan 2020 08:41:53 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w8sm493719wmd.2.2020.01.21.08.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 08:41:53 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] trivial: Remove xenfb_enabled from sysemu.h
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
References: <20200121161747.10569-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cf8a8ee3-0c95-20f3-3225-31bb8413344e@redhat.com>
Date: Tue, 21 Jan 2020 17:41:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121161747.10569-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: dhcmcgqwN4uab5ckCNrodA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 5:17 PM, Thomas Huth wrote:
> The define is only used in one other place. Move the code there
> instead of keeping this xen-specific define in sysemu.h.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/xenpv/xen_machine_pv.c | 2 +-
>   include/sysemu/sysemu.h   | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
> index 3a8af1a1e0..8df575a457 100644
> --- a/hw/xenpv/xen_machine_pv.c
> +++ b/hw/xenpv/xen_machine_pv.c
> @@ -60,7 +60,7 @@ static void xen_init_pv(MachineState *machine)
>       xen_be_register("qnic", &xen_netdev_ops);
>  =20
>       /* configure framebuffer */
> -    if (xenfb_enabled) {
> +    if (vga_interface_type =3D=3D VGA_XENFB) {
>           xen_config_dev_vfb(0, "vnc");
>           xen_config_dev_vkbd(0);
>       }
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 80c57fdc4e..2ccf216158 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -32,7 +32,6 @@ typedef enum {
>   } VGAInterfaceType;
>  =20
>   extern int vga_interface_type;
> -#define xenfb_enabled (vga_interface_type =3D=3D VGA_XENFB)
>  =20
>   extern int graphic_width;
>   extern int graphic_height;
>=20


