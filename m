Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B55C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6C220678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rm06D77b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6C220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioluJ-0003Nj-El
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iolkY-0006oS-Se
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iolkX-0003me-Kr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:06:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57947
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iolkX-0003mJ-Hd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578391569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roNAOiTxMppecbI18fA9nXaIrsoN69+V7CraW+NnxYw=;
 b=Rm06D77bPV51Tm2qgIhaaHs77GiYA9dSAbIHaqtc53XTtw6ql8ESy3tBnBU2yJtLSTaGac
 eBjSG8kFQM0gWyvW06N1hElS/56TuvbwPsWlS9zHZGsn1WjIwkNaM6Zlssw5MB623GNaG3
 GUxyMhb2a66B7Q1k/CMA1l0qbxAXS00=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-iOwT4B98P5OaPkw5PYUTtw-1; Tue, 07 Jan 2020 05:06:06 -0500
Received: by mail-wm1-f69.google.com with SMTP id p2so3892527wma.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YgbBebsjUiDfwbSwnShoFApHftPg1MQ5BFE0eYrMKNs=;
 b=kt4oDJBDcIzuvQnrVR1oP+oeezVmBkyZD2SKmIRBiFxeCAlFMkb+bau/QUq6s2711J
 PUkXOfTaKjaJ03ClrtRf9ceQizFEo0DayVw9Uf1nzA9gbWlM1Pkpn1CpgBL3y0Y5GTky
 5Wef4PAashvnleERzYrudKuOuZfTyCkkZ54I/5p+HQ4gYF278+zpNPPVPQynx87p5Yrn
 d9sz+ZXJo7s63V6zJv8yV8bOwFHya7LmDRrwhT61TmI4p/b1CZzbwx/G4J7X242HEnZw
 p5qRg36fgPJP8zhpWUTwmCNwxUCCwYoN9kmL1LTj2pPrIzUCO3lCL8TJu36SYliOC08A
 XOyg==
X-Gm-Message-State: APjAAAX5Gty7kMSKzkbueHEjYbLgiv3LsIZbs8ZDnihQKLu29daa34jl
 806lUXh8QF0Dijl2IwamKuXsWsLCTWrNQtvBo8/m45/VkSA7IMLXc1yb5NNhPfzzwM2ilsNZ48E
 DS+4eJ1CLd0FQ0Pg=
X-Received: by 2002:adf:806e:: with SMTP id 101mr6293246wrk.300.1578391565406; 
 Tue, 07 Jan 2020 02:06:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhpQTHIoua4bWFUT/1keFePqRsttC844B+HKL9AFvKlUXi+O6DHyMOHHvckpaUxZIwS3xsVg==
X-Received: by 2002:adf:806e:: with SMTP id 101mr6293210wrk.300.1578391565184; 
 Tue, 07 Jan 2020 02:06:05 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id f12sm26154981wmf.28.2020.01.07.02.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:06:04 -0800 (PST)
Subject: Re: [PATCH 03/14] hw/i386/Kconfig: Let the MicroVM machine select the
 SERIAL_ISA config
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-4-philmd@redhat.com>
 <cf08bcf8-d0f2-e3ac-c4b4-946f268d8fa1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6287357d-fb82-bf05-c3bf-690aab5f116e@redhat.com>
Date: Tue, 7 Jan 2020 11:06:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cf08bcf8-d0f2-e3ac-c4b4-946f268d8fa1@redhat.com>
Content-Language: en-US
X-MC-Unique: iOwT4B98P5OaPkw5PYUTtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 11:00 AM, Paolo Bonzini wrote:
> On 31/12/19 19:32, Philippe Mathieu-Daud=C3=A9 wrote:
>> When configured with --without-default-devices, the build fails:
>>
>>       LINK    x86_64-softmmu/qemu-system-x86_64
>>    /usr/bin/ld: hw/i386/microvm.o: in function `microvm_devices_init':
>>    hw/i386/microvm.c:157: undefined reference to `serial_hds_isa_init'
>>    collect2: error: ld returned 1 exit status
>>    make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
>>    make: *** [Makefile:483: x86_64-softmmu/all] Error 2
>>
>> While the MicroVM machine only uses the ISA serial port when the
>> MICROVM_MACHINE_ISA_SERIAL property is set, it has to be linked
>> with it. Replace the 'imply' Kconfig rule by a 'select'.
>=20
> I added a comment "# for serial_hds_isa_init()" here.

Sounds good, assuming the microvm might become more modular later.

>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Sergio Lopez <slp@redhat.com>
>> ---
>>   hw/i386/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index e428322a2c..cbcfb1ce81 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -96,7 +96,7 @@ config Q35
>>  =20
>>   config MICROVM
>>       bool
>> -    imply SERIAL_ISA
>> +    select SERIAL_ISA
>>       select ISA_BUS
>>       select APIC
>>       select IOAPIC
>>
>=20


