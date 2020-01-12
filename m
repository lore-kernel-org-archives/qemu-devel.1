Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48062C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 13:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123B52084D
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 13:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiSNdyd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123B52084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqdZF-0004ER-4p
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 08:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iqdYL-0003UL-Pn
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 08:45:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iqdYJ-00086E-6F
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 08:45:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iqdYI-00080b-Pm
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 08:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578836713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PP484GAI63WNDjZkwFWIiKuFUOgs+ZDNSgseBWrZ9JQ=;
 b=LiSNdyd+rxJanl/Tp48k6Z4UAs23wtgOXY2kkndnH2iAhXe+2ZfjokRIqyJOnWuyQ60gHZ
 jkwVd/1BFYdWEPAkuurQrskFpXUx6ohFmt76RIUg/JACo4BfENCJdMfcy7IrCHM2NEq0IJ
 jJIBRBodtXlNGkO/tnJIuRFV1oP0JLk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-gvj4Vg98O2m1SdZBwIIdjQ-1; Sun, 12 Jan 2020 08:45:12 -0500
Received: by mail-wr1-f71.google.com with SMTP id j13so3619782wrr.20
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2020 05:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JFL2PZFkYCUq9EBkZ1f9ZZgtG4mRI3t6MhkcDGaPmQA=;
 b=BNAcVNdgJYbZsRuDHIPYdUxvV/jTvE8T/HRcysHIIsazeSm1zOK0cx9A42D35efovU
 I+IKGfbZDL9KLSiqhrraKT1CNfJ4N1JjZcpcFgfMR9SaCfp9NRhzt9liYwVh1cZttsqX
 7cwsxy+unKiDiensu7H0j2lg07Rrv/SzEJORsis7bJI/2xXQHpB49e7AuSlf4pYwZLQF
 XjEqqO80Lg0GKXHJ8okexsNSCTES/ULgjz2uWiHC86JYxyTPLZU+zwzW1qBzSXsZGUK+
 XU3IAXHXoOGblmadER2DCKUOG9uOgWvvg94tMs12sWgYDZSK2cAxrStWVtHAoQNl/CAZ
 YFMQ==
X-Gm-Message-State: APjAAAWe0U9bE0bdV+505MbB2MZU+UBMIS8B+21GfKhYAf6rLpQ7c53y
 fupjY25bc2PgNGhHrD1GrgsQ+hBtMXAlx8KUHr7CTl3qBE0Qebjosabqc6fTw+wzUGn4cWdeK7Z
 pnyKjnJkeUcOcoWg=
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr13027069wrm.338.1578836711239; 
 Sun, 12 Jan 2020 05:45:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqyksaEmElv2UTCB/l/18UFqbEAYTSoV5f6uKSxAKpAnVb6fo0pyYB/gKSnmWVoZ/sTqC2KwVw==
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr13027042wrm.338.1578836710928; 
 Sun, 12 Jan 2020 05:45:10 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id q6sm11096257wrx.72.2020.01.12.05.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2020 05:45:10 -0800 (PST)
Subject: Re: [PATCH 10/15] memory: Replace current_machine by
 qdev_get_machine()
To: Alistair Francis <alistair23@gmail.com>
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-11-philmd@redhat.com>
 <CAKmqyKNrgTbiipNK1wrwCMqk_=7cJmc4rBwO1zxjFiVV+TRSgQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f7e3539a-4506-0df1-ee66-f3d8a6aa8fce@redhat.com>
Date: Sun, 12 Jan 2020 14:45:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNrgTbiipNK1wrwCMqk_=7cJmc4rBwO1zxjFiVV+TRSgQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: gvj4Vg98O2m1SdZBwIIdjQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Overall" <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/12/20 10:48 AM, Alistair Francis wrote:
> On Thu, Jan 9, 2020 at 11:29 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> As we want to remove the global current_machine,
>> replace 'current_machine' by MACHINE(qdev_get_machine()).
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   memory.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/memory.c b/memory.c
>> index d7b9bb6951..57e38b1f50 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -3004,6 +3004,7 @@ static void mtree_print_flatview(gpointer key, gpo=
inter value,
>>       int n =3D view->nr;
>>       int i;
>>       AddressSpace *as;
>> +    MachineState *ms;
>>
>>       qemu_printf("FlatView #%d\n", fvi->counter);
>>       ++fvi->counter;
>> @@ -3026,6 +3027,7 @@ static void mtree_print_flatview(gpointer key, gpo=
inter value,
>>           return;
>>       }
>>
>> +    ms =3D MACHINE(qdev_get_machine());
>=20
> Why not set this at the top?

Calling qdev_get_machine() is not free as it does some introspection=20
checks. Since we can return earlier if there are no rendered FlatView, I=20
placed the machinestate initialization just before it we need to access it.

> Alistair
>=20
>>       while (n--) {
>>           mr =3D range->mr;
>>           if (range->offset_in_region) {
>> @@ -3057,7 +3059,7 @@ static void mtree_print_flatview(gpointer key, gpo=
inter value,
>>           if (fvi->ac) {
>>               for (i =3D 0; i < fv_address_spaces->len; ++i) {
>>                   as =3D g_array_index(fv_address_spaces, AddressSpace*,=
 i);
>> -                if (fvi->ac->has_memory(current_machine, as,
>> +                if (fvi->ac->has_memory(ms, as,
>>                                           int128_get64(range->addr.start=
),
>>                                           MR_SIZE(range->addr.size) + 1)=
) {
>>                       qemu_printf(" %s", fvi->ac->name);
>> --
>> 2.21.1
>>
>>
>=20


