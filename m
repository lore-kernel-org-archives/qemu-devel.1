Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D6EC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 13:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766ED20714
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 13:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJ36bk7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766ED20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYVin-0001Pf-IW
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 08:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iYVi1-0000yb-0M
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 08:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iYVhx-00061o-Kq
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 08:44:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iYVhx-00061e-8B
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 08:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574516656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mYesbVdhf9cHH3Bg3lwPkkgLdmLF+8oAUS+gqFaUwAg=;
 b=CJ36bk7II6h5II04m7tdWkCTyMFCCMETRq7lis36darin5DTL7Ja+1YmH7975GM3WvN0aU
 CzaFDiJON6ib3S8yxVd9RI8jgiPbRYkxz56KI4rwyQFpYzxutieLmt95vxE3v6ufvrU0b/
 5Ad+L3hAiumDptzdTz2UP3JKPst54uo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-rUxIVlO9OG-R2ECg_Rg4Gw-1; Sat, 23 Nov 2019 08:44:13 -0500
Received: by mail-wm1-f71.google.com with SMTP id f191so4812697wme.1
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 05:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f1EOhxUK6kDFM6O+xmC4p/Jlhtx2PkbUmXtDL33ILoA=;
 b=Dr/ry6XXjPZv5QbESGQZlH9I0jC/MViH1z5+IhlvC/zkle+8rryZfyXhH9IJVX2H8q
 h0TRlwFL5RtUfwe87rU0BkNI3QohIm9MKGoTQX4bmTuegRvDHMCkZI9WGDAKZBJDCd5K
 HkKMeull0pgmoeEeXmZviwunC00fRqy5xNKT3JSn2f4kthdFJm+2dsslnM8v9uhKcO0V
 0THH+VYOutmZi+xj265Panrfrm8JQhQfMj75MqtgwAiFvzV6a3T5WMSPoZglHx11Mn3g
 bzpfOH6oQgRKxfBliZYwDIFUaxnN7cp29lY73sRkGz5eLcyb1kzbfrW1L3jRZoqrqrWE
 R+LQ==
X-Gm-Message-State: APjAAAUDdVi2solMJRqm9kKUg3prGJ3wxtyVa/frmu5W/496hRKf+Fx5
 zhLm1ZlmjGjj3V+EovSjsrhwOUtDdtKtT7oMK81a6lGoq7gLGfu4asrxRD5yj1KRCj7v0N5wcCo
 0CbAAi7z8X5zul5Q=
X-Received: by 2002:adf:d1a3:: with SMTP id w3mr24145178wrc.9.1574516651930;
 Sat, 23 Nov 2019 05:44:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBdzg10qiP6x2nwxitB5+ed8EH+Mb7jtCQOv722he/UZ+3ZMQQE2aFMmUE21J43Qnk2Zvvqw==
X-Received: by 2002:adf:d1a3:: with SMTP id w3mr24145164wrc.9.1574516651623;
 Sat, 23 Nov 2019 05:44:11 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id d16sm2479028wrg.27.2019.11.23.05.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2019 05:44:11 -0800 (PST)
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add two files to Malta section
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <0fc4bf6b-3725-e2dd-79aa-bc5b74377b39@redhat.com>
 <CAL1e-=h1GAF-U2NO4BAU1FQ-qF7dwPE1MwgYModi6d1z=yADiQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <621e70d1-8a32-4578-29c2-6bcc903f8791@redhat.com>
Date: Sat, 23 Nov 2019 14:44:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h1GAF-U2NO4BAU1FQ-qF7dwPE1MwgYModi6d1z=yADiQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: rUxIVlO9OG-R2ECg_Rg4Gw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 9:37 PM, Aleksandar Markovic wrote:
> On Fri, Nov 22, 2019 at 9:28 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>
>>> Add two files that were recently introduced in a refactoring,
>>> that Malta emulation relies on. They are added by this patch
>>> to Malta section, but they are not added to the general MIPS
>>> section, since they are really not MIPS-specific, and there
>>> may be some non-MIPS hardware using them in future.
>>>
>>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> ---
>>>    MAINTAINERS | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ba9ca98..f8a1646 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -959,8 +959,10 @@ M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>    R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>>    R: Aurelien Jarno <aurelien@aurel32.net>
>>>    S: Maintained
>>> +F: hw/isa/piix4.c
>>
>> Maybe:
>>
>>      F: hw/*/piix4.c
>>
>> Or also add:
>>
>>      F: hw/acpi/piix4.c
>>
>=20
> Philippe, are you sure? hw/acpi/piix4.c is used in PC, not in Malta, no?

It is instantiated via:

   mips_malta_init -> piix4_create -> piix4_pm_init

The ACPI block is part of the PIIX4 chipset and should be mapped=20
unconditionally.


The Malta indeed uses a PIIX4, which is a PIIX3 extended.

The PC uses a Frankenstein PIIX3 with ACPI from PIIX4... I suppose=20
because it started with a PIIX3, then we wanted power saving features=20
but it was too late to switch to the PIIX4, so we abused of the fact=20
than these blocks are exposed internally as PCI devices, so we can=20
overload a PIIX3.

See https://www.mail-archive.com/qemu-devel@nongnu.org/msg601512.html


FYI I have a patch ready removing the 'if smbus' check in piix4_create().

>>>    F: hw/mips/mips_malta.c
>>>    F: hw/mips/gt64xxx_pci.c
>>> +F: include/hw/southbridge/piix.h
>>>    F: tests/acceptance/linux_ssh_mips_malta.py
>>>
>>>    Mipssim
>>>
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>>


