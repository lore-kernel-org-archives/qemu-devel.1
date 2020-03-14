Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33550C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B9D2074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anfM78Rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B9D2074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD29i-00020c-TI
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jD28t-0001B8-8T
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jD28s-0000Wl-Am
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:27:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57563
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jD28s-0000Vg-67
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584174453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/SA1V/AUcqNQiNqmh3zq2HzpbKLYphKvzfkhXJFJgfw=;
 b=anfM78Rm2Df+6BSq3fwN+i9IuQMWWSxsrMEuKjm9Qo8NDCFQbIYs4VaurIGH9Vy/ApGszh
 n+CBMUNr3uzNjavBzBsME/d2zSQVup4wmX9aduPr/aYNeiqpDXFCDXZ+r7Lyr7hyHnmHRU
 kdXJvAq6VcSqwm1IFaqkAPtugGOvqLo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-Vy19727RM3mJD6YnNEqGfQ-1; Sat, 14 Mar 2020 04:27:31 -0400
X-MC-Unique: Vy19727RM3mJD6YnNEqGfQ-1
Received: by mail-wr1-f72.google.com with SMTP id x14so5573483wrv.23
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HjvanUfPksQl++xVgrNCOimtflzJz62BfwIfjKNLpqo=;
 b=nW5/4qycIVGypr6CZB9ufLZBGqlcoLV5z15oAJcNX91iyjYMcuFtjgD+dWzL3DnlJx
 JEjEmmIQpv+k0X5Fiel60YNrca8vvx5aitHsm+O4ZH6FI2KREXta2m7ZScGu24lEZyPJ
 KFPwxNp3BAG/eUVh1SKCA/+A7bmmSATRgZS14YVVcegQlch9rLVwT43cVNkgD65iWvfl
 1pm9Y29ayl4Y9gfbQsptn251mQeTn7Igg9mT8+3BdNcF3RK5joscJ22GzvOA23QkXmt+
 jHER6s7fNvG0vYTx8ilQqUUY7NtdikQFUEU4HjWqO6RGUW5keC89iskWMJbtQMsio3UR
 zx1A==
X-Gm-Message-State: ANhLgQ2LBeV4gD0XA7zMiTZkRd/z4pThtR0kRRYHzBhaaLwR+TqeWiAL
 MU8NiLt0oPldhnEGvhqSyQKSd6wZEhn+kwPn68cpqXwiUJuR5wvCnwZtEC/2kzwIu3Ra6tRyK8v
 noQA755zvVIDaVRg=
X-Received: by 2002:a1c:408b:: with SMTP id
 n133mr14628521wma.182.1584174450557; 
 Sat, 14 Mar 2020 01:27:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vukYgAt3LeTeUs5ve7IUL9atv7Lp8NwlKc1cgDdNJ4FjT2qbZxVHq7O4PYDQraOVed1fNfUmw==
X-Received: by 2002:a1c:408b:: with SMTP id
 n133mr14628501wma.182.1584174450372; 
 Sat, 14 Mar 2020 01:27:30 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id w81sm20099934wmg.19.2020.03.14.01.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:27:29 -0700 (PDT)
Subject: Re: [PATCH v3 15/16] hw/i386/vmport: Add support for CMD_GETHZ
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-16-liran.alon@oracle.com>
 <97784452-8270-e0ab-1164-d3a9fe567006@redhat.com>
 <5a1a347a-102d-2c1e-bb27-e5b05408eb4a@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2ab2600-3f52-46c5-04d4-67d9c554e2c2@redhat.com>
Date: Sat, 14 Mar 2020 09:27:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5a1a347a-102d-2c1e-bb27-e5b05408eb4a@oracle.com>
Content-Language: en-US
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
Cc: pbonzini@redhat.com, Nikita Leshenko <nikita.leshchenko@oracle.com>,
 rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:44 PM, Liran Alon wrote:
> On 13/03/2020 22:07, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 3/12/20 5:54 PM, Liran Alon wrote:
>>>
>>> diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
>>> index 34cc050b1ffa..aee809521aa0 100644
>>> --- a/include/hw/i386/vmport.h
>>> +++ b/include/hw/i386/vmport.h
>>> @@ -12,6 +12,7 @@ typedef enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_DATA=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 39,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_STATUS=C2=A0=C2=A0 =
=3D 40,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_COMMAND=C2=A0 =3D 41,
>>> +=C2=A0=C2=A0=C2=A0 VMPORT_CMD_GETHZ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 45,
>>
>> Can you rename to something easier to read, such _GET_FREQS_HZ or nicer?
>>
> I actually prefer to stick with names similar to open-vm-tools. i.e.=20
> Similar to the definitions in lib/include/backdoor_def.h.
> This helps correlates a command in QEMU code to guest code (in=20
> open-vm-tools) that interacts with it.

Well, we don't have to follow bad examples ;)

> I can rename to just VMPORT_CMD_GET_HZ (Similar to what you suggested=20
> for previous commands).

Thanks, this makes code review more easier.

> But I don't have a strong opinion on this. If you still think=20
> _GET_FREQ_HZ is preferred, I will rename to that.
>=20
> -Liran
>=20


