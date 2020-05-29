Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAFAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112F4208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112F4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZJ5-0007tQ-8d
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeZHM-000621-IW
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:18:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeZHL-0007EO-H2
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:18:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id s19so915123edt.12
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 00:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r8s4lmYjvCILx3uYTbc/WcY4v3IZHWDE9bGWJ1KzuMs=;
 b=oMXRyiL0tS2DM7sFMyoPKPwIQrz/oxHuX67VsYJB30TAJsoDPzeiB1UZ+M3nP3ps05
 KEz+G7ZQELLC7FFkzeQJlj9g1+LRR9OQwrxX9sF8DbIdd86lYgLrg1jPlKoykQYLqn88
 4e3hxAW+cuO31jrhNzqZ7kx/BBGK10yXyNGgJ8VO2TdDAFnbb7QG8aYoyJMXYqqoVTRl
 0YgPEdBB3xm7qeMHZzMg2RZBE8Gn9TcKvfasORF7xdnqtluA2fQ30FT02gCBYGoni9Z2
 mQRBX67PBnUXWQdiCrTPcuvD+asjpRoDqKKVfboA7SNOEgYeYE2sU4KioNEfdNO0fEGY
 2Scw==
X-Gm-Message-State: AOAM531mdoM/u8JfWJIW9NoQ8vBS8sIIfqfoJZ8LALRUOIJ12qdiixBD
 ad+fs5cnJxpOtCw94db/HuHW3Nrs27OBaKMaQn0=
X-Google-Smtp-Source: ABdhPJzLMwqk5HjJsFbgNRW+JSA+YfnZq4K+RC8vqYRYq74MqapPC42q5/EWprISQBY/V5fpu4qTbTPu7UmXdlq5HjA=
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr6693617edc.55.1590736685900; 
 Fri, 29 May 2020 00:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200525122330.3691-1-f4bug@amsat.org>
 <2623aab1-355a-a5dc-3fc1-e22f795b98a0@redhat.com>
In-Reply-To: <2623aab1-355a-a5dc-3fc1-e22f795b98a0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 May 2020 09:17:54 +0200
Message-ID: <CAAdtpL5=-e_MwpK0n3X0TeT_XrYOLHfA8gqTrx0WS7yBRqO6MQ@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/net/e1000e: Do not abort() on invalid PSRCTL
 register value
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001828f805a6c43f07"
Received-SPF: pass client-ip=209.85.208.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:18:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001828f805a6c43f07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 29 mai 2020 08:36, Jason Wang <jasowang@redhat.com> a =C3=A9crit :

>
> On 2020/5/25 =E4=B8=8B=E5=8D=888:23, Philippe Mathieu-Daud=C3=A9 wrote:
> > libFuzzer found using 'qemu-system-i386 -M q35':
> >
> > qemu: hardware error: e1000e: PSRCTL.BSIZE0 cannot be zero
> > CPU #0:
> > EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D00000663
> > ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
> > EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 =
HLT=3D0
> > ES =3D0000 00000000 0000ffff 00009300
> > CS =3Df000 ffff0000 0000ffff 00009b00
> > SS =3D0000 00000000 0000ffff 00009300
> > DS =3D0000 00000000 0000ffff 00009300
> > FS =3D0000 00000000 0000ffff 00009300
> > GS =3D0000 00000000 0000ffff 00009300
> > LDT=3D0000 00000000 0000ffff 00008200
> > TR =3D0000 00000000 0000ffff 00008b00
> > GDT=3D     00000000 0000ffff
> > IDT=3D     00000000 0000ffff
> > CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
> > DR0=3D00000000 DR1=3D00000000 DR2=3D00000000 DR3=3D00000000
> > DR6=3Dffff0ff0 DR7=3D00000400
> > EFER=3D0000000000000000
> > FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
> > FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
> > FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
> > FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
> > FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
> > XMM00=3D00000000000000000000000000000000
> XMM01=3D00000000000000000000000000000000
> > XMM02=3D00000000000000000000000000000000
> XMM03=3D00000000000000000000000000000000
> > XMM04=3D00000000000000000000000000000000
> XMM05=3D00000000000000000000000000000000
> > XMM06=3D00000000000000000000000000000000
> XMM07=3D00000000000000000000000000000000
> > =3D=3D1988=3D=3D ERROR: libFuzzer: deadly signal
> >      #6 0x7fae4d3ea894 in __GI_abort (/lib64/libc.so.6+0x22894)
> >      #7 0x563f4cc59a1d in hw_error (qemu-fuzz-i386+0xe8ca1d)
> >      #8 0x563f4d7c93f2 in e1000e_set_psrctl (qemu-fuzz-i386+0x19fc3f2)
> >      #9 0x563f4d7b798f in e1000e_core_write (qemu-fuzz-i386+0x19ea98f)
> >      #10 0x563f4d7afc46 in e1000e_mmio_write (qemu-fuzz-i386+0x19e2c46)
> >      #11 0x563f4cc9a0a7 in memory_region_write_accessor
> (qemu-fuzz-i386+0xecd0a7)
> >      #12 0x563f4cc99c13 in access_with_adjusted_size
> (qemu-fuzz-i386+0xeccc13)
> >      #13 0x563f4cc987b4 in memory_region_dispatch_write
> (qemu-fuzz-i386+0xecb7b4)
> >
> > It simply sent the following 2 I/O command to the e1000e
> > PCI BAR #2 I/O region:
> >
> >    writew 0x0100 0x0c00 # RCTL =3D   E1000_RCTL_DTYP_MASK
> >    writeb 0x2170 0x00   # PSRCTL =3D 0
> >
> > 2813 static void
> > 2814 e1000e_set_psrctl(E1000ECore *core, int index, uint32_t val)
> > 2815 {
> > 2816     if (core->mac[RCTL] & E1000_RCTL_DTYP_MASK) {
> > 2817
> > 2818         if ((val & E1000_PSRCTL_BSIZE0_MASK) =3D=3D 0) {
> > 2819             hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
> > 2820         }
> >
> > Instead of calling hw_error() which abort the process (it is
> > meant for CPU fatal error condition, not for device logging),
> > log the invalid request with qemu_log_mask(LOG_GUEST_ERROR)
> > and return ignoring the request.
>

Maybe more understandable adding a comma after "return":

"... and return, ignoring the request."

>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> > RFC because there might be something clever than returning...
> > Probably worth a Cc:qemu-stable@ tag
>
>
> I can't think of a better solution here. And the code looks safe if we
> accept zero value.
>
> So I applied this patch.
>

Thanks. Can you append the "Cc:qemu-stable@..." tag please?


> Thanks
>
>
> > ---
> >   hw/net/e1000e_core.c | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> > index d5676871fa..bcd186cac5 100644
> > --- a/hw/net/e1000e_core.c
> > +++ b/hw/net/e1000e_core.c
> > @@ -34,9 +34,9 @@
> >   */
> >
> >   #include "qemu/osdep.h"
> > +#include "qemu/log.h"
> >   #include "net/net.h"
> >   #include "net/tap.h"
> > -#include "hw/hw.h"
> >   #include "hw/pci/msi.h"
> >   #include "hw/pci/msix.h"
> >   #include "sysemu/runstate.h"
> > @@ -2816,11 +2816,15 @@ e1000e_set_psrctl(E1000ECore *core, int index,
> uint32_t val)
> >       if (core->mac[RCTL] & E1000_RCTL_DTYP_MASK) {
> >
> >           if ((val & E1000_PSRCTL_BSIZE0_MASK) =3D=3D 0) {
> > -            hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "e1000e: PSRCTL.BSIZE0 cannot be zero");
> > +            return;
> >           }
> >
> >           if ((val & E1000_PSRCTL_BSIZE1_MASK) =3D=3D 0) {
> > -            hw_error("e1000e: PSRCTL.BSIZE1 cannot be zero");
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "e1000e: PSRCTL.BSIZE1 cannot be zero");
> > +            return;
> >           }
> >       }
> >
>
>

--0000000000001828f805a6c43f07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le ven. 29 mai 2020 08:36, Jason Wang &lt;<a href=3D"mailto:ja=
sowang@redhat.com">jasowang@redhat.com</a>&gt; a =C3=A9crit=C2=A0:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><br>
On 2020/5/25 =E4=B8=8B=E5=8D=888:23, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; libFuzzer found using &#39;qemu-system-i386 -M q35&#39;:<br>
&gt;<br>
&gt; qemu: hardware error: e1000e: PSRCTL.BSIZE0 cannot be zero<br>
&gt; CPU #0:<br>
&gt; EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D00000663<br>
&gt; ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000<br>
&gt; EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0=
 HLT=3D0<br>
&gt; ES =3D0000 00000000 0000ffff 00009300<br>
&gt; CS =3Df000 ffff0000 0000ffff 00009b00<br>
&gt; SS =3D0000 00000000 0000ffff 00009300<br>
&gt; DS =3D0000 00000000 0000ffff 00009300<br>
&gt; FS =3D0000 00000000 0000ffff 00009300<br>
&gt; GS =3D0000 00000000 0000ffff 00009300<br>
&gt; LDT=3D0000 00000000 0000ffff 00008200<br>
&gt; TR =3D0000 00000000 0000ffff 00008b00<br>
&gt; GDT=3D=C2=A0 =C2=A0 =C2=A000000000 0000ffff<br>
&gt; IDT=3D=C2=A0 =C2=A0 =C2=A000000000 0000ffff<br>
&gt; CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000<br>
&gt; DR0=3D00000000 DR1=3D00000000 DR2=3D00000000 DR3=3D00000000<br>
&gt; DR6=3Dffff0ff0 DR7=3D00000400<br>
&gt; EFER=3D0000000000000000<br>
&gt; FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80<br>
&gt; FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000<br>
&gt; FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000<br>
&gt; FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000<br>
&gt; FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000<br>
&gt; XMM00=3D00000000000000000000000000000000 XMM01=3D000000000000000000000=
00000000000<br>
&gt; XMM02=3D00000000000000000000000000000000 XMM03=3D000000000000000000000=
00000000000<br>
&gt; XMM04=3D00000000000000000000000000000000 XMM05=3D000000000000000000000=
00000000000<br>
&gt; XMM06=3D00000000000000000000000000000000 XMM07=3D000000000000000000000=
00000000000<br>
&gt; =3D=3D1988=3D=3D ERROR: libFuzzer: deadly signal<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #6 0x7fae4d3ea894 in __GI_abort (/lib64/libc.so.6+=
0x22894)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #7 0x563f4cc59a1d in hw_error (qemu-fuzz-i386+0xe8=
ca1d)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #8 0x563f4d7c93f2 in e1000e_set_psrctl (qemu-fuzz-=
i386+0x19fc3f2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #9 0x563f4d7b798f in e1000e_core_write (qemu-fuzz-=
i386+0x19ea98f)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #10 0x563f4d7afc46 in e1000e_mmio_write (qemu-fuzz=
-i386+0x19e2c46)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #11 0x563f4cc9a0a7 in memory_region_write_accessor=
 (qemu-fuzz-i386+0xecd0a7)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #12 0x563f4cc99c13 in access_with_adjusted_size (q=
emu-fuzz-i386+0xeccc13)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #13 0x563f4cc987b4 in memory_region_dispatch_write=
 (qemu-fuzz-i386+0xecb7b4)<br>
&gt;<br>
&gt; It simply sent the following 2 I/O command to the e1000e<br>
&gt; PCI BAR #2 I/O region:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 writew 0x0100 0x0c00 # RCTL =3D=C2=A0 =C2=A0E1000_RCTL_DT=
YP_MASK<br>
&gt;=C2=A0 =C2=A0 writeb 0x2170 0x00=C2=A0 =C2=A0# PSRCTL =3D 0<br>
&gt;<br>
&gt; 2813 static void<br>
&gt; 2814 e1000e_set_psrctl(E1000ECore *core, int index, uint32_t val)<br>
&gt; 2815 {<br>
&gt; 2816=C2=A0 =C2=A0 =C2=A0if (core-&gt;mac[RCTL] &amp; E1000_RCTL_DTYP_M=
ASK) {<br>
&gt; 2817<br>
&gt; 2818=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((val &amp; E1000_PSRCTL_BSIZ=
E0_MASK) =3D=3D 0) {<br>
&gt; 2819=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw_error(&quot;e10=
00e: PSRCTL.BSIZE0 cannot be zero&quot;);<br>
&gt; 2820=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; Instead of calling hw_error() which abort the process (it is<br>
&gt; meant for CPU fatal error condition, not for device logging),<br>
&gt; log the invalid request with qemu_log_mask(LOG_GUEST_ERROR)<br>
&gt; and return ignoring the request.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Maybe more understandable adding a co=
mma after &quot;return&quot;:</div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><span style=3D"font-family:sans-serif">&quot;... and return, ignoring=
 the request.&quot;</span><br></div><div dir=3D"auto"><span style=3D"font-f=
amily:sans-serif"><br></span></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org" target=3D"_blank" rel=3D"noreferrer">f4bug@amsat.org</a>&gt;<br=
>
&gt; ---<br>
&gt; RFC because there might be something clever than returning...<br>
&gt; Probably worth a Cc:qemu-stable@ tag<br>
<br>
<br>
I can&#39;t think of a better solution here. And the code looks safe if we =
<br>
accept zero value.<br>
<br>
So I applied this patch.<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Thanks. Can you append the &quot;<span style=3D"fon=
t-family:sans-serif;font-size:13.696px">Cc:qemu-stable@...&quot; tag please=
?=C2=A0</span></div><div dir=3D"auto"><span style=3D"font-family:sans-serif=
;font-size:13.696px"><br></span></div><div dir=3D"auto"><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/e1000e_core.c | 10 +++++++---<br>
&gt;=C2=A0 =C2=A01 file changed, 7 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c<br>
&gt; index d5676871fa..bcd186cac5 100644<br>
&gt; --- a/hw/net/e1000e_core.c<br>
&gt; +++ b/hw/net/e1000e_core.c<br>
&gt; @@ -34,9 +34,9 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;net/net.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;net/tap.h&quot;<br>
&gt; -#include &quot;hw/hw.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/pci/msi.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/pci/msix.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;sysemu/runstate.h&quot;<br>
&gt; @@ -2816,11 +2816,15 @@ e1000e_set_psrctl(E1000ECore *core, int index,=
 uint32_t val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (core-&gt;mac[RCTL] &amp; E1000_RCTL_DTYP=
_MASK) {<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((val &amp; E1000_PSRCTL_BS=
IZE0_MASK) =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hw_error(&quot;e1000e: PSRC=
TL.BSIZE0 cannot be zero&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERR=
OR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;e1000e: PSRCTL.BSIZE0 cannot be zero&quot;);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((val &amp; E1000_PSRCTL_BS=
IZE1_MASK) =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hw_error(&quot;e1000e: PSRC=
TL.BSIZE1 cannot be zero&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERR=
OR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;e1000e: PSRCTL.BSIZE1 cannot be zero&quot;);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div></div></div>

--0000000000001828f805a6c43f07--

