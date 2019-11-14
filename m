Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305CAC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB0A20706
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgq+z5CJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB0A20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFUa-0001wq-5H
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVFTQ-00011R-Ev
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVFTO-0005nH-Aq
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:47:48 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVFTK-0005ei-Rs
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:47:46 -0500
Received: by mail-wm1-x342.google.com with SMTP id j18so7523599wmk.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 05:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hft5bfnNtkvERHgVkw7XAcaQsAVjfu1bkRL38qIft0c=;
 b=zgq+z5CJjgpZ1ZLYIjCLN+ajgKaeywWKL7ZLtOoez55EfUgZUmHOH/Um5ta3bf8fOn
 G0nvUr7iIID2vJYvULunyxHkLCGb6ec4Getmk8HlGEUCZg8p2j2UbO3kVkEZJhAUaLuD
 QvfMhf6CmARflzXvtxJikhv2sRW5qXLqzvDZg4Rnlig6OyY2Brg2QSPvvwJKCp7bRZKn
 IhUa9RHHEnWFawWlAqYsx6m6XQIwwe90A2y690Ga1iya18250AjOx6ynbqd7NwlTboy2
 AiOHObmZ+E0H8rtTKD7RbQz/GygKveBcDRzWC9pT2W2UFeL61uhUX7bXlfQTzqw0pZ5T
 uG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hft5bfnNtkvERHgVkw7XAcaQsAVjfu1bkRL38qIft0c=;
 b=lbUcAJL7sqMjc4hFeaMhF3D3U9JXwbcpVJA4RHJ68M1Exc4e/DyA306Kthjz65oy6X
 88MOBhF4jBs7q0rQjOfYOxkf8TeKv4dsxsz5S7E3aYa9UlgJAyUt7ei6f1HTi9/v9NJT
 vUi2mRGOowNUNO/yLokk9M0oAjc5Z/99dG1/Z/+lNsCA0XPB+p2Zqtl0oMFeQRbpHiI8
 2C2alBY83NuKH6CY7Q8lm//JU91Uvu0otxZOWVuRBGKNeZlF4Glci0D2lVoecJxY01Wl
 Cto05vKo1j/OniZZAmwh4D9VvAwMqHLbwwo4WKAM0PttWYdQbGP1Bg8eYnnbtLpJi2ih
 UAsQ==
X-Gm-Message-State: APjAAAXEXY7spGpQSM4N0rJvUygZjtvqBd/3ul9jER5vVkazd09+gmos
 +yZkK9OvTico/I7e3vm4SYyOlA==
X-Google-Smtp-Source: APXvYqxjW+TdlZ/JkfBA6VLgCSYU0y5dxf1seVGFH88DnRobqIl5bT4RGaVO8yWL/0SXq9V1RsJ9Sg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr8377874wma.116.1573739254500; 
 Thu, 14 Nov 2019 05:47:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t14sm7003738wrw.87.2019.11.14.05.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2019 05:47:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC2031FF87;
 Thu, 14 Nov 2019 13:47:32 +0000 (GMT)
References: <20191108125534.114474-1-damien.hedde@greensocs.com>
 <877e4ah32n.fsf@linaro.org>
 <7aa732a4-b67f-855f-0432-290580fc239d@greensocs.com>
 <87v9rufh2z.fsf@linaro.org>
 <78291aad-5c91-32a3-f0d8-f74f3a75dfbf@greensocs.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH] gdbstub: Fix buffer overflow in handle_read_all_regs
In-reply-to: <78291aad-5c91-32a3-f0d8-f74f3a75dfbf@greensocs.com>
Date: Thu, 14 Nov 2019 13:47:32 +0000
Message-ID: <875zjm7eob.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Damien Hedde <damien.hedde@greensocs.com> writes:

> On 11/8/19 5:50 PM, Alex Benn=C3=A9e wrote:
>>
>> Damien Hedde <damien.hedde@greensocs.com> writes:
>>
>>> On 11/8/19 3:09 PM, Alex Benn=C3=A9e wrote:
>>>>
>>>> Damien Hedde <damien.hedde@greensocs.com> writes:
>>>>
>>>>> Ensure we don't put too much register data in buffers. This avoids
>>>>> a buffer overflow (and stack corruption) when a target has lots
>>>>> of registers.
>>>>>
>>>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>>>> ---
>>>>>
>>>>> Hi all,
>>>>>
>>>>> While working on a target with many registers. I found out the gdbstub
>>>>> may do buffer overflows when receiving a 'g' query (to read general
>>>>> registers). This patch prevents that.
>>>>>
>>>>> Gdb is pretty happy with a partial set of registers and queries
>>>>> remaining registers one by one when needed.
>>>>
>>>> Heh I was just looking at this code with regards to SVE (which can get
>>>> quite big).
>>>
>>> SVE ?
>>
>> ARM's Scalable Vector Registers which currently can get upto 16 vector
>> quads (256 bytes) but are likely to get bigger.
>>
>>>
>>>>
>>>>>
>>>>> Regards,
>>>>> Damien
>>>>> ---
>>>>>  gdbstub.c | 13 +++++++++++--
>>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/gdbstub.c b/gdbstub.c
>>>>> index 4cf8af365e..dde0cfe0fe 100644
>>>>> --- a/gdbstub.c
>>>>> +++ b/gdbstub.c
>>>>> @@ -1810,8 +1810,17 @@ static void handle_read_all_regs(GdbCmdContext=
 *gdb_ctx, void *user_ctx)
>>>>>      cpu_synchronize_state(gdb_ctx->s->g_cpu);
>>>>>      len =3D 0;
>>>>>      for (addr =3D 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr+=
+) {
>>>>> -        len +=3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_b=
uf + len,
>>>>> -                                 addr);
>>>>> +        int size =3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->m=
em_buf + len,
>>>>> +                                     addr);
>>>>> +        if (len + size > MAX_PACKET_LENGTH / 2) {
>>>>> +            /*
>>>>> +             * Prevent gdb_ctx->str_buf overflow in memtohex() below.
>>>>> +             * As a consequence, send only the first registers conte=
nt.
>>>>> +             * Gdb will query remaining ones if/when needed.
>>>>> +             */
>>>>
>>>> Haven't we already potentially overflowed gdb_ctx->mem_buf though? I
>>>> suspect the better fix is for str_buf is to make it growable with
>>>> g_string and be able to handle arbitrary size conversions (unless the
>>>> spec limits us). But we still don't want a hostile gdbstub to be able =
to
>>>> spam memory by asking for registers that might be bigger than
>>>> MAX_PACKET_LENGTH bytes.
>>>
>>> For gdb_ctx->mem_buf  it's ok because it has also a size of
>>> MAX_PACKET_LENGTH. (assuming no single register can be bigger than
>>> MAX_PACKET_LENGTH)
>>> str_buf has a size of MAX_PACKET_LENGTH + 1
>>
>> Are these limits of the protocol rather than our own internal limits?
>
> gdb has a dynamic sized packet buffer. Remote protocol doc says:
>
> =E2=80=98qSupported [:gdbfeature [;gdbfeature]=E2=80=A6 ]=E2=80=99
>     [...] Any GDB which sends a =E2=80=98qSupported=E2=80=99 packet suppo=
rts receiving
> packets of unlimited length (earlier versions of GDB may reject overly
> long responses).

OK so it seems worth cleaning this up. I'm currently putting together a
patch set to support these large SVE registers and I'm cleaning up the
core gdbstub code while I go. If you are interested the current WIP
branch is:

  https://github.com/stsquad/qemu/commits/gdbstub/sve-registers

but I can include you on the review CC when I post (hopefully this
week)?

>
>
>>
>>> I'm not sure I've understood the second part but if we increase the size
>>> of str_buf then we will need also a bigger packet buffer.
>>
>> Glib provides some nice functions for managing arbitrary sized strings
>> in a nice flexible way which grow on demand. There is also a nice
>> growable GByteArray type which we can use for the packet buffer. I think
>> I'd started down this road of re-factoring but never got around to
>> posting the patches.
>>
>>> The size here only depends on what are the target declared registers, so
>>> it depends only on the cpu target code.
>>
>> Sure - but guest registers are growing all the time!
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e

