Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9849FC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C14206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd0mnPUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C14206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVC0M-0001Qp-Bd
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iVByn-0000IU-PR
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iVByl-0000ZM-4N
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:03:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47193
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iVByl-0000Yb-0m
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573725834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=V+HpgZ0izySaZwjH5Kez1WXrOu6XKCOqPwKaJ6S/W2k=;
 b=fd0mnPUeMik0Jmf+gkNBFAIs0m4JA4tOZKAv6S/T3seOF6HEcD+vH42teM+jgyxKNoyrxy
 m1F2MfBKzW77G0e937dX5cXri8cJHZHpyha163fUAa2WSsXASzEHB9ye5ES5J2R5ANuCSJ
 2GbiKTRdYwALye7Sw8ewb2iEwPQnjdk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-q1kp-j3rO_i2GgOUjYHuAA-1; Thu, 14 Nov 2019 05:03:52 -0500
Received: by mail-wm1-f70.google.com with SMTP id g13so3866801wme.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 02:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s3mrhYi5USE47zqjcJbZk3/QjwY7g17f0COfc6haMkc=;
 b=JX5g0MttoWjV/UdftCcykch+wzkeY2a6WPgSApRUjrixceADJNKw6Y6XAk2baU4Z9N
 nMXQRAPYONSzOBlOTOgzgpKw3WB6LK2fiy5E3XUh+OcZolpiqGoxRQ+V+bIw0C1AUW7l
 ohJ9TlCgYpmI6RpOr7n6WgXIs17UYN3tjuL2if0pmkSxLZTbT/KCznzIQIUNa516b9SE
 AhVlMMJ0q+Jk/L15bf0fIV5WmceKy6petUw3TbylT0v346Lat6xM/D5Sw0AoXs99nJbC
 S9KivTekQ1IvrSlQ0AAmmpUap1NghhOSqyYzuDYcZvfsSkW2OwkY8341Fm8RbDIE9j5j
 Hn/A==
X-Gm-Message-State: APjAAAVHQwrmuYI2GzXIVNq/yNmQ1HEmukrEzDStD8yh0+IGRtx9qDFg
 UiFm4by6FOHX8AF2/9mSLHlMXVQfNrnpEdfwpHWgJ7Z1vSMB8KMwPhkZK9hWIeKd8LlaBtMh3Fk
 TnsNpAt8qfKaWavQ=
X-Received: by 2002:a7b:c768:: with SMTP id x8mr7365880wmk.26.1573725831665;
 Thu, 14 Nov 2019 02:03:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzP86zHEXXIeZB5H1BMMkBYMInedLI7gZymxhqBydoevsNOD5b2cBhZWGZDIW7WyJqHwK5e3A==
X-Received: by 2002:a7b:c768:: with SMTP id x8mr7365848wmk.26.1573725831287;
 Thu, 14 Nov 2019 02:03:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id y2sm6120027wmy.2.2019.11.14.02.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 02:03:50 -0800 (PST)
Subject: Re: [PATCH 08/16] qom: introduce object_register_sugar_prop
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-9-git-send-email-pbonzini@redhat.com>
 <CAJ+F1CLJhFZhu4RJOnwQ=RjJwP=U_xGU-15J0BO_3CEfys7aZg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <de9bc045-1eb5-ab77-136e-859a1d4a0e98@redhat.com>
Date: Thu, 14 Nov 2019 11:03:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLJhFZhu4RJOnwQ=RjJwP=U_xGU-15J0BO_3CEfys7aZg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: q1kp-j3rO_i2GgOUjYHuAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/11/19 10:53, Marc-Andr=C3=A9 Lureau wrote:
>>  include/qom/object.h |  1 +
>>  qom/object.c         | 23 +++++++++++++++++++++--
>>  vl.c                 | 10 +++-------
>>  3 files changed, 25 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index 128d00c..230b18f 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -679,6 +679,7 @@ void object_apply_global_props(Object *obj, const GP=
trArray *props,
>>                                 Error **errp);
>>  void object_set_machine_compat_props(GPtrArray *compat_props);
>>  void object_set_accelerator_compat_props(GPtrArray *compat_props);
>> +void object_register_sugar_prop(const char *driver, const char *prop, c=
onst char *value);
>=20
> Or simply
>=20
> void object_add_global_prop(const char *typename, ...) ?

This is actually how I called it first, but I didn't like it because
it's prioritized _below_ -global, and it's easy to confuse it with
object_add_global_prop.

>>  /*
>>   * Set machine's global property defaults to @compat_props.
>> @@ -445,7 +464,7 @@ void object_apply_compat_props(Object *obj)
>>
>>      for (i =3D 0; i < ARRAY_SIZE(object_compat_props); i++) {
>>          object_apply_global_props(obj, object_compat_props[i],
>> -                                  &error_abort);
>> +                                  i =3D=3D 2 ? &error_fatal : &error_ab=
ort);
>=20
> Isn't error_abort() appropriate in all cases?

Unfortunately not, because otherwise "-accel tcg,tb-size=3Dfoo" would crash=
.

>>      }
>>  }
>>
>> diff --git a/vl.c b/vl.c
>> index 843b263..cb993dd 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -896,13 +896,9 @@ static void configure_rtc(QemuOpts *opts)
>>      value =3D qemu_opt_get(opts, "driftfix");
>>      if (value) {
>>          if (!strcmp(value, "slew")) {
>> -            static GlobalProperty slew_lost_ticks =3D {
>> -                .driver   =3D "mc146818rtc",
>> -                .property =3D "lost_tick_policy",
>> -                .value    =3D "slew",
>> -            };
>> -
>> -            qdev_prop_register_global(&slew_lost_ticks);
>> +            object_register_sugar_prop("mc146818rtc",
>> +                                       "lost_tick_policy",
>> +                                       "slew");
>=20
> Why do you convert this since it's a device?

Not strictly necessary, but it's more compact and it more or less
matches the usecase for this function.

Paolo


