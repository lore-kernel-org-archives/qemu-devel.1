Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008FCC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73937207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZJLbE/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73937207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKJp9-00064X-ER
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKJnN-00051U-DV
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKJnJ-0007dO-AX
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600686939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrsyckzqfOeD+VtQ+pY586cRARZRcNPieVvCSzMt4MI=;
 b=SZJLbE/dBN+w6EpOWUx4XnWVq2mh5ZkqZ4uq1FcpvY42nmNE0KpmEMJFuP4b1es3kEYpgV
 oVc0DjKM49GG4+iR+SKl/WUxBokT0tqauRR5wG/GKMEiXqj1UOwSQsuMAU6/L2+mAIs0f4
 06ZQkgzFqlGCsGa1TeTMibaA988HYTs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-tU8vkYEiND6vXSRJXmFwoA-1; Mon, 21 Sep 2020 07:15:33 -0400
X-MC-Unique: tU8vkYEiND6vXSRJXmFwoA-1
Received: by mail-wr1-f70.google.com with SMTP id v12so5726389wrm.9
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 04:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZrsyckzqfOeD+VtQ+pY586cRARZRcNPieVvCSzMt4MI=;
 b=BtpvJiGP94T5hc7QRKAMuz5jzQdH6pMdUjwf6aHEkW3TOl/67SRNXtR5ZE/P+KSwG7
 NmlE0d0JHdKJsCDaAghb5tGT6HowE4XXUNvZa6GA6whwu54DSdhzABOM/CI8LMvm4K15
 QlYRP1kqiBCvai28BrHUM77/x/Hk4D4cO7Xn1eYSm9OaKpsFPkDRBchNPHuNOisdWoAJ
 eJ05/2htCVJY0pQ6g24zErap/GWoW2n5vq7vVCgfqT1NTxOc4yhm0AeKGzyR5ki4sKVb
 yJw4+D4trPlxJaNl1NLcv9c81t9PcOkoaKNEaUQX4IQmjnv2b+ubKaMgewh6v4KPorNU
 oTQw==
X-Gm-Message-State: AOAM5306KS0dUJHyr7cIpfjARiUXbuRj3KvT3tpSHIfrRAObV2c05un1
 6K3SRZWffaPAGBiU0hZJLQOmO++O7p20L7G/kN7NYClw622wZRA+mZz3E+xWy4fishUsgSiHqLI
 LIkqrCqkC5Asq6Fs=
X-Received: by 2002:a1c:a949:: with SMTP id s70mr27951624wme.42.1600686932472; 
 Mon, 21 Sep 2020 04:15:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhGI4WBYctd18WIlxtBbRFSUdri+JPB5KGVgnqYDc/z58AotaPAxz/IgYSYonc9voaMR9+qA==
X-Received: by 2002:a1c:a949:: with SMTP id s70mr27951590wme.42.1600686932133; 
 Mon, 21 Sep 2020 04:15:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d153:8d0f:94cf:5114?
 ([2001:b07:6468:f312:d153:8d0f:94cf:5114])
 by smtp.gmail.com with ESMTPSA id l5sm19924175wmf.10.2020.09.21.04.15.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 04:15:31 -0700 (PDT)
Subject: Re: [RFC] Move to C11 Atomics
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200921104107.134323-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b32450b7-13e4-9968-cd99-fe8210040d3b@redhat.com>
Date: Mon, 21 Sep 2020 13:15:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921104107.134323-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel Berrange <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/20 12:41, Stefan Hajnoczi wrote:
> The upshot is that all atomic variables in QEMU need to use C11 Atomic
> atomic_* types. This is a big change!

The main issue with this is that C11 atomic types do too much magic,
including defaulting to seq-cst operations for loads and stores. As
documented in docs/devel/atomics.rst, seq-cst loads and stores are
almost never what you want (they're only a little below volatile :)):

1) in almost all cases where we do message passing between threads, we
can use store-release/load-acquire

2) when we want a full memory barrier, it's usually better to write the
whole construct by hand, to avoid issues like the ones we had with
->notify_me.

In addition, atomics are complicated enough that you almost always want
a sign that you are using them, even at the cost of heavier-looking
code.  For example "atomic_read" straight ahead tells you "this is
complicated but somebody has thought about it", while a naked access to
a global variable or a struct field tells you "check which mutex is held
when this function is called".  By allowing shortcuts for seq-cst loads
and stores, C11 atomics fool you into thinking that seq-cst accesses are
all you need, while in reality they create more problems than they solve. :(

So if we need to make a big change in the implementation of atomics,
what we should do is to wrap variables that are accessed atomically with
a struct.  This would enforce using atomic_read/atomic_set to access
them.  These structs could be types like stdatomic.h's atomic_char,
though probably we'd name them something like AtomicChar.

It would move us further from C11; however, it would also make it harder
to write buggy code.

If there is a problem of namespace pollution between qemu/atomic.h and
C11 atomics we could also fix that.

> 1. Reimplement everything in terms of atomic_fetch_*() and other C11
>    Atomic APIs. For example atomic_fetch_inc() becomes
>    atomic_fetch_add(ptr, 1).
> 
> 2. atomic_*_fetch() is not available in C11 Atomics so emulate it by
>    performing the operation twice (once atomic, then again non-atomic
>    using the fetched old atomic value). Yuck!

They're hidden in plain sight if you are okay with seq-cst operations
(which we almost always are for RMW operations, unlike loads and
stores): "x += 3" is an atomic_add_fetch(&x, 3).  However, they share
with loads and stores the problem of being too magic; if you see "x +=
3" you don't think of it as something that's thread safe.

Sorry for being so negative.  Unfortunately while the C11 memory model
is a great addition, in my not so humble opinion stdatomic.h was
designed without enough experience with atomics and with the memory
model itself (it even took people like Hans Boehm and Paul McKenney to
convince the committee that non-seq-cst atomics have a place).

Thanks,

Paolo

> 3. Can everything in atomic.h really be converted to C11 Atomics? I'm
>    not sure yet :(.
> 
> Better ideas?
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/aio.h   |  2 +-
>  include/qemu/atomic.h | 79 +++++++++++++++++++++++++++++++++----------
>  include/qemu/bitops.h |  2 +-
>  include/qom/object.h  |  3 +-
>  util/aio-posix.h      |  2 +-
>  util/async.c          |  2 +-
>  meson.build           |  3 ++
>  7 files changed, 70 insertions(+), 23 deletions(-)
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index b2f703fa3f..466c058880 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -220,7 +220,7 @@ struct AioContext {
>       */
>      QEMUTimerListGroup tlg;
>  
> -    int external_disable_cnt;
> +    atomic_int external_disable_cnt;
>  
>      /* Number of AioHandlers without .io_poll() */
>      int poll_disable_cnt;
> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> index ff72db5115..4fbbd5f362 100644
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -15,6 +15,32 @@
>  #ifndef QEMU_ATOMIC_H
>  #define QEMU_ATOMIC_H
>  
> +#include <stdbool.h>
> +#include <stddef.h>
> +
> +/* Use C11 Atomics if possible, otherwise fall back to custom definitions */
> +#ifdef CONFIG_STDATOMIC_H
> +#include <stdatomic.h>
> +#else
> +/* Commonly used types from C11 "7.17.6 Atomic integer types" */
> +typedef bool atomic_bool;
> +typedef char atomic_char;
> +typedef signed char atomic_schar;
> +typedef unsigned char atomic_uchar;
> +typedef short atomic_short;
> +typedef unsigned short atomic_ushort;
> +typedef int atomic_int;
> +typedef unsigned int atomic_uint;
> +typedef long atomic_long;
> +typedef unsigned long atomic_ulong;
> +typedef long long atomic_llong;
> +typedef unsigned long long atomic_ullong;
> +typedef intptr_t atomic_intptr_t;
> +typedef uintptr_t atomic_uintptr_t;
> +typedef size_t atomic_size_t;
> +typedef ptrdiff_t atomic_ptrdiff_t;
> +#endif
> +
>  /* Compiler barrier */
>  #define barrier()   ({ asm volatile("" ::: "memory"); (void)0; })
>  
> @@ -205,10 +231,6 @@
>      atomic_cmpxchg__nocheck(ptr, old, new);                             \
>  })
>  
> -/* Provide shorter names for GCC atomic builtins, return old value */
> -#define atomic_fetch_inc(ptr)  __atomic_fetch_add(ptr, 1, __ATOMIC_SEQ_CST)
> -#define atomic_fetch_dec(ptr)  __atomic_fetch_sub(ptr, 1, __ATOMIC_SEQ_CST)
> -
>  #ifndef atomic_fetch_add
>  #define atomic_fetch_add(ptr, n) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_CST)
>  #define atomic_fetch_sub(ptr, n) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_CST)
> @@ -217,22 +239,41 @@
>  #define atomic_fetch_xor(ptr, n) __atomic_fetch_xor(ptr, n, __ATOMIC_SEQ_CST)
>  #endif
>  
> -#define atomic_inc_fetch(ptr)    __atomic_add_fetch(ptr, 1, __ATOMIC_SEQ_CST)
> -#define atomic_dec_fetch(ptr)    __atomic_sub_fetch(ptr, 1, __ATOMIC_SEQ_CST)
> -#define atomic_add_fetch(ptr, n) __atomic_add_fetch(ptr, n, __ATOMIC_SEQ_CST)
> -#define atomic_sub_fetch(ptr, n) __atomic_sub_fetch(ptr, n, __ATOMIC_SEQ_CST)
> -#define atomic_and_fetch(ptr, n) __atomic_and_fetch(ptr, n, __ATOMIC_SEQ_CST)
> -#define atomic_or_fetch(ptr, n)  __atomic_or_fetch(ptr, n, __ATOMIC_SEQ_CST)
> -#define atomic_xor_fetch(ptr, n) __atomic_xor_fetch(ptr, n, __ATOMIC_SEQ_CST)
> +/* Provide shorter names for GCC atomic builtins, return old value */
> +#define atomic_fetch_inc(ptr)  atomic_fetch_add(ptr, 1)
> +#define atomic_fetch_dec(ptr)  atomic_fetch_sub(ptr, 1)
> +
> +#define atomic_inc_fetch(ptr)    (atomic_fetch_add(ptr, 1) + 1)
> +#define atomic_dec_fetch(ptr)    (atomic_fetch_sub(ptr, 1) - 1)
> +#define atomic_add_fetch(ptr, n) ({ \
> +    typeof(n) _n = n; \
> +    atomic_fetch_add(ptr, _n) + _n; \
> +})
> +#define atomic_sub_fetch(ptr, n) ({ \
> +    typeof(n) _n = n; \
> +    atomic_fetch_sub(ptr, _n) - n; \
> +})
> +#define atomic_and_fetch(ptr, n) ({ \
> +    typeof(n) _n = n; \
> +    atomic_fetch_and(ptr, _n) & _n; \
> +})
> +#define atomic_or_fetch(ptr, n) ({ \
> +    typeof(n) _n = n; \
> +    atomic_fetch_or(ptr, _n) | _n; \
> +})
> +#define atomic_xor_fetch(ptr, n) ({ \
> +    typeof(n) _n = n; \
> +    atomic_fetch_xor(ptr, _n) ^ _n; \
> +})
>  
>  /* And even shorter names that return void.  */
> -#define atomic_inc(ptr)    ((void) __atomic_fetch_add(ptr, 1, __ATOMIC_SEQ_CST))
> -#define atomic_dec(ptr)    ((void) __atomic_fetch_sub(ptr, 1, __ATOMIC_SEQ_CST))
> -#define atomic_add(ptr, n) ((void) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_CST))
> -#define atomic_sub(ptr, n) ((void) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_CST))
> -#define atomic_and(ptr, n) ((void) __atomic_fetch_and(ptr, n, __ATOMIC_SEQ_CST))
> -#define atomic_or(ptr, n)  ((void) __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_CST))
> -#define atomic_xor(ptr, n) ((void) __atomic_fetch_xor(ptr, n, __ATOMIC_SEQ_CST))
> +#define atomic_inc(ptr)    ((void) atomic_fetch_add(ptr, 1))
> +#define atomic_dec(ptr)    ((void) atomic_fetch_sub(ptr, 1))
> +#define atomic_add(ptr, n) ((void) atomic_fetch_add(ptr, n))
> +#define atomic_sub(ptr, n) ((void) atomic_fetch_sub(ptr, n))
> +#define atomic_and(ptr, n) ((void) atomic_fetch_and(ptr, n))
> +#define atomic_or(ptr, n)  ((void) atomic_fetch_or(ptr, n))
> +#define atomic_xor(ptr, n) ((void) atomic_fetch_xor(ptr, n))
>  
>  #else /* __ATOMIC_RELAXED */
>  
> @@ -424,6 +465,8 @@
>  #define atomic_or(ptr, n)      ((void) __sync_fetch_and_or(ptr, n))
>  #define atomic_xor(ptr, n)     ((void) __sync_fetch_and_xor(ptr, n))
>  
> +#error TODO
> +
>  #endif /* __ATOMIC_RELAXED */
>  
>  #ifndef smp_wmb
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index f55ce8b320..e9d676d112 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -49,7 +49,7 @@ static inline void set_bit(long nr, unsigned long *addr)
>  static inline void set_bit_atomic(long nr, unsigned long *addr)
>  {
>      unsigned long mask = BIT_MASK(nr);
> -    unsigned long *p = addr + BIT_WORD(nr);
> +    atomic_ulong *p = (atomic_ulong *)(addr + BIT_WORD(nr));
>  
>      atomic_or(p, mask);
>  }
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 056f67ab3b..f51244b61f 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -15,6 +15,7 @@
>  #define QEMU_OBJECT_H
>  
>  #include "qapi/qapi-builtin-types.h"
> +#include "qemu/atomic.h"
>  #include "qemu/module.h"
>  #include "qom/object.h"
>  
> @@ -550,7 +551,7 @@ struct Object
>      ObjectClass *class;
>      ObjectFree *free;
>      GHashTable *properties;
> -    uint32_t ref;
> +    atomic_uint ref;
>      Object *parent;
>  };
>  
> diff --git a/util/aio-posix.h b/util/aio-posix.h
> index c80c04506a..c5b446f0a1 100644
> --- a/util/aio-posix.h
> +++ b/util/aio-posix.h
> @@ -33,7 +33,7 @@ struct AioHandler {
>      QLIST_ENTRY(AioHandler) node_poll;
>  #ifdef CONFIG_LINUX_IO_URING
>      QSLIST_ENTRY(AioHandler) node_submitted;
> -    unsigned flags; /* see fdmon-io_uring.c */
> +    atomic_uint flags; /* see fdmon-io_uring.c */
>  #endif
>      int64_t poll_idle_timeout; /* when to stop userspace polling */
>      bool is_external;
> diff --git a/util/async.c b/util/async.c
> index 4266745dee..dcf1a32492 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -60,7 +60,7 @@ struct QEMUBH {
>      QEMUBHFunc *cb;
>      void *opaque;
>      QSLIST_ENTRY(QEMUBH) next;
> -    unsigned flags;
> +    atomic_uint flags;
>  };
>  
>  /* Called concurrently from any thread */
> diff --git a/meson.build b/meson.build
> index f4d1ab1096..8d80033d90 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -433,8 +433,11 @@ keyutils = dependency('libkeyutils', required: false,
>  
>  has_gettid = cc.has_function('gettid')
>  
> +has_stdatomic_h = cc.has_header('stdatomic.h')
> +
>  # Create config-host.h
>  
> +config_host_data.set('CONFIG_STDATOMIC_H', has_stdatomic_h)
>  config_host_data.set('CONFIG_SDL', sdl.found())
>  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
>  config_host_data.set('CONFIG_VNC', vnc.found())
> 


