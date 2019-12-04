Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D819FC2BC73
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94EA22073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZFP5+Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EA22073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icUnh-000283-PY
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <catherine.hecx@gmail.com>) id 1icUmb-0001NE-Lv
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <catherine.hecx@gmail.com>) id 1icUma-0002TF-5S
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:33:33 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
 id 1icUmY-0002MJ-7M
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:33:32 -0500
Received: by mail-oi1-x243.google.com with SMTP id 6so6825219oix.7
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 05:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kgXZVlg/np2RFAlicTQXy8RF82Wnir/9w4md2lq06Cg=;
 b=NZFP5+Q2g7RWxw6vPrVrYKyNjSxDWIaXsKo/j4Y4s4TT6eMqx+XZks80NjcKy5mck+
 hrMcNyWcuRMryJaQrwdCt/HMd/oS2h0CQGkGInBhkr/mrCoAUONJJLMlaWYqPKEtx/Cp
 xFrtpoBSjwNTQUOYXvP6xUnmYgBK9ulLe+bQkmK9KTdBsXxqIH+At7wHfXdDhIF7qu+C
 ZUPMfc9KlyUVdOkB4C2FloWnSoPXIxfkaa6BdpHFK5uGgHx0ySs1oeSuXlUgtuUu1KEy
 XZLMabvQK3rW7FZzuCvTUqSkGO1UuhokLt7pKGqoVL0p4AKbvYbcTxBuoRIb1sna6s+n
 d44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kgXZVlg/np2RFAlicTQXy8RF82Wnir/9w4md2lq06Cg=;
 b=hwLh89lQq3KNl54voXBkRwHok2WvFFBk4f1eAIBqxP9v+KVcvMN13ncIBGjzqJq66D
 1u3Nb3OKUi5xTr37k5GxiqOGelWNl6yfWc2dUpCapUp4RP8l0/4G0JMRS8ohN9alENfB
 KeIWHIXHj8J9NwckEkZ8K3LqqefDLXHL/g0eFbA2cKUdJvrt1JOxTk5Ky/n+0d0Xhp2G
 GNstaXaEuSm9IQzHbQwTiA2Ga5hGOO3V5FJxfKXMu3VZsA6OPbApPRao7puwldnv3QGv
 EpdiStQ4RYaFebQW5VOkC3mtxbUBhnjY+D+6EWfSvky0DFro25boYiLIF7xyVvfEBPpJ
 WdOg==
X-Gm-Message-State: APjAAAWB1vSOApkbN+d1w2T1NtEo5+5eehRiXFM4qabEoJr68B0gMFGM
 ZQ+VoOGb7Wuj6Kha0ddWDTvoB5V3yY8wFetWOpk=
X-Google-Smtp-Source: APXvYqzPMynBnODSBzE67mrEmqAI1It0HVH7L5uZQfYArzHXrMmN5lt/Tiebv8iLmyYmJid3lrrDcZ1UKHVODA9uUrk=
X-Received: by 2002:a05:6808:f:: with SMTP id
 u15mr2471778oic.164.1575466404865; 
 Wed, 04 Dec 2019 05:33:24 -0800 (PST)
MIME-Version: 1.0
References: <1575449430-23366-1-git-send-email-catherine.hecx@gmail.com>
 <2ac1a83c-6958-1b49-295f-92149749fa7c@redhat.com>
In-Reply-To: <2ac1a83c-6958-1b49-295f-92149749fa7c@redhat.com>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Wed, 4 Dec 2019 21:33:12 +0800
Message-ID: <CAEn6zmFex9WJ9jr5-0br7YzQZ=jA5bQn314OM+U=Q6ZGPiCRAg@mail.gmail.com>
Subject: Re: [PATCH] target/i386: relax assert when old host kernels don't
 include msrs
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006ae9da0598e0db04"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006ae9da0598e0db04
Content-Type: text/plain; charset="UTF-8"

Hi Paolo
[sorry to resend it, seems to reply it incorrectly]

On Wed, 4 Dec 2019 at 19:23, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 04/12/19 09:50, Catherine Ho wrote:
> > Commit 20a78b02d315 ("target/i386: add VMX features") unconditionally
> > add vmx msr entry although older host kernels don't include them.
> >
> > But old host kernel + newest qemu will cause a qemu crash as follows:
> > qemu-system-x86_64: error: failed to set MSR 0x480 to 0x0
> > target/i386/kvm.c:2932: kvm_put_msrs: Assertion `ret ==
> > cpu->kvm_msr_buf->nmsrs' failed.
> >
> > This fixes it by relaxing the condition.
>
> This is intentional.  The VMX MSR entries should not have been added.
> What combination of host kernel/QEMU are you using, and what QEMU
> command line?
>
>
> Host kernel: 4.15.0 (ubuntu 18.04)
Qemu: https://gitlab.com/virtio-fs/qemu/tree/virtio-fs-dev
cmdline: qemu-system-x86_64 -M pc -cpu host --enable-kvm -smp 8 \
                  -m 4G,maxmem=4G

But before 20a78b02d315, the older kernel + latest qemu can boot guest
successfully.

Best Regards,
Catherine

--0000000000006ae9da0598e0db04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Paolo</div><div>[sorry to resend =
it, seems to reply it incorrectly]<br></div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 4 Dec 2019 at 19:23, Pa=
olo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n 04/12/19 09:50, Catherine Ho wrote:<br>
&gt; Commit 20a78b02d315 (&quot;target/i386: add VMX features&quot;) uncond=
itionally<br>
&gt; add vmx msr entry although older host kernels don&#39;t include them.<=
br>
&gt; <br>
&gt; But old host kernel + newest qemu will cause a qemu crash as follows:<=
br>
&gt; qemu-system-x86_64: error: failed to set MSR 0x480 to 0x0<br>
&gt; target/i386/kvm.c:2932: kvm_put_msrs: Assertion `ret =3D=3D<br>
&gt; cpu-&gt;kvm_msr_buf-&gt;nmsrs&#39; failed.<br>
&gt; <br>
&gt; This fixes it by relaxing the condition.<br>
<br>
This is intentional.=C2=A0 The VMX MSR entries should not have been added.<=
br>
What combination of host kernel/QEMU are you using, and what QEMU<br>
command line?<br>
<br><br></blockquote><div>
<div>Host kernel: 4.15.0 (ubuntu 18.04)</div><div>Qemu: <a href=3D"https://=
gitlab.com/virtio-fs/qemu/tree/virtio-fs-dev" target=3D"_blank">https://git=
lab.com/virtio-fs/qemu/tree/virtio-fs-dev</a></div><div>cmdline: qemu-syste=
m-x86_64 -M pc -cpu host --enable-kvm -smp 8 \<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -m 4G,maxmem=3D4G</div><div><br></di=
v><div>But before=20
20a78b02d315, the older kernel=C2=A0+ latest qemu can boot guest</div><div>=
successfully.</div><div><br></div><div>Best Regards,</div><div>Catherine</d=
iv>=C2=A0

<br></div></div></div>

--0000000000006ae9da0598e0db04--

