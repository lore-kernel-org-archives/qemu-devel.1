Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5F8C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F0321569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMg5wHP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F0321569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itv1i-0004Cn-Hf
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itupO-0000XM-1o
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itupK-0003B7-7e
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:48:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itupK-0003Av-3p
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579618101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MfidcSyopCaLwrpkq8aitEvnsa7tFBx3jPnCZiP9wKM=;
 b=eMg5wHP5VEM6RO2jKZj3p+/YfZCl+hhkQ8oDo4pmD3frA3SMLYl5OS3ldG8Tv6fO9FC2Hs
 R7/ChLA0qXs06qHud83Sj04q1oLUMj5DumrMXqPpTvUokOyPBk77SNhC+Wi+LGWimeOIub
 a7nfEq+hwOOge/L2ytiilvsh9B3pCVo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-49xXuXh8NzCkGyLFz5kb9w-1; Tue, 21 Jan 2020 09:48:19 -0500
Received: by mail-wm1-f70.google.com with SMTP id o24so449939wmh.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 06:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=04T7j8PomeDgoRXx5iKV6fdYTEJYSzY06xuvF5Hk/NQ=;
 b=FFgHJCIl1P0hlIVYLoYSvumYi4gdavBxxq2JM3pgb/RFkvPPjIXHXW+HbC7RhT6oCr
 cVPjGZI5T1U48x/IFoQL7S5ll1vmAT+mmvcfD35tjPHPYp49hAaIAqivo/vCagUoiTkM
 2KRws8+m0RCAUrvQhQOvMBo6z0cscPUTV7vxxMwlOwZA+PxBdsDv0SWFrWYTZbSOPl4l
 sJWKk+1fL3GfiJ2wk4VzZ4XTtDk1JVRN+yyNyS1MUxoN7K9l9Hld/7XWDNgfPQlkzqai
 uToGi/mbWBWU34EEAEdtHT3UsnS1Z5qo1zw4msf3oGyNS3qb2627rXa9kj8fWoZjjGdy
 P0xw==
X-Gm-Message-State: APjAAAUf39bSllS22yJzmvLfd2GZjHKafR5cNPyXb9SRqztwr0f/sd94
 WChOAyl9Uu1fgBnyNw8idAtZDstV5EuyP+posAoGBV/UCHRVY5ofUdZch4gfHpucNDAr7pcjG+3
 122U+dTUOQunQJV0=
X-Received: by 2002:adf:e641:: with SMTP id b1mr5681496wrn.34.1579618097668;
 Tue, 21 Jan 2020 06:48:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwT6ZcJ12xM6GzrgvW/pMgLLnD6yp4jQumA8QFIBT9YqQI0EnXJyx0AXKDyzrmpiwQ+SHnGHA==
X-Received: by 2002:adf:e641:: with SMTP id b1mr5681468wrn.34.1579618097267;
 Tue, 21 Jan 2020 06:48:17 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n1sm50169232wrw.52.2020.01.21.06.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 06:48:16 -0800 (PST)
Subject: Re: [RFC PATCH] qapi: Incorrect attempt to fix building with
 MC146818RTC=n
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20191231184916.10235-1-philmd@redhat.com>
 <875zhfzc9l.fsf@dusky.pond.sub.org>
 <a06fd97c-b149-2f24-1180-4e4efa8ff79d@redhat.com>
 <87wo9ll5on.fsf@dusky.pond.sub.org>
 <b0559940-7b97-901b-5729-587d8649eede@redhat.com>
 <87lfq0c2jq.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7095e183-c9dc-6198-918e-159dd5f65e52@redhat.com>
Date: Tue, 21 Jan 2020 15:48:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87lfq0c2jq.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: 49xXuXh8NzCkGyLFz5kb9w-1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 3:22 PM, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 21/01/20 06:49, Markus Armbruster wrote:
>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>
>>>> On 13/01/20 15:01, Markus Armbruster wrote:
>>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>>>
>>>>>> When configured with --without-default-devices and setting
>>>>>> MC146818RTC=3Dn, the build fails:
>>>>>>
>>>>>>      LINK    x86_64-softmmu/qemu-system-x86_64
>>>>>>    /usr/bin/ld: qapi/qapi-commands-misc-target.o: in function `qmp_m=
arshal_rtc_reset_reinjection':
>>>>>>    qapi/qapi-commands-misc-target.c:46: undefined reference to `qmp_=
rtc_reset_reinjection'
>>>>>>    /usr/bin/ld: qapi/qapi-commands-misc-target.c:46: undefined refer=
ence to `qmp_rtc_reset_reinjection'
>>>>>>    collect2: error: ld returned 1 exit status
>>>>>>    make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
>>>>>>    make: *** [Makefile:483: x86_64-softmmu/all] Error 2
>>>>>>
>>>>>> This patch tries to fix this, but this is incorrect because QAPI
>>>>>> scripts only provide TARGET definitions, so with MC146818RTC=3Dy we
>>>>>> get:
>>>>>>
>>>>>>    hw/rtc/mc146818rtc.c:113:6: error: no previous prototype for =E2=
=80=98qmp_rtc_reset_reinjection=E2=80=99 [-Werror=3Dmissing-prototypes]
>>>>>>      113 | void qmp_rtc_reset_reinjection(Error **errp)
>>>>>>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>    cc1: all warnings being treated as errors
>>>>>>    make[1]: *** [rules.mak:69: hw/rtc/mc146818rtc.o] Error 1
>>>>>>
>>>>>> Any idea? :)
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>>> ---
>>>>>>   qapi/misc-target.json | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>>>> index a00fd821eb..8e49c113d1 100644
>>>>>> --- a/qapi/misc-target.json
>>>>>> +++ b/qapi/misc-target.json
>>>>>> @@ -41,7 +41,7 @@
>>>>>>   #
>>>>>>   ##
>>>>>>   { 'command': 'rtc-reset-reinjection',
>>>>>> -  'if': 'defined(TARGET_I386)' }
>>>>>> +  'if': 'defined(TARGET_I386) && defined(CONFIG_MC146818RTC)' }
>>>>>>  =20
>>>>>>  =20
>>>>>>   ##
>>>>>
>>>>> The generated qapi-commands-misc-target.h duly has
>>>>>
>>>>>      #if defined(TARGET_I386) && defined(CONFIG_MC146818RTC)
>>>>>      void qmp_rtc_reset_reinjection(Error **errp);
>>>>>      void qmp_marshal_rtc_reset_reinjection(QDict *args, QObject **re=
t, Error **errp);
>>>>>      #endif /* defined(TARGET_I386) && defined(CONFIG_MC146818RTC) */
>>>>>
>>>>> mc146818rtc.c includes it.  But since it doesn't include
>>>>> config-devices.h, CONFIG_MC146818RTC remains undefined, and the
>>>>> prototype gets suppressed.
>>>>>
>>>>> Crude fix: make mc146818rtc.c #include "config-devices.h".

I am happy enough if this 'crude fix' works, I'll test it, thanks!

>>>>
>>>> Can we modify the code generator to leave out the #if from the header,
>>>> and only include it in the .c file?  An extra prototype is harmless.
>>>
>>> Is *everything* we generate into headers just as harmless?
>>
>> It should be, since it's just the C version of some JSON.  The only
>> problematic thing could be different definitions of the same command for
>> multiple targets, and I think we want to avoid that anyway.
>>
>> To see it a different way, these are the "C bindings" to QMP, just that
>> the implementation is an in-process call rather than RPC.  If the QAPI
>> code generator was also able to generate Python bindings and the like,
>> they would have to be the same for all QEMU binaries, wouldn't they?
>=20
> Ommitting the kind of #if we've been discussing is relatively harmless:
>=20
>      #if defined(TARGET_I386)
>      void qmp_rtc_reset_reinjection(Error **errp);
>      void qmp_marshal_rtc_reset_reinjection(QDict *args, QObject **ret, E=
rror **errp);
>      #endif /* defined(TARGET_I386) */
>=20
> But what about this one, in qapi-types-block-core.h:
>=20
>      typedef enum BlockdevDriver {
>          BLOCKDEV_DRIVER_BLKDEBUG,
>          [...]
>      #if defined(CONFIG_REPLICATION)
>          BLOCKDEV_DRIVER_REPLICATION,
>      #endif /* defined(CONFIG_REPLICATION) */
>          [...]
>          BLOCKDEV_DRIVER__MAX,
>      } BlockdevDriver;
>=20
> If I omit it in the header, I then have to omit it in
> qapi-types-block-core.c's
>=20
>      const QEnumLookup BlockdevDriver_lookup =3D {
>          .array =3D (const char *const[]) {
>              [BLOCKDEV_DRIVER_BLKDEBUG] =3D "blkdebug",
>              [...]
>      #if defined(CONFIG_REPLICATION)
>              [BLOCKDEV_DRIVER_REPLICATION] =3D "replication",
>      #endif /* defined(CONFIG_REPLICATION) */
>              [...]
>          },
>          .size =3D BLOCKDEV_DRIVER__MAX
>      };
>=20
> and God knows what else.  But I must not omit it in qapi-introspect.c's
>=20
>          QLIT_QDICT(((QLitDictEntry[]) {
>              { "meta-type", QLIT_QSTR("enum"), },
>              { "name", QLIT_QSTR("245"), },
>              { "values", QLIT_QLIST(((QLitObject[]) {
>                  QLIT_QSTR("blkdebug"),
>                  [...]
>      #if defined(CONFIG_REPLICATION)
>                  QLIT_QSTR("replication"),
>      #endif /* defined(CONFIG_REPLICATION) */
>                  [...]
>                  {}
>              })), },
>              {}
>          })),
>=20
> because that would defeat introspection.
>=20
> I smell a swamp.
>=20
> I'd rather not complicate the generator to support not including a
> header I feel we *should* include.  #ifdef CONFIG_FOO can occur not just
> in QAPI-generated code, and neglecting to include the relevant header
> can cause *nasty* problems not just in QAPI-generated code.  Like
> inconsistent struct definitions in separate compilation units.  Been
> there, debugged that, wasn't fun, do not want to go there again.
>=20


