Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771E8C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96607206F7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="ydzedP03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96607206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ3Da-0002ue-MG
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 02:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kQ3AC-0001AZ-9A
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 02:43:00 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kQ3A8-00053p-Tb
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 02:43:00 -0400
Received: by mail-pl1-x641.google.com with SMTP id h2so492552pll.11
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oqjm9UYQaC0KbkHDlW58it8LWpqAFUADrAYka5eOyFI=;
 b=ydzedP03pBSaU+91G/aiwJa3NM+bvyX+IbKvgBMGoYdgj/jBAZ/dj8Lrb9NEd+yw5z
 8NUcW5o8AcABX0Tf0v/ao1vTCz695qm4VvD9weW90KNl+Ch4tCglwpZzQPasNmZhVI5w
 aAVc3OqhLqCd13Z6b4+rbYJ5NXQzNMF+uevG6HJLSSLX7TWTz4brLjnk3wpSfpdCN7sV
 Z2btjvGKjCDqKnZWsI+b6AUb3wSvnAXld+U4VG7K0ee/BGdoil3tjrdGpIU72VjNevWO
 2HS/k79swkKd2sG5bGdnb0QFxuo6Tg+JoPhvS19P/RtoPQz47fYWgCCchkl1FKwHhoNd
 hueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oqjm9UYQaC0KbkHDlW58it8LWpqAFUADrAYka5eOyFI=;
 b=KcJkhTfGVNry4oG7BNRhZEYMp46GYlAok291PX/XtHtoPthi8ShkZ20NHMW39mU0IX
 JXA7gz8ZzIfYv4rRbGg49IUHBUCfaTNfedR5EtCCIccZA4Zvjko11fLHEKijwXE+9WeB
 VRt62MR34CmOoFycnDEwkFCGqXGoFp3VSQMJAwDt2uWWVAWddeLNDlFsoOl4K2jucc9F
 XbeGESMubXoHkLfkD3JHmG+rJrvt8EM6BnUsceES7CyaPwzOBXNYTVPWeOPCzba/OwAF
 LhHg9pyaB063VHz07qc+0UXScP4xvSMK78h57YPFBjxRH3gssp/TlIygyDQNYgmeAVhx
 AIAA==
X-Gm-Message-State: AOAM531eVH69hbSaWRorCWuarY+HodSuH0wzYuuKQRwuYBYf3s+UE9kT
 AC5S9BwlZhNQiO5PzEh692narbol1TuRdlBbPeiuPA==
X-Google-Smtp-Source: ABdhPJwUE2c3DenpndHdafPuLFFz5L6N1wEDOnoQLvefN9NcOr+XVr8iCAqXLf8siam4OGoCLq+5AJmT5ay+H7VrDOI=
X-Received: by 2002:a17:902:204:b029:d3:9c43:3715 with SMTP id
 4-20020a1709020204b02900d39c433715mr1635622plc.74.1602052974871; Tue, 06 Oct
 2020 23:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201005115601.103791-1-andrew@daynix.com>
 <20201005115601.103791-3-andrew@daynix.com>
 <20201005134406-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201005134406-mutt-send-email-mst@kernel.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Wed, 7 Oct 2020 10:13:52 +0300
Message-ID: <CABcq3pFnRzfbnBgYtYd7ocy1C6qEdCNeT0M_L5bv9v_PQccrqA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] hw/virtio-pci Added AER capability.
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007a9a9205b10f063b"
Received-SPF: none client-ip=2607:f8b0:4864:20::641;
 envelope-from=andrew@daynix.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007a9a9205b10f063b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok,
Main motivation:

> According to Microsoft driver\device certification requirements for next
> version of Window Server, PCIe device must support AER.
> The exact quote of Microsoft certification requirements:
> "Windows Server PCI Express devices are required to support Advanced
> Error Reporting [AER] as defined in PCI Express Base Specification versio=
n
> 2.1.*=E2=80=9D*
>
 and

> Does management need ability to enable this capability?
>
Actually, yes. Can you provide their email address?

I'll prepare a new patch and I'll remove bugzilla link.

On Mon, Oct 5, 2020 at 8:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Mon, Oct 05, 2020 at 02:56:01PM +0300, andrew@daynix.com wrote:
> > From: Andrew <andrew@daynix.com>
> >
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1878465
>
> That's a private bug - what information can you share about
> the motivation for the patch?
>
> > Added AER capability for virtio-pci devices.
> > Also added property for devices, by default AER is disabled.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  hw/virtio/virtio-pci.c | 16 ++++++++++++++++
> >  hw/virtio/virtio-pci.h |  4 ++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index ae60c1e249..e0a7936f9c 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1807,6 +1807,12 @@ static void virtio_pci_realize(PCIDevice
> *pci_dev, Error **errp)
> >           */
> >          pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
> >
> > +        if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
> > +            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
> > +                          PCI_ERR_SIZEOF, NULL);
> > +            last_pcie_cap_offset +=3D PCI_ERR_SIZEOF;
> > +        }
> > +
> >          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
> >              /* Init error enabling flags */
> >              pcie_cap_deverr_init(pci_dev);
> > @@ -1848,7 +1854,15 @@ static void virtio_pci_realize(PCIDevice
> *pci_dev, Error **errp)
> >
> >  static void virtio_pci_exit(PCIDevice *pci_dev)
> >  {
> > +    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);
> > +    bool pcie_port =3D pci_bus_is_express(pci_get_bus(pci_dev)) &&
> > +                     !pci_bus_is_root(pci_get_bus(pci_dev));
> > +
> >      msix_uninit_exclusive_bar(pci_dev);
> > +    if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
> > +        pci_is_express(pci_dev)) {
> > +        pcie_aer_exit(pci_dev);
> > +    }
> >  }
> >
> >  static void virtio_pci_reset(DeviceState *qdev)
> > @@ -1901,6 +1915,8 @@ static Property virtio_pci_properties[] =3D {
> >                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> >      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
> >                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> > +    DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> > +                    VIRTIO_PCI_FLAG_AER_BIT, false),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
>
> Does management need ability to enable this capability?
> If yes let's cc them. If no let's rename to x-aer so we don't
> commit to a stable interface ...
>
>
> > diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> > index 91096f0291..3986b4f0e3 100644
> > --- a/hw/virtio/virtio-pci.h
> > +++ b/hw/virtio/virtio-pci.h
> > @@ -45,6 +45,7 @@ enum {
> >      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
> >      VIRTIO_PCI_FLAG_INIT_PM_BIT,
> >      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> > +    VIRTIO_PCI_FLAG_AER_BIT,
> >  };
> >
> >  /* Need to activate work-arounds for buggy guests at vmstate load. */
> > @@ -84,6 +85,9 @@ enum {
> >  /* Init Function Level Reset capability */
> >  #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
> >
> > +/* Advanced Error Reporting capability */
> > +#define VIRTIO_PCI_FLAG_AER (1 << VIRTIO_PCI_FLAG_AER_BIT)
> > +
> >  typedef struct {
> >      MSIMessage msg;
> >      int virq;
> > --
> > 2.28.0
>
>

--0000000000007a9a9205b10f063b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Ok,</div><div>Main motivation:</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div><div></div><div>According to Microsof=
t driver\device certification requirements for next version of Window Serve=
r, PCIe device must support AER.</div><div>The exact quote of Microsoft cer=
tification requirements:</div><div>&quot;<span style=3D"color:rgb(0,0,0);fo=
nt-family:Arial;font-size:9pt;font-style:italic">Windows
 Server PCI Express devices are required to support Advanced Error=20
Reporting [AER] as defined in PCI Express Base Specification version=20
2.1.</span><font face=3D"Arial" color=3D"#000000"><span><i>=E2=80=9D</i></s=
pan></font></div></div></blockquote><div>=C2=A0and</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div>Does management need ability to enabl=
e this capability?</div></blockquote><div>Actually, yes. Can you provide th=
eir email address?<br></div><div><br></div><div>I&#39;ll prepare a new patc=
h and I&#39;ll remove bugzilla link.<br></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 5, 2020 at 8:46 P=
M Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank=
">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Mon, Oct 05, 2020 at 02:56:01PM +0300, <a href=3D"mailto=
:andrew@daynix.com" target=3D"_blank">andrew@daynix.com</a> wrote:<br>
&gt; From: Andrew &lt;<a href=3D"mailto:andrew@daynix.com" target=3D"_blank=
">andrew@daynix.com</a>&gt;<br>
&gt; <br>
&gt; Buglink: <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1878=
465" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_=
bug.cgi?id=3D1878465</a><br>
<br>
That&#39;s a private bug - what information can you share about<br>
the motivation for the patch?<br>
<br>
&gt; Added AER capability for virtio-pci devices.<br>
&gt; Also added property for devices, by default AER is disabled.<br>
&gt; <br>
&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.=
com" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/virtio-pci.c | 16 ++++++++++++++++<br>
&gt;=C2=A0 hw/virtio/virtio-pci.h |=C2=A0 4 ++++<br>
&gt;=C2=A0 2 files changed, 20 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c<br>
&gt; index ae60c1e249..e0a7936f9c 100644<br>
&gt; --- a/hw/virtio/virtio-pci.c<br>
&gt; +++ b/hw/virtio/virtio-pci.c<br>
&gt; @@ -1807,6 +1807,12 @@ static void virtio_pci_realize(PCIDevice *pci_d=
ev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_set_word(pci_dev-&gt;config + po=
s + PCI_PM_PMC, 0x3);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (proxy-&gt;flags &amp; VIRTIO_PCI_FLAG=
_AER) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcie_aer_init(pci_dev, PCI_=
ERR_VER, last_pcie_cap_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 PCI_ERR_SIZEOF, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_pcie_cap_offset +=3D P=
CI_ERR_SIZEOF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (proxy-&gt;flags &amp; VIRTIO_PCI=
_FLAG_INIT_DEVERR) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Init error enabling=
 flags */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcie_cap_deverr_init(p=
ci_dev);<br>
&gt; @@ -1848,7 +1854,15 @@ static void virtio_pci_realize(PCIDevice *pci_d=
ev, Error **errp)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void virtio_pci_exit(PCIDevice *pci_dev)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);<br>
&gt; +=C2=A0 =C2=A0 bool pcie_port =3D pci_bus_is_express(pci_get_bus(pci_d=
ev)) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0!pci_bus_is_root(pci_get_bus(pci_dev));<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 msix_uninit_exclusive_bar(pci_dev);<br>
&gt; +=C2=A0 =C2=A0 if (proxy-&gt;flags &amp; VIRTIO_PCI_FLAG_AER &amp;&amp=
; pcie_port &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_is_express(pci_dev)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcie_aer_exit(pci_dev);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void virtio_pci_reset(DeviceState *qdev)<br>
&gt; @@ -1901,6 +1915,8 @@ static Property virtio_pci_properties[] =3D {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 VIRTIO_PCI_FLAG_INIT_PM_BIT, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BIT(&quot;x-pcie-flr-init&quot;, VirtI=
OPCIProxy, flags,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BIT(&quot;aer&quot;, VirtIOPCIProxy, flags,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 VIRTIO_PCI_FLAG_AER_BIT, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt;=C2=A0 };<br>
&gt; <br>
<br>
Does management need ability to enable this capability?<br>
If yes let&#39;s cc them. If no let&#39;s rename to x-aer so we don&#39;t<b=
r>
commit to a stable interface ...<br>
<br>
<br>
&gt; diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h<br>
&gt; index 91096f0291..3986b4f0e3 100644<br>
&gt; --- a/hw/virtio/virtio-pci.h<br>
&gt; +++ b/hw/virtio/virtio-pci.h<br>
&gt; @@ -45,6 +45,7 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_PCI_FLAG_INIT_PM_BIT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_PCI_FLAG_INIT_FLR_BIT,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_PCI_FLAG_AER_BIT,<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* Need to activate work-arounds for buggy guests at vmstate loa=
d. */<br>
&gt; @@ -84,6 +85,9 @@ enum {<br>
&gt;=C2=A0 /* Init Function Level Reset capability */<br>
&gt;=C2=A0 #define VIRTIO_PCI_FLAG_INIT_FLR (1 &lt;&lt; VIRTIO_PCI_FLAG_INI=
T_FLR_BIT)<br>
&gt;=C2=A0 <br>
&gt; +/* Advanced Error Reporting capability */<br>
&gt; +#define VIRTIO_PCI_FLAG_AER (1 &lt;&lt; VIRTIO_PCI_FLAG_AER_BIT)<br>
&gt; +<br>
&gt;=C2=A0 typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MSIMessage msg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int virq;<br>
&gt; -- <br>
&gt; 2.28.0<br>
<br>
</blockquote></div>

--0000000000007a9a9205b10f063b--

