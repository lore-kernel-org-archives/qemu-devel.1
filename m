Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6DBC38A2E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 12:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B6821D79
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 12:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjbD4EFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B6821D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPmtN-0001LJ-Vs
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 08:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jPmsj-0000vz-Jp
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 08:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jPmsh-0002vx-A8
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 08:47:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jPmsh-0002rN-2R
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 08:47:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id o81so5569689wmo.2
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=2zL+4itvJ3mWTIrjA5CxtMh8GGPrLYc9umV1dxKnIQo=;
 b=bjbD4EFvQUi3SmobPIar/RuGVsIhQMbXAabWv/msPfkQkqWD5NEW6PlTY8EIBvf0Or
 18pXMQLWUajvUIbkmhlr1GhKf7Kr0Pd5+FjhBNC6d7piJZ0N4AzChlLs+BC9Bpedr7GK
 EGs5gv9hGsMSvyOmKD0Oob5oAU1rGdjbtQV0/ApTfZrVFTFB2u9jLkd8+0o5zW2vKQhg
 XxFE/oKDhCZaBb4qfd1GMbZrCzC0dwQ2O29HI6pl+ks2sZTWCS9Kp5NvtcvNEmR10d0L
 GySW3ersWw79eF2pngnkQcTPlARXflUYPlkiYLmCbz0GsZJd3yq+rzHvw9JXQ+2C8RCb
 eziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2zL+4itvJ3mWTIrjA5CxtMh8GGPrLYc9umV1dxKnIQo=;
 b=gdzYo+nDA0edyMuZDi8p4vCZ4ahzuIUjw0HHTSRmqUSmVeNGojRnATjXHyQfSocUh1
 k8qV9rPsSxGLiv5l0xSBVnqa3imyGQQ0WuCprqLNxGaYvefUIPyslhpwFlApIIaOo++s
 c0ent3q/dqdNXqdu1G+nM6A2790V+s801DDcKDLItUtjY3zPxXC8th0gQXU2Jr6VIGIr
 3hKAgRYm9f3g48JRhzFXpRhqoNrdjCYLblW+MYu67cGXhocDfglYAORbCKfmB1HPu7e7
 2GPq3RyUMNo9RCtPINwqHjVQMj64+cJc5IV6eQvc8CmXmX3uG+h1oyzhL79e+dByBCvH
 U/hg==
X-Gm-Message-State: AGi0PuZFtYzsNYRRApqhfe1lj4I35oObsOidp9JX9LarR70QXbwCZXnN
 THCxAom1+4129D1J90/1zsM=
X-Google-Smtp-Source: APiQypJVtwKmHhlsHawE/ruUr+vD/DcYz8GhCD7J7jVEzrNqKSnZREuM6+3xH6QQZNmPaDOB5vpA5A==
X-Received: by 2002:a1c:8049:: with SMTP id b70mr8165619wmd.162.1587214054034; 
 Sat, 18 Apr 2020 05:47:34 -0700 (PDT)
Received: from [192.168.86.37] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id c190sm11669899wme.4.2020.04.18.05.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2020 05:47:33 -0700 (PDT)
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
To: Ani Sinha <ani.sinha@nutanix.com>, Laine Stump <laine@redhat.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <56B4E13C-DCAA-4E40-A821-6C043844A253@nutanix.com>
 <0e15c8e7-7b32-985e-c182-2868273a1bd7@redhat.com>
 <AFEDBC1F-8536-4354-9C5E-9829C258B6E3@nutanix.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <67ca69f6-8d6b-8be0-72f2-b30a67edf200@gmail.com>
Date: Sat, 18 Apr 2020 15:48:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <AFEDBC1F-8536-4354-9C5E-9829C258B6E3@nutanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Ani,

On 4/18/20 6:25 AM, Ani Sinha wrote:
> +Julia who implemented https://patchwork.kernel.org/patch/11388881/
>
>
>> On Apr 18, 2020, at 3:26 AM, Laine Stump <laine@redhat.com> wrote:
>>
>> On 4/17/20 12:35 PM, Ani Sinha wrote:
>>> +Laine
>>>> On Apr 17, 2020, at 9:39 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> Problem is, I think this is not something we can support with pcie or shpc.
>>>> I'm reluctant to add features that only ACPI can support,
>>>> we are trying to phase that out.
>>> Hmm. I see. We use conventional PCI and hence was looking for providing this feature for conventional PCI only. Laine might be able to throw some lights as to feasibility of the in PCIE world.
>> Sorry, my knowledge doesn't go that low. If there's a qemu option I can expose it in libvirt, but am by no means an expert of qemu internals or the pci/pcie specs :-)
>>
>> (BTW, I think in the past people have prevented enabling hot-unplug by unprivileged users in Windows with some sort of a "system policy" in Windows. (whatever that is - I don't use Windows, and have just heard this from others when discussing the problem).
>>

A PCIe Root Port or a PCI slot can or cannot support hot-plugging. 
Anything in the middle can't be done at PCIe/PCI level (as far as I know).
I think the answer can be at the modelling level. Use non hot-pluggable 
slots (or PCIe Root Ports without hot-plug support) for the devices
you don't want hot-unplugged, leave an empty PCI Bridge (or some PCIe 
Root Ports with hot-plug support) to be able to hot-plug devices.

Thanks,
Marcel

> My question to Julia is whether it is possible to disable just hot unplug but keep hot plugging for PCIE devices enabled using PCI_EXP_SLTCAP_HPC  or otherwise in Qemu?
>
>



