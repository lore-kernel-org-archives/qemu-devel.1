Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C24C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7DD24684
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjP74i9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7DD24684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwPBI-0007kx-1w
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwPAk-0007H0-17
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwPAi-0008FA-J0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:36:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40197
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwPAi-0008E1-F6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580211403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KISe04aOvz+cdMxhAYI3rVzjgn3PbNcjWrE82vtQD8U=;
 b=PjP74i9dxRWwMnAgAr1TzlMOiL/fMG1TP0utXgWjmRtOrC0vub9JqQhvSMvL6nPEhX9y01
 iNXHu+g5vuzURX0zGhhcjydosQwuruw52i9HHZaAtX3+BfBoBc6FBkP17LuppyiWXUtyek
 W4QOsM06013S+iVa2a11kN1JT+it4bA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-uptomnKOMsCaq6axjyO51g-1; Tue, 28 Jan 2020 06:36:42 -0500
Received: by mail-wr1-f71.google.com with SMTP id 90so7892727wrq.6
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 03:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KISe04aOvz+cdMxhAYI3rVzjgn3PbNcjWrE82vtQD8U=;
 b=nKv7ImT01FER2imLNwP33IUVdDxkTs49qxsYnpn+gNzU2vTHefiXu389SRKJAy0E8q
 geu2VhP51kP+uvoMjBP1hk4N09BblJs74DX4R1v7VKfw97Qti3PNJRzBZNdn8OdC6RiI
 nq8pdCxo9NQP9y9reXgIhMdCFra9N1DOSEpFkw0y/YIpqRDt0Qou8h+Aro8gyHZqkKqp
 0+YD8hepvaFiKLiZUpPAsP+6Ayx+JS0LhJQoZbBL86Drym5CW/QNxv3dncHaj93ldZIw
 +/FNd5yX2MDGksDb8No7UiGObhwLG8m1K3p9uvhEi7FSVDZjp6Yt+yAl3BmnTad9yGZT
 FBAA==
X-Gm-Message-State: APjAAAUdm1Ju2nnPWGVtYGGNdJmlJ5uR6FgiPm6CA5lS1dflDheFKZ40
 0n7dX7H0E9smGegxZ++JkFS1jFIYjAQhzMwTZoqi0NbHuvdWYhlX2IVZyVF5wGjMh3dBNP2kmOP
 bZP2uE0YIODew4WU=
X-Received: by 2002:a05:600c:54b:: with SMTP id
 k11mr4563417wmc.63.1580211401157; 
 Tue, 28 Jan 2020 03:36:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkyWRMR9a9svoXoIbzPMNYln9xgYrtUho4ELdQHtQPNwy4CIpn+RyvGKNjFHeOOQchZTesKA==
X-Received: by 2002:a05:600c:54b:: with SMTP id
 k11mr4563390wmc.63.1580211400892; 
 Tue, 28 Jan 2020 03:36:40 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id u1sm2599661wmc.5.2020.01.28.03.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 03:36:40 -0800 (PST)
Subject: Re: [PATCH] qxl: introduce hardware revision 5
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200128112851.15895-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e73baad8-8be3-50de-7d9b-a5248c97d717@redhat.com>
Date: Tue, 28 Jan 2020 12:36:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200128112851.15895-1-kraxel@redhat.com>
Content-Language: en-US
X-MC-Unique: uptomnKOMsCaq6axjyO51g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/28/20 12:28 PM, Gerd Hoffmann wrote:
> The only difference to hardware revision 4 is that the device doesn't
> switch to VGA mode in case someone happens to touch a VGA register,
> which should make things more robust in configurations with multiple
> vga devices.
> 
> Swtiching back to VGA mode happens on reset, either full machine

typo "Switching"

> reset or qxl device reset (QXL_IO_RESET ioport command).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/display/qxl.h  | 2 +-
>   hw/core/machine.c | 2 ++
>   hw/display/qxl.c  | 7 ++++++-
>   3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> index 80eb0d267269..707631a1f573 100644
> --- a/hw/display/qxl.h
> +++ b/hw/display/qxl.h
> @@ -144,7 +144,7 @@ typedef struct PCIQXLDevice {
>           }                                                               \
>       } while (0)
>   
> -#define QXL_DEFAULT_REVISION QXL_REVISION_STABLE_V12
> +#define QXL_DEFAULT_REVISION (QXL_REVISION_STABLE_V12 + 1)
>   
>   /* qxl.c */
>   void *qxl_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL phys, int group_id);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 3e288bfceb7f..13a3b2c9c425 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,6 +34,8 @@ GlobalProperty hw_compat_4_2[] = {
>       { "vhost-blk-device", "seg_max_adjust", "off"},
>       { "usb-host", "suppress-remote-wake", "off" },
>       { "usb-redir", "suppress-remote-wake", "off" },
> +    { "qxl", "revision", "4" },
> +    { "qxl-vga", "revision", "4" },
>   };
>   const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
>   
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 6d43b7433cff..c2e89ea40924 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -1309,7 +1309,8 @@ static void qxl_vga_ioport_write(void *opaque, uint32_t addr, uint32_t val)
>       PCIQXLDevice *qxl = container_of(vga, PCIQXLDevice, vga);
>   
>       trace_qxl_io_write_vga(qxl->id, qxl_mode_to_string(qxl->mode), addr, val);
> -    if (qxl->mode != QXL_MODE_VGA) {
> +    if (qxl->mode != QXL_MODE_VGA &&
> +        qxl->revision <= QXL_REVISION_STABLE_V12) {
>           qxl_destroy_primary(qxl, QXL_SYNC);
>           qxl_soft_reset(qxl);
>       }
> @@ -2121,6 +2122,10 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
>           pci_device_rev = QXL_REVISION_STABLE_V12;
>           io_size = pow2ceil(QXL_IO_RANGE_SIZE);
>           break;
> +    case 5: /* qxl-5 */
> +        pci_device_rev = QXL_REVISION_STABLE_V12 + 1;
> +        io_size = pow2ceil(QXL_IO_RANGE_SIZE);
> +        break;
>       default:
>           error_setg(errp, "Invalid revision %d for qxl device (max %d)",
>                      qxl->revision, QXL_DEFAULT_REVISION);
> 


