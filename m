Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E142AC388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 14:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2207F20719
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 14:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEJBq1qG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2207F20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbP3j-0002X2-Ud
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 09:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbP33-00026a-9V
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 09:18:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbP30-0000FZ-W8
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 09:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604758709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pv11pfFCtMQrIcRZpkrLLgsagzJ+1jr2C5uaLU8Zdfo=;
 b=aEJBq1qGihSXW3M/jOo+ZoU3NNLICOpT+62T+ltAgyqDZi+/FJ7ZE2qilYyZ7v/zlS6hG4
 TOL/bUpgpUf5AzJTPcafbmHE5CAZ/3PaMXpXjj7Ml0zff8slkGstXS60NkN4LRyKgI9flk
 QW7gfn/35ODAnVCTuHtn/RjjpLz6p2I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-uaSuVUktNKeMtLC0z6SRNw-1; Sat, 07 Nov 2020 09:18:28 -0500
X-MC-Unique: uaSuVUktNKeMtLC0z6SRNw-1
Received: by mail-wr1-f69.google.com with SMTP id f11so1765403wro.15
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 06:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pv11pfFCtMQrIcRZpkrLLgsagzJ+1jr2C5uaLU8Zdfo=;
 b=T8rgRlLjlPu9SF1rkrgojleCZI3Qj5Q2zjJwgrdtIR6okfKQCWePWgq1KPNska3rV5
 9cjJ3MPxe+wjScIMKfHieNO4AFvcxveLK15gkyV+67VKz0mRK8PF68WQjUfhEpZXysGO
 9HPBV+fo6V7Tilpd3Wqgurcq2qebevq/H1Hs3hpRny4Y32RX/SML8Dysq6hSaqzEWR4E
 8i9VoQc7WkVImnXrLtFLFRJry1efOeevpYdv4s3k2kFOABy75Oi3+lVe5oU224CLH/0x
 nLYPu9iISOhmRSd1Ym4FYxP4BMq8N093c7LPkYJ2usxh5C13YEMwcvQ1VCW1O1X0HpFm
 9+VA==
X-Gm-Message-State: AOAM531rixk3xIH4Wn1KFfNZ1LXISA9ITxfwUpfLVFc/J+kuOl22Ozvc
 tpzm/1IgQ/kPLM8WU4xeGbxWHE5CzW7DEY1eypGtyuzkG2QObTTl+wjOELage0HxQb55a6fMjUv
 tfBp/Zw9u181UGEE=
X-Received: by 2002:adf:ee92:: with SMTP id b18mr3947503wro.104.1604758706969; 
 Sat, 07 Nov 2020 06:18:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgS4WI+h3XkKBsHHbPfju8tulElMshJhCnGgbcegBU01nvgxqbqpF3DLk3Wt7vjw3xO/Znzw==
X-Received: by 2002:adf:ee92:: with SMTP id b18mr3947477wro.104.1604758706716; 
 Sat, 07 Nov 2020 06:18:26 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m14sm6566491wro.43.2020.11.07.06.18.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2020 06:18:25 -0800 (PST)
Subject: Re: [PULL v4 44/48] piix4: don't reserve hw resources when hotplug is
 off globally
To: Ani Sinha <ani@anisinha.ca>
References: <20200929071948.281157-1-mst@redhat.com>
 <20200929071948.281157-45-mst@redhat.com>
 <5b79133f-374e-8a8f-6aeb-bd5313dc8eb1@redhat.com>
 <CAARzgwx+n0k9kC15Twy0sj07jcDcPWX6-x2pGDXQ1i8fDU-Leg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <56a067f8-945f-cab4-d80e-6706ae446705@redhat.com>
Date: Sat, 7 Nov 2020 15:18:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAARzgwx+n0k9kC15Twy0sj07jcDcPWX6-x2pGDXQ1i8fDU-Leg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:12:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/20 1:22 PM, Ani Sinha wrote:
> On Sat, Nov 7, 2020 at 3:40 PM Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Hi,
>>
>> On 9/29/20 9:22 AM, Michael S. Tsirkin wrote:
>>> From: Ani Sinha <ani@anisinha.ca>
>>>
>>> When acpi hotplug is turned off for both root pci bus as well as for pci
>>> bridges, we should not generate the related ACPI code for DSDT table or
>>> initialize related hw ports or reserve hw resources. This change makes
>>> sure all those operations are turned off in the case ACPI pci hotplug is
>>> off globally.
>>>
>>> In this change, we also make sure ACPI code for the PCNT method are only
>>> added when bsel is enabled for the corresponding pci bus or bridge hotplug
>>> is turned on.
>>
>> I'm trying to understand the following build failure using gcc 9.3.0
>> on Ubuntu:
>>
>> [2567/3684] Compiling C object
>> libqemu-x86_64-softmmu.fa.p/hw_i386_acpi-build.c.o
>> FAILED: libqemu-x86_64-softmmu.fa.p/hw_i386_acpi-build.c.o
>> ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
>> ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialized
>> in this function [-Werror=maybe-uninitialized]
>>   496 |         aml_append(parent_scope, method);
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
...
>>>  static void acpi_get_misc_info(AcpiMiscInfo *info)
>>> @@ -456,10 +460,12 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>>>      }
>>>
>>>      /* Append PCNT method to notify about events on local and child buses.
>>> -     * Add unconditionally for root since DSDT expects it.
>>> +     * Add this method for root bus only when hotplug is enabled since DSDT
>>> +     * expects it.
>>>       */
>>> -    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
>>> -
>>> +    if (bsel || pcihp_bridge_en) {
>>> +        method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
>>> +    }
>>
>> build_append_pci_bus_devices() is not easy to follow and could certainly
>> benefit from a refactor.
> 
> Hmm, ok will do that in my spare time.
> 
>>
>> So here, before 'method' was always reinitialized. Now not always,
>> so it can be any value set in the big for() loop before...
> 
> In line 467 above, method is initialized when bsel is available or
> pcihp is enabled. In line 496, it is appended to the parent scope only
> under those conditions as well. Basically, in hunks
> 
> +    if (bsel || pcihp_bridge_en) {
> +        method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> +    }
> 
> and
> +
> +    if (bsel || pcihp_bridge_en) {
> +        aml_append(parent_scope, method);
> +    }
> 
> the conditions are exactly the same.

The problem is in the (!bsel && !pcihp_bridge_en) case,
what 'method' is used there?


