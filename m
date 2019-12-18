Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739D5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E1D206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeeRXG7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E1D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdPN-0005Fn-QF
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihdOX-0004RG-Sn
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihdOU-0005f8-PB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:45:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29946
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihdOU-0005Sw-Ix
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576691143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYdCtARh1DlaJb5QhxAom7DShKuTQCeWthsEi/g0iqI=;
 b=HeeRXG7o339Cd1RstBdgzWnH6dKN+LmeApubOElP8q66u000cQ8QUpjP+irAkF2ctgLcyi
 rKuAS/j8IdP9A6e4FiEW0+kPRMWOJU575EjPNRKyheYT7Yi7c/l8EisWt8hmrtFP7c7mWZ
 rwFflpu30Tkyx/Xe6+d6pN6FqYAm+hI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-CML05TKHMeGGPojmi8wkbw-1; Wed, 18 Dec 2019 12:45:38 -0500
Received: by mail-wm1-f70.google.com with SMTP id b9so696659wmj.6
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 09:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SXc/wu8KlY6VL5Z2QJesRd/ee9QosLEou+3J83m0oio=;
 b=iHtjWGkioJtDGIDNXtwLFc63yw+mwlpZsCQ3ifymv6ivHXUv+OVxMkVrBzG64la7ku
 EhxMfTGhjLCVBwtA3rxzjT5n/cX9Pc+54gr6wbN+d7BvqTZJpZGAOr8wqk+mADnToyVH
 FrE1Il0YKaivQ8kcUZGmYzjlhSMkKLld1TR9sLr3QMC17Qn/zLvvK0WbFYn7UQ2QfWc1
 QQYJ8HQ++i7TXur4mYasXnSez9jW/ITR6Jb2RJC37dPBt4ACS2VCzkJKx9LzbqTYig7b
 WKB8wgZMWw8rQ3L1nyseEqQHV78XVKc2Vr7uPgtGuEew+uPwmJdGHIiy2Akr3O2K99P1
 k5Tw==
X-Gm-Message-State: APjAAAW79C6UHU/qnGmwKNx60WRidBZZfDYQ1Qkzkq6LSb0F6GEQyALN
 n6JCNfiXYXl0n0ZGKqtS1PQF6jqNQRPbn2mQnHW0oVZ10nMGW76dGI01Xjrtgj0/xgnjvA46ivu
 Tp+g3yIzTkGsD/QQ=
X-Received: by 2002:a05:600c:108a:: with SMTP id
 e10mr4478085wmd.38.1576691136999; 
 Wed, 18 Dec 2019 09:45:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxZFf933ygNrX6goWNEZCNEh4Z1T7XrmfQKj+0lmiiO4CTTeMAuX7QMLTamuo6X91ot5C7LA==
X-Received: by 2002:a05:600c:108a:: with SMTP id
 e10mr4478054wmd.38.1576691136690; 
 Wed, 18 Dec 2019 09:45:36 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id z6sm3373743wrw.36.2019.12.18.09.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 09:45:36 -0800 (PST)
Subject: Re: [PATCH 6/6] qemu-io-cmds: Silent GCC9 format-overflow warning
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-7-philmd@redhat.com>
 <0bd64884-03fd-68e1-a790-c9ceb7710fd9@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ac01ca89-ad58-a6f4-e33f-c1dcc4e0ad90@redhat.com>
Date: Wed, 18 Dec 2019 18:45:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0bd64884-03fd-68e1-a790-c9ceb7710fd9@linaro.org>
Content-Language: en-US
X-MC-Unique: CML05TKHMeGGPojmi8wkbw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 5:15 AM, Richard Henderson wrote:
> On 12/17/19 7:34 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> GCC9 is confused when building with CFLAG -O3:
>>
>>    In function =E2=80=98help_oneline=E2=80=99,
>>        inlined from =E2=80=98help_all=E2=80=99 at qemu-io-cmds.c:2414:9,
>>        inlined from =E2=80=98help_f=E2=80=99 at qemu-io-cmds.c:2424:9:
>>    qemu-io-cmds.c:2389:9: error: =E2=80=98%s=E2=80=99 directive argument=
 is null [-Werror=3Dformat-overflow=3D]
>>     2389 |         printf("%s ", ct->name);
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>>
>> Audit shows this can't happen. Give a hint to GCC adding an
>> assert() call.
>=20
> This deserves more investigation.  From my glance it appears you are righ=
t --
> and moreover impossible for gcc to have come to this conclusion.  Which b=
egs
> the question of how that is.

New entries are added to cmdtab[] in qemuio_add_command() which is=20
public (also called in qemu-io.c). So you can insert a cmdinfo_t with a=20
name being NULL. This is why I thought GCC was correct first, and I tried:

-- >8 --
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -42,6 +42,7 @@ void qemuio_add_command(const cmdinfo_t *ci)
       * Catch it now rather than letting it manifest as a crash if a
       * particular set of command line options are used.
       */
+    assert(ci->name);
      assert(ci->perm =3D=3D 0 ||
             (ci->flags & (CMD_FLAG_GLOBAL | CMD_NOFILE_OK)) =3D=3D 0);
      cmdtab =3D g_renew(cmdinfo_t, cmdtab, ++ncmds);
---

But this didn't fix the warning... So I moved the assert() in the other=20
location.

>=20
> Did you file a gcc bug report?

No because I'm not sure this is a bug, but if you confirm I'll file one :)

>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: qemu-block@nongnu.org
>> ---
>>   qemu-io-cmds.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
>> index 1b7e700020..9e956a5dd4 100644
>> --- a/qemu-io-cmds.c
>> +++ b/qemu-io-cmds.c
>> @@ -2411,6 +2411,7 @@ static void help_all(void)
>>       const cmdinfo_t *ct;
>>  =20
>>       for (ct =3D cmdtab; ct < &cmdtab[ncmds]; ct++) {
>> +        assert(ct->name);
>>           help_oneline(ct->name, ct);
>>       }
>>       printf("\nUse 'help commandname' for extended help.\n");
>>
>=20


