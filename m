Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8337DC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A11920757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZmHsiAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A11920757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJyzq-0007QU-C7
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJyz1-0006V3-Oy
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJyyy-0002lB-Ea
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:30:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59331
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJyyy-0002ky-AA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585830603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfTQt9qXJWo5tpZTcTcOcx/e7CKs7JhHS4AHY5UWQaI=;
 b=BZmHsiASw8TzH24FX8LE1XuwxB810cmFvDVn3DZm2U/+laZnTiUGgOsB4QOcyzSsQOSv3y
 x/Qe85TyObFA1Z/UVLBC+pCeZY7ZaqRDCx7RWP142kL8nf0+nC27WALhBVm82doIT0qbpJ
 xULE6FYxfpbcZXEBmTx1oaSoI0tat9s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-i4ylkx2lPMOrSq-XsX5xWw-1; Thu, 02 Apr 2020 08:30:02 -0400
X-MC-Unique: i4ylkx2lPMOrSq-XsX5xWw-1
Received: by mail-ed1-f69.google.com with SMTP id g7so2577381edm.20
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 05:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sfTQt9qXJWo5tpZTcTcOcx/e7CKs7JhHS4AHY5UWQaI=;
 b=Cor4YKgjL62AXPM1cucNbqM+PLScgSIBG7A2QnoqPidPq3Qz41yH7hjzmH0avIh/uT
 ejr2DZ2EcQVXdsOqyNQfFcd2tu+1ZmQIPVLO652gAKebnH6bxtIg0ehNm9pdrAbKTrie
 WykVtNG9+BEmJXn9L6nRF8mcRHq5yn5Z6cyH8ff63rHiN65PhIX46owv3qOjHX49Z9ms
 1fCSohPL3mcRvn/Wh0bstu1gjhN+aWHjhBlanYrY5G0If4/NBvCzv2AmUlxBqcFYrp52
 bBfGWRgqbZEfXq3zZUprW0HeGWE34JKEgih7uC38oozH//VKePiv6pBVlvzXzyHMEhTB
 FEpg==
X-Gm-Message-State: AGi0Pua0AMS/FDtAtrayNYUzZIWTcXYJskZ26XYXVne6ktODWCwEHG3E
 kaPd4KVKsLVO8U8MPbsHEHm0Ayr7Y1YwCkxqrlMZuDp6D5TRDjYzo4vTqz5mt9Oc2zYT1h90D2M
 CdN0TS9r3pEQyayc=
X-Received: by 2002:a17:906:1f47:: with SMTP id
 d7mr3072786ejk.37.1585830600899; 
 Thu, 02 Apr 2020 05:30:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypKeX80pPa9C8222VOnI4cbLnWdZF59G6LnRfdsFiMxtknkGafsO/lIettCfSY1oLiuIUKS8LA==
X-Received: by 2002:a17:906:1f47:: with SMTP id
 d7mr3072756ejk.37.1585830600621; 
 Thu, 02 Apr 2020 05:30:00 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d27sm1066779ejo.72.2020.04.02.05.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 05:30:00 -0700 (PDT)
Subject: Re: Function-like macro with the same name as a typedef confuses
 Coccinelle
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87k12y5by1.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <31eed279-5ef9-4d11-62de-51c0eeaff589@redhat.com>
Date: Thu, 2 Apr 2020 14:29:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87k12y5by1.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 2:06 PM, Markus Armbruster wrote:
> I discovered that Vladimir's auto-propagated-errp.cocci leaves
> hw/arm/armsse.c unchanged, even though it clearly should change it.
> Running spatch with --debug prints (among lots of other things)
> 
>      let's go
>      -----------------------------------------------------------------------
>      -----------------------------------------------------------------------
>      parse error
>       = error in hw/arm/armsse.c; set verbose_parsing for more info
>      badcount: 7
>      bad: }
>      bad:
>      bad: static void nsccfg_handler(void *opaque, int n, int level)
>      bad: {
>      BAD:!!!!!     ARMSSE *s = ARMSSE(opaque);
>      bad:
>      bad:     s->nsccfg = level;
>      bad: }
>      parse error
> 
> Alright, what's wrong with this?  ARMSSE is both a function-like macro
> and a typedef:
> 
>      #define ARMSSE(obj) OBJECT_CHECK(ARMSSE, (obj), TYPE_ARMSSE)
> 
>      typedef struct ARMSSE {
>          ...
>      } ARMSSE;
> 
> This appears to spook Coccinelle badly enough to skip code using ARMSSE.
> 
> If I rename the macro to ARMSSE_() just for testing, it produces the
> transformation I'd expect.
> 
> Grepping for typedef names is bothersome, so I used ctags -x to build a
> cross reference table, and searched that for function-like macros
> clashing with typedefs.  Result:
> 
> include/hw/arm/armsse.h:#define ARMSSE(obj) OBJECT_CHECK(ARMSSE, (obj), TYPE_ARMSSE)
> include/hw/arm/armsse.h:} ARMSSE;
> include/hw/block/swim.h:#define SWIM(obj) OBJECT_CHECK(SWIM, (obj), TYPE_SWIM)
> include/hw/block/swim.h:} SWIM;
> target/rx/cpu-qom.h:#define RXCPU(obj) \
> target/rx/cpu.h:typedef struct RXCPU RXCPU;
> target/s390x/translate.c:#define BD(N, BB, BD) { BB,  4, 0, FLD_C_b##N, FLD_O_b##N }, \
> hw/audio/ac97.c:} BD;
> 
> The last one is a name clash in unrelated files; should not bother
> Coccinelle.
> 
> The first three are due to QOM.  By convention, the name of the
> function-like macro to convert to the QOM type is the QOM type in
> ALL_CAPS.  Clash when the QOM type is ALL_CAPS already.

To add to this list, another problem I'm having is with QOM interfaces.

For example this line:

   isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2));

The definitions are:

#define ISADMA(obj) INTERFACE_CHECK(IsaDma, (obj), TYPE_ISADMA)
typedef struct IsaDma IsaDma;

This is used as opaque pointer, so it compiles fine, but coccinelle is 
confused because the actual 'struct IsaDma' is never defined.

The only 'documentation' I found about this is commit 00ed3da9b5 which 
describes this as 'common practice'.

> 
> Clearly, Coccinelle is getting spooked to easily.  Regardless, three
> questions:
> 
> 1. Are ALL_CAPS typedef names a good idea?  We shout macros to tell
> readers "beware, possibly magic".  Shouting other stuff as well
> undermines that.
> 
> 2. The compiler is quite cool with us using the same name for a
> function-like macro and a not-function-like non-macro.  But is it a good
> idea?
> 
> 3. Do we want to work around Coccinelle's parsing flaw?  Having it skip
> so much code is clearly suboptimal, and potentially dangerous.  The
> obvious work-around is to rename the three problematic types so they
> contain at least one lower-case letter.


