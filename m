Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B09C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 04:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0897620716
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 04:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="m+SnNvPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0897620716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCFFQ-0000Oy-5h
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 00:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1jCFEd-0008KN-5J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 00:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1jCFEb-0005cf-IW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 00:14:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1jCFEb-0005bt-0X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 00:14:13 -0400
Received: by mail-pl1-x644.google.com with SMTP id g6so2119562plt.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 21:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tCaa2Jt0NgkYjA5yWwciDOCODpGltXXkNXovmqrg98A=;
 b=m+SnNvPsj0zDYJr1CS2JS6AE8iKX5wuF9dwnG/PIzrxwYYKPXv42GYt/J1CpyUsTJc
 gSoX3KaCD9S4LmwilVay2T36UzD/Ice9Ppoxbdn+VZaPybeiotwaoeSIKW31nId+oDW0
 l15urQJooRPT1z0kt9vLDZhtlFFrlyHCrK/zMrAyeyNKf+ALqNYd36/8HCE6d0u2muIt
 plbb7dFCd6kKfxgXJbPj/G+o5E8cbiemiMK232C+rdJVoHpiTIbmaTiE37fWxtCdZKvJ
 YliX2/sdyrjEulHj3IO/jMNzUnOZxPP16/dtRNWFKcszFfmT5vBi47jZysGIehaNViWs
 xX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tCaa2Jt0NgkYjA5yWwciDOCODpGltXXkNXovmqrg98A=;
 b=sAJUXOkEjyxWcIliux7rFtkGyU+4kS2GEqc4EVZs5JZyaB378P/hJX4rOQiNX5/IPC
 tVEDC9HWtFaJW/XvJDCEU/XtbY33jqLjeidaaQrF+i1WCxiQDaawChd36uV97iE1yStA
 Pt3qbYtQ3adqQg14+8+4eqAJNvSeW40OBiWf2gsrwF76fBXMQtoCVkyELOud3J+zoage
 z+4/EauJ2O8wUUKWJjnknxHCS1ciL0DnwYz3HNBrZVmzFILSC7GZM127MpJvvKPu4mNb
 NhnCEjwA317RdbW3fCuuo7q5PGWN+c1lQS3LrrlHylW5AABOuB1+dpUIE0qPHhXYX9j5
 Vl+Q==
X-Gm-Message-State: ANhLgQ3FtPTiqZbaLPkYXBFgrfBoFZ3w6ZcZQyFxtZVqVNKaDPMNnK4q
 SSQObW81h+wB1PYTjVeDVaaZqQ==
X-Google-Smtp-Source: ADFU+vtnrygmSYRw6ryG4qhVpdr4JRVZiiGTBJ/lhoKs2sMSmuCLSqcSeInystg5sHFiphUIKKVnZQ==
X-Received: by 2002:a17:902:7618:: with SMTP id
 k24mr6216341pll.320.1583986451580; 
 Wed, 11 Mar 2020 21:14:11 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id x18sm41856749pfo.148.2020.03.11.21.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 21:14:10 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] spapr: Enable virtio iommu_platform=on by default
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200305043009.611636-3-david@gibson.dropbear.id.au>
 <20200305125903.096c3897@bahia.home> <20200310114351.5381504e@bahia.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <e9a2de91-7737-f793-b445-4846a1126daf@ozlabs.ru>
Date: Thu, 12 Mar 2020 15:14:06 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310114351.5381504e@bahia.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: pair@us.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, paulus@samba.org,
 clg@kaod.org, mdroth@us.ibm.com, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/03/2020 21:43, Greg Kurz wrote:
> On Thu, 5 Mar 2020 12:59:03 +0100
> Greg Kurz <groug@kaod.org> wrote:
> 
>> On Thu,  5 Mar 2020 15:30:09 +1100
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>
>>> Traditionally, virtio devices don't do DMA by the usual path on the
>>> guest platform.  In particular they usually bypass any virtual IOMMU
>>> the guest has, using hypervisor magic to access untranslated guest
>>> physical addresses.
>>>
>>> There's now the optional iommu_platform flag which can tell virtio
>>> devices to use the platform's normal DMA path, including any IOMMUs.
>>> That flag was motiviated for the case of hardware virtio
>>> implementations, but there are other reasons to want it.
>>>
>>> Specifically, the fact that the virtio device doesn't use vIOMMU
>>> translation means that virtio devices are unsafe to pass to nested
>>> guests, or to use with VFIO userspace drivers inside the guest.  This
>>> is particularly noticeable on the pseries platform which *always* has
>>> a guest-visible vIOMMU.
>>>
>>> Not using the normal DMA path also causes difficulties for the guest
>>> side driver when using the upcoming POWER Secure VMs (a.k.a. PEF).
>>> While it's theoretically possible to handle this on the guest side,
>>> it's really fiddly.  Given the other problems with the non-translated
>>> virtio device, let's just enable vIOMMU translation for virtio devices
>>> by default in the pseries-5.0 (and later) machine types.
>>>
>>> This does mean the new machine type will no longer support guest
>>> kernels older than 4.8, unless they have support for the virtio
>>> IOMMU_PLATFORM flag backported (which some distro kernels like RHEL7
>>> do).
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>
>> The patch looks good but I'm not sure if we're quite ready to merge
>> it yet. With this applied, I get zero output on a virtio-serial based
>> console:
>>
>> ie.
>>   -chardev stdio,id=con0 -device virtio-serial -device virtconsole,chardev=con0 
>>
>> FYI, virtio-serial is a bit broken for spapr with iommu_platform=off already:
>>
>> (1) pressing a key in the console during SLOF or grub has no effect
>>
>> (2) the guest kernel boot stays stuck around quiesce
>>
>> These are regressions introduced by this SLOF update:
>>
>> a363e9ed8731f45674260932a340a0d81c4b0a6f is the first bad commit
>> commit a363e9ed8731f45674260932a340a0d81c4b0a6f
>> Author: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Date:   Tue Dec 17 11:31:54 2019 +1100
>>     pseries: Update SLOF firmware image
>>
>> A trivial fix was already posted on the SLOF list for (1) :
>>
>> https://patchwork.ozlabs.org/patch/1249338/
>>
>> (2) is still under investigation but the console is _at least_
>> functional until the guest OS takes control. This is no longer
>> the case with this patch.
>>
> 
> Some progress was made on the SLOF front:
> 
> https://patchwork.ozlabs.org/project/slof/list/?series=163314
> 
> With these series applied to SLOF, I can now boot a fedora31 guest
> with a virtio-serial console and iommu_platform=on... but now
> I'm trying out other virtio devices supported by SLOF and I'm
> running into issues around virtio-pci.disable-legacy as mentioned
> in some other mail...
> 
> It seems we may not be ready to merge this series yet.


fwiw I sent a pull request:

https://lore.kernel.org/qemu-devel/20200312041010.16229-1-aik@ozlabs.ru/T/#u



> 
>>>  hw/ppc/spapr.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 3cfc98ac61..5ef099536e 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -4575,6 +4575,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>>>       */
>>>      static GlobalProperty compat[] = {
>>>          { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
>>> +        { TYPE_VIRTIO_DEVICE, "iommu_platform", "on", },
>>>      };
>>>  
>>>      mc->alias = "pseries";
>>> @@ -4622,6 +4623,7 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
>>>      SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>>>      static GlobalProperty compat[] = {
>>>          { TYPE_VIRTIO_PCI, "disable-legacy", "auto" },
>>> +        { TYPE_VIRTIO_DEVICE, "iommu_platform", "off", },
>>>      };
>>>  
>>>      spapr_machine_5_0_class_options(mc);
>>
> 

-- 
Alexey

