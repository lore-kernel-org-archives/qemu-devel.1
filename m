Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE1CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5610A207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKCvZtJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5610A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbNPg-0006xg-DS
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbNOX-0005Qj-9N
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:00:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbNOV-0001DL-2j
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589976018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRfMlzIt1B9bM6JJdes6fGVMJ5S+76QHEVBTr2skXB4=;
 b=LKCvZtJwgGVvSlWxtNkDYzid9mfe8B8T0fXyxfFo1JvfT0o9yY9Us/T6hTEed66rwc7/nE
 +ugcsO1l0s8o4hbrHjCSdLzR+B5R36h6Oj0p3IBW0nn/k/o6kuOrLOnAlPg7alZmPOhpuz
 lMWROqY/YX5hh/KsrcEDa/7GQbhG0Dg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-4E4tTdtlOCezOEL-Zqi2lw-1; Wed, 20 May 2020 08:00:16 -0400
X-MC-Unique: 4E4tTdtlOCezOEL-Zqi2lw-1
Received: by mail-wr1-f69.google.com with SMTP id i9so1327093wrx.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 05:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LRfMlzIt1B9bM6JJdes6fGVMJ5S+76QHEVBTr2skXB4=;
 b=p8boCU7frrdoPSPFaBCOa/tmfml18HmmIkNaFbWZReciUDCDg9gCEoHJYNoFlujZHw
 kcXcwixvIeVEtib0pLVMKLIySIakJBXu735+TecSDF0apenOpaBm9hVOHGTOBl3tOVgj
 sPueAb9EnYVW9kxzoLdq6ISc7BTIhZIMtwKR4YI8oiznkhBtMoKRm2omr6n17b2ySiqm
 OcolzhCsvP2YdySJx7OYXV1EyERZ9Ob6+OltbZPH0cPy6N63v8S54xQD99NuutpK1RP6
 ZMzpbuhFr2SXjJ30r7+28uWyKIVv+V8Mohbe0DqQYJb4F89RcIIQP2AkvgS3qb1qEdlG
 M4WA==
X-Gm-Message-State: AOAM533qG4xrIvj1yrAQ03a04soiytTIOAiU5NLYJOSVWZsrjoObxcla
 qWRJxvbFglwpqAvPZJyQ24TAOhWFjdNtRNkhYuB2ibS6U1txX8IdvC8BaWrLrUoZSp7igZX02vV
 7XeSbHLM+VT2j35k=
X-Received: by 2002:a1c:9893:: with SMTP id a141mr2012440wme.176.1589976015344; 
 Wed, 20 May 2020 05:00:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ1lDioro9JvcmfRmPXilAmhv8tLbN3rzvVOszQ0TxPpI57MyfPt61Dxp6ks8QceRvXmfA4A==
X-Received: by 2002:a1c:9893:: with SMTP id a141mr2012411wme.176.1589976015060; 
 Wed, 20 May 2020 05:00:15 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 37sm2620980wrk.61.2020.05.20.05.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 05:00:14 -0700 (PDT)
Subject: Re: [PATCH 02/55] qdev: Drop redundant bus realization
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7f130f89-ae0d-ecb0-11f5-e9847548950b@redhat.com>
Date: Wed, 20 May 2020 14:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519145551.22836-3-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Marcel

On 5/19/20 4:54 PM, Markus Armbruster wrote:
> Realizing a device automatically realizes its buses, in
> device_set_realized().  Realizing them in realize methods is
> redundant, unless the methods themselves require them to be realized
> early.  None do.  Drop the redundant bus realiziations.

Typo realiziations-> realizations.

So you are reverting commits 685f9a3428f & b1af7959a66...
I don't understand them, Marcel can you review this patch?

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/pci-host/prep.c      | 1 -
>   hw/pci-host/versatile.c | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 1a02e9a670..c821ef889d 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -268,7 +268,6 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>       memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
>   
>       /* TODO Remove once realize propagates to child devices. */
> -    object_property_set_bool(OBJECT(&s->pci_bus), true, "realized", errp);
>       object_property_set_bool(OBJECT(&s->pci_dev), true, "realized", errp);
>   }
>   
> diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
> index cfb9a78ea6..28817dbeec 100644
> --- a/hw/pci-host/versatile.c
> +++ b/hw/pci-host/versatile.c
> @@ -458,7 +458,6 @@ static void pci_vpb_realize(DeviceState *dev, Error **errp)
>       }
>   
>       /* TODO Remove once realize propagates to child devices. */
> -    object_property_set_bool(OBJECT(&s->pci_bus), true, "realized", errp);
>       object_property_set_bool(OBJECT(&s->pci_dev), true, "realized", errp);
>   }
>   
> 


