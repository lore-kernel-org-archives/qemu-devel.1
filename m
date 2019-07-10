Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D35C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E2020838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zesyvFcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E2020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl915-0006S4-4Y
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49889)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hl8vm-0004x6-Qo
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hl8vj-0008LG-Ou
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:30:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hl8vj-0008Hz-Cg
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:30:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id p17so1633866wrf.11
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PD7B1AFoddL6PeFkFXeMJjvGUsmn79RGnU7jpTstRj0=;
 b=zesyvFcRpLfHnzLNsnAQEZ10pe8zpgpanXjKy1VFlVTtbGiouW0dJROcVSAXrQ3fvt
 dTe/M6dF4TOihsRVMo7XcdI6isa4yFZRI3wvUYN5Um8bon5cBv8ua/UBgXewwE08SUz9
 3PIpFgjoCKNJ9TEV+tKuK3CwI15Ru56AxKUv2B/otQCDV0ZWuu7Xbme44qa4csneMQ7J
 XGK5K/lRmYupHoSywRIFSq6f0HUaKBTLkoIXNHXPMxlOUC9yy8qpghUb/mN8bQXF353M
 hOtKb2Isq7PhN9ReAXYDdTTWgxDpt3qkijBNRQi8AEtFYz3QqcoH4x86Txz1VMPIIwUp
 OeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PD7B1AFoddL6PeFkFXeMJjvGUsmn79RGnU7jpTstRj0=;
 b=LMNAxqRBPeFDz74V6uQwAHs0LvhxBfS6UjcV0R66m9OkdmttG0rTNlDemW9LWhxaHn
 AxFzWIsg5xmw0AIPtkuOYmAk41dS47P0ccADoM0dsvukdmlWttx6EWVzU03I+6a/Ijq3
 BuBRXkmKE0ZO5iPYT5lKKa0HvylQEA32nmDHzFhTcjAxycuIXrk/hDr6Qwh1Vbt7br/y
 iBUMwqMaRWWjviagJkKyyYPk0cS+aG9dmgeJQAsq2BH3qQq8ORFJqyW49mu3dXm58j0a
 Q2shgPQUCly9Os9nEWujQx0JKSl7tEvc+cP2s0BzA5LU5sa8G/Y09L34uk8t1wQmIWOy
 0uEA==
X-Gm-Message-State: APjAAAXrKcPn0a2i1VtChIAerZPezuyaqt7HiwCV9vcuI0KAXTISq+Bm
 0JX1YGS+oZiBVTm7XbLe9hJNRw==
X-Google-Smtp-Source: APXvYqxwqnIydOacM29BQxT0BeiLcTP65ZkdeH0HaP9X23+nqEHncYd8g+/EUUjyEaC1IcAL5I6Ujg==
X-Received: by 2002:adf:ab4a:: with SMTP id r10mr28567981wrc.95.1562751024937; 
 Wed, 10 Jul 2019 02:30:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q7sm1514665wrx.6.2019.07.10.02.30.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 02:30:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 005131FF87;
 Wed, 10 Jul 2019 10:30:23 +0100 (BST)
References: <20190705160421.19015-1-alex.bennee@linaro.org>
 <20190705160421.19015-6-alex.bennee@linaro.org>
 <CAL1e-=i08h1j0V7d97p7a-OQqdNXzG1s5QATmLDxfGCDtwE-4Q@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
In-reply-to: <CAL1e-=i08h1j0V7d97p7a-OQqdNXzG1s5QATmLDxfGCDtwE-4Q@mail.gmail.com>
Date: Wed, 10 Jul 2019 10:30:23 +0100
Message-ID: <87o922dyog.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 5/5] gdbstub: revert to previous set_reg
 behaviour
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> On Jul 5, 2019 6:08 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrote:
>>
>> The refactoring of handle_set_reg missed the fact we previously had
>> responded with an empty packet when we were not using XML based
>> protocols. This broke the fallback behaviour for architectures that
>> don't have registers defined in QEMU's gdb-xml directory.
>>
>> Revert to the previous behaviour and clean up the commentary for what
>> is going on.
>>
>> Fixes: 62b3320bddd
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Cc: Jon Doron <arilou@gmail.com>
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>
> Do you plan to integrate this patch in 4.1?
>
> Thanks, Aleksandar

Yes - I'm putting together a PR today.

>
>>  gdbstub.c | 18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index ea3349d1aa..b6df7ee25a 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -1669,12 +1669,23 @@ static void handle_remove_bp(GdbCmdContext
> *gdb_ctx, void *user_ctx)
>>      put_packet(gdb_ctx->s, "E22");
>>  }
>>
>> +/*
>> + * handle_set/get_reg
>> + *
>> + * Older gdb are really dumb, and don't use 'G/g' if 'P/p' is available.
>> + * This works, but can be very slow. Anything new enough to understand
>> + * XML also knows how to use this properly. However to use this we
>> + * need to define a local XML file as well as be talking to a
>> + * reasonably modern gdb. Responding with an empty packet will cause
>> + * the remote gdb to fallback to older methods.
>> + */
>> +
>>  static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
>>  {
>>      int reg_size;
>>
>>      if (!gdb_has_xml) {
>> -        put_packet(gdb_ctx->s, "E00");
>> +        put_packet(gdb_ctx->s, "");
>>          return;
>>      }
>>
>> @@ -1694,11 +1705,6 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx,
> void *user_ctx)
>>  {
>>      int reg_size;
>>
>> -    /*
>> -     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialabl=
e.
>> -     * This works, but can be very slow.  Anything new enough to
>> -     * understand XML also knows how to use this properly.
>> -     */
>>      if (!gdb_has_xml) {
>>          put_packet(gdb_ctx->s, "");
>>          return;
>> --
>> 2.20.1
>>
>>


--
Alex Benn=C3=A9e

