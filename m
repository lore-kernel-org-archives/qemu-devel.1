Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F806C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CB320707
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="nFL1ifcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CB320707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMDd-0003uK-EJ
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kBMBl-0002cH-8j
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:59:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kBMBg-00054W-2D
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:59:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id a5so6219966wrm.6
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aEqVK7bLDljUE0KpGNIvl4cVn7Zn0fE3c1v9nRSQzEU=;
 b=nFL1ifcv73ZlN7K3CFvXPjSLv8r8aAMsz9Sp3d2QBelWF4gu+x1cp1ezTQR8xcuzmj
 1L4Q6bkC4BkjBDdraKynKbgd3CRboDxPrcXshWKeH1hMWJd5VbDfcYG3dmZJ9y6APDe7
 oqapu7MyIwkPMFYOlpFRj+Riu0BP2JCduThxzbS7JsCUDHK+pNbx1eYp0pXQR1J+k5BJ
 omOAyndEyxSS9chiqvBC3NE2HcSjTO9pYcLG+6kSLIr2i7MmT5IKkM7PzWG2D5hrifEr
 ZkUY216onpaUTfko+Ru3aLEGkadNhquqZIB04osUiQq1lhI761syhm5SQUgSwRAqFYEp
 BFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aEqVK7bLDljUE0KpGNIvl4cVn7Zn0fE3c1v9nRSQzEU=;
 b=OMjN0STpRhgHwT6692LKMoAEemeYRim/sD1kvWGjTkjQtFTx5JHN5Fi5QAMc63nz0o
 H+y0nll6MqPrHe8RK/4gdT9DkwRdLJhz14GB2b+NQ1C2d6zLEgpabJVXQlz+lZrmeriW
 eKwYpkE6Txy7oEGW3z6Ywl/b2ZrE30/NcF4D0UziqppBtBcFJPKzDj4sNvm42Z/E7xfs
 JuhavO2ft42IKbX7oYA3d90WDwkv8ZbC9DWg4sIw/o83c+qwH4pifF0pu+gWNcbx/O7r
 B5/GFDrTs5l9C+gRFc/xQL1C8444aWUS/9IQK5EOg8YATysSHCRfMSACljlqgar2z+7t
 S1Xg==
X-Gm-Message-State: AOAM533A7LJXVVdBxWax1bA+kQH+0epJFgxnD2SV6syAq7ZwTVsgZ33E
 /nHLUhzjrHRnK/3sfw+7lyoIFAzlyBJ6UvTlsUaVwQ==
X-Google-Smtp-Source: ABdhPJzlLL6+PY1mCdAP+I6gq5Z8duPNj2aKLJaJh1OswniJmRSF+bJNxm+E32ohujSeVd/aXRvbi/8LehmD7b3fV4o=
X-Received: by 2002:adf:97dc:: with SMTP id t28mr20094770wrb.291.1598551185978; 
 Thu, 27 Aug 2020 10:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200827133954.2118749-1-mst@redhat.com>
 <20200827133954.2118749-7-mst@redhat.com>
 <20200827194115.673f94de@imammedo-mac>
In-Reply-To: <20200827194115.673f94de@imammedo-mac>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 27 Aug 2020 23:29:34 +0530
Message-ID: <CAARzgwzLcu5iHrXNZrVbg2Yx27AvyYWrKqBZ0wK7CveQ_eKgsQ@mail.gmail.com>
Subject: Re: [PULL 06/13] Introduce a new flag for i440fx to disable PCI
 hotplug on the root bus
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 11:11 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 27 Aug 2020 09:40:34 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> > From: Ani Sinha <ani@anisinha.ca>
> >
> > We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with which
> > we can turn on or off PCI device hotplug on the root bus. This flag can be
> > used to prevent all PCI devices from getting hotplugged or unplugged from the
> > root PCI bus.
> > This feature is targetted mostly towards Windows VMs. It is useful in cases
> > where some hypervisor admins want to deploy guest VMs in a way so that the
> > users of the guest OSes are not able to hot-eject certain PCI devices from
> > the Windows system tray. Laine has explained the use case here in detail:
> > https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
> >
> > Julia has resolved this issue for PCIE buses with the following commit:
> > 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")
> >
> > This commit attempts to introduce similar behavior for PCI root buses used in
> > i440fx machine types (although in this case, we do not have a per-slot
> > capability to turn hotplug on or off).
> >
> > Usage:
> >    -global PIIX4_PM.acpi-root-pci-hotplug=off
> >
> > By default, this option is enabled which means that hotplug is turned on for
> > the PCI root bus.
> >
> > The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for PCI-PCI
> > bridges remain as is and can be used along with this new flag to control PCI
> > hotplug on PCI bridges.
> >
> > This change has been tested using a Windows 2012R2 server guest image and also
> > with a Windows 2019 server guest image on a Ubuntu 18.04 host using the latest
> > master qemu from upstream.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > Message-Id: <20200821165403.26589-1-ani@anisinha.ca>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> > Tested-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> A glitch in scripts?
> I didn't review nor tested this (v8) version

oops! I am so eager to get this done and dusted :)

>
> > ---
> >  include/hw/acpi/pcihp.h |  2 +-
> >  hw/acpi/pcihp.c         | 23 ++++++++++++++++++++++-
> >  hw/acpi/piix4.c         |  5 ++++-
> >  3 files changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> > index 8bc4a4c01d..02f4665767 100644
> > --- a/include/hw/acpi/pcihp.h
> > +++ b/include/hw/acpi/pcihp.h
> > @@ -67,7 +67,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> >                                           Error **errp);
> >
> >  /* Called on reset */
> > -void acpi_pcihp_reset(AcpiPciHpState *s);
> > +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off);
> >
> >  extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
> >
> > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > index 9e31ab2da4..39b1f74442 100644
> > --- a/hw/acpi/pcihp.c
> > +++ b/hw/acpi/pcihp.c
> > @@ -104,6 +104,24 @@ static void acpi_set_pci_info(void)
> >      }
> >  }
> >
> > +static void acpi_pcihp_disable_root_bus(void)
> > +{
> > +    static bool root_hp_disabled;
> > +    PCIBus *bus;
> > +
> > +    if (root_hp_disabled) {
> > +        return;
> > +    }
> > +
> > +    bus = find_i440fx();
> > +    if (bus) {
> > +        /* setting the hotplug handler to NULL makes the bus non-hotpluggable */
> > +        qbus_set_hotplug_handler(BUS(bus), NULL);
> > +    }
> > +    root_hp_disabled = true;
> > +    return;
> > +}
> > +
> >  static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
> >  {
> >      AcpiPciHpFind *find = opaque;
> > @@ -209,8 +227,11 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
> >      }
> >  }
> >
> > -void acpi_pcihp_reset(AcpiPciHpState *s)
> > +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off)
> >  {
> > +    if (acpihp_root_off) {
> > +        acpi_pcihp_disable_root_bus();
> > +    }
> >      acpi_set_pci_info();
> >      acpi_pcihp_update(s);
> >  }
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index 26bac4f16c..e6163bb6ce 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> >
> >      AcpiPciHpState acpi_pci_hotplug;
> >      bool use_acpi_hotplug_bridge;
> > +    bool use_acpi_root_pci_hotplug;
> >
> >      uint8_t disable_s3;
> >      uint8_t disable_s4;
> > @@ -324,7 +325,7 @@ static void piix4_pm_reset(DeviceState *dev)
> >          pci_conf[0x5B] = 0x02;
> >      }
> >      pm_io_space_update(s);
> > -    acpi_pcihp_reset(&s->acpi_pci_hotplug);
> > +    acpi_pcihp_reset(&s->acpi_pci_hotplug, !s->use_acpi_root_pci_hotplug);
> >  }
> >
> >  static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
> > @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
> >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> >      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
> >                       use_acpi_hotplug_bridge, true),
> > +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> > +                     use_acpi_root_pci_hotplug, true),
> >      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> >                       acpi_memory_hotplug.is_enabled, true),
> >      DEFINE_PROP_END_OF_LIST(),
>

