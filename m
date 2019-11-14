Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7028C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8351B20715
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLZeO4OC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8351B20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVMcZ-0006fR-Ng
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 16:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iVMb7-0005JP-C7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iVMb5-0001S7-HT
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:24:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iVMb5-0001Rr-Dk
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573766650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMYVnu/QioG78ckKeCNfu19H6SmTq1Wb7xgXCYr7lS4=;
 b=TLZeO4OC4Ah0gg1QmIhE6C/wKzwp9bbpPtkZW0YZK7TkFE22TA/XYlQJvoncb+f0XG8ehU
 6/LzbDDEpmNnkzWDkCMjKKjmsRTPMZorzQuNdP5UNnSrVwvwMjjrvoSg9KOQeKRBIoIAW0
 Uno8jTZrXl3qu8WtbuhgMvvKE0gcxQY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-SoZU-bMoPYywzW-hgG0dCA-1; Thu, 14 Nov 2019 16:24:09 -0500
Received: by mail-wr1-f72.google.com with SMTP id l3so5630695wrx.21
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 13:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QwcE/DqumSPzvCi6RyJBPaw3kY/NfmaYQc3YQaxPPMk=;
 b=HbAyGfMFtJtefPAOHadr7ymJrurb2gziTlAMM8cCO00UD2jSqDnqkXXEs+NZiJ9Jm6
 niJJmlpmHBCnFyvhWqQd+abzTL7oMVtjXVZk8gI20WK4B8kJ3dF4NjTuYUJQIeLu0Bh4
 M0KwftKou9IJpr05+Tt0pVB3xA76jhv66DWcDdVDw3wZwzMv5BrDCWZQ7QROTA37iTmk
 ehM3t8+yWzOHCmou4RoGANd8LXP9wjJvog3GqGlxnKDWXmo712wLv7wV3vs5k0sSW+mK
 i5R9RZbSX/pjlM3bNHM3agLz85glD85M3KdBZ9dPh+ILo+zFiTQxvinidoi0hoWyXP3c
 j5wQ==
X-Gm-Message-State: APjAAAVqrtGnm5j27ugnrrsKx7eRg9JktHZq4RZcrwqAygLyNgvsb4Mx
 DVZH4JkooCoMEqkA98goOX/7yx0qd7MC8dSdXLSI+0lkiKBR4BMh/b2rbNor97/CzvhG3+XCZs7
 h2O6MZstsRF5q/pE=
X-Received: by 2002:adf:e28f:: with SMTP id v15mr10571103wri.130.1573766648216; 
 Thu, 14 Nov 2019 13:24:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQByTgbqPtxsG4VWwfBAQOHcuheI/vp59/mKz643WpbL+QRm3GlGOQeqp+7blcDUpGI3UsGA==
X-Received: by 2002:adf:e28f:: with SMTP id v15mr10570979wri.130.1573766647268; 
 Thu, 14 Nov 2019 13:24:07 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id v184sm7949618wme.31.2019.11.14.13.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 13:24:06 -0800 (PST)
Subject: Re: [PATCH v2 2/3] hw/mips/gt64xxx: Remove dynamic field width from
 trace events
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191108144042.30245-1-philmd@redhat.com>
 <20191108144042.30245-3-philmd@redhat.com>
 <ead1eb4b-a0e0-edf9-8323-ce9f5a291547@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bffde73d-cc1a-dcea-2e5d-7128bda7abf9@redhat.com>
Date: Thu, 14 Nov 2019 22:24:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ead1eb4b-a0e0-edf9-8323-ce9f5a291547@redhat.com>
Content-Language: en-US
X-MC-Unique: SoZU-bMoPYywzW-hgG0dCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 4:58 PM, Eric Blake wrote:
> On 11/8/19 8:40 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since not all trace backends support dynamic field width in
>> format (dtrace via stap does not), replace by a static field
>> width instead.
>>
>> Reported-by: Eric Blake <eblake@redhat.com>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1844817
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> v2: Do not update qemu_log_mask()
>> ---
>> =C2=A0 hw/mips/gt64xxx_pci.c | 16 ++++++++--------
>> =C2=A0 hw/mips/trace-events=C2=A0 |=C2=A0 4 ++--
>> =C2=A0 2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
>> index 5cab9c1ee1..6743e7c929 100644
>> --- a/hw/mips/gt64xxx_pci.c
>> +++ b/hw/mips/gt64xxx_pci.c
>> @@ -642,19 +642,19 @@ static void gt64120_writel(void *opaque, hwaddr=20
>> addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* not really imp=
lemented */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs[saddr] =
=3D ~(~(s->regs[saddr]) | ~(val & 0xfffffffe));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs[saddr] |=
=3D !!(s->regs[saddr] & 0xfffffffe);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_gt64120_write("INTRCAU=
SE", size << 1, val);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_gt64120_write("INTRCAU=
SE", size << 3, val);
>=20
> Again, this isn't mentioned in the commit message.=C2=A0 Why are you chan=
ging=20
> parameter values?
>=20
>=20
>> +++ b/hw/mips/trace-events
>> @@ -1,4 +1,4 @@
>> =C2=A0 # gt64xxx.c
>> -gt64120_read(const char *regname, int width, uint64_t value) "gt64120=
=20
>> read %s value:0x%0*" PRIx64
>> -gt64120_write(const char *regname, int width, uint64_t value)=20
>> "gt64120 write %s value:0x%0*" PRIx64
>> +gt64120_read(const char *regname, int width, uint64_t value) "gt64120=
=20
>> read %s width:%d value:0x%08" PRIx64
>> +gt64120_write(const char *regname, int width, uint64_t value)=20
>> "gt64120 write %s width:%d value:0x%08" PRIx64
>=20
> Huh, we were really broken - the old code (if passed to printf) would=20
> try to parse 4 parameters, even though it was only passed 3.=C2=A0 But it=
=20
> looks like you still need a v3.

Oops. I am surprise the compiler doesn't emit a warning here...


