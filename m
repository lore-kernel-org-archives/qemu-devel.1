Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D084C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FA420789
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="f4+bU+yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FA420789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7z8z-0000zj-KQ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k7z88-0000Ov-28
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:46:12 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k7z85-0003zf-HQ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:46:11 -0400
Received: by mail-pg1-x543.google.com with SMTP id h12so9565990pgm.7
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=yM0j1r1stRIJfpQt5hOHE+RVaivKRtLEbmCBoJY3CaE=;
 b=f4+bU+yjAozdzVBQ748sIk1lsa+BuhEVy8zLFEqopoRII31FYYK+rAxHSKVuPpXhcv
 F0EmYs+YLrYKoiXFOf1uZGhpzvk3iij7uR2V1VRcbMn5Ax1X4uyhnKsmVnLBGlhSVkCo
 55jUYSgyyytpyfnEbAU6OEhcoX9RCWrjRvHVzUKjR85ZVcdy/XFVjRjESv0DTGIifrOQ
 UXbhnQqiTBY449d16Vp1LxMJRCZKWgxEbmk7KKX+AnM5+OsV6hhhSquShvT+I2unHIcP
 qffcR0O4cQ45/SyOThhvliuWs4+RonQ/3L2njU5SSIh2PGr86CP5Z3ivWwyJ8MdhBCZg
 3CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=yM0j1r1stRIJfpQt5hOHE+RVaivKRtLEbmCBoJY3CaE=;
 b=sBjy13UW/wuco8443uTAFpXi+3wxTQf0bAdMKxkcTz1ZvtOXeB/aPCHRETtd9qQcwa
 72yIJrgWhpKNnFH0DU4vx4wNTMLQpUK813FoV4Q0clmZYZNVLr48hnwsLMLBpqA/19rx
 M+d7rEC9wkZMo/5LI8IJm5I0lp1M9IA6+UP3i0wCVZwcjRb3XwxGFNfLNTF9/hFR0mje
 Y3y40cWOg6aRL7/szPZwvJsm9gbj8YEhZg+KO9Isvdj0o42GxqeAQcdByHNKO088BMW1
 o6dLtEANaJO6TEIEAbLl0/yq39MdCAWH30jUjzLGEWxNshTX6g953VpElXxitxYtf3zW
 446Q==
X-Gm-Message-State: AOAM530ZInpI+9fIR7Zb60ZEeZnP1NphWg2w6dq2WK/BkQhonye7lkkw
 OKUkQ8dA+Dg9rvAD0Q152QJcHw==
X-Google-Smtp-Source: ABdhPJxSHRHNAC85Yd3YYKx1Khc1N//UwmIZfIsmCeXaYdgTcGAhEwSLFvVnMchpsX6h5kgkEzKSzg==
X-Received: by 2002:a63:2202:: with SMTP id i2mr12425341pgi.177.1597747567886; 
 Tue, 18 Aug 2020 03:46:07 -0700 (PDT)
Received: from [192.168.1.2] ([116.72.129.57])
 by smtp.gmail.com with ESMTPSA id 12sm23691158pfn.173.2020.08.18.03.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 03:46:07 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-C0D05729-183A-4DC2-B08D-74D7A4C5B2D0
Content-Transfer-Encoding: 7bit
From: Ani Sinha <ani@anisinha.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V2] Introduce a new flag for piix to disable root bus PCI
 hotplug
Date: Tue, 18 Aug 2020 16:16:03 +0530
Message-Id: <27C27549-F4D4-4F42-AB42-AF84B4110CF0@anisinha.ca>
References: <CAARzgwzk4i_PD_Emkj-TjgAFt3y=XmodeOfc2DzPXhcg_NK9bA@mail.gmail.com>
In-Reply-To: <CAARzgwzk4i_PD_Emkj-TjgAFt3y=XmodeOfc2DzPXhcg_NK9bA@mail.gmail.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: iPad Mail (17G68)
Received-SPF: none client-ip=2607:f8b0:4864:20::543;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, MIME_QP_LONG_LINE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail-C0D05729-183A-4DC2-B08D-74D7A4C5B2D0
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable



> On Aug 18, 2020, at 3:49 PM, Ani Sinha <ani@anisinha.ca> wrote:
>=20
> =EF=BB=BF
> This is not a workaround, this is a feature we need badly. We have discuss=
ed this at length. Igor suggested we have one additional global flag to disa=
ble all pci hotplug. But then that leads to strange case when pci hotplug on=
 the bridges are enabled (we have a separate flag for that). Hence, I think w=
e can simply add another flag to disable hotplug just for the pci root bus.=20=


Relevant thread: https://www.mail-archive.com/qemu-devel@nongnu.org/msg72907=
2.html


>> On Tue, Aug 18, 2020 at 3:46 PM Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>> Hi,
>>=20
>>=20
>>=20
>> On 8/18/20 11:54 AM, Ani Sinha wrote:
>>=20
>> > Igor etc, I just tested this patch using a Windows 2012 R2 image and
>>=20
>> > it seems to be working. Any feedbacks on this patch?
>>=20
>> >=20
>>=20
>> > On Tue, Aug 11, 2020 at 6:42 PM Ani Sinha <ani@anisinha.ca> wrote:
>>=20
>> >>
>>=20
>> >> We introduce a new global flag for PIIX with which we can turn on or o=
ff PCI
>>=20
>> >> device hotplug on the root bus. This flag can be used to prevent all P=
CI
>>=20
>> >> devices from getting hotplugged or unplugged from the root PCI bus.
>>=20
>> >>
>>=20
>> >> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>>=20
>> >> ---
>>=20
>> >>  hw/acpi/piix4.c      |  3 +++
>>=20
>> >>  hw/i386/acpi-build.c | 20 ++++++++++++++++----
>>=20
>> >>  2 files changed, 19 insertions(+), 4 deletions(-)
>>=20
>> >>
>>=20
>> >> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>>=20
>> >> index 26bac4f..94ec35a 100644
>>=20
>> >> --- a/hw/acpi/piix4.c
>>=20
>> >> +++ b/hw/acpi/piix4.c
>>=20
>> >> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>>=20
>> >>
>>=20
>> >>      AcpiPciHpState acpi_pci_hotplug;
>>=20
>> >>      bool use_acpi_hotplug_bridge;
>>=20
>> >> +    bool use_acpi_root_pci_hotplug;
>>=20
>> >>
>>=20
>> >>      uint8_t disable_s3;
>>=20
>> >>      uint8_t disable_s4;
>>=20
>> >> @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] =3D {
>>=20
>> >>      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>>=20
>> >>      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMS=
tate,
>>=20
>> >>                       use_acpi_hotplug_bridge, true),
>>=20
>> >> +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
>>=20
>> >> +                     use_acpi_root_pci_hotplug, true),
>>=20
>>=20
>>=20
>> =46rom what I understood here, this file is already pretty twisted
>>=20
>> and Igor doesn't want more workarounds:
>>=20
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg690564.html
>>=20
>>=20
>>=20
>> =C2=AF\_(=E3=83=84)_/=C2=AF
>>=20
>>=20
>>=20
>> >>      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>>=20
>> >>                       acpi_memory_hotplug.is_enabled, true),
>>=20
>> >>      DEFINE_PROP_END_OF_LIST(),
>>=20
>> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>=20
>> >> index b7bcbbb..a82e5c1 100644
>>=20
>> >> --- a/hw/i386/acpi-build.c
>>=20
>> >> +++ b/hw/i386/acpi-build.c
>>=20
>> >> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
>>=20
>> >>      bool s3_disabled;
>>=20
>> >>      bool s4_disabled;
>>=20
>> >>      bool pcihp_bridge_en;
>>=20
>> >> +    bool pcihp_root_en;
>>=20
>> >>      uint8_t s4_val;
>>=20
>> >>      AcpiFadtData fadt;
>>=20
>> >>      uint16_t cpu_hp_io_base;
>>=20
>> >> @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine=
, AcpiPmInfo *pm)
>>=20
>> >>      pm->pcihp_bridge_en =3D
>>=20
>> >>          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-s=
upport",
>>=20
>> >>                                   NULL);
>>=20
>> >> +    pm->pcihp_root_en =3D
>>=20
>> >> +        object_property_get_bool(obj, "acpi-root-pci-hotplug", NULL);=

>>=20
>> >> +
>>=20
>> >>  }
>>=20
>> >>
>>=20
>> >>  static void acpi_get_misc_info(AcpiMiscInfo *info)
>>=20
>> >> @@ -337,12 +341,15 @@ static void build_append_pcihp_notify_entry(Aml *=
method, int slot)
>>=20
>> >>  }
>>=20
>> >>
>>=20
>> >>  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *b=
us,
>>=20
>> >> -                                         bool pcihp_bridge_en)
>>=20
>> >> +                                         bool pcihp_bridge_en,
>>=20
>> >> +                                         bool pcihp_root_en)
>>=20
>> >>  {
>>=20
>> >>      Aml *dev, *notify_method =3D NULL, *method;
>>=20
>> >>      QObject *bsel;
>>=20
>> >>      PCIBus *sec;
>>=20
>> >>      int i;
>>=20
>> >> +    bool root_bus =3D pci_bus_is_root(bus);
>>=20
>> >> +    bool root_pcihp_disabled =3D (root_bus && !pcihp_root_en);
>>=20
>> >>
>>=20
>> >>      bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP=
_BSEL, NULL);
>>=20
>> >>      if (bsel) {
>>=20
>> >> @@ -361,6 +368,9 @@ static void build_append_pci_bus_devices(Aml *pare=
nt_scope, PCIBus *bus,
>>=20
>> >>          bool bridge_in_acpi;
>>=20
>> >>
>>=20
>> >>          if (!pdev) {
>>=20
>> >> +            /* skip if pci hotplug for the root bus is disabled */
>>=20
>> >> +            if (root_pcihp_disabled)
>>=20
>> >> +                continue;
>>=20
>> >>              if (bsel) { /* add hotplug slots for non present devices *=
/
>>=20
>> >>                  dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
>>=20
>> >>                  aml_append(dev, aml_name_decl("_SUN", aml_int(slot)))=
;
>>=20
>> >> @@ -419,7 +429,7 @@ static void build_append_pci_bus_devices(Aml *pare=
nt_scope, PCIBus *bus,
>>=20
>> >>              method =3D aml_method("_S3D", 0, AML_NOTSERIALIZED);
>>=20
>> >>              aml_append(method, aml_return(aml_int(s3d)));
>>=20
>> >>              aml_append(dev, method);
>>=20
>> >> -        } else if (hotplug_enabled_dev) {
>>=20
>> >> +        } else if (hotplug_enabled_dev && !root_pcihp_disabled) {
>>=20
>> >>              /* add _SUN/_EJ0 to make slot hotpluggable  */
>>=20
>> >>              aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>>=20
>> >>
>>=20
>> >> @@ -439,7 +449,8 @@ static void build_append_pci_bus_devices(Aml *pare=
nt_scope, PCIBus *bus,
>>=20
>> >>               */
>>=20
>> >>              PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pde=
v));
>>=20
>> >>
>>=20
>> >> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_e=
n);
>>=20
>> >> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_e=
n,
>>=20
>> >> +                                         pcihp_root_en);
>>=20
>> >>          }
>>=20
>> >>          /* slot descriptor has been composed, add it into parent cont=
ext */
>>=20
>> >>          aml_append(parent_scope, dev);
>>=20
>> >> @@ -1818,7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
r,
>>=20
>> >>          if (bus) {
>>=20
>> >>              Aml *scope =3D aml_scope("PCI0");
>>=20
>> >>              /* Scan all PCI buses. Generate tables to support hotplug=
. */
>>=20
>> >> -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge=
_en);
>>=20
>> >> +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge=
_en,
>>=20
>> >> +                                         pm->pcihp_root_en);
>>=20
>> >>
>>=20
>> >>              if (TPM_IS_TIS_ISA(tpm)) {
>>=20
>> >>                  if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
>>=20
>> >> --
>>=20
>> >> 2.7.4
>>=20
>> >>
>>=20
>> >=20
>>=20
>>=20
>>=20

--Apple-Mail-C0D05729-183A-4DC2-B08D-74D7A4C5B2D0
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div dir=3D"ltr"><br></div><div dir=3D"ltr"=
><br><blockquote type=3D"cite">On Aug 18, 2020, at 3:49 PM, Ani Sinha &lt;an=
i@anisinha.ca&gt; wrote:<br><br></blockquote></div><blockquote type=3D"cite"=
><div dir=3D"ltr">=EF=BB=BF<div><div dir=3D"auto">This is not a workaround, t=
his is a feature we need badly. We have discussed this at length. Igor sugge=
sted we have one additional global flag to disable all pci hotplug. But then=
 that leads to strange case when pci hotplug on the bridges are enabled (we h=
ave a separate flag for that). Hence, I think we can simply add another flag=
 to disable hotplug just for the pci root bus.&nbsp;</div></div></div></bloc=
kquote><div><br></div>Relevant thread:&nbsp;<a href=3D"https://www.mail-arch=
ive.com/qemu-devel@nongnu.org/msg729072.html">https://www.mail-archive.com/q=
emu-devel@nongnu.org/msg729072.html</a><div><br></div><div><br><blockquote t=
ype=3D"cite"><div dir=3D"ltr"><div><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Aug 18, 2020 at 3:46 PM Philippe Mathieu-Dau=
d=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;border=
-left-color:rgb(204,204,204)">Hi,<br><br><br><br>On 8/18/20 11:54 AM, Ani Si=
nha wrote:<br><br>&gt; Igor etc, I just tested this patch using a Windows 20=
12 R2 image and<br><br>&gt; it seems to be working. Any feedbacks on this pa=
tch?<br><br>&gt; <br><br>&gt; On Tue, Aug 11, 2020 at 6:42 PM Ani Sinha &lt;=
<a href=3D"mailto:ani@anisinha.ca" target=3D"_blank">ani@anisinha.ca</a>&gt;=
 wrote:<br><br>&gt;&gt;<br><br>&gt;&gt; We introduce a new global flag for P=
IIX with which we can turn on or off PCI<br><br>&gt;&gt; device hotplug on t=
he root bus. This flag can be used to prevent all PCI<br><br>&gt;&gt; device=
s from getting hotplugged or unplugged from the root PCI bus.<br><br>&gt;&gt=
;<br><br>&gt;&gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:ani@anisinh=
a.ca" target=3D"_blank">ani@anisinha.ca</a>&gt;<br><br>&gt;&gt; ---<br><br>&=
gt;&gt;&nbsp; hw/acpi/piix4.c&nbsp; &nbsp; &nbsp; |&nbsp; 3 +++<br><br>&gt;&=
gt;&nbsp; hw/i386/acpi-build.c | 20 ++++++++++++++++----<br><br>&gt;&gt;&nbs=
p; 2 files changed, 19 insertions(+), 4 deletions(-)<br><br>&gt;&gt;<br><br>=
&gt;&gt; diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c<br><br>&gt;&gt; inde=
x 26bac4f..94ec35a 100644<br><br>&gt;&gt; --- a/hw/acpi/piix4.c<br><br>&gt;&=
gt; +++ b/hw/acpi/piix4.c<br><br>&gt;&gt; @@ -78,6 +78,7 @@ typedef struct P=
IIX4PMState {<br><br>&gt;&gt;<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; AcpiPciHpS=
tate acpi_pci_hotplug;<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; bool use_acpi_hot=
plug_bridge;<br><br>&gt;&gt; +&nbsp; &nbsp; bool use_acpi_root_pci_hotplug;<=
br><br>&gt;&gt;<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; uint8_t disable_s3;<br><=
br>&gt;&gt;&nbsp; &nbsp; &nbsp; uint8_t disable_s4;<br><br>&gt;&gt; @@ -635,=
6 +636,8 @@ static Property piix4_pm_properties[] =3D {<br><br>&gt;&gt;&nbsp=
; &nbsp; &nbsp; DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val,=
 2),<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; DEFINE_PROP_BOOL("acpi-pci-hotplug-=
with-bridge-support", PIIX4PMState,<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;use_acpi_hotplug_b=
ridge, true),<br><br>&gt;&gt; +&nbsp; &nbsp; DEFINE_PROP_BOOL("acpi-root-pci=
-hotplug", PIIX4PMState,<br><br>&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;use_acpi_root_pci_hotplug, true),<=
br><br><br><br>=46rom what I understood here, this file is already pretty tw=
isted<br><br>and Igor doesn't want more workarounds:<br><br><a href=3D"https=
://www.mail-archive.com/qemu-devel@nongnu.org/msg690564.html" rel=3D"norefer=
rer" target=3D"_blank">https://www.mail-archive.com/qemu-devel@nongnu.org/ms=
g690564.html</a><br><br><br><br>=C2=AF\_(=E3=83=84)_/=C2=AF<br><br><br><br>&=
gt;&gt;&nbsp; &nbsp; &nbsp; DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4=
PMState,<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp;acpi_memory_hotplug.is_enabled, true),<br><br=
>&gt;&gt;&nbsp; &nbsp; &nbsp; DEFINE_PROP_END_OF_LIST(),<br><br>&gt;&gt; dif=
f --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c<br><br>&gt;&gt; index b=
7bcbbb..a82e5c1 100644<br><br>&gt;&gt; --- a/hw/i386/acpi-build.c<br><br>&gt=
;&gt; +++ b/hw/i386/acpi-build.c<br><br>&gt;&gt; @@ -95,6 +95,7 @@ typedef s=
truct AcpiPmInfo {<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; bool s3_disabled;<br>=
<br>&gt;&gt;&nbsp; &nbsp; &nbsp; bool s4_disabled;<br><br>&gt;&gt;&nbsp; &nb=
sp; &nbsp; bool pcihp_bridge_en;<br><br>&gt;&gt; +&nbsp; &nbsp; bool pcihp_r=
oot_en;<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; uint8_t s4_val;<br><br>&gt;&gt;&=
nbsp; &nbsp; &nbsp; AcpiFadtData fadt;<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; u=
int16_t cpu_hp_io_base;<br><br>&gt;&gt; @@ -245,6 +246,9 @@ static void acpi=
_get_pm_info(MachineState *machine, AcpiPmInfo *pm)<br><br>&gt;&gt;&nbsp; &n=
bsp; &nbsp; pm-&gt;pcihp_bridge_en =3D<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-sup=
port",<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;NULL)=
;<br><br>&gt;&gt; +&nbsp; &nbsp; pm-&gt;pcihp_root_en =3D<br><br>&gt;&gt; +&=
nbsp; &nbsp; &nbsp; &nbsp; object_property_get_bool(obj, "acpi-root-pci-hotp=
lug", NULL);<br><br>&gt;&gt; +<br><br>&gt;&gt;&nbsp; }<br><br>&gt;&gt;<br><b=
r>&gt;&gt;&nbsp; static void acpi_get_misc_info(AcpiMiscInfo *info)<br><br>&=
gt;&gt; @@ -337,12 +341,15 @@ static void build_append_pcihp_notify_entry(Am=
l *method, int slot)<br><br>&gt;&gt;&nbsp; }<br><br>&gt;&gt;<br><br>&gt;&gt;=
&nbsp; static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *b=
us,<br><br>&gt;&gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp;bool pcihp_bridge_en)<br><br>&gt;&gt; +&nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bool pcihp_bridge_en,<br><br>=
&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp;bool pcihp_root_en)<br><br>&gt;&gt;&nbsp; {<br><br>&gt;&gt;&nbsp; &nbsp;=
 &nbsp; Aml *dev, *notify_method =3D NULL, *method;<br><br>&gt;&gt;&nbsp; &n=
bsp; &nbsp; QObject *bsel;<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; PCIBus *sec;<=
br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; int i;<br><br>&gt;&gt; +&nbsp; &nbsp; bo=
ol root_bus =3D pci_bus_is_root(bus);<br><br>&gt;&gt; +&nbsp; &nbsp; bool ro=
ot_pcihp_disabled =3D (root_bus &amp;&amp; !pcihp_root_en);<br><br>&gt;&gt;<=
br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; bsel =3D object_property_get_qobject(OBJ=
ECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; i=
f (bsel) {<br><br>&gt;&gt; @@ -361,6 +368,9 @@ static void build_append_pci_=
bus_devices(Aml *parent_scope, PCIBus *bus,<br><br>&gt;&gt;&nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; bool bridge_in_acpi;<br><br>&gt;&gt;<br><br>&gt;&gt;&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; if (!pdev) {<br><br>&gt;&gt; +&nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; /* skip if pci hotplug for the root bus is disabled=
 */<br><br>&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (root_pcih=
p_disabled)<br><br>&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; continue;<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; if (bsel) { /* add hotplug slots for non present devices */<br><br>&gt=
;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev =3D a=
ml_device("S%.02X", PCI_DEVFN(slot, 0));<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; aml_append(dev, aml_name_decl("_S=
UN", aml_int(slot)));<br><br>&gt;&gt; @@ -419,7 +429,7 @@ static void build_=
append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,<br><br>&gt;&gt;&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; method =3D aml_method("_S3D", 0, A=
ML_NOTSERIALIZED);<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; aml_append(method, aml_return(aml_int(s3d)));<br><br>&gt;&gt;&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; aml_append(dev, method);<br><br>&gt;=
&gt; -&nbsp; &nbsp; &nbsp; &nbsp; } else if (hotplug_enabled_dev) {<br><br>&=
gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; } else if (hotplug_enabled_dev &amp;&am=
p; !root_pcihp_disabled) {<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; /* add _SUN/_EJ0 to make slot hotpluggable&nbsp; */<br><br>&g=
t;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; aml_append(dev, aml_n=
ame_decl("_SUN", aml_int(slot)));<br><br>&gt;&gt;<br><br>&gt;&gt; @@ -439,7 +=
449,8 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *=
bus,<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*=
/<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PCIBus *se=
c_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));<br><br>&gt;&gt;<br><br>&=
gt;&gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; build_append_pci_bus_devi=
ces(dev, sec_bus, pcihp_bridge_en);<br><br>&gt;&gt; +&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_e=
n,<br><br>&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp;pcihp_root_en);<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; }<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* slot descriptor has=
 been composed, add it into parent context */<br><br>&gt;&gt;&nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; aml_append(parent_scope, dev);<br><br>&gt;&gt; @@ -1818,=
7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,<br><br>&gt;&=
gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (bus) {<br><br>&gt;&gt;&nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Aml *scope =3D aml_scope("PCI0");<br><b=
r>&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Scan all PCI b=
uses. Generate tables to support hotplug. */<br><br>&gt;&gt; -&nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; build_append_pci_bus_devices(scope, bus, pm-&gt;p=
cihp_bridge_en);<br><br>&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; b=
uild_append_pci_bus_devices(scope, bus, pm-&gt;pcihp_bridge_en,<br><br>&gt;&=
gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;p=
m-&gt;pcihp_root_en);<br><br>&gt;&gt;<br><br>&gt;&gt;&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; if (TPM_IS_TIS_ISA(tpm)) {<br><br>&gt;&gt;&nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (misc-&gt;tpm_vers=
ion =3D=3D TPM_VERSION_2_0) {<br><br>&gt;&gt; --<br><br>&gt;&gt; 2.7.4<br><b=
r>&gt;&gt;<br><br>&gt; <br><br><br><br></blockquote></div></div>
</div></blockquote></div></body></html>=

--Apple-Mail-C0D05729-183A-4DC2-B08D-74D7A4C5B2D0--

