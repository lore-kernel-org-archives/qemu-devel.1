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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39DAC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A98C20758
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsBUTcTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A98C20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoil-0006Pr-Cs
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDohw-0005SR-QG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDohu-0002Rh-4P
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599137472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fUgUhHMY5q3aLxdxOpdJp2bGWCfJ/xVrkJETROEMYwU=;
 b=RsBUTcTiTwX2sQ3w4P9i33PI4yquCwh+RUqY0P2aMJlVYvgak+kVPe75epcjtq2aL9jxHs
 fNTnKDyzra6rBZ7TO5WUiv5RrWvHpBBzuRAJWY9ofiZ5ZGeEavlLNYjtgFWULNtYFh5bso
 kcBUaF892SfhABCdAaVhKVtkY/M7Ez8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Klhs18ncPMKwTcLihT6ZOQ-1; Thu, 03 Sep 2020 08:51:10 -0400
X-MC-Unique: Klhs18ncPMKwTcLihT6ZOQ-1
Received: by mail-wm1-f71.google.com with SMTP id x6so939167wmb.6
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fUgUhHMY5q3aLxdxOpdJp2bGWCfJ/xVrkJETROEMYwU=;
 b=bbDuZhr/DiuWC/DzsCeBNiaxtlg/zNtOqW4nT5L45TTIgm2+pIdr3zzw3EzBs5HjS0
 X6n/sQhCxWJ/D4IKdEUCZ+zxWJJYpKVxp0pVg9WU40AKUbqkp7CKWz6wujlTi7v2UPIi
 wgx9rv87Fme/GAbwM/YSVn8zOluM9lCo3SAStyoZWzBOfrDxnukCqV3vcqR99qpKXRfZ
 ZIN//ykuJAttf5wJRnK1LXga3YW5xTHSkjPw3QWg6CS0cO74LXEAKvZ0mNSOKEG12JBd
 dviZTZFJa5J8LOadDSqxUKeEGRoppucuvSROYoax2fxnuQWvQLAz5wLQHIWhUWFBaI2F
 OJaQ==
X-Gm-Message-State: AOAM531uG93iBd/k12LznymQCj/5gf61zjoko916/ap8oa8AWGjHsbl3
 KLbnEf1txs5EfTtNBCO+AoLdh0/q3F+L0Fd/T44zeZAagv6mEq6tIdByMwdZ2wxL4ep9FXyPI/8
 UdK3x8VXDrw457oQ=
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr2409205wmh.56.1599137469748; 
 Thu, 03 Sep 2020 05:51:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdTiCQ8j775JLSg9KoAv6Kmgp1suCLizutwInbr0HRFs5RwvMQVch746gTnlnJdWk/T2XbPQ==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr2409192wmh.56.1599137469584; 
 Thu, 03 Sep 2020 05:51:09 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id j135sm4556115wmj.20.2020.09.03.05.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:51:09 -0700 (PDT)
Subject: Re: [PATCH 10/63] vmgenid: Rename VMGENID_DEVICE to TYPE_VMGENID
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-11-ehabkost@redhat.com>
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
Message-ID: <d17b6e3b-4cb6-0212-2198-08a1c6fc363e@redhat.com>
Date: Thu, 3 Sep 2020 14:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-11-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, berrange@redhat.com,
 Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>
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
> Cc: Ben Warren <ben@skyportsystems.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/acpi/vmgenid.h | 6 +++---
>  hw/acpi/vmgenid.c         | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
> index 86cd1da605..aff574df5f 100644
> --- a/include/hw/acpi/vmgenid.h
> +++ b/include/hw/acpi/vmgenid.h
> @@ -6,7 +6,7 @@
>  #include "qemu/uuid.h"
>  #include "qom/object.h"
>  
> -#define VMGENID_DEVICE           "vmgenid"
> +#define TYPE_VMGENID           "vmgenid"
>  #define VMGENID_GUID             "guid"
>  #define VMGENID_GUID_FW_CFG_FILE      "etc/vmgenid_guid"
>  #define VMGENID_ADDR_FW_CFG_FILE      "etc/vmgenid_addr"
> @@ -18,7 +18,7 @@
>  
>  typedef struct VmGenIdState VmGenIdState;
>  DECLARE_INSTANCE_CHECKER(VmGenIdState, VMGENID,
> -                         VMGENID_DEVICE)
> +                         TYPE_VMGENID)
>  
>  struct VmGenIdState {
>      DeviceClass parent_obj;
> @@ -29,7 +29,7 @@ struct VmGenIdState {
>  /* returns NULL unless there is exactly one device */
>  static inline Object *find_vmgenid_dev(void)
>  {
> -    return object_resolve_path_type("", VMGENID_DEVICE, NULL);
> +    return object_resolve_path_type("", TYPE_VMGENID, NULL);
>  }
>  
>  void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index 2df7623d74..53db6af75d 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -198,7 +198,7 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
>  
>      if (!bios_linker_loader_can_write_pointer()) {
>          error_setg(errp, "%s requires DMA write support in fw_cfg, "
> -                   "which this machine type does not provide", VMGENID_DEVICE);
> +                   "which this machine type does not provide", TYPE_VMGENID);
>          return;
>      }
>  
> @@ -206,7 +206,7 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
>       * device. Check if there are several.
>       */
>      if (!find_vmgenid_dev()) {
> -        error_setg(errp, "at most one %s device is permitted", VMGENID_DEVICE);
> +        error_setg(errp, "at most one %s device is permitted", TYPE_VMGENID);
>          return;
>      }
>  
> @@ -232,7 +232,7 @@ static void vmgenid_device_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo vmgenid_device_info = {
> -    .name          = VMGENID_DEVICE,
> +    .name          = TYPE_VMGENID,
>      .parent        = TYPE_DEVICE,
>      .instance_size = sizeof(VmGenIdState),
>      .class_init    = vmgenid_device_class_init,
> 


