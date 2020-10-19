Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF66EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FCCE2225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJf91SQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCCE2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kURBf-0004vy-Sj
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUR9k-0003cH-6B
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUR9h-00062S-10
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603098514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IcrWkVtq6M8tcSBX9LdqNv5TcNxSLD/rGERk43hwxLE=;
 b=HJf91SQA4o0S06171pCTT6tpH2V5/CaWoW8igxRCgETcC9/bkqBLa8h/k2ckKddnmjWSRh
 /+/vgEnpOnMbcimbgZNAyCJe8Sq1hLN5AKjcZx0RIX4J8ZP0llV/Pfd1BvMS7ZplLZ/cv2
 lRSoAcWIMmkHi6cl4l4l1FGE3u2G5ko=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-cQPbaa2QNtSG-H-RrUw4Dw-1; Mon, 19 Oct 2020 05:08:30 -0400
X-MC-Unique: cQPbaa2QNtSG-H-RrUw4Dw-1
Received: by mail-wr1-f71.google.com with SMTP id t3so7178383wrq.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 02:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IcrWkVtq6M8tcSBX9LdqNv5TcNxSLD/rGERk43hwxLE=;
 b=Salyqs1ERsJZ91W7cONZi4mfxRNw6BAudRrLe0zTIJTz4NoEi4qn3LFtItprl+I7C8
 fu5/AAyx4YWhqwL7/GUd0BJmPCwachTugFmpXjfS+trW6mf24/OeCO8IzpYoRCwf2gKz
 k5Z46/LsIGV5quiMmLAiBrIUeBJprBycflKBFOKcZA/MSd1PkZHZl0arr3EFKaP0Zc/F
 urI1Gn8GFfqyHXkhitGcR6X8gdNE56aZPft0u0dHjqsaXWnhaw6GKRMYxfTHb8zT0hJr
 CUl1wgaHXN8RNqhXcdFAkQ2Ew6GYqRxUfCpBFxcADpfLJaAcKhvAXvSrryhsphoEQT7c
 Hxsw==
X-Gm-Message-State: AOAM5321tneIiCAeHtK7HcvyIWAdF3mcHmK9aDgJjsFqMaVCgDixoxES
 BoZ2hh58j1xY4HfDOY/O9rNoHvBmLxKS9xDe7GY5fr6/rCG0LkztNFvWpBRwGPQK5CuNGZv66ho
 s5Uf0VORuApFkig4=
X-Received: by 2002:adf:e447:: with SMTP id t7mr18651564wrm.384.1603098509587; 
 Mon, 19 Oct 2020 02:08:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMnjZCikVQGo5Vt5Rj6pHq3tPr90DvLj6WX0w1qVI6UvPS8w480y8IU1f9KCuZO5GsNHk7yw==
X-Received: by 2002:adf:e447:: with SMTP id t7mr18651545wrm.384.1603098509377; 
 Mon, 19 Oct 2020 02:08:29 -0700 (PDT)
Received: from [192.168.1.36] (36.red-83-57-175.dynamicip.rima-tde.net.
 [83.57.175.36])
 by smtp.gmail.com with ESMTPSA id h16sm17332443wre.87.2020.10.19.02.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 02:08:28 -0700 (PDT)
Subject: Re: [PATCH 3/5] spapr: Use appropriate getter for PC_DIMM_SLOT_PROP
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309730758.2739814.15821922745424652642.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d30860c5-5f96-f60e-2f8f-45e86feb55c7@redhat.com>
Date: Mon, 19 Oct 2020 11:08:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160309730758.2739814.15821922745424652642.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 10:48 AM, Greg Kurz wrote:
> The PC_DIMM_SLOT_PROP property is defined as:
> 
>      DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
>                        PC_DIMM_UNASSIGNED_SLOT),

Worth adding:

       #define PC_DIMM_UNASSIGNED_SLOT -1

for better understanding why it is signed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Use object_property_get_int() instead of object_property_get_uint().
> Since spapr_memory_plug() only gets called if pc_dimm_pre_plug()
> succeeded, we expect to have a valid >= 0 slot number, either because
> the user passed a valid slot number or because pc_dimm_get_free_slot()
> picked one up for us.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr.c |    9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 115fc52e3b06..1b173861152f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3433,7 +3433,8 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       Error *local_err = NULL;
>       SpaprMachineState *ms = SPAPR_MACHINE(hotplug_dev);
>       PCDIMMDevice *dimm = PC_DIMM(dev);
> -    uint64_t size, addr, slot;
> +    uint64_t size, addr;
> +    int64_t slot;
>       bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>   
>       size = memory_device_get_region_size(MEMORY_DEVICE(dev), &error_abort);
> @@ -3450,11 +3451,13 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                          spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
>                          &local_err);
>       } else {
> -        slot = object_property_get_uint(OBJECT(dimm),
> -                                        PC_DIMM_SLOT_PROP, &local_err);
> +        slot = object_property_get_int(OBJECT(dimm),
> +                                       PC_DIMM_SLOT_PROP, &local_err);
>           if (local_err) {
>               goto out_unplug;
>           }
> +        /* We should have valid slot number at this point */
> +        g_assert(slot >= 0);
>           spapr_add_nvdimm(dev, slot, &local_err);
>       }
>   
> 
> 
> 


