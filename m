Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D51C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40589205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0isFY/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40589205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jECoJ-0005jP-F9
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jECn7-0004zp-SW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jECn6-0001DV-La
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:01:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22251)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jECn6-0001Ay-Gv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584453716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fjqAwTuU/pxothbsgzA3Iu8zWzuLxsk/MI79OfMHP4=;
 b=d0isFY/Q5/i+BCYVXc3cP8hQTyYnHlSHgPLV7KYALzSKqL/vpObPWzM3XRnz/+5pA23aQ0
 wLalmiYPQT5Rzi52DXbDT0w6Ag1vGljssqRPOrdOpi5bdKEdK92SXgzB+qli6KfWVdVJkw
 MTN08pMk8RfDIII9AmUkpbcaxSvzU2M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-jNjCPD-3NMir947lXdoh-Q-1; Tue, 17 Mar 2020 10:01:51 -0400
X-MC-Unique: jNjCPD-3NMir947lXdoh-Q-1
Received: by mail-wr1-f71.google.com with SMTP id k11so2072719wrq.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 07:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kxl1EfFl/soPuExGHjrlU88uVGUD3q5GopKVDeFc4EU=;
 b=qB0HwBqzgo7N3rFAYSb3mO7m+KESypDiZW3np6ApkjCm8/qrSOC0XgtYRNnhxdY2tR
 lQTi7dccqzWdLOIwo96bcCCW6XvNr+Die6Uw4UlbtwOislXS63z8+rIMCS4bGhycUsGj
 H8VTtiKVxjqREM6PFXuOZyKqKpUMxTMac9vEmaZyG8hCir7UfYh7+VWxfLNiRC9Y912N
 2+HSeLTehlolMBw+0L/E7IQ79DsUbhS9jrC1EoRCtT+A3aThHFR1N3zGO8YKwIPlpZZg
 bVm0XdOTNKiMKlIS+pbxQHNCUj8AOH9UI4bDG1k66VNN/KRqEZyB59R9u/mr4Mi9Okyg
 ePZA==
X-Gm-Message-State: ANhLgQ2Z3xyWxvZZrgiqgx/jgUVct3tUl8qJHEtAfawIslMLZJ6m/8KK
 69RHweoPudpXwUNppl3LD25+HCjgxAvAeQpwYZRFq8Vg3EGIyrTsorsDTE46BGI+P6VZ5nI0YWU
 3uY4YH0X8Om8KYZA=
X-Received: by 2002:a5d:4484:: with SMTP id j4mr6696315wrq.153.1584453710014; 
 Tue, 17 Mar 2020 07:01:50 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu3UntdUqqGwuxy5TZaA1DQAmrKd7B65YvGYy05yrHkDRTIv13zUMtCbxJs891cRJXM/DxRCQ==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr6696295wrq.153.1584453709761; 
 Tue, 17 Mar 2020 07:01:49 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id t5sm4006626wmi.34.2020.03.17.07.01.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 07:01:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] hw/ide: Get rid of piix4_init function
To: John Snow <jsnow@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <cover.1584437957.git.balaton@eik.bme.hu>
 <3240656814c804513de08bdbbf318f2f590df241.1584437958.git.balaton@eik.bme.hu>
 <c43e2f9b-3002-32f0-08fa-7164a98f3b9f@redhat.com>
 <f70ea487-c8e8-d76d-fbe5-9213284a8574@redhat.com>
 <2038186d-3f18-d430-2305-5697097397e9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <549ffd77-a020-51c8-96e7-c4afc28ff633@redhat.com>
Date: Tue, 17 Mar 2020 15:01:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2038186d-3f18-d430-2305-5697097397e9@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 2:50 PM, John Snow wrote:
> On 3/17/20 6:49 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 3/17/20 11:41 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 3/17/20 10:39 AM, BALATON Zoltan wrote:
>>>> This removes pci_piix4_ide_init() function similar to clean up done to
>>>> other ide devices.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>> Please disregard this tag (I withdraw it), I mis-read the pci variable
>> was not assigned.
>>
>=20
> Is there an issue you've noticed, or you are just no longer certain
> enough to give an RB?

I asked Zoltan there why he was reassigning 'pci' and he replied here:
https://www.mail-archive.com/qemu-block@nongnu.org/msg63324.html

I don't know enough the PCI API (and don't have time this week to dig=20
into it) to check how pci->devfn is used (is it populated by a=20
pci_create() call?).

     pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
                                           true, TYPE_PIIX4_PCI_DEVICE);
     ...
+   pci =3D pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");
     ...
     pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");

What annoys me is here -------^^^^^^ I don't know if reassigning the pci=20
variable can have an impact, so as I am not confident I prefer to=20
withdraw my review tag.

Since the patch already has 2 R-b I'm not going to NAck it neither.


