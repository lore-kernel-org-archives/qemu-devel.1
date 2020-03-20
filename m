Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A485FC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B46820739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOICcVZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B46820739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFDn3-0007bv-FW
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 05:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jFDmT-0007C6-RZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jFDmS-000795-7z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:17:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jFDmR-00077F-Td
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:17:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id h9so6470067wrc.8
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=h3vMhOANxcPsV31YqVmNqQFw9idOpZWiwbHYTPT56yc=;
 b=xOICcVZ8iB77qwsxSASDO76QttylmRwuXV3t4H3Fxz37tZ7d0dS1BFPYdWPgHfFT0K
 1zvTxeoXQ4nK+vkD4Aod5yN+FN3hmmkd+dPLDb5rYtegFlMyIYkzkBGWLODkb9do+kuc
 jVYSzVyo4ol3UxaaU3n/hYAz0e1eUW/CWZD0Dh+5e/LCCf886Bj45gKlgKY/GEg/Qhpb
 8HD5rutgG4+KlxOYuR0mTOhswE4F9u0F+vypiom+hJnmtCjEIGuJoBaDqKisU7J0rSbb
 ewBZ5ox0cfmKKQTOQuOhmiZ7Sea+jAqoy1yPn4BwG5DGBIo5aZRpyxSywGN/3U1oj4kw
 OZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=h3vMhOANxcPsV31YqVmNqQFw9idOpZWiwbHYTPT56yc=;
 b=FauqbXse+FGJ6uxeqpkg9jDzRiK2t+y7GpL0uZmrETmepAyG+dM/+Pwt/8vu1SLq/0
 hkHD7124ucL55tmrIX0QWujLqYgiif2KGL70SGCvQM4XGxjtBIWLXrF9FbFTI93dDxJP
 ICoDr+G5Yn+J/3GJcI1bGgVE/br1A559m/8u6tuuSpgnU/RvDjtsVvaZCucIioGc6nUV
 rMYGtW7N6zom5LtivFKuNJmKyRW8VVagMpx/Xjjcm5GOLzfk6USsuYLbfdU7Hm++Eol/
 FVyCeB9szti/UpGXbB6k+SUBtVrKMldN1gqxlIUYCqRjlgPo1PSekEFbyBfVk1Hnu/GE
 b2vQ==
X-Gm-Message-State: ANhLgQ0M28m8s2Uecs7cNqNW1BHAZdBBHTvw52cbUGo1msp5bLwTkvsT
 uGd3jA9eUFr5iW0Tx57z/OHGNw==
X-Google-Smtp-Source: ADFU+vvH3TUmRpULgXd2X6EYtmdBaO6WI7IJOv6lYEMp+JlumW0jcUOnevbk9QQd+FSZ1/Ayp4Pz0w==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr10136802wro.207.1584695846262; 
 Fri, 20 Mar 2020 02:17:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f14sm6237866wmb.3.2020.03.20.02.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 02:17:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D1E3E1FF7E;
 Fri, 20 Mar 2020 09:17:23 +0000 (GMT)
References: <20200307010051.97022-1-yuanzi@google.com>
 <CADjx4CKDPY9J7Zr1YTLv78Ku6mQS6zrMu7oX7-ujU3PGxvHA4w@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lirong Yuan <yuanzi@google.com>
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
In-reply-to: <CADjx4CKDPY9J7Zr1YTLv78Ku6mQS6zrMu7oX7-ujU3PGxvHA4w@mail.gmail.com>
Date: Fri, 20 Mar 2020 09:17:23 +0000
Message-ID: <87imizidwc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Josh Kunz <jkz@google.com>,
 Philippe =?utf-8?Q?Mathieu-Da?= =?utf-8?Q?ud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Lirong Yuan <yuanzi@google.com> writes:

> On Fri, Mar 6, 2020 at 5:01 PM Lirong Yuan <yuanzi@google.com> wrote:
>
>> This allows gdb to access the target=E2=80=99s auxiliary vector,
>> which can be helpful for telling system libraries important details
>> about the hardware, operating system, and process.
>>
>> Signed-off-by: Lirong Yuan <yuanzi@google.com>
>> ---
>>  gdbstub.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index 22a2d630cd..a946af7007 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -2105,6 +2105,12 @@ static void handle_query_supported(GdbCmdContext
>> *gdb_ctx, void *user_ctx)
>>          pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
>>                  ";qXfer:features:read+");
>>      }
>> +#ifdef CONFIG_USER_ONLY
>> +    if (gdb_ctx->s->c_cpu->opaque) {
>> +        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
>> +                ";qXfer:auxv:read+");
>> +    }
>> +#endif
>>
>>      if (gdb_ctx->num_params &&
>>          strstr(gdb_ctx->params[0].data, "multiprocess+")) {
>> @@ -2166,6 +2172,47 @@ static void
>> handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
>>      put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
>>  }
>>
>> +#ifdef CONFIG_USER_ONLY
>> +static void handle_query_xfer_auxv(GdbCmdContext *gdb_ctx, void *user_c=
tx)
>> +{
>> +    TaskState *ts;
>> +    unsigned long offset, len, saved_auxv, auxv_len;
>> +    const char *mem;
>> +
>> +    if (gdb_ctx->num_params < 2) {
>> +        put_packet(gdb_ctx->s, "E22");
>> +        return;
>> +    }
>> +
>> +    offset =3D gdb_ctx->params[0].val_ul;
>> +    len =3D gdb_ctx->params[1].val_ul;
>> +
>> +    ts =3D gdb_ctx->s->c_cpu->opaque;
>> +    saved_auxv =3D ts->info->saved_auxv;
>> +    auxv_len =3D ts->info->auxv_len;
>> +    mem =3D (const char *)(saved_auxv + offset);
>> +
>> +    if (offset >=3D auxv_len) {
>> +        put_packet(gdb_ctx->s, "E22");
>> +        return;
>> +    }
>> +
>> +    if (len > (MAX_PACKET_LENGTH - 5) / 2) {
>> +        len =3D (MAX_PACKET_LENGTH - 5) / 2;
>> +    }
>> +
>> +    if (len < auxv_len - offset) {
>> +        gdb_ctx->str_buf[0] =3D 'm';
>> +        len =3D memtox(gdb_ctx->str_buf + 1, mem, len);
>> +    } else {
>> +        gdb_ctx->str_buf[0] =3D 'l';
>> +        len =3D memtox(gdb_ctx->str_buf + 1, mem, auxv_len - offset);
>> +    }
>> +
>> +    put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
>> +}
>> +#endif
>> +
>>  static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ct=
x)
>>  {
>>      put_packet(gdb_ctx->s, GDB_ATTACHED);
>> @@ -2271,6 +2318,14 @@ static GdbCmdParseEntry gdb_gen_query_table[] =3D=
 {
>>          .cmd_startswith =3D 1,
>>          .schema =3D "s:l,l0"
>>      },
>> +#ifdef CONFIG_USER_ONLY
>> +    {
>> +        .handler =3D handle_query_xfer_auxv,
>> +        .cmd =3D "Xfer:auxv:read:",
>> +        .cmd_startswith =3D 1,
>> +        .schema =3D "l,l0"
>> +    },
>> +#endif
>>      {
>>          .handler =3D handle_query_attached,
>>          .cmd =3D "Attached:",
>> --
>> 2.25.1.481.gfbce0eb801-goog
>>
>>
> Friendly ping~

Sorry I missed this on my radar. There was a minor re-factor of gdbstub
that was just merged which will mean this patch needs a re-base to use
g_string_* functions to expand stings.

Also we have some simple gdbstub tests now - could we come up with a
multiarch gdbstub test to verify this is working properly?

>
> Link to the patchwork page:
> http://patchwork.ozlabs.org/patch/1250727/


--=20
Alex Benn=C3=A9e

