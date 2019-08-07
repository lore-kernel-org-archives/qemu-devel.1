Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCF9C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 21:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81312186A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 21:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvFAtpan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81312186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvTV7-0001tC-TT
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 17:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41997)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvTUS-0001TB-4t
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 17:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvTUQ-00019u-EO
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 17:29:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvTUQ-00018a-6o
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 17:28:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so92786851wru.13
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=izxNZnbbDz/T+JBIs6ekxsgwiECR4e+n2K0yZaz1Ww0=;
 b=nvFAtpanAeUopHKlSzyNBh/4u+69UlP3woQIlY9ZBpmJYhn1QY1xf1Fj4lDiP0PH9X
 ZqX0Jemo84oX76zDa6y+Viynjk4IoHMzH1cRbphGEC1aUw0PTD5jxB/GSFw8j+JNJRJz
 oKQUzpUESAjlC4pQruK5IB03j+03CtpCHGNigY1IQU6jfA1mx8/lPAz17OSxMgBN2rph
 wW9wWFW32WlOnK3ppmMOIx0zNCchbKeSm3x7cXzOcYqFzMNVhM6MLv4N79kaBnmvnRnN
 sy5RKJvEaG343JXGw99w4IAD2Kvq6WiZw+PnhxK9V8OM113dnhZtHZGl1jU9fvvgSzOR
 WCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=izxNZnbbDz/T+JBIs6ekxsgwiECR4e+n2K0yZaz1Ww0=;
 b=j+udUqD2XawnOnsgjx4lGfnBBdmmeKx+gZeOJ/IFPIxu7S0TrwGRVeJ378ST1A8kx2
 Y2m97OZ9ppoFpTjvIxtuy0B2SoxTxW7qLzTQKhe6lMMYIx5/E9ZXNAlMrtLZ1t1Cmn1Q
 ydHqYPAOOdN/NBmzHpcksSoyWX+aVvDhmtaaq0VE31V/Z91FoykK7DyWJNxfQMjQTfog
 4/cjsdpALsJrXGlVmcOoE5diV0uLfMWk0GpcnIXo1YnGeCJIZTRLerF8ZagzOF9XRe+6
 CjJ2rr8r4BR69UwZlRTTw0yyn0QcZih8MaXfPqtOE9Nheti00ZePRZ2/N9+T/lGw2gNx
 mnpA==
X-Gm-Message-State: APjAAAVJ4WAfym7/spaIW4YBPbuOXfB0WMhM4kldMj9md5QUV8ppvLyw
 09d0LjvaZjmp2olrmhbow9h2L5C/x1A=
X-Google-Smtp-Source: APXvYqz4amO8XmfttJ4U9xc8/Da9eblNVwnw0QkBRf2CvdTesrr1cpWGNj6FTpag/IxoN3YyCKgv8A==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr12824706wrn.165.1565213336090; 
 Wed, 07 Aug 2019 14:28:56 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c78sm277852wmd.16.2019.08.07.14.28.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 14:28:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D82501FF87;
 Wed,  7 Aug 2019 22:28:54 +0100 (BST)
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-2-armbru@redhat.com> <87k1bphvbq.fsf@linaro.org>
 <87woforc8d.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
In-reply-to: <87woforc8d.fsf@dusky.pond.sub.org>
Date: Wed, 07 Aug 2019 22:28:54 +0100
Message-ID: <878ss4is15.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 01/29] include: Make headers more
 self-contained
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
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Back in 2016, we discussed[1] rules for headers, and these were
>>> generally liked:
>>>
>>> 1. Have a carefully curated header that's included everywhere first.  We
>>>    got that already thanks to Peter: osdep.h.
>>>
>>> 2. Headers should normally include everything they need beyond osdep.h.
>>>    If exceptions are needed for some reason, they must be documented in
>>>    the header.  If all that's needed from a header is typedefs, put
>>>    those into qemu/typedefs.h instead of including the header.
>>>
>>> 3. Cyclic inclusion is forbidden.
>>>
>>> This patch gets include/ closer to obeying 2.
>>>
>>> It's actually extracted from my "[RFC] Baby steps towards saner
>>> headers" series[2], which demonstrates a possible path towards
>>> checking 2 automatically.  It passes the RFC test there.
>>>
>>> [1] Message-ID: <87h9g8j57d.fsf@blackfin.pond.sub.org>
>>>     https://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg03345.h=
tml
>>> [2] Message-Id: <20190711122827.18970-1-armbru@redhat.com>
>>>     https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg02715.h=
tml
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>> <snip>
>>>  include/exec/cputlb.h                 | 2 ++
>>>  include/exec/exec-all.h               | 1 +
>>>  include/exec/ioport.h                 | 2 ++
>>>  include/exec/memory-internal.h        | 2 ++
>>>  include/exec/ram_addr.h               | 1 +
>>>  include/exec/softmmu-semi.h           | 2 ++
>>>  include/exec/tb-hash.h                | 2 ++
>>>  include/exec/user/thunk.h             | 1 +
>>>  include/fpu/softfloat-macros.h        | 2 ++
>> <snip>
>>>
>>>  /*
>>>   * bdrv_write_threshold_set:
>>> diff --git a/include/disas/disas.h b/include/disas/disas.h
>>> index 15da511f49..ba47e9197c 100644
>>> --- a/include/disas/disas.h
>>> +++ b/include/disas/disas.h
>>> @@ -1,6 +1,7 @@
>>>  #ifndef QEMU_DISAS_H
>>>  #define QEMU_DISAS_H
>>>
>>> +#include "exec/hwaddr.h"
>>>
>>>  #ifdef NEED_CPU_H
>>>  #include "cpu.h"
>>> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
>>> index 5373188be3..23abd71579 100644
>>> --- a/include/exec/cputlb.h
>>> +++ b/include/exec/cputlb.h
>>> @@ -19,6 +19,8 @@
>>>  #ifndef CPUTLB_H
>>>  #define CPUTLB_H
>>>
>>> +#include "exec/cpu-common.h"
>>> +
>>>  #if !defined(CONFIG_USER_ONLY)
>>>  /* cputlb.c */
>>>  void tlb_protect_code(ram_addr_t ram_addr);
>>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>>> index 16034ee651..135aeaab0d 100644
>>> --- a/include/exec/exec-all.h
>>> +++ b/include/exec/exec-all.h
>>> @@ -20,6 +20,7 @@
>>>  #ifndef EXEC_ALL_H
>>>  #define EXEC_ALL_H
>>>
>>> +#include "cpu.h"
>>>  #include "exec/tb-context.h"
>>>  #include "sysemu/cpus.h"
>>>
>>> diff --git a/include/exec/ioport.h b/include/exec/ioport.h
>>> index a298b89ce1..97feb296d2 100644
>>> --- a/include/exec/ioport.h
>>> +++ b/include/exec/ioport.h
>>> @@ -24,6 +24,8 @@
>>>  #ifndef IOPORT_H
>>>  #define IOPORT_H
>>>
>>> +#include "exec/memory.h"
>>> +
>>>  #define MAX_IOPORTS     (64 * 1024)
>>>  #define IOPORTS_MASK    (MAX_IOPORTS - 1)
>>>
>>> diff --git a/include/exec/memory-internal.h b/include/exec/memory-inter=
nal.h
>>> index d1a9dd1ec8..ef4fb92371 100644
>>> --- a/include/exec/memory-internal.h
>>> +++ b/include/exec/memory-internal.h
>>> @@ -20,6 +20,8 @@
>>>  #ifndef MEMORY_INTERNAL_H
>>>  #define MEMORY_INTERNAL_H
>>>
>>> +#include "cpu.h"
>>> +
>>>  #ifndef CONFIG_USER_ONLY
>>>  static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
>>>  {
>>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>>> index b7b2e60ff6..a327a80cfe 100644
>>> --- a/include/exec/ram_addr.h
>>> +++ b/include/exec/ram_addr.h
>>> @@ -20,6 +20,7 @@
>>>  #define RAM_ADDR_H
>>>
>>>  #ifndef CONFIG_USER_ONLY
>>> +#include "cpu.h"
>>>  #include "hw/xen/xen.h"
>>>  #include "sysemu/tcg.h"
>>>  #include "exec/ramlist.h"
>>> diff --git a/include/exec/softmmu-semi.h b/include/exec/softmmu-semi.h
>>> index 970837992e..fbcae88f4b 100644
>>> --- a/include/exec/softmmu-semi.h
>>> +++ b/include/exec/softmmu-semi.h
>>> @@ -10,6 +10,8 @@
>>>  #ifndef SOFTMMU_SEMI_H
>>>  #define SOFTMMU_SEMI_H
>>>
>>> +#include "cpu.h"
>>> +
>>>  static inline uint64_t softmmu_tget64(CPUArchState *env, target_ulong =
addr)
>>>  {
>>>      uint64_t val;
>>> diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
>>> index 4f3a37d927..805235d321 100644
>>> --- a/include/exec/tb-hash.h
>>> +++ b/include/exec/tb-hash.h
>>> @@ -20,6 +20,8 @@
>>>  #ifndef EXEC_TB_HASH_H
>>>  #define EXEC_TB_HASH_H
>>>
>>> +#include "exec/cpu-defs.h"
>>> +#include "exec/exec-all.h"
>>>  #include "qemu/xxhash.h"
>>>
>>>  #ifdef CONFIG_SOFTMMU
>>> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
>>> index 8d3af5a3be..d05a8a4dab 100644
>>> --- a/include/exec/user/thunk.h
>>> +++ b/include/exec/user/thunk.h
>>> @@ -20,6 +20,7 @@
>>>  #define THUNK_H
>>>
>>>  #include "cpu.h"
>>> +#include "exec/user/abitypes.h"
>>>
>>>  /* types enums definitions */
>>
>> These all seem OK.
>>
>>>
>>> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-mac=
ros.h
>>> index c55aa6d174..be83a833ec 100644
>>> --- a/include/fpu/softfloat-macros.h
>>> +++ b/include/fpu/softfloat-macros.h
>>> @@ -82,6 +82,8 @@ this code that are retained.
>>>  #ifndef FPU_SOFTFLOAT_MACROS_H
>>>  #define FPU_SOFTFLOAT_MACROS_H
>>>
>>> +#include "fpu/softfloat.h"
>>> +
>>
>> What does softfloat-macros actually need from the core softfloat API?
>> These are lower level functions used by softfloat itself (and m68k for
>> it's own bit fiddling).
>
> I extracted this patch out of "[PATCH RFC v5 0/3] Baby steps towards
> saner headers".  PATCH 1/3 creates make target "check-source", which is
> what I used to find headers that aren't self-contained.  In this case:
>
>   CC      cris-softmmu/tests/headers-tgt/include/fpu/softfloat.o
> In file included from tests/headers-tgt/include/fpu/softfloat-macros.c:21:
> /work/armbru/qemu/include/fpu/softfloat-macros.h: In function =E2=80=98es=
timateDiv128To64=E2=80=99:
> /work/armbru/qemu/include/fpu/softfloat-macros.h:623:27: error: implicit =
declaration of function =E2=80=98LIT64=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
>   623 |     if ( b <=3D a0 ) return LIT64( 0xFFFFFFFFFFFFFFFF );

The LIT64 definition should be moved to softfloat-types.h which is
already included by softfloat.h unless we already have a QEMU expansion
we should be using. The softfloat-macros.h can include softfloat-types.h
as well and we should only include the full softfloat.h if they need it.

Do you want me to spin up a patch?

>       |                           ^~~~~
> /work/armbru/qemu/include/fpu/softfloat-macros.h:623:27: error: nested ex=
tern declaration of =E2=80=98LIT64=E2=80=99 [-Werror=3Dnested-externs]
> /work/armbru/qemu/include/fpu/softfloat-macros.h: At top level:
> /work/armbru/qemu/include/fpu/softfloat-macros.h:761:15: error: unknown t=
ype name =E2=80=98flag=E2=80=99
>   761 | static inline flag eq128( uint64_t a0, uint64_t a1, uint64_t b0, =
uint64_t b1 )
>       |               ^~~~
> /work/armbru/qemu/include/fpu/softfloat-macros.h:774:15: error: unknown t=
ype name =E2=80=98flag=E2=80=99
>   774 | static inline flag le128( uint64_t a0, uint64_t a1, uint64_t b0, =
uint64_t b1 )
>       |               ^~~~
> /work/armbru/qemu/include/fpu/softfloat-macros.h:787:15: error: unknown t=
ype name =E2=80=98flag=E2=80=99
>   787 | static inline flag lt128( uint64_t a0, uint64_t a1, uint64_t b0, =
uint64_t b1 )
>       |               ^~~~
> /work/armbru/qemu/include/fpu/softfloat-macros.h:800:15: error: unknown t=
ype name =E2=80=98flag=E2=80=99
>   800 | static inline flag ne128( uint64_t a0, uint64_t a1, uint64_t b0, =
uint64_t b1 )
>       |               ^~~~
> cc1: all warnings being treated as errors
> make[1]: *** [/work/armbru/qemu/rules.mak:69: tests/headers-tgt/include/f=
pu/softfloat-macros.o] Error 1


--
Alex Benn=C3=A9e

