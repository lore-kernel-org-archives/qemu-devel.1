Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A56DC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352CB2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMvaTmJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352CB2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7LCo-0001Pw-CX
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7LCC-0000mT-AE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7LCB-0007ls-DX
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:35:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7LCB-0007km-AI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582817726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NF4E9rOgtCZE9IThrbg7pTderyZQUYYORdAU/Nf/mUc=;
 b=hMvaTmJ3z3a+h6whsRhWtRFQVJ14h9KkJTpm44YgQdt9WE3TquZ4v0xuRuy3pQMVZgCFf7
 6D+yReqXZn5k+S+1G8k21xAI0ASn+lX6p2f+gw5h4/rPkvx8/vZbMLkDtyOc6uuyWM0wMj
 CLBWlaxVOZpkZ/fLePdR53he47aFq2A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281--js1bjmxOXCpdi7_DOpXVw-1; Thu, 27 Feb 2020 10:35:25 -0500
X-MC-Unique: -js1bjmxOXCpdi7_DOpXVw-1
Received: by mail-wr1-f70.google.com with SMTP id r1so1449699wrc.15
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 07:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qhsvCr8jZD0F4RJ22ERrwxPlGA82K7TJGhS6HMn0sFc=;
 b=WltbA3G/zWqA5fe8GTz1/p5B9x6pDSIOi1gRx5Kkwh3Kwd5Ce5OJwEAHKrWcJtOmUx
 Ul1db1nBzriv2KD2ZG/J2k2hl07aTj5Xz0KtejlwraFMhg02MSxliLZMn66KuaRkilCr
 w4C0wsRBVlrxddQv41mi76NTeggwbGwauCO/EDU4C86hxTl/kPQxze2Uj5fnhCApb6rI
 0B8tDlI41pBJh1KI4vni72EvMsmD1ovQ4dUumlakZzyCu6f1JS5onhUsKjIqCnASQMql
 fA7RkOyOGyfjSK1jNfJ8Zvw2F/enAICyXyoTJ2M1NP8r4+zqRGUQwZ22K8dxp2pcMwge
 sxlg==
X-Gm-Message-State: APjAAAUtAQHSikyLCG22h1KTQ6PfKhCeYtewfu3JkGVPk3vun7YNo0Ms
 KlhXKEBKkiBLWvVFj3g6QsXDJP4ttI04x9Mv7JLIEUUcZrpuNslOS4WQ+mk0f8gb4sF2jOImsNI
 Upwaf4PM9+qD7XT4=
X-Received: by 2002:adf:a114:: with SMTP id o20mr5393477wro.7.1582817723903;
 Thu, 27 Feb 2020 07:35:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCE8WP7/70/qfZ23012B2ERp/howwJmG7d+gDFzsPJzAQGbErLa0IDH9rHyacG7b4+m1pVKw==
X-Received: by 2002:adf:a114:: with SMTP id o20mr5393456wro.7.1582817723695;
 Thu, 27 Feb 2020 07:35:23 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a7sm7564161wmj.12.2020.02.27.07.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 07:35:23 -0800 (PST)
Subject: Re: [PATCH 2/2] util/oslib-win32: Improve error report by calling
 error_setg_win32()
To: Markus Armbruster <armbru@redhat.com>
References: <20200227100250.20514-1-philmd@redhat.com>
 <20200227100250.20514-3-philmd@redhat.com>
 <87zhd4ozv7.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2d967cdd-3625-5b00-a154-65781f4f7d4b@redhat.com>
Date: Thu, 27 Feb 2020 16:35:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87zhd4ozv7.fsf@dusky.pond.sub.org>
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 3:42 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Use error_setg_win32() which adds a hint similar to strerror(errno)).
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   util/oslib-win32.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>> index e9b14ab178..d2fca1808d 100644
>> --- a/util/oslib-win32.c
>> +++ b/util/oslib-win32.c
>> @@ -46,7 +46,8 @@
>>   void *qemu_oom_check(void *ptr)
>>   {
>>       if (ptr =3D=3D NULL) {
>> -        fprintf(stderr, "Failed to allocate memory: %lu\n", GetLastErro=
r());
>> +        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError()=
);
>=20
> Since we're on a path to abort(), I wouldn't bother with g_autofree.\

This is in case other developers copy that elsewhere.

>=20
>> +        fprintf(stderr, "Failed to allocate memory: %s\n", emsg);
>=20
> Any particular reason not to use error_report()?

Pre-existing call, but I can change.

>=20
>>           abort();
>>       }
>>       return ptr;
>=20


