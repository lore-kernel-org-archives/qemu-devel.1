Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B4C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E54C206F8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRUT0GLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E54C206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJdx8-00028Y-8o
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 10:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJdwD-0001VV-Ks
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJdwA-0007Dv-Ob
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:01:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJdw8-0007AT-J8
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:01:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id f6so7332347wmj.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=y6c6Y5KkGBjhH/8y4pQ3fx0e7WvtyUvZzqmDp/3fNBc=;
 b=DRUT0GLdq+OJIJVxl4uEpVr3goE0dv4obmfm/XyzrqtIgbP+ASr9XzArN790a7wUbJ
 VWOawyPIdfZ0gSG2J0DeTWskn4uryUpHD1wKgNF5sYGQfJ4x+zLVMiW7OjW5b10UquVh
 9FU6bWWnTGU1GKxt0xFn48NhbQeAX2UcSjKMsxp8LAWz4V2sLtkYz2+rMbVoT2EMBDhh
 0Ck3BNcF5h0YAfRk+zSxIog2q8ij1qf7UmR14f1M24vvVDMuAZNDio6tWBdQPRF8bwT6
 NJJXmENgpYFSGPTSDu/5fplsUrf8/cEXOklCI9wQzJRtClfXOOoOAFfF9i4GGJXdXuus
 xuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=y6c6Y5KkGBjhH/8y4pQ3fx0e7WvtyUvZzqmDp/3fNBc=;
 b=QTijds+GKnbgx+ywz8olFjOFhaw9RWufKL9g+zp9oFRkc+HsOHYLGTmlaSrFT1YNyX
 DuDQ2uiFOyzm6Oav+iVuv6ocsTl4yhvbGDhrLFmRLfORXsy0JvdIV/sa9kfa1miyQamd
 Pn0o/BYuOWS8OmTHwo0GYNwzlT7q/DNYkjIN2uHPJDpF69JpeRmkaGqnUlx3QRsl2KVf
 VemSPJPjWmo7tQFkbRgKka7AerN1SRToS1ABnnQ0ad+lfmo5wYdBg6pzukQHwcvM1q9f
 Qcygl2i2v9XLmf4jXWZdrA4DEXpKIttqOgC6IBFYLXtYa1oHMXjnth0MdLbcyZqP0DCI
 8neg==
X-Gm-Message-State: AGi0Pub/mv09M4pUzdpDEJ8JYSWz+EraPrlDBOyuQhd4yRn7KkA9XXe/
 joGOWM0W0wCQUrz/IwbrqsxDGSXlJhc=
X-Google-Smtp-Source: APiQypIDypwTaJWLqwW6oLAcp6CSDqqjDMop/ybGOFmtfxkUPXH6J6YFNfGPYeTtvx/+7kWHnUsyxQ==
X-Received: by 2002:a05:600c:34c:: with SMTP id
 u12mr4385293wmd.186.1585749701335; 
 Wed, 01 Apr 2020 07:01:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m8sm2684539wmc.28.2020.04.01.07.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 07:01:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DF9181FF7E;
 Wed,  1 Apr 2020 15:01:38 +0100 (BST)
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <e980477d-3951-2a2b-fa38-dee8e1895019@virtuozzo.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Questionable aspects of QEMU Error's design
In-reply-to: <e980477d-3951-2a2b-fa38-dee8e1895019@virtuozzo.com>
Date: Wed, 01 Apr 2020 15:01:38 +0100
Message-ID: <87v9mje24d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 01.04.2020 12:02, Markus Armbruster wrote:
>> QEMU's Error was patterned after GLib's GError.  Differences include:
>> * &error_fatal, &error_abort for convenience
>> * Error can optionally store hints
>> * Pointlessly different names: error_prepend() vs. g_error_prefix()
>> and
>>    so forth *shrug*
>> * Propagating errors
>>    Thanks to Vladimir, we'll soon have "auto propagation", which is
>> less
>>    verbose and less error-prone.
>> * Accumulating errors
>>    error_propagate() permits it, g_propagate_error() does not[*].
>>    I believe this feature is used rarely.  Perhaps we'd be better
>> off
>>    without it.  The problem is identifying its uses.  If I remember
>>    correctly, Vladimir struggled with that for his "auto propagation"
>>    work.
>>    Perhaps "auto propagation" will reduce the number of manual
>>    error_propagate() to the point where we can identify accumulations.
>>    Removing the feature would become feasible then.
>> * Distinguishing different errors
>>    Where Error has ErrorClass, GError has Gquark domain, gint code.
>> Use
>>    of ErrorClass other than ERROR_CLASS_GENERIC_ERROR is strongly
>>    discouraged.  When we need callers to distinguish errors, we return
>>    suitable error codes separately.
>> * Return value conventions
>>    Common: non-void functions return a distinct error value on
>> failure
>>    when such a value can be defined.  Patterns:
>>    - Functions returning non-null pointers on success return null
>> pointer
>>      on failure.
>>    - Functions returning non-negative integers on success return a
>>      negative error code on failure.
>>    Different: GLib discourages void functions, because these lead to
>>    awkward error checking code.  We have tons of them, and tons of
>>    awkward error checking code:
>>      Error *err =3D NULL;
>>      frobnicate(arg, &err);
>>      if (err) {
>>          ... recover ...
>>          error_propagate(errp, err);
>>      }
>>    instead of
>>      if (!frobnicate(arg, errp))
>>          ... recover ...
>>      }
>>    Can also lead to pointless creation of Error objects.
>>    I consider this a design mistake.  Can we still fix it?  We have
>> more
>>    than 2000 void functions taking an Error ** parameter...
>>    Transforming code that receives and checks for errors with
>> Coccinelle
>>    shouldn't be hard.  Transforming code that returns errors seems more
>>    difficult.  We need to transform explicit and implicit return to
>>    either return true or return false, depending on what we did to the
>>    @errp parameter on the way to the return.  Hmm.
>>=20
>> [*] According to documentation; the code merely calls g_warning() then,
>> in typical GLib fashion.
>>=20
>
>
> Side question:
>
> Can we somehow implement a possibility to reliably identify file and line=
 number
> where error is set by error message?
>
> It's where debug of error-bugs always starts: try to imagine which parts =
of the error
> message are "%s", and how to grep for it in the code, keeping in mind als=
o,
> that error massage may be split into several lines..
>
> Put file:line into each error? Seems too noisy for users.. A lot of error=
s are not
> bugs: use do something wrong and see the error, and understands what he i=
s doing
> wrong.. It's not usual practice to print file:line into each message
> for user.

I tend to use __func__ for these things as the result is usually easily
grep-able.


>
>
> But what if we do some kind of mapping file:line <-> error code, so user =
will see
> something like:
>
>
>    Error 12345: Device drive-scsi0-0-0-0 is not found
>
> ....
>
> Hmm, maybe, just add one more argument to error_setg:
>
> error_setg(errp, 12345, "Device %s is not found", device_name);
>
> - it's enough grep-able.


--=20
Alex Benn=C3=A9e

