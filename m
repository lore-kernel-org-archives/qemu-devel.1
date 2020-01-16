Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31CAC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 08:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D562207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 08:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBWqmRsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D562207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is0z5-0002aO-Ns
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 03:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is0yR-0001Wn-0K
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is0yN-0001Mv-By
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:57:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39988
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is0yM-0001MK-Uc
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579165070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cXQzohup6hjqIXLGgmQrlek2mCqLTuM7KD+AjF0QeU=;
 b=IBWqmRswL430q/IssjhW8z723MXF2q/Z4/rNu2ajbXdT2LJHHDAsF/cY3qxKu7oixMbzbB
 V+sUhCz/ht8eh5qic6F9ocnoimNBWGPqZAeiMZD7/fE8VpIrvbt4ChWD75pyxha9ghF0h8
 XqVeZBc++0ORC55VXpr2SDaLzF6N5p4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-67ODVIqMMMmfTWo6QuN_1A-1; Thu, 16 Jan 2020 03:57:48 -0500
Received: by mail-wr1-f70.google.com with SMTP id b13so8990948wrx.22
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 00:57:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wQOEugOMmg1fICBTqthSLBUtXExmev6wgldHUgBgYo4=;
 b=MPEORwRdcjdsiO5NwPcSTkQbpY/njvNkMaffjU7Q3yt4pwN+gHuzQN3Z0gL/11u0d2
 gD/6qtPCGYo8l9/oQ951HKZxBf++2kCrCYmd5ic7f8ks+sSXqjzzHyuzszQZapL0KMvW
 uzeZUIfCXtl5cG18u4NBUExlI531U9MrPctwVkuBTseIPnGdbm7fziAF95E2/BzWkeFC
 dfMdvBXmvhLHELJViSkoWOgDkA3BAuxXB/iciQBghPOnBiQMrIXwoFVyoXwnuyGNiiQ9
 sRmgTEeNSjnYxRfXKncvwOWJrlt2d/VQ/XbA+9iW7Zb7D3to8OAWv8uW+ZdjMgTUDxu4
 O74A==
X-Gm-Message-State: APjAAAUEFmRjzaohz+lV/ru0g0cHYXgz+mW+E0kQmeUgf5CFduG9nnp2
 W9YgB51F8wQ7ynDsHAt6KCSG5jk1eyh3DXkbGVzraDG6oso2YGgkVUFajTL3dpqjg0xNb2Nharx
 k3MF3V3CegpIyFlg=
X-Received: by 2002:adf:fc08:: with SMTP id i8mr2225066wrr.82.1579165067655;
 Thu, 16 Jan 2020 00:57:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGcVjHXG+bRCeI5TjX+jPSR/g6gCsW7PlrcnGZdVZO/nYFwBn5NOO1VXnWvYpKJodL8V+4mg==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr2225025wrr.82.1579165067241;
 Thu, 16 Jan 2020 00:57:47 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id z3sm28245628wrs.94.2020.01.16.00.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 00:57:46 -0800 (PST)
Subject: Re: [PATCH v7 03/11] hw/core: create Resettable QOM interface
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-4-damien.hedde@greensocs.com>
 <656ee01a-54ad-273f-e71e-873328428565@redhat.com>
 <42e9a018-0070-205b-65ed-1d7a6a1b1ff5@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ddd3f6cf-83e5-7198-fd91-9433ef6df923@redhat.com>
Date: Thu, 16 Jan 2020 09:57:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <42e9a018-0070-205b-65ed-1d7a6a1b1ff5@greensocs.com>
Content-Language: en-US
X-MC-Unique: 67ODVIqMMMmfTWo6QuN_1A-1
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 9:53 AM, Damien Hedde wrote:
> On 1/16/20 2:59 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/15/20 1:36 PM, Damien Hedde wrote:
>>> This commit defines an interface allowing multi-phase reset. This aims
>>> to solve a problem of the actual single-phase reset (built in
>>> DeviceClass and BusClass): reset behavior is dependent on the order
>>> in which reset handlers are called. In particular doing external
>>> side-effect (like setting an qemu_irq) is problematic because receiving
>>> object may not be reset yet.
>>>
>>> The Resettable interface divides the reset in 3 well defined phases.
>>> To reset an object tree, all 1st phases are executed then all 2nd then
>>> all 3rd. See the comments in include/hw/resettable.h for a more complet=
e
>>> description. The interface defines 3 phases to let the future
>>> possibility of holding an object into reset for some time.
>>>
>>> The qdev/qbus reset in DeviceClass and BusClass will be modified in
>>> following commits to use this interface. A mechanism is provided
>>> to allow executing a transitional reset handler in place of the 2nd
>>> phase which is executed in children-then-parent order inside a tree.
>>> This will allow to transition devices and buses smoothly while
>>> keeping the exact current qdev/qbus reset behavior for now.
>>>
>>> Documentation will be added in a following commit.
>>>
>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>
>>> v7 update: un-nest struct ResettablePhases
>>> ---
>>>  =C2=A0 Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>  =C2=A0 include/hw/resettable.h | 211 +++++++++++++++++++++++++++++++++=
++
>>>  =C2=A0 hw/core/resettable.c=C2=A0=C2=A0=C2=A0 | 238 ++++++++++++++++++=
++++++++++++++++++++++
>>>  =C2=A0 hw/core/Makefile.objs=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>  =C2=A0 hw/core/trace-events=C2=A0=C2=A0=C2=A0 |=C2=A0 17 +++
>>>  =C2=A0 5 files changed, 468 insertions(+)
>>>  =C2=A0 create mode 100644 include/hw/resettable.h
>>>  =C2=A0 create mode 100644 hw/core/resettable.c
>>>
>=20
>>
>> Something here breaks ./configure --enable-trace-backends=3Dust:
>>
>>  =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace-ust-all.o
>> In file included from trace-ust-all.h:13,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from trace-ust-all.c:13:
>> trace-ust-all.h:35151:1: error: redefinition of
>> =E2=80=98__tracepoint_cb_qemu___loader_write_rom=E2=80=99
>> 35151 | TRACEPOINT_EVENT(
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
>> trace-ust-all.h:31791:1: note: previous definition of
>> =E2=80=98__tracepoint_cb_qemu___loader_write_rom=E2=80=99 was here
>> 31791 | TRACEPOINT_EVENT(
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
>> ...
>> ./trace-ust-all.h:35388:1: error: redefinition of
>> =E2=80=98__tp_event_signature___qemu___resettable_transitional_function=
=E2=80=99
>> 35388 | TRACEPOINT_EVENT(
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
>> ./trace-ust-all.h:32028:1: note: previous definition of
>> =E2=80=98__tp_event_signature___qemu___resettable_transitional_function=
=E2=80=99 was here
>> 32028 | TRACEPOINT_EVENT(
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
>> In file included from /usr/include/lttng/tracepoint-event.h:58,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from trace-ust-all.h:35401,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from trace-ust-all.c:13:
>>
>> Indeed:
>>
>> 32028 TRACEPOINT_EVENT(
>> 32029=C2=A0=C2=A0=C2=A0 qemu,
>> 32030=C2=A0=C2=A0=C2=A0 resettable_transitional_function,
>> 32031=C2=A0=C2=A0=C2=A0 TP_ARGS(void *, obj, const char *, objtype),
>> 32032=C2=A0=C2=A0=C2=A0 TP_FIELDS(
>> 32033=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_integer_hex(void *, =
obj, obj)
>> 32034=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_string(objtype, objt=
ype)
>> 32035=C2=A0=C2=A0=C2=A0 )
>> 32036 )
>> 32037
>> ...
>> 35388 TRACEPOINT_EVENT(
>> 35389=C2=A0=C2=A0=C2=A0 qemu,
>> 35390=C2=A0=C2=A0=C2=A0 resettable_transitional_function,
>> 35391=C2=A0=C2=A0=C2=A0 TP_ARGS(void *, obj, const char *, objtype),
>> 35392=C2=A0=C2=A0=C2=A0 TP_FIELDS(
>> 35393=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_integer_hex(void *, =
obj, obj)
>> 35394=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_string(objtype, objt=
ype)
>> 35395=C2=A0=C2=A0=C2=A0 )
>> 35396 )
>> 35397
>> 35398 #endif /* TRACE_ALL_GENERATED_UST_H */
>>
>> Ah! I was going to say "no clue what could be wrong, so Cc'ing Stefan"
>> but got it:
>>
>> $ git grep hw/core Makefile.objs
>> Makefile.objs:194:trace-events-subdirs +=3D hw/core
>> Makefile.objs:207:trace-events-subdirs +=3D hw/core
>>
>> We might already have a 'uniq' makefile function to do:
>>
>> trace-events-subdirs =3D $(call uniq $(trace-events-subdirs))
>>
>> or maybe was it with $filter? I can't find it/remember, too tired.
>=20
> You can use $sort to remove duplicates in make.

Ah $(sort ...) thanks, I was too tired to remember it =3D)

>>
>> So the fix is:
>>
>> -- >8 --
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -191,7 +191,6 @@ trace-events-subdirs +=3D migration
>>  =C2=A0trace-events-subdirs +=3D net
>>  =C2=A0trace-events-subdirs +=3D ui
>>  =C2=A0endif
>> -trace-events-subdirs +=3D hw/core
>>  =C2=A0trace-events-subdirs +=3D hw/display
>>  =C2=A0trace-events-subdirs +=3D qapi
>>  =C2=A0trace-events-subdirs +=3D qom
>> ---
>>
>=20
> I'll remove the duplicate entry.

I prepared a patch to move hw/core, if qemu-trivial merges it first, you=20
shouldn't need to respin your series.


