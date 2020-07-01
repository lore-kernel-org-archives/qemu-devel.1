Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43979C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B9F2085B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bI57N5oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B9F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhpP-0000Yu-CF
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqhok-00008V-3i
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:50:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21415
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqhoh-0008Hz-6W
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593629441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R8rVCPJTaO5qYr1ca3cWG6gNe34yXi4fc524fMoJbe0=;
 b=bI57N5oW2N7hJ4jPWXDH/FIPTqHJf5cLStRHXiV0cX96s7ECQcTgoQGoDstV1PXmuxzObo
 w9w3rmnj1cbXY72Tk1xYHqEgRNUzyM13bTOmYPJHelQk+m0neTebOranUfB7tKekn+ZkRg
 jMuPsaKyefB0gxVCwZmK+OxzWt1Tj1o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-lQhq-dGPOaqwG1l8K3gY1Q-1; Wed, 01 Jul 2020 14:50:39 -0400
X-MC-Unique: lQhq-dGPOaqwG1l8K3gY1Q-1
Received: by mail-ed1-f72.google.com with SMTP id x20so22558686edr.20
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 11:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R8rVCPJTaO5qYr1ca3cWG6gNe34yXi4fc524fMoJbe0=;
 b=cj0QalQZMctJ81oLt0Qf6/yO/TC3rqjnpqFYer/IKJamq1AEfO/JYzuSHFrC4G/lpT
 /EYv0XTuh6iaT1PZCdOwpLkt20EvRG/i9+Bnus0EBG1b/8Lj2rArT+7fs2+2zO/9MAEP
 a9yHvFlHg9nQ5neMrY/wxuE+UXn000PF286bE9bIE0QbYjPu6/eF0Tud/VnKWNFAJ2rl
 oSR9RK5QWNKVqeYlWSHMpiPlqpmiKJcE5aMMMSIMcN1m97fTN6oa8twPd9owejYTCjj/
 4HJ4qQ1fkYsQeIYBnib47W9VzFjOwv69GOnxqiOXA9EhmHCQAJAlGybmCsgQAnxSpkzd
 IqRA==
X-Gm-Message-State: AOAM533aHvhbILY7Gt6m43yBWgJ6V7mrHQsW+hKlrFOn1znLZEFGEWSY
 C4N7i/3A7N1miLH+Av2wF3TagGzvJ08foaY2FyGMqdVwCSPmYYYqtSTz/+mUFX3+dNIPCXdoX1b
 e8OYBb0/IeptLA6gSns61GwNDiBeURss=
X-Received: by 2002:a05:6402:21c2:: with SMTP id
 bi2mr30391870edb.296.1593629438727; 
 Wed, 01 Jul 2020 11:50:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCW9gu1Y/PBj8P5VukR3GuNvEnICd4eDdZMcMWcD+6ofrMdlzm69LX019ftGnsC6eC7IhvpgNUo3X8tGF/Q6g=
X-Received: by 2002:a05:6402:21c2:: with SMTP id
 bi2mr30391852edb.296.1593629438550; 
 Wed, 01 Jul 2020 11:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200630102824.77604-1-r.bolshakov@yadro.com>
 <20200630102824.77604-5-r.bolshakov@yadro.com>
 <d75c6bd1-b588-796b-e238-21ff41fce60d@redhat.com>
 <20200630155059.GA78555@SPB-NB-133.local>
 <2ba7aa12-9eba-1cef-93e0-5561f50629b9@redhat.com>
 <20200701183645.GC78555@SPB-NB-133.local>
In-Reply-To: <20200701183645.GC78555@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 1 Jul 2020 20:50:26 +0200
Message-ID: <CABgObfaFJkcEazMKjGi_eVdNia0vYqQ8ookcaPKrrJkBET=9tw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] i386: hvf: Implement CPU kick
To: Roman Bolshakov <r.bolshakov@yadro.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000096c1c405a965c4fe"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>, Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000096c1c405a965c4fe
Content-Type: text/plain; charset="UTF-8"

Thanks, sounds good! Of course the best solution would be in HVF itself,
similar to KVM and WHPX, but at least it's possible to work around it.

Paolo

Il mer 1 lug 2020, 20:37 Roman Bolshakov <r.bolshakov@yadro.com> ha scritto:

> On Tue, Jun 30, 2020 at 06:04:23PM +0200, Paolo Bonzini wrote:
> > On 30/06/20 17:50, Roman Bolshakov wrote:
> > > On Tue, Jun 30, 2020 at 02:33:42PM +0200, Paolo Bonzini wrote:
> > >> Can a signal interrupt hv_vcpu_run?  If so you actually don't need
> > >> hv_vcpu_interrupt at all.
> > >
> > > Existing signal masking and SIG_IPI didn't work IIRC when I tried to
> add
> > > a primitive version of gdbstub support.
> >
> > You can try pthread_kill followed by hv_vcpu_interrupt if it doesn't.
> > The signal would be delivered after return to userspace.
> >
>
> I looked at the signal setup for HVF again. I was wrong with regards to
> SIG_IPI. It isn't delivered to vCPU because the signal is masked, this
> fixes it:
>
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index d81f569aed..7bf05bca21 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -479,6 +479,7 @@ int hvf_init_vcpu(CPUState *cpu)
>
>      pthread_sigmask(SIG_BLOCK, NULL, &set);
>      sigdelset(&set, SIG_IPI);
> +    pthread_sigmask(SIG_SETMASK, &set, NULL);
>
>      init_emu();
>      init_decoder();
>
> But the signal is delivered only after vmxexit, perhaps a sequence of
> pthread_kill() and hv_vcpu_interrupt() is really needed.
>
> So, there are two race windows on kernel-to-user border in v2: just
> before checking the deadline and vmenter and just after vmxexit and
> re-arm of preemption timer, that's two places where kicks could be lost.
> The approach you proposed seems to address them.
>
> Thanks,
> Roman
>
> > >> You can also require the preemption time, all
> > >> processor that support HVF have it, but never set it by default.  The
> > >> deadline can be left at 0 all the time; instead, you toggle the bit in
> > >> the pin-based controls.  In the signal handler you do:
> > >>
> > >>    if (atomic_xchg(&env->hvf_in_guest, false)) {
> > >>            wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
> > >>                  rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
> > >>                    | VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
> > >>    }
> > >>
> > >> In the main loop you do:
> > >>
> > >>    atomic_set(&env->hvf_guest_mode, true);
> > >>    smp_mb();
> > >>    hv_vcpu_run(...);
> > >>    atomic_set(&env->hvf_guest_mode, false);
> > >>
> > >> and in the preemption timer vmexit handler:
> > >>
> > >>            wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
> > >>                  rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
> > >>                    & ~VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
> > >>
> > >
>
>

--00000000000096c1c405a965c4fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks, sounds good! Of course the best solution would be=
 in HVF itself, similar to KVM and WHPX, but at least it&#39;s possible to =
work around it.<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il =
mer 1 lug 2020, 20:37 Roman Bolshakov &lt;<a href=3D"mailto:r.bolshakov@yad=
ro.com">r.bolshakov@yadro.com</a>&gt; ha scritto:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">On Tue, Jun 30, 2020 at 06:04:23PM +0200, Paolo Bonzini wrot=
e:<br>
&gt; On 30/06/20 17:50, Roman Bolshakov wrote:<br>
&gt; &gt; On Tue, Jun 30, 2020 at 02:33:42PM +0200, Paolo Bonzini wrote:<br=
>
&gt; &gt;&gt; Can a signal interrupt hv_vcpu_run?=C2=A0 If so you actually =
don&#39;t need<br>
&gt; &gt;&gt; hv_vcpu_interrupt at all.<br>
&gt; &gt; <br>
&gt; &gt; Existing signal masking and SIG_IPI didn&#39;t work IIRC when I t=
ried to add<br>
&gt; &gt; a primitive version of gdbstub support.<br>
&gt; <br>
&gt; You can try pthread_kill followed by hv_vcpu_interrupt if it doesn&#39=
;t.<br>
&gt; The signal would be delivered after return to userspace.<br>
&gt; <br>
<br>
I looked at the signal setup for HVF again. I was wrong with regards to<br>
SIG_IPI. It isn&#39;t delivered to vCPU because the signal is masked, this<=
br>
fixes it:<br>
<br>
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c<br>
index d81f569aed..7bf05bca21 100644<br>
--- a/target/i386/hvf/hvf.c<br>
+++ b/target/i386/hvf/hvf.c<br>
@@ -479,6 +479,7 @@ int hvf_init_vcpu(CPUState *cpu)<br>
<br>
=C2=A0 =C2=A0 =C2=A0pthread_sigmask(SIG_BLOCK, NULL, &amp;set);<br>
=C2=A0 =C2=A0 =C2=A0sigdelset(&amp;set, SIG_IPI);<br>
+=C2=A0 =C2=A0 pthread_sigmask(SIG_SETMASK, &amp;set, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0init_emu();<br>
=C2=A0 =C2=A0 =C2=A0init_decoder();<br>
<br>
But the signal is delivered only after vmxexit, perhaps a sequence of<br>
pthread_kill() and hv_vcpu_interrupt() is really needed.<br>
<br>
So, there are two race windows on kernel-to-user border in v2: just<br>
before checking the deadline and vmenter and just after vmxexit and<br>
re-arm of preemption timer, that&#39;s two places where kicks could be lost=
.<br>
The approach you proposed seems to address them.<br>
<br>
Thanks,<br>
Roman<br>
<br>
&gt; &gt;&gt; You can also require the preemption time, all<br>
&gt; &gt;&gt; processor that support HVF have it, but never set it by defau=
lt.=C2=A0 The<br>
&gt; &gt;&gt; deadline can be left at 0 all the time; instead, you toggle t=
he bit in<br>
&gt; &gt;&gt; the pin-based controls.=C2=A0 In the signal handler you do:<b=
r>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 if (atomic_xchg(&amp;env-&gt;hvf_in_guest, false=
)) {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wvmcs(cpu-&gt;hvf_fd=
, VMCS_PIN_BASED_CTLS,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 rvmcs(cpu-&gt;hvf_fd, VMCS_PIN_BASED_CTLS)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; In the main loop you do:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 atomic_set(&amp;env-&gt;hvf_guest_mode, true);<b=
r>
&gt; &gt;&gt;=C2=A0 =C2=A0 smp_mb();<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 hv_vcpu_run(...);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 atomic_set(&amp;env-&gt;hvf_guest_mode, false);<=
br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; and in the preemption timer vmexit handler:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 <br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wvmcs(cpu-&gt;hvf_fd=
, VMCS_PIN_BASED_CTLS,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 rvmcs(cpu-&gt;hvf_fd, VMCS_PIN_BASED_CTLS)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &amp; ~VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);<br>
&gt; &gt;&gt;<br>
&gt; &gt; <br>
<br>
</blockquote></div>

--00000000000096c1c405a965c4fe--


