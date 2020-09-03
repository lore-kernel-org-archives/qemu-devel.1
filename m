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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A5CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8E52072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWW9SKqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8E52072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDonf-00036F-EC
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDomx-0002XZ-2O
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:56:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29379
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDomv-0003EA-ES
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599137784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KveyHYVdF04QBjPXFmnHpypNu+GZ/YeWn5rzq5Ic4xw=;
 b=OWW9SKqw+3kMMSIH+frN7+FCTf2S00Ve1nYw5HIdS4S43qVY/YdB7o3zVTB9hLzMD36bsV
 LtQyJELfc2PtGEAXsaP2ekgBwpYzOh44c1XSH1gEm/OO+9dO8BW5c/cRHdHjd6opYfAAs5
 PoEG0pFEHb3A+7gbK/NZqbVHzBNEHgY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536--vq-UIbiMcipEiV6hjd6vA-1; Thu, 03 Sep 2020 08:56:23 -0400
X-MC-Unique: -vq-UIbiMcipEiV6hjd6vA-1
Received: by mail-wm1-f69.google.com with SMTP id u5so690641wme.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=KveyHYVdF04QBjPXFmnHpypNu+GZ/YeWn5rzq5Ic4xw=;
 b=e5wcVJLojSkVGxb86GjvvgXtIU5QfwM/ghMmCMGUYiMSC0pnbJEmeqZTs3jGTRjmX4
 9rvHiixOR9QKa7MhqYB9K/IOS2u5ZO3xesmDdZwwoDnBvfsMURk0xRmOVv5asLpAqKm1
 1lAYngJPdoim/EKgN2tvGSKofdMjiN0+7g0wwIbXxZzDvoi6liQcnP3qeAGF+uaCD94I
 yAOnQd7q0ZDDCwam6muyGbeqZTAT3lS+oEYepUd38d1qHs0hhChwlVB2nTkCtmxQgqbK
 ssbbx3HE6F/yqVhzTyQuG+ydnHHVE/QSB08JKOTN2/04y3bZ0P0NY2yx9kP3cXBZMdse
 l4TQ==
X-Gm-Message-State: AOAM533Qk2zkaPdTzrtESFrCOPwtCWAxtYPy6ZtV9c+wxa5N9EZ2LfXm
 LieTmTgo2d+nq3sSxxtWrxrck3+qd5vw1tdSSm9XZoX+cZs27uRpKz6pMveMYXpTMUEPcy7BCzo
 7txfGxMc6Jg2YBKk=
X-Received: by 2002:a5d:518b:: with SMTP id k11mr2251079wrv.369.1599137781880; 
 Thu, 03 Sep 2020 05:56:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxATAWTCltXNmcIgnptArUMWsIQm1GJJyRKrzDH7WdYsWqetFqBhizTZXholpXBIWU8vZBsZg==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr2251064wrv.369.1599137781682; 
 Thu, 03 Sep 2020 05:56:21 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o4sm4203307wrv.86.2020.09.03.05.56.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:56:21 -0700 (PDT)
Subject: Re: [PATCH 28/63] tusb6010: Rename TYPE_TUSB6010 to TYPE_TUSB
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-29-ehabkost@redhat.com>
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
Message-ID: <fa919593-5c84-a42a-e443-2a957b0426a0@redhat.com>
Date: Thu, 3 Sep 2020 14:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-29-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
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
> ---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/usb/tusb6010.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
> index 2bee3ae59f..9b35c1d4b8 100644
> --- a/hw/usb/tusb6010.c
> +++ b/hw/usb/tusb6010.c
> @@ -30,10 +30,10 @@
>  #include "hw/sysbus.h"
>  #include "qom/object.h"
>  
> -#define TYPE_TUSB6010 "tusb6010"
> +#define TYPE_TUSB "tusb6010"

We are loosing information helpful to reviewers.
Can we rename the type macro TUSB6010() instead?

>  typedef struct TUSBState TUSBState;
>  DECLARE_INSTANCE_CHECKER(TUSBState, TUSB,
> -                         TYPE_TUSB6010)
> +                         TYPE_TUSB)
>  
>  struct TUSBState {
>      SysBusDevice parent_obj;
> @@ -838,7 +838,7 @@ static void tusb6010_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo tusb6010_info = {
> -    .name          = TYPE_TUSB6010,
> +    .name          = TYPE_TUSB,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(TUSBState),
>      .class_init    = tusb6010_class_init,
> 


