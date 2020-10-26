Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1E5C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148DD20809
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3ouaDVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148DD20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6y7-0006DQ-UH
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX6OA-00030u-Ke
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX6O8-00028G-Or
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603733671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPfiA+YBWBs48plVx8bAfP36wVADlIy2M62PRzsdiuc=;
 b=Z3ouaDVwhHFaxxLEZpaqMrBqKy5itOSdGAfd5aJqK/zv0jPeNWPxz7RAIdPHZ0stqyNcvY
 m0uWOhoWhnZ0TYM7MoDbQxJ9Wxj1dbVz7w6NZgL1S7tjame4hctmJhUnq9n1IMMOOtpUHz
 LVFH23dLo96hom+YY0dNQYKMtY5PCP4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-glGZL8EfOD2CgPZO9dPUOA-1; Mon, 26 Oct 2020 13:34:30 -0400
X-MC-Unique: glGZL8EfOD2CgPZO9dPUOA-1
Received: by mail-wm1-f70.google.com with SMTP id l23so6218761wmg.6
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EPfiA+YBWBs48plVx8bAfP36wVADlIy2M62PRzsdiuc=;
 b=QIc3yrVvCTqEf6119oGZp+Np58cw8GCkUBxc/ZeRPb0pKs0mSony6SWMT35R0fD2tw
 8Q3z4x/tkrauFTwiqwn/6pfWBfVlmdU140Tf8ztCpM4yGjZ0wENYacegnDkybiPqTC0R
 ZTuArBtX/T5hlKhZWF6bEMFzY9LOGXZqBSuKzIeaM7Gk+SJZiE49pdGCwLFVEfgh/LqH
 yI0OGaKbS2Bmz2DfgUKvSZZ1sl6BU5SW27nxVPL0VmEg4wYW0SERhdrzBKvKm9lhUwLh
 aAyOXSIrH8C3ji8ESnAB+k9PHuMlBrjQlmim3o6DEuGsICeiYCSwPj9BlcmJnZmhH1Qm
 U1BA==
X-Gm-Message-State: AOAM533f2oGGLLs8ihOy/j8jadyQpC8J/+UsyytsPL2pveqmlEkL/qKC
 rzrr5vH8ejGL9/n8EBMQO2xqHVlF+ZHEg938kCi1xLeltt8WytbyRrprGko/JYk6M9u7Wi1dBq+
 o9vCgAtOVqzeaTyk=
X-Received: by 2002:a1c:a749:: with SMTP id q70mr1632666wme.117.1603733668729; 
 Mon, 26 Oct 2020 10:34:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztV7Fg+WJrSo6PyjJrfX5fXl8/SNhrqQkkp8VMgkSYI899xcGkGhv9DRP0r9drxjx3WckGAw==
X-Received: by 2002:a1c:a749:: with SMTP id q70mr1632647wme.117.1603733668542; 
 Mon, 26 Oct 2020 10:34:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id y201sm10202716wmd.27.2020.10.26.10.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 10:34:27 -0700 (PDT)
Subject: Re: [PATCH 11/15] rx: move BIOS load from MCU to board
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-12-pbonzini@redhat.com> <87lffsgas5.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53ddb690-db6d-cfce-ee9e-c274b18bfaa0@redhat.com>
Date: Mon, 26 Oct 2020 18:34:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87lffsgas5.fsf@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/20 18:24, Alex Bennée wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> The ROM loader state is global and not part of the MCU, and the
>> BIOS is in machine->firmware.  So just like the kernel case,
>> load it in the board.
>>
>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hw/rx/rx-gdbsim.c | 7 +++++++
>>  hw/rx/rx62n.c     | 9 ---------
>>  2 files changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
>> index 417ec0564b..040006c1c5 100644
>> --- a/hw/rx/rx-gdbsim.c
>> +++ b/hw/rx/rx-gdbsim.c
>> @@ -142,6 +142,13 @@ static void rx_gdbsim_init(MachineState *machine)
>>              /* Set dtb address to R1 */
>>              RX_CPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
>>          }
>> +    } else {
>> +        if (machine->firmware) {
>> +            rom_add_file_fixed(machine->firmware, RX62N_CFLASH_BASE, 0);
>> +        } else if (!qtest_enabled()) {
>> +            error_report("No bios or kernel specified");
>> +            exit(1);
>> +        }
>>      }
>>  }
>>  
>> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
>> index 6eb4eea700..17ec73fc7b 100644
>> --- a/hw/rx/rx62n.c
>> +++ b/hw/rx/rx62n.c
>> @@ -245,15 +245,6 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
>>                             rxc->rom_flash_size, &error_abort);
>>      memory_region_add_subregion(s->sysmem, RX62N_CFLASH_BASE, &s->c_flash);
>>  
>> -    if (!s->kernel) {
>> -        if (bios_name) {
>> -            rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);
>> -        }  else if (!qtest_enabled()) {
>> -            error_report("No bios or kernel specified");
>> -            exit(1);
>> -        }
>> -    }
>> -
> 
> I'm confused because on the face of it these are two different models.
> I'll defer to the domain expert on this one.

rx62n is the SoC, rx-gdbsim.c instead includes the rx62n7 and rx62n8
machines.

Paolo


