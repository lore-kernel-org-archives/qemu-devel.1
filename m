Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AEEC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8632B2073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUQx+yh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8632B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieIo7-0007hq-8T
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieIkb-0004Ka-9E
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieIkY-0003rG-R6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:06:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43107
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieIkY-0003p1-GI
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575896813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7qHSuFE4xQP0UBGVO8GzfH55b3bU9ZOU2qCJgMn9BE=;
 b=LUQx+yh1/CLXtLl2n5zDAbXPIt7oRsbP/DQF7sQLTpJTtAcvt4cFC8tmRJLfIlQa5JxAUG
 OHy4A6q2OIbe9EylLTDhYaePI5Hsg3mrDtr38LYanszIijxhQY9Vopw16Hvy/UIwbadkmH
 1u+MX8Y8O/zWQqIuh+J2PCR7qbB2/l0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-d5MYWUFnMXSYQOsSyog5mg-1; Mon, 09 Dec 2019 08:06:50 -0500
Received: by mail-wm1-f72.google.com with SMTP id y125so7062053wmg.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 05:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R7qHSuFE4xQP0UBGVO8GzfH55b3bU9ZOU2qCJgMn9BE=;
 b=krsFnqFVmJGzXYEsd5baI/0mnCH+dSvteB0m28LgiGOtQ2rAfkszGO1f44ePyrBCdu
 RQKHOczhglzJyJ//j/Kjdjimg17C7mR/iV4ktI7ueWb93HsPSttNWWgYEh3ORFpocj5q
 fowurnc/lTTAcPawzRCZPYoQPDexrU1YTfMgJFPXiwPL2vT5B0bDb8p4RTfodtiYamwS
 lDK2vzEY+I0e5Z5f3fzPkgLr5aP9lU2ufpN2XKjC3bGzZtz8IVWTWHHp10TxHE1TQn0c
 B3Zo7wFkvzOGq5OJcLAzrsrgd1AVHkWm03I8MO6DcK9TeBkaWr3bmObxjkxNdnebzL/7
 NEaw==
X-Gm-Message-State: APjAAAV4TTtirAOWznDAVg+KdyjvZpfIeW0VbtDyzYJSwr9sxzbrR7Ze
 oabsG8yp+Tp0zOvZVk3/HumCSeyaGHXcfIoC838X8ENMtklK97GoxZJZp5/0ZRi9Bg164e4x0BK
 hbVvRHijbklb4mk0=
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr2243860wrp.17.1575896809423;
 Mon, 09 Dec 2019 05:06:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzy624tIlqCkig9fzZuVEHxDvpHhQNzLJAOQnvtoZC8VqUdE/JjAl6D8TseH/9HH0NrAQscfw==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr2243835wrp.17.1575896809132;
 Mon, 09 Dec 2019 05:06:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id o189sm11255250wme.29.2019.12.09.05.06.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 05:06:48 -0800 (PST)
Subject: Re: [PATCH v2 0/4] Remove deprecated pc-0.x machine types and related
 hacks
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20191209125248.5849-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05af415a-5058-98b4-4a12-9d093a30b1e3@redhat.com>
Date: Mon, 9 Dec 2019 14:06:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191209125248.5849-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: d5MYWUFnMXSYQOsSyog5mg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/19 13:52, Thomas Huth wrote:
> These have been on the deprecation list since a year now, so it's
> time to finally remove the pc-0.x machine types.
> 
> We then can also remove some compatibility hacks in the devices, i.e.
> the "use_broken_id" in ac97, the "command_serr_enable" in PCI devices
> and the "rombar" stuff in VGA devices.
> 
> v2:
>  - Minor updates to the first patch (fix comment, add deprecation_reason
>    message for the pc-1.x machines)
>  - Keep the QEMU_PCI_CAP_SERR enum in the third patch
>  - Added fourth patch to remove the "rombar" hacks from the VGA devices
> 
> Thomas Huth (4):
>   hw/i386: Remove the deprecated machines 0.12 up to 0.15
>   hw/audio: Remove the "use_broken_id" hack from the AC97 device
>   hw/pci: Remove the "command_serr_enable" property
>   hw/display: Remove "rombar" hack from vga-pci and vmware_vga
> 
>  hw/audio/ac97.c         |  9 -----
>  hw/display/vga-pci.c    |  5 ---
>  hw/display/vga.c        |  4 +-
>  hw/display/vmware_vga.c |  5 ---
>  hw/i386/pc_piix.c       | 85 +----------------------------------------
>  hw/pci/pci.c            |  6 +--
>  include/hw/pci/pci.h    |  2 +-
>  qemu-deprecated.texi    |  2 +-
>  tests/cpu-plug-test.c   |  6 +--
>  9 files changed, 7 insertions(+), 117 deletions(-)
> 

Queued, thanks.

Paolo


