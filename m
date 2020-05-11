Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374E7C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E264D2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="OaqmXuCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E264D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4vy-0001VC-Ur
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jY4vA-0000qp-Nv
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:40:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jY4v8-0000xW-1T
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:40:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id s8so10045355wrt.9
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=juyLA1iVZG/s3fTnWmtpKz2qjfSkaCG6PE8JrcGf5ug=;
 b=OaqmXuCIgUIvxjMbfs1t01f8jkHizBMF32ljqxDJB+XB4OkylmxUcKjZk3TvFlvbDc
 P6Y3fPPI4P8m1TjuSbsQeBgLottNvy78KJOsrMTDzPCnDMK7ICTa2ibczookhaDBSwLd
 VJRYfo4hfEa70wQrvsoFr30YKxxIYfZuTRWL4DW/uVyeACp6Yeh7vX8wtnHvZtDDVYTo
 hiQiXhiQokxSoUXA8WUoeBRyQ38paNnTC+DYYknHyYXx9BBJD/+oYh0AF3nL9/xJ1yU6
 kErZ/4cdyvQfsG10sex+7kQAILCRZNqVa+GUQYw5aoE6mIl5VT+PO16CwgYyVK9isZqL
 P2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=juyLA1iVZG/s3fTnWmtpKz2qjfSkaCG6PE8JrcGf5ug=;
 b=BkQwTwSzYIcbmySK2AGYqT9iK24G4ZlNpu7yB8aCwPVeIFw8SzZSRluddIjLf2O5JN
 AC4QtfSUMcuVidwDKeWnZ+g2ftH4lFKOHD+8Kv+W8zu/yySq1obi1CAOt61dr1/D24D2
 oEFl+hnCOw1gC2u/Ugl5Nf38BT2aj7fCZkecwWV0N41/CppID5Jw75gkegD01pZ8LaOE
 P+Uu/oWqFqPq/dnUCXnBwp42f96phMIJYrvjmC9fwRQlYIzqkVlMfZdehHRVM+2TsUdv
 /YPlGalXr2YbnZpn2k8Q+A9qfwXw+ono6pGJrAfcyDqkcr4jka2E84B8WFw3UwgXljZl
 xwgg==
X-Gm-Message-State: AGi0PuY81vKv/5op514H/6MrrFGzNA8r/I8GWE4Q3gc7j4bz0ddmPTCa
 9T2u6qGZF171C2Uy9YTwY128qyO8GtwapOdfevFthA==
X-Google-Smtp-Source: APiQypL/HmtlqJjUj42vasAq8YLqizTLKujyeEg1jL7lyntWGzH6IKZoJxqAZYGi3kKjnFFzf5m3Tq57LnKKXnt4870=
X-Received: by 2002:a05:6000:110b:: with SMTP id
 z11mr15225784wrw.16.1589190019464; 
 Mon, 11 May 2020 02:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200506212645.894533-1-andrew@daynix.com>
 <b67e29f9-a904-242f-9df2-801410f07aba@redhat.com>
 <CABcq3pEicPdvMDAC7v_ns_YasCBvc8o-3-6vOb=+mTfXzvTJeQ@mail.gmail.com>
 <53be0d4e-214d-dc9c-58a4-0bbd9c46b78f@redhat.com>
In-Reply-To: <53be0d4e-214d-dc9c-58a4-0bbd9c46b78f@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 11 May 2020 13:08:07 +0300
Message-ID: <CABcq3pGvAdXazPs-91F=seUQxv3VUNVwbFOrQ42CBSLSwMw_Kg@mail.gmail.com>
Subject: Re: [PATCH v2] e1000e: Added ICR clearing by corresponding IMS bit.
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000974d4005a55c22d2"
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=andrew@daynix.com; helo=mail-wr1-x444.google.com
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

--000000000000974d4005a55c22d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yo,

> So I think we should implement the 82574l behavior?

 Well, as I understand it - its already implemented. I've added ICR
clearance if ICR & IMS(also need to add ICR_ASSERTED check, my bad, I'll
prepare new patch).

At first, I had hacks to clear 'msi_causes_pending' at
'e1000e_core_set_link_status()' before link down. It works but it's not a
solution.
Also, on Windows the bug doesn't reproduce. I've traced Windows and Linux -
the difference that Windows driver clears pending by writing to ICR, where
Linux tries to clear by reading it.
I had another possible fix - for Linux driver(writing to ICR at interrupt
routine).
I've asked intel guys, does Linux driver works with a device(I don't have
real one). Thay said that it works and suggested to check 8257x spec. I'll
forward the message to you.

On Sat, May 9, 2020 at 9:02 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/5/9 =E4=B8=8A=E5=8D=882:13, Andrew Melnichenko wrote:
> > Yo, I've used OpenSDM_8257x-18.pdf specification.
> > This document was recommended by Intel guys(Also, they referenced to
> > that note).
> > I've made a fast fix and it works. Before that I had a fix for Linux
> > e1000e driver.
> > Overall, the issue was in pending interrupts that can't be cleared by
> > reading ICR in Linux(Windows driver clears by writing to ICR).
> >
> > You can download spec for example from:
> >
> http://iweb.dl.sourceforge.net/project/e1000/8257x%20Developer%20Manual/R=
evision%201.8/OpenSDM_8257x-18.pdf
>
>
> Interesting, this spec doesn't include 82574l which is what e1000e
> claims to emulate:
>
>      c->vendor_id =3D PCI_VENDOR_ID_INTEL;
>      c->device_id =3D E1000_DEV_ID_82574L;
>
> Looking at 82574l spec (using the link mentioned in e1000e_core.c), it
> said (7.4.3):
>
> In MSI-X mode the bits in this register can be configured to auto-clear
> when the MSI-X
> interrupt message is sent, in order to minimize driver overhead, and
> when using MSI-X
> interrupt signaling.
> In systems that do not support MSI-X, reading the ICR register clears
> it's bits or writing
> 1b's clears the corresponding bits in this register.
>
> So the auto clear is under the control of EIAC (MSIX) or unconditionally
> (non MSI-X).
>
> But what has been implemented in e1000e_mac_icr_read() is something
> similar to the behavior of non 82574l card.
>
> So I think we should implement the 82574l behavior?
>
> Thanks
>
>
> >
> > On Fri, May 8, 2020 at 5:21 AM Jason Wang <jasowang@redhat.com
> > <mailto:jasowang@redhat.com>> wrote:
> >
> >
> >     On 2020/5/7 =E4=B8=8A=E5=8D=885:26, andrew@daynix.com <mailto:andre=
w@daynix.com>
> >     wrote:
> >     > From: Andrew Melnychenko <andrew@daynix.com
> >     <mailto:andrew@daynix.com>>
> >     >
> >     > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1707441
> >     > Added ICR clearing if there is IMS bit - according to the note by
> >     > section 13.3.27 of the 8257X developers manual.
> >     >
> >     > Signed-off-by: Andrew Melnychenko <andrew@daynix.com
> >     <mailto:andrew@daynix.com>>
> >     > ---
> >     >   hw/net/e1000e_core.c | 9 +++++++++
> >     >   hw/net/trace-events  | 1 +
> >     >   2 files changed, 10 insertions(+)
> >     >
> >     > diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> >     > index d5676871fa..302e99ff46 100644
> >     > --- a/hw/net/e1000e_core.c
> >     > +++ b/hw/net/e1000e_core.c
> >     > @@ -2624,6 +2624,15 @@ e1000e_mac_icr_read(E1000ECore *core, int
> >     index)
> >     >           e1000e_clear_ims_bits(core, core->mac[IAM]);
> >     >       }
> >     >
> >     > +    /*
> >     > +     * PCIe* GbE Controllers Open Source Software Developer's
> >     Manual
> >     > +     * 13.3.27 Interrupt Cause Read Register
> >     > +     */
> >
> >
> >     Hi Andrew:
> >
> >     Which version of the manual did you use? I try to use the one
> >     mentioned
> >     in e1000e.c which is
> >
> http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-data=
sheet.pdf
> .
> >
> >     But I couldn't find chapter 13.3.27.
> >
> >     Thanks
> >
> >
> >     > +    if (core->mac[ICR] & core->mac[IMS]) {
> >     > + trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR],
> >     core->mac[IMS]);
> >     > +        core->mac[ICR] =3D 0;
> >     > +    }
> >     > +
> >     >       trace_e1000e_irq_icr_read_exit(core->mac[ICR]);
> >     >       e1000e_update_interrupt_state(core);
> >     >       return ret;
> >     > diff --git a/hw/net/trace-events b/hw/net/trace-events
> >     > index e18f883cfd..46e40fcfa9 100644
> >     > --- a/hw/net/trace-events
> >     > +++ b/hw/net/trace-events
> >     > @@ -237,6 +237,7 @@ e1000e_irq_icr_read_entry(uint32_t icr)
> >     "Starting ICR read. Current ICR: 0x%x"
> >     >   e1000e_irq_icr_read_exit(uint32_t icr) "Ending ICR read.
> >     Current ICR: 0x%x"
> >     >   e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due
> >     to zero IMS"
> >     >   e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to
> IAME"
> >     > +e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims)
> >     "Clearing ICR on read due corresponding IMS bit: 0x%x & 0x%x"
> >     >   e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause)
> >     "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
> >     >   e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac)
> >     "Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
> >     >   e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits
> >     due to IMC write 0x%x"
> >
>
>

--000000000000974d4005a55c22d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Yo, <br></div><blockquote style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gm=
ail_quote">So I think we should implement the 82574l behavior?</blockquote>=
<div>=C2=A0Well, as I understand it - its already implemented. I&#39;ve add=
ed ICR clearance if ICR &amp; IMS(also need to add ICR_ASSERTED check, my b=
ad, I&#39;ll prepare new patch).</div><div><br></div><div>At first, I had h=
acks to clear &#39;msi_causes_pending&#39; at &#39;e1000e_core_set_link_sta=
tus()&#39; before link down. It works but it&#39;s not a solution.</div><di=
v>Also, on Windows the bug doesn&#39;t reproduce. I&#39;ve traced Windows a=
nd Linux - the difference that Windows driver clears pending by writing to =
ICR, where Linux tries to clear by reading it.</div><div>I had another poss=
ible fix - for Linux driver(writing to ICR at interrupt routine).</div><div=
>I&#39;ve asked intel guys, does Linux driver works with a device(I don&#39=
;t have real one). Thay said that it works and suggested to check 8257x spe=
c. I&#39;ll forward the message to you.<br></div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 9, 2020 at 9:0=
2 AM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><br>
On 2020/5/9 =E4=B8=8A=E5=8D=882:13, Andrew Melnichenko wrote:<br>
&gt; Yo, I&#39;ve used OpenSDM_8257x-18.pdf specification.<br>
&gt; This document was recommended by Intel guys(Also, they referenced to <=
br>
&gt; that note).<br>
&gt; I&#39;ve made a fast fix and it works. Before that I had a fix for Lin=
ux <br>
&gt; e1000e driver.<br>
&gt; Overall, the issue was in pending interrupts that can&#39;t be cleared=
 by <br>
&gt; reading ICR in Linux(Windows driver clears by writing to ICR).<br>
&gt;<br>
&gt; You can download spec for example from:<br>
&gt; <a href=3D"http://iweb.dl.sourceforge.net/project/e1000/8257x%20Develo=
per%20Manual/Revision%201.8/OpenSDM_8257x-18.pdf" rel=3D"noreferrer" target=
=3D"_blank">http://iweb.dl.sourceforge.net/project/e1000/8257x%20Developer%=
20Manual/Revision%201.8/OpenSDM_8257x-18.pdf</a><br>
<br>
<br>
Interesting, this spec doesn&#39;t include 82574l which is what e1000e <br>
claims to emulate:<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0 c-&gt;vendor_id =3D PCI_VENDOR_ID_INTEL;<br>
=C2=A0=C2=A0=C2=A0=C2=A0 c-&gt;device_id =3D E1000_DEV_ID_82574L;<br>
<br>
Looking at 82574l spec (using the link mentioned in e1000e_core.c), it <br>
said (7.4.3):<br>
<br>
In MSI-X mode the bits in this register can be configured to auto-clear <br=
>
when the MSI-X<br>
interrupt message is sent, in order to minimize driver overhead, and <br>
when using MSI-X<br>
interrupt signaling.<br>
In systems that do not support MSI-X, reading the ICR register clears <br>
it&#39;s bits or writing<br>
1b&#39;s clears the corresponding bits in this register.<br>
<br>
So the auto clear is under the control of EIAC (MSIX) or unconditionally <b=
r>
(non MSI-X).<br>
<br>
But what has been implemented in e1000e_mac_icr_read() is something <br>
similar to the behavior of non 82574l card.<br>
<br>
So I think we should implement the 82574l behavior?<br>
<br>
Thanks<br>
<br>
<br>
&gt;<br>
&gt; On Fri, May 8, 2020 at 5:21 AM Jason Wang &lt;<a href=3D"mailto:jasowa=
ng@redhat.com" target=3D"_blank">jasowang@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">ja=
sowang@redhat.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2020/5/7 =E4=B8=8A=E5=8D=885:26, <a href=3D"mail=
to:andrew@daynix.com" target=3D"_blank">andrew@daynix.com</a> &lt;mailto:<a=
 href=3D"mailto:andrew@daynix.com" target=3D"_blank">andrew@daynix.com</a>&=
gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; From: Andrew Melnychenko &lt;<a href=3D"mailto=
:andrew@daynix.com" target=3D"_blank">andrew@daynix.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:andrew@daynix.com" tar=
get=3D"_blank">andrew@daynix.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Buglink: <a href=3D"https://bugzilla.redhat.co=
m/show_bug.cgi?id=3D1707441" rel=3D"noreferrer" target=3D"_blank">https://b=
ugzilla.redhat.com/show_bug.cgi?id=3D1707441</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Added ICR clearing if there is IMS bit - accor=
ding to the note by<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; section 13.3.27 of the 8257X developers manual=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=
=3D"mailto:andrew@daynix.com" target=3D"_blank">andrew@daynix.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:andrew@daynix.com" tar=
get=3D"_blank">andrew@daynix.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0hw/net/e1000e_core.c | 9 +++++++++=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0hw/net/trace-events=C2=A0 | 1 +<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A02 files changed, 10 insertions(+)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/hw/net/e1000e_core.c b/hw/net/e10=
00e_core.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index d5676871fa..302e99ff46 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/hw/net/e1000e_core.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/hw/net/e1000e_core.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -2624,6 +2624,15 @@ e1000e_mac_icr_read(E10=
00ECore *core, int<br>
&gt;=C2=A0 =C2=A0 =C2=A0index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e1000e=
_clear_ims_bits(core, core-&gt;mac[IAM]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* PCIe* GbE Controllers O=
pen Source Software Developer&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0Manual<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* 13.3.27 Interrupt Cause=
 Read Register<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Andrew:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Which version of the manual did you use? I try to u=
se the one<br>
&gt;=C2=A0 =C2=A0 =C2=A0mentioned<br>
&gt;=C2=A0 =C2=A0 =C2=A0in e1000e.c which is<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.intel.com/content/dam/doc/dat=
asheet/82574l-gbe-controller-datasheet.pdf" rel=3D"noreferrer" target=3D"_b=
lank">http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-=
datasheet.pdf</a>.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0But I couldn&#39;t find chapter 13.3.27.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 if (core-&gt;mac[ICR] &amp; cor=
e-&gt;mac[IMS]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + trace_e1000e_irq_icr_clear_icr_bit_ims(core-=
&gt;mac[ICR],<br>
&gt;=C2=A0 =C2=A0 =C2=A0core-&gt;mac[IMS]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 core-&gt;mac[ICR]=
 =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_e1000e_irq_icr=
_read_exit(core-&gt;mac[ICR]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0e1000e_update_interr=
upt_state(core);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/hw/net/trace-events b/hw/net/trac=
e-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index e18f883cfd..46e40fcfa9 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/hw/net/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/hw/net/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -237,6 +237,7 @@ e1000e_irq_icr_read_entry(=
uint32_t icr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;Starting ICR read. Current ICR: 0x%x&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0e1000e_irq_icr_read_exit(uint32_t =
icr) &quot;Ending ICR read.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Current ICR: 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0e1000e_irq_icr_clear_zero_ims(void=
) &quot;Clearing ICR on read due<br>
&gt;=C2=A0 =C2=A0 =C2=A0to zero IMS&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0e1000e_irq_icr_clear_iame(void) &q=
uot;Clearing ICR on read due to IAME&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr=
, uint32_t ims)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;Clearing ICR on read due corresponding IMS bi=
t: 0x%x &amp; 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0e1000e_irq_iam_clear_eiame(uint32_=
t iam, uint32_t cause)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;Clearing IMS due to EIAME, IAM: 0x%X, cause: =
0x%X&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0e1000e_irq_icr_clear_eiac(uint32_t=
 icr, uint32_t eiac)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;Clearing ICR bits due to EIAC, ICR: 0x%X, EIA=
C: 0x%X&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0e1000e_irq_ims_clear_set_imc(uint3=
2_t val) &quot;Clearing IMS bits<br>
&gt;=C2=A0 =C2=A0 =C2=A0due to IMC write 0x%x&quot;<br>
&gt;<br>
<br>
</blockquote></div>

--000000000000974d4005a55c22d2--

