Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC3FC4727E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6752A2068D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="NEYxYmEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6752A2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPqe-0002SP-9M
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kLPpw-0001xm-E4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:54:56 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kLPpu-0008QL-7g
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:54:56 -0400
Received: by mail-pg1-x543.google.com with SMTP id 7so1747244pgm.11
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 04:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:date:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=gLF446tIPaXpo83KkPhZFWtQ8ci6uHCVcLvSFi2YVfA=;
 b=NEYxYmEJaCqXiegKrCrhxlOnX0RgLOy4OQIQkiBZTYeUNrUQb/ukUs21ssZErtYPts
 fKkj/UMHHap4bBor8wmO6aiogVl7NxxgruG5uTfSr9iW+DxdTm/GG7pElYnFC5cGaLIi
 fgqT9vQC9p5F8fgTnIZbD/qONDvVB/xshx64VNrr/enKY9wNCPiEI9EkA+Ge89DQg78Z
 ULOLpSyPal9VyOEsfqVTnRTgCu5kXjAIvswlpfv8l8xsV105KfqcbWTnyYgBTNA2k6es
 Av7vauLSwpLor66GFROLH+KhJukzHMIZZNCvzCVMMdKzcQbOT37o50PAK6iMNRC8Rl4D
 cDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=gLF446tIPaXpo83KkPhZFWtQ8ci6uHCVcLvSFi2YVfA=;
 b=NyRGp6biQV/lfLvHPcDo2P7WNPTQAigo+Qv3YnfKa4JjoVhD52Q+vifHIHhFhrK8FD
 /FMGzpEIuXzR0cOTe4uUWHpPMKqZ7fM28cQhUkYA8+3EsUEqVDAdWa/MCC0AtDo0nLLW
 b402IG7GCHkGCXXhthJqIOx4W2bowvV8fDaOg3VQHyBfgzj1pOgqTrBtVNr8tmHO+l0u
 YW6WiqHGaZWi59q9hSGjFI5XBV/i4YVk5xo7hSuu7sjW1VZXNreByBTQlkiykvOHYTds
 jQb5Xqw6UMppHrFd14Qdkv2+RKPX0EtMt/XYoTDJknssnh0NBz3/NgaPT9A6AcjCMfvV
 sehg==
X-Gm-Message-State: AOAM5331/9lKyeOAZSeQDXUHffcTYAqu7dhNe0mh6MrvhC5diWMD2e91
 Jo/BluvoFt8P5+BG+p57L0htuA==
X-Google-Smtp-Source: ABdhPJx8hQf20DXVBDODq5YXk6GOOGFoi89pKOE3wDwgzuY8LMaiCOwfz/V9qX0hBmzxqIPOUrw7AA==
X-Received: by 2002:a63:d245:: with SMTP id t5mr3485108pgi.283.1600948492416; 
 Thu, 24 Sep 2020 04:54:52 -0700 (PDT)
Received: from ani-ubuntu ([115.96.139.162])
 by smtp.googlemail.com with ESMTPSA id s129sm2718393pfb.39.2020.09.24.04.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:54:51 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <ani@ani-ubuntu>
Date: Thu, 24 Sep 2020 17:24:45 +0530 (IST)
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH v3 3/7] hw/pci/pcie: Do not initialize slot capability
 if acpihp is used
In-Reply-To: <CAMDeoFXobPuNnKB3bQB=20SPbvTCgNiE_UWJrtsT6d5aAS5sTQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2009241722470.17687@ani-ubuntu>
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924070013.165026-4-jusual@redhat.com>
 <20200924033305-mutt-send-email-mst@kernel.org>
 <CAMDeoFXobPuNnKB3bQB=20SPbvTCgNiE_UWJrtsT6d5aAS5sTQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: none client-ip=2607:f8b0:4864:20::543;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Thu, 24 Sep 2020, Julia Suvorova wrote:

> On Thu, Sep 24, 2020 at 9:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Thu, Sep 24, 2020 at 09:00:09AM +0200, Julia Suvorova wrote:
>>> Instead of changing the hot-plug type in _OSC register, do not
>>> initialize the slot capability or set the 'Slot Implemented' flag.
>>> This way guest will choose ACPI hot-plug if it is preferred and leave
>>> the option to use SHPC with pcie-pci-bridge.
>>>
>>> Signed-off-by: Julia Suvorova <jusual@redhat.com>
>>> ---
>>>  hw/i386/acpi-build.h |  2 ++
>>>  hw/i386/acpi-build.c |  2 +-
>>>  hw/pci/pcie.c        | 16 ++++++++++++++++
>>>  3 files changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
>>> index 487ec7710f..4c5bfb3d0b 100644
>>> --- a/hw/i386/acpi-build.h
>>> +++ b/hw/i386/acpi-build.h
>>> @@ -11,4 +11,6 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
>>>
>>>  void acpi_setup(void);
>>>
>>> +Object *object_resolve_type_unambiguous(const char *typename);
>>> +
>>>  #endif
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index cf503b16af..b7811a8912 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -174,7 +174,7 @@ static void init_common_fadt_data(MachineState *ms, Object *o,
>>>      *data = fadt;
>>>  }
>>>
>>> -static Object *object_resolve_type_unambiguous(const char *typename)
>>> +Object *object_resolve_type_unambiguous(const char *typename)
>>>  {
>>>      bool ambig;
>>>      Object *o = object_resolve_path_type("", typename, &ambig);
>>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>>> index 5b48bae0f6..c1a082e8b9 100644
>>> --- a/hw/pci/pcie.c
>>> +++ b/hw/pci/pcie.c
>>> @@ -27,6 +27,8 @@
>>>  #include "hw/pci/pci_bus.h"
>>>  #include "hw/pci/pcie_regs.h"
>>>  #include "hw/pci/pcie_port.h"
>>> +#include "hw/i386/ich9.h"
>>> +#include "hw/i386/acpi-build.h"
>>>  #include "qemu/range.h"
>>>
>>>  //#define DEBUG_PCIE
>>
>>
>> Not really happy with pcie.c getting an i386 dependency.
>>
>>
>>
>>> @@ -515,12 +517,26 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>>>      pcie_cap_slot_push_attention_button(hotplug_pdev);
>>>  }
>>>
>>> +static bool acpi_pcihp_enabled(void)
>>> +{
>>> +    Object *lpc = object_resolve_type_unambiguous(TYPE_ICH9_LPC_DEVICE);
>>> +
>>> +    return lpc &&
>>> +           object_property_get_bool(lpc, "acpi-pci-hotplug-with-bridge-support",
>>> +                                    NULL);
>>> +
>>> +}
>>> +
>>
>> Why not just check the property unconditionally?
>
> Ok.

I do not see how that would work if lpc is NULL.
object_resolve_type_unambiguous() can return NULL, at least in theory.

>
>>>  /* pci express slot for pci express root/downstream port
>>>     PCI express capability slot registers */
>>>  void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
>>>  {
>>>      uint32_t pos = dev->exp.exp_cap;
>>>
>>> +    if (acpi_pcihp_enabled()) {
>>> +        return;
>>> +    }
>>> +
>>
>> I think I would rather not teach pcie about acpi. How about we
>> change the polarity, name the property
>> "pci-native-hotplug" or whatever makes sense.
>
> I'd prefer not to change the property name since the common code in
> hw/i386/acpi-build.c depends on it, but I can add a new one if it
> makes any sense.
>
>>>      pci_word_test_and_set_mask(dev->config + pos + PCI_EXP_FLAGS,
>>>                                 PCI_EXP_FLAGS_SLOT);
>>>
>>> --
>>> 2.25.4
>>
>
>

