Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FCAC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145B02085B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="0x0rVgto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145B02085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTU8k-0004TC-1n
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:35:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani@anisinha.ca>) id 1jTSuy-0004Hm-RD
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani@anisinha.ca>) id 1jTSux-0007o6-SV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:17:08 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1jTSnc-0007Lp-A9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:09:32 -0400
Received: by mail-pl1-x641.google.com with SMTP id c21so7725171plz.4
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 09:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=FJ3+Ug7hDAqmoK/FB9ROTbAl4WWzo5IRwSTEqGWK8ww=;
 b=0x0rVgtoiB6PspnWyPG8mU5S7N3OZm6d/fowvUlz7X9lmkcsYMg+rP18+GS3Hm0GkV
 W4IynNIQsAiWTk4CWv84xbya+aRBjZangLSA9sWOXZq24kk5UCbFaHHalB0Ddy5wGdBM
 MHq1m6RCxa4AyCPdemKX2I2/0NTA81F6vn8PPdENO9TR2gD9GkzuiSq8jDIs24umebIo
 oIDyF9DBxbVr9KOLkvm14NKjDmeMzma1HCOqqzX26vMFM+waMGERullIq6PewIG9vMpx
 vd8SroaMwhozue6DMV4ZaUaHc1CbNNzU40/SgDl1OEhfk48iedUsFkYitQ/CZio1CZHl
 tj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=FJ3+Ug7hDAqmoK/FB9ROTbAl4WWzo5IRwSTEqGWK8ww=;
 b=PQbWvI79jcUgtgj9F7xKkukfa8lXN8YlvgEO8MX6/izUIX6VBysnomVIDTzUkBMV2T
 Q9o12Ymk8C9Tu52uvFGupKDA4xkJQpiw1ANClEO8J870WbgxsdBUIKJyTQAFETTB+HQR
 7G9SLIZiqpaFJwO+QzEmd1bxur5p8c16+lRWzTYHv4j6gIR6dGAUryWtonJ0+aKNaBYD
 TsaMta5DePhie0xB3k7mmJ41mFEOX26WNUBIhUmapCQmSnXjCI7Y813v9/egX6YdigsR
 FFqvFl505FHhE/pIaAevFzgaJCszrWNrweBclhx/l2AhHjN0KkcxWF9W0uXrm4pNaikO
 EcfA==
X-Gm-Message-State: AGi0PubbZgX6jS3NQPl+Bv1zf+upmfB69DH3sGo06M2Kfw9Z4WIqyLHG
 vY6bvysTia1b+iSdvl6TgFwOcA==
X-Google-Smtp-Source: APiQypLjmDFQgsruiIKd6X2D16isNrQy3WH3qAtpLxFawmb+cX6HTt7r6IXGaW4daTQFI5kmv5WsOQ==
X-Received: by 2002:a17:902:561:: with SMTP id
 88mr30272367plf.78.1588090170404; 
 Tue, 28 Apr 2020 09:09:30 -0700 (PDT)
Received: from [192.168.1.3] ([115.96.144.150])
 by smtp.gmail.com with ESMTPSA id z1sm2493759pjn.43.2020.04.28.09.09.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Apr 2020 09:09:29 -0700 (PDT)
Date: Tue, 28 Apr 2020 21:39:16 +0530
From: Ani Sinha <ani@anisinha.ca>
To: Ani Sinha <ani.sinha@nutanix.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Message-ID: <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
In-Reply-To: <20200428120426-mutt-send-email-mst@kernel.org>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200428120426-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot
 unplugging of devices on non-root buses
X-Readdle-Message-ID: 67e481a5-de04-4e01-b9ec-70932194d69f@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5ea85532_327b23c6_434b"
Received-SPF: none client-ip=2607:f8b0:4864:20::641;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
X-Mailman-Approved-At: Tue, 28 Apr 2020 13:34:12 -0400
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5ea85532_327b23c6_434b
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Ani
On Apr 28, 2020, 21:35 +0530, Michael S. Tsirkin <mst=40redhat.com>, wrot=
e:
> On Tue, Apr 28, 2020 at 10:16:52AM +0000, Ani Sinha wrote:
> > A new option =22use=5Facpi=5Funplug=22 is introduced for PIIX which w=
ill
> > selectively only disable hot unplugging of both hot plugged and
> > cold plugged PCI devices on non-root PCI buses. This will prevent
> > hot unplugging of devices from Windows based guests from system
> > tray but will not prevent devices from being hot plugged into the
> > guest.
> >
> > It has been tested on Windows guests.
> >
> > Signed-off-by: Ani Sinha <ani.sinha=40nutanix.com>
>
> It's still a non starter until we find something similar for PCIE and
> SHPC. Do guests check command status=3F Can some unplug commands fail=3F=


Ok I =C2=A0give up=21 I thought we debated this on the other thread.

>
>
> > ---
> > hw/acpi/piix4.c =7C 3 +++
> > hw/i386/acpi-build.c =7C 40 ++++++++++++++++++++++++++--------------
> > 2 files changed, 29 insertions(+), 14 deletions(-)
> >
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index 964d6f5..59fa707 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > =40=40 -78,6 +78,7 =40=40 typedef struct PIIX4PMState =7B
> >
> > AcpiPciHpState acpi=5Fpci=5Fhotplug;
> > bool use=5Facpi=5Fpci=5Fhotplug;
> > + bool use=5Facpi=5Funplug;
> >
> > uint8=5Ft disable=5Fs3;
> > uint8=5Ft disable=5Fs4;
> > =40=40 -633,6 +634,8 =40=40 static Property piix4=5Fpm=5Fproperties=5B=
=5D =3D =7B
> > DE=46INE=5FPROP=5FUINT8(ACPI=5FPM=5FPROP=5FS4=5FVAL, PIIX4PMState, s4=
=5Fval, 2),
> > DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotplug-with-bridge-support=22, PI=
IX4PMState,
> > use=5Facpi=5Fpci=5Fhotplug, true),
> > + DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotunplug-enable-bridge=22, PIIX=
4PMState,
> > + use=5Facpi=5Funplug, true),
> > DE=46INE=5FPROP=5FBOOL(=22memory-hotplug-support=22, PIIX4PMState,
> > acpi=5Fmemory=5Fhotplug.is=5Fenabled, true),
> > DE=46INE=5FPROP=5FEND=5FO=46=5FLIST(),
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 23c77ee..71b3ac3 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > =40=40 -96,6 +96,7 =40=40 typedef struct AcpiPmInfo =7B
> > bool s3=5Fdisabled;
> > bool s4=5Fdisabled;
> > bool pcihp=5Fbridge=5Fen;
> > + bool pcihup=5Fbridge=5Fen;
> > uint8=5Ft s4=5Fval;
> > Acpi=46adtData fadt;
> > uint16=5Ft cpu=5Fhp=5Fio=5Fbase;
> > =40=40 -240,6 +241,9 =40=40 static void acpi=5Fget=5Fpm=5Finfo(Machin=
eState *machine, AcpiPmInfo *pm)
> > pm->pcihp=5Fbridge=5Fen =3D
> > object=5Fproperty=5Fget=5Fbool(obj, =22acpi-pci-hotplug-with-bridge-s=
upport=22,
> > NULL);
> > + pm->pcihup=5Fbridge=5Fen =3D
> > + object=5Fproperty=5Fget=5Fbool(obj, =22acpi-pci-hotunplug-enable-br=
idge=22,
> > + NULL);
> > =7D
> >
> > static void acpi=5Fget=5Fmisc=5Finfo(AcpiMiscInfo *info)
> > =40=40 -451,7 +455,8 =40=40 static void build=5Fappend=5Fpcihp=5Fnoti=
fy=5Fentry(Aml *method, int slot)
> > =7D
> >
> > static void build=5Fappend=5Fpci=5Fbus=5Fdevices(Aml *parent=5Fscope,=
 PCIBus *bus,
> > - bool pcihp=5Fbridge=5Fen)
> > + bool pcihp=5Fbridge=5Fen,
> > + bool pcihup=5Fbridge=5Fen)
> > =7B
> > Aml *dev, *notify=5Fmethod =3D NULL, *method;
> > QObject *bsel;
> > =40=40 -479,11 +484,14 =40=40 static void build=5Fappend=5Fpci=5Fbus=5F=
devices(Aml *parent=5Fscope, PCIBus *bus,
> > dev =3D aml=5Fdevice(=22S%.02X=22, PCI=5FDEV=46N(slot, 0));
> > aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FSUN=22, aml=5Fint(slot)));
> > aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FADR=22, aml=5Fint(slot << 1=
6)));
> > - method =3D aml=5Fmethod(=22=5FEJ0=22, 1, AML=5FNOTSERIALIZED);
> > - aml=5Fappend(method,
> > - aml=5Fcall2(=22PCEJ=22, aml=5Fname(=22BSEL=22), aml=5Fname(=22=5FSU=
N=22))
> > - );
> > - aml=5Fappend(dev, method);
> > + if (pcihup=5Fbridge=5Fen =7C=7C pci=5Fbus=5Fis=5Froot(bus)) =7B
> > + method =3D aml=5Fmethod(=22=5FEJ0=22, 1, AML=5FNOTSERIALIZED);
> > + aml=5Fappend(method,
> > + aml=5Fcall2(=22PCEJ=22, aml=5Fname(=22BSEL=22),
> > + aml=5Fname(=22=5FSUN=22))
> > + );
> > + aml=5Fappend(dev, method);
> > + =7D
> > aml=5Fappend(parent=5Fscope, dev);
> >
> > build=5Fappend=5Fpcihp=5Fnotify=5Fentry(notify=5Fmethod, slot);
> > =40=40 -537,12 +545,14 =40=40 static void build=5Fappend=5Fpci=5Fbus=5F=
devices(Aml *parent=5Fscope, PCIBus *bus,
> > /* add =5FSUN/=5FEJ0 to make slot hotpluggable */
> > aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FSUN=22, aml=5Fint(slot)));
> >
> > - method =3D aml=5Fmethod(=22=5FEJ0=22, 1, AML=5FNOTSERIALIZED);
> > - aml=5Fappend(method,
> > - aml=5Fcall2(=22PCEJ=22, aml=5Fname(=22BSEL=22), aml=5Fname(=22=5FSU=
N=22))
> > - );
> > - aml=5Fappend(dev, method);
> > -
> > + if (pcihup=5Fbridge=5Fen =7C=7C pci=5Fbus=5Fis=5Froot(bus)) =7B
> > + method =3D aml=5Fmethod(=22=5FEJ0=22, 1, AML=5FNOTSERIALIZED);
> > + aml=5Fappend(method,
> > + aml=5Fcall2(=22PCEJ=22, aml=5Fname(=22BSEL=22),
> > + aml=5Fname(=22=5FSUN=22))
> > + );
> > + aml=5Fappend(dev, method);
> > + =7D
> > if (bsel) =7B
> > build=5Fappend=5Fpcihp=5Fnotify=5Fentry(notify=5Fmethod, slot);
> > =7D
> > =40=40 -553,7 +563,8 =40=40 static void build=5Fappend=5Fpci=5Fbus=5F=
devices(Aml *parent=5Fscope, PCIBus *bus,
> > */
> > PCIBus *sec=5Fbus =3D pci=5Fbridge=5Fget=5Fsec=5Fbus(PCI=5FBRIDGE(pde=
v));
> >
> > - build=5Fappend=5Fpci=5Fbus=5Fdevices(dev, sec=5Fbus, pcihp=5Fbridge=
=5Fen);
> > + build=5Fappend=5Fpci=5Fbus=5Fdevices(dev, sec=5Fbus, pcihp=5Fbridge=
=5Fen,
> > + pcihup=5Fbridge=5Fen);
> > =7D
> > /* slot descriptor has been composed, add it into parent context */
> > aml=5Fappend(parent=5Fscope, dev);
> > =40=40 -2196,7 +2207,8 =40=40 build=5Fdsdt(GArray *table=5Fdata, BIOS=
Linker *linker,
> > if (bus) =7B
> > Aml *scope =3D aml=5Fscope(=22PCI0=22);
> > /* Scan all PCI buses. Generate tables to support hotplug. */
> > - build=5Fappend=5Fpci=5Fbus=5Fdevices(scope, bus, pm->pcihp=5Fbridge=
=5Fen);
> > + build=5Fappend=5Fpci=5Fbus=5Fdevices(scope, bus, pm->pcihp=5Fbridge=
=5Fen,
> > + pm->pcihup=5Fbridge=5Fen);
> >
> > if (TPM=5FIS=5FTIS=5FISA(tpm)) =7B
> > if (misc->tpm=5Fversion =3D=3D TPM=5FVERSION=5F2=5F0) =7B
> > --
> > 1.9.4
>

--5ea85532_327b23c6_434b
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageSignatureSection=22><br />
<div dir=3D=22auto=22>Ani</div>
</div>
<div name=3D=22messageReplySection=22>On Apr 28, 2020, 21:35 +0530, Micha=
el S. Tsirkin &lt;mst=40redhat.com&gt;, wrote:<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =231abc9c;=22>On=
 Tue, Apr 28, 2020 at 10:16:52AM +0000, Ani Sinha wrote:<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =23e67e22;=22>A =
new option =22use=5Facpi=5Funplug=22 is introduced for PIIX which will<br=
 />
selectively only disable hot unplugging of both hot plugged and<br />
cold plugged PCI devices on non-root PCI buses. This will prevent<br />
hot unplugging of devices from Windows based guests from system<br />
tray but will not prevent devices from being hot plugged into the<br />
guest.<br />
<br />
It has been tested on Windows guests.<br />
<br />
Signed-off-by: Ani Sinha &lt;ani.sinha=40nutanix.com&gt;<br /></blockquot=
e>
<br />
It's still a non starter until we find something similar for PCIE and<br =
/>
SHPC. Do guests check command status=3F Can some unplug commands fail=3F&=
=23160;<br /></blockquote>
<div><br /></div>
<div dir=3D=22auto=22>Ok I &=23160;give up=21 I thought we debated this o=
n the other thread.</div>
<div dir=3D=22auto=22><br /></div>
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =231abc9c;=22><b=
r />
<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =23e67e22;=22>--=
-<br />
hw/acpi/piix4.c =7C 3 +++<br />
hw/i386/acpi-build.c =7C 40 ++++++++++++++++++++++++++--------------<br /=
>
2 files changed, 29 insertions(+), 14 deletions(-)<br />
<br />
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c<br />
index 964d6f5..59fa707 100644<br />
--- a/hw/acpi/piix4.c<br />
+++ b/hw/acpi/piix4.c<br />
=40=40 -78,6 +78,7 =40=40 typedef struct PIIX4PMState =7B<br />
<br />
AcpiPciHpState acpi=5Fpci=5Fhotplug;<br />
bool use=5Facpi=5Fpci=5Fhotplug;<br />
+ bool use=5Facpi=5Funplug;<br />
<br />
uint8=5Ft disable=5Fs3;<br />
uint8=5Ft disable=5Fs4;<br />
=40=40 -633,6 +634,8 =40=40 static Property piix4=5Fpm=5Fproperties=5B=5D=
 =3D =7B<br />
DE=46INE=5FPROP=5FUINT8(ACPI=5FPM=5FPROP=5FS4=5FVAL, PIIX4PMState, s4=5Fv=
al, 2),<br />
DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotplug-with-bridge-support=22, PIIX4P=
MState,<br />
use=5Facpi=5Fpci=5Fhotplug, true),<br />
+ DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotunplug-enable-bridge=22, PIIX4PMS=
tate,<br />
+ use=5Facpi=5Funplug, true),<br />
DE=46INE=5FPROP=5FBOOL(=22memory-hotplug-support=22, PIIX4PMState,<br />
acpi=5Fmemory=5Fhotplug.is=5Fenabled, true),<br />
DE=46INE=5FPROP=5FEND=5FO=46=5FLIST(),<br />
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c<br />
index 23c77ee..71b3ac3 100644<br />
--- a/hw/i386/acpi-build.c<br />
+++ b/hw/i386/acpi-build.c<br />
=40=40 -96,6 +96,7 =40=40 typedef struct AcpiPmInfo =7B<br />
bool s3=5Fdisabled;<br />
bool s4=5Fdisabled;<br />
bool pcihp=5Fbridge=5Fen;<br />
+ bool pcihup=5Fbridge=5Fen;<br />
uint8=5Ft s4=5Fval;<br />
Acpi=46adtData fadt;<br />
uint16=5Ft cpu=5Fhp=5Fio=5Fbase;<br />
=40=40 -240,6 +241,9 =40=40 static void acpi=5Fget=5Fpm=5Finfo(MachineSta=
te *machine, AcpiPmInfo *pm)<br />
pm-&gt;pcihp=5Fbridge=5Fen =3D<br />
object=5Fproperty=5Fget=5Fbool(obj, =22acpi-pci-hotplug-with-bridge-suppo=
rt=22,<br />
NULL);<br />
+ pm-&gt;pcihup=5Fbridge=5Fen =3D<br />
+ object=5Fproperty=5Fget=5Fbool(obj, =22acpi-pci-hotunplug-enable-bridge=
=22,<br />
+ NULL);<br />
=7D<br />
<br />
static void acpi=5Fget=5Fmisc=5Finfo(AcpiMiscInfo *info)<br />
=40=40 -451,7 +455,8 =40=40 static void build=5Fappend=5Fpcihp=5Fnotify=5F=
entry(Aml *method, int slot)<br />
=7D<br />
<br />
static void build=5Fappend=5Fpci=5Fbus=5Fdevices(Aml *parent=5Fscope, PCI=
Bus *bus,<br />
- bool pcihp=5Fbridge=5Fen)<br />
+ bool pcihp=5Fbridge=5Fen,<br />
+ bool pcihup=5Fbridge=5Fen)<br />
=7B<br />
Aml *dev, *notify=5Fmethod =3D NULL, *method;<br />
QObject *bsel;<br />
=40=40 -479,11 +484,14 =40=40 static void build=5Fappend=5Fpci=5Fbus=5Fde=
vices(Aml *parent=5Fscope, PCIBus *bus,<br />
dev =3D aml=5Fdevice(=22S%.02X=22, PCI=5FDEV=46N(slot, 0));<br />
aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FSUN=22, aml=5Fint(slot)));<br /=
>
aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FADR=22, aml=5Fint(slot &lt;&lt;=
 16)));<br />
- method =3D aml=5Fmethod(=22=5FEJ0=22, 1, AML=5FNOTSERIALIZED);<br />
- aml=5Fappend(method,<br />
- aml=5Fcall2(=22PCEJ=22, aml=5Fname(=22BSEL=22), aml=5Fname(=22=5FSUN=22=
))<br />
- );<br />
- aml=5Fappend(dev, method);<br />
+ if (pcihup=5Fbridge=5Fen =7C=7C pci=5Fbus=5Fis=5Froot(bus)) =7B<br />
+ method =3D aml=5Fmethod(=22=5FEJ0=22, 1, AML=5FNOTSERIALIZED);<br />
+ aml=5Fappend(method,<br />
+ aml=5Fcall2(=22PCEJ=22, aml=5Fname(=22BSEL=22),<br />
+ aml=5Fname(=22=5FSUN=22))<br />
+ );<br />
+ aml=5Fappend(dev, method);<br />
+ =7D<br />
aml=5Fappend(parent=5Fscope, dev);<br />
<br />
build=5Fappend=5Fpcihp=5Fnotify=5Fentry(notify=5Fmethod, slot);<br />
=40=40 -537,12 +545,14 =40=40 static void build=5Fappend=5Fpci=5Fbus=5Fde=
vices(Aml *parent=5Fscope, PCIBus *bus,<br />
/* add =5FSUN/=5FEJ0 to make slot hotpluggable */<br />
aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FSUN=22, aml=5Fint(slot)));<br /=
>
<br />
- method =3D aml=5Fmethod(=22=5FEJ0=22, 1, AML=5FNOTSERIALIZED);<br />
- aml=5Fappend(method,<br />
- aml=5Fcall2(=22PCEJ=22, aml=5Fname(=22BSEL=22), aml=5Fname(=22=5FSUN=22=
))<br />
- );<br />
- aml=5Fappend(dev, method);<br />
-<br />
+ if (pcihup=5Fbridge=5Fen =7C=7C pci=5Fbus=5Fis=5Froot(bus)) =7B<br />
+ method =3D aml=5Fmethod(=22=5FEJ0=22, 1, AML=5FNOTSERIALIZED);<br />
+ aml=5Fappend(method,<br />
+ aml=5Fcall2(=22PCEJ=22, aml=5Fname(=22BSEL=22),<br />
+ aml=5Fname(=22=5FSUN=22))<br />
+ );<br />
+ aml=5Fappend(dev, method);<br />
+ =7D<br />
if (bsel) =7B<br />
build=5Fappend=5Fpcihp=5Fnotify=5Fentry(notify=5Fmethod, slot);<br />
=7D<br />
=40=40 -553,7 +563,8 =40=40 static void build=5Fappend=5Fpci=5Fbus=5Fdevi=
ces(Aml *parent=5Fscope, PCIBus *bus,<br />
*/<br />
PCIBus *sec=5Fbus =3D pci=5Fbridge=5Fget=5Fsec=5Fbus(PCI=5FBRIDGE(pdev));=
<br />
<br />
- build=5Fappend=5Fpci=5Fbus=5Fdevices(dev, sec=5Fbus, pcihp=5Fbridge=5Fe=
n);<br />
+ build=5Fappend=5Fpci=5Fbus=5Fdevices(dev, sec=5Fbus, pcihp=5Fbridge=5Fe=
n,<br />
+ pcihup=5Fbridge=5Fen);<br />
=7D<br />
/* slot descriptor has been composed, add it into parent context */<br />=

aml=5Fappend(parent=5Fscope, dev);<br />
=40=40 -2196,7 +2207,8 =40=40 build=5Fdsdt(GArray *table=5Fdata, BIOSLink=
er *linker,<br />
if (bus) =7B<br />
Aml *scope =3D aml=5Fscope(=22PCI0=22);<br />
/* Scan all PCI buses. Generate tables to support hotplug. */<br />
- build=5Fappend=5Fpci=5Fbus=5Fdevices(scope, bus, pm-&gt;pcihp=5Fbridge=5F=
en);<br />
+ build=5Fappend=5Fpci=5Fbus=5Fdevices(scope, bus, pm-&gt;pcihp=5Fbridge=5F=
en,<br />
+ pm-&gt;pcihup=5Fbridge=5Fen);<br />
<br />
if (TPM=5FIS=5FTIS=5FISA(tpm)) =7B<br />
if (misc-&gt;tpm=5Fversion =3D=3D TPM=5FVERSION=5F2=5F0) =7B<br />
--<br />
1.9.4<br /></blockquote>
<br /></blockquote>
</div>
</body>
</html>

--5ea85532_327b23c6_434b--


