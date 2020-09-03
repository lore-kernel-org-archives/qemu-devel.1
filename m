Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8764C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FAE82072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OStODvbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAE82072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoj6-0006zU-KC
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDohI-0004k7-Fz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:50:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDohG-0002OJ-N4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599137433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VDjmmiZ46X8xdN04wFJ9qwDoL83bdCg7z/QsL3Nqvy4=;
 b=OStODvbYDgGFSp+Wq1bDM9KuskffO/nbb598v1Kjnkb0vwIk0Dhb1Z1cuceAy9x7ijplWx
 Ofb/Lg7nZ6+z18N2a8ZAccCmQzAoQWRhC9z72DsbqRaDuWUAl7S1Ys7qUlMp4J8z7o8X+H
 nXbhtnbXxK3JfbZJ3GEk4K2QuvwwWa8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-aj3J9PefNoievfJPV6kcDA-1; Thu, 03 Sep 2020 08:50:32 -0400
X-MC-Unique: aj3J9PefNoievfJPV6kcDA-1
Received: by mail-wm1-f72.google.com with SMTP id a7so949021wmc.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=VDjmmiZ46X8xdN04wFJ9qwDoL83bdCg7z/QsL3Nqvy4=;
 b=ddSISNstUYDDL7V2TfVWvorAYrXtknXQQP7FKQgvn7F8AHS+sJy1yvcNlRMCxnmAIz
 oSGN8u/psV2cE/FXbD4VB6lxCa/+mhrKt03g4Cmt/NQ+LkpKXbC3/iiHKSve4NHX/TLm
 cXAqdlKFOy8vvS1DaZP2GhkPKR6Z//OAwhWvrc6QJYDkXzRXFwu3wUDmZkGQ5oCwz9B5
 eNyjkJo8M8S0RFUQqBcGscpp6fp6yWvMPAgBDxdD+T3IC/Df9mz4nb3bb99f5sgy33YF
 cjxlFi0+lpzmMoItwXvysurm310h6J2ysE+KIJJyXr+nQbg9fjaAU/+QunaC9g4esTvv
 brhg==
X-Gm-Message-State: AOAM5308g61yZv40awnDGL0nkBXzX9z1Myy6ouVR0pcExqmdy1i368rP
 abCQvXQtBHkL/r/v7BzMBBxQfHISGIt6FVEFHRyEl077V2YtAaAIguPyeEhpEvvoFjBhvrmkIAo
 xGNii3s9yYIFQWNg=
X-Received: by 2002:a1c:6385:: with SMTP id x127mr2453533wmb.95.1599137430981; 
 Thu, 03 Sep 2020 05:50:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxRRAlPteoZOY4H88uDWauPYSZzYne+connTzK+INeV9WUJjMMEIjTafllAKoUoT0x43HteQ==
X-Received: by 2002:a1c:6385:: with SMTP id x127mr2453514wmb.95.1599137430758; 
 Thu, 03 Sep 2020 05:50:30 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 188sm16683924wmz.2.2020.09.03.05.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:50:30 -0700 (PDT)
Subject: Re: [PATCH 06/63] dev-smartcard-reader: Rename CCID_DEV_NAME to
 TYPE_USB_CCID_DEV
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-7-ehabkost@redhat.com>
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
Message-ID: <004afb90-1ff1-469f-db3e-de0f4e1c64ed@redhat.com>
Date: Thu, 3 Sep 2020 14:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-7-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> This will make the type name constant consistent with the name of
> the type checking macro.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/usb/dev-smartcard-reader.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index 432508c478..59b2248f34 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -60,10 +60,10 @@ do { \
>  #define D_MORE_INFO 3
>  #define D_VERBOSE 4
>  
> -#define CCID_DEV_NAME "usb-ccid"
> +#define TYPE_USB_CCID_DEV "usb-ccid"
>  typedef struct USBCCIDState USBCCIDState;
>  DECLARE_INSTANCE_CHECKER(USBCCIDState, USB_CCID_DEV,
> -                         CCID_DEV_NAME)
> +                         TYPE_USB_CCID_DEV)
>  /*
>   * The two options for variable sized buffers:
>   * make them constant size, for large enough constant,
> @@ -1462,7 +1462,7 @@ static void ccid_class_initfn(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo ccid_info = {
> -    .name          = CCID_DEV_NAME,
> +    .name          = TYPE_USB_CCID_DEV,
>      .parent        = TYPE_USB_DEVICE,
>      .instance_size = sizeof(USBCCIDState),
>      .class_init    = ccid_class_initfn,
> @@ -1495,7 +1495,7 @@ static void ccid_register_types(void)
>      type_register_static(&ccid_bus_info);
>      type_register_static(&ccid_card_type_info);
>      type_register_static(&ccid_info);
> -    usb_legacy_register(CCID_DEV_NAME, "ccid", NULL);
> +    usb_legacy_register(TYPE_USB_CCID_DEV, "ccid", NULL);
>  }
>  
>  type_init(ccid_register_types)
> 


