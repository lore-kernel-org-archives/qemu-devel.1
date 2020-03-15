Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C98C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476DB206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTbziD03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476DB206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDbh9-0004Ug-2S
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 18:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDbcn-00032U-32
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDbcl-0001fN-KH
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:20:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56255
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDbcl-0001b4-FH
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584310847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2D7bkdwvbndMrUyNh6sDviBz4171BxInLQo0HF5lyY=;
 b=DTbziD03Wqy4fXYy1V/0eODE2f6WtyH0/iiz+CTxemDxrhi5RSr3RITi2OBTsu9n8Q2vc2
 2oHhV2q1yTTVR3ZAn3vCxR/J/Q7NUmnb1r1DpWPZOQGx7s9FJXnDsiOuXNwRo7GiN95qWa
 8M76/iCCYvrKtD8dnSrJQWIqcAH7mAk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-q2kg3AAHOKW1LD9bmFb1eA-1; Sun, 15 Mar 2020 18:20:45 -0400
X-MC-Unique: q2kg3AAHOKW1LD9bmFb1eA-1
Received: by mail-wm1-f71.google.com with SMTP id s15so2519001wmc.0
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 15:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jli2nez5UekOBc427wJHMKwGcjgVsf+7alJp/mq+nCI=;
 b=hru0K/04bYCMh1GdhjdSfrJRt95cTQEMnRNgAqTRTcMt4B3vsVwY444wocmpyL2qYy
 OooNnqjbVGoL7HlqmYJvuGC2uRo9vvfjAwJTIFWUp8vMbL+o3B0+m5RcP75CHHcu7wfa
 YOCwIh4sp4CbNF5PHwCxNlQyJ0qkcm7F4svXdk1Pis0smBKYrMCzh1JYKq2OODGVWLBD
 P5nq8Mzr8hx56iWF379CLPp2RIoqVyb2poOFR5FE7OWKi4iriIVbzGlDuOKAuahu7GJp
 1bOUXTvTzvuYDCBH29fL6zziyMoRSm8kqak/1dOOfrj5mx3WG9th1osW+bJbBNIvQhp0
 IKfQ==
X-Gm-Message-State: ANhLgQ1nuPUFW9cqEsZA+QBpQ2jB3qyJKT8/Zl6IuXOJ5WGe84bUN+mK
 YA92cAULnzFZdagtolTPvsHYpnwbwTzWhimw2IZQN+3p5HEQ0hBww0mAgKZazRn8Oe6Vtcl87zR
 Uy8c9shjV3+rnXiQ=
X-Received: by 2002:a05:6000:10c6:: with SMTP id
 b6mr8106423wrx.130.1584310844204; 
 Sun, 15 Mar 2020 15:20:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs6KxVepLGqG+3FvdCYOFEixDOrgXfo9SUxpugF5dxHBxknKmVnV7QCaGv3YG5nhvVlnzHbwA==
X-Received: by 2002:a05:6000:10c6:: with SMTP id
 b6mr8106393wrx.130.1584310843984; 
 Sun, 15 Mar 2020 15:20:43 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id c2sm27522294wma.39.2020.03.15.15.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 15:20:43 -0700 (PDT)
Subject: Re: [PATCH 09/14] exec: Drop redundant #ifdeffery
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-10-philmd@redhat.com>
 <fdbcdfba-9467-2270-7309-abe8e509edc2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ee7ce742-7750-eee7-67a4-804f65f114a1@redhat.com>
Date: Sun, 15 Mar 2020 23:20:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fdbcdfba-9467-2270-7309-abe8e509edc2@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 9:39 PM, Richard Henderson wrote:
> On 3/13/20 11:36 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   exec.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/exec.c b/exec.c
>> index 7bc9828c5b..f258502966 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -185,10 +185,6 @@ struct DirtyBitmapSnapshot {
>>       unsigned long dirty[];
>>   };
>>  =20
>> -#endif
>> -
>> -#if !defined(CONFIG_USER_ONLY)
>> -
>>   static void phys_map_node_reserve(PhysPageMap *map, unsigned nodes)
>>   {
>>       static unsigned alloc_hint =3D 16;
>>
>=20
> There's even more than that.  Looking further down,
>=20
>>      745 #endif
>>      746
>>      747 #if !defined(CONFIG_USER_ONLY)
>=20
> This is the #endif that paired with the one at 190.
>=20
> Later,
>=20
>>      988 #if defined(CONFIG_USER_ONLY)
> ...
>>     1000 #else
> ...
>>     1031 #endif
>>     1032
>>     1033 #ifndef CONFIG_USER_ONLY
>=20
> So those three lines are redundant.
>=20
> Later,
>=20
>>     1252 #if !defined(CONFIG_USER_ONLY)
> ...
>>     1438 #endif /* defined(CONFIG_USER_ONLY) */
>>     1439
>>     1440 #if !defined(CONFIG_USER_ONLY)
>=20
> Clearly these ifdefs are very hard to follow.  I would thus welcome a spl=
it of
> this file.
>=20
> Possibly into exec-common.c (with functions present in both softmmu and
> user-only, with ifdefs *inside* functions only), and exec-system.c (with =
no
> /#if.*CONFIG_USER_ONLY/).
>=20
> But exec.c is over 4000 lines, so if there's another logical split into e=
ven
> more files, that would be even better.

OK, I am taking notes for the 5.0 cycle.

We can drop this patch for this series objective, as it is mostly cosmetic.

>=20
>=20
> r~
>=20


