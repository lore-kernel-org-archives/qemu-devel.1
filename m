Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760AFC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD802082E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WipSWg3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD802082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Qlj-0004qQ-34
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 09:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Qkj-0004On-N1
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Qkf-00016L-Qq
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:06:33 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Qkf-00013v-GR
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:06:29 -0500
Received: by mail-wr1-x435.google.com with SMTP id u6so2199587wrt.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 06:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u+fQjHlf2Juu5WwaGr2n5mtnzFeKExNbyZG5Byh/KnY=;
 b=WipSWg3aZ6txad/kB+qxpMpn4JgA+Z7gy5x3LOZQKdtT6HQWTdO54NNTK7JF4Qu7WB
 1bFpBWgIh6/fbCUE3gdTSeQmEDh+KR0le+IUijuWulOkH8rPJA3/aHfN48kD8Nmwsthi
 TqaNu+kVUKj2IX5aEMlIfQYpN5N5Zp1oJHYCmAPK1x/6G3ziOEm9idkUNw20dwavCnSP
 2KqdN21VmJhNUt7grxBYl/bi7DP0peg5Kw+fAuEy6ssj8JY4ofhSaOwF8Vw9S9YS1Ucx
 TuY0U996R70Tp3S79wCudE84Dek5lW2YNxRahhcIb3R+vKeEFNM5hNfR6UFawYDB6/ad
 8D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=u+fQjHlf2Juu5WwaGr2n5mtnzFeKExNbyZG5Byh/KnY=;
 b=G9PeDKCvbXstkrhgLjvXvcIwbtXb6MA7e6jBCx4ZpNamnTP+Nyxr6F3jyYFewax0+V
 kgWk+lq8990HAhwO3eC0eu8LMCxjVD+MbQjJFW69AqDYZFkLzzBJYvH5q19quRFixUkr
 AsUd91lFau5AT0a2OJelp8NBKKDWGR/rLGulhWlyGKcdJ1TeMcoSTtjRCwRRgLpUnUE7
 qCtsrlYYjkY46fZdP4jERXpcmXFIpkyZxD3Rryan73Gvpfs8DNt7kbOAjQmWGQiDPLc+
 k0OXtlegafrgbdnAlI1u8dE50vFKA7fyKT4qAjpawiroB0CSOmco0NcCz8NfyyypbotC
 0ZGA==
X-Gm-Message-State: APjAAAVrwQAPD6RrvDkhDt6XaoCuCURZ72K79afekEy6ntpiZBoifkIq
 uyETukp/1cM5waRV0R6vYCA=
X-Google-Smtp-Source: APXvYqxmCAsD1HeTFzt0wGV3/moF0kmXG7iWbqJlMgaObtCbVtVBgia1nBBv77goSlBTSYYVNsAWNQ==
X-Received: by 2002:adf:ab1c:: with SMTP id q28mr5344025wrc.425.1581170787680; 
 Sat, 08 Feb 2020 06:06:27 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a16sm7668654wrx.87.2020.02.08.06.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Feb 2020 06:06:26 -0800 (PST)
Subject: Re: [PATCH] !fixup "target/avr: Add defintions of AVR core types"
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <1581040680-308-9-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200207112338.27754-1-philmd@redhat.com>
 <CAL1e-=jqCgakxTn1zQaNu7WqLjEien_Nd+nxQRe7NdmXKiivfw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <556ea4ff-7af6-5a84-b793-f31b8d58d202@amsat.org>
Date: Sat, 8 Feb 2020 15:06:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jqCgakxTn1zQaNu7WqLjEien_Nd+nxQRe7NdmXKiivfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 Michael Rolnik <mrolnik@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 2/8/20 8:10 AM, Aleksandar Markovic wrote:
> On Friday, February 7, 2020, Philippe Mathieu-Daudé <philmd@redhat.com
> <mailto:philmd@redhat.com>> wrote:
> 
>     These cores have unresolved review comment:
>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg674105.html
>     <https://www.mail-archive.com/qemu-devel@nongnu.org/msg674105.html>
>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg674259.html
>     <https://www.mail-archive.com/qemu-devel@nongnu.org/msg674259.html>
>     and:
>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg676046.html
>     <https://www.mail-archive.com/qemu-devel@nongnu.org/msg676046.html>
> 
>     As we don't want a bad start with this architecture, remove them.
> 
> 
> I agree with underlying motivation of your fixup.
> 
> Still, the division of AVR cores into avr1, avr2, ... , xmega7 is here
> to stay. The reason is that because such coding is a part of ELF header,
> and this means they will stay forever (as they are approved by some kind
> of ELF comitee, and are meant not to be ever changed in future).

I am not removing anything ELF related. We don't have any machine using
CPU avrtiny/avr1/avr2/avr25 so AFAIK I'm simply removing unreviewed dead
code.


> Rather than deleting definitions and references of core types we know we
> don't support (or, at least, don't fully support), let's think of some
> less intrusive way - for example, checking core type of executable given
> via CLI, and refusing to emulate, if we know we still have some issues
> with the core type in question.
> 
> For example, "avrtiny" type is missing handling the fact that it has 16
> register instead of 32 registers, like otger AVR core types. But, other
> AVRFeatures of "avrtiny" are correctly identified, and it would be a
> shame to delete them now and force someone in future to reinvent the
> wheel. Just refusing to emulate "avrtiny" seems a better approach to me.

It is hard to follow you, this port is contributed by hobbyist and you
appeared lately in the review process and asked to raised the quality to
a professional level. Now professionals are taking extra care to review
little details as the CPU features implemented by each core, and you are
saying we shouldn't delete incorrect code?

I am not saying we will never accept these cores, I'm proposing to start
with reviewed cores, so we don't delay the merge if this port. There are
already a lot of cores to use:

    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
    DEFINE_AVR_CPU_TYPE("xmega3", avr_xmega3_initfn),
    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),

Then it will be less stressful to correct/review/add the avr1/2/tiny
cores. This seems simpler than keep respining 30 patches during the next
6 months. I don't want the community to get tired and loose interest in
this port, we already spent a fair amount of time to get it merged.

Regards,

Phil.

> 
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>     Based-on:
>     <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com
>     <mailto:1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>>
> 
>     Side note: typo in the subject "definitions"
>     ---
>      target/avr/cpu.c | 96 ------------------------------------------------
>      1 file changed, 96 deletions(-)
> 
>     diff --git a/target/avr/cpu.c b/target/avr/cpu.c
>     index 8a084c750f..b3d661142d 100644
>     --- a/target/avr/cpu.c
>     +++ b/target/avr/cpu.c
>     @@ -216,77 +216,6 @@ static void avr_cpu_class_init(ObjectClass *oc,
>     void *data)
>          cc->gdb_core_xml_file = "avr-cpu.xml";
>      }
> 
>     -/*
>     - * Setting features of AVR core type avr1
>     - * --------------------------------------
>     - *
>     - * This type of AVR core is present in the following AVR MCUs:
>     - *
>     - * at90s1200, attiny11, attiny12, attiny15, attiny28
>     - */
>     -static void avr_avr1_initfn(Object *obj)
>     -{
>     -    AVRCPU *cpu = AVR_CPU(obj);
>     -    CPUAVRState *env = &cpu->env;
>     -
>     -    set_avr_feature(env, AVR_FEATURE_LPM);
>     -    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>     -    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>     -}
>     -
>     -/*
>     - * Setting features of AVR core type avr2
>     - * --------------------------------------
>     - *
>     - * This type of AVR core is present in the following AVR MCUs:
>     - *
>     - * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26,
>     at90s4414,
>     - * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
>     - */
>     -static void avr_avr2_initfn(Object *obj)
>     -{
>     -    AVRCPU *cpu = AVR_CPU(obj);
>     -    CPUAVRState *env = &cpu->env;
>     -
>     -    set_avr_feature(env, AVR_FEATURE_LPM);
>     -    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>     -    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>     -    set_avr_feature(env, AVR_FEATURE_SRAM);
>     -    set_avr_feature(env, AVR_FEATURE_BREAK);
>     -
>     -    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>     -    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>     -}
>     -
>     -/*
>     - * Setting features of AVR core type avr25
>     - * --------------------------------------
>     - *
>     - * This type of AVR core is present in the following AVR MCUs:
>     - *
>     - * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a,
>     attiny24,
>     - * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84,
>     attiny84a,
>     - * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461,
>     attiny461a,
>     - * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88,
>     attiny828,
>     - * attiny841, at86rf401
>     - */
>     -static void avr_avr25_initfn(Object *obj)
>     -{
>     -    AVRCPU *cpu = AVR_CPU(obj);
>     -    CPUAVRState *env = &cpu->env;
>     -
>     -    set_avr_feature(env, AVR_FEATURE_LPM);
>     -    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>     -    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>     -    set_avr_feature(env, AVR_FEATURE_SRAM);
>     -    set_avr_feature(env, AVR_FEATURE_BREAK);
>     -
>     -    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>     -    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>     -    set_avr_feature(env, AVR_FEATURE_LPMX);
>     -    set_avr_feature(env, AVR_FEATURE_MOVW);
>     -}
>     -
>      /*
>       * Setting features of AVR core type avr3
>       * --------------------------------------
>     @@ -499,27 +428,6 @@ static void avr_avr6_initfn(Object *obj)
>          set_avr_feature(env, AVR_FEATURE_MUL);
>      }
> 
>     -/*
>     - * Setting features of AVR core type avrtiny
>     - * --------------------------------------
>     - *
>     - * This type of AVR core is present in the following AVR MCUs:
>     - *
>     - * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
>     - */
>     -static void avr_avrtiny_initfn(Object *obj)
>     -{
>     -    AVRCPU *cpu = AVR_CPU(obj);
>     -    CPUAVRState *env = &cpu->env;
>     -
>     -    set_avr_feature(env, AVR_FEATURE_LPM);
>     -    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>     -    set_avr_feature(env, AVR_FEATURE_BREAK);
>     -
>     -    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>     -    set_avr_feature(env, AVR_FEATURE_1_BYTE_SP);
>     -}
>     -
>      /*
>       * Setting features of AVR core type xmega2
>       * --------------------------------------
>     @@ -754,10 +662,6 @@ static const TypeInfo avr_cpu_type_info[] = {
>              .class_init = avr_cpu_class_init,
>              .abstract = true,
>          },
>     -    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
>     -    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
>     -    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
>     -    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
>          DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
>          DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
>          DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
>     -- 
>     2.21.1
> 

