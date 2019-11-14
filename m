Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94948C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6436020409
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="3178B9Mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6436020409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCGe-0002ol-DG
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iVCDj-0001DV-W8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:19:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iVCDi-0007hm-Ey
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:19:23 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:38886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iVCDh-0007dU-TP
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:19:22 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 9945596EF0;
 Thu, 14 Nov 2019 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573726758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63vYYUWDpprINMCK0qNnk+1Ba0UCWFiZtg9mSDtgwiI=;
 b=3178B9MgLp37OhpB7fOBTSv1OZLOcr4Emk6R1QmVdiUGO3uMcU/hDkm2UvXSL7VNJtUxRE
 zEoCKiQl3R0HwGQ9HIhvctnkgx2ceTVZr6T7Wf6xTThlm8Ml0yW6dETZOPcvTKUBrvjTjF
 vd1gW/CRNpfe+tple1me2wZhFUXd0i4=
Subject: Re: [PATCH] gdbstub: Fix buffer overflow in handle_read_all_regs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191108125534.114474-1-damien.hedde@greensocs.com>
 <877e4ah32n.fsf@linaro.org>
 <7aa732a4-b67f-855f-0432-290580fc239d@greensocs.com>
 <87v9rufh2z.fsf@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <78291aad-5c91-32a3-f0d8-f74f3a75dfbf@greensocs.com>
Date: Thu, 14 Nov 2019 11:19:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87v9rufh2z.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573726758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63vYYUWDpprINMCK0qNnk+1Ba0UCWFiZtg9mSDtgwiI=;
 b=fSxFdheP9IjfTlUPchD9QGQap5R7/Hav5AgAaEwIVpD3WNtYIVtjiiiRWqjJaM+o116vVy
 xp6JbJ7cxZ+hFHqZVlNMJ067F47jR9Oq3Ib35UBngkMkpBRkdXjhm/0bsSUgUjGnIQdz3u
 8qXQXPshh/IQ4/tSMnkOBaX2JsXSfwU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573726758; a=rsa-sha256; cv=none;
 b=OLwjvOEKM5tIwQDqBT/wlWv9tnslDQNFRGhizGOuPYj3Wt5IzSSJHg4tzcCTEvJVhOkfZZ
 oNMO9zwUxtiJpbRb4LsXwfd32h/IN76waIY836pXwwaUAGfrGexiPQ9NW7UbvSX8dZSOra
 gIcWxL/Tjfit8YS1576Qx2Q5du/WfVY=
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



On 11/8/19 5:50 PM, Alex Benn=C3=A9e wrote:
>=20
> Damien Hedde <damien.hedde@greensocs.com> writes:
>=20
>> On 11/8/19 3:09 PM, Alex Benn=C3=A9e wrote:
>>>
>>> Damien Hedde <damien.hedde@greensocs.com> writes:
>>>
>>>> Ensure we don't put too much register data in buffers. This avoids
>>>> a buffer overflow (and stack corruption) when a target has lots
>>>> of registers.
>>>>
>>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>>> ---
>>>>
>>>> Hi all,
>>>>
>>>> While working on a target with many registers. I found out the gdbst=
ub
>>>> may do buffer overflows when receiving a 'g' query (to read general
>>>> registers). This patch prevents that.
>>>>
>>>> Gdb is pretty happy with a partial set of registers and queries
>>>> remaining registers one by one when needed.
>>>
>>> Heh I was just looking at this code with regards to SVE (which can ge=
t
>>> quite big).
>>
>> SVE ?
>=20
> ARM's Scalable Vector Registers which currently can get upto 16 vector
> quads (256 bytes) but are likely to get bigger.
>=20
>>
>>>
>>>>
>>>> Regards,
>>>> Damien
>>>> ---
>>>>  gdbstub.c | 13 +++++++++++--
>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/gdbstub.c b/gdbstub.c
>>>> index 4cf8af365e..dde0cfe0fe 100644
>>>> --- a/gdbstub.c
>>>> +++ b/gdbstub.c
>>>> @@ -1810,8 +1810,17 @@ static void handle_read_all_regs(GdbCmdContex=
t *gdb_ctx, void *user_ctx)
>>>>      cpu_synchronize_state(gdb_ctx->s->g_cpu);
>>>>      len =3D 0;
>>>>      for (addr =3D 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr=
++) {
>>>> -        len +=3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_=
buf + len,
>>>> -                                 addr);
>>>> +        int size =3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->=
mem_buf + len,
>>>> +                                     addr);
>>>> +        if (len + size > MAX_PACKET_LENGTH / 2) {
>>>> +            /*
>>>> +             * Prevent gdb_ctx->str_buf overflow in memtohex() belo=
w.
>>>> +             * As a consequence, send only the first registers cont=
ent.
>>>> +             * Gdb will query remaining ones if/when needed.
>>>> +             */
>>>
>>> Haven't we already potentially overflowed gdb_ctx->mem_buf though? I
>>> suspect the better fix is for str_buf is to make it growable with
>>> g_string and be able to handle arbitrary size conversions (unless the
>>> spec limits us). But we still don't want a hostile gdbstub to be able=
 to
>>> spam memory by asking for registers that might be bigger than
>>> MAX_PACKET_LENGTH bytes.
>>
>> For gdb_ctx->mem_buf  it's ok because it has also a size of
>> MAX_PACKET_LENGTH. (assuming no single register can be bigger than
>> MAX_PACKET_LENGTH)
>> str_buf has a size of MAX_PACKET_LENGTH + 1
>=20
> Are these limits of the protocol rather than our own internal limits?

gdb has a dynamic sized packet buffer. Remote protocol doc says:

=E2=80=98qSupported [:gdbfeature [;gdbfeature]=E2=80=A6 ]=E2=80=99
    [...] Any GDB which sends a =E2=80=98qSupported=E2=80=99 packet suppo=
rts receiving
packets of unlimited length (earlier versions of GDB may reject overly
long responses).


>=20
>> I'm not sure I've understood the second part but if we increase the si=
ze
>> of str_buf then we will need also a bigger packet buffer.
>=20
> Glib provides some nice functions for managing arbitrary sized strings
> in a nice flexible way which grow on demand. There is also a nice
> growable GByteArray type which we can use for the packet buffer. I thin=
k
> I'd started down this road of re-factoring but never got around to
> posting the patches.
>=20
>> The size here only depends on what are the target declared registers, =
so
>> it depends only on the cpu target code.
>=20
> Sure - but guest registers are growing all the time!
>=20
> --
> Alex Benn=C3=A9e
>=20

