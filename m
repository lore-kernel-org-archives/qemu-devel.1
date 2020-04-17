Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05306C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2BE206B9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0j4s+A8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2BE206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPSv4-0007O1-Ts
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 11:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jPSu8-0006bu-4o
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jPSu6-000409-57
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:27:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41122
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jPSu5-0003y5-TQ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587137261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o3ff6rgMA2qyRxg425PHXGMxGq+PxttnXXQ604+Cq7w=;
 b=B0j4s+A8NRL2fwF+VHq38qTVOTVK3fBcrtyP5qv0uFc4i4T4HNiryVXb2Vx7mtenlJbhMz
 zK7ZSYiAfQviq4Ds2N11PknPevcpEbit41Kuucz+ZzB7U0VxhBxZXKF6ljlAe76gcAmhXj
 KQbkXwNfmcfL74JHVyieBlCOzQLajD0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-xJAd7PYuO5q9LQh-gGfuew-1; Fri, 17 Apr 2020 11:27:39 -0400
X-MC-Unique: xJAd7PYuO5q9LQh-gGfuew-1
Received: by mail-wr1-f69.google.com with SMTP id m15so1195968wrb.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 08:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QjfqxDeMa13kqODMarxZ6BTmhf7jxQnL33XRGg7aots=;
 b=XOEbnPl0bpBfRQZXhzp7wq/qW32RBhIqQjNSMJVopMY/dleHNkS1Tjhlm6bBdEQ8PY
 ESpwOk5YDqlAW6Sbo3mMT3Ryv78TORBMnI3o3v6KFRAJ9IzgEHvMtBvG/yy2rg7WswPP
 Ts31k8m4MjsqRrLFKHqkQ63ve6u3E0nszT+9dSoODz7sqs+A78twxTx/ZapCcIWJHzjH
 HagS9wvdgfXUxsd2eCROBBwLSKCw4iiQ2US5nnSghEoTctGh6aReeKqPstI1S0laNpc9
 A9RL/pSawPeu9gCi+vbwpjdve1IWnd0G5JjBnSihlY3VkG2e/nxey+Ds4cho8/fwW5Jp
 pRmQ==
X-Gm-Message-State: AGi0PuY3fQBwpUXDolRdA8mxGVbOeCq+vRAmwZx1TNJ0R1HBMo3aaJLk
 Hkbzf6tLua4x9aW+PHmnruIFUx4d0yUOVnHPIKcyI6Ro8EKMZU4DLzIJnQhpdBGcikYNRLS3EEv
 MF5M003Os6Wy7Vh0=
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr4402380wrr.354.1587137258218; 
 Fri, 17 Apr 2020 08:27:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypKcJVZOCtip37zZxD508I1VQzln6OLILFOZy2C31LM6RWIunkMHE83VDkPCQzZ3bM4A0BjmpQ==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr4402337wrr.354.1587137257686; 
 Fri, 17 Apr 2020 08:27:37 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id i17sm22304145wru.39.2020.04.17.08.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 08:27:36 -0700 (PDT)
Date: Fri, 17 Apr 2020 11:27:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Message-ID: <20200417112620-mutt-send-email-mst@kernel.org>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 03:13:31PM +0000, Ani Sinha wrote:
> A new option "use_acpi_unplug" is introduced for PIIX which will
> selectively only disable hot unplugging of both hot plugged and
> cold plugged PCI devices on non-root PCI buses. This will prevent
> hot unplugging of devices from Windows based guests from system
> tray but will not prevent devices from being hot plugged into the
> guest.
>=20
> The patch is initial version and is a rough implementation. It has
> been tested on Windows guests.
>=20
> Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>

Is there a real reason to do this? Can't we just limit the
hotplug control to pcie ports? At some point I'd like us to
start leaving piix alone...


> ---
>  hw/acpi/piix4.c      |  3 +++
>  hw/i386/acpi-build.c | 40 ++++++++++++++++++++++++++--------------
>  2 files changed, 29 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index d706360..dad1bf4 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -82,6 +82,7 @@ typedef struct PIIX4PMState {
> =20
>      AcpiPciHpState acpi_pci_hotplug;
>      bool use_acpi_pci_hotplug;
> +    bool use_acpi_unplug;
> =20
>      uint8_t disable_s3;
>      uint8_t disable_s4;
> @@ -676,6 +677,8 @@ static Property piix4_pm_properties[] =3D {
>      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMStat=
e,
>                       use_acpi_pci_hotplug, true),
> +    DEFINE_PROP_BOOL("acpi-pci-hotunplug-enable-bridge", PIIX4PMState,
> +                     use_acpi_unplug, true),
>      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>                       acpi_memory_hotplug.is_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2bc8117..526feb2 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -94,6 +94,7 @@ typedef struct AcpiPmInfo {
>      bool s3_disabled;
>      bool s4_disabled;
>      bool pcihp_bridge_en;
> +    bool pcihup_bridge_en;
>      uint8_t s4_val;
>      AcpiFadtData fadt;
>      uint16_t cpu_hp_io_base;
> @@ -220,6 +221,9 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>      pm->pcihp_bridge_en =3D
>          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-supp=
ort",
>                                   NULL);
> +    pm->pcihup_bridge_en =3D
> +        object_property_get_bool(obj, "acpi-pci-hotunplug-enable-bridge"=
,
> +                                 NULL);
>  }
> =20
>  static void acpi_get_misc_info(AcpiMiscInfo *info)
> @@ -430,7 +434,8 @@ static void build_append_pcihp_notify_entry(Aml *meth=
od, int slot)
>  }
> =20
>  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> -                                         bool pcihp_bridge_en)
> +                                         bool pcihp_bridge_en,
> +                                         bool pcihup_bridge_en)
>  {
>      Aml *dev, *notify_method =3D NULL, *method;
>      QObject *bsel;
> @@ -458,11 +463,14 @@ static void build_append_pci_bus_devices(Aml *paren=
t_scope, PCIBus *bus,
>                  dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
>                  aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>                  aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16=
)));
> -                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> -                aml_append(method,
> -                    aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN")=
)
> -                );
> -                aml_append(dev, method);
> +                if (pcihup_bridge_en || pci_bus_is_root(bus)) {
> +                    method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> +                    aml_append(method,
> +                               aml_call2("PCEJ", aml_name("BSEL"),
> +                                         aml_name("_SUN"))
> +                        );
> +                    aml_append(dev, method);
> +                }
>                  aml_append(parent_scope, dev);
> =20
>                  build_append_pcihp_notify_entry(notify_method, slot);
> @@ -516,12 +524,14 @@ static void build_append_pci_bus_devices(Aml *paren=
t_scope, PCIBus *bus,
>              /* add _SUN/_EJ0 to make slot hotpluggable  */
>              aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> =20
> -            method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> -            aml_append(method,
> -                aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
> -            );
> -            aml_append(dev, method);
> -
> +            if (pcihup_bridge_en || pci_bus_is_root(bus)) {
> +                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> +                aml_append(method,
> +                           aml_call2("PCEJ", aml_name("BSEL"),
> +                                     aml_name("_SUN"))
> +                    );
> +                aml_append(dev, method);
> +            }
>              if (bsel) {
>                  build_append_pcihp_notify_entry(notify_method, slot);
>              }
> @@ -532,7 +542,8 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
>               */
>              PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev))=
;
> =20
> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
> +                                         pcihup_bridge_en);
>          }
>          /* slot descriptor has been composed, add it into parent context=
 */
>          aml_append(parent_scope, dev);
> @@ -2133,7 +2144,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          if (bus) {
>              Aml *scope =3D aml_scope("PCI0");
>              /* Scan all PCI buses. Generate tables to support hotplug. *=
/
> -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en=
);
> +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en=
,
> +                                         pm->pcihup_bridge_en);
> =20
>              if (TPM_IS_TIS(tpm_find())) {
>                  dev =3D aml_device("ISA.TPM");
> --=20
> 1.9.4


