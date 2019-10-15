Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24C1C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C32C20872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVoARnJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C32C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKS7s-0005Sm-K5
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 15:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iKS6P-0004M6-NB
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iKS6O-000247-2s
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:03:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iKS6N-00023v-Ri
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:03:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id y21so218742wmi.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Wnsu517e6kvFDqqF4K40vMgZahvWSaPe+F3iXhPp58k=;
 b=EVoARnJ3QSrdnKe1/87klwWChNtfvOcXKnx9k0EAjuhn1v/VxgnPoZ8QUPAwrwEFI7
 yt+q2SP8AH6NsTgctWGFvRedGAg7QdZIa/vW+DEw0JmeL9WxQSYYa964c+Y77xQ5rS1m
 wrIqItFmw48emGODXKprVnWrJ89IzNFoYBRM2oEvs8nWSkigBrcwzwd5xGAMCtKBD0rr
 UNkx0vQj9xgsmWixcB/6PSZk8az87z5B84ml0JEkJWFkdsNphjrVsiuS9v0R4s++IrhA
 h375lfT0OyzzbsSW4KMpJi4nE1KsuT3eY3Ab8+2pNyltxqSg/qiorYNHjY16qfgqAfvS
 xo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Wnsu517e6kvFDqqF4K40vMgZahvWSaPe+F3iXhPp58k=;
 b=kv7EUu/ahp9ZCLEOIl0YGy2mcpO30ZCK1G46yabzrcnFzDzhnacm2y+nfXOOodH9Yh
 8gg8LZYkdAwhPOvqe9uTJq5ionjlDzdJjQys1Rgru63NbZNbc2hBSnGXpIXTdxgAwDcO
 05EzATvStwwc/Emh6y3A1oP+m5gZe9O+PuxfjObRfQR7MXu/RhDndMP8aRmO6eRAy2jh
 QQdy2te77GAsF2bwDe6Vom9LrUOxJUjrVhooO+oufrWXCXBoCAFmO8Y8dEBDTf0vyrfN
 KzadLjodvwt0Htu0CpTy5dKaDuTHW87yIm49s5z0ch0yVMCb5V9vpJfO4vqC5vPjxbAO
 ULJQ==
X-Gm-Message-State: APjAAAXJ5mFJAUJkg6P7gRx3mbHLDw9HWGtkrNXfA68Og+aQHvWKSy/r
 +jHSn59OXzvVYgb0QzCH7GWY4A==
X-Google-Smtp-Source: APXvYqxIcEuzltxqa4wXmAuLqI2kKV2x2MVO8v263URSwtPc6JDeyyYCYKiaQksOZiOaaCz2c7+RQQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr44724wmb.55.1571166201928;
 Tue, 15 Oct 2019 12:03:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l18sm24193425wrn.48.2019.10.15.12.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 12:03:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7319B1FF87;
 Tue, 15 Oct 2019 20:03:20 +0100 (BST)
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-24-alex.bennee@linaro.org>
 <CAFEAcA-PJ8V4to4SKu6PXZH6yFkrQ7FJBZR=2O-fJFoZgEq=TQ@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 23/55] translator: add translator_ld{ub,sw,uw,l,q}
In-reply-to: <CAFEAcA-PJ8V4to4SKu6PXZH6yFkrQ7FJBZR=2O-fJFoZgEq=TQ@mail.gmail.com>
Date: Tue, 15 Oct 2019 20:03:20 +0100
Message-ID: <87y2xlltl3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, peter.puhov@futurewei.com,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 14 Oct 2019 at 12:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> From: "Emilio G. Cota" <cota@braap.org>
>>
>> We don't bother with replicating the fast path (tlb_hit) of the old
>> cpu_ldst helpers as it has no measurable effect on performance. This
>> probably indicates we should consider flattening the whole set of
>> helpers but that is out of scope for this change.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>> [AJB: directly plumb into softmmu/user helpers]
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> diff --git a/tcg/tcg.h b/tcg/tcg.h
>> index a38659ea5b..302533b463 100644
>> --- a/tcg/tcg.h
>> +++ b/tcg/tcg.h
>> @@ -1317,6 +1317,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, tar=
get_ulong addr,
>>  # define helper_ret_stl_mmu   helper_be_stl_mmu
>>  # define helper_ret_stq_mmu   helper_be_stq_mmu
>>  # define helper_ret_ldw_cmmu  helper_be_ldw_cmmu
>> +# define helper_ret_lduw_cmmu helper_be_ldw_cmmu
>>  # define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
>>  # define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
>>  #else
>> @@ -1330,6 +1331,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, tar=
get_ulong addr,
>>  # define helper_ret_stl_mmu   helper_le_stl_mmu
>>  # define helper_ret_stq_mmu   helper_le_stq_mmu
>>  # define helper_ret_ldw_cmmu  helper_le_ldw_cmmu
>> +# define helper_ret_lduw_cmmu helper_le_ldw_cmmu
>>  # define helper_ret_ldl_cmmu  helper_le_ldl_cmmu
>>  # define helper_ret_ldq_cmmu  helper_le_ldq_cmmu
>>  #endif
>
> This looks odd. Why is it ok to define a 'lduw' helper
> as the 'ldw' cmmu helper ? One ought to be sign
> extending and the other not...

This is the alternative:

3 files changed, 9 insertions(+), 17 deletions(-)
include/exec/translator.h | 19 +++++++++----------
include/qemu/bswap.h      |  5 -----
tcg/tcg.h                 |  2 --

modified   include/exec/translator.h
@@ -158,26 +158,26 @@ void translator_loop_temp_check(DisasContextBase *db);

 #ifdef CONFIG_USER_ONLY

-#define DO_LOAD(type, name, shift)               \
+#define DO_LOAD(type, name, uname, shift)        \
     set_helper_retaddr(1);                       \
-    ret =3D name ## _p(g2h(pc));                   \
+    ret =3D uname ## _p(g2h(pc));                  \
     clear_helper_retaddr();

 #else

-#define DO_LOAD(type, name, shift)                   \
+#define DO_LOAD(type, name, uname, shift)            \
     int mmu_idx =3D cpu_mmu_index(env, true);          \
     TCGMemOpIdx oi =3D make_memop_idx(shift, mmu_idx); \
     ret =3D helper_ret_ ## name ## _cmmu(env, pc, oi, 0);

 #endif

-#define GEN_TRANSLATOR_LD(fullname, name, type, shift, swap_fn)         \
+#define GEN_TRANSLATOR_LD(fullname, name, uname, type, shift, swap_fn)  \
     static inline type                                                  \
     fullname ## _swap(CPUArchState *env, abi_ptr pc, bool do_swap)      \
     {                                                                   \
         type ret;                                                       \
-        DO_LOAD(type, name, shift)                                      \
+        DO_LOAD(type, name, uname, shift)                               \
                                                                         \
         if (do_swap) {                                                  \
             ret =3D swap_fn(ret);                                         \
@@ -191,11 +191,10 @@ void translator_loop_temp_check(DisasContextBase *db);
         return fullname ## _swap(env, pc, false);                       \
     }

-GEN_TRANSLATOR_LD(translator_ldub, ldb, uint8_t, 0, /* no swap needed */)
-GEN_TRANSLATOR_LD(translator_ldsw, lduw, int16_t, 1, bswap16)
-GEN_TRANSLATOR_LD(translator_lduw, lduw, uint16_t, 1, bswap16)
-GEN_TRANSLATOR_LD(translator_ldl, ldl, uint32_t, 2, bswap32)
-GEN_TRANSLATOR_LD(translator_ldq, ldq, uint64_t, 3, bswap64)
+GEN_TRANSLATOR_LD(translator_ldub, ldb, ldub, uint8_t, 0, /* no swap neede=
d */)
+GEN_TRANSLATOR_LD(translator_ldw, ldw, lduw, uint16_t, 1, bswap16)
+GEN_TRANSLATOR_LD(translator_ldl, ldl, ldl, uint32_t, 2, bswap32)
+GEN_TRANSLATOR_LD(translator_ldq, ldq, ldl, uint64_t, 3, bswap64)
 #undef GEN_TRANSLATOR_LD

 #endif  /* EXEC__TRANSLATOR_H */
modified   include/qemu/bswap.h
@@ -306,11 +306,6 @@ static inline int ldub_p(const void *ptr)
     return *(uint8_t *)ptr;
 }

-static inline int ldb_p(const void *ptr)
-{
-    return ldub_p(ptr);
-}
-
 static inline int ldsb_p(const void *ptr)
 {
     return *(int8_t *)ptr;
modified   tcg/tcg.h
@@ -1317,7 +1317,6 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target=
_ulong addr,
 # define helper_ret_stl_mmu   helper_be_stl_mmu
 # define helper_ret_stq_mmu   helper_be_stq_mmu
 # define helper_ret_ldw_cmmu  helper_be_ldw_cmmu
-# define helper_ret_lduw_cmmu helper_be_ldw_cmmu
 # define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
 #else
@@ -1331,7 +1330,6 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target=
_ulong addr,
 # define helper_ret_stl_mmu   helper_le_stl_mmu
 # define helper_ret_stq_mmu   helper_le_stq_mmu
 # define helper_ret_ldw_cmmu  helper_le_ldw_cmmu
-# define helper_ret_lduw_cmmu helper_le_ldw_cmmu
 # define helper_ret_ldl_cmmu  helper_le_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_le_ldq_cmmu
 #endif

--
Alex Benn=C3=A9e

