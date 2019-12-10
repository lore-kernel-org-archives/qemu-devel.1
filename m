Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57200C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F94206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7WePyoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F94206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieaCY-0007TY-AO
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 02:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieaBl-0006kL-0R
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieaBi-0003QD-Dp
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:44:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50207
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieaBi-0003Pe-90
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575963844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJ+RLC/vcSgOE1EhsMl39jeHDMf1Cw+xk0nSGismuVY=;
 b=g7WePyoa8A5oWr1zdxfaIwTpoh+5pgHeVPGBudpDBjHuC9GWf0PZp3XHE2CjMnQdZhgDyp
 8PjEdkeggltdKPJ+DtjrX0on7Ra7bRUTb/G66eS/qDnYkKkWPAxbChoBi3rVx1a/t1WjgM
 jugMMDDXodm3p3KERwHKTg2HqjfvYQk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-Cy47fjNCMpKdy_KAdtNljQ-1; Tue, 10 Dec 2019 02:44:03 -0500
Received: by mail-wm1-f70.google.com with SMTP id l11so557728wmi.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 23:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IJ+RLC/vcSgOE1EhsMl39jeHDMf1Cw+xk0nSGismuVY=;
 b=KsHT6DpyFVhpxKpltshxO7ZiZxaLfiUM4zak9RxCMaPaJRbL1iUkFVI9VBPxL9h9cB
 dhBxBlbVvEYGT0rz75BFhlotfP9+y4GRunbHR8Vh7TvYjCA236trVoa2WSQXuBvUVolO
 3VJep2pjpYfHlBY2J7HZaiHpiwU/e1BkAw1fgMCtpYOBg6i6EoP7L7cwupRI9/0SMwuo
 eICN/Imox3Bp2VncqmH82hQmKklhF35jLq0dqdgnY6DZnxoxrq70ar+BeDizv7kfAoDa
 b8+kX42smjznj2PGCwiMmz2ClJJ2dIYw2JusmA5TgVPQx3/VU6mEQL2UPPRiU6gwUdI2
 ZPEw==
X-Gm-Message-State: APjAAAUuejhkOB70nBooYTnvKBT5d2w8QPB/zKGk1f5nes/tlsEktsOP
 dsnP7sgwoFgMmaXW1OR34RTrSw9g4YnCOn8gWudFhi7t00QlC65bQwFikHaqvxdIGwh9lgvtHxG
 WoHOjk/cPmNtXzMo=
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr3498362wmj.106.1575963841928; 
 Mon, 09 Dec 2019 23:44:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDLTOTpjGQC+Bq3t4W/V9/IN3XtYCcY7rJIFS04EGGxhOmIb4VYRC0RDn2VGIMX0SZzM66Hw==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr3498342wmj.106.1575963841640; 
 Mon, 09 Dec 2019 23:44:01 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id v22sm2120447wml.11.2019.12.09.23.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 23:44:01 -0800 (PST)
Subject: Re: [PATCH] hw/usb: Introduce Kconfig switches for the CCID card
 devices
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20191210072048.15603-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c402f822-bbbc-7ece-2fb4-1a37484be05e@redhat.com>
Date: Tue, 10 Dec 2019 08:43:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210072048.15603-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: Cy47fjNCMpKdy_KAdtNljQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/19 8:20 AM, Thomas Huth wrote:
> In our downstream distribution of QEMU, we need more fine-grained
> control on the set of CCID card devices that we want to include.
> So let's introduce some proper Kconfig switches that it is easier
> to disable them without modifying the corresponding Makefile.objs.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/usb/Kconfig       | 10 ++++++++++
>   hw/usb/Makefile.objs |  7 +++++--
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 555e09377b..1358847eba 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -96,3 +96,13 @@ config USB_STORAGE_MTP
>       bool
>       default y
>       depends on USB
> +
> +config CCID_PASSTHRU
> +    bool
> +    default y
> +    depends on USB_SMARTCARD
> +
> +config CCID_EMULATED
> +    bool
> +    default y
> +    depends on USB_SMARTCARD
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 303ac084a0..ebe103fb3d 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -29,11 +29,14 @@ common-obj-$(CONFIG_USB_BLUETOOTH)    += dev-bluetooth.o
>   
>   ifeq ($(CONFIG_USB_SMARTCARD),y)
>   common-obj-y                          += dev-smartcard-reader.o
> -common-obj-$(CONFIG_SMARTCARD)        += smartcard.mo
> -smartcard.mo-objs := ccid-card-passthru.o ccid-card-emulated.o
> +ifeq ($(CONFIG_SMARTCARD),y)

We don't need the 'ifeq ($(CONFIG_SMARTCARD),y)' ... endif anymore.

> +common-obj-$(call lor,$(CONFIG_CCID_PASSTHRU),$(CONFIG_CCID_EMULATED)) += smartcard.mo
> +smartcard.mo-objs := $(call lif,$(CONFIG_CCID_PASSTHRU),ccid-card-passthru.o) \
> +                     $(call lif,$(CONFIG_CCID_EMULATED),ccid-card-emulated.o)
>   smartcard.mo-cflags := $(SMARTCARD_CFLAGS)
>   smartcard.mo-libs := $(SMARTCARD_LIBS)
>   endif
> +endif
>   
>   ifeq ($(CONFIG_POSIX),y)
>   common-obj-$(CONFIG_USB_STORAGE_MTP)  += dev-mtp.o
> 


