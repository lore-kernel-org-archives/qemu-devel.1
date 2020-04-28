Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B4BC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B892085B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="ZVkoXl6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B892085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41785 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTU9o-0005w1-Tc
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani@anisinha.ca>) id 1jTTHd-0002yw-B9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani@anisinha.ca>) id 1jTTHb-0005Qz-QA
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:40:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1jTTHb-0005Qm-6J
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:40:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id x18so25433661wrq.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jVxJi0CluGBRGq+VUWBUIrOApF26166T8t0yZujFMRQ=;
 b=ZVkoXl6GQL0GWm//kzBQU5OnX6FR29K+IVCwTzFSHirfemkI1EYR6CkWkIxzB3FuYI
 o9yH4mhGYpwEgH5esqQa8+noMV5VsjXdawMRCqtz+MgjzhRU8jS1dCVbxq9+gGRy92FM
 Tcb5NL6fncipcFK7Cfy0hIYAXQNMgbEVpHmkqbtm5IniMRN1ydlsCMzCilHPrqGwV3lB
 RM1Qy7zTyzsEJGKLhBgSHozL7gpIuzM76QctM7BU2uu9ksSSMqM052oIub32Va5QQgUn
 A8AtRN1/I5L2H0AatR30gq7h3UgVoYZBQM1jpDPO6NCXRY85GHeGdrFcESwWDZuQ1h00
 dGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jVxJi0CluGBRGq+VUWBUIrOApF26166T8t0yZujFMRQ=;
 b=kxIYoHVMTSX3Z0aBGJNPrerEKjzAotfXRZgOmjTAuhXSbp/xVjSJUhE8cLcnFaiT0v
 5J7Q9UlNtgkCembVD1SXIJP/q5W6Y62+vT11POI3oQyUK4/0zxty8I8SPPUS6Ubh09QW
 i8aIBX3yPgiU+apFHCLsa6uC7tN0frjNhan/8A47kp9cMxHEeOfXfwlXtfYO59UPjtQ2
 OIQW4lqzTV6akkbJBFrDoa+kqmqesq/p1S4vyS04xFTPjhDHyBkWir3Rvdf91CHRMmrN
 3IExqGztatrZpZ96pNMvozaHTKLpUawwA3M+4tt2YwYTKGFfoiW4U3v2WXubeFJjilRS
 75mQ==
X-Gm-Message-State: AGi0PubRtXHiXl2ZaCD892tWjYuhPNM/Y4qBtFq7Gow3Vnf941UePYdp
 8Vv+YRfVIYTwXviYV3dNdjoLXppDVIH5vRVbOx8kqw==
X-Google-Smtp-Source: APiQypLrupyNKD3OLIlSK0JkxOR+NcrFsaX6dYOe98NKLWo+VD6qTQIKgsqXXfvUMmgrLVsuAWRXxRII9LRmGFLh8RE=
X-Received: by 2002:a5d:6946:: with SMTP id r6mr31647659wrw.291.1588092029462; 
 Tue, 28 Apr 2020 09:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200428120426-mutt-send-email-mst@kernel.org>
 <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
 <20200428121837-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200428121837-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 28 Apr 2020 22:10:18 +0530
Message-ID: <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000049821905a45c7d71"
Received-SPF: none client-ip=2a00:1450:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000049821905a45c7d71
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 28, 2020 at 9:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Apr 28, 2020 at 09:39:16PM +0530, Ani Sinha wrote:
> >
> > Ani
> > On Apr 28, 2020, 21:35 +0530, Michael S. Tsirkin <mst@redhat.com>,
> wrote:
> >
> >     On Tue, Apr 28, 2020 at 10:16:52AM +0000, Ani Sinha wrote:
> >
> >         A new option "use_acpi_unplug" is introduced for PIIX which will
> >         selectively only disable hot unplugging of both hot plugged and
> >         cold plugged PCI devices on non-root PCI buses. This will prevent
> >         hot unplugging of devices from Windows based guests from system
> >         tray but will not prevent devices from being hot plugged into the
> >         guest.
> >
> >         It has been tested on Windows guests.
> >
> >         Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
> >
> >
> >     It's still a non starter until we find something similar for PCIE and
> >     SHPC. Do guests check command status? Can some unplug commands fail?
> >
> >
> > Ok I  give up! I thought we debated this on the other thread.
>
> Sorry to hear that.
> I'd rather you didn't, and worked on a solution that works for everyone.


That is extremely hard for one person to do, without inputs and ideas from
the community. Satisfying the entire world requires lot of time and energy
investment, not to mention a broad expertise in multiple technologies.


> Pushing back on merging code is unfortunately the only mechanism
> maintainers have to make sure features are complete and
> orthogonal to each other, so I'm not sure I can help otherwise.
>
> >
> >
> >
> >
> >         ---
> >         hw/acpi/piix4.c | 3 +++
> >         hw/i386/acpi-build.c | 40
> ++++++++++++++++++++++++++--------------
> >         2 files changed, 29 insertions(+), 14 deletions(-)
> >
> >         diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> >         index 964d6f5..59fa707 100644
> >         --- a/hw/acpi/piix4.c
> >         +++ b/hw/acpi/piix4.c
> >         @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> >
> >         AcpiPciHpState acpi_pci_hotplug;
> >         bool use_acpi_pci_hotplug;
> >         + bool use_acpi_unplug;
> >
> >         uint8_t disable_s3;
> >         uint8_t disable_s4;
> >         @@ -633,6 +634,8 @@ static Property piix4_pm_properties[] = {
> >         DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> >         DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support",
> PIIX4PMState,
> >         use_acpi_pci_hotplug, true),
> >         + DEFINE_PROP_BOOL("acpi-pci-hotunplug-enable-bridge",
> PIIX4PMState,
> >         + use_acpi_unplug, true),
> >         DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> >         acpi_memory_hotplug.is_enabled, true),
> >         DEFINE_PROP_END_OF_LIST(),
> >         diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >         index 23c77ee..71b3ac3 100644
> >         --- a/hw/i386/acpi-build.c
> >         +++ b/hw/i386/acpi-build.c
> >         @@ -96,6 +96,7 @@ typedef struct AcpiPmInfo {
> >         bool s3_disabled;
> >         bool s4_disabled;
> >         bool pcihp_bridge_en;
> >         + bool pcihup_bridge_en;
> >         uint8_t s4_val;
> >         AcpiFadtData fadt;
> >         uint16_t cpu_hp_io_base;
> >         @@ -240,6 +241,9 @@ static void acpi_get_pm_info(MachineState
> *machine,
> >         AcpiPmInfo *pm)
> >         pm->pcihp_bridge_en =
> >         object_property_get_bool(obj,
> "acpi-pci-hotplug-with-bridge-support",
> >         NULL);
> >         + pm->pcihup_bridge_en =
> >         + object_property_get_bool(obj,
> "acpi-pci-hotunplug-enable-bridge",
> >         + NULL);
> >         }
> >
> >         static void acpi_get_misc_info(AcpiMiscInfo *info)
> >         @@ -451,7 +455,8 @@ static void
> build_append_pcihp_notify_entry(Aml
> >         *method, int slot)
> >         }
> >
> >         static void build_append_pci_bus_devices(Aml *parent_scope,
> PCIBus
> >         *bus,
> >         - bool pcihp_bridge_en)
> >         + bool pcihp_bridge_en,
> >         + bool pcihup_bridge_en)
> >         {
> >         Aml *dev, *notify_method = NULL, *method;
> >         QObject *bsel;
> >         @@ -479,11 +484,14 @@ static void
> build_append_pci_bus_devices(Aml
> >         *parent_scope, PCIBus *bus,
> >         dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
> >         aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> >         aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));
> >         - method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> >         - aml_append(method,
> >         - aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
> >         - );
> >         - aml_append(dev, method);
> >         + if (pcihup_bridge_en || pci_bus_is_root(bus)) {
> >         + method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> >         + aml_append(method,
> >         + aml_call2("PCEJ", aml_name("BSEL"),
> >         + aml_name("_SUN"))
> >         + );
> >         + aml_append(dev, method);
> >         + }
> >         aml_append(parent_scope, dev);
> >
> >         build_append_pcihp_notify_entry(notify_method, slot);
> >         @@ -537,12 +545,14 @@ static void
> build_append_pci_bus_devices(Aml
> >         *parent_scope, PCIBus *bus,
> >         /* add _SUN/_EJ0 to make slot hotpluggable */
> >         aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> >
> >         - method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> >         - aml_append(method,
> >         - aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
> >         - );
> >         - aml_append(dev, method);
> >         -
> >         + if (pcihup_bridge_en || pci_bus_is_root(bus)) {
> >         + method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> >         + aml_append(method,
> >         + aml_call2("PCEJ", aml_name("BSEL"),
> >         + aml_name("_SUN"))
> >         + );
> >         + aml_append(dev, method);
> >         + }
> >         if (bsel) {
> >         build_append_pcihp_notify_entry(notify_method, slot);
> >         }
> >         @@ -553,7 +563,8 @@ static void build_append_pci_bus_devices(Aml
> >         *parent_scope, PCIBus *bus,
> >         */
> >         PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> >
> >         - build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
> >         + build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
> >         + pcihup_bridge_en);
> >         }
> >         /* slot descriptor has been composed, add it into parent context
> */
> >         aml_append(parent_scope, dev);
> >         @@ -2196,7 +2207,8 @@ build_dsdt(GArray *table_data, BIOSLinker
> >         *linker,
> >         if (bus) {
> >         Aml *scope = aml_scope("PCI0");
> >         /* Scan all PCI buses. Generate tables to support hotplug. */
> >         - build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> >         + build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en,
> >         + pm->pcihup_bridge_en);
> >
> >         if (TPM_IS_TIS_ISA(tpm)) {
> >         if (misc->tpm_version == TPM_VERSION_2_0) {
> >         --
> >         1.9.4
> >
> >
> >
>
>

--00000000000049821905a45c7d71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Apr 28, 2020 at 9:51 PM Michael S. Tsirkin &lt;<a h=
ref=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">On Tue, Apr 28, 2020 at 09:39:16PM +0530, Ani Sinh=
a wrote:<br>
&gt; <br>
&gt; Ani<br>
&gt; On Apr 28, 2020, 21:35 +0530, Michael S. Tsirkin &lt;<a href=3D"mailto=
:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;, wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Apr 28, 2020 at 10:16:52AM +0000, Ani Sinha=
 wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A new option &quot;use_acpi_unplug&qu=
ot; is introduced for PIIX which will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selectively only disable hot unpluggi=
ng of both hot plugged and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cold plugged PCI devices on non-root =
PCI buses. This will prevent<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hot unplugging of devices from Window=
s based guests from system<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tray but will not prevent devices fro=
m being hot plugged into the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0It has been tested on Windows guests.=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Ani Sinha &lt;<a href=
=3D"mailto:ani.sinha@nutanix.com" target=3D"_blank">ani.sinha@nutanix.com</=
a>&gt;<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It&#39;s still a non starter until we find somethin=
g similar for PCIE and<br>
&gt;=C2=A0 =C2=A0 =C2=A0SHPC. Do guests check command status? Can some unpl=
ug commands fail? <br>
&gt; <br>
&gt; <br>
&gt; Ok I=C2=A0 give up! I thought we debated this on the other thread.<br>
<br>
Sorry to hear that.<br>
I&#39;d rather you didn&#39;t, and worked on a solution that works for ever=
yone.</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">That is ext=
remely hard for one person to do, without inputs and ideas from the communi=
ty. Satisfying the entire world requires lot of time and energy investment,=
 not to mention a broad expertise in multiple technologies.=C2=A0</div><div=
 dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
Pushing back on merging code is unfortunately the only mechanism<br>
maintainers have to make sure features are complete and<br>
orthogonal to each other, so I&#39;m not sure I can help otherwise.<br>
<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw/acpi/piix4.c | 3 +++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw/i386/acpi-build.c | 40 +++++++++++=
+++++++++++++++--------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 files changed, 29 insertions(+), 14=
 deletions(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff --git a/hw/acpi/piix4.c b/hw/acp=
i/piix4.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index 964d6f5..59fa707 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--- a/hw/acpi/piix4.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+++ b/hw/acpi/piix4.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -78,6 +78,7 @@ typedef struct PIIX=
4PMState {<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AcpiPciHpState acpi_pci_hotplug;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool use_acpi_pci_hotplug;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ bool use_acpi_unplug;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t disable_s3;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t disable_s4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -633,6 +634,8 @@ static Property p=
iix4_pm_properties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL=
, PIIX4PMState, s4_val, 2),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;acpi-pci-hotpl=
ug-with-bridge-support&quot;, PIIX4PMState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use_acpi_pci_hotplug, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ DEFINE_PROP_BOOL(&quot;acpi-pci-hot=
unplug-enable-bridge&quot;, PIIX4PMState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ use_acpi_unplug, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;memory-hotplug=
-support&quot;, PIIX4PMState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_memory_hotplug.is_enabled, true)=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff --git a/hw/i386/acpi-build.c b/h=
w/i386/acpi-build.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index 23c77ee..71b3ac3 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--- a/hw/i386/acpi-build.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+++ b/hw/i386/acpi-build.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -96,6 +96,7 @@ typedef struct Acpi=
PmInfo {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool s3_disabled;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool s4_disabled;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool pcihp_bridge_en;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ bool pcihup_bridge_en;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t s4_val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AcpiFadtData fadt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t cpu_hp_io_base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -240,6 +241,9 @@ static void acpi_=
get_pm_info(MachineState *machine,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AcpiPmInfo *pm)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm-&gt;pcihp_bridge_en =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_get_bool(obj, &quot;a=
cpi-pci-hotplug-with-bridge-support&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ pm-&gt;pcihup_bridge_en =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ object_property_get_bool(obj, &quot=
;acpi-pci-hotunplug-enable-bridge&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static void acpi_get_misc_info(AcpiMi=
scInfo *info)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -451,7 +455,8 @@ static void build=
_append_pcihp_notify_entry(Aml<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*method, int slot)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static void build_append_pci_bus_devi=
ces(Aml *parent_scope, PCIBus<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*bus,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- bool pcihp_bridge_en)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ bool pcihp_bridge_en,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ bool pcihup_bridge_en)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Aml *dev, *notify_method =3D NULL, *m=
ethod;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QObject *bsel;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -479,11 +484,14 @@ static void bui=
ld_append_pci_bus_devices(Aml<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*parent_scope, PCIBus *bus,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev =3D aml_device(&quot;S%.02X&quot;=
, PCI_DEVFN(slot, 0));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(dev, aml_name_decl(&quot;_=
SUN&quot;, aml_int(slot)));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(dev, aml_name_decl(&quot;_=
ADR&quot;, aml_int(slot &lt;&lt; 16)));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- method =3D aml_method(&quot;_EJ0&qu=
ot;, 1, AML_NOTSERIALIZED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- aml_append(method,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- aml_call2(&quot;PCEJ&quot;, aml_nam=
e(&quot;BSEL&quot;), aml_name(&quot;_SUN&quot;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- );<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- aml_append(dev, method);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ if (pcihup_bridge_en || pci_bus_is_=
root(bus)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ method =3D aml_method(&quot;_EJ0&qu=
ot;, 1, AML_NOTSERIALIZED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ aml_append(method,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ aml_call2(&quot;PCEJ&quot;, aml_nam=
e(&quot;BSEL&quot;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ aml_name(&quot;_SUN&quot;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ );<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ aml_append(dev, method);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(parent_scope, dev);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_append_pcihp_notify_entry(notif=
y_method, slot);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -537,12 +545,14 @@ static void bui=
ld_append_pci_bus_devices(Aml<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*parent_scope, PCIBus *bus,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* add _SUN/_EJ0 to make slot hotplug=
gable */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(dev, aml_name_decl(&quot;_=
SUN&quot;, aml_int(slot)));<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- method =3D aml_method(&quot;_EJ0&qu=
ot;, 1, AML_NOTSERIALIZED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- aml_append(method,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- aml_call2(&quot;PCEJ&quot;, aml_nam=
e(&quot;BSEL&quot;), aml_name(&quot;_SUN&quot;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- );<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- aml_append(dev, method);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ if (pcihup_bridge_en || pci_bus_is_=
root(bus)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ method =3D aml_method(&quot;_EJ0&qu=
ot;, 1, AML_NOTSERIALIZED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ aml_append(method,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ aml_call2(&quot;PCEJ&quot;, aml_nam=
e(&quot;BSEL&quot;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ aml_name(&quot;_SUN&quot;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ );<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ aml_append(dev, method);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bsel) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_append_pcihp_notify_entry(notif=
y_method, slot);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -553,7 +563,8 @@ static void build=
_append_pci_bus_devices(Aml<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*parent_scope, PCIBus *bus,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCIBus *sec_bus =3D pci_bridge_get_se=
c_bus(PCI_BRIDGE(pdev));<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- build_append_pci_bus_devices(dev, s=
ec_bus, pcihp_bridge_en);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ build_append_pci_bus_devices(dev, s=
ec_bus, pcihp_bridge_en,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ pcihup_bridge_en);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* slot descriptor has been composed,=
 add it into parent context */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aml_append(parent_scope, dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -2196,7 +2207,8 @@ build_dsdt(GArr=
ay *table_data, BIOSLinker<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*linker,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bus) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Aml *scope =3D aml_scope(&quot;PCI0&q=
uot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Scan all PCI buses. Generate table=
s to support hotplug. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- build_append_pci_bus_devices(scope,=
 bus, pm-&gt;pcihp_bridge_en);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ build_append_pci_bus_devices(scope,=
 bus, pm-&gt;pcihp_bridge_en,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ pm-&gt;pcihup_bridge_en);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TPM_IS_TIS_ISA(tpm)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (misc-&gt;tpm_version =3D=3D TPM_V=
ERSION_2_0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01.9.4<br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000049821905a45c7d71--

