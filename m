Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83349C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C8F20656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgPM8erw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C8F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopEU-0005V4-Iv
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ionsJ-0008An-9L
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ionsI-0007GG-4g
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:22:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27804
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ionsI-0007G5-1i
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578399737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuhCTz+C6MaTpFxoNziRH6JqZlhj937Jrv0EFLky8Sk=;
 b=LgPM8erw2/Z3UqeKun5f8y7I3AHUZFD22rLi9m20/TaQ9P6tnqASAIb073ZONmrColKSK2
 zInlFHUiOXYsXtYYTqgM8Y1akpkPgxVEfxH6pSkG5BHvRcytX+Z+gN2/cpegvLGa2JemlV
 ziBUHHksvnc2ZBX2GQLilztvo5lJ0CI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-Bg7ntxGaNdOxX9slddlIyw-1; Tue, 07 Jan 2020 07:22:16 -0500
Received: by mail-wm1-f72.google.com with SMTP id 7so1891690wmf.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 04:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wqAJeqaN1FUy1p3MtuptAKhlaN745axb3tJUVhCfY7U=;
 b=Y+jRK9BqCQOCnsAp8XRlvI3dgzPGY5C7rkSLJWEPLZD3dAILPdsekweM7zs9c+VrKl
 WT9YW89K/+9RoKH0GHn6TaSZY9zSBGYIq7S10G1FR2grJgZxpNYP7B6g1TVCSTcbXV85
 zhlJjJCzbSsyVSO6c39t+kCwTJBGY9j+AqzAtxIU4HoFqD1uGPG3aUGwcB/Al+fF3KV3
 cod3bJXUr7ca7E8xnrE4d8BaWT0Ml0KsNhOkxQ0OW1aCFw8BP7U1hIpSXtslR5/MiD8X
 F0t+Zh8T7PLhJ2hHl3w749l8msVy/GihpHBDdNHsPMnrT1qm1ijpx5IXQcVQ26p7QeSG
 fSnA==
X-Gm-Message-State: APjAAAWif7uXVqDcoeyJ3FyE2JmbDlJalr53tAqJUAxhFuVRn9sv8+YC
 Yyigw3eQ5HY1vgY7/FtShXT7uyF63oTN+BzeqaCnMqOGB5YxiUGk6CBth8KfeAoedg52w+7hb4z
 +dJKSvNvt7scnhR4=
X-Received: by 2002:a1c:7ed0:: with SMTP id z199mr39307387wmc.58.1578399735084; 
 Tue, 07 Jan 2020 04:22:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxkH39hJZcyPPUEai+OguMZZ8G0fZoCu5nbD6Q7LmnhnBkch7+9oVFscjGePNm6QvaTkzo0MQ==
X-Received: by 2002:a1c:7ed0:: with SMTP id z199mr39307355wmc.58.1578399734829; 
 Tue, 07 Jan 2020 04:22:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id k13sm76207458wrx.59.2020.01.07.04.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 04:22:14 -0800 (PST)
Subject: Re: [PATCH 04/14] hw/i386: Restrict fw_cfg to the PC machines
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-5-philmd@redhat.com>
 <a5ba0619-e236-7fb0-8c17-028670b69501@redhat.com>
 <20200107050921-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21529c45-117d-ed7d-d518-e8073af86581@redhat.com>
Date: Tue, 7 Jan 2020 13:22:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200107050921-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-MC-Unique: Bg7ntxGaNdOxX9slddlIyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/20 11:16, Michael S. Tsirkin wrote:
> On Tue, Jan 07, 2020 at 11:01:48AM +0100, Paolo Bonzini wrote:
>> On 31/12/19 19:32, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Only the PC-based machines use the fw_cfg device. In particular,
>>> the MicroVM machine does not use it. Only compile/link it when
>>> machines require it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> Cc: Sergio Lopez <slp@redhat.com>
>>> ---
>>>  hw/i386/Makefile.objs | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
>>> index 6ebb6d0cf0..48f2693546 100644
>>> --- a/hw/i386/Makefile.objs
>>> +++ b/hw/i386/Makefile.objs
>>> @@ -5,7 +5,7 @@ obj-$(CONFIG_PC) +=3D pc.o pc_sysfw.o
>>>  obj-$(CONFIG_I440FX) +=3D pc_piix.o
>>>  obj-$(CONFIG_Q35) +=3D pc_q35.o
>>>  obj-$(CONFIG_MICROVM) +=3D microvm.o
>>> -obj-y +=3D fw_cfg.o
>>> +obj-$(CONFIG_PC) +=3D fw_cfg.o
>>>  obj-$(CONFIG_X86_IOMMU) +=3D x86-iommu.o
>>>  obj-$(CONFIG_VTD) +=3D intel_iommu.o
>>>  obj-$(CONFIG_AMD_IOMMU) +=3D amd_iommu.o
>>>
>>
>> Ah no, this is hw/i386/fw_cfg.c; of course hw/nvram/fw_cfg.c has its own
>> Kconfig symbol.
>=20
> Sorry couldn't find it. Which symbol is that?

None. :)  fw_cfg has a bunch of uses in vl.c, it's not really going to
be easy to stub it out and probably pointless because it's an easy way
for firmware to get QEMU-specific information.

Paolo


