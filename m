Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7F4C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E1720844
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wjx8DArO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E1720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hknbP-0002fT-PA
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 06:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hknat-0002E5-GN
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hknar-0001Yo-Rl
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:43:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hknar-0001Y9-Ie
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:43:29 -0400
Received: by mail-wm1-x344.google.com with SMTP id f17so2688057wme.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6tq2m/pTwJxhypfaqK3jUsn4tUyW29zXA/x+ROyPhg0=;
 b=Wjx8DArO/PTVzDplMg58dAzUVhZXTpVHxFD+F9DaTfaz5HbZlZjJzociCaYsZJH5G0
 uT/F6ka5+m0ZEpeBkrBalkIMl3/ntx318sy/MpWTbYqiXOujw/wYCEHMAgNPheyuM14I
 AqkscvMKTgJLiMaBi7YDVLbTCW/tk7mJUbTeNdyzUPBwdfkIPgxsD9l0vE8QEnEK0DQE
 0W1r4U2U7B88OD+NmdZSQAxfTXWYiCOT+3S2MAFW/yV5avS8T6M0xT04Lg7x142XgSpw
 lp+0TZZelJmt1CimEVAbHS1k/opDF/RbrRzkDzMgqHLiJUbEv+rPMya+QmctJ65weimZ
 9BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6tq2m/pTwJxhypfaqK3jUsn4tUyW29zXA/x+ROyPhg0=;
 b=BZEeFc4i74fgh5cEPDCTOHObJKt4HoZjB8h184AFROgmOnmMpRU4YQOkoYHEw7Yx7N
 PjDi0LDQgli63VHdDi8CL36fbz9XfkcQMjygbg67iLAFt79CUIW9patS6D6m1J0GotSW
 Ag5I0wtuG2xNha04jwPGjZNSp8HYMfOkLMn7kgkZH2vvrHZq74UgiXGVrlHOjDLMPn6U
 jVUPKUiek+Ag3ZeaTBT03WCylIcGFx9HNZS8jLh85qprC9OjFM2iZdQ0KGqQXPt2jnYm
 Y63ysXjL/p2ybhVD9YkMV1b5HdEiP32oNWX+5BC7iJJaOpEygp3fh8SrmR7UAGljSBP3
 fvHg==
X-Gm-Message-State: APjAAAX5qMVV7RQX80xEr900PLOGhj4juEkNSykn+CM7HbNYYYjwwgjc
 4Sho3VeMgu/mkHc3ZG1akTkqkA==
X-Google-Smtp-Source: APXvYqwABb69vGFRE6+J85q9y5raFEAsMzmMC40c2P6IQpR4OMm7tSXfpA2qej9Pey8qonWyncPA7g==
X-Received: by 2002:a7b:c398:: with SMTP id s24mr22223990wmj.53.1562669008183; 
 Tue, 09 Jul 2019 03:43:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r12sm31574311wrt.95.2019.07.09.03.43.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 03:43:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2D1891FF87;
 Tue,  9 Jul 2019 11:43:27 +0100 (BST)
References: <20190709092049.13771-1-richard.henderson@linaro.org>
 <20190709092049.13771-3-richard.henderson@linaro.org>
 <87zhlned2x.fsf@zen.linaroharston>
 <ae07033e-a29c-7419-09e0-703212d228a0@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <ae07033e-a29c-7419-09e0-703212d228a0@linaro.org>
Date: Tue, 09 Jul 2019 11:43:27 +0100
Message-ID: <87tvbvebe8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 2/5] tcg: Introduce set/clear_helper_retaddr
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/9/19 12:07 PM, Alex Benn=C3=A9e wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> At present we have a potential error in that helper_retaddr contains
>>> data for handle_cpu_signal, but we have not ensured that those stores
>>> will be scheduled properly before the operation that may fault.
>>>
>>> It might be that these races are not in practice observable, due to
>>> our use of -fno-strict-aliasing, but better safe than sorry.
>>>
>>> Adjust all of the setters of helper_retaddr.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  include/exec/cpu_ldst.h                   | 20 +++++++++++
>>>  include/exec/cpu_ldst_useronly_template.h | 12 +++----
>>>  accel/tcg/user-exec.c                     | 11 +++---
>>>  target/arm/helper-a64.c                   |  8 ++---
>>>  target/arm/sve_helper.c                   | 43 +++++++++++------------
>>>  5 files changed, 57 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
>>> index a08b11bd2c..9de8c93303 100644
>>> --- a/include/exec/cpu_ldst.h
>>> +++ b/include/exec/cpu_ldst.h
>>> @@ -89,6 +89,26 @@ typedef target_ulong abi_ptr;
>>>
>>>  extern __thread uintptr_t helper_retaddr;
>>>
>>> +static inline void set_helper_retaddr(uintptr_t ra)
>>> +{
>>> +    helper_retaddr =3D ra;
>>> +    /*
>>> +     * Ensure that this write is visible to the SIGSEGV handler that
>>> +     * may be invoked due to a subsequent invalid memory operation.
>>> +     */
>>> +    signal_barrier();
>>> +}
>>> +
>>> +static inline void clear_helper_retaddr(void)
>>> +{
>>> +    /*
>>> +     * Ensure that previous memory operations have succeeded before
>>> +     * removing the data visible to the signal handler.
>>> +     */
>>> +    signal_barrier();
>>> +    helper_retaddr =3D 0;
>>> +}
>>> +
>>>  /* In user-only mode we provide only the _code and _data accessors. */
>>>
>>>  #define MEMSUFFIX _data
>>> diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/c=
pu_ldst_useronly_template.h
>>> index bc45e2b8d4..e65733f7e2 100644
>>> --- a/include/exec/cpu_ldst_useronly_template.h
>>> +++ b/include/exec/cpu_ldst_useronly_template.h
>>> @@ -78,9 +78,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
>>>                                                    uintptr_t retaddr)
>>>  {
>>>      RES_TYPE ret;
>>> -    helper_retaddr =3D retaddr;
>>> +    set_helper_retaddr(retaddr);
>>>      ret =3D glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(env, ptr);
>>> -    helper_retaddr =3D 0;
>>> +    clear_helper_retaddr();
>>>      return ret;
>>>  }
>>>
>>> @@ -102,9 +102,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(C=
PUArchState *env,
>>>                                                    uintptr_t retaddr)
>>>  {
>>>      int ret;
>>> -    helper_retaddr =3D retaddr;
>>> +    set_helper_retaddr(retaddr);
>>>      ret =3D glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(env, ptr);
>>> -    helper_retaddr =3D 0;
>>> +    clear_helper_retaddr();
>>>      return ret;
>>>  }
>>>  #endif
>>> @@ -128,9 +128,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CP=
UArchState *env,
>>>                                                    RES_TYPE v,
>>>                                                    uintptr_t retaddr)
>>>  {
>>> -    helper_retaddr =3D retaddr;
>>> +    set_helper_retaddr(retaddr);
>>>      glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(env, ptr, v);
>>> -    helper_retaddr =3D 0;
>>> +    clear_helper_retaddr();
>>>  }
>>>  #endif
>>>
>>> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
>>> index cb5f4b19c5..4384b59a4d 100644
>>> --- a/accel/tcg/user-exec.c
>>> +++ b/accel/tcg/user-exec.c
>>> @@ -134,7 +134,7 @@ static inline int handle_cpu_signal(uintptr_t pc, s=
iginfo_t *info,
>>>               * currently executing TB was modified and must be exited
>>>               * immediately.  Clear helper_retaddr for next execution.
>>>               */
>>> -            helper_retaddr =3D 0;
>>> +            clear_helper_retaddr();
>>>              cpu_exit_tb_from_sighandler(cpu, old_set);
>>>              /* NORETURN */
>>>
>>> @@ -152,7 +152,7 @@ static inline int handle_cpu_signal(uintptr_t pc, s=
iginfo_t *info,
>>>       * an exception.  Undo signal and retaddr state prior to longjmp.
>>>       */
>>>      sigprocmask(SIG_SETMASK, old_set, NULL);
>>> -    helper_retaddr =3D 0;
>>> +    clear_helper_retaddr();
>>>
>>>      cc =3D CPU_GET_CLASS(cpu);
>>>      access_type =3D is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
>>> @@ -682,14 +682,15 @@ static void *atomic_mmu_lookup(CPUArchState *env,=
 target_ulong addr,
>>>      if (unlikely(addr & (size - 1))) {
>>>          cpu_loop_exit_atomic(env_cpu(env), retaddr);
>>>      }
>>> -    helper_retaddr =3D retaddr;
>>> -    return g2h(addr);
>>> +    void *ret =3D g2h(addr);
>>> +    set_helper_retaddr(retaddr);
>>> +    return ret;
>>>  }
>>>
>>>  /* Macro to call the above, with local variables from the use context.=
  */
>>>  #define ATOMIC_MMU_DECLS do {} while (0)
>>>  #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GET=
PC())
>>> -#define ATOMIC_MMU_CLEANUP do { helper_retaddr =3D 0; } while (0)
>>> +#define ATOMIC_MMU_CLEANUP do { clear_helper_retaddr(); } while (0)
>>>
>>>  #define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
>>>  #define EXTRA_ARGS
>>> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
>>> index 44e45a8037..060699b901 100644
>>> --- a/target/arm/helper-a64.c
>>> +++ b/target/arm/helper-a64.c
>>> @@ -554,7 +554,7 @@ uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *e=
nv, uint64_t addr,
>>>      /* ??? Enforce alignment.  */
>>>      uint64_t *haddr =3D g2h(addr);
>>>
>>> -    helper_retaddr =3D ra;
>>> +    set_helper_retaddr(ra);
>>>      o0 =3D ldq_le_p(haddr + 0);
>>>      o1 =3D ldq_le_p(haddr + 1);
>>>      oldv =3D int128_make128(o0, o1);
>>> @@ -564,7 +564,7 @@ uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *e=
nv, uint64_t addr,
>>>          stq_le_p(haddr + 0, int128_getlo(newv));
>>>          stq_le_p(haddr + 1, int128_gethi(newv));
>>>      }
>>> -    helper_retaddr =3D 0;
>>> +    clear_helper_retaddr();
>>>  #else
>>>      int mem_idx =3D cpu_mmu_index(env, false);
>>>      TCGMemOpIdx oi0 =3D make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
>>> @@ -624,7 +624,7 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *e=
nv, uint64_t addr,
>>>      /* ??? Enforce alignment.  */
>>>      uint64_t *haddr =3D g2h(addr);
>>>
>>> -    helper_retaddr =3D ra;
>>> +    set_helper_retaddr(ra);
>>>      o1 =3D ldq_be_p(haddr + 0);
>>>      o0 =3D ldq_be_p(haddr + 1);
>>>      oldv =3D int128_make128(o0, o1);
>>> @@ -634,7 +634,7 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *e=
nv, uint64_t addr,
>>>          stq_be_p(haddr + 0, int128_gethi(newv));
>>>          stq_be_p(haddr + 1, int128_getlo(newv));
>>>      }
>>> -    helper_retaddr =3D 0;
>>> +    clear_helper_retaddr();
>>>  #else
>>>      int mem_idx =3D cpu_mmu_index(env, false);
>>>      TCGMemOpIdx oi0 =3D make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
>>> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
>>> index fd434c66ea..fc0c1755d2 100644
>>> --- a/target/arm/sve_helper.c
>>> +++ b/target/arm/sve_helper.c
>>> @@ -4125,12 +4125,11 @@ static intptr_t max_for_page(target_ulong base,=
 intptr_t mem_off,
>>>      return MIN(split, mem_max - mem_off) + mem_off;
>>>  }
>>>
>>> -static inline void set_helper_retaddr(uintptr_t ra)
>>> -{
>>> -#ifdef CONFIG_USER_ONLY
>>> -    helper_retaddr =3D ra;
>>> +#ifndef CONFIG_USER_ONLY
>>> +/* These are normally defined only for CONFIG_USER_ONLY in <exec/cpu_l=
dst.h> */
>>> +static inline void set_helper_retaddr(uintptr_t ra) { }
>>> +static inline void clear_helper_retaddr(void) { }
>>
>> Why aren't these stubs in the #else leg of cpu_ldst.h?
>
> I'm not sure it makes sense to spread these around generically, since the=
y are
> no-ops which require the extra help of the "host_fn" pointers within that=
 file.
>
> In particular, the softmmu host_fn continues to use ra, while the linux-u=
ser
> host_fn does not.  Indeed, the whole point of sve_helper.c using
> set_helper_retaddr is to hoist the setting of helper_retaddr that would b=
e done
> for each occurrence of cpu_ld_data_ra() et al.

Fair enough, keep the r-b.

--
Alex Benn=C3=A9e

