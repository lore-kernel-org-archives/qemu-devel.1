Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C765EC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD2820684
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmevbgZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD2820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9ug-0006vl-HT
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is9tJ-0005ux-0x
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is9tF-0007so-En
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:29:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46248
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is9tF-0007ri-By
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579199348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7fkFnyJ97vi5GklBVKq9hju9opwZ7Tq7OW+Ppw6Qxg=;
 b=QmevbgZAYR79B/hqbKuJrEbjAJ4JP0+AkCE6X/4dkwzyJHMLyfyCf2aoKpYKWNEbvUM3ZE
 lasK10PyzwrDBGPhjOi2MdbFW1ecxqcnt1mDWuHXAlUXbGj9Pf9jMz6yLRW0erYWE1sDK6
 q4e9hnNXPWpMa5m2qSgz4Z9BWjIHPfc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-8KF7Xqx0MaiU7JUGm6iiUA-1; Thu, 16 Jan 2020 13:29:07 -0500
Received: by mail-wr1-f70.google.com with SMTP id f15so9644229wrr.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GZ1XLkSfhFj3IIcYvd9R2n76IwFJwihRIlmhN6wQ1gE=;
 b=FTFA1XjWPmcj76rGBEUox+bezkJ2ndWJaeo1LuE8D1AsOYwyrwumCag7eHCZGGVKUk
 1uCxeeARbHUm3MF2duc90DeDMuZw9aqzqxQIMB2ZniLh94XlPgXrian7ZLJIsN5OdceD
 8m4PrWV9AJLdbQQRA8oyTrE5kzYYFjDP4NCjcktWue46jXRvvVjYD2M+WxRkEBHEJ7Ov
 Bh3j+fzES7l2+dOryBwhfkpSobwkPfTOtBN/25eEqSSg7yE+VOZsZ65QMPUt/U5sOEec
 MhM9DN+4bGxo4DgNt77OC3qgxzBtnr2+5X2WlIbN+rm8s18cUNe682CVFAkrzRsTmVmw
 Drlg==
X-Gm-Message-State: APjAAAXv9QxxmXp+bXFahs//E/Wy+9C5aPYo1lwH3iQ1KRFxRIiBEFIx
 MtETi59/zlF+TdThwRAnpMvC1tDIh/y3RIJFl4SbqtnVpNRERrMmREQJEGAt9ztSeO0kqHFRRaW
 5dsu0GaHtJuPH5Hw=
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr334896wml.107.1579199345799; 
 Thu, 16 Jan 2020 10:29:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1Ek6ECnPIZOEKFBqmMOG+pmDCMVMdr6e69OM+y+SSc+2D9Hg0uS8HArUwbt1A7FNNC/djsA==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr334874wml.107.1579199345579; 
 Thu, 16 Jan 2020 10:29:05 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id l15sm29108043wrv.39.2020.01.16.10.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 10:29:05 -0800 (PST)
Subject: Re: [PATCH] spapr: Fail CAS if option vector table cannot be parsed
To: Greg Kurz <groug@kaod.org>
References: <157918715618.376249.7891210201270364781.stgit@bahia.lan>
 <ee5bcc16-2e86-a9b2-423d-bc82d327f581@redhat.com>
 <20200116171351.57fc442a@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ed534a9-e5b7-3379-489a-758a6a898cd7@redhat.com>
Date: Thu, 16 Jan 2020 19:29:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116171351.57fc442a@bahia.lan>
Content-Language: en-US
X-MC-Unique: 8KF7Xqx0MaiU7JUGm6iiUA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 5:13 PM, Greg Kurz wrote:
> On Thu, 16 Jan 2020 16:34:06 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> Hi Greg,
>>
>=20
> Hi Phil,
>=20
>> On 1/16/20 4:05 PM, Greg Kurz wrote:
>>> Most of the option vector helpers have assertions to check their
>>> arguments aren't null. The guest can provide an arbitrary address
>>> for the CAS structure that would result in such null arguments.
>>> Fail CAS with H_PARAMETER instead of aborting QEMU.
>>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>>    hw/ppc/spapr_hcall.c |    9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>>> index 84e1612595bb..051869ae20ec 100644
>>> --- a/hw/ppc/spapr_hcall.c
>>> +++ b/hw/ppc/spapr_hcall.c
>>> @@ -1701,9 +1701,18 @@ static target_ulong h_client_architecture_suppor=
t(PowerPCCPU *cpu,
>>>   =20
>>>        /* For the future use: here @ov_table points to the first option=
 vector */
>>>        ov_table =3D addr;
>>> +    if (!ov_table) {
>>> +        return H_PARAMETER;
>>> +    }
>>
>> This doesn't look right to check ov_table, I'd check addr directly inste=
ad:
>>
>=20
> I decided to check ov_table because this is what we pass to
> spapr_ovec_parse_vector() and that shouldn't be NULL.

OK, it makes sense.

>> -- >8 --
>> @@ -1679,12 +1679,16 @@ static target_ulong
>> h_client_architecture_support(PowerPCCPU *cpu,
>>
>>        cas_pvr =3D cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported,
>> &local_err);
>>        if (local_err) {
>>            error_report_err(local_err);
>>            return H_HARDWARE;
>>        }
>> +    if (!addr) {
>> +        // error_report*()
>> +        return H_PARAMETER;
>> +    }
>>
>=20
> I don't really care one way or another, but adding an error_report() is a
> good idea since linux just print out the following in case of CAS failure=
:
>=20
> WARNING: ibm,client-architecture-support call FAILED!

With some error_report:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>>        /* Update CPUs */
>>        if (cpu->compat_pvr !=3D cas_pvr) {
>> ---
>>
>> Still I'm not sure it makes sense, because the guest can also set other
>> invalid addresses such addr=3D0x69.
>>
>=20
> The point of this patch is just to avoid hitting the assertions. 0x69
> is probably bullshit but it passes the g_assert() at least.
>=20
>>>   =20
>>>        ov1_guest =3D spapr_ovec_parse_vector(ov_table, 1);
>>> +    if (!ov1_guest) {
>>> +        return H_PARAMETER;
>>> +    }
>>
>> This one is OK (unlikely case where vector 1 isn't present).
>>
>>>        ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
>>> +    if (!ov5_guest) {
>>> +        return H_PARAMETER;
>>> +    }
>>
>> This one is OK too (unlikely case where vector 5 isn't present).
>>
>>>        if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
>>>            error_report("guest requested hash and radix MMU, which is i=
nvalid.");
>>>            exit(EXIT_FAILURE);
>>>
>>>
>>
>=20


