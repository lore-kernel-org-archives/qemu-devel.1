Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C61C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 17:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A117F2063A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 17:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="XPt5zsRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A117F2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX751-0005yb-Mr
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 13:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jX748-0004xC-IY
 for qemu-devel@nongnu.org; Fri, 08 May 2020 13:45:40 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jX746-0004k1-R2
 for qemu-devel@nongnu.org; Fri, 08 May 2020 13:45:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id e26so11030016wmk.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YRgiHARMevehzIkgStpvXQEJMCrTdVn04I4zJJXdiBA=;
 b=XPt5zsRi1/nSVetAWab2X0MiDHhN+pDeqiyKvbvwyqoFfLTiG0L8o2F0W0IiGeQ3DC
 xDfKevYJ79XlKsPjcWTJ+HZ2x/VOaTRVpJBhL9u/SBzUz4PbwM/zh0DUWVPL+x9piHCE
 mI0sAL6OlhseBaGgwkaixhDrz6LZVlB3OKzGMwFyKoo2EDns3TkIXBYeP8ccvm4GZcmH
 BHuRy442sLpqRkA6Zx9o85S5PNz+nutyDjGtlyg9TBzNKcyenWsPtFz3uFusJ6ieYhQZ
 jFm7pWsZ0ydm3O6DfwRKNvRKaxZ2iS4uxih51zoOWreP0My+R+8oFXjDGu/o3I8k3PBl
 7fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YRgiHARMevehzIkgStpvXQEJMCrTdVn04I4zJJXdiBA=;
 b=YX9cM6aL3cNDP3TFwj3fJFnjUYrrXYgaqgaghhe1G0yZfD+cIdTuM1jgM0889jkQlb
 1bT1WFpvW+qv2ZIcCxEC1Zl66UhPSeQvkITnlhrjw+mXRvw8HEhLa5+Bj2Vmy8UQttXO
 RN2Wji84KqoaHcWPAX4xc6T+SGuhyh+5zaeiSz+0d96buis/n0iwsvzlanCZYJy20H2y
 gr0g6r5hpM4RsMLhb9vFKYT/fNZTW+qYQUiAu14px5xViru7VPDtPBeON9ySkhVZ5kjI
 ONPHrMpp6b5y+oCf2q9ekOyXv8JsB5aexYWDcx8S+3kDzZLY8HSB+OdiydAmiYfGs8Bn
 6vtw==
X-Gm-Message-State: AGi0PuZo5K95QoT1Jmz+5vidpZL8jxjTwncvrizopCKM/fw5fLhvKpw9
 fB9nCsM2pRr/7ukUF2A2tEDLEmZeO/I3M+az7eNr0Q==
X-Google-Smtp-Source: APiQypJM/iud1wo8AWPbm3eXxm/NdtP9Q2AnX5vyItDLO70Sbl3EfdFSv5aZ3b6bQHHst8XVIWhtJFbnEEpBL6ToBJw=
X-Received: by 2002:a7b:cf23:: with SMTP id m3mr16675315wmg.36.1588959936713; 
 Fri, 08 May 2020 10:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200506212645.894533-1-andrew@daynix.com>
 <b67e29f9-a904-242f-9df2-801410f07aba@redhat.com>
In-Reply-To: <b67e29f9-a904-242f-9df2-801410f07aba@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Fri, 8 May 2020 21:13:21 +0300
Message-ID: <CABcq3pEicPdvMDAC7v_ns_YasCBvc8o-3-6vOb=+mTfXzvTJeQ@mail.gmail.com>
Subject: Re: [PATCH v2] e1000e: Added ICR clearing by corresponding IMS bit.
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000972b3205a52690a4"
Received-SPF: none client-ip=2a00:1450:4864:20::344;
 envelope-from=andrew@daynix.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: dmitry.fleytman@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000972b3205a52690a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yo, I've used OpenSDM_8257x-18.pdf specification.
This document was recommended by Intel guys(Also, they referenced to that
note).
I've made a fast fix and it works. Before that I had a fix for Linux e1000e
driver.
Overall, the issue was in pending interrupts that can't be cleared by
reading ICR in Linux(Windows driver clears by writing to ICR).

You can download spec for example from:
http://iweb.dl.sourceforge.net/project/e1000/8257x%20Developer%20Manual/Rev=
ision%201.8/OpenSDM_8257x-18.pdf

On Fri, May 8, 2020 at 5:21 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/5/7 =E4=B8=8A=E5=8D=885:26, andrew@daynix.com wrote:
> > From: Andrew Melnychenko <andrew@daynix.com>
> >
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1707441
> > Added ICR clearing if there is IMS bit - according to the note by
> > section 13.3.27 of the 8257X developers manual.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >   hw/net/e1000e_core.c | 9 +++++++++
> >   hw/net/trace-events  | 1 +
> >   2 files changed, 10 insertions(+)
> >
> > diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> > index d5676871fa..302e99ff46 100644
> > --- a/hw/net/e1000e_core.c
> > +++ b/hw/net/e1000e_core.c
> > @@ -2624,6 +2624,15 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
> >           e1000e_clear_ims_bits(core, core->mac[IAM]);
> >       }
> >
> > +    /*
> > +     * PCIe* GbE Controllers Open Source Software Developer's Manual
> > +     * 13.3.27 Interrupt Cause Read Register
> > +     */
>
>
> Hi Andrew:
>
> Which version of the manual did you use? I try to use the one mentioned
> in e1000e.c which is
>
> http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-data=
sheet.pdf
> .
>
> But I couldn't find chapter 13.3.27.
>
> Thanks
>
>
> > +    if (core->mac[ICR] & core->mac[IMS]) {
> > +        trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR],
> core->mac[IMS]);
> > +        core->mac[ICR] =3D 0;
> > +    }
> > +
> >       trace_e1000e_irq_icr_read_exit(core->mac[ICR]);
> >       e1000e_update_interrupt_state(core);
> >       return ret;
> > diff --git a/hw/net/trace-events b/hw/net/trace-events
> > index e18f883cfd..46e40fcfa9 100644
> > --- a/hw/net/trace-events
> > +++ b/hw/net/trace-events
> > @@ -237,6 +237,7 @@ e1000e_irq_icr_read_entry(uint32_t icr) "Starting
> ICR read. Current ICR: 0x%x"
> >   e1000e_irq_icr_read_exit(uint32_t icr) "Ending ICR read. Current ICR:
> 0x%x"
> >   e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero
> IMS"
> >   e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
> > +e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) "Clearing
> ICR on read due corresponding IMS bit: 0x%x & 0x%x"
> >   e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IM=
S
> due to EIAME, IAM: 0x%X, cause: 0x%X"
> >   e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR
> bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
> >   e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to
> IMC write 0x%x"
>
>

--000000000000972b3205a52690a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Yo, I&#39;ve used OpenSDM_8257x-18.pdf specification.=
</div><div> This document was recommended by Intel guys(Also, they referenc=
ed to that note).</div><div>I&#39;ve made a fast fix and it works. Before t=
hat I had a fix for Linux e1000e driver.</div><div>Overall, the issue was i=
n pending interrupts that can&#39;t be cleared by reading ICR in Linux(Wind=
ows driver clears by writing to ICR).</div><div></div><div><br></div><div>Y=
ou can download spec for example from:</div><div><a href=3D"http://iweb.dl.=
sourceforge.net/project/e1000/8257x%20Developer%20Manual/Revision%201.8/Ope=
nSDM_8257x-18.pdf">http://iweb.dl.sourceforge.net/project/e1000/8257x%20Dev=
eloper%20Manual/Revision%201.8/OpenSDM_8257x-18.pdf</a> </div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 8=
, 2020 at 5:21 AM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jas=
owang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><br>
On 2020/5/7 =E4=B8=8A=E5=8D=885:26, <a href=3D"mailto:andrew@daynix.com" ta=
rget=3D"_blank">andrew@daynix.com</a> wrote:<br>
&gt; From: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.com" targ=
et=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt;<br>
&gt; Buglink: <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1707=
441" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_=
bug.cgi?id=3D1707441</a><br>
&gt; Added ICR clearing if there is IMS bit - according to the note by<br>
&gt; section 13.3.27 of the 8257X developers manual.<br>
&gt;<br>
&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.=
com" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/e1000e_core.c | 9 +++++++++<br>
&gt;=C2=A0 =C2=A0hw/net/trace-events=C2=A0 | 1 +<br>
&gt;=C2=A0 =C2=A02 files changed, 10 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c<br>
&gt; index d5676871fa..302e99ff46 100644<br>
&gt; --- a/hw/net/e1000e_core.c<br>
&gt; +++ b/hw/net/e1000e_core.c<br>
&gt; @@ -2624,6 +2624,15 @@ e1000e_mac_icr_read(E1000ECore *core, int index=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e1000e_clear_ims_bits(core, co=
re-&gt;mac[IAM]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* PCIe* GbE Controllers Open Source Software Deve=
loper&#39;s Manual<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* 13.3.27 Interrupt Cause Read Register<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
<br>
<br>
Hi Andrew:<br>
<br>
Which version of the manual did you use? I try to use the one mentioned <br=
>
in e1000e.c which is <br>
<a href=3D"http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-contro=
ller-datasheet.pdf" rel=3D"noreferrer" target=3D"_blank">http://www.intel.c=
om/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf</a>.<br>
<br>
But I couldn&#39;t find chapter 13.3.27.<br>
<br>
Thanks<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 if (core-&gt;mac[ICR] &amp; core-&gt;mac[IMS]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000e_irq_icr_clear_icr_bit_ims(co=
re-&gt;mac[ICR], core-&gt;mac[IMS]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 core-&gt;mac[ICR] =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_e1000e_irq_icr_read_exit(core-&gt;mac[=
ICR]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0e1000e_update_interrupt_state(core);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; diff --git a/hw/net/trace-events b/hw/net/trace-events<br>
&gt; index e18f883cfd..46e40fcfa9 100644<br>
&gt; --- a/hw/net/trace-events<br>
&gt; +++ b/hw/net/trace-events<br>
&gt; @@ -237,6 +237,7 @@ e1000e_irq_icr_read_entry(uint32_t icr) &quot;Star=
ting ICR read. Current ICR: 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0e1000e_irq_icr_read_exit(uint32_t icr) &quot;Ending ICR re=
ad. Current ICR: 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0e1000e_irq_icr_clear_zero_ims(void) &quot;Clearing ICR on =
read due to zero IMS&quot;<br>
&gt;=C2=A0 =C2=A0e1000e_irq_icr_clear_iame(void) &quot;Clearing ICR on read=
 due to IAME&quot;<br>
&gt; +e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) &quot;Cl=
earing ICR on read due corresponding IMS bit: 0x%x &amp; 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) &=
quot;Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X&quot;<br>
&gt;=C2=A0 =C2=A0e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) &qu=
ot;Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X&quot;<br>
&gt;=C2=A0 =C2=A0e1000e_irq_ims_clear_set_imc(uint32_t val) &quot;Clearing =
IMS bits due to IMC write 0x%x&quot;<br>
<br>
</blockquote></div>

--000000000000972b3205a52690a4--

