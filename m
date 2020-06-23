Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFF0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1989E20774
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOg5bwf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1989E20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkrn-0005Xg-DU
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnkrD-0004ui-9H
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:29:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25532
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnkr9-0001gD-Lt
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592926142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zK5dBlT0LtmrrNUNzELUSHvkFOntBOdU/GwZhmtmQGk=;
 b=GOg5bwf+n3HXtODnCHNLoCkgcawx5YEApG72kiJIpTHRd55T4l9uX3dkkF+0w1dbhA4p2t
 C9Pe1D4tKSnS3i+fh02Ztw68f+QAw2f01XMB0A5lCVEkusoMZjD2D2t4hwWCRFnXn6rMEm
 /S/cev38BOWLw+Wpg1peoJ4zLjAdmnE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-kWX09vASP8WNjOZJB4UUJA-1; Tue, 23 Jun 2020 11:28:58 -0400
X-MC-Unique: kWX09vASP8WNjOZJB4UUJA-1
Received: by mail-wr1-f69.google.com with SMTP id i12so7848388wrx.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zK5dBlT0LtmrrNUNzELUSHvkFOntBOdU/GwZhmtmQGk=;
 b=McIWWeM497nTmR/AcQlWULWAqbNkO3GS9CbpfUsZFlqAmm7p/1h1hYHs2fOYP/tZ4/
 xqU1BM0koo+g1oaIVGjiXNSyJSYILL6nlGy8gJT2lqZyEdBGHwMPe6mYz8DpOXLoh7A5
 5NAizsLLlBhDFiw8pXFIhYGH9wmFEOn1x+sTce6rp5HDuLuC3m7p4JbY5RWQzMub8XvW
 RqjOvialJitCCJTRSRPSXyM8zfr/DSff66PKsLIaqvokMypdsfQJn7z5WwnFpIGfagkC
 dj5l24Kt9mvjFXPGyCirmZ1JTk4PhTyKg3KcjIJh2C7t50mUbl2IyPAsU5XNGDV+dHhB
 1wGA==
X-Gm-Message-State: AOAM531hyUZc+06m9Qv+SXhdHTdgOx8+5G7lbmQLk89Vp/oDY+OJ8TW1
 gkYwH1IuanoGlBlPoCscAFsLOxg5euxVfeKYqm0SeMupFw7zw6pvY1NeVWuNTrcW93azRBJ6cUZ
 0gbBneN+5AJry1Kw=
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr18310847wmm.156.1592926137101; 
 Tue, 23 Jun 2020 08:28:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIMH/y7tM2Hi0v9621MCnS5YQA/L6XU/KncJ7rlEP5IBvcSzbJVXQPL+YwxqHxsSYeuq/6vw==
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr18310823wmm.156.1592926136820; 
 Tue, 23 Jun 2020 08:28:56 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d24sm3899253wmb.45.2020.06.23.08.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 08:28:56 -0700 (PDT)
Subject: Re: [PATCH v4 3/7] ccid: build smartcard as module
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200622135601.12433-1-kraxel@redhat.com>
 <20200622135601.12433-4-kraxel@redhat.com>
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
Message-ID: <434be3b8-8ed0-d27b-99c7-e682b0dc4c02@redhat.com>
Date: Tue, 23 Jun 2020 17:28:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200622135601.12433-4-kraxel@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: dinechin@redhat.com, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 6/22/20 3:55 PM, Gerd Hoffmann wrote:
> Drops libcacard.so dependency from core qemu.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  Makefile.objs        | 1 +
>  hw/core/qdev.c       | 2 ++
>  hw/Makefile.objs     | 1 +
>  hw/usb/Makefile.objs | 4 +++-
>  4 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index 7ce2588b89a3..ca555ede0710 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -59,6 +59,7 @@ common-obj-y += migration/
>  common-obj-y += audio/
>  common-obj-m += audio/
>  common-obj-y += hw/
> +common-obj-m += hw/
>  
>  common-obj-y += replay/
>  
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 6119e25e0eeb..d6459e4aa8e8 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -172,6 +172,8 @@ static struct {
>      const char *type;
>      const char *mod;
>  } const hwmodules[] = {
> +    { .type = "ccid-card-passthru",    .mod = "usb-smartcard"         },
> +    { .type = "ccid-card-emulated",    .mod = "usb-smartcard"         },

We want to use type definitions here (such TYPE_CCID_PASSTHRU),
as we don't guaranty them stable.

We don't want to include various "hw/x/y.h" in this core file.

Since there is a relation between QOM type and the module,
can we store/use the module name in the TypeInfo declaration?

  static const TypeInfo passthru_card_info = {
      .name          = TYPE_CCID_PASSTHRU,
      .parent        = TYPE_CCID_CARD,
      .instance_size = sizeof(PassthruState),
      .class_init    = passthru_class_initfn,
      .module_name   = "usb-smartcard",        <=====
  };

Actually this modularization is not specific to QDEV
and can be used to all QOM right? I.e:

  static const TypeInfo qcrypto_tls_creds_x509_info = {
      .parent = TYPE_QCRYPTO_TLS_CREDS,
      .name = TYPE_QCRYPTO_TLS_CREDS_X509,
      .module_name = "gnu-tls",
      ...
  }

>  };
>  
>  static bool qdev_module_loaded_all;
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 4cbe5e4e57d6..af8fd9a510ed 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -43,4 +43,5 @@ devices-dirs-y += smbios/
>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> +common-obj-m += usb/
>  obj-y += $(devices-dirs-y)
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index fa5c3fa1b877..3c5b3d4fadd3 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -29,11 +29,13 @@ common-obj-$(CONFIG_USB_NETWORK)      += dev-network.o
>  
>  ifeq ($(CONFIG_USB_SMARTCARD),y)
>  common-obj-y                          += dev-smartcard-reader.o
> -common-obj-$(CONFIG_SMARTCARD)        += smartcard.mo
> +ifeq ($(CONFIG_SMARTCARD),y)
> +common-obj-m                          += smartcard.mo
>  smartcard.mo-objs := ccid-card-passthru.o ccid-card-emulated.o
>  smartcard.mo-cflags := $(SMARTCARD_CFLAGS)
>  smartcard.mo-libs := $(SMARTCARD_LIBS)
>  endif
> +endif
>  
>  ifeq ($(CONFIG_POSIX),y)
>  common-obj-$(CONFIG_USB_STORAGE_MTP)  += dev-mtp.o
> 


