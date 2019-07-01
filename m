Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D00DC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B35620665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlOuCE9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B35620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhx8h-0004D4-2l
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42772)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hhwQr-0000OW-GX
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hhwQo-0006ZB-VE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:33:20 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hhwQn-0006V2-U4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:33:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so13891323wrm.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gZ8QQoOMD4Dac54oipBU4JVQraIx3GI7A22osVYTtns=;
 b=OlOuCE9NdN/x/UXGCYCG9EJew2Al5TXA6beznrUU2p9QZv9h36TAwGW+V6zqlhQrix
 CS87nlkbRCXCbMikTei0Nks8LXkriFh2qcouYUNgakMyrol+IVbvqv54W2xbRTSZON4r
 ObF2oLyaBUFg8/sbhHqL+OoYjl+OM2ge4kAyU0Gjo1W1PlfJOstqC1aOQdWpNK5CIG8w
 o2/oyREs4KGlX3amX7eRaI3Zh7ELJEv+XWpPNXklYy0iZyo8v9/GLvgTVb0qL0bcqoMO
 a/ZxBSm2jYtxxcucAToAF3obQOtvE8yppoLfy03q7yRkNz5lNM2zBqnZD4C7ZdA+CoiF
 VWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gZ8QQoOMD4Dac54oipBU4JVQraIx3GI7A22osVYTtns=;
 b=ce8EKwMUY9gaCRAwqPFHj3cypFFEB1gUXJFdbT7N+p0c/P6GzzWyv5vtwPhJT1LdY8
 qsdvjb6ELT5vrXzUTp+FL3rqDRsub5C/Q5J88COEeWiND5l8ff70a+jGLcp+6AFD+FQA
 YqDhJJ3oKCEsNIxTv/2mVSwQvqGtn9KWTQ6r9ej4D1kZZYCG4f7Zj6PFLDJco/KcsdIH
 BBcpni0gYayyWi7m0MIr2vYn2OjYj6UevRdiVaiOSF7D77ICby3InSMYBR+JOkITexmc
 dFzwtFapmT+0s2uyDxDY4sNGqRda8a60sOB2uQ5w/YsCJbq0H0ODXOn1Se5ss6YQ4dOU
 j7jg==
X-Gm-Message-State: APjAAAXyGcIlt1WOuR/UdJslb6P7UgSJx+77mKCa3DJGpZiFE4881sDz
 s+1jfFbmPe4YuzhK5JwylmmxYg==
X-Google-Smtp-Source: APXvYqxiQmWF5WmEdysprk0Zw+r9Oas4VyZW6pu5SPClhoFo+EySRi6u0tKdGODz/3b3pEOJ2WdzPg==
X-Received: by 2002:adf:fa4c:: with SMTP id y12mr18988475wrr.282.1561987992168; 
 Mon, 01 Jul 2019 06:33:12 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o11sm11549386wmh.37.2019.07.01.06.33.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 06:33:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 363EA1FF87;
 Mon,  1 Jul 2019 14:33:11 +0100 (BST)
References: <20190628113917.15869-1-luc.michel@greensocs.com>
 <f9c429e1-4a1d-959a-04c4-e9b7e94637cf@linaro.org>
 <20190701131933.GA2840@toto>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190701131933.GA2840@toto>
Date: Mon, 01 Jul 2019 14:33:11 +0100
Message-ID: <87blydswvc.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [RFC PATCH] accel/tcg/translator: add tb_enter TCG
 trace
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
Cc: damien.hedde@greensocs.com,
 Richard Henderson <richard.henderson@linaro.org>, mark.burton@greensocs.com,
 sakisp@xilinx.com, edgari@xilinx.com, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Edgar E. Iglesias <edgar.iglesias@xilinx.com> writes:

> On Fri, Jun 28, 2019 at 02:16:41PM +0200, Richard Henderson wrote:
>> On 6/28/19 1:39 PM, Luc Michel wrote:
>> > Add a TCG trace at the begining of a translation block recording the
>> > first and last (past-the-end) PC values.
>> >
>> > Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>> > ---
>> > This can be used to trace the execution of the guest quite efficiently.
>> > It will report each time a TB is entered (using the tb_enter_exec
>> > trace). The traces arguments give the PC start and past-the-end values.
>> > It has very little to no performance impact since the trace is actually
>> > emitted in the generated code only when it is enabled at run time.
>> >
>> > It works already quite well on its own to trace guest execution. Howev=
er
>> > it does not handle the case where a TB is exited in the middle of
>> > execution. I'm not sure how to properly trace that. A trace could be
>> > added when `cpu_loop_exit()' is called to report the current PC, but in
>> > most cases the interesting value (the PC of the instruction that
>> > caused the exit) is already lost at this stage.
>> >
>> > I'm not sure there is a generic (i.e. not target specific) way of
>> > recovering the last PC executed when cpu_loop_exit() is called. Do you
>> > think of a better way?
>> >
>> > Thanks to the Xilinx's QEMU team who sponsored this work.
>> > ---
>> >  accel/tcg/translator.c | 24 ++++++++++++++++++++++++
>> >  trace-events           |  3 +++
>> >  2 files changed, 27 insertions(+)
>> >
>> > diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
>> > index 9226a348a3..c55377aa18 100644
>> > --- a/accel/tcg/translator.c
>> > +++ b/accel/tcg/translator.c
>> > @@ -14,10 +14,11 @@
>> >  #include "tcg/tcg-op.h"
>> >  #include "exec/exec-all.h"
>> >  #include "exec/gen-icount.h"
>> >  #include "exec/log.h"
>> >  #include "exec/translator.h"
>> > +#include "trace-tcg.h"
>> >
>> >  /* Pairs with tcg_clear_temp_count.
>> >     To be called by #TranslatorOps.{translate_insn,tb_stop} if
>> >     (1) the target is sufficiently clean to support reporting,
>> >     (2) as and when all temporaries are known to be consumed.
>> > @@ -28,14 +29,31 @@ void translator_loop_temp_check(DisasContextBase *=
db)
>> >          qemu_log("warning: TCG temporary leaks before "
>> >                   TARGET_FMT_lx "\n", db->pc_next);
>> >      }
>> >  }
>> >
>> > +static TCGOp *gen_trace_tb_enter(TranslationBlock *tb)
>> > +{
>> > +    TCGOp *last_pc_op;
>> > +
>> > +    TCGv pc_end =3D tcg_temp_new();
>> > +
>> > +    /* The last PC value is not known yet */
>> > +    tcg_gen_movi_tl(pc_end, 0xdeadbeef);
>> > +    last_pc_op =3D tcg_last_op();
>>
>> TL is a target-specific type that does not necessarily correspond to uin=
t64_t,
>> as you assume in the print message.  More importantly, on a 32-bit host =
with a
>> 64-bit guest, this movi will generate *two* ops...
>>
>> > +    /* Fixup the last PC value in the tb_enter trace now that we know=
 it */
>> > +    tcg_set_insn_param(trace_pc_end, 1, db->pc_next);
>>
>> ... which means that this operation does not do what you think it does. =
 It
>> will only set one (unknown) half of the _i64 temporary.
>>
>> Moreover, this isn't quite as zero overhead as I would like, because the=
 pc_end
>> temporary is always created, even if the trace_tb condition is not satis=
fied
>> and so it (eventually) gets removed as unused.
>>
>> I'm not quite sure what you're after with pc_end anyway.  As you note wi=
thin
>> the cover, you can't reliably use it for anything.  If you remove that, =
then
>> you've also removed all of the other problems with this patch.
>>
>
> Hi,
>
> One of the use cases is to be able to collect code-coverage from these tr=
aces.
> In that case we're going to need a reliable pc_end. We may need to recove=
r it
> from outside of TCG in some cases though...

Why?

The only place you need to recover pc_end is when processing an
exception and for that case the front end should be using
cpu_loop_exit_restore() to ensure registers are valid before the
exception is processed. Otherwise you know where you've been given the
next block starts at pc_next (with -d nochain).

However I suspect if you want to build more sophisticated tools to track
execution the plugin approach might be better. This seems like a bit of
an arbitrary addition to the TCG core for a single use case where we
already have logging facilities that will give you the same information.

--
Alex Benn=C3=A9e

