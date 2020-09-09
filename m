Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195DBC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691A3206B5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="QmpM+8sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691A3206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFz0u-0005Vj-Gf
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kFz00-0004fs-SK
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:14:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kFyzy-0004Oj-Kz
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:14:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id z9so2129738wmk.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iiN0grqXMBLXfu22ZZxKXYMku0yWlbXwWJk0BzAZIkE=;
 b=QmpM+8sk19W3qct+0ZNpio/fR7s47eklRxbfHLVORCPsiyslrCGTK/dB4FG9zW27ln
 J5QLtikliKkYoap0+8q0nwU8yGh/Z6G4DgJhfLCDPmEVFc3ftGDcC+FVTJzpiBaiSiGe
 ZrUHHXvLnyLsT2lUxLs6HTlSSz0AJ326078aZgA8vo4KBmU+3020egg1Bc7cCLYrb+L1
 HQCPunWHRs7+kuuFB8JVdC/Rmk+5nfFlGDfm0YDzRg3mMk0VXEgD6r9niSLgML7zLLUo
 ACsUKcOR9UrNrnvvPjyG5f3tCPWii3juqf9t+3E1wkTqwwGVVkCIe/os2LLfeP1LGLFE
 S5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iiN0grqXMBLXfu22ZZxKXYMku0yWlbXwWJk0BzAZIkE=;
 b=fOVmKHdap5C8dIiVJm6Z7fv8KOvrR6ahwha5V+4ZKpfv6wmbwEnKmoDrd8u9UbVri2
 vpo++mN6NLSFm5cil3AehnF74t/re5A0BXwYTxQOdnd+jbTnOSahEZ/UJk97AOYd6sKN
 HI/iUaxYZ7aTmB4o7dy0ACBrvnxvxrgvDSZBrqkwq1kZ3auIQqvutxo9FFTDvXGxywDn
 MI5HNOhutWvV9DF2zsbSsZV4S3gTjv5IZzG4Iw/8DqTXZZEXE+ttYfi4ucxjMr2nlsFu
 uV4veoLGPGY52oZwkEenLZltEE6CnWP6weRUIWGMKOBinjP3gFKuS73YnigekCQLQBG5
 aNGg==
X-Gm-Message-State: AOAM533Pe5CNirFKIBawPTvgyveTQv4p669hryIALlcz8M4+MN1P5Kgk
 X/WQXwdiVzBN+Y8zLOMAcJC3IhPyYKHTH5+iT1v77BFc6kfQHQ==
X-Google-Smtp-Source: ABdhPJxpr93nqx9+maCXZQirNI4AlEnLpl/oIyEee1aCQUOV0DWoNgiw2Jkdg6xwBG1a4cA+iL/7YX7hJA/KJuHcH7U=
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr3392517wme.102.1599653688070; 
 Wed, 09 Sep 2020 05:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200904161000.12115-1-ani@anisinha.ca>
 <CAARzgwzZtRzrLNpgeE3NtimQZzz9VunyTTGNQ8KXVkYzezZFiA@mail.gmail.com>
In-Reply-To: <CAARzgwzZtRzrLNpgeE3NtimQZzz9VunyTTGNQ8KXVkYzezZFiA@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Wed, 9 Sep 2020 17:44:36 +0530
Message-ID: <CAARzgwxudt2abG-WiQyKUxsnE3VGJBQ0gw03nZJ9zgD=iib2jw@mail.gmail.com>
Subject: Re: [PATCH v3] i440fx/acpi: do not add hotplug related amls for cold
 plugged bridges
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x341.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gentle reminder to kindly review this patch :-)

@Julia Suvorova @Michael S. Tsirkin

On Mon, Sep 7, 2020 at 6:47 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> Julia Michael,
>
> Can you please provide your inputs on this one and the corresponding unit tests?
>
> On Fri, Sep 4, 2020 at 9:40 PM Ani Sinha <ani@anisinha.ca> wrote:
>>
>> Cold plugged bridges are not hot unpluggable, even when their hotplug
>>
>> property (acpi-pci-hotplug-with-bridge-support) is turned off. Please see
>>
>> the function acpi_pcihp_pc_no_hotplug() (thanks Julia). However, with
>>
>> the current implementaton, windows would try to hot-unplug a pci bridge when
>>
>> it's hotplug switch is off. This is regardless of whether there are devices
>>
>> attached to the bridge. This is because we add amls like _EJ0 etc for the
>>
>> pci slot where the bridge is cold plugged. We have a demo video here:
>>
>> https://youtu.be/pME2sjyQweo
>>
>>
>>
>> In this fix, we identify a cold plugged bridge and for cold plugged bridges,
>>
>> we do not add the appropriate amls and acpi methods that are used by the OS
>>
>> to identify a hot-pluggable/unpluggable pci device. After this change, Windows
>>
>> does not show an option to eject the PCI bridge. A demo video is here:
>>
>> https://youtu.be/kbgej5B9Hgs
>>
>>
>>
>> While at it, I have also updated a stale comment.
>>
>>
>>
>> This change is tested with a Windows 2012R2 guest image and Windows 2019 server
>>
>> guest image running on Ubuntu 18.04 host. This change is based off of upstream
>>
>> qemu master branch tag v5.1.0.
>>
>>
>>
>> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>>
>> ---
>>
>>  hw/i386/acpi-build.c | 12 ++++++------
>>
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>>
>>
>> changelog:
>>
>> v3: commit log updates providing more accurate information as received from Julia.
>>
>> v2: cosmetic commit log updates with patch testing information.
>>
>> v1: initial patch.
>>
>>
>>
>>
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>
>> index b7bcbbbb2a..90b863f4ec 100644
>>
>> --- a/hw/i386/acpi-build.c
>>
>> +++ b/hw/i386/acpi-build.c
>>
>> @@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>>
>>          int slot = PCI_SLOT(i);
>>
>>          bool hotplug_enabled_dev;
>>
>>          bool bridge_in_acpi;
>>
>> +        bool cold_plugged_bridge;
>>
>>
>>
>>          if (!pdev) {
>>
>>              if (bsel) { /* add hotplug slots for non present devices */
>>
>> @@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>>
>>          pc = PCI_DEVICE_GET_CLASS(pdev);
>>
>>          dc = DEVICE_GET_CLASS(pdev);
>>
>>
>>
>> -        /* When hotplug for bridges is enabled, bridges are
>>
>> -         * described in ACPI separately (see build_pci_bus_end).
>>
>> -         * In this case they aren't themselves hot-pluggable.
>>
>> +        /*
>>
>> +         * Cold plugged bridges aren't themselves hot-pluggable.
>>
>>           * Hotplugged bridges *are* hot-pluggable.
>>
>>           */
>>
>> -        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
>>
>> -            !DEVICE(pdev)->hotplugged;
>>
>> +        cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
>>
>> +        bridge_in_acpi =  cold_plugged_bridge && pcihp_bridge_en;
>>
>>
>>
>> -        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
>>
>> +        hotplug_enabled_dev = bsel && dc->hotpluggable && !cold_plugged_bridge;
>>
>>
>>
>>          if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
>>
>>              continue;
>>
>> --
>>
>> 2.17.1
>>
>>
>>

