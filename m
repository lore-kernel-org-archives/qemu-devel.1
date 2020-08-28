Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA95C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B81207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="HGrRgCWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B81207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeFV-0007Zq-Bl
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kBeEc-0006ky-O3
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:16:03 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:40122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kBeEZ-0003is-6l
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:16:02 -0400
Received: by mail-pl1-x62c.google.com with SMTP id z15so442875plo.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=ktCvkPbaRE29dMMbEUTVC3KZtiqbYaDt1o49613d2TQ=;
 b=HGrRgCWBSr13k1uT1hd7Dziy3Ho5Ar9R3HNjqs0dXXOjDXITbOYy6CPYe8FRb6wM1r
 jRs7eM6KK5/g6/2dR7dC9H3vnfrpSujtOOH8vvR5QH0IyB5pgGd6Ri4GQ56GjtN0F1QI
 RUL4E1LEUNHRjgWSqj4nTsn5gz76WAFzUEyLeBPK1w/6yg1pDZIPTxllZjLTcW9lSItp
 lig3xP5au6NJuc5z/Y15FTJcOKuxgUSwbttcQ1cADx8UyliqevGYNrRTYff92JIayz6b
 114x5B8FHVtQKgbatuZ1evMGKyiX39S/zTz194eYBM2hQJzZZoyvZbOv1/yXtwLFyqVp
 2JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=ktCvkPbaRE29dMMbEUTVC3KZtiqbYaDt1o49613d2TQ=;
 b=Aa6pv/ZIijiKcjADrgWBJrX041XKrd2X5lwR/lo1re/DvUul3ODFrYYlvbkDonx0A7
 8fFM470KvWZ+L3eH0X+IuZMKd2lfadoIIjHnp4lPCnUS5onM5BvjM7J7/PFlmwl7naZB
 JwEMGf+Z9PgLSf+DavVemTQG26HtHLUJ06aTsJOt78D49fRLYr7QeON8uSlc2e5qHSIE
 5XY+D/pByiL030yFYL7mg8sP7Aob0yUIhiz5NsNqJSsb50KH1BwilvkDdLNt/PuwA8qg
 iRkv2edpRmdvb6uny4YrjCn5CHeBg/xRq40Ee6nJLz52RDw+u475CjvIfN9J66PQajBR
 Z96w==
X-Gm-Message-State: AOAM530+pdzb+nhz6fF289abnYWfpYTFerg57kKSbmgS0s6AYHGr4qMl
 XsSlCEZpVHxvHsFP+qNpyhH/4A==
X-Google-Smtp-Source: ABdhPJyfMrd8Q84sPEJD2bJD3u79QzMe7xUauQ9CfE6hV9f+N9L9VfiziIiZw/bxytpYn+vId2MPhg==
X-Received: by 2002:a17:90a:f416:: with SMTP id
 ch22mr1157598pjb.232.1598620556866; 
 Fri, 28 Aug 2020 06:15:56 -0700 (PDT)
Received: from [192.168.1.3] ([115.96.108.41])
 by smtp.gmail.com with ESMTPSA id y3sm1389667pjg.8.2020.08.28.06.15.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Aug 2020 06:15:56 -0700 (PDT)
Date: Fri, 28 Aug 2020 18:45:26 +0530
From: Ani Sinha <ani@anisinha.ca>
To: Julia Suvorova <jusual@redhat.com>
Message-ID: <7074c5ce-b2c8-4d11-8309-2a19cadec0ef@Spark>
In-Reply-To: <CAMDeoFXa2NPwCE3u-OVsBGQQWOY9yk_048iL8gieboGU5Hj7+w@mail.gmail.com>
References: <20200827133954.2118749-1-mst@redhat.com>
 <20200827133954.2118749-7-mst@redhat.com>
 <20200827194115.673f94de@imammedo-mac>
 <CAARzgwzLcu5iHrXNZrVbg2Yx27AvyYWrKqBZ0wK7CveQ_eKgsQ@mail.gmail.com>
 <20200828114907.42961cd3@redhat.com>
 <d67e8431-b23a-46ee-94f3-544c4476848e@Spark>
 <CAMDeoFXa2NPwCE3u-OVsBGQQWOY9yk_048iL8gieboGU5Hj7+w@mail.gmail.com>
Subject: Re: [PULL 06/13] Introduce a new flag for i440fx to disable PCI
 hotplug on the root bus
X-Readdle-Message-ID: 7074c5ce-b2c8-4d11-8309-2a19cadec0ef@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f490385_5bd062c2_239"
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x62c.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5f490385_5bd062c2_239
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Aug 28, 2020, 18:40 +0530, Julia Suvorova <jusual=40redhat.com>, wrote=
:
> On =46ri, Aug 28, 2020 at 11:53 AM Ani Sinha <ani=40anisinha.ca> wrote:=

> >
> >
> > Ani
> > On Aug 28, 2020, 15:19 +0530, Igor Mammedov <imammedo=40redhat.com>, =
wrote:
> >
> > On Thu, 27 Aug 2020 23:29:34 +0530
> >
> > Ani Sinha <ani=40anisinha.ca> wrote:
> >
> >
> > On Thu, Aug 27, 2020 at 11:11 PM Igor Mammedov <imammedo=40redhat.com=
> wrote:
> >
> >
> > On Thu, 27 Aug 2020 09:40:34 -0400
> >
> > =22Michael S. Tsirkin=22 <mst=40redhat.com> wrote:
> >
> >
> > =46rom: Ani Sinha <ani=40anisinha.ca>
> >
> >
> > We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx wit=
h which
> >
> > we can turn on or off PCI device hotplug on the root bus. This flag c=
an be
> >
> > used to prevent all PCI devices from getting hotplugged or unplugged =
from the
> >
> > root PCI bus.
> >
> > This feature is targetted mostly towards Windows VMs. It is useful in=
 cases
> >
> > where some hypervisor admins want to deploy guest VMs in a way so tha=
t the
> >
> > users of the guest OSes are not able to hot-eject certain PCI devices=
 from
> >
> > the Windows system tray. Laine has explained the use case here in det=
ail:
> >
> > https://www.redhat.com/archives/libvir-list/2020-=46ebruary/msg00110.=
html
> >
> >
> > Julia has resolved this issue for PCIE buses with the following commi=
t:
> >
> > 530a0963184e57e71a5b538 (=22pcie=5Froot=5Fport: Add hotplug disabling=
 option=22)
> >
> >
> > This commit attempts to introduce similar behavior for PCI root buses=
 used in
> >
> > i440fx machine types (although in this case, we do not have a per-slo=
t
> >
> > capability to turn hotplug on or off).
> >
> >
> > Usage:
> >
> > -global PIIX4=5FPM.acpi-root-pci-hotplug=3Doff
> >
> >
> > By default, this option is enabled which means that hotplug is turned=
 on for
> >
> > the PCI root bus.
> >
> >
> > The previously existing flag 'acpi-pci-hotplug-with-bridge-support' f=
or PCI-PCI
> >
> > bridges remain as is and can be used along with this new flag to cont=
rol PCI
> >
> > hotplug on PCI bridges.
> >
> >
> > This change has been tested using a Windows 2012R2 server guest image=
 and also
> >
> > with a Windows 2019 server guest image on a Ubuntu 18.04 host using t=
he latest
> >
> > master qemu from upstream.
> >
> >
> > Signed-off-by: Ani Sinha <ani=40anisinha.ca>
> >
> > Message-Id: <20200821165403.26589-1-ani=40anisinha.ca>
> >
> > Reviewed-by: Michael S. Tsirkin <mst=40redhat.com>
> >
> > Signed-off-by: Michael S. Tsirkin <mst=40redhat.com>
> >
> >
> >
> > Tested-by: Igor Mammedov <imammedo=40redhat.com>
> >
> > Reviewed-by: Igor Mammedov <imammedo=40redhat.com>
> >
> > A glitch in scripts=3F
> >
> > I didn't review nor tested this (v8) version
> >
> >
> > oops=21 I am so eager to get this done and dusted :)
> >
> > it's merged now,
> >
> >
> > Wait it merged without your review=3F
>
> Yeah, not only added into the pull request, but actually merged.
>
> >
> > can you add a test case for it please=3F
> >
> >
> > You can use test=5Facpi=5Fpiix4=5Ftcg=5Fbridge() as model.
> >
> > See header comment at the top of bios-tables-test.c
> >
> > for how to prepare and submit testcase.
> >
> >
> > Will get on it.
>
> Also, while the whole approach seems good to me, it leaves the hotplug
> registers initialized (see build=5Fpiix4=5Fpci=5Fhotplug()), even if bo=
th
> root and bridges hotplug are disabled. Which you can exploit by
> writing something like this to the io registers:
>
> outl 0xae10 0

You=E2=80=99re setting bsel 0 with this line correct=3F
> outl 0xae08 your=5Fslot
>
> And because of these quite interesting lines the device will be
> successfully unplugged:
>
> static PCIBus *acpi=5Fpcihp=5Ffind=5Fhotplug=5Fbus(AcpiPciHpState *s, i=
nt bsel)
> =7B
> ...
> /* Make bsel 0 eject root bus if bsel property is not set,
> * for compatibility with non acpi setups.
> * TODO: really needed=3F
> */
> if (=21bsel && =21find.bus) =7B
> find.bus =3D s->root;
> =7D
> return find.bus;
> =7D
>
> Could you please cover both issues in the follow-up patches=3F

Can you please explain what do you mean by both issues=3F The unit test i=
ssue and leaving the registers initialized=3F

>
> Best regards, Julia Suvorova.
>
> >
> >
> >
> > ---
> >
> > include/hw/acpi/pcihp.h =7C 2 +-
> >
> > hw/acpi/pcihp.c =7C 23 ++++++++++++++++++++++-
> >
> > hw/acpi/piix4.c =7C 5 ++++-
> >
> > 3 files changed, 27 insertions(+), 3 deletions(-)
> >
> >
> > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> >
> > index 8bc4a4c01d..02f4665767 100644
> >
> > --- a/include/hw/acpi/pcihp.h
> >
> > +++ b/include/hw/acpi/pcihp.h
> >
> > =40=40 -67,7 +67,7 =40=40 void acpi=5Fpcihp=5Fdevice=5Funplug=5Freque=
st=5Fcb(HotplugHandler *hotplug=5Fdev,
> >
> > Error **errp);
> >
> >
> > /* Called on reset */
> >
> > -void acpi=5Fpcihp=5Freset(AcpiPciHpState *s);
> >
> > +void acpi=5Fpcihp=5Freset(AcpiPciHpState *s, bool acpihp=5Froot=5Fof=
f);
> >
> >
> > extern const VMStateDescription vmstate=5Facpi=5Fpcihp=5Fpci=5Fstatus=
;
> >
> >
> > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> >
> > index 9e31ab2da4..39b1f74442 100644
> >
> > --- a/hw/acpi/pcihp.c
> >
> > +++ b/hw/acpi/pcihp.c
> >
> > =40=40 -104,6 +104,24 =40=40 static void acpi=5Fset=5Fpci=5Finfo(void=
)
> >
> > =7D
> >
> > =7D
> >
> >
> > +static void acpi=5Fpcihp=5Fdisable=5Froot=5Fbus(void)
> >
> > +=7B
> >
> > + static bool root=5Fhp=5Fdisabled;
> >
> > + PCIBus *bus;
> >
> > +
> >
> > + if (root=5Fhp=5Fdisabled) =7B
> >
> > + return;
> >
> > + =7D
> >
> > +
> >
> > + bus =3D find=5Fi440fx();
> >
> > + if (bus) =7B
> >
> > + /* setting the hotplug handler to NULL makes the bus non-hotpluggab=
le */
> >
> > + qbus=5Fset=5Fhotplug=5Fhandler(BUS(bus), NULL);
> >
> > + =7D
> >
> > + root=5Fhp=5Fdisabled =3D true;
> >
> > + return;
> >
> > +=7D
> >
> > +
> >
> > static void acpi=5Fpcihp=5Ftest=5Fhotplug=5Fbus(PCIBus *bus, void *op=
aque)
> >
> > =7B
> >
> > AcpiPciHp=46ind *find =3D opaque;
> >
> > =40=40 -209,8 +227,11 =40=40 static void acpi=5Fpcihp=5Fupdate(AcpiPc=
iHpState *s)
> >
> > =7D
> >
> > =7D
> >
> >
> > -void acpi=5Fpcihp=5Freset(AcpiPciHpState *s)
> >
> > +void acpi=5Fpcihp=5Freset(AcpiPciHpState *s, bool acpihp=5Froot=5Fof=
f)
> >
> > =7B
> >
> > + if (acpihp=5Froot=5Foff) =7B
> >
> > + acpi=5Fpcihp=5Fdisable=5Froot=5Fbus();
> >
> > + =7D
> >
> > acpi=5Fset=5Fpci=5Finfo();
> >
> > acpi=5Fpcihp=5Fupdate(s);
> >
> > =7D
> >
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> >
> > index 26bac4f16c..e6163bb6ce 100644
> >
> > --- a/hw/acpi/piix4.c
> >
> > +++ b/hw/acpi/piix4.c
> >
> > =40=40 -78,6 +78,7 =40=40 typedef struct PIIX4PMState =7B
> >
> >
> > AcpiPciHpState acpi=5Fpci=5Fhotplug;
> >
> > bool use=5Facpi=5Fhotplug=5Fbridge;
> >
> > + bool use=5Facpi=5Froot=5Fpci=5Fhotplug;
> >
> >
> > uint8=5Ft disable=5Fs3;
> >
> > uint8=5Ft disable=5Fs4;
> >
> > =40=40 -324,7 +325,7 =40=40 static void piix4=5Fpm=5Freset(DeviceStat=
e *dev)
> >
> > pci=5Fconf=5B0x5B=5D =3D 0x02;
> >
> > =7D
> >
> > pm=5Fio=5Fspace=5Fupdate(s);
> >
> > - acpi=5Fpcihp=5Freset(&s->acpi=5Fpci=5Fhotplug);
> >
> > + acpi=5Fpcihp=5Freset(&s->acpi=5Fpci=5Fhotplug, =21s->use=5Facpi=5Fr=
oot=5Fpci=5Fhotplug);
> >
> > =7D
> >
> >
> > static void piix4=5Fpm=5Fpowerdown=5Freq(Notifier *n, void *opaque)
> >
> > =40=40 -635,6 +636,8 =40=40 static Property piix4=5Fpm=5Fproperties=5B=
=5D =3D =7B
> >
> > DE=46INE=5FPROP=5FUINT8(ACPI=5FPM=5FPROP=5FS4=5FVAL, PIIX4PMState, s4=
=5Fval, 2),
> >
> > DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotplug-with-bridge-support=22, PI=
IX4PMState,
> >
> > use=5Facpi=5Fhotplug=5Fbridge, true),
> >
> > + DE=46INE=5FPROP=5FBOOL(=22acpi-root-pci-hotplug=22, PIIX4PMState,
> >
> > + use=5Facpi=5Froot=5Fpci=5Fhotplug, true),
> >
> > DE=46INE=5FPROP=5FBOOL(=22memory-hotplug-support=22, PIIX4PMState,
> >
> > acpi=5Fmemory=5Fhotplug.is=5Fenabled, true),
> >
> > DE=46INE=5FPROP=5FEND=5FO=46=5FLIST(),
> >
> >
> >
> >
>

--5f490385_5bd062c2_239
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageReplySection=22>
<div dir=3D=22auto=22>On Aug 28, 2020, 18:40 +0530, Julia Suvorova &lt;ju=
sual=40redhat.com&gt;, wrote:</div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On =46ri, Aug 28, 2020 at 11:53 =
AM Ani Sinha &lt;ani=40anisinha.ca&gt; wrote:</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Ani</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Aug 28, 2020, 15:19 +0530, Ig=
or Mammedov &lt;imammedo=40redhat.com&gt;, wrote:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Thu, 27 Aug 2020 23:29:34 +05=
30</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Ani Sinha &lt;ani=40anisinha.ca&=
gt; wrote:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Thu, Aug 27, 2020 at 11:11 PM=
 Igor Mammedov &lt;imammedo=40redhat.com&gt; wrote:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Thu, 27 Aug 2020 09:40:34 -04=
00</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=22Michael S. Tsirkin=22 &lt;mst=
=40redhat.com&gt; wrote:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=46rom: Ani Sinha &lt;ani=40anis=
inha.ca&gt;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>We introduce a new global flag '=
acpi-root-pci-hotplug' for i440fx with which</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>we can turn on or off PCI device=
 hotplug on the root bus. This flag can be</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>used to prevent all PCI devices =
from getting hotplugged or unplugged from the</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>root PCI bus.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>This feature is targetted mostly=
 towards Windows VMs. It is useful in cases</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>where some hypervisor admins wan=
t to deploy guest VMs in a way so that the</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>users of the guest OSes are not =
able to hot-eject certain PCI devices from</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>the Windows system tray. Laine h=
as explained the use case here in detail:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>https://www.redhat.com/archives/=
libvir-list/2020-=46ebruary/msg00110.html</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Julia has resolved this issue fo=
r PCIE buses with the following commit:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>530a0963184e57e71a5b538 (=22pcie=
=5Froot=5Fport: Add hotplug disabling option=22)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>This commit attempts to introduc=
e similar behavior for PCI root buses used in</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>i440fx machine types (although i=
n this case, we do not have a per-slot</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>capability to turn hotplug on or=
 off).</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Usage:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-global PIIX4=5FPM.acpi-root-pci=
-hotplug=3Doff</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>By default, this option is enabl=
ed which means that hotplug is turned on for</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>the PCI root bus.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>The previously existing flag 'ac=
pi-pci-hotplug-with-bridge-support' for PCI-PCI</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>bridges remain as is and can be =
used along with this new flag to control PCI</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>hotplug on PCI bridges.</blockqu=
ote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>This change has been tested usin=
g a Windows 2012R2 server guest image and also</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>with a Windows 2019 server guest=
 image on a Ubuntu 18.04 host using the latest</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>master qemu from upstream.</bloc=
kquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Signed-off-by: Ani Sinha &lt;ani=
=40anisinha.ca&gt;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Message-Id: &lt;20200821165403.2=
6589-1-ani=40anisinha.ca&gt;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Reviewed-by: Michael S. Tsirkin =
&lt;mst=40redhat.com&gt;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Signed-off-by: Michael S. Tsirki=
n &lt;mst=40redhat.com&gt;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Tested-by: Igor Mammedov &lt;ima=
mmedo=40redhat.com&gt;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Reviewed-by: Igor Mammedov &lt;i=
mammedo=40redhat.com&gt;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>A glitch in scripts=3F</blockquo=
te>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>I didn't review nor tested this =
(v8) version</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>oops=21 I am so eager to get thi=
s done and dusted :)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>it's merged now,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Wait it merged without your revi=
ew=3F</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Yeah, not only added into the pu=
ll request, but actually merged.</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>can you add a test case for it p=
lease=3F</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>You can use test=5Facpi=5Fpiix4=5F=
tcg=5Fbridge() as model.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>See header comment at the top of=
 bios-tables-test.c</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>for how to prepare and submit te=
stcase.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Will get on it.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Also, while the whole approach s=
eems good to me, it leaves the hotplug</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>registers initialized (see build=
=5Fpiix4=5Fpci=5Fhotplug()), even if both</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>root and bridges hotplug are dis=
abled. Which you can exploit by</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>writing something like this to t=
he io registers:</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>outl 0xae10 0</blockquote>
<div dir=3D=22auto=22><br />
You=E2=80=99re setting bsel 0 with this line correct=3F<br /></div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>outl 0xae08 your=5Fslot</blockqu=
ote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>And because of these quite inter=
esting lines the device will be</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>successfully unplugged:</blockqu=
ote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>static PCIBus *acpi=5Fpcihp=5Ffi=
nd=5Fhotplug=5Fbus(AcpiPciHpState *s, int bsel)</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7B</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>...</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>/* Make bsel 0 eject root bus if=
 bsel property is not set,</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>* for compatibility with non acp=
i setups.</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>* TODO: really needed=3F</blockq=
uote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>*/</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>if (=21bsel &amp;&amp; =21find.b=
us) =7B</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>find.bus =3D s-&gt;root;</blockq=
uote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>return find.bus;</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Could you please cover both issu=
es in the follow-up patches=3F</blockquote>
<div dir=3D=22auto=22><br />
Can you please explain what do you mean by both issues=3F The unit test i=
ssue and leaving the registers initialized=3F<br />
<br /></div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Best regards, Julia Suvorova.</b=
lockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>---</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>include/hw/acpi/pcihp.h =7C 2 +-=
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>hw/acpi/pcihp.c =7C 23 +++++++++=
+++++++++++++-</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>hw/acpi/piix4.c =7C 5 ++++-</blo=
ckquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>3 files changed, 27 insertions(+=
), 3 deletions(-)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>diff --git a/include/hw/acpi/pci=
hp.h b/include/hw/acpi/pcihp.h</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>index 8bc4a4c01d..02f4665767 100=
644</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--- a/include/hw/acpi/pcihp.h</b=
lockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+++ b/include/hw/acpi/pcihp.h</b=
lockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -67,7 +67,7 =40=40 void a=
cpi=5Fpcihp=5Fdevice=5Funplug=5Frequest=5Fcb(HotplugHandler *hotplug=5Fde=
v,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Error **errp);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>/* Called on reset */</blockquot=
e>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-void acpi=5Fpcihp=5Freset(AcpiP=
ciHpState *s);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+void acpi=5Fpcihp=5Freset(AcpiP=
ciHpState *s, bool acpihp=5Froot=5Foff);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>extern const VMStateDescription =
vmstate=5Facpi=5Fpcihp=5Fpci=5Fstatus;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>diff --git a/hw/acpi/pcihp.c b/h=
w/acpi/pcihp.c</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>index 9e31ab2da4..39b1f74442 100=
644</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--- a/hw/acpi/pcihp.c</blockquot=
e>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+++ b/hw/acpi/pcihp.c</blockquot=
e>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -104,6 +104,24 =40=40 sta=
tic void acpi=5Fset=5Fpci=5Finfo(void)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+static void acpi=5Fpcihp=5Fdisa=
ble=5Froot=5Fbus(void)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+=7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ static bool root=5Fhp=5Fdisabl=
ed;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ PCIBus *bus;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ if (root=5Fhp=5Fdisabled) =7B<=
/blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ return;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ =7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ bus =3D find=5Fi440fx();</bloc=
kquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ if (bus) =7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ /* setting the hotplug handler=
 to NULL makes the bus non-hotpluggable */</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ qbus=5Fset=5Fhotplug=5Fhandler=
(BUS(bus), NULL);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ =7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ root=5Fhp=5Fdisabled =3D true;=
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ return;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>static void acpi=5Fpcihp=5Ftest=5F=
hotplug=5Fbus(PCIBus *bus, void *opaque)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>AcpiPciHp=46ind *find =3D opaque=
;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -209,8 +227,11 =40=40 sta=
tic void acpi=5Fpcihp=5Fupdate(AcpiPciHpState *s)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-void acpi=5Fpcihp=5Freset(AcpiP=
ciHpState *s)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+void acpi=5Fpcihp=5Freset(AcpiP=
ciHpState *s, bool acpihp=5Froot=5Foff)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ if (acpihp=5Froot=5Foff) =7B</=
blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ acpi=5Fpcihp=5Fdisable=5Froot=5F=
bus();</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ =7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>acpi=5Fset=5Fpci=5Finfo();</bloc=
kquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>acpi=5Fpcihp=5Fupdate(s);</block=
quote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>diff --git a/hw/acpi/piix4.c b/h=
w/acpi/piix4.c</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>index 26bac4f16c..e6163bb6ce 100=
644</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--- a/hw/acpi/piix4.c</blockquot=
e>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+++ b/hw/acpi/piix4.c</blockquot=
e>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -78,6 +78,7 =40=40 typede=
f struct PIIX4PMState =7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>AcpiPciHpState acpi=5Fpci=5Fhotp=
lug;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>bool use=5Facpi=5Fhotplug=5Fbrid=
ge;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ bool use=5Facpi=5Froot=5Fpci=5F=
hotplug;</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>uint8=5Ft disable=5Fs3;</blockqu=
ote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>uint8=5Ft disable=5Fs4;</blockqu=
ote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -324,7 +325,7 =40=40 stat=
ic void piix4=5Fpm=5Freset(DeviceState *dev)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>pci=5Fconf=5B0x5B=5D =3D 0x02;</=
blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>pm=5Fio=5Fspace=5Fupdate(s);</bl=
ockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>- acpi=5Fpcihp=5Freset(&amp;s-&g=
t;acpi=5Fpci=5Fhotplug);</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ acpi=5Fpcihp=5Freset(&amp;s-&g=
t;acpi=5Fpci=5Fhotplug, =21s-&gt;use=5Facpi=5Froot=5Fpci=5Fhotplug);</blo=
ckquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>static void piix4=5Fpm=5Fpowerdo=
wn=5Freq(Notifier *n, void *opaque)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -635,6 +636,8 =40=40 stat=
ic Property piix4=5Fpm=5Fproperties=5B=5D =3D =7B</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FUINT8(ACPI=5FP=
M=5FPROP=5FS4=5FVAL, PIIX4PMState, s4=5Fval, 2),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FBOOL(=22acpi-p=
ci-hotplug-with-bridge-support=22, PIIX4PMState,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>use=5Facpi=5Fhotplug=5Fbridge, t=
rue),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ DE=46INE=5FPROP=5FBOOL(=22acpi=
-root-pci-hotplug=22, PIIX4PMState,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ use=5Facpi=5Froot=5Fpci=5Fhotp=
lug, true),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FBOOL(=22memory=
-hotplug-support=22, PIIX4PMState,</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>acpi=5Fmemory=5Fhotplug.is=5Fena=
bled, true),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FEND=5FO=46=5FL=
IST(),</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</div>
</body>
</html>

--5f490385_5bd062c2_239--


