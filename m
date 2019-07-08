Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7A7C606C9
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095CE21783
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYL/zdXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095CE21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkYra-0005py-9X
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 14:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57738)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hkYqH-0005NQ-Df
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hkYqG-0005bm-6W
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:58:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hkYqF-0005ZF-RV
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:58:24 -0400
Received: by mail-wm1-x341.google.com with SMTP id p74so561840wme.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=lSsBfvNV08XOjlhDYAo1s5GOzPqIGaZbDXHmO4YtGQw=;
 b=vYL/zdXysbbJ3tq4vGkxc/HCGoYswq8JbBDFAP7YESQSFXdtMJZ5vofaf3ZSvtY8+x
 jO850+2t48OBuRLBniu39pKAn2kA9rU62jCGlUvPvXD1yEllcr1UDbYtUUJklmbAWwkI
 rOtiW09tYvf1+El7/PgorDd5bnmGpYb5ntXPWyZQ/1LuiYhoib5MR1XL7gLZqA9llVep
 l5O0R4R1YrBUj869GJmGp9Cz+kgtm/UkncPA8eh/BnK9ThkJozOyxssknkuDyjJ3Iz5z
 znCcdiG0QR/7gGxwe2OCavtAErjZ0GpqYJaG7rEyA01FvxeQeR6MmkCZTkt1PI6tAD4n
 NSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lSsBfvNV08XOjlhDYAo1s5GOzPqIGaZbDXHmO4YtGQw=;
 b=rxX/dqOYIeq5XRH/IIoTqmmrn8cl7sl9eGFN7MZ/0kXaGLMbJpdfMJVwzX0cx7SKiO
 QdQUQy66uKatIbZRzqRaaTXECj5EhbxF7Qoc1ybEuiJBbci5T5uIMsvpZLs3IUfy70eF
 fLC/yasn/LLRVoqxs5aJo+gAT7xAqUUWg368u5bA/N4qtEi5xXJ8pKSCT2rQvjN1O5Ff
 mucOkeU/8FkltBO6UP9slDFgSBR7NAz51+edqRly2lWIrvSkR15erSiiIqFS5u9uXqSr
 3h8FRrTGDsbFsSGu7TSW0hZYZsP25s5a41w/xbuQ0pgyH7OkhFbQ6hHWtwAeXlCGMPuA
 PtHw==
X-Gm-Message-State: APjAAAW7moJ9uOiAW/Y8aTeg2eqojo2X887WXK6lqyyoNlEz8c5N4Dl+
 O25xj2owJExEkvbYCkQ6Gbg=
X-Google-Smtp-Source: APXvYqxqhoLsnUkjsI8SFqATktSteBuXa7bzcuX1SmTpc3hX51L+jKUl/GmkMeNFDhiDCv45nNuJZw==
X-Received: by 2002:a1c:2e09:: with SMTP id u9mr18115680wmu.137.1562612302636; 
 Mon, 08 Jul 2019 11:58:22 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id e3sm13811019wrs.37.2019.07.08.11.58.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jul 2019 11:58:21 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190706040940.7884-1-skrtbhtngr@gmail.com>
 <26ae890e-ca8a-6a5b-0d93-67cd266c8e93@gmail.com>
 <20190708093833.GC3082@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <2945aace-7bff-4713-4117-eb0688e4b488@gmail.com>
Date: Mon, 8 Jul 2019 21:58:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190708093833.GC3082@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RFC v2 0/2] Add live migration support in the
 PVRDMA device
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
Cc: Sukrit Bhatnagar <skrtbhtngr@gmail.com>,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/8/19 12:38 PM, Daniel P. Berrangé wrote:
> On Sat, Jul 06, 2019 at 10:04:55PM +0300, Marcel Apfelbaum wrote:
>> Hi Sukrit,
>>
>> On 7/6/19 7:09 AM, Sukrit Bhatnagar wrote:
>>> Changes in v2:
>>>
>>> * Modify load_dsr() such that dsr mapping is not performed if dsr value
>>>     is non-NULL. Also move free_dsr() out of load_dsr() and call it right
>>>     before if needed. These two changes will allow us to call load_dsr()
>>>     even when we have already done dsr mapping and would like to go on
>>>     with the rest of mappings.
>>>
>>> * Use VMStateDescription instead of SaveVMHandlers to describe migration
>>>     state. Also add fields for parent PCI object and MSIX.
>>>
>>> * Use a temporary structure (struct PVRDMAMigTmp) to hold some fields
>>>     during migration. These fields, such as cmd_slot_dma and resp_slot_dma
>>>     inside dsr, do not fit into VMSTATE macros as their container
>>>     (dsr_info->dsr) will not be ready until it is mapped on the dest.
>>>
>>> * Perform mappings to CQ and event notification rings after the state is
>>>     loaded. This is an extension to the mappings performed in v1;
>>>     following the flow of load_dsr(). All the mappings are succesfully
>>>     done on the dest on state load.
>> Nice!
>>
>>> Link(s) to v1:
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04924.html
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04923.html
>>>
>>>
>>> Things working now (were not working at the time of v1):
>>>
>>> * vmxnet3 is migrating successfully. The issue was in the migration of
>>>     its PCI configuration space, and is solved by the patch Marcel had sent:
>>>     https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01500.html
>>>
>>> * There is no problem due to BounceBuffers which were failing the dma mapping
>>>     calls in state load logic earlier. Not sure exactly how it went away. I am
>>>     guessing that adding the PCI and MSIX state to migration solved the issue.
>>>
>> I am sure it was connected somehow, anyway, I am glad we can continue
>> with the project.
>>
>>> What is still needed:
>>>
>>> * A workaround to get libvirt to support same-host migration. Since
>>>     the problems faced in v1 (mentioned above) are out of the way, we
>>>     can move further, and in doing so, we will need this.
>> [Adding Daniel  and Michal]
>> Is there anyway to test live-migration for libvirt domains on the same host?
>> Even a 'hack' would be enough.
> Create two VMs on your host & run inside those. Or create two containers
> if you want a lighter weight solution. You must have two completely
> independant libvirtd instances, sharing nothing, except optionally where
> you store disk images.

We'll work with live-cd, no storage is needed.

Thank you for the help!
Marcel

> Regards,
> Daniel


