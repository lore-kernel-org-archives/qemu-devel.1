Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFBFC2D0C6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 10:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EC9207E0
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7sjyVhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EC9207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1il9nn-0005HZ-F4
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 05:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1il9n9-0004kQ-CI
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 05:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1il9n6-0005VS-EZ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 05:57:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45499
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1il9n6-0005RM-3m
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 05:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577530670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5PjrCP+bYwbhnndNvPykGZp5WKDW1MBmxa+yYKXq/U=;
 b=E7sjyVhRQ3h+vOFAd2OzNcILA6szW7u+YvjlZpIvYInrWN0LQkmgxJ308cPMntYtdATyfH
 r0hNQ0A8XrRKUVScN2nk9ULJyda0MRBhwhDOy26MxzormVb2aSlLFXarz6WAHIsSBAcG7Q
 IMrNLZgJqVxTuXzptlMADIaL4QEFjGc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-JQeCX8nNNj6-bRPXU8FMAQ-1; Sat, 28 Dec 2019 05:57:47 -0500
Received: by mail-ed1-f71.google.com with SMTP id c24so13061477edy.9
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 02:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8+wGAM3s5tlctSZCj8dEZy9SuBZU0TtkXSAMvso5RLs=;
 b=uApiHzUa3TNDcvMrcCuvuQwQeYGOkUKS9iYyT1r/JKcd/QzEvXoY4KqHpyXIo7fr8C
 qJ/V2M0LtgdbmhslOXsMg8OF57Apr+aFMuux7Jp/66VSVnnbPl1Kk049T8IPQCXRNrC1
 sLRC3cZVWZJr4ZzThn7gcpo2lIAheACCLD614JgPvqaf5AcmMxu10zQ+Q6BN6UcHFbKv
 glNud5jsM9AjTGq7JWfgKJx8/21ln9WutkYr1+hKANQOB+YY6CvZZS6gI2/Hd6sXE/P3
 ERbdToUfBrnul2TtQCUizgVs9EoqFJvgygU0pNF4O63p+LsVHZwHH2Hic33nOyeN+p0V
 tsZA==
X-Gm-Message-State: APjAAAVUicqIivmB9YK/ZECNUkudTT/46VLBR5FOLnskhzzKvLQTbLsK
 pSm2l0s6BM/JH5wfsVq5cPyj+Rt2YUvpxCEcp40E57NGe7N8SwDy1Y5r0IgKXVs8T/2iphTzB6n
 ZQ/e97qdr/O1rmaab+Cs0CU8gGCYw+cw=
X-Received: by 2002:a05:6402:1771:: with SMTP id
 da17mr61208214edb.68.1577530665820; 
 Sat, 28 Dec 2019 02:57:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAEVGgchiLXnHpo5XDpG6j937ydBFbZTnkRQpW67lOXKkssA/4L4gmtiWqX9fTmi2zN151VDoUkQP6mpPrdx4=
X-Received: by 2002:a05:6402:1771:: with SMTP id
 da17mr61208207edb.68.1577530665635; 
 Sat, 28 Dec 2019 02:57:45 -0800 (PST)
MIME-Version: 1.0
References: <CABgObfbKM_QNXJaAk7m2JYOoZgAAa+98d2x3==eYUkTi_CGw6Q@mail.gmail.com>
 <20191228093222.18431-1-xiaoyao.li@intel.com>
 <CABgObfZRjFVrUdWV81h6K7U+Jq=60uQR-uNvu5bLY=xs90FA8Q@mail.gmail.com>
 <1d4592b74493c637d4b897c771d8613d93462ec1.camel@intel.com>
In-Reply-To: <1d4592b74493c637d4b897c771d8613d93462ec1.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 28 Dec 2019 10:57:13 +0000
Message-ID: <CABgObfbiCrLtUoDnGZBVW+5hhfs2YYLs0nrcMeFgAPAir_R2mA@mail.gmail.com>
Subject: Re: [PATCH] accel/kvm: Make "kernel_irqchip" default on
To: Xiaoyao Li <xiaoyao.li@intel.com>
X-MC-Unique: JQeCX8nNNj6-bRPXU8FMAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="000000000000f2b3aa059ac17a44"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

--000000000000f2b3aa059ac17a44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 28 dic 2019, 10:24 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:

> BTW, it seems that this patch makes kernel_irqchip default on to
> workaround the
> bug.
> However, when explicitly configuring kernel_irqchip=3Doff, guest still fa=
ils
> booting due to "KVM: failed to send PV IPI: -95" with a latest upstream
> kernel
> ubuntu guest. Any idea about this?
>

We need to clear the PV IPI feature for userspace irqchip. Are you using
-cpu host by chance?

Paolo


> > Paolo
> > >  }
> > >
> > >  static void kvm_accel_class_init(ObjectClass *oc, void *data)
> > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > index 61f8bb8e5a42..fb1b43d5b972 100644
> > > --- a/include/hw/boards.h
> > > +++ b/include/hw/boards.h
> > > @@ -271,9 +271,6 @@ struct MachineState {
> > >
> > >      /*< public >*/
> > >
> > > -    bool kernel_irqchip_allowed;
> > > -    bool kernel_irqchip_required;
> > > -    bool kernel_irqchip_split;
> > >      char *dtb;
> > >      char *dumpdtb;
> > >      int phandle_start;
>
>

--000000000000f2b3aa059ac17a44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 28 dic 2019, 10:24 Xiaoyao Li &lt;<a href=3D"ma=
ilto:xiaoyao.li@intel.com">xiaoyao.li@intel.com</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">BTW, it seems that this patch makes kernel=
_irqchip default on to workaround the<br>
bug. <br>
However, when explicitly configuring kernel_irqchip=3Doff, guest still fail=
s<br>
booting due to &quot;KVM: failed to send PV IPI: -95&quot; with a latest up=
stream kernel<br>
ubuntu guest. Any idea about this? <br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">We need to clear the PV IPI feature for =
userspace irqchip. Are you using -cpu host by chance?</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Paolo<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 static void kvm_accel_class_init(ObjectClass *oc, void *dat=
a)<br>
&gt; &gt; diff --git a/include/hw/boards.h b/include/hw/boards.h<br>
&gt; &gt; index 61f8bb8e5a42..fb1b43d5b972 100644<br>
&gt; &gt; --- a/include/hw/boards.h<br>
&gt; &gt; +++ b/include/hw/boards.h<br>
&gt; &gt; @@ -271,9 +271,6 @@ struct MachineState {<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; &gt; <br>
&gt; &gt; -=C2=A0 =C2=A0 bool kernel_irqchip_allowed;<br>
&gt; &gt; -=C2=A0 =C2=A0 bool kernel_irqchip_required;<br>
&gt; &gt; -=C2=A0 =C2=A0 bool kernel_irqchip_split;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 char *dtb;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 char *dumpdtb;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int phandle_start;<br>
<br>
</blockquote></div></div></div>

--000000000000f2b3aa059ac17a44--


