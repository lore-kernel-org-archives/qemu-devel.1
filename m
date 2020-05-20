Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E75DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 03:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5778207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 03:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="ckONB3Mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5778207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbFT1-0004ZH-U5
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 23:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1jbFSQ-00049j-0e
 for qemu-devel@nongnu.org; Tue, 19 May 2020 23:31:50 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1jbFSO-0006cs-EY
 for qemu-devel@nongnu.org; Tue, 19 May 2020 23:31:49 -0400
Received: by mail-pj1-x1043.google.com with SMTP id nu7so618605pjb.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 20:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=xzGC6/i/nFy7uUsYDPjPkXCNW8gT/YpqxckI3DC+oVc=;
 b=ckONB3MkUPpDjmPgdCw1rB19EIYRvJlqsqbuNaGeG5WSukiuK+VWCSD9rCoCnjr2DN
 +AMWAumfzgJwmtMNov95rM9osblk8nxl0XgBBIVdDev1sYbFmCEDmqej/bx5g2EwTs4j
 7soIekiuJqhO66GtDeFlVsplkE7j8I0fI8MUKNewRRskJhwaJh92a6UiTWV1RlviXEcJ
 3ApSIhR0OOLYQ063d79SDsBAlxr+vcTJFwZozUKaTc4/DsRIIIB/xxeiuKPdHL4X+FHr
 0/Wf1Kzcdr2L9sIsQh2QV2wlsOfCW2xxSmjz1Rsa1vCPfkkxSPBKdGYrRar5oGDbKR65
 MSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=xzGC6/i/nFy7uUsYDPjPkXCNW8gT/YpqxckI3DC+oVc=;
 b=FGsMgHy0C2BhuNCcMrCcWt1R2fHlnEkw3d2+nPHBaLyHd450x2ODCwAw+dBlwZejZV
 OcuKMwKc7Ev2a7S2qcfZlOfiliczTHxtNSBqm60/0WBeCIH2HLubOvB98HES5vEF/U59
 lkS7ipSRdjHEY+lOzkW8WxvPoyxdzqQDymFJjFh+RgQQG2tgjnisIQPd/5Y7TxUWW5bK
 RtlePb9TOzXPv7eEF+XbwnTnUzL/ZTHBQwdXYPTa5hxgZnFAZF+G2D13xQ1I/3GlQZuA
 H2Vtc0IHd3sUb4VQv6PUrb4RqCLuoDnPMHfFTbN7w1Qrqc/e17TcxPZq1cyChJMalSuG
 Updw==
X-Gm-Message-State: AOAM532PLwXMTaDGtMx0OnbXHlrVxHjBpUrDxS540xDCFbulFe9t11dm
 3e+00wxd7/gXEIfvLypuc4378QVzIHCYPA==
X-Google-Smtp-Source: ABdhPJxNsSSf89cRikX0zlj2daJH6JGnPtT+zscJAPEPANmp37S5ZeuC2zlhymhyRjZ9cH8hv1+Okg==
X-Received: by 2002:a17:90a:8d0a:: with SMTP id
 c10mr2772610pjo.151.1589945505707; 
 Tue, 19 May 2020 20:31:45 -0700 (PDT)
Received: from [100.112.128.13] ([182.66.32.81])
 by smtp.gmail.com with ESMTPSA id a16sm742249pfl.167.2020.05.19.20.31.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 May 2020 20:31:44 -0700 (PDT)
Date: Wed, 20 May 2020 09:01:13 +0530
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org, Ani Sinha <ani.sinha@nutanix.com>
Message-ID: <1014a253-024c-41a8-ac37-ca7cfece5a98@Spark>
In-Reply-To: <1589563650-70820-2-git-send-email-ani.sinha@nutanix.com>
References: <[PATCH]AddanewPIIXoptiontocontrolglobalPCIhot-plugging>
 <1589563650-70820-1-git-send-email-ani.sinha@nutanix.com>
 <1589563650-70820-2-git-send-email-ani.sinha@nutanix.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control global PCI
 hot-plugging
X-Readdle-Message-ID: 1014a253-024c-41a8-ac37-ca7cfece5a98@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5ec4a499_327b23c6_27a7"
Received-SPF: none client-ip=2607:f8b0:4864:20::1043;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1043.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5ec4a499_327b23c6_27a7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

@igor Did you get a chance to look?
On May 15, 2020, 22:57 +0530, Ani Sinha <ani.sinha@nutanix.com>, wrote:
> A new option "acpi-pci-hotplug" is introduced for PIIX which will
> globally disable hot-plugging of both hot plugged and
> cold plugged PCI devices. This will prevent
> hot-plugging and hot un-plugging of devices from within Windows based
> guests using system tray.
>
> The patch has been tested on Windows 2016.
>
> Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
> ---
> hw/acpi/piix4.c | 18 ++++++++++++------
> hw/i386/acpi-build.c | 46 ++++++++++++++++++++++++++++++----------------
> 2 files changed, 42 insertions(+), 22 deletions(-)
>
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 964d6f5..91b7e86 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>
> AcpiPciHpState acpi_pci_hotplug;
> bool use_acpi_pci_hotplug;
> + bool use_acpi_hotplug_bridge;
>
> uint8_t disable_s3;
> uint8_t disable_s4;
> @@ -207,13 +208,13 @@ static const VMStateDescription vmstate_pci_status = {
> static bool vmstate_test_use_acpi_pci_hotplug(void *opaque, int version_id)
> {
> PIIX4PMState *s = opaque;
> - return s->use_acpi_pci_hotplug;
> + return s->use_acpi_hotplug_bridge;
> }
>
> static bool vmstate_test_no_use_acpi_pci_hotplug(void *opaque, int version_id)
> {
> PIIX4PMState *s = opaque;
> - return !s->use_acpi_pci_hotplug;
> + return !s->use_acpi_hotplug_bridge;
> }
>
> static bool vmstate_test_use_memhp(void *opaque)
> @@ -505,7 +506,10 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
>
> piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
> pci_get_bus(dev), s);
> - qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s), &error_abort);
> + if (s->use_acpi_pci_hotplug) {
> + qbus_set_hotplug_handler(BUS(pci_get_bus(dev)),
> + OBJECT(s), &error_abort);
> + }
>
> piix4_pm_add_propeties(s);
> }
> @@ -528,7 +532,7 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
> s->smi_irq = smi_irq;
> s->smm_enabled = smm_enabled;
> if (xen_enabled()) {
> - s->use_acpi_pci_hotplug = false;
> + s->use_acpi_hotplug_bridge = false;
> }
>
> qdev_init_nofail(dev);
> @@ -593,7 +597,7 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
>
> acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> - s->use_acpi_pci_hotplug);
> + s->use_acpi_hotplug_bridge);
>
> s->cpu_hotplug_legacy = true;
> object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> @@ -631,8 +635,10 @@ static Property piix4_pm_properties[] = {
> DEFINE_PROP_UINT8(ACPI_PM_PROP_S3_DISABLED, PIIX4PMState, disable_s3, 0),
> DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_DISABLED, PIIX4PMState, disable_s4, 0),
> DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> - DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
> + DEFINE_PROP_BOOL("acpi-pci-hotplug", PIIX4PMState,
> use_acpi_pci_hotplug, true),
> + DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
> + use_acpi_hotplug_bridge, true),
> DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> acpi_memory_hotplug.is_enabled, true),
> DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2e15f68..1737378 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -96,6 +96,7 @@ typedef struct AcpiPmInfo {
> bool s3_disabled;
> bool s4_disabled;
> bool pcihp_bridge_en;
> + bool acpi_pcihp_en;
> uint8_t s4_val;
> AcpiFadtData fadt;
> uint16_t cpu_hp_io_base;
> @@ -246,6 +247,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
> pm->pcihp_bridge_en =
> object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> NULL);
> + pm->acpi_pcihp_en =
> + object_property_get_bool(obj, "acpi-pci-hotplug",
> + NULL);
> }
>
> static void acpi_get_misc_info(AcpiMiscInfo *info)
> @@ -457,7 +461,8 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
> }
>
> static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> - bool pcihp_bridge_en)
> + bool pcihp_bridge_en,
> + bool acpi_pcihp_en)
> {
> Aml *dev, *notify_method = NULL, *method;
> QObject *bsel;
> @@ -481,18 +486,25 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> bool bridge_in_acpi;
>
> if (!pdev) {
> - if (bsel) { /* add hotplug slots for non present devices */
> - dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
> - aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> - aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));
> - method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> - aml_append(method,
> - aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
> - );
> - aml_append(dev, method);
> - aml_append(parent_scope, dev);
> -
> - build_append_pcihp_notify_entry(notify_method, slot);
> + if (bsel) {
> + /*
> + * add hotplug slots for non present devices when
> + * acpi hotplug is enabled.
> + */
> + if (acpi_pcihp_en) {
> + dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
> + aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> + aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));
> + method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> + aml_append(method,
> + aml_call2("PCEJ", aml_name("BSEL"),
> + aml_name("_SUN"))
> + );
> + aml_append(dev, method);
> + aml_append(parent_scope, dev);
> +
> + build_append_pcihp_notify_entry(notify_method, slot);
> + }
> }
> continue;
> }
> @@ -539,7 +551,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> method = aml_method("_S3D", 0, AML_NOTSERIALIZED);
> aml_append(method, aml_return(aml_int(s3d)));
> aml_append(dev, method);
> - } else if (hotplug_enabled_dev) {
> + } else if (hotplug_enabled_dev && acpi_pcihp_en) {
> /* add _SUN/_EJ0 to make slot hotpluggable */
> aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>
> @@ -559,7 +571,8 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> */
> PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>
> - build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
> + build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
> + acpi_pcihp_en);
> }
> /* slot descriptor has been composed, add it into parent context */
> aml_append(parent_scope, dev);
> @@ -2197,7 +2210,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> if (bus) {
> Aml *scope = aml_scope("PCI0");
> /* Scan all PCI buses. Generate tables to support hotplug. */
> - build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> + build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en,
> + pm->acpi_pcihp_en);
>
> if (TPM_IS_TIS_ISA(tpm)) {
> if (misc->tpm_version == TPM_VERSION_2_0) {
> --
> 1.9.4
>

--5ec4a499_327b23c6_27a7
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>=40igor Did you get a chance to look=3F</div>
</div>
<div name=3D=22messageReplySection=22>On May 15, 2020, 22:57 +0530, Ani S=
inha &lt;ani.sinha=40nutanix.com&gt;, wrote:<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22>A new option =22acpi-pci-hotplug=22 is introduced for PIIX whic=
h will<br />
globally disable hot-plugging of both hot plugged and<br />
cold plugged PCI devices. This will prevent<br />
hot-plugging and hot un-plugging of devices from within Windows based<br =
/>
guests using system tray.<br />
<br />
The patch has been tested on Windows 2016.<br />
<br />
Signed-off-by: Ani Sinha &lt;ani.sinha=40nutanix.com&gt;<br />
---<br />
hw/acpi/piix4.c =7C 18 ++++++++++++------<br />
hw/i386/acpi-build.c =7C 46 ++++++++++++++++++++++++++++++---------------=
-<br />
2 files changed, 42 insertions(+), 22 deletions(-)<br />
<br />
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c<br />
index 964d6f5..91b7e86 100644<br />
--- a/hw/acpi/piix4.c<br />
+++ b/hw/acpi/piix4.c<br />
=40=40 -78,6 +78,7 =40=40 typedef struct PIIX4PMState =7B<br />
<br />
AcpiPciHpState acpi=5Fpci=5Fhotplug;<br />
bool use=5Facpi=5Fpci=5Fhotplug;<br />
+ bool use=5Facpi=5Fhotplug=5Fbridge;<br />
<br />
uint8=5Ft disable=5Fs3;<br />
uint8=5Ft disable=5Fs4;<br />
=40=40 -207,13 +208,13 =40=40 static const VMStateDescription vmstate=5Fp=
ci=5Fstatus =3D =7B<br />
static bool vmstate=5Ftest=5Fuse=5Facpi=5Fpci=5Fhotplug(void *opaque, int=
 version=5Fid)<br />
=7B<br />
PIIX4PMState *s =3D opaque;<br />
- return s-&gt;use=5Facpi=5Fpci=5Fhotplug;<br />
+ return s-&gt;use=5Facpi=5Fhotplug=5Fbridge;<br />
=7D<br />
<br />
static bool vmstate=5Ftest=5Fno=5Fuse=5Facpi=5Fpci=5Fhotplug(void *opaque=
, int version=5Fid)<br />
=7B<br />
PIIX4PMState *s =3D opaque;<br />
- return =21s-&gt;use=5Facpi=5Fpci=5Fhotplug;<br />
+ return =21s-&gt;use=5Facpi=5Fhotplug=5Fbridge;<br />
=7D<br />
<br />
static bool vmstate=5Ftest=5Fuse=5Fmemhp(void *opaque)<br />
=40=40 -505,7 +506,10 =40=40 static void piix4=5Fpm=5Frealize(PCIDevice *=
dev, Error **errp)<br />
<br />
piix4=5Facpi=5Fsystem=5Fhot=5Fadd=5Finit(pci=5Faddress=5Fspace=5Fio(dev),=
<br />
pci=5Fget=5Fbus(dev), s);<br />
- qbus=5Fset=5Fhotplug=5Fhandler(BUS(pci=5Fget=5Fbus(dev)), OBJECT(s), &a=
mp;error=5Fabort);<br />
+ if (s-&gt;use=5Facpi=5Fpci=5Fhotplug) =7B<br />
+ qbus=5Fset=5Fhotplug=5Fhandler(BUS(pci=5Fget=5Fbus(dev)),<br />
+ OBJECT(s), &amp;error=5Fabort);<br />
+ =7D<br />
<br />
piix4=5Fpm=5Fadd=5Fpropeties(s);<br />
=7D<br />
=40=40 -528,7 +532,7 =40=40 I2CBus *piix4=5Fpm=5Finit(PCIBus *bus, int de=
vfn, uint32=5Ft smb=5Fio=5Fbase,<br />
s-&gt;smi=5Firq =3D smi=5Firq;<br />
s-&gt;smm=5Fenabled =3D smm=5Fenabled;<br />
if (xen=5Fenabled()) =7B<br />
- s-&gt;use=5Facpi=5Fpci=5Fhotplug =3D false;<br />
+ s-&gt;use=5Facpi=5Fhotplug=5Fbridge =3D false;<br />
=7D<br />
<br />
qdev=5Finit=5Fnofail(dev);<br />
=40=40 -593,7 +597,7 =40=40 static void piix4=5Facpi=5Fsystem=5Fhot=5Fadd=
=5Finit(MemoryRegion *parent,<br />
memory=5Fregion=5Fadd=5Fsubregion(parent, GPE=5FBASE, &amp;s-&gt;io=5Fgpe=
);<br />
<br />
acpi=5Fpcihp=5Finit(OBJECT(s), &amp;s-&gt;acpi=5Fpci=5Fhotplug, bus, pare=
nt,<br />
- s-&gt;use=5Facpi=5Fpci=5Fhotplug);<br />
+ s-&gt;use=5Facpi=5Fhotplug=5Fbridge);<br />
<br />
s-&gt;cpu=5Fhotplug=5Flegacy =3D true;<br />
object=5Fproperty=5Fadd=5Fbool(OBJECT(s), =22cpu-hotplug-legacy=22,<br />=

=40=40 -631,8 +635,10 =40=40 static Property piix4=5Fpm=5Fproperties=5B=5D=
 =3D =7B<br />
DE=46INE=5FPROP=5FUINT8(ACPI=5FPM=5FPROP=5FS3=5FDISABLED, PIIX4PMState, d=
isable=5Fs3, 0),<br />
DE=46INE=5FPROP=5FUINT8(ACPI=5FPM=5FPROP=5FS4=5FDISABLED, PIIX4PMState, d=
isable=5Fs4, 0),<br />
DE=46INE=5FPROP=5FUINT8(ACPI=5FPM=5FPROP=5FS4=5FVAL, PIIX4PMState, s4=5Fv=
al, 2),<br />
- DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotplug-with-bridge-support=22, PIIX=
4PMState,<br />
+ DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotplug=22, PIIX4PMState,<br />
use=5Facpi=5Fpci=5Fhotplug, true),<br />
+ DE=46INE=5FPROP=5FBOOL(=22acpi-pci-hotplug-with-bridge-support=22, PIIX=
4PMState,<br />
+ use=5Facpi=5Fhotplug=5Fbridge, true),<br />
DE=46INE=5FPROP=5FBOOL(=22memory-hotplug-support=22, PIIX4PMState,<br />
acpi=5Fmemory=5Fhotplug.is=5Fenabled, true),<br />
DE=46INE=5FPROP=5FEND=5FO=46=5FLIST(),<br />
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c<br />
index 2e15f68..1737378 100644<br />
--- a/hw/i386/acpi-build.c<br />
+++ b/hw/i386/acpi-build.c<br />
=40=40 -96,6 +96,7 =40=40 typedef struct AcpiPmInfo =7B<br />
bool s3=5Fdisabled;<br />
bool s4=5Fdisabled;<br />
bool pcihp=5Fbridge=5Fen;<br />
+ bool acpi=5Fpcihp=5Fen;<br />
uint8=5Ft s4=5Fval;<br />
Acpi=46adtData fadt;<br />
uint16=5Ft cpu=5Fhp=5Fio=5Fbase;<br />
=40=40 -246,6 +247,9 =40=40 static void acpi=5Fget=5Fpm=5Finfo(MachineSta=
te *machine, AcpiPmInfo *pm)<br />
pm-&gt;pcihp=5Fbridge=5Fen =3D<br />
object=5Fproperty=5Fget=5Fbool(obj, =22acpi-pci-hotplug-with-bridge-suppo=
rt=22,<br />
NULL);<br />
+ pm-&gt;acpi=5Fpcihp=5Fen =3D<br />
+ object=5Fproperty=5Fget=5Fbool(obj, =22acpi-pci-hotplug=22,<br />
+ NULL);<br />
=7D<br />
<br />
static void acpi=5Fget=5Fmisc=5Finfo(AcpiMiscInfo *info)<br />
=40=40 -457,7 +461,8 =40=40 static void build=5Fappend=5Fpcihp=5Fnotify=5F=
entry(Aml *method, int slot)<br />
=7D<br />
<br />
static void build=5Fappend=5Fpci=5Fbus=5Fdevices(Aml *parent=5Fscope, PCI=
Bus *bus,<br />
- bool pcihp=5Fbridge=5Fen)<br />
+ bool pcihp=5Fbridge=5Fen,<br />
+ bool acpi=5Fpcihp=5Fen)<br />
=7B<br />
Aml *dev, *notify=5Fmethod =3D NULL, *method;<br />
QObject *bsel;<br />
=40=40 -481,18 +486,25 =40=40 static void build=5Fappend=5Fpci=5Fbus=5Fde=
vices(Aml *parent=5Fscope, PCIBus *bus,<br />
bool bridge=5Fin=5Facpi;<br />
<br />
if (=21pdev) =7B<br />
- if (bsel) =7B /* add hotplug slots for non present devices */<br />
- dev =3D aml=5Fdevice(=22S%.02X=22, PCI=5FDEV=46N(slot, 0));<br />
- aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FSUN=22, aml=5Fint(slot)));<br=
 />
- aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FADR=22, aml=5Fint(slot &lt;&l=
t; 16)));<br />
- method =3D aml=5Fmethod(=22=5FEJ0=22, 1, AML=5FNOTSERIALIZED);<br />
- aml=5Fappend(method,<br />
- aml=5Fcall2(=22PCEJ=22, aml=5Fname(=22BSEL=22), aml=5Fname(=22=5FSUN=22=
))<br />
- );<br />
- aml=5Fappend(dev, method);<br />
- aml=5Fappend(parent=5Fscope, dev);<br />
-<br />
- build=5Fappend=5Fpcihp=5Fnotify=5Fentry(notify=5Fmethod, slot);<br />
+ if (bsel) =7B<br />
+ /*<br />
+ * add hotplug slots for non present devices when<br />
+ * acpi hotplug is enabled.<br />
+ */<br />
+ if (acpi=5Fpcihp=5Fen) =7B<br />
+ dev =3D aml=5Fdevice(=22S%.02X=22, PCI=5FDEV=46N(slot, 0));<br />
+ aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FSUN=22, aml=5Fint(slot)));<br=
 />
+ aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FADR=22, aml=5Fint(slot &lt;&l=
t; 16)));<br />
+ method =3D aml=5Fmethod(=22=5FEJ0=22, 1, AML=5FNOTSERIALIZED);<br />
+ aml=5Fappend(method,<br />
+ aml=5Fcall2(=22PCEJ=22, aml=5Fname(=22BSEL=22),<br />
+ aml=5Fname(=22=5FSUN=22))<br />
+ );<br />
+ aml=5Fappend(dev, method);<br />
+ aml=5Fappend(parent=5Fscope, dev);<br />
+<br />
+ build=5Fappend=5Fpcihp=5Fnotify=5Fentry(notify=5Fmethod, slot);<br />
+ =7D<br />
=7D<br />
continue;<br />
=7D<br />
=40=40 -539,7 +551,7 =40=40 static void build=5Fappend=5Fpci=5Fbus=5Fdevi=
ces(Aml *parent=5Fscope, PCIBus *bus,<br />
method =3D aml=5Fmethod(=22=5FS3D=22, 0, AML=5FNOTSERIALIZED);<br />
aml=5Fappend(method, aml=5Freturn(aml=5Fint(s3d)));<br />
aml=5Fappend(dev, method);<br />
- =7D else if (hotplug=5Fenabled=5Fdev) =7B<br />
+ =7D else if (hotplug=5Fenabled=5Fdev &amp;&amp; acpi=5Fpcihp=5Fen) =7B<=
br />
/* add =5FSUN/=5FEJ0 to make slot hotpluggable */<br />
aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FSUN=22, aml=5Fint(slot)));<br /=
>
<br />
=40=40 -559,7 +571,8 =40=40 static void build=5Fappend=5Fpci=5Fbus=5Fdevi=
ces(Aml *parent=5Fscope, PCIBus *bus,<br />
*/<br />
PCIBus *sec=5Fbus =3D pci=5Fbridge=5Fget=5Fsec=5Fbus(PCI=5FBRIDGE(pdev));=
<br />
<br />
- build=5Fappend=5Fpci=5Fbus=5Fdevices(dev, sec=5Fbus, pcihp=5Fbridge=5Fe=
n);<br />
+ build=5Fappend=5Fpci=5Fbus=5Fdevices(dev, sec=5Fbus, pcihp=5Fbridge=5Fe=
n,<br />
+ acpi=5Fpcihp=5Fen);<br />
=7D<br />
/* slot descriptor has been composed, add it into parent context */<br />=

aml=5Fappend(parent=5Fscope, dev);<br />
=40=40 -2197,7 +2210,8 =40=40 build=5Fdsdt(GArray *table=5Fdata, BIOSLink=
er *linker,<br />
if (bus) =7B<br />
Aml *scope =3D aml=5Fscope(=22PCI0=22);<br />
/* Scan all PCI buses. Generate tables to support hotplug. */<br />
- build=5Fappend=5Fpci=5Fbus=5Fdevices(scope, bus, pm-&gt;pcihp=5Fbridge=5F=
en);<br />
+ build=5Fappend=5Fpci=5Fbus=5Fdevices(scope, bus, pm-&gt;pcihp=5Fbridge=5F=
en,<br />
+ pm-&gt;acpi=5Fpcihp=5Fen);<br />
<br />
if (TPM=5FIS=5FTIS=5FISA(tpm)) =7B<br />
if (misc-&gt;tpm=5Fversion =3D=3D TPM=5FVERSION=5F2=5F0) =7B<br />
--<br />
1.9.4<br />
<br /></blockquote>
</div>
</body>
</html>

--5ec4a499_327b23c6_27a7--


