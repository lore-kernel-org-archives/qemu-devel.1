Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B436EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1B122310
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvEbVXzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1B122310
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWodc-0007Zb-Jb
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 16:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWocS-0006ku-S6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWocO-0007qc-Uz
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:31:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWocO-0007qU-Rk
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574112692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kbTWmqXHnmxazJ4xx8pcDYzJd3sokrjpCI4meWf984=;
 b=IvEbVXzG49HWpVtFa6IJVfgNQjR7Rm9cD8eGd61hh8owXpn5ztge7QUrQ2xVAEGgiSP/FN
 fGuJo3z10b8zE1ost5lmMnJjO2thVpILz71w0bLIBsSz+G5GE5JG13feyHj6GYTxqGXScU
 vi9oILxMw4wTTEKSsG38AY5gzIaGEFU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-fh-laQPlNuGm82lRvBhu6g-1; Mon, 18 Nov 2019 16:31:29 -0500
Received: by mail-wr1-f70.google.com with SMTP id w9so16757294wrn.9
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 13:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zxsUeB4B4DceliHoSNAgm9t/YU1l7m0npLaqPTfKu50=;
 b=DAfK6BTV4fqQAIOXVvmLtIU7/q4+uChhIvjQE5TzZB8eKq8d86sdKSMJEC4cDSh7QK
 nGS4EJCs11XKw/dahdafNMpgtECbDjGeYKHNXXRp4YEWUPX8OP4KCamQ9iHlBj65NIMd
 k4dApOqtz/f9yyiC/4Zp4XpXUw40tc0FxSXL6+UFYhh46KCR52nm+RG8WZYoa34UmjVB
 gFPdiRU8+WYswYHgtZfVBZl90jnZG36+sC/ji1vTNM+fBA+GIkXzxxx7iaE43VoBxgaE
 UO26dqnWYkKKdWoVQXSp5rPLxx6K8j6sqPjLq7WHpplGf86Lod0ZkRUdvTqWrPUJjvhe
 gEDg==
X-Gm-Message-State: APjAAAUXleibbjskNPUFbCCZPeOeHY3A/Mz6myk0uQ+k5Ho+ejlL1+v8
 i9ViGnskd88jmgaiV4QQRKqlRPr7rYeqW0exVT3xYbLOvjCk9BmtXhx2SBoeoqLxQTxHde8eqsX
 s2Uo5jcSU+Hh3dEw=
X-Received: by 2002:a5d:558e:: with SMTP id i14mr32447974wrv.140.1574112688542; 
 Mon, 18 Nov 2019 13:31:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqygRIvc9D+JaBA7VmgEuhSUKRQ+LUtVmfsk8bLnpoBPFU/9QyaOj6s/QmiwehAbVsFy8doDmg==
X-Received: by 2002:a5d:558e:: with SMTP id i14mr32447941wrv.140.1574112688215; 
 Mon, 18 Nov 2019 13:31:28 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id t187sm750164wma.16.2019.11.18.13.31.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 13:31:27 -0800 (PST)
Subject: Re: [PATCH-for-4.2 v3 3/3] trace: Forbid dynamic field width in event
 format
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191118210458.11959-1-philmd@redhat.com>
 <20191118210458.11959-4-philmd@redhat.com>
 <c12c9178-6d40-17c5-7572-090cecbcc7a4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <35b0441b-ac62-c4ff-fea8-10c72be81921@redhat.com>
Date: Mon, 18 Nov 2019 22:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c12c9178-6d40-17c5-7572-090cecbcc7a4@redhat.com>
Content-Language: en-US
X-MC-Unique: fh-laQPlNuGm82lRvBhu6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 10:26 PM, Eric Blake wrote:
> On 11/18/19 3:04 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since not all trace backends support dynamic field width in
>> format (dtrace via stap does not), forbid them.
>>
>> Add a check to refuse field width in new formats:
>>
>> =C2=A0=C2=A0 $ make
>> =C2=A0=C2=A0 [...]
>> =C2=A0=C2=A0=C2=A0=C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0 hw/block/trace.h
>> =C2=A0=C2=A0 Traceback (most recent call last):
>> =C2=A0=C2=A0=C2=A0=C2=A0 File "scripts/tracetool.py", line 152, in <modu=
le>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 main(sys.argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0 File "scripts/tracetool.py", line 143, in main
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 events.extend(tracetool.read_events=
(fh, arg))
>> =C2=A0=C2=A0=C2=A0=C2=A0 File "scripts/tracetool/__init__.py", line 371,=
 in read_events
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event =3D Event.build(line)
>> =C2=A0=C2=A0=C2=A0=C2=A0 File "scripts/tracetool/__init__.py", line 285,=
 in build
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise ValueError("Event format must=
 not contain field width '%*'")
>> =C2=A0=C2=A0 ValueError: Error at hw/block/trace-events:11: Event format=
 must=20
>> not contain field width '%*'
>>
>> Reported-by: Eric Blake <eblake@redhat.com>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1844817
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>=20
>> +++ b/docs/devel/tracing.txt
>> @@ -113,7 +113,8 @@ Format strings should reflect the types defined in=
=20
>> the trace event.=C2=A0 Take
>> =C2=A0 special care to use PRId64 and PRIu64 for int64_t and uint64_t ty=
pes,
>> =C2=A0 respectively.=C2=A0 This ensures portability between 32- and 64-b=
it=20
>> platforms.
>> =C2=A0 Format strings must not end with a newline character.=C2=A0 It is=
 the=20
>> responsibility
>> -of backends to adapt line ending for proper logging.
>> +of backends to adapt line ending for proper logging.=C2=A0 Format strin=
gs=20
>> must not
>> +use numeric field width dynamic precision (SystemTap does not support=
=20
>> them).
>=20
> Reads awkwardly - a dynamic precision is not numeric in the format=20
> string (but '*' instead).=C2=A0 Better might be:
>=20
> Format strings must not use dynamic field width or precision ('*'), as=20
> at least SystemTap does not support them.
>=20
> Or even:
>=20
> Format strings may use numeric field width or precision, but must not=20
> use dynamic forms ('*') as at least SystemTap does not support that.
>=20
>> =C2=A0 Each event declaration will start with the event name, then its=
=20
>> arguments,
>> =C2=A0 finally a format string for pretty-printing. For example:
>> diff --git a/scripts/tracetool/__init__.py=20
>> b/scripts/tracetool/__init__.py
>> index 44c118bc2a..ec7fe9fa4a 100644
>> --- a/scripts/tracetool/__init__.py
>> +++ b/scripts/tracetool/__init__.py
>> @@ -206,6 +206,7 @@ class Event(object):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\s*"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "(?:(?:(=
?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\s*")
>> +=C2=A0=C2=A0=C2=A0 _DFWRE =3D re.compile(r"%[\d\.\- +#']*\*") # dynamic=
 width precision
>=20
> The comment is slightly off - this catches both dynamic field width (any=
=20
> '*' before '.') and dynamic precision (any '*' after '.'), maybe the fix=
=20
> is just s/width/width or/
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _VALID_PROPS =3D set(["disable", "tcg", "=
tcg-trans", "tcg-exec",=20
>> "vcpu"])
>> @@ -280,6 +281,8 @@ class Event(object):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if fmt.endswith(r=
'\n"'):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 raise ValueError("Event format must not end with a=20
>> newline "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "character")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if Event._DFWRE.search(fmt):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rais=
e ValueError("Event format must not contain field=20
>> width '%*'")
>=20
> and I don't know if you want to tweak the error message, maybe:
>  =C2=A0Event format must not use dynamic '*'
>=20
> If we're trying to get stuff in 4.2-rc2, patch 1 and 2 are actual bug=20
> fixes and deserve to go in; patch 3 is nice-to-have but doesn't affect=20
> the build if it is omitted (as there are no other offenders left), so=20
> slipping it into 5.0 for a v4 to clean it up slightly doesn't hurt.=C2=A0=
 I=20
> don't know who would send the pull request, though, and slipping 1 and 2=
=20
> into -rc3 just because of 3 is not ideal.

Wise thought. I'll respin 1-2 with the Fixes: tag in case qemu-block@ or=20
qemu-trivial@ have pending pull-request for tomorrow, they can queue it.
Else they can go via the mips-next tree, since both patch affect the=20
Malta board.

Thanks!

Phil.


