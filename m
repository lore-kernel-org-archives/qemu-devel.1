Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B5CC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3BF20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJaxCQmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3BF20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipEq4-0000XP-LR
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 12:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ipEnK-0005a9-HI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ipEnI-0001nQ-0y
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:06:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56087
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ipEnH-0001m7-M2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578503214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xljsfmVNGPNxuk7FDMgcbUPbIKzv4OpYgcxiC9c3Lno=;
 b=OJaxCQmUMBejEx6xTaCwPcXX6xUDfIyLxTDj+skK1hjzeuzWsQCWDRstM4Se3gc/419mkm
 AATdLjPk/U04YCaFZ+XFfWjfheQZ8e0l9z8XH7FAc6IZ9dmvb40qNiDUvcKugvQVj1aBeq
 rzNDQKWEqlrbcCnx6POaITJ/IYEMIMY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-n_4N2NhPNreAV-DaA1TYSw-1; Wed, 08 Jan 2020 12:06:51 -0500
Received: by mail-wr1-f72.google.com with SMTP id k18so1690319wrw.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 09:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d8eTdDIXvxWUlzXdJJ4soe0bL5qfH7LzvgLtD3JYCIk=;
 b=E/gAt47b0PBcMlyd09stshvAI5dMyJDT6f/PGw1cEaUayhveqtzeZgZT7mxYfO8hGb
 ElEoEfNpxtvlYLPCDD7GbnAt2rmTuqZEPEWqYpoW5N2FEVfJZGYEnm4srC9whF5zE7Af
 kDAmjEy3mLcW9/DiMs3XxYpNlO5Vr+C45lY036j0Kf/KE56M3sVNlDKuQTmF1P3mh+I4
 OzY5ANLWeYJ9lpHr5VU8bGe5oulotbwDAI9hgvXxXN0VffWeif13Z55sXmJgSf/5xLdn
 m8Wnl1xKq/2N5GQu2m4rpXes/rYw9AUW3wi5xh52mWBSa9EreQ0tn4p3JoIrhe1tM/vq
 9hdg==
X-Gm-Message-State: APjAAAUuQH2izN0g7D2QP1LcmsdWPe6hyGSdTGcRXEZgDLDhH/I75snK
 +PoOAtPVOXltly36XyVYWhnVf01aV0YC2JU3xsyt/IgnJ/n+2qjucU6fnOpXXLcASWNdd2pdD/D
 +mG2LOEKM4LOUPR0=
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr5845607wrm.241.1578503210120; 
 Wed, 08 Jan 2020 09:06:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuXgbKZNKJPmZO9w18p2izGIUU/89C3bgo7ZOhc6RWuLqQ8WhbM9Fg5CiFEqStZqMVdVkRIA==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr5845577wrm.241.1578503209899; 
 Wed, 08 Jan 2020 09:06:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id n189sm4662479wme.33.2020.01.08.09.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 09:06:48 -0800 (PST)
Subject: Re: [PATCH v2 1/3] misc: use QEMU_IS_ALIGNED
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-2-marcandre.lureau@redhat.com>
 <2668c259-8ee9-06eb-9d7e-c09ca12aace4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a135ce07-a9ef-6d32-4119-4aca8dc65dfe@redhat.com>
Date: Wed, 8 Jan 2020 18:06:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2668c259-8ee9-06eb-9d7e-c09ca12aace4@redhat.com>
Content-Language: en-US
X-MC-Unique: n_4N2NhPNreAV-DaA1TYSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Juan Quintela <quintela@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/01/20 08:43, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/3/20 8:39 AM, Marc-Andr=C3=A9 Lureau wrote:
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>> =C2=A0 exec.c=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0 roms/SLOF | 2 +-
>> =C2=A0 2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/exec.c b/exec.c
>> index d4b769d0d4..1feda49ca1 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -3895,7 +3895,7 @@ int ram_block_discard_range(RAMBlock *rb,
>> uint64_t start, size_t length)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *host_startaddr =3D rb->ho=
st + start;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if ((uintptr_t)host_startaddr & (rb->page_siz=
e - 1)) {
>> +=C2=A0=C2=A0=C2=A0 if (!QEMU_PTR_IS_ALIGNED(host_startaddr, rb->page_si=
ze)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("ram=
_block_discard_range: Unaligned start
>> address: %p",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host_startaddr=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err;
>> @@ -3903,7 +3903,7 @@ int ram_block_discard_range(RAMBlock *rb,
>> uint64_t start, size_t length)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((start + length) <=3D rb->used=
_length) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool need_madvise=
, need_fallocate;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (length & (rb->page_size =
- 1)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!QEMU_IS_ALIGNED(length,=
 rb->page_size)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report("ram_block_discard_range: Unaligned length:
>> %zx",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 length);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto err;
>> diff --git a/roms/SLOF b/roms/SLOF
>> index 9546892a80..8ebf2f55e1 160000
>> --- a/roms/SLOF
>> +++ b/roms/SLOF
>> @@ -1 +1 @@
>> -Subproject commit 9546892a80d5a4c73deea6719de46372f007f4a6
>> +Subproject commit 8ebf2f55e1ba1492b942ba4b682160e644fc0f98
>=20
> Without the SLOF submodule update:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Also without the SLOF update:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


