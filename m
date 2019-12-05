Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B189C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A4622525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpZ7O025"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A4622525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrPV-0002rM-Jn
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icrIm-0005yo-0h
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icrIk-0001Tm-Ak
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:36:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29644
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icrIk-0001QO-58
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575552973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5ZuXt0si4sWt83jFb5fbkotlopmza9rOsBqNm3goIQ=;
 b=RpZ7O025GkVnraKn6JmHX6FwNVcvA0FDWwU8gT8XQvNZk3cxILQ3Qd2E7qO5jysWmZ9Cde
 IOoo1ZFwkZ49EVYQACz7CIGSbg+T0GvR5yyUHvsVIVjKX2aqmMZ5CKWrKBLLimnhvQcZWT
 O1VYt9c9VQEFcIB8f+Z1LW4oO3xSZ3M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167---lVPQG7NSKPF3D1S3nTiw-1; Thu, 05 Dec 2019 08:20:58 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so1510217wrm.16
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 05:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7kLUgzRSoKPS2gPrcq7IoucaNiiYb85oE21ZOxbzP4w=;
 b=KVTM+rgLxd9KkINk839ywoXXwr5O5JzFE2vXjRuAZJCW1DOgIGVu1t4gIZcxvXc9Ce
 hnHZqBjfdhUcdPXsGJ8zdOYClVqVlopooWloKz8ux2kB9OLeIsRY77eHUOR9Xq5Sxou9
 jPFztOfNB6BugxRKzf0uYKfhxO5+v1FhEwh0US8PHRhetAXHhSB75+UVEdvm7ZgoBKEM
 4GQbqe2tYyP3iqQhlkqm34bVG712+UIGbpG48qW/iJiH7O+5z9vdn+fn45IMYYpUDJvA
 qFtDNLFtvplYoaT1MjfLdtaQHa29VoZ8U7rAY/O+NUtMZtjq9P6TagOzxTicKmn/er1o
 t9Ag==
X-Gm-Message-State: APjAAAWbFMehEQS1ONXMUNVGKCGlAlxIK6QNcNWFjIZHB9KeFKToS4Gj
 f4oMqhN0YfDFrINEwNErcIYbU3vCBWv6q+y0lidzVwn5AnPfWjWI75jpPaJBeGlfcfrpwTP4FjC
 FNWdVnUo9LluaPTc=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr9643622wrj.325.1575552057046; 
 Thu, 05 Dec 2019 05:20:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqymHDCn44GLE9xotEfyPSsRcDcLSiO3gipw6oTanaT1wgKd9SG615tlF5cKSPhrnbFyOvwQUQ==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr9643588wrj.325.1575552056738; 
 Thu, 05 Dec 2019 05:20:56 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id i10sm12654510wru.16.2019.12.05.05.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 05:20:56 -0800 (PST)
Subject: Re: [PATCH v3] qga: fence guest-set-time if hwclock not available
To: Cornelia Huck <cohuck@redhat.com>
References: <20191205115350.18713-1-cohuck@redhat.com>
 <5aaa7f3a-e3d1-0057-5fe2-07dea4864bc7@redhat.com>
 <20191205141212.6cb05ac7.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <634de177-e6eb-7a06-9fc5-674b6555182f@redhat.com>
Date: Thu, 5 Dec 2019 14:20:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205141212.6cb05ac7.cohuck@redhat.com>
Content-Language: en-US
X-MC-Unique: --lVPQG7NSKPF3D1S3nTiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 2:12 PM, Cornelia Huck wrote:
> On Thu, 5 Dec 2019 14:05:19 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> Hi Cornelia,
>>
>> On 12/5/19 12:53 PM, Cornelia Huck wrote:
>>> The Posix implementation of guest-set-time invokes hwclock to
>>> set/retrieve the time to/from the hardware clock. If hwclock
>>> is not available, the user is currently informed that "hwclock
>>> failed to set hardware clock to system time", which is quite
>>> misleading. This may happen e.g. on s390x, which has a different
>>> timekeeping concept anyway.
>>>
>>> Let's check for the availability of the hwclock command and
>>> return QERR_UNSUPPORTED for guest-set-time if it is not available.
>>>
>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>
>>> v2->v3:
>>>     - added 'static' keyword to hwclock_path
>>>
>>> Not sure what tree this is going through; if there's no better place,
>>> I can also take this through the s390 tree.
>>
>> s390 or trivial trees seems appropriate.
>>
>>>
>>> ---
>>>    qga/commands-posix.c | 13 ++++++++++++-
>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>>> index 1c1a165daed8..0be301a4ea77 100644
>>> --- a/qga/commands-posix.c
>>> +++ b/qga/commands-posix.c
>>> @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t tim=
e_ns, Error **errp)
>>>        pid_t pid;
>>>        Error *local_err =3D NULL;
>>>        struct timeval tv;
>>> +    static const char hwclock_path[] =3D "/sbin/hwclock";
>>> +    static int hwclock_available =3D -1;
>>> +
>>> +    if (hwclock_available < 0) {
>>> +        hwclock_available =3D (access(hwclock_path, X_OK) =3D=3D 0);
>>> +    }
>>> +
>>> +    if (!hwclock_available) {
>>> +        error_setg(errp, QERR_UNSUPPORTED);
>>
>> In include/qapi/qmp/qerror.h we have:
>>
>> /*
>>    * These macros will go away, please don't use in new code, and do not
>>    * add new ones!
>>    */
>=20
> Sigh, it is really hard to keep track here :( I just copied from other
> callers in this file...
>=20
>>
>> Maybe we can replace it by "this feature is not supported on this
>> architecture"? (or without 'on this architecture').
>=20
> This is not really architecture specific, you'd get this on any setup
> that does not have /sbin/hwclock.
>=20
> Q: Is libvirt doing anything with such an error message from QEMU? Do
> we have the freedom to say e.g "guest-set-time is not supported" or so?
> Or is it beneficial to print the same error message for any unsupported
> feature?

Cc'ing Markus who added the command and libvir-list.

Using "guest-set-time is not supported" or "this command is not supported":
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>>> +        return;
>>> +    }
>>>   =20
>>>        /* If user has passed a time, validate and set it. */
>>>        if (has_time) {
>>> @@ -195,7 +206,7 @@ void qmp_guest_set_time(bool has_time, int64_t time=
_ns, Error **errp)
>>>   =20
>>>            /* Use '/sbin/hwclock -w' to set RTC from the system time,
>>>             * or '/sbin/hwclock -s' to set the system time from RTC. */
>>> -        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
>>> +        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",
>>>                   NULL, environ);
>>>            _exit(EXIT_FAILURE);
>>>        } else if (pid < 0) {
>>>   =20
>>
>=20


