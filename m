Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09640C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A84206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WIctcHmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A84206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix89s-0001BQ-1l
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ix89A-0000jO-2D
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ix898-0007lI-Op
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:08 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ix898-0007je-FK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:06 -0500
Received: by mail-wr1-x441.google.com with SMTP id j104so3611542wrj.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:cc:from:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=bhkInt9r79AEuYhyosUHrzvXZsZM2oAc3Emt2SMYCm4=;
 b=WIctcHmxGDiEZcqmOR+QEsq8erTlN02GpH7c9FOm5aCxs1A41484TY74/v4jucYgSi
 5gwsQPyeE859fh3Qy3+2oBA7sU5KKc54DwapkT4h8FAVX0pu9Ci9B2ph/tPpesA11mzh
 C4OzVQ7VoKMgTLAKC45ckKDhUd3PRTZrzEPmKnSIYNCbQZaDHwBbYQWs5Bxo1SPc+IcV
 ++bfs23mVUHyuVCAHHlO4wSs2OxmACZduzbVjZxoeBBycDPyURDyVWIT9duny65WRFuO
 H8C2owTh9xAyZylyInIJeEhSaTPx9gI50+7iZRNHiA9Fj2ubgdRFkLcqQ+z+8gqZJmOD
 h11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:cc:from:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=bhkInt9r79AEuYhyosUHrzvXZsZM2oAc3Emt2SMYCm4=;
 b=m+NF37b6Y2S6XtUG40Hf0Z832GGlKJYPW99N7Yg3M71ycDOsL1Qkw4YUrVsk93aJHA
 FFASR/G9C+h67GaBhzlnkP6YjGZtzR1FCjBjBGhuIS6EJp2x+U7Ua6Su96KYMoqq6swZ
 N2occvsgxCyFO67YuczioL6q5FrT7EudxxHq1PjwZW82qutCzrDYU577XQx/KrjDldrP
 7S78xBAttfqmAGyl/EyYTm1xNSqaqXkQr3Nplmg5Sh8c2Y1UPDJRedHgMRw43oLUM6Gt
 wYfbrE3sjq07YDbUgRE5Og5WaQe47zEi5RXRlamC3QYko3StbGTZyKLM/iG/6DZJN5dE
 3LzA==
X-Gm-Message-State: APjAAAV4eiBp8yjZh8a1pm5s2huGvLe/9EeIkQkPcaxM3MB6VMV4zkir
 riZ34TsIFRY7hBPWjA7B0JypXg==
X-Google-Smtp-Source: APXvYqwJz0ev1puKtSY+USN2og4xSUWMN8L6EzzHc3O4MLMfYZn1SNHsaHIrniRwpL5fY1VzfwbNdQ==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr5229683wrv.148.1580384285000; 
 Thu, 30 Jan 2020 03:38:05 -0800 (PST)
Received: from localhost ([2a00:79e0:d:11:1da2:3fd4:a302:4fff])
 by smtp.gmail.com with ESMTPSA id o2sm5891178wmh.46.2020.01.30.03.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:38:04 -0800 (PST)
Date: Thu, 30 Jan 2020 03:38:04 -0800 (PST)
X-Google-Original-Date: Thu, 30 Jan 2020 11:38:00 GMT (+0000)
Subject: Re: [PATCH] riscv: Add semihosting support [v4]
CC: keithp@keithp.com, qemu-devel@nongnu.org, riku.voipio@iki.fi,
 laurent@vivier.eu, 
 Alistair Francis <Alistair.Francis@wdc.com>, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-riscv@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <CAFEAcA8Vs5Bp7tPgxLOG_T0350-Y_w7SitNzNuvHZN6AB=b0gg@mail.gmail.com>
References: <CAFEAcA8Vs5Bp7tPgxLOG_T0350-Y_w7SitNzNuvHZN6AB=b0gg@mail.gmail.com>
 <20200128233224.515233-1-keithp@keithp.com>
 <CAFEAcA_dD3eAfKvOGOoXe3NWKg1PiW8=s2Xk41w19Tk67R-R4A@mail.gmail.com>
 <877e1arz2w.fsf@keithp.org>
Message-ID: <mhng-e399eb36-5106-485c-972c-db2610e42dff@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 10:54:37 GMT (+0000), Peter Maydell wrote:
> On Wed, 29 Jan 2020 at 16:45, Keith Packard <keithp@keithp.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > True but irrelevant. You need to refer to a proper
>> > risc-v specification for your semihosting.
>>
>> The RISC-V Foundation defined semihosting as relative to the existing
>> ARM specification, so using a link to that is appropriate here.
>>
>> Here's the current specification of the unprivileged ISA, which includes
>> the definition of semihosting
>>
>>         https://riscv.org/specifications/
>>
>> While it may be nice in some abstract sense to create a "better"
>> semihosting spec, that's not what the RISC-V foundation has decided to
>> do.
>
> We've gone round this several times. You can't just
> say "it's the arm spec", because you're not arm and
> your architecture is different. You need to actually
> document what the architecture-specific parts are,
> even if you want to mostly say "and we follow the
> Arm spec most of the time". If you really really want
> to say "32 bit RISC-V is gratuitously different from
> 64-bit RISC-V in these areas because we just blindly
> copied the way Arm happened to have historically
> developed" then you can do that if you like, but you
> need to actually write it down in a document somewhere.
>
> You're trying to implement an ABI which has multiple
> different implementations of both consumers and
> producers; it's not a good idea to shortcut the
> process of actually writing down what the requirements
> between the two ends are.

I think, more concretely, the issues here are:

* The only mention of "semihosting" in the RISC-V specification is in the
  commentary, which is not considered a normative part of the specification.
* The interface that commentary contains is defined as maybe being obsolete
  already, but no new concrete interface is defined.
* The semihosting comment doesn't define the semihosting call numbers, just the
  sequence to get to a call.  That said, we haven't written down the Linux ABI
  either -- though there's a much larger breadth of software out there that
  implements it and won't break ABI compatibility, so maybe that's considered
  sufficient in Linux land where it's not for semihosting.

It seems to me like the right way to go forward is to put together a
semihosting ABI specification as a RISC-V specification.  That would give
everyone who cares about their pre-specification implementations a chance to
get together to figure out which parts they want to keep, and give us a path to
move forwards.  There's more work that needs to be done here to put together a
system that will actually work (for example, how to we insert breakpoints if
we're using ebreak to indicate semihosting and haven't reserved NOP
sequences?), so this does warrant a bit of thought.

I know it's a bit of a headache in the short term to get a specification
together, but we've had so many headaches of the "there's no spec" sort that at
least it'll be a change of pace :)

>
> thanks
> -- PMM


