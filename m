Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770BDC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446CC206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZlEv6bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446CC206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxao5-0005rR-KF
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxanR-0005Qb-KD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:45:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxanQ-0007F0-49
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:45:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id z2so18896050wrp.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2TF7Z/qd2uPvQq9OP80Xocngn74bXUeDUl9O+E2tyl0=;
 b=JZlEv6bxK/BIaO0b3g0aiEDqOpYxBBnyT8NrosGBqffNuac/GEKrNkklBL/JwAoaIx
 T0+9t/AYE93TRZJtLbeD73vEvrStNHQi9UeTVZFlUbV9TjeHAnnePfgYQBuQ8MoB/H9R
 Kj7NRIbnTyAEzfJVhnVk+0g911fOnl+nudqCPHEPEO6YUx3kU1068kvOvN55e24VWsV4
 JZMmzASkSNkd/eRqTYOQ6lBieDM10aeaLLY9O/SFAoP/rXqcxefzh7wDIiCocZ/QymqD
 9oZW4YuAuZmMYp0qI+QsdW6EgocuYo/BMQxuzgrwzKLYqCMKycZ68K++dbwBq1FZuui6
 bpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2TF7Z/qd2uPvQq9OP80Xocngn74bXUeDUl9O+E2tyl0=;
 b=e0EpNyjgjTz25pax+QQ8M6uq6e41faxlU6vdaVEhFbAZnYO1wDVg48IIbIDVrZdLlO
 L/2iYyC9H4pOltPqJQTIiLCN7KHpvS5D6dRknvMvQeSQZc/cpn49ssdjaLcvxu7DJUMA
 VH1ivmbEzhOXjDTeFt8OdFoMYPxBjjKcA6TPBypAW+nVOYh4ubm71xSw4o2ha0BKruwX
 lJCTK+DeH1drbNLVsWLYOtlGOZnMaCbRzE57dqUC3MW2KYLIfATzJD7ljmsIot2Bsx4F
 p7zbn+Xg64KYDb0tIFv8zu7yfHBOfAYQMitN0VLz4iUl/WMt8jXgv3y1IXbaylqSaMC+
 nOuQ==
X-Gm-Message-State: AOAM530GotrWllaEILHDrSI6o885yPvGpTgQeGIG9xyqXTg0XTlDzwbF
 NW+XmfESWxQV5wfLTOQhvsc=
X-Google-Smtp-Source: ABdhPJzZjyEQ0+yYMkraPVTc4M9BYw1qIBBxVZJM1kvMGk5Uk7fej8vL4f6ToHQ7V5ZEGbyRnGIKdQ==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr23289680wrp.412.1595270750581; 
 Mon, 20 Jul 2020 11:45:50 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d14sm2043907wre.44.2020.07.20.11.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 11:45:49 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 4/4] hw/avr/boot: Fix memory leak in
 avr_load_firmware()
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200714164257.23330-1-f4bug@amsat.org>
 <20200714164257.23330-5-f4bug@amsat.org> <20200720141806.GI643836@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3e60e1b3-055e-04ef-1de3-bd030646e0aa@amsat.org>
Date: Mon, 20 Jul 2020 20:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200720141806.GI643836@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Sarah Harris <S.E.Harris@kent.ac.uk>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 4:18 PM, Daniel P. Berrangé wrote:
> On Tue, Jul 14, 2020 at 06:42:57PM +0200, Philippe Mathieu-Daudé wrote:
>> The value returned by qemu_find_file() must be freed.
>>
>> This fixes Coverity issue CID 1430449, which points out
>> that the memory returned by qemu_find_file() is leaked.
>>
>> Fixes: Coverity CID 1430449 (RESOURCE_LEAK)
>> Fixes: 7dd8f6fde4 ('hw/avr: Add support for loading ELF/raw binaries')
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/avr/boot.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/avr/boot.c b/hw/avr/boot.c
>> index 6fbcde4061..151734f82d 100644
>> --- a/hw/avr/boot.c
>> +++ b/hw/avr/boot.c
>> @@ -60,7 +60,7 @@ static const char *avr_elf_e_flags_to_cpu_type(uint32_t flags)
>>  bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
>>                         MemoryRegion *program_mr, const char *firmware)
>>  {
>> -    const char *filename;
>> +    g_autofree char *filename;
> 
> Any variable marked g_autofree or g_auto must always be initialized
> to NULL otherwise there's risk of free'ing uninitialized data. Even
> if currently safe, any later refactoring could turn it into a bug.

TIL, thanks :)

> 
> So iff "= NULL" is added:
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> Regards,
> Daniel
> 

