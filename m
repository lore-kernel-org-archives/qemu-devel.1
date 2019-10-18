Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4605CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902AB21925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nBUrreQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902AB21925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLZ5J-0005m2-MC
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 16:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iLZ4E-00054a-SF
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iLZ4D-0005Vh-HK
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:41:46 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iLZ4C-0005Ut-R6
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:41:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id u20so3402934plq.4
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=MLz7DnVdESSnmHkJ4Sc37niu2QQkAm0+3fXFiaPQXJE=;
 b=nBUrreQkpUmAByHTWzfYZfkEGqXWMHJQFbN8qUEEMbeXllXlYEPkqRlyhxjkgJ2WwG
 R81fX8RtoNq4rFEluaBHBvjkzQ96rjPvUjkvEJ33osihmy+GKjaLnd/MfRJ/fwtxztiL
 /Kx73p+cQOlkNYujrc/1WzhotFJ19KPs2WvSR/MUWvPWgCBWt75XQnlQ8g3GFMwkWNdw
 Fsxlfft9WVSjMPtGhIH+LILnNiOP91xNbVbSDrS3CXuYfLka77k1mUVVxVC/hQkhWAEY
 4WmiVXxZl66CyYOJn+tDkxKbnaVxgV4w1EGqjsnUD+iu1hiUFEs4VXv9KWUN3V10sY7z
 L+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=MLz7DnVdESSnmHkJ4Sc37niu2QQkAm0+3fXFiaPQXJE=;
 b=kgrx+HCe1e6QemF40OylB/W44SYeGI8RlIeeVOGh7RSmAYvD4AAMKzO9pYfMoOL9DS
 AfEFjgVIqm2OT+Tuym/TNYpegGKxD5GoiP6zXA2nipcWHGtmrAgK7LtxRhrPR1uz2OOZ
 HJv5w5CmN7S+j6pRKjxgyraPLqIyayheeDb2oO5RtPoSbllTe2MRBXc4e1dzDLaIRMNW
 ZjW4XTFBrcBLovOkMXP/d3dLiO1miNVfu79bRYC5HHFGiD0dLhnkStD4CHxjeS1JH4GI
 tas2qcFiBB8nX1DzfSS5GQnBDUcCx53xzTCZXtGYfZqlr+tkZHP6JZsQJgjhwJEWPFwu
 xRzQ==
X-Gm-Message-State: APjAAAVoiOXsGG8TuTNr2xzWu93BQ81YZDkc1tGaDDh8GzCqr4Mb/0fm
 zMGag9P9aKJpLhFN/oIgKkpt4g==
X-Google-Smtp-Source: APXvYqxHXvByHlY/eL1PwTCF/HIST0o6FRRo+d+t8Wi36ji+gjjirg/0PkVTMNmGqJpdm1mh2R0zrA==
X-Received: by 2002:a17:902:8542:: with SMTP id
 d2mr11829756plo.86.1571431303381; 
 Fri, 18 Oct 2019 13:41:43 -0700 (PDT)
Received: from localhost ([152.179.112.46])
 by smtp.gmail.com with ESMTPSA id m12sm8965342pff.66.2019.10.18.13.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 13:41:42 -0700 (PDT)
Date: Fri, 18 Oct 2019 13:41:42 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Oct 2019 13:40:14 PDT (-0700)
Subject: Re: [PATCH v2 1/1] riscv/boot: Fix possible memory leak
In-Reply-To: <CAFEAcA_Sk2VFxxHV92RpaaRt3MLY2n_xYYM7CSwTTcxLDVtsgg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <mhng-91e0cd9d-237f-4dce-9ebf-2cc863c1b012@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 05:08:39 PDT (-0700), Peter Maydell wrote:
> Ping? It would be nice to see this patch get into master
> to silence the coverity errors.

Sorry, it looks like I dropped this.  It's in my queue, I hope to submit a PR 
soon.

>
> thanks
> -- PMM
>
> On Thu, 3 Oct 2019 at 18:05, Alistair Francis <alistair.francis@wdc.com> wrote:
>>
>> Coverity (CID 1405786) thinks that there is a possible memory leak as
>> we don't guarantee that the memory allocated from riscv_find_firmware()
>> is freed. This is a false positive, but let's tidy up the code to fix
>> the warning.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v2:
>>  - Fix commit typos
>>
>>  hw/riscv/boot.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>> index 2e92fb0680..7fee98d2f8 100644
>> --- a/hw/riscv/boot.c
>> +++ b/hw/riscv/boot.c
>> @@ -38,7 +38,7 @@ void riscv_find_and_load_firmware(MachineState *machine,
>>                                    const char *default_machine_firmware,
>>                                    hwaddr firmware_load_addr)
>>  {
>> -    char *firmware_filename;
>> +    char *firmware_filename = NULL;
>>
>>      if (!machine->firmware) {
>>          /*
>> @@ -70,14 +70,11 @@ void riscv_find_and_load_firmware(MachineState *machine,
>>           * if no -bios option is set without breaking anything.
>>           */
>>          firmware_filename = riscv_find_firmware(default_machine_firmware);
>> -    } else {
>> -        firmware_filename = machine->firmware;
>> -        if (strcmp(firmware_filename, "none")) {
>> -            firmware_filename = riscv_find_firmware(firmware_filename);
>> -        }
>> +    } else if (strcmp(machine->firmware, "none")) {
>> +        firmware_filename = riscv_find_firmware(machine->firmware);
>>      }
>>
>> -    if (strcmp(firmware_filename, "none")) {
>> +    if (firmware_filename) {
>>          /* If not "none" load the firmware */
>>          riscv_load_firmware(firmware_filename, firmware_load_addr);
>>          g_free(firmware_filename);
>> --
>> 2.23.0

