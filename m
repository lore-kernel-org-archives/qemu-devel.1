Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0929AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA66C2087C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iktFtIuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA66C2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1bXj-00081Y-14
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 16:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1bX5-0007cY-UP
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 16:21:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1bX1-0002pk-20
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 16:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596226889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DA94Js8GQaZqugJt4eessgsW509QMCP+ezsyvFZbQGk=;
 b=iktFtIuCLeFSi7ApKzOxjIgQdBak4x8QeuUpq1QCIRcMpHLOetSrBhIF2V5yyy2yP/x1sH
 5zYXouove4zzy16Xz2/KOrakTsjwzzeRb05C8acUzl0LYZy7QsyIczasaLZp8DkSQF3dDG
 Ly4U7Bl1q2uvOFqsVfChJXKm1/0PwjI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-A-l5o1faNtuEZPf2VrWzNQ-1; Fri, 31 Jul 2020 16:21:24 -0400
X-MC-Unique: A-l5o1faNtuEZPf2VrWzNQ-1
Received: by mail-ed1-f71.google.com with SMTP id dd25so6300274edb.6
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 13:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DA94Js8GQaZqugJt4eessgsW509QMCP+ezsyvFZbQGk=;
 b=SMmhWb+ELdszp+v5s5UBOITWQuQXCQwes3AOBDIwcg50LNPa+rx/pHjCnicNVAECZL
 XNUjyh6Lzt8mVmeE2Obqvxj5oDxdBmRkvZyjNpGoZwu/GZRKZ5GiW/z50Igf0Gn/4soo
 FeUzAwZ8uYIfqG+8xVJCcnSs+2Kxeng7eFVcIg+Ycvbm0XnqBH/RUXEXIPQbFE6uryQB
 u28CvEaGJIcgD8bS9Kt6LngNqTQJFPMyTqzmQ1Nh45SwoA8hDR/M+Fg9xefpdcQwOf7Q
 j7htprHaWBFL6OdusQXW4rXSiromabnA+dXXaoUYYkWWy5hbRf9r129hRAqhw45ztaad
 RZWw==
X-Gm-Message-State: AOAM531H17smxZNntDqmhTgveJyW+EUVataqsdQ6iMO2Hj4nrxawa0Na
 ei+vMKzS6VZ1P6dQmzMHkgyx7bH/Pf5svukPbgdL7GiHzVXsdR0s9JHHiVIL+lrykRDMeqFsoFh
 P5g6J/ntEVv9Vd+klZk5pJJ8yfBj+ZLQ=
X-Received: by 2002:a17:906:82c1:: with SMTP id
 a1mr5722436ejy.172.1596226883090; 
 Fri, 31 Jul 2020 13:21:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2esJr1VoqQxP+Ei/ypNeU4tt/2qpmHLMbH5SiNUEAAsaWlqbGjOBc8P6GecU5XnBS73Di8DQ5H06ymzqFq2E=
X-Received: by 2002:a17:906:82c1:: with SMTP id
 a1mr5722414ejy.172.1596226882863; 
 Fri, 31 Jul 2020 13:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200731125127.30866-1-robert.foley@linaro.org>
 <20200731125127.30866-3-robert.foley@linaro.org>
 <67497c73-d2b9-941e-471d-de0ccd61bb7f@redhat.com>
 <CAEyhzFuPNsC3xVPG9bFEbfUPq6MW26STdr-OtKzGsfKykK2FuA@mail.gmail.com>
In-Reply-To: <CAEyhzFuPNsC3xVPG9bFEbfUPq6MW26STdr-OtKzGsfKykK2FuA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 Jul 2020 22:21:11 +0200
Message-ID: <CABgObfbHMsn7yR9GiYGUmrHr6o2LZT+xdw+915R6zNi29reRzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] accel/tcg: interrupt/exception handling uses
 bql_interrupt flag
To: Robert Foley <robert.foley@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000559eaa05abc28853"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:28:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Puhov <peter.puhov@linaro.org>, "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000559eaa05abc28853
Content-Type: text/plain; charset="UTF-8"

Yes, that is correct. It's more work but also more maintainable.

Thanks,

Paolo

Il ven 31 lug 2020, 22:09 Robert Foley <robert.foley@linaro.org> ha scritto:

> On Fri, 31 Jul 2020 at 14:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 31/07/20 14:51, Robert Foley wrote:
> > > This change removes the implied BQL from the cpu_handle_interrupt,
> > > and cpu_handle_exception paths. We can now select per-arch if
> > > the BQL is needed or not by using the bql_interrupt flag.
> > > By default, the core code holds the BQL.
> > > One benefit of this change is that it leaves it up to the arch
> > > to make the change to remove BQL when it makes sense.
> > >
> > > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> >
> > No, please just modify all implementation to do lock/unlock.  It's a
> > simpler patch than this on.
>
> Sure, we will update the patch based on this.
>
> To clarify, the suggestion here is to remove the bql_interrupt flag
> that we added and change all the per-arch interrupt callback code to
> do the lock/unlock of the BQL?  So for example change
> x86_cpu_exec_interrupt, and arm_cpu_exec_interrupt, etc to lock/unlock BQL?
>
> Thanks,
> -Rob
>
>
> >
> > Paolo
> >
> > > ---
> > >  accel/tcg/cpu-exec.c | 34 ++++++++++++++++++++++++++--------
> > >  1 file changed, 26 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > > index 80d0e649b2..cde27ee0bf 100644
> > > --- a/accel/tcg/cpu-exec.c
> > > +++ b/accel/tcg/cpu-exec.c
> > > @@ -517,9 +517,13 @@ static inline bool cpu_handle_exception(CPUState
> *cpu, int *ret)
> > >  #else
> > >          if (replay_exception()) {
> > >              CPUClass *cc = CPU_GET_CLASS(cpu);
> > > -            qemu_mutex_lock_iothread();
> > > +            if (cc->bql_interrupt) {
> > > +                qemu_mutex_lock_iothread();
> > > +            }
> > >              cc->do_interrupt(cpu);
> > > -            qemu_mutex_unlock_iothread();
> > > +            if (cc->bql_interrupt) {
> > > +                qemu_mutex_unlock_iothread();
> > > +            }
> > >              cpu->exception_index = -1;
> > >
> > >              if (unlikely(cpu->singlestep_enabled)) {
> > > @@ -558,7 +562,7 @@ static inline bool cpu_handle_interrupt(CPUState
> *cpu,
> > >      if (unlikely(cpu_interrupt_request(cpu))) {
> > >          int interrupt_request;
> > >
> > > -        qemu_mutex_lock_iothread();
> > > +        cpu_mutex_lock(cpu);
> > >          interrupt_request = cpu_interrupt_request(cpu);
> > >          if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
> > >              /* Mask out external interrupts for this step. */
> > > @@ -567,7 +571,7 @@ static inline bool cpu_handle_interrupt(CPUState
> *cpu,
> > >          if (interrupt_request & CPU_INTERRUPT_DEBUG) {
> > >              cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
> > >              cpu->exception_index = EXCP_DEBUG;
> > > -            qemu_mutex_unlock_iothread();
> > > +            cpu_mutex_unlock(cpu);
> > >              return true;
> > >          }
> > >          if (replay_mode == REPLAY_MODE_PLAY &&
> !replay_has_interrupt()) {
> > > @@ -577,13 +581,15 @@ static inline bool cpu_handle_interrupt(CPUState
> *cpu,
> > >              cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
> > >              cpu_halted_set(cpu, 1);
> > >              cpu->exception_index = EXCP_HLT;
> > > -            qemu_mutex_unlock_iothread();
> > > +            cpu_mutex_unlock(cpu);
> > >              return true;
> > >          }
> > >  #if defined(TARGET_I386)
> > >          else if (interrupt_request & CPU_INTERRUPT_INIT) {
> > >              X86CPU *x86_cpu = X86_CPU(cpu);
> > >              CPUArchState *env = &x86_cpu->env;
> > > +            cpu_mutex_unlock(cpu);
> > > +            qemu_mutex_lock_iothread();
> > >              replay_interrupt();
> > >              cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0, 0);
> > >              do_cpu_init(x86_cpu);
> > > @@ -595,7 +601,7 @@ static inline bool cpu_handle_interrupt(CPUState
> *cpu,
> > >          else if (interrupt_request & CPU_INTERRUPT_RESET) {
> > >              replay_interrupt();
> > >              cpu_reset(cpu);
> > > -            qemu_mutex_unlock_iothread();
> > > +            cpu_mutex_unlock(cpu);
> > >              return true;
> > >          }
> > >  #endif
> > > @@ -604,7 +610,15 @@ static inline bool cpu_handle_interrupt(CPUState
> *cpu,
> > >             True when it is, and we should restart on a new TB,
> > >             and via longjmp via cpu_loop_exit.  */
> > >          else {
> > > +            cpu_mutex_unlock(cpu);
> > > +            if (cc->bql_interrupt) {
> > > +                qemu_mutex_lock_iothread();
> > > +            }
> > >              if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
> > > +                if (cc->bql_interrupt) {
> > > +                    qemu_mutex_unlock_iothread();
> > > +                }
> > > +                cpu_mutex_lock(cpu);
> > >                  replay_interrupt();
> > >                  /*
> > >                   * After processing the interrupt, ensure an
> EXCP_DEBUG is
> > > @@ -614,6 +628,11 @@ static inline bool cpu_handle_interrupt(CPUState
> *cpu,
> > >                  cpu->exception_index =
> > >                      (cpu->singlestep_enabled ? EXCP_DEBUG : -1);
> > >                  *last_tb = NULL;
> > > +            } else {
> > > +                if (cc->bql_interrupt) {
> > > +                    qemu_mutex_unlock_iothread();
> > > +                }
> > > +                cpu_mutex_lock(cpu);
> > >              }
> > >              /* The target hook may have updated the
> 'cpu->interrupt_request';
> > >               * reload the 'interrupt_request' value */
> > > @@ -627,7 +646,7 @@ static inline bool cpu_handle_interrupt(CPUState
> *cpu,
> > >          }
> > >
> > >          /* If we exit via cpu_loop_exit/longjmp it is reset in
> cpu_exec */
> > > -        qemu_mutex_unlock_iothread();
> > > +        cpu_mutex_unlock(cpu);
> > >      }
> > >
> > >      /* Finally, check if we need to exit to the main loop.  */
> > > @@ -691,7 +710,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu,
> TranslationBlock *tb,
> > >      }
> > >  #endif
> > >  }
> > > -
> > >  /* main execution loop */
> > >
> > >  int cpu_exec(CPUState *cpu)
> > >
> >
>
>

--000000000000559eaa05abc28853
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, that is correct. It&#39;s more work but also more ma=
intainable.<div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 31 lug 2020, 22:=
09 Robert Foley &lt;<a href=3D"mailto:robert.foley@linaro.org">robert.foley=
@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On =
Fri, 31 Jul 2020 at 14:02, Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@red=
hat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt; On 31/07/20 14:51, Robert Foley wrote:<br>
&gt; &gt; This change removes the implied BQL from the cpu_handle_interrupt=
,<br>
&gt; &gt; and cpu_handle_exception paths. We can now select per-arch if<br>
&gt; &gt; the BQL is needed or not by using the bql_interrupt flag.<br>
&gt; &gt; By default, the core code holds the BQL.<br>
&gt; &gt; One benefit of this change is that it leaves it up to the arch<br=
>
&gt; &gt; to make the change to remove BQL when it makes sense.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Robert Foley &lt;<a href=3D"mailto:robert.foley@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">robert.foley@linaro.org</a>&=
gt;<br>
&gt;<br>
&gt; No, please just modify all implementation to do lock/unlock.=C2=A0 It&=
#39;s a<br>
&gt; simpler patch than this on.<br>
<br>
Sure, we will update the patch based on this.<br>
<br>
To clarify, the suggestion here is to remove the bql_interrupt flag<br>
that we added and change all the per-arch interrupt callback code to<br>
do the lock/unlock of the BQL?=C2=A0 So for example change<br>
x86_cpu_exec_interrupt, and arm_cpu_exec_interrupt, etc to lock/unlock BQL?=
<br>
<br>
Thanks,<br>
-Rob<br>
<br>
<br>
&gt;<br>
&gt; Paolo<br>
&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 accel/tcg/cpu-exec.c | 34 ++++++++++++++++++++++++++-------=
-<br>
&gt; &gt;=C2=A0 1 file changed, 26 insertions(+), 8 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c<br>
&gt; &gt; index 80d0e649b2..cde27ee0bf 100644<br>
&gt; &gt; --- a/accel/tcg/cpu-exec.c<br>
&gt; &gt; +++ b/accel/tcg/cpu-exec.c<br>
&gt; &gt; @@ -517,9 +517,13 @@ static inline bool cpu_handle_exception(CPUS=
tate *cpu, int *ret)<br>
&gt; &gt;=C2=A0 #else<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (replay_exception()) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUClass *cc =3D =
CPU_GET_CLASS(cpu);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock_iothre=
ad();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cc-&gt;bql_interru=
pt) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mut=
ex_lock_iothread();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc-&gt;do_interru=
pt(cpu);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock_ioth=
read();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cc-&gt;bql_interru=
pt) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mut=
ex_unlock_iothread();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;exception=
_index =3D -1;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(cpu-=
&gt;singlestep_enabled)) {<br>
&gt; &gt; @@ -558,7 +562,7 @@ static inline bool cpu_handle_interrupt(CPUSt=
ate *cpu,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (unlikely(cpu_interrupt_request(cpu))) {<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int interrupt_request;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock_iothread();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mutex_lock(cpu);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt_request =3D cpu_inter=
rupt_request(cpu);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(cpu-&gt;singlestep=
_enabled &amp; SSTEP_NOIRQ)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Mask out exter=
nal interrupts for this step. */<br>
&gt; &gt; @@ -567,7 +571,7 @@ static inline bool cpu_handle_interrupt(CPUSt=
ate *cpu,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (interrupt_request &amp; CPU=
_INTERRUPT_DEBUG) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_reset_interru=
pt(cpu, CPU_INTERRUPT_DEBUG);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;exception=
_index =3D EXCP_DEBUG;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock_ioth=
read();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mutex_unlock(cpu);=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (replay_mode =3D=3D REPLAY_M=
ODE_PLAY &amp;&amp; !replay_has_interrupt()) {<br>
&gt; &gt; @@ -577,13 +581,15 @@ static inline bool cpu_handle_interrupt(CPU=
State *cpu,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_reset_interru=
pt(cpu, CPU_INTERRUPT_HALT);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_halted_set(cp=
u, 1);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;exception=
_index =3D EXCP_HLT;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock_ioth=
read();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mutex_unlock(cpu);=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 #if defined(TARGET_I386)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (interrupt_request &amp=
; CPU_INTERRUPT_INIT) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X86CPU *x86_cpu =
=3D X86_CPU(cpu);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUArchState *env=
 =3D &amp;x86_cpu-&gt;env;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mutex_unlock(cpu);=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock_iothre=
ad();<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 replay_interrupt(=
);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_svm_check_int=
ercept_param(env, SVM_EXIT_INIT, 0, 0);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_cpu_init(x86_c=
pu);<br>
&gt; &gt; @@ -595,7 +601,7 @@ static inline bool cpu_handle_interrupt(CPUSt=
ate *cpu,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (interrupt_request &amp=
; CPU_INTERRUPT_RESET) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 replay_interrupt(=
);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_reset(cpu);<b=
r>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock_ioth=
read();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mutex_unlock(cpu);=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 #endif<br>
&gt; &gt; @@ -604,7 +610,15 @@ static inline bool cpu_handle_interrupt(CPUS=
tate *cpu,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0True when it is, a=
nd we should restart on a new TB,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and via longjmp vi=
a cpu_loop_exit.=C2=A0 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mutex_unlock(cpu);=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cc-&gt;bql_interru=
pt) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mut=
ex_lock_iothread();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cc-&gt;cpu_ex=
ec_interrupt(cpu, interrupt_request)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cc-&=
gt;bql_interrupt) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 qemu_mutex_unlock_iothread();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mute=
x_lock(cpu);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rep=
lay_interrupt();<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* After processing the interrupt, ensure an EXCP_DEBUG is<br>
&gt; &gt; @@ -614,6 +628,11 @@ static inline bool cpu_handle_interrupt(CPUS=
tate *cpu,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu=
-&gt;exception_index =3D<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (cpu-&gt;singlestep_enabled ? EXCP_DEBUG : -1);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *la=
st_tb =3D NULL;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cc-&=
gt;bql_interrupt) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 qemu_mutex_unlock_iothread();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mute=
x_lock(cpu);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The target hoo=
k may have updated the &#39;cpu-&gt;interrupt_request&#39;;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* reload th=
e &#39;interrupt_request&#39; value */<br>
&gt; &gt; @@ -627,7 +646,7 @@ static inline bool cpu_handle_interrupt(CPUSt=
ate *cpu,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If we exit via cpu_loop_exit=
/longjmp it is reset in cpu_exec */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock_iothread();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mutex_unlock(cpu);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Finally, check if we need to exit to the m=
ain loop.=C2=A0 */<br>
&gt; &gt; @@ -691,7 +710,6 @@ static inline void cpu_loop_exec_tb(CPUState =
*cpu, TranslationBlock *tb,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 #endif<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; -<br>
&gt; &gt;=C2=A0 /* main execution loop */<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 int cpu_exec(CPUState *cpu)<br>
&gt; &gt;<br>
&gt;<br>
<br>
</blockquote></div>

--000000000000559eaa05abc28853--


