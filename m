Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A81C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCD0207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmQ96M14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCD0207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jybOP-0000Op-8y
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jybNo-0008NO-Kq
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:35:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36258
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jybNm-0006rW-QW
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595511333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srwDp/A77RlMDm0W+H9Bcgwv7+kBUyKltBgmoIP4Ngw=;
 b=LmQ96M14i2msp3aiU6wG+j+ZNWeD4U81kgG8d+Q+qnXJ1iGOJe5zOJWcLqtA+lGFme3VMY
 ooSbDgkMVTLtkNub7iI3pIxuEbH9rsUDdQEIJ0Yhw56CZZolgv3IVXxC9cE+/y/RulZFUU
 7hiQik88QYsj1WmTvm34AVxZQywY9+8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-QEyyLVn0Nn2s1IJHQgaexQ-1; Thu, 23 Jul 2020 09:35:29 -0400
X-MC-Unique: QEyyLVn0Nn2s1IJHQgaexQ-1
Received: by mail-ej1-f69.google.com with SMTP id b14so2430617ejv.14
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 06:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=srwDp/A77RlMDm0W+H9Bcgwv7+kBUyKltBgmoIP4Ngw=;
 b=ORsyWaB7N09hFXNPq/+Lh93/Wb2J552ONFrbZrxCk69PaYTB5hwom7Iwr5jdj6Dh9f
 JKUAm3DCLzT08W887Ru685pMxoRLBcuXAvSNCAo7MjvKocsk7zeH6y84/zAw4s8sGf08
 gm+gB7QG1zetkXnJdCaK30Ioo017nMqkgwHL1gxFGSkXwF/9KbGVFajgrzGj4f3NyRBo
 Wj1gl+yg+FJsUSejMZ5UnFyblFNeXGFK7ysCqCp0Hz2StQWzFJ3nqVX+J+u8eB6EGHLl
 F9NGz/8FhxeISozPUNi/Z8kxk9m8XaukZLx7rmXpeQzFBFO3bLPkcfEW3/fAtoTAIQ5w
 QWQw==
X-Gm-Message-State: AOAM530yn4/MRdRUlUK0MhgpNB0jklmaUnQfn8BtrT6hQL+3z66X/577
 I5eCY7TmQRfHYx+jhXJSvVRBDBS5A6mGzhbO12aYhZqebU03e+USfom61pfxriXS0vZQn/7QT9v
 ASmFLX9y2lGSp0PQuOz7qs12ivbqDKpQ=
X-Received: by 2002:a17:906:7d90:: with SMTP id
 v16mr4308869ejo.27.1595511327842; 
 Thu, 23 Jul 2020 06:35:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRFiKHr2mDjAmOE4g1tcuQoAVviBpqidWuh1b1DQV18zSmF5musSgCQnUHCKMNIX0e0CVnVe7ZyvdNQ20Fg48=
X-Received: by 2002:a17:906:7d90:: with SMTP id
 v16mr4308854ejo.27.1595511327632; 
 Thu, 23 Jul 2020 06:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <bf007af9-f81e-3542-0237-5ea467f34377@siemens.com>
 <20200722173513.GO1274972@habkost.net>
 <7be95bd6-dfc6-2c22-85a1-a1c932d07fdd@siemens.com>
 <20200722204731.GP1274972@habkost.net> <20200722212159.GQ1274972@habkost.net>
 <20200723084026.GB2622@work-vm>
 <3eba2f87-5527-bd7c-2eb7-ce67cb32d9ef@redhat.com>
 <87pn8mo20i.fsf@vitty.brq.redhat.com> <20200723125223.GI2621@work-vm>
 <60af679d-8c7d-cc37-344b-79aa193df166@siemens.com>
 <87mu3qnz00.fsf@vitty.brq.redhat.com>
In-Reply-To: <87mu3qnz00.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Jul 2020 15:35:15 +0200
Message-ID: <CABgObfZZCPGq9-G8aP9+6X1kxCfPFy9Kbfgq8FUsNKLdxOfLpQ@mail.gmail.com>
Subject: Re: 5.1.0-rc1 regression: reset fails with kvm and -cpu host
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000eb4cc905ab1bed1c"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000eb4cc905ab1bed1c
Content-Type: text/plain; charset="UTF-8"

Yes, that seems correct.

Paolo


Il gio 23 lug 2020, 15:26 Vitaly Kuznetsov <vkuznets@redhat.com> ha scritto:

> This depends on whether the guest has performed VMXON or not I believe.
>
> Anyways, I *think* the fix will be:
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 2b6b744..75c2e68 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -3883,7 +3883,7 @@ static int kvm_put_nested_state(X86CPU *cpu)
>      } else {
>          env->nested_state->flags &= ~KVM_STATE_NESTED_GUEST_MODE;
>      }
> -    if (env->hflags2 & HF2_GIF_MASK) {
> +    if (cpu_has_svm(env) && (env->hflags2 & HF2_GIF_MASK)) {
>          env->nested_state->flags |= KVM_STATE_NESTED_GIF_SET;
>      } else {
>          env->nested_state->flags &= ~KVM_STATE_NESTED_GIF_SET;
>
> As "KVM_STATE_NESTED_GIF_SET" is not relevant to nVMX, this works for me
> but let me explore kernel side of this a bit more.
>
> --
> Vitaly
>
>

--000000000000eb4cc905ab1bed1c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Yes, that seems correct.<div dir=3D"auto"><br></div>=
<div dir=3D"auto">Paolo</div><br><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">Il gio 23 lug 2020, 15:26 Vitaly Kuznetsov &lt;<=
a href=3D"mailto:vkuznets@redhat.com">vkuznets@redhat.com</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">This depends on whether the gues=
t has performed VMXON or not I believe.<br>
<br>
Anyways, I *think* the fix will be:<br>
<br>
diff --git a/target/i386/kvm.c b/target/i386/kvm.c<br>
index 2b6b744..75c2e68 100644<br>
--- a/target/i386/kvm.c<br>
+++ b/target/i386/kvm.c<br>
@@ -3883,7 +3883,7 @@ static int kvm_put_nested_state(X86CPU *cpu)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;nested_state-&gt;flags &amp;=3D ~=
KVM_STATE_NESTED_GUEST_MODE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (env-&gt;hflags2 &amp; HF2_GIF_MASK) {<br>
+=C2=A0 =C2=A0 if (cpu_has_svm(env) &amp;&amp; (env-&gt;hflags2 &amp; HF2_G=
IF_MASK)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;nested_state-&gt;flags |=3D KVM_S=
TATE_NESTED_GIF_SET;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;nested_state-&gt;flags &amp;=3D ~=
KVM_STATE_NESTED_GIF_SET;<br>
<br>
As &quot;KVM_STATE_NESTED_GIF_SET&quot; is not relevant to nVMX, this works=
 for me<br>
but let me explore kernel side of this a bit more.<br>
<br>
-- <br>
Vitaly<br>
<br>
</blockquote></div></div></div>

--000000000000eb4cc905ab1bed1c--


