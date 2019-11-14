Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F8FC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1D72070E
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="BU5gOX2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1D72070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVGPR-00006S-I3
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 09:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iVGLq-0006Nx-Lw
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iVGLo-0003v3-MH
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:44:02 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:46242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iVGLm-0003ow-Jb
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:44:00 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 94B8F96EF0;
 Thu, 14 Nov 2019 14:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573742635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSVPUAxHqBpvl3GZyzNjbpozmg6Os1gmUEmn1/rfajM=;
 b=BU5gOX2G/6zljp6lnT/+yYVT0M4DfwTGA1chi79PdiYqYXwAx33+T6JjJ9qcB8pLnUHOa+
 ZLrM+kKmGtTroX22XiHhg5Hz/d7DeZmDRlRLLHx6sTjmnaVkFHPuSbN6RbIBSuxTM60Dfp
 tBT1KDWQ4v6JpyGvaPnjl6PXXxkuwI0=
Subject: Re: [PATCH] gdbstub: Fix buffer overflow in handle_read_all_regs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191108125534.114474-1-damien.hedde@greensocs.com>
 <877e4ah32n.fsf@linaro.org>
 <7aa732a4-b67f-855f-0432-290580fc239d@greensocs.com>
 <87v9rufh2z.fsf@linaro.org>
 <78291aad-5c91-32a3-f0d8-f74f3a75dfbf@greensocs.com>
 <875zjm7eob.fsf@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <ec16e919-3e75-b6c7-3583-abd1b4542bcc@greensocs.com>
Date: Thu, 14 Nov 2019 15:43:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <875zjm7eob.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573742636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSVPUAxHqBpvl3GZyzNjbpozmg6Os1gmUEmn1/rfajM=;
 b=TQ9wcffMqc5dYCXCSkiAOFw0BQcTqVk1wcDkLQWaj4vDtLS4J0KIoAe1gutDgDGXYV9vCC
 d8V4QQmUBjG7fsLdPT8EKWEiZJ4x9ymbELM0K1z17P3sZKBRSRTMt3zuxKC2pMI3PC666/
 mkMCNqSTY4Jux+qw6ihngMxdweAv9Bo=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573742636; a=rsa-sha256; cv=none;
 b=SxGwecb9H/pA4HuEmFkTVBtCZvGy+mYVfInZcYii4lq8Z+lE3sVUA0O1RELIGVXsBU3ufq
 lmhNFA3dwFUa6v8XGe3Kyqz47Ev6L0jcTPgEJLlMCBVeGYSSIpZjN5Bf5cn56pqzPLwi7Y
 1gz+tJT0QxVr+kRBzyX+XVaOgL2H1J8=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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



On 11/14/19 2:47 PM, Alex Benn=C3=A9e wrote:
>=20
> Damien Hedde <damien.hedde@greensocs.com> writes:
>=20
>> On 11/8/19 5:50 PM, Alex Benn=C3=A9e wrote:
>>>
>>> Damien Hedde <damien.hedde@greensocs.com> writes:
>>>
>>>> On 11/8/19 3:09 PM, Alex Benn=C3=A9e wrote:
>>>>>
>>>>> Damien Hedde <damien.hedde@greensocs.com> writes:
>>>>>
>>>>>> Ensure we don't put too much register data in buffers. This avoids
>>>>>> a buffer overflow (and stack corruption) when a target has lots
>>>>>> of registers.
>>>>>>
>>>>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>>>>> ---
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> While working on a target with many registers. I found out the gdb=
stub
>>>>>> may do buffer overflows when receiving a 'g' query (to read genera=
l
>>>>>> registers). This patch prevents that.
>>>>>>
>>>>>> Gdb is pretty happy with a partial set of registers and queries
>>>>>> remaining registers one by one when needed.
>>>>>
>>>>> Heh I was just looking at this code with regards to SVE (which can =
get
>>>>> quite big).
>>>>
>>>> SVE ?
>>>
>>> ARM's Scalable Vector Registers which currently can get upto 16 vecto=
r
>>> quads (256 bytes) but are likely to get bigger.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Damien
>>>>>> ---
>>>>>>  gdbstub.c | 13 +++++++++++--
>>>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/gdbstub.c b/gdbstub.c
>>>>>> index 4cf8af365e..dde0cfe0fe 100644
>>>>>> --- a/gdbstub.c
>>>>>> +++ b/gdbstub.c
>>>>>> @@ -1810,8 +1810,17 @@ static void handle_read_all_regs(GdbCmdCont=
ext *gdb_ctx, void *user_ctx)
>>>>>>      cpu_synchronize_state(gdb_ctx->s->g_cpu);
>>>>>>      len =3D 0;
>>>>>>      for (addr =3D 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; ad=
dr++) {
>>>>>> -        len +=3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->me=
m_buf + len,
>>>>>> -                                 addr);
>>>>>> +        int size =3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx=
->mem_buf + len,
>>>>>> +                                     addr);
>>>>>> +        if (len + size > MAX_PACKET_LENGTH / 2) {
>>>>>> +            /*
>>>>>> +             * Prevent gdb_ctx->str_buf overflow in memtohex() be=
low.
>>>>>> +             * As a consequence, send only the first registers co=
ntent.
>>>>>> +             * Gdb will query remaining ones if/when needed.
>>>>>> +             */
>>>>>
>>>>> Haven't we already potentially overflowed gdb_ctx->mem_buf though? =
I
>>>>> suspect the better fix is for str_buf is to make it growable with
>>>>> g_string and be able to handle arbitrary size conversions (unless t=
he
>>>>> spec limits us). But we still don't want a hostile gdbstub to be ab=
le to
>>>>> spam memory by asking for registers that might be bigger than
>>>>> MAX_PACKET_LENGTH bytes.
>>>>
>>>> For gdb_ctx->mem_buf  it's ok because it has also a size of
>>>> MAX_PACKET_LENGTH. (assuming no single register can be bigger than
>>>> MAX_PACKET_LENGTH)
>>>> str_buf has a size of MAX_PACKET_LENGTH + 1
>>>
>>> Are these limits of the protocol rather than our own internal limits?
>>
>> gdb has a dynamic sized packet buffer. Remote protocol doc says:
>>
>> =E2=80=98qSupported [:gdbfeature [;gdbfeature]=E2=80=A6 ]=E2=80=99
>>     [...] Any GDB which sends a =E2=80=98qSupported=E2=80=99 packet su=
pports receiving
>> packets of unlimited length (earlier versions of GDB may reject overly
>> long responses).
>=20
> OK so it seems worth cleaning this up. I'm currently putting together a
> patch set to support these large SVE registers and I'm cleaning up the
> core gdbstub code while I go. If you are interested the current WIP
> branch is:
>=20
>   https://github.com/stsquad/qemu/commits/gdbstub/sve-registers
>=20
> but I can include you on the review CC when I post (hopefully this
> week)?

Sure. I will review what I can.
>=20
>>
>>
>>>
>>>> I'm not sure I've understood the second part but if we increase the =
size
>>>> of str_buf then we will need also a bigger packet buffer.
>>>
>>> Glib provides some nice functions for managing arbitrary sized string=
s
>>> in a nice flexible way which grow on demand. There is also a nice
>>> growable GByteArray type which we can use for the packet buffer. I th=
ink
>>> I'd started down this road of re-factoring but never got around to
>>> posting the patches.
>>>
>>>> The size here only depends on what are the target declared registers=
, so
>>>> it depends only on the cpu target code.
>>>
>>> Sure - but guest registers are growing all the time!
>>>
>>> --
>>> Alex Benn=C3=A9e
>>>
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20

--
Damien

