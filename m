Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C389C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2D420838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKJLBGn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2D420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAu9o-00085a-28
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAu95-0007NF-7O
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:03:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAu93-0002PH-3U
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598443391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydDQZQI4SBjZMxuBLUz5DmF/3QFXmG6RNFGl4fbQ1Bw=;
 b=JKJLBGn5hjqNnzoXb7kTUfqJx/cyBTlx9GWmBRSzCMBhUJn/CufK+KdNjNDwAIlsa1DdN/
 FrkNbGHG9Kwwi8Dee7oQyCPIMw8EIxitx18EpL0U93Ds/UqaiS9vRweKcViJEg/h+mGk4G
 ob29ffw5E6qN3X5gpCHHqKGPyb7BFZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-9-Tq7mKqOrGr2rn65Gl_wA-1; Wed, 26 Aug 2020 08:03:10 -0400
X-MC-Unique: 9-Tq7mKqOrGr2rn65Gl_wA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A49C18030B2;
 Wed, 26 Aug 2020 12:03:08 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAD7C808B9;
 Wed, 26 Aug 2020 12:03:04 +0000 (UTC)
Date: Wed, 26 Aug 2020 14:03:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH V8] Introduce a new flag for i440fx to disable PCI
 hotplug on the root bus
Message-ID: <20200826140303.2514a68f@redhat.com>
In-Reply-To: <CAARzgwwrc0ioTsUibT1J2EiiW3QdOgFxyd4S5TtaFzPV+-JeBQ@mail.gmail.com>
References: <20200821165403.26589-1-ani@anisinha.ca>
 <CAARzgwwrc0ioTsUibT1J2EiiW3QdOgFxyd4S5TtaFzPV+-JeBQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGll?= =?UTF-8?B?dS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Aug 2020 20:32:04 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> Reminder to kindly review this patch.

I'm a bit occupied elsewhere right now,
will look into it later when more urgent tasks are dealt with.

Maybe Julia can help with review (CCed)
(she should be familiar with the pci hotplug code atm)

 
> On Fri, Aug 21, 2020 at 10:24 PM Ani Sinha <ani@anisinha.ca> wrote:
> 
> > We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with
> > which
> >
> > we can turn on or off PCI device hotplug on the root bus. This flag can be
> >
> > used to prevent all PCI devices from getting hotplugged or unplugged from
> > the
> >
> > root PCI bus.
> >
> > This feature is targetted mostly towards Windows VMs. It is useful in cases
> >
> > where some hypervisor admins want to deploy guest VMs in a way so that the
> >
> > users of the guest OSes are not able to hot-eject certain PCI devices from
> >
> > the Windows system tray. Laine has explained the use case here in detail:
> >
> > https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
> >
> >
> >
> > Julia has resolved this issue for PCIE buses with the following commit:
> >
> > 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")
> >
> >
> >
> > This commit attempts to introduce similar behavior for PCI root buses used
> > in
> >
> > i440fx machine types (although in this case, we do not have a per-slot
> >
> > capability to turn hotplug on or off).
> >
> >
> >
> > Usage:
> >
> >    -global PIIX4_PM.acpi-root-pci-hotplug=off
> >
> >
> >
> > By default, this option is enabled which means that hotplug is turned on
> > for
> >
> > the PCI root bus.
> >
> >
> >
> > The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for
> > PCI-PCI
> >
> > bridges remain as is and can be used along with this new flag to control
> > PCI
> >
> > hotplug on PCI bridges.
> >
> >
> >
> > This change has been tested using a Windows 2012R2 server guest image and
> > also
> >
> > with a Windows 2019 server guest image on a Ubuntu 18.04 host using the
> > latest
> >
> > master qemu from upstream.
> >
> >
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> >
> > ---
> >
> >  hw/acpi/pcihp.c         | 23 ++++++++++++++++++++++-
> >
> >  hw/acpi/piix4.c         |  5 ++++-
> >
> >  include/hw/acpi/pcihp.h |  2 +-
> >
> >  3 files changed, 27 insertions(+), 3 deletions(-)
> >
> >
> >
> > Change Log:
> >
> > V7..V8: Cosmetic. Removed extra new line in the patch. Rebased to latest
> >
> > upstream master and retested with both versions of Windows.
> >
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
> > @@ -104,6 +104,24 @@ static void acpi_set_pci_info(void)
> >
> >      }
> >
> >  }
> >
> >
> >
> > +static void acpi_pcihp_disable_root_bus(void)
> >
> > +{
> >
> > +    static bool root_hp_disabled;
> >
> > +    PCIBus *bus;
> >
> > +
> >
> > +    if (root_hp_disabled) {
> >
> > +        return;
> >
> > +    }
> >
> > +
> >
> > +    bus = find_i440fx();
> >
> > +    if (bus) {
> >
> > +        /* setting the hotplug handler to NULL makes the bus
> > non-hotpluggable */
> >
> > +        qbus_set_hotplug_handler(BUS(bus), NULL);
> >
> > +    }
> >
> > +    root_hp_disabled = true;
> >
> > +    return;
> >
> > +}
> >
> > +
> >
> >  static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
> >
> >  {
> >
> >      AcpiPciHpFind *find = opaque;
> >
> > @@ -209,8 +227,11 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
> >
> >      }
> >
> >  }
> >
> >
> >
> > -void acpi_pcihp_reset(AcpiPciHpState *s)
> >
> > +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off)
> >
> >  {
> >
> > +    if (acpihp_root_off) {
> >
> > +        acpi_pcihp_disable_root_bus();
> >
> > +    }
> >
> >      acpi_set_pci_info();
> >
> >      acpi_pcihp_update(s);
> >
> >  }
> >
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> >
> > index 26bac4f16c..e6163bb6ce 100644
> >
> > --- a/hw/acpi/piix4.c
> >
> > +++ b/hw/acpi/piix4.c
> >
> > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> >
> >
> >
> >      AcpiPciHpState acpi_pci_hotplug;
> >
> >      bool use_acpi_hotplug_bridge;
> >
> > +    bool use_acpi_root_pci_hotplug;
> >
> >
> >
> >      uint8_t disable_s3;
> >
> >      uint8_t disable_s4;
> >
> > @@ -324,7 +325,7 @@ static void piix4_pm_reset(DeviceState *dev)
> >
> >          pci_conf[0x5B] = 0x02;
> >
> >      }
> >
> >      pm_io_space_update(s);
> >
> > -    acpi_pcihp_reset(&s->acpi_pci_hotplug);
> >
> > +    acpi_pcihp_reset(&s->acpi_pci_hotplug, !s->use_acpi_root_pci_hotplug);
> >
> >  }
> >
> >
> >
> >  static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
> >
> > @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
> >
> >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> >
> >      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
> >
> >                       use_acpi_hotplug_bridge, true),
> >
> > +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> >
> > +                     use_acpi_root_pci_hotplug, true),
> >
> >      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> >
> >                       acpi_memory_hotplug.is_enabled, true),
> >
> >      DEFINE_PROP_END_OF_LIST(),
> >
> > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> >
> > index 8bc4a4c01d..02f4665767 100644
> >
> > --- a/include/hw/acpi/pcihp.h
> >
> > +++ b/include/hw/acpi/pcihp.h
> >
> > @@ -67,7 +67,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler
> > *hotplug_dev,
> >
> >                                           Error **errp);
> >
> >
> >
> >  /* Called on reset */
> >
> > -void acpi_pcihp_reset(AcpiPciHpState *s);
> >
> > +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off);
> >
> >
> >
> >  extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
> >
> >
> >
> > --
> >
> > 2.17.1
> >
> >
> >
> >  


