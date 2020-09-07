Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF91C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 03:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3B3207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 03:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8XjbEZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3B3207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF80t-0006cq-VG
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 23:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF80M-0006Cd-Ix
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 23:39:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF80K-0002Zo-Id
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 23:39:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id o5so14156725wrn.13
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 20:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V56Gq+LaTEaITEizAWIlAPD4v0bw7dx51vm3rnPusW0=;
 b=r8XjbEZRDCS9rrjLDa3NNng+mf1H9THSoVvJ3h7mENbCkpA8XUtI/oWyyNU2sGM8qg
 WSfD1G16qZCUiAeKiPMdhCRXh8/CG0RRkxHq1LtIqVDk0nsbjxtcvhMvsbgR6Uc+++Sh
 pxLtMUQ9SVQJFucjQSZSiNzp+MnSVkoHA0gcXu3VkUnQbW0vP2JaiTPEylemVWyKhpJT
 eu1ix1okMacLmOJLVuW7guPsmjbFtacp7Wwo8Rz17NLIVzES3wQA6KGqmzTdTuKqLtnH
 ZtP+/rx+VMqaXttcZfZreEXZsx/RFW4SAYdmE/cqUCbCKm5Xtl4t7auS/SJokkcd24sS
 oiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V56Gq+LaTEaITEizAWIlAPD4v0bw7dx51vm3rnPusW0=;
 b=eYFtXV/rOom9CHR6q16nZoCHSu47boGfZQU2mUdc9QwiClr07oNPTXfxwg//G351DK
 ywhZ4MhvnXLLEAHaSThiodJGGlVVcg918B7h/MQ+kpGCNbH8ktw8mOqoDCy7amnYiKRk
 vpTix/2KgH0xiO/dSKTxa3dGDXgrOPL/N08UzWfVgVuf3Rivm89qZnk5hfGvoQOrGx8t
 h+PKOkcchO2dxIZ26vQYMVrSkBPw9jl3BT7/F0S6gvCzX5+KLsHWVTw0IxrTJV4znyV5
 3W6oR+4ujU1OID+UjKmAxvMz+RwS79HamXvlAB53c1iVjH9KyPgQ+WXDLnNCruqP3mso
 2SxQ==
X-Gm-Message-State: AOAM532j7J/7N2XHC+O1+D6hiTfyVGReTrn4ESqopNJnajmyarznz2nC
 pq/RC5nbP8gPEFucsxJLgZk=
X-Google-Smtp-Source: ABdhPJxYDpTO/Qx2+yJjFsr7fmjs5Lsdo8dShhjlCFJaNIQmiJtJW0rcGVPyDr476+fx5M7d3c6HGQ==
X-Received: by 2002:adf:8069:: with SMTP id 96mr1119320wrk.342.1599449978437; 
 Sun, 06 Sep 2020 20:39:38 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id j14sm26094038wrr.66.2020.09.06.20.39.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Sep 2020 20:39:37 -0700 (PDT)
Subject: Re: [PATCH V2 for-5.2] hw/null-machine: Add the kvm_type() hook for
 MIPS
To: Huacai Chen <chenhuacai@gmail.com>
References: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
 <d594ed8e-1cb5-f9ac-09d3-7da28f5a95d3@amsat.org>
 <CAAhV-H4hRT+7KNCDX7bWwxK_mgYRSkWh+9rh1o6LLfD8zmGdqg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <15357cf6-43d0-557c-f3c8-1668aa44fd5d@amsat.org>
Date: Mon, 7 Sep 2020 05:39:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4hRT+7KNCDX7bWwxK_mgYRSkWh+9rh1o6LLfD8zmGdqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.69,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You forgot to Cc the maintainers, doing it for you:

./scripts/get_maintainer.pl -f hw/core/null-machine.c
Eduardo Habkost <ehabkost@redhat.com> (supporter:Machine core)
Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:Machine core)

On 9/3/20 2:58 AM, Huacai Chen wrote:
> Hi, Philippe,
> 
> On Wed, Sep 2, 2020 at 9:55 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Hi Huacai,
>>
>> On 8/24/20 10:11 AM, Huacai Chen wrote:
>>> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now,
>>> libvirt uses a null-machine to detect the kvm capability. In the MIPS
>>> case, it will return "KVM not supported" on a VZ platform by default.
>>> So, add the kvm_type() hook to the null-machine.
>>>
>>> This seems not a very good solution, but I cannot do it better now.
>>>
>>> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>>  hw/core/meson.build    | 2 +-
>>>  hw/core/null-machine.c | 6 ++++++
>>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/core/meson.build b/hw/core/meson.build
>>> index fc91f98..b6591b9 100644
>>> --- a/hw/core/meson.build
>>> +++ b/hw/core/meson.build
>>> @@ -35,7 +35,6 @@ softmmu_ss.add(files(
>>>    'machine-hmp-cmds.c',
>>>    'machine.c',
>>>    'nmi.c',
>>> -  'null-machine.c',
>>>    'qdev-fw.c',
>>>    'qdev-properties-system.c',
>>>    'sysbus.c',
>>> @@ -45,5 +44,6 @@ softmmu_ss.add(files(
>>>
>>>  specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
>>>    'machine-qmp-cmds.c',
>>> +  'null-machine.c',
>>>    'numa.c',
>>>  ))
>>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
>>> index 7e69352..4b4ab76 100644
>>> --- a/hw/core/null-machine.c
>>> +++ b/hw/core/null-machine.c
>>> @@ -17,6 +17,9 @@
>>>  #include "sysemu/sysemu.h"
>>>  #include "exec/address-spaces.h"
>>>  #include "hw/core/cpu.h"
>>> +#ifdef TARGET_MIPS
>>> +#include "kvm_mips.h"
>>> +#endif
>>>
>>>  static void machine_none_init(MachineState *mch)
>>>  {
>>> @@ -55,6 +58,9 @@ static void machine_none_machine_init(MachineClass *mc)
>>>      mc->no_floppy = 1;
>>>      mc->no_cdrom = 1;
>>>      mc->no_sdcard = 1;
>>> +#ifdef TARGET_MIPS
>>> +    mc->kvm_type = mips_kvm_type;
>>> +#endif
>>
>> I'm a bit confused here, you are taking the same path from your v4...
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg712550.html
>>
>> Did you rebase the correct version?
> The old patch has split to two parts, the first part is used by MIPS
> machine and already merged. This is the second part used by the
> null-machine (and libvirt use null-machine to detect kvm
> capabilities).
> 
> Huacai
>>
>>>  }
>>>
>>>  DEFINE_MACHINE("none", machine_none_machine_init)
>>>
> 

