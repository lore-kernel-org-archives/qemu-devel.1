Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D03C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9D5215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="fAoa+ebF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9D5215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5ft-0000p3-8t
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iT5ch-00084D-AS
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iT5cf-00068r-So
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:52:27 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:59986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iT5cf-00068d-JE
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:52:25 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 8A8D896EF0;
 Fri,  8 Nov 2019 14:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573224743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DNOQ7vsYv2z6bevm4oIlQT8k2RPxSG1KI7v84PEqb4=;
 b=fAoa+ebF9Iq2mPSUnIW7RQUx5KdvkDrCN1xyklY38AxKW92+evyQu0uB2r2Zqa13mAmhQa
 Z3LGr1G11k/m1AFajLJkV0jyCynl/qHKYUpHXKJT8GrH0gmBhbATySrsjqNW+pGMYDa3G1
 yyHl+YArkqWUgMBSTiQZPxB8pevS0Zk=
Subject: Re: [PATCH] gdbstub: Fix buffer overflow in handle_read_all_regs
From: Damien Hedde <damien.hedde@greensocs.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191108125534.114474-1-damien.hedde@greensocs.com>
 <877e4ah32n.fsf@linaro.org>
 <7aa732a4-b67f-855f-0432-290580fc239d@greensocs.com>
Message-ID: <2be19dae-bc42-972c-18d9-ab332e98c825@greensocs.com>
Date: Fri, 8 Nov 2019 15:52:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <7aa732a4-b67f-855f-0432-290580fc239d@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573224743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DNOQ7vsYv2z6bevm4oIlQT8k2RPxSG1KI7v84PEqb4=;
 b=us3D3rbpqx3ST2cqThYBZCMiYUw7rsq6LCYktijR10y8xFnh1druNmhBvq1+sYfmAs0Z1n
 EDCbguV21I53ViuIcmqrURmg9zB7Pw467hTfFu30J+STVfkv+N+qXK8nxuGhyMqgkgGzmk
 4lxeHW0RQqejLpeXDdfq55RMqs0xa5k=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573224743; a=rsa-sha256; cv=none;
 b=uOv8481B9JFkB/wsUEikoA5QXVgIE1UWCPWzTzRCdlcT9WkKReSVSE/bgssmcS56dH1VpX
 452eUmE3v8tTPCoVJxUtmR9wC8q9UfU+XsFRmG/gsJOZQ9kSHTmhRJC1OqDaZNr2iLz4H+
 jyjnw9vOLNBmj+Buo6pqVAhSWmaKcMw=
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/8/19 3:43 PM, Damien Hedde wrote:
>=20
>=20
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
>>> While working on a target with many registers. I found out the gdbstu=
b
>>> may do buffer overflows when receiving a 'g' query (to read general
>>> registers). This patch prevents that.
>>>
>>> Gdb is pretty happy with a partial set of registers and queries
>>> remaining registers one by one when needed.
>>
>> Heh I was just looking at this code with regards to SVE (which can get
>> quite big).
>=20
> SVE ?
>=20
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
>>> @@ -1810,8 +1810,17 @@ static void handle_read_all_regs(GdbCmdContext=
 *gdb_ctx, void *user_ctx)
>>>      cpu_synchronize_state(gdb_ctx->s->g_cpu);
>>>      len =3D 0;
>>>      for (addr =3D 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr+=
+) {
>>> -        len +=3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_b=
uf + len,
>>> -                                 addr);
>>> +        int size =3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->m=
em_buf + len,
>>> +                                     addr);
>>> +        if (len + size > MAX_PACKET_LENGTH / 2) {
>>> +            /*
>>> +             * Prevent gdb_ctx->str_buf overflow in memtohex() below=
.
>>> +             * As a consequence, send only the first registers conte=
nt.
>>> +             * Gdb will query remaining ones if/when needed.
>>> +             */
>>
>> Haven't we already potentially overflowed gdb_ctx->mem_buf though? I
>> suspect the better fix is for str_buf is to make it growable with
>> g_string and be able to handle arbitrary size conversions (unless the
>> spec limits us). But we still don't want a hostile gdbstub to be able =
to
>> spam memory by asking for registers that might be bigger than
>> MAX_PACKET_LENGTH bytes.
>=20
> For gdb_ctx->mem_buf  it's ok because it has also a size of
> MAX_PACKET_LENGTH. (assuming no single register can be bigger than
> MAX_PACKET_LENGTH)
sorry, it is MAX_PACKET_LENGTH / 2 for the max single register allowed si=
ze.

> str_buf has a size of MAX_PACKET_LENGTH + 1
>=20
> I'm not sure I've understood the second part but if we increase the siz=
e
> of str_buf then we will need also a bigger packet buffer.
>=20
> The size here only depends on what are the target declared registers, s=
o
> it depends only on the cpu target code.
>=20
>>
>>> +            break;
>>> +        }
>>> +        len +=3D size;
>>>      }
>>>
>>>      memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
>>
>>
>> --
>> Alex Benn=C3=A9e
>>
>=20

