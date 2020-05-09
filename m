Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9ABC54E4A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 21:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B338920A8B
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 21:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgDLR+mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B338920A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXWeO-0005En-Q2
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 17:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jXWdM-0004N8-6w
 for qemu-devel@nongnu.org; Sat, 09 May 2020 17:03:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32766
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jXWdK-0003fR-9f
 for qemu-devel@nongnu.org; Sat, 09 May 2020 17:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589058220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eWQ7oRRRzgy+2UB7pbmKBWhbVt318EdO1qW0dY5SxA4=;
 b=OgDLR+mbgM4RCBubyyLP1A5kSuC9drl4K32B3JdBK56wcFFC2eDZTeXqJ0XGsiGuZslCle
 j3JFs67ZI+bpClHiMXdYnWOgnN+MxHti47aQfA9lAls3ucodi3ag2rvkY2+l7UTuy21UeG
 f6MFC8sd2saVgFlwVcGl16JsLD+6FHQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-ZcWW9Im0OR6VQWa8NxjJLg-1; Sat, 09 May 2020 17:03:38 -0400
X-MC-Unique: ZcWW9Im0OR6VQWa8NxjJLg-1
Received: by mail-ej1-f71.google.com with SMTP id q25so2178103ejz.21
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 14:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eWQ7oRRRzgy+2UB7pbmKBWhbVt318EdO1qW0dY5SxA4=;
 b=jXzcW3uK0c8Yk8jU3ffPXSTmQokUXzI27XC7UooVBqCNXAzAIGgmMkpjssCPqCRjPI
 0eJFmF3eSrUCZugltFOLiMy44fMYaWckozBl461STmrHrEYGvO4d/Vpjk38EllNfMQ/u
 sPe4tOpTiW8BPp11dwuJEmIa+SL38tw3Tho+AjJKkon2Abmu1yMPP73jbtX4bBo4za9t
 lvBi2zKQID3TAC5KnW/IdcwIlCrE2ceBskZLsGEM8rcL0iPxwyO0XqjlJZiuk8S3E2S5
 x3/GRXS7ZLhdPjStqFAvQ0iDGHUQo4YHasTxmPgipeRue/dMUwh2BjlCB3rPWOZBHzZq
 3fqA==
X-Gm-Message-State: AGi0PuYz2r8NkIngiaJUxVP6nnxwLM8xU6cAiQjPsjEUUlFYxOJDahtS
 Cnmd4UZSLXKzoU/rIXgjAmfOT6eqP4ZoiVrVNtGHl3KK5jxf4kFrfAXnDOPPJI4c1xFGlzl4qAg
 Ncdl+x8UwPkbksCrBnyARu1C28OkAbUI=
X-Received: by 2002:a05:6402:297:: with SMTP id
 l23mr7826943edv.57.1589058217227; 
 Sat, 09 May 2020 14:03:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJljXkkW4jro+DvOcRbZr0X5qyoAZl+Xz1H8KzzCfxpXZcLjGVU7yxuAkOFgguGAJHPpe6OAz00/u5WEWYCrec=
X-Received: by 2002:a05:6402:297:: with SMTP id
 l23mr7826897edv.57.1589058216890; 
 Sat, 09 May 2020 14:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200509130910.26335-1-f4bug@amsat.org>
 <20200509130910.26335-10-f4bug@amsat.org>
 <ba3d3ba1-09bf-17a0-2116-549fa92e1ed6@amsat.org>
 <CAAdtpL5KT0H3+yVRgzCwVaLYUUSCBW8vK4X3cHX_N91NPkUFBg@mail.gmail.com>
In-Reply-To: <CAAdtpL5KT0H3+yVRgzCwVaLYUUSCBW8vK4X3cHX_N91NPkUFBg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 9 May 2020 23:03:24 +0200
Message-ID: <CABgObfZ78q9Eaik63DM-Oy60MKpoqbmtq6QZE8tazrjwqTrhgg@mail.gmail.com>
Subject: Re: [PATCH 09/11] target/cpu: Restrict handlers using hwaddr type to
 system-mode
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000008bad0f05a53d7211"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 17:03:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "open list:vfio-ccw" <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008bad0f05a53d7211
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 9 mag 2020, 22:01 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> ha
scritto:

> > I forgot once Peter Maydell told me we can't do that for some reason I
> > don't remember.
> >
> > At least this changes the sizeof(CPUClass), so we get:
> >
> > qom/object.c:315:type_initialize: assertion failed: (parent->class_size
> > <=3D ti->class_size)
> >
> > So we can't poison the hwaddr type? (final patch of this series).
>
> Well, this works...:
>
> -- >8 --
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -167,6 +167,7 @@ typedef struct CPUClass {
>      int reset_dump_flags;
>      bool (*has_work)(CPUState *cpu);
>      void (*do_interrupt)(CPUState *cpu);
> +#ifndef CONFIG_USER_ONLY
>      void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
>                                  MMUAccessType access_type,
>                                  int mmu_idx, uintptr_t retaddr);
> @@ -174,6 +175,12 @@ typedef struct CPUClass {
>                                    unsigned size, MMUAccessType
> access_type,
>                                    int mmu_idx, MemTxAttrs attrs,
>                                    MemTxResult response, uintptr_t
> retaddr);
> +    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
> +    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
> +                                        MemTxAttrs *attrs);
> +#else
> +    void (*reserved[4])(CPUState *cpu, ...);
> +#endif /* CONFIG_USER_ONLY */
>      bool (*virtio_is_big_endian)(CPUState *cpu);
>      int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>                             uint8_t *buf, int len, bool is_write);
> @@ -189,9 +196,6 @@ typedef struct CPUClass {
>      bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
>                       MMUAccessType access_type, int mmu_idx,
>                       bool probe, uintptr_t retaddr);
> -    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
> -    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
> -                                        MemTxAttrs *attrs);
>      int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
>      int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
>      int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
> ---
>
> Ugly?
>

More. :-) And hwaddr is only a small part, there are several other methods
that only make sense for system emulation. Let me review the rest of the
series, it may not be good enough to stop here while we figure out a way.

Paolo


> >
> > >       void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
> > >                                   MMUAccessType access_type,
> > >                                   int mmu_idx, uintptr_t retaddr);
> > > @@ -174,6 +175,10 @@ typedef struct CPUClass {
> > >                                     unsigned size, MMUAccessType
> access_type,
> > >                                     int mmu_idx, MemTxAttrs attrs,
> > >                                     MemTxResult response, uintptr_t
> retaddr);
> > > +    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
> > > +    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
> > > +                                        MemTxAttrs *attrs);
> > > +#endif /* CONFIG_USER_ONLY */
> > >       bool (*virtio_is_big_endian)(CPUState *cpu);
> > >       int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
> > >                              uint8_t *buf, int len, bool is_write);
> > > @@ -189,9 +194,6 @@ typedef struct CPUClass {
> > >       bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
> > >                        MMUAccessType access_type, int mmu_idx,
> > >                        bool probe, uintptr_t retaddr);
> > > -    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
> > > -    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
> > > -                                        MemTxAttrs *attrs);
> > >       int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
> > >       int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int
> reg);
> > >       int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg)=
;
> > [...]
>
>

--0000000000008bad0f05a53d7211
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 9 mag 2020, 22:01 Philippe Mathieu-Daud=C3=A9 &=
lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank" rel=3D"noreferrer">=
f4bug@amsat.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>&gt; I forgot once Peter Maydell told me we can&#39;t do that for some rea=
son I<br>
&gt; don&#39;t remember.<br>
&gt;<br>
&gt; At least this changes the sizeof(CPUClass), so we get:<br>
&gt;<br>
&gt; qom/object.c:315:type_initialize: assertion failed: (parent-&gt;class_=
size<br>
&gt; &lt;=3D ti-&gt;class_size)<br>
&gt;<br>
&gt; So we can&#39;t poison the hwaddr type? (final patch of this series).<=
br>
<br>
Well, this works...:<br>
<br>
-- &gt;8 --<br>
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h<br>
--- a/include/hw/core/cpu.h<br>
+++ b/include/hw/core/cpu.h<br>
@@ -167,6 +167,7 @@ typedef struct CPUClass {<br>
=C2=A0 =C2=A0 =C2=A0int reset_dump_flags;<br>
=C2=A0 =C2=A0 =C2=A0bool (*has_work)(CPUState *cpu);<br>
=C2=A0 =C2=A0 =C2=A0void (*do_interrupt)(CPUState *cpu);<br>
+#ifndef CONFIG_USER_ONLY<br>
=C2=A0 =C2=A0 =C2=A0void (*do_unaligned_access)(CPUState *cpu, vaddr addr,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMUAccessType access_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mmu_idx, uintptr_t retaddr=
);<br>
@@ -174,6 +175,12 @@ typedef struct CPUClass {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned size, MMUAcces=
sType access_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mmu_idx, MemTxAttrs=
 attrs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxResult response, u=
intptr_t retaddr);<br>
+=C2=A0 =C2=A0 hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);<br=
>
+=C2=A0 =C2=A0 hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr add=
r,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemTxAtt=
rs *attrs);<br>
+#else<br>
+=C2=A0 =C2=A0 void (*reserved[4])(CPUState *cpu, ...);<br>
+#endif /* CONFIG_USER_ONLY */<br>
=C2=A0 =C2=A0 =C2=A0bool (*virtio_is_big_endian)(CPUState *cpu);<br>
=C2=A0 =C2=A0 =C2=A0int (*memory_rw_debug)(CPUState *cpu, vaddr addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *buf, int len, bool is_write);<br>
@@ -189,9 +196,6 @@ typedef struct CPUClass {<br>
=C2=A0 =C2=A0 =C2=A0bool (*tlb_fill)(CPUState *cpu, vaddr address, int size=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MMUAccessType access_type, int mmu_idx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 bool probe, uintptr_t retaddr);<br>
-=C2=A0 =C2=A0 hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);<br=
>
-=C2=A0 =C2=A0 hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr add=
r,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemTxAtt=
rs *attrs);<br>
=C2=A0 =C2=A0 =C2=A0int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs=
);<br>
=C2=A0 =C2=A0 =C2=A0int (*gdb_read_register)(CPUState *cpu, GByteArray *buf=
, int reg);<br>
=C2=A0 =C2=A0 =C2=A0int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, =
int reg);<br>
---<br>
<br>
Ugly?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">More. :-) And hwaddr is only a small part, there are several other met=
hods that only make sense for system emulation. Let me review the rest of t=
he series, it may not be good enough to stop here while we figure out a way=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*do_unaligned_access)(CPUState *c=
pu, vaddr addr,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMUAccessType ac=
cess_type,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mmu_idx, uin=
tptr_t retaddr);<br>
&gt; &gt; @@ -174,6 +175,10 @@ typedef struct CPUClass {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
size, MMUAccessType access_type,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mmu_i=
dx, MemTxAttrs attrs,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxResu=
lt response, uintptr_t retaddr);<br>
&gt; &gt; +=C2=A0 =C2=A0 hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr=
 addr);<br>
&gt; &gt; +=C2=A0 =C2=A0 hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu,=
 vaddr addr,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MemTxAttrs *attrs);<br>
&gt; &gt; +#endif /* CONFIG_USER_ONLY */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool (*virtio_is_big_endian)(CPUState *=
cpu);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*memory_rw_debug)(CPUState *cpu, v=
addr addr,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *buf, int len, bool is_write=
);<br>
&gt; &gt; @@ -189,9 +194,6 @@ typedef struct CPUClass {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool (*tlb_fill)(CPUState *cpu, vaddr a=
ddress, int size,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 MMUAccessType access_type, int mmu_idx,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool probe, uintptr_t retaddr);<br>
&gt; &gt; -=C2=A0 =C2=A0 hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr=
 addr);<br>
&gt; &gt; -=C2=A0 =C2=A0 hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu,=
 vaddr addr,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MemTxAttrs *attrs);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*asidx_from_attrs)(CPUState *cpu, =
MemTxAttrs attrs);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*gdb_read_register)(CPUState *cpu,=
 GByteArray *buf, int reg);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*gdb_write_register)(CPUState *cpu=
, uint8_t *buf, int reg);<br>
&gt; [...]<br>
<br>
</blockquote></div></div></div>

--0000000000008bad0f05a53d7211--


