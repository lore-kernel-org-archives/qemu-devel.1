Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA87FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCBA206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="BCvXW+Ay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCBA206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfnBL-0005T8-RX
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jfn9x-00048S-EH
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:19:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jfn9v-0002dU-Pf
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:19:33 -0400
Received: by mail-wm1-x344.google.com with SMTP id q25so128377wmj.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QjbvqPqlTxweDiYh6hL4FyvTRuce4kixdpG5MpPpZSw=;
 b=BCvXW+AyOB/Gjjmr0mZnWB2/DxC2EFX+vtwh9TUah+fCaoe9QKAYNL7J5ckpG8rt8F
 wp1cDq08GE4JpHsR1M03GtV8MJCZBtECAGvCjixqRruCM/8VfqF7I4iFQrtg7LyjDA0q
 lQlSXWhjhFFr2FFqExVW2ULCTWqiXO/WEYS+s2n66G/e8QH4LfuvajJpP1FB0NPaO2py
 qd2NAdlI5wTK0Y1kKYLXjxk/0MVToOukKR+9agNhTl8qBiI3jIxBlz2J1syPaGGJ8kVB
 Mmgq1Dn6vuJh2n+fktKqfX9JKgqcUWlUW0FBwCDPyuBqB1+i0cSnOlwDfv4zSaq+Zq83
 3c7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QjbvqPqlTxweDiYh6hL4FyvTRuce4kixdpG5MpPpZSw=;
 b=SxTgTTgdBf4/F8zqHuBz8bChlsAs7lhH6ku3KZGrg4J5itj4u0LWvJaV9Qrb9bwCFt
 2kBNsXOvIXc8fmymAqlW87i3PJxVz9OgnhssjpKQ1JmjIZs7uHOjKhYpkzRfwJB39oYQ
 Arxmq+z1pLlwylK17PoV4yLve2KTau0ETxI5+Y/TuBaE6tQ1Xxgw+ywnljae0tUuB37a
 N/HEIj3AcaU80dTNwVj4w3iXZIXCnj8i58lUkco7sAz1ZL5xpEU6TL/7EB94evfzpzkY
 yoM3AZnB18mayx+eHex0BWoJPolmbYqKSNZTGT2zWagoe6ddzLOqPmZeOVjXQ4yCx82r
 jQVA==
X-Gm-Message-State: AOAM533CyBLJ55Z9mtzFlwmbQqeCwxIAbFObMvS3nH+M+1dADeWntngK
 ULuGdQucJYt0Lc8GMeY6NwYlq7lJhXuL/9JSK4pgkQ==
X-Google-Smtp-Source: ABdhPJyJALuXwxb3omjMAnZCm7B5Wz/jZZ8pt5vCsPzF2f6b9D+aryHDz4fO4BFQZjVbUIXMxxRmBzXesTy3/BENSik=
X-Received: by 2002:a05:600c:4401:: with SMTP id
 u1mr131950wmn.36.1591028370338; 
 Mon, 01 Jun 2020 09:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200513113125.1465650-1-andrew@daynix.com>
 <20200513113125.1465650-2-andrew@daynix.com>
 <57ab1532-c3a6-e631-5b0e-e89fc4d82873@redhat.com>
 <7d8202a5-58ad-d7e9-db29-3316834547b8@redhat.com>
In-Reply-To: <7d8202a5-58ad-d7e9-db29-3316834547b8@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 1 Jun 2020 19:47:47 +0300
Message-ID: <CABcq3pGy1yPiEusHnQMwFOwa3hbqXaMWGUi0TnrMLhetMXzq9w@mail.gmail.com>
Subject: Re: [PATCH 1/1] e1000e: Added ICR clearing by corresponding IMS bit.
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d784ca05a7082860"
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

--000000000000d784ca05a7082860
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As I understand it, the e1000e.c was implemented by 82574L spec(
https://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datas=
heet.pdf
).
In the same spec there is 10.2.4 paragraph which provides more details when
ICR should be cleared.

> =E2=80=A2 Case 1 - Interrupt Mask register equals 0x0000 (mask all): ICR =
content
> is cleared.
> =E2=80=A2 Case 2 - Interrupt was asserted (ICR.INT_ASSERT=3D1) and auto m=
ask is
> active: ICR
> content is cleared, and the IAM register is written to the IMC register.
> =E2=80=A2 Case 3 - Interrupt was not asserted (ICR.INT_ASSERT=3D0): Read =
has no side
> affect.


On Fri, May 29, 2020 at 10:35 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/5/29 =E4=B8=8B=E5=8D=883:18, Jason Wang wrote:
> >
> > On 2020/5/13 =E4=B8=8B=E5=8D=887:31, andrew@daynix.com wrote:
> >> From: Andrew Melnychenko <andrew@daynix.com>
> >>
> >> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1707441
> >> Added ICR clearing if there is IMS bit - according to the note by
> >> section 13.3.27 of the 8257X developers manual.
> >>
> >> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> >> ---
> >>   hw/net/e1000e_core.c | 10 ++++++++++
> >>   hw/net/trace-events  |  1 +
> >>   2 files changed, 11 insertions(+)
> >>
> >> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> >> index d5676871fa..10212d7932 100644
> >> --- a/hw/net/e1000e_core.c
> >> +++ b/hw/net/e1000e_core.c
> >> @@ -2624,6 +2624,16 @@ e1000e_mac_icr_read(E1000ECore *core, int index=
)
> >>           e1000e_clear_ims_bits(core, core->mac[IAM]);
> >>       }
> >>   +    /*
> >> +     * PCIe* GbE Controllers Open Source Software Developer's Manual
> >> +     * 13.3.27 Interrupt Cause Read Register
> >> +     */
> >> +    if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
> >> +        (core->mac[ICR] & core->mac[IMS])) {
> >> + trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR],
> >> core->mac[IMS]);
> >> +        core->mac[ICR] =3D 0;
> >> +    }
> >> +
> >
> >
> > Hi Andrew:
> >
> > So my comments still. I think we need to implement 82574l behavior (if
> > you go through e1000e.c all chapters it mentioned is for 82574l
> > datasheet not the one you pointed to me).
> >
> > And actually the 82574l behavior is much more simpler.
>
>
> To be more specific.
>
> See chapter 7.4.5 which describes the ICR clearing.
>
> It has three methods for clearing: auto-clear, clear-on-write and
> clear-on-read.
>
> And in the part of "Read to clear" it said:
>
> """
> All bits in the ICR register are cleared on a read to ICR.
>
> """
>
> So there's no need to IMS and other stuffs here.
>
> Thanks
>
>
> >
> > Thanks
>
>

--000000000000d784ca05a7082860
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>As I understand it, the e1000e.c was implemented by 8=
2574L spec(<a href=3D"https://www.intel.com/content/dam/doc/datasheet/82574=
l-gbe-controller-datasheet.pdf">https://www.intel.com/content/dam/doc/datas=
heet/82574l-gbe-controller-datasheet.pdf</a>).</div><div>In the same spec t=
here is 10.2.4 paragraph which provides more details when ICR should be cle=
ared.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=E2=80=A2 Case=
 1 - Interrupt Mask register equals 0x0000 (mask all): ICR content is clear=
ed.<br>=E2=80=A2 Case 2 - Interrupt was asserted (ICR.INT_ASSERT=3D1) and a=
uto mask is active: ICR<br>content is cleared, and the IAM register is writ=
ten to the IMC register.<br>=E2=80=A2 Case 3 - Interrupt was not asserted (=
ICR.INT_ASSERT=3D0): Read has no side affect.</blockquote></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 29, 2=
020 at 10:35 AM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasow=
ang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><br>
On 2020/5/29 =E4=B8=8B=E5=8D=883:18, Jason Wang wrote:<br>
&gt;<br>
&gt; On 2020/5/13 =E4=B8=8B=E5=8D=887:31, <a href=3D"mailto:andrew@daynix.c=
om" target=3D"_blank">andrew@daynix.com</a> wrote:<br>
&gt;&gt; From: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.com" =
target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Buglink: <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D=
1707441" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/s=
how_bug.cgi?id=3D1707441</a><br>
&gt;&gt; Added ICR clearing if there is IMS bit - according to the note by<=
br>
&gt;&gt; section 13.3.27 of the 8257X developers manual.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@day=
nix.com" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 hw/net/e1000e_core.c | 10 ++++++++++<br>
&gt;&gt; =C2=A0 hw/net/trace-events=C2=A0 |=C2=A0 1 +<br>
&gt;&gt; =C2=A0 2 files changed, 11 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c<br>
&gt;&gt; index d5676871fa..10212d7932 100644<br>
&gt;&gt; --- a/hw/net/e1000e_core.c<br>
&gt;&gt; +++ b/hw/net/e1000e_core.c<br>
&gt;&gt; @@ -2624,6 +2624,16 @@ e1000e_mac_icr_read(E1000ECore *core, int i=
ndex)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e1000e_clea=
r_ims_bits(core, core-&gt;mac[IAM]);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0 +=C2=A0=C2=A0=C2=A0 /*<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * PCIe* GbE Controllers Open Source Soft=
ware Developer&#39;s Manual<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * 13.3.27 Interrupt Cause Read Register<=
br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if ((core-&gt;mac[ICR] &amp; E1000_ICR_ASSERTE=
D) &amp;&amp;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (core-&gt;mac[ICR] &am=
p; core-&gt;mac[IMS])) {<br>
&gt;&gt; + trace_e1000e_irq_icr_clear_icr_bit_ims(core-&gt;mac[ICR], <br>
&gt;&gt; core-&gt;mac[IMS]);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core-&gt;mac[ICR] =3D =
0;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +<br>
&gt;<br>
&gt;<br>
&gt; Hi Andrew:<br>
&gt;<br>
&gt; So my comments still. I think we need to implement 82574l behavior (if=
 <br>
&gt; you go through e1000e.c all chapters it mentioned is for 82574l <br>
&gt; datasheet not the one you pointed to me).<br>
&gt;<br>
&gt; And actually the 82574l behavior is much more simpler.<br>
<br>
<br>
To be more specific.<br>
<br>
See chapter 7.4.5 which describes the ICR clearing.<br>
<br>
It has three methods for clearing: auto-clear, clear-on-write and <br>
clear-on-read.<br>
<br>
And in the part of &quot;Read to clear&quot; it said:<br>
<br>
&quot;&quot;&quot;<br>
All bits in the ICR register are cleared on a read to ICR.<br>
<br>
&quot;&quot;&quot;<br>
<br>
So there&#39;s no need to IMS and other stuffs here.<br>
<br>
Thanks<br>
<br>
<br>
&gt;<br>
&gt; Thanks<br>
<br>
</blockquote></div>

--000000000000d784ca05a7082860--

