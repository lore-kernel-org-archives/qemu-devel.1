Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D487C388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3F920720
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvOwJWFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3F920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7lf-0005bl-SD
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX7jk-0004P2-UG
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:00:57 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX7jj-00063x-3Z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:00:56 -0400
Received: by mail-ed1-x541.google.com with SMTP id x1so10594154eds.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=e0etMofaW9SaMB1wnsg0x/G5RNjt5vIKJ7MJQXxwx3M=;
 b=bvOwJWFi664MCi6AIGRffX7BN7VJ4zo08SfvSQeC31S8W3A3cAU/vILdF9X4mMWxIc
 bFhBm/DGRlqaMovQpDAcrsEeqZetMdbh0EcZT+lPH8qprr53ZUbVTrTyf/KcrKnN+uuv
 nfyxswVevnQOSPDPC9v2htkFzFJk3cm0FeqJEWhVwbhtN4DlW+blUC3zQ1OQpK9JFVuC
 5+f69hVbIEy5+f6Seos4vwlFFeHtBEsdrG2A1cDcErnt68O4qEMhQk68kwbFJs2dKXy9
 4lqRFQ/nhgAU6xFPJcs7IweH4st5KlxVRRZ59SFUS20m5n1wHFaUDsF/JVoQGppQh7Q+
 q7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e0etMofaW9SaMB1wnsg0x/G5RNjt5vIKJ7MJQXxwx3M=;
 b=hW+LeSgXxx3YAaOSr/RjHRiVl486PSf7guR3JyxQXu01lFPpkiUNrQCS+pD+/teLKR
 +J9ZTlYdLL5HaGOt77BHTPUt5pTwz22QVgjnBMULYUBpbe4lPeMdVQpGwD/D53qtQSwW
 Uac7kPGIrZ3xICeW86gvjbkf+mX7LBMaRtRWYqUW9Od0iaor8HAdi/vp25uZ33kuPhE4
 P21B9osb+x4910nW6oHAvrjME7e0NErcr0t6o5B0wnJvEJYarxHehkRjhKr0Nm0i6E/o
 RL2bi9J0FWe7HkNPXRfo4wKrp3ToRGO9QgRj7SLx0WCElld5EnVZKiN4sxsbbVU0ZGdC
 J21Q==
X-Gm-Message-State: AOAM530ve+WVal3IL3Qr707u8Qix27LLzZXHya+moIVfb3OHUcJIs/DG
 FnT7/CT+3kjdwdLe8nc5t/oFbsy1DUg=
X-Google-Smtp-Source: ABdhPJyOvKqK5PmXho1UCcjMkj69ZTnhKL5r95fA/QkcWuMIGfh/RIJeybs3lRfqCMWE3sFkfwC7FA==
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr17617624edf.52.1603738850669; 
 Mon, 26 Oct 2020 12:00:50 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u2sm5725592edr.70.2020.10.26.12.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 12:00:49 -0700 (PDT)
Subject: Re: [PATCH 11/15] rx: move BIOS load from MCU to board
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-12-pbonzini@redhat.com> <87lffsgas5.fsf@linaro.org>
 <53ddb690-db6d-cfce-ee9e-c274b18bfaa0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d76b93ed-0abf-9b77-7b46-66161d57c75f@amsat.org>
Date: Mon, 26 Oct 2020 20:00:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <53ddb690-db6d-cfce-ee9e-c274b18bfaa0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 6:34 PM, Paolo Bonzini wrote:
> On 26/10/20 18:24, Alex Bennée wrote:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> The ROM loader state is global and not part of the MCU, and the
>>> BIOS is in machine->firmware.  So just like the kernel case,
>>> load it in the board.
>>>
>>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   hw/rx/rx-gdbsim.c | 7 +++++++
>>>   hw/rx/rx62n.c     | 9 ---------
>>>   2 files changed, 7 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
>>> index 417ec0564b..040006c1c5 100644
>>> --- a/hw/rx/rx-gdbsim.c
>>> +++ b/hw/rx/rx-gdbsim.c
>>> @@ -142,6 +142,13 @@ static void rx_gdbsim_init(MachineState *machine)
>>>               /* Set dtb address to R1 */
>>>               RX_CPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
>>>           }
>>> +    } else {
>>> +        if (machine->firmware) {
>>> +            rom_add_file_fixed(machine->firmware, RX62N_CFLASH_BASE, 0);
>>> +        } else if (!qtest_enabled()) {
>>> +            error_report("No bios or kernel specified");
>>> +            exit(1);
>>> +        }
>>>       }
>>>   }
>>>   
>>> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
>>> index 6eb4eea700..17ec73fc7b 100644
>>> --- a/hw/rx/rx62n.c
>>> +++ b/hw/rx/rx62n.c
>>> @@ -245,15 +245,6 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
>>>                              rxc->rom_flash_size, &error_abort);
>>>       memory_region_add_subregion(s->sysmem, RX62N_CFLASH_BASE, &s->c_flash);
>>>   
>>> -    if (!s->kernel) {
>>> -        if (bios_name) {
>>> -            rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);

The acceptance test fails. There is some odd reset order problem,
eventually related to this discussion "CPU reset handler priority":
https://www.mail-archive.com/qemu-devel@nongnu.org/msg686362.html

>>> -        }  else if (!qtest_enabled()) {
>>> -            error_report("No bios or kernel specified");
>>> -            exit(1);
>>> -        }
>>> -    }
>>> -
>>
>> I'm confused because on the face of it these are two different models.
>> I'll defer to the domain expert on this one.

Yoshinori started to clean that here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg734135.html

> 
> rx62n is the SoC, rx-gdbsim.c instead includes the rx62n7 and rx62n8
> machines.
> 
> Paolo
> 


