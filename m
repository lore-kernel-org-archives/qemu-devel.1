Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E7BC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D658206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="U7/F2Wi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D658206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPOJ4-0004Pc-5X
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 07:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kPOGE-0002mg-89
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 07:02:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kPOG8-00037t-6o
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 07:02:29 -0400
Received: by mail-pg1-x544.google.com with SMTP id g18so3641067pgd.5
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 04:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=08vZY+3bcErz95M3JZ2GrS8+wbjWer11x6dH+Wo3MyI=;
 b=U7/F2Wi5EDYgMyJUT70w1CqyKYUzU3OR8vTxKF/VQ5ucI1x5uA1VoXqXRXArLsVXv5
 NTkBu10ESZPio1zmwah5J/+iPaM89WzfDMS7f0T9Vqebo4ICcM+Zj3+8RWjT4KUKJSyJ
 NdnVysZ6fXxpEvAtRk5hklSKGOn0SvLr4Qxa+2ugMK2JAgFwIRg9rWEpC3EtA6K8Ur0l
 o+VQzDdTguGzHUsHxKqY0AmTsSlH08NT5JIxMep6tmca86ksSXhNDYBMtfDkAfQk9Wta
 1gLDZmRNuIL+b9S8RVPunUGGbh02D5LcNBezwf1dBZrHOJEq7SYihhu83JusruiqbcbY
 Ejpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=08vZY+3bcErz95M3JZ2GrS8+wbjWer11x6dH+Wo3MyI=;
 b=Guq1/nACfWIs02VOLpsb/jfx1qXcD3iMm5/XR5dANpys7+9SRpo4qnEyye+H2sNIGD
 PC1J5FyAHucPCxseiOozpRfLkab1I2J+nJk7OzbXfpC7s/3Fdl7waW3SkmTUNRDttYFM
 91/zyIUyV4uUlPM2moxHTc5KpuWfzkf9ecLIDoMuoMIQBdg5f1086UNoVLk6umYm3aR3
 UzFJWR6PsFiR32PsgdlhSyAA5yrON2RSz+Dt5lY28AsKNQgWpJxZQaY2Zc9P/QzaL+QK
 ZORJExxeg0VXPmOALQsQx4C9EeQwi5vxmmlmMZvhjhs+HsDThfohsftNIkOMZFdYCYgf
 0rlQ==
X-Gm-Message-State: AOAM532aO6COjNwFALsMJaKze4uc6BSQEhC5iHB7IHh5ZXH2Yq/j2J+1
 WhOgB5iJWauJ+d0VCvozISxnDkwXrp5gy9sEBPz3jsRdGZV5yA==
X-Google-Smtp-Source: ABdhPJzZSkFlOM0KTo8Bx/m8A3Lx4YhpoOirz5Ekc1MNTopR49ObJPEjj3mKYA7em+aBwhfFH5nV2c24Vi/sUyDu5/Q=
X-Received: by 2002:a63:fe03:: with SMTP id p3mr14026134pgh.100.1601895742371; 
 Mon, 05 Oct 2020 04:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201005090140.90461-1-andrew@daynix.com>
 <20201005090140.90461-3-andrew@daynix.com>
 <20201005060809-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201005060809-mutt-send-email-mst@kernel.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 5 Oct 2020 14:33:18 +0300
Message-ID: <CABcq3pEx_vqgtMbhBwsw52cOhGQuyh7YjAnVnHni3-31iz5-zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/virtio-pci Added AER capability.
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b1143405b0ea6abb"
Received-SPF: none client-ip=2607:f8b0:4864:20::544;
 envelope-from=andrew@daynix.com; helo=mail-pg1-x544.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b1143405b0ea6abb
Content-Type: text/plain; charset="UTF-8"

yes

>     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
>                     VIRTIO_PCI_FLAG_AER_BIT, *false*),
>

On Mon, Oct 5, 2020 at 1:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Mon, Oct 05, 2020 at 12:01:40PM +0300, andrew@daynix.com wrote:
> > From: Andrew <andrew@daynix.com>
> >
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1857668
> > Added AER capability for virtio-pci devices.
> > Also added property for devices, by default AER is enabled.
>
>
> Looking at code it's disabled by default, isn't it?
>
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
> > +            last_pcie_cap_offset += PCI_ERR_SIZEOF;
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
> > +    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
> > +    bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
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
> > @@ -1901,6 +1915,8 @@ static Property virtio_pci_properties[] = {
> >                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> >      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
> >                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> > +    DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> > +                    VIRTIO_PCI_FLAG_AER_BIT, false),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
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

--000000000000b1143405b0ea6abb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>yes</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div>=C2=A0 =C2=A0 DEFINE_PROP_BIT(&quot;aer&quot;, VirtIOPCIProxy, f=
lags,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 VIRTIO_PCI_FLAG_AER_BIT, <b>false</b>),</div></blockquote></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 5=
, 2020 at 1:08 PM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">=
mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Mon, Oct 05, 2020 at 12:01:40PM +0300, <a href=3D"mailto:a=
ndrew@daynix.com" target=3D"_blank">andrew@daynix.com</a> wrote:<br>
&gt; From: Andrew &lt;<a href=3D"mailto:andrew@daynix.com" target=3D"_blank=
">andrew@daynix.com</a>&gt;<br>
&gt; <br>
&gt; Buglink: <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1857=
668" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_=
bug.cgi?id=3D1857668</a><br>
&gt; Added AER capability for virtio-pci devices.<br>
&gt; Also added property for devices, by default AER is enabled.<br>
<br>
<br>
Looking at code it&#39;s disabled by default, isn&#39;t it?<br>
<br>
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
&gt;=C2=A0 <br>
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

--000000000000b1143405b0ea6abb--

