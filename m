Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88146FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDD32178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkLcQWIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDD32178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT7To-0006G6-Fn
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 11:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iT7Sm-0005dM-Ls
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iT7Sk-0006d7-Bt
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:50:20 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iT7Si-0006TK-EY
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:50:18 -0500
Received: by mail-wm1-x344.google.com with SMTP id a17so7026510wmb.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 08:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Iy8Gilt6K/VmLrMs25ELxt+JksPIAkZPo+SYu1J222k=;
 b=MkLcQWIK70drUoMmqbUCZeRCYs9nne9NXbf6Z9SYY1zJa1sNkHhSDK1DtHJE9VS5JM
 WIix9aeI5HlYnbcuIw2cshbsp6+T/n7fs6P5rf/HB4FaEPj9FnnKNnIuokEdFFb9w7nH
 31AyRaEDsK1CYn0IMUkEzot2Ft3VMEFQZY61iFmm2oCErKgBOEz1v67s9O6y2tysMJcq
 3Nk3gyb9O0YrZkD6ejPHemCW5I9QKflii2wQ04AzLxr2Vo1hjPC91eKB/ABZnSl9P5kl
 vQxlb+zxvJpeRDtdNsbSxkInQl7q9x2MEjM6nUeOHzOKp6cfFaxrWu1rHRBrIbutSBn/
 YlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Iy8Gilt6K/VmLrMs25ELxt+JksPIAkZPo+SYu1J222k=;
 b=ZDapzS4Qe9dW/k5y4fJeWTgkERrpqbyIqDTZfNiNVlYM8ljsMzZag89pCCMVmbF6J6
 BWeoVohK1NVIzA8iWRUMOlkQhbO5Rnid/CvCGJGErHWVyYcvUNfeQcXqG88UdyvD1Y/s
 izyMgKmql18zLTy/eRqQbe9BzQ9LHGHLmUQhdesOQfhpskIq1ESDBmOsbc7jz7jeiMOA
 5adtb4zXw2U2x2BgYLmaYYFly2YaHxfHsG9trc37l7aw9wE+av3BsPxrHgSRz9oVBbQo
 7/fAtvYxxQG7l4ncyv7derm8jNEdiC/aA+hI0sbxmvsWbF4mRjG1A8j7MPS4TPBEqH6n
 eklg==
X-Gm-Message-State: APjAAAURpbp2JsoC+9vogvcTmgMY9CaD55L9p6w0ep1ZOO1WY8G0QPdH
 lUK5id6lSAQIP2wkBRDoNkKUYA==
X-Google-Smtp-Source: APXvYqysNLDawi4nLjh2LGoA+g4eNzPAHTjScvXRkN+5ZU041qVeqZkVF4bR2VBfP1YiC2bn3UfZ0A==
X-Received: by 2002:a1c:e308:: with SMTP id a8mr9123365wmh.55.1573231814255;
 Fri, 08 Nov 2019 08:50:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u203sm6781521wme.34.2019.11.08.08.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 08:50:13 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 733F51FF87;
 Fri,  8 Nov 2019 16:50:12 +0000 (GMT)
References: <20191108125534.114474-1-damien.hedde@greensocs.com>
 <877e4ah32n.fsf@linaro.org>
 <7aa732a4-b67f-855f-0432-290580fc239d@greensocs.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH] gdbstub: Fix buffer overflow in handle_read_all_regs
In-reply-to: <7aa732a4-b67f-855f-0432-290580fc239d@greensocs.com>
Date: Fri, 08 Nov 2019 16:50:12 +0000
Message-ID: <87v9rufh2z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Damien Hedde <damien.hedde@greensocs.com> writes:

> On 11/8/19 3:09 PM, Alex Benn=C3=A9e wrote:
>>
>> Damien Hedde <damien.hedde@greensocs.com> writes:
>>
>>> Ensure we don't put too much register data in buffers. This avoids
>>> a buffer overflow (and stack corruption) when a target has lots
>>> of registers.
>>>
>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>> ---
>>>
>>> Hi all,
>>>
>>> While working on a target with many registers. I found out the gdbstub
>>> may do buffer overflows when receiving a 'g' query (to read general
>>> registers). This patch prevents that.
>>>
>>> Gdb is pretty happy with a partial set of registers and queries
>>> remaining registers one by one when needed.
>>
>> Heh I was just looking at this code with regards to SVE (which can get
>> quite big).
>
> SVE ?

ARM's Scalable Vector Registers which currently can get upto 16 vector
quads (256 bytes) but are likely to get bigger.

>
>>
>>>
>>> Regards,
>>> Damien
>>> ---
>>>  gdbstub.c | 13 +++++++++++--
>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/gdbstub.c b/gdbstub.c
>>> index 4cf8af365e..dde0cfe0fe 100644
>>> --- a/gdbstub.c
>>> +++ b/gdbstub.c
>>> @@ -1810,8 +1810,17 @@ static void handle_read_all_regs(GdbCmdContext *=
gdb_ctx, void *user_ctx)
>>>      cpu_synchronize_state(gdb_ctx->s->g_cpu);
>>>      len =3D 0;
>>>      for (addr =3D 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++)=
 {
>>> -        len +=3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf=
 + len,
>>> -                                 addr);
>>> +        int size =3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem=
_buf + len,
>>> +                                     addr);
>>> +        if (len + size > MAX_PACKET_LENGTH / 2) {
>>> +            /*
>>> +             * Prevent gdb_ctx->str_buf overflow in memtohex() below.
>>> +             * As a consequence, send only the first registers content.
>>> +             * Gdb will query remaining ones if/when needed.
>>> +             */
>>
>> Haven't we already potentially overflowed gdb_ctx->mem_buf though? I
>> suspect the better fix is for str_buf is to make it growable with
>> g_string and be able to handle arbitrary size conversions (unless the
>> spec limits us). But we still don't want a hostile gdbstub to be able to
>> spam memory by asking for registers that might be bigger than
>> MAX_PACKET_LENGTH bytes.
>
> For gdb_ctx->mem_buf  it's ok because it has also a size of
> MAX_PACKET_LENGTH. (assuming no single register can be bigger than
> MAX_PACKET_LENGTH)
> str_buf has a size of MAX_PACKET_LENGTH + 1

Are these limits of the protocol rather than our own internal limits?

> I'm not sure I've understood the second part but if we increase the size
> of str_buf then we will need also a bigger packet buffer.

Glib provides some nice functions for managing arbitrary sized strings
in a nice flexible way which grow on demand. There is also a nice
growable GByteArray type which we can use for the packet buffer. I think
I'd started down this road of re-factoring but never got around to
posting the patches.

> The size here only depends on what are the target declared registers, so
> it depends only on the cpu target code.

Sure - but guest registers are growing all the time!

--
Alex Benn=C3=A9e

