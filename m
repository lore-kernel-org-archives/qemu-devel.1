Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E46C2D0C6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 10:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FE720838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 10:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2Nn8+Y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FE720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1il8wA-00049i-Eq
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 05:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1il8vV-0003jw-W3
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 05:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1il8vT-00079H-6D
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 05:02:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39907
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1il8vS-000722-T4
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 05:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577527343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8w3PFCBMhPHALwdp7x0d5qLtXF14glvy09u5iythQLA=;
 b=Z2Nn8+Y1zKcxaBhb7v7orrg5cegopJ0hocMiFKYe7kw0NGqVbRWuP470ouFYBiugFXWOd4
 PXq0s0NL5Pvd24Z1cDcc1MCWlu8295M20QCjl2G6AahGCDsEgajz2cWaiQHz0m5Qnt9MyL
 79hmCoCmKuJ8tqomE0lf+aWHov+Mv1E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-L469gu1JMOuCkkHKtveRbg-1; Sat, 28 Dec 2019 05:02:22 -0500
Received: by mail-ed1-f69.google.com with SMTP id d21so2365340edy.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 02:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0zGk/aC34JNikEwYn8RmhJ0vWp/jEY8grNqwivAAfZQ=;
 b=CfcmwzG3UL1d4XuDi8uTuspZuJ/vZWSvw1QXaC1yNU8BaM977EsG86cUmyTIOMSuvQ
 D5rspxMK9hFT0iVEtDL536la5hpXrD/SE4Elv+gPTP47VuoFTweEe0CHKLC0c+wZwfLE
 j6Jb3x8bQlRpSPhky9YMyMB5E4RoPVLlqwSnhBRQIy6IMPnGG5qZMhv/bnxdc4NNXQuX
 hnDhSBIB6geO64fx//uPVClDLCBqKjsP3ZVPoE5xEQ63Sy6tojc0HzpEq2T3XiT6TJ6/
 gdAUG5c+PbP22WsTxn2GIeBJXsfA0m5p3KDwMyHBANKEL1aalFiW6rJjAAJRp94r6x1R
 wIdw==
X-Gm-Message-State: APjAAAUab3fGP9uR5x6544dxS4wDAYEvwFoX3P4e6BdXMfBrapHEdpfG
 6NWfc0Cyj1SFGukRUMdGK0ZntXiTJ8K0joa3Ksxk1BgD8JYi9pnZNQJ/kuLFldI1882CjvRztdU
 KyBs+sEYE5IpNhTJvFx9TiBBFLbiTYpM=
X-Received: by 2002:a17:906:560e:: with SMTP id
 f14mr58497852ejq.300.1577527340635; 
 Sat, 28 Dec 2019 02:02:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8jEBk7wZvkMoMhyPAuLIyV/Ia8KGOjB77z8yD6/IdtA6t5q7xJgq2ABSDEQ6AYVTfNRm/oL6TxWT4sxYnl8c=
X-Received: by 2002:a17:906:560e:: with SMTP id
 f14mr58497826ejq.300.1577527340396; 
 Sat, 28 Dec 2019 02:02:20 -0800 (PST)
MIME-Version: 1.0
References: <CABgObfbKM_QNXJaAk7m2JYOoZgAAa+98d2x3==eYUkTi_CGw6Q@mail.gmail.com>
 <20191228093222.18431-1-xiaoyao.li@intel.com>
In-Reply-To: <20191228093222.18431-1-xiaoyao.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 28 Dec 2019 10:02:09 +0000
Message-ID: <CABgObfZRjFVrUdWV81h6K7U+Jq=60uQR-uNvu5bLY=xs90FA8Q@mail.gmail.com>
Subject: Re: [PATCH] accel/kvm: Make "kernel_irqchip" default on
To: Xiaoyao Li <xiaoyao.li@intel.com>
X-MC-Unique: L469gu1JMOuCkkHKtveRbg-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="000000000000bf93c1059ac0b4b1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bf93c1059ac0b4b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 28 dic 2019, 09:48 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:

> Commit 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an
> accelerator property") moves kernel_irqchip property from "-machine" to
> "-accel kvm", but it forgets to set the default value of
> kernel_irqchip_allowed and kernel_irqchip_split.
>
> Also cleaning up the three useless members (kernel_irqchip_allowed,
> kernel_irqchip_required, kernel_irqchip_split) in struct MachineState.
>
> Fixes: 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an
> accelerator property")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>

Please also add a Reported-by line for Vitaly Kuznetsov.

---
>  accel/kvm/kvm-all.c | 3 +++
>  include/hw/boards.h | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index b2f1a5bcb5ef..40f74094f8d3 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3044,8 +3044,11 @@ bool kvm_kernel_irqchip_split(void)
>  static void kvm_accel_instance_init(Object *obj)
>  {
>      KVMState *s =3D KVM_STATE(obj);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(current_machine);
>
>      s->kvm_shadow_mem =3D -1;
> +    s->kernel_irqchip_allowed =3D true;
> +    s->kernel_irqchip_split =3D mc->default_kernel_irqchip_split;
>

Can you initialize this from the init_machine method instead of assuming
that current_machine has been initialized earlier?

Thanks for the quick fix!

Paolo

>  }
>
>  static void kvm_accel_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 61f8bb8e5a42..fb1b43d5b972 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -271,9 +271,6 @@ struct MachineState {
>
>      /*< public >*/
>
> -    bool kernel_irqchip_allowed;
> -    bool kernel_irqchip_required;
> -    bool kernel_irqchip_split;
>      char *dtb;
>      char *dumpdtb;
>      int phandle_start;
> --
> 2.19.1
>
>

--000000000000bf93c1059ac0b4b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 28 dic 2019, 09:48 Xiaoyao Li &lt;<a href=3D"ma=
ilto:xiaoyao.li@intel.com">xiaoyao.li@intel.com</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">Commit 11bc4a13d1f4 (&quot;kvm: convert &q=
uot;-machine kernel_irqchip&quot; to an<br>
accelerator property&quot;) moves kernel_irqchip property from &quot;-machi=
ne&quot; to<br>
&quot;-accel kvm&quot;, but it forgets to set the default value of<br>
kernel_irqchip_allowed and kernel_irqchip_split.<br>
<br>
Also cleaning up the three useless members (kernel_irqchip_allowed,<br>
kernel_irqchip_required, kernel_irqchip_split) in struct MachineState.<br>
<br>
Fixes: 11bc4a13d1f4 (&quot;kvm: convert &quot;-machine kernel_irqchip&quot;=
 to an accelerator property&quot;)<br>
Signed-off-by: Xiaoyao Li &lt;<a href=3D"mailto:xiaoyao.li@intel.com" targe=
t=3D"_blank" rel=3D"noreferrer">xiaoyao.li@intel.com</a>&gt;<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Please also add=
 a Reported-by line for Vitaly Kuznetsov.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
---<br>
=C2=A0accel/kvm/kvm-all.c | 3 +++<br>
=C2=A0include/hw/boards.h | 3 ---<br>
=C2=A02 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c<br>
index b2f1a5bcb5ef..40f74094f8d3 100644<br>
--- a/accel/kvm/kvm-all.c<br>
+++ b/accel/kvm/kvm-all.c<br>
@@ -3044,8 +3044,11 @@ bool kvm_kernel_irqchip_split(void)<br>
=C2=A0static void kvm_accel_instance_init(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0KVMState *s =3D KVM_STATE(obj);<br>
+=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_GET_CLASS(current_machine);<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;kvm_shadow_mem =3D -1;<br>
+=C2=A0 =C2=A0 s-&gt;kernel_irqchip_allowed =3D true;<br>
+=C2=A0 =C2=A0 s-&gt;kernel_irqchip_split =3D mc-&gt;default_kernel_irqchip=
_split;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Can you initialize this from the init_machine method instead of assu=
ming that current_machine has been initialized earlier?</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Thanks for the quick fix!</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0}<br>
<br>
=C2=A0static void kvm_accel_class_init(ObjectClass *oc, void *data)<br>
diff --git a/include/hw/boards.h b/include/hw/boards.h<br>
index 61f8bb8e5a42..fb1b43d5b972 100644<br>
--- a/include/hw/boards.h<br>
+++ b/include/hw/boards.h<br>
@@ -271,9 +271,6 @@ struct MachineState {<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; public &gt;*/<br>
<br>
-=C2=A0 =C2=A0 bool kernel_irqchip_allowed;<br>
-=C2=A0 =C2=A0 bool kernel_irqchip_required;<br>
-=C2=A0 =C2=A0 bool kernel_irqchip_split;<br>
=C2=A0 =C2=A0 =C2=A0char *dtb;<br>
=C2=A0 =C2=A0 =C2=A0char *dumpdtb;<br>
=C2=A0 =C2=A0 =C2=A0int phandle_start;<br>
-- <br>
2.19.1<br>
<br>
</blockquote></div></div></div>

--000000000000bf93c1059ac0b4b1--


