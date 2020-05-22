Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E1FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916A920738
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGLXRT3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916A920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBH5-0003ar-OZ
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBGJ-0002sJ-1V
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:15:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59778
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBGH-0000AK-7s
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590167707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mQ2MroD+A6wv44khLQS5zv6j2tMBIPPqYdNr7BXBQYE=;
 b=LGLXRT3Tyy5ODbhJFaV0nu/Xps+80m0hB1GvKjbh4z4D5Xy7pVN07SDMQaQcHBGSwMLkWk
 sxMsNdCuE8g8CjI6GF25sGAsQxzXqEh2kZpOKCv3sC89wK1LjBjvEtXY94SsLCP6SJiNuU
 HDab495yHT3niuZ0mLx71fyIpvGtL/o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-s1_Qms54NlyJmuhZNVpo7w-1; Fri, 22 May 2020 13:15:02 -0400
X-MC-Unique: s1_Qms54NlyJmuhZNVpo7w-1
Received: by mail-wm1-f70.google.com with SMTP id x11so2900322wmc.9
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mQ2MroD+A6wv44khLQS5zv6j2tMBIPPqYdNr7BXBQYE=;
 b=sTIAO+8yk8xCroMZ/djxyjQdDULG3nQU/9FIWSYGAjgoCJsASLNeFCqY+vNqX/hLMN
 cu6JSvjUU1p1Ou6G+GjJZuuskwdvUDFZ9mxZXjw4K2OEwaM0PH8j9bK9xxrZcd6CwphF
 Ce4HjS54T51irUjJPy7kgAo7SWxCPQtcLVO0fZBf/uAtsoTME/HkPWaYl3ere06lLKte
 21/zFCv3uobszOZO0m+JDcZ117RoYMAow/i3tAj/RSdrwkcExCrwKnkiG2VNvEFcwCM8
 MxYfb7Yv7vVVasspOeWLKOCeDivSsNnljGI2twxoTPRQKilbtv2uuD+evfwefQhaUODQ
 AbqQ==
X-Gm-Message-State: AOAM532H+CT5WbRRavBncZZ+Qw9qqAXasGGhBaB1R1+9nW1rJ0ESR3aX
 NGA396Z61zukn6gSmLKeYH2ruets07Lb+WpkSNS8r2tOAXWWh0xTHLNoIFTTvBI9wzXHT6r4Y9q
 E/lyw8Z+pdZqNtN8=
X-Received: by 2002:a7b:c193:: with SMTP id y19mr13911254wmi.158.1590167701788; 
 Fri, 22 May 2020 10:15:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNTQQ4Bajscum7c/q8yKvCnNu0QFgK1zJ0PcskRA+1/76tpVuYvQIWZkmac3wExLHjXg7wwg==
X-Received: by 2002:a7b:c193:: with SMTP id y19mr13911238wmi.158.1590167701560; 
 Fri, 22 May 2020 10:15:01 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id p3sm4919487wru.95.2020.05.22.10.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2020 10:15:00 -0700 (PDT)
Subject: Re: [PULL 01/11] ui/win32-kbd-hook: handle AltGr in a hook procedure
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200520084316.22057-1-kraxel@redhat.com>
 <20200520084316.22057-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <b2a1cca7-e599-a3fe-0fab-d615167bb61d@redhat.com>
Date: Fri, 22 May 2020 19:15:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520084316.22057-2-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 10:36:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 10:43 AM, Gerd Hoffmann wrote:
> From: Volker Rümelin <vr_qemu@t-online.de>
> 
> Import win32 keyboard hooking code from project spice-gtk. This
> patch removes the extra left control key up/down input events
> inserted by Windows for the right alt key up/down input events
> with international keyboard layouts. Additionally there's some
> code to grab the keyboard.
> 
> The next patches will use this code.
> 
> Only Windows needs this.
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> Message-id: 20200516072014.7766-1-vr_qemu@t-online.de

This patch content doesn't match exactly the content of the message-id.

There are some build-sys changes.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/win32-kbd-hook.h |  14 +++++
>  stubs/win32-kbd-hook.c      |  18 +++++++
>  ui/win32-kbd-hook.c         | 102 ++++++++++++++++++++++++++++++++++++
>  stubs/Makefile.objs         |   1 +
>  ui/Makefile.objs            |   3 ++
>  5 files changed, 138 insertions(+)
>  create mode 100644 include/ui/win32-kbd-hook.h
>  create mode 100644 stubs/win32-kbd-hook.c
>  create mode 100644 ui/win32-kbd-hook.c
[...]
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 45be5dc0ed78..6a9e3135e8f9 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -32,6 +32,7 @@ stub-obj-y += trace-control.o
>  stub-obj-y += uuid.o
>  stub-obj-y += vm-stop.o
>  stub-obj-y += vmstate.o
> +stub-obj-y += win32-kbd-hook.o
>  stub-obj-y += fd-register.o
>  stub-obj-y += qmp_memory_device.o
>  stub-obj-y += target-monitor-defs.o
> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> index e6da6ff047fd..504b19647977 100644
> --- a/ui/Makefile.objs
> +++ b/ui/Makefile.objs
> @@ -15,6 +15,9 @@ common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
>  common-obj-$(CONFIG_COCOA) += cocoa.o
>  common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
>  common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
> +ifneq (,$(findstring m,$(CONFIG_SDL)$(CONFIG_GTK)))

If we limit this object compilation, shouldn't we also limit the stub?

> +common-obj-$(CONFIG_WIN32) += win32-kbd-hook.o
> +endif
>  
>  # ui-sdl module
>  common-obj-$(CONFIG_SDL) += sdl.mo
> 


