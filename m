Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A4CC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DA520665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gr7lBDqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DA520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeAI-0003i8-Mn
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kBe9e-0002u0-Jm
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:10:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kBe9b-0001Y3-JH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598620250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAIvqp3ccyjaTQHD3360UFrGFFGM5rwxIvGXNDKjOa4=;
 b=gr7lBDqjbPKTHyXtl9fFtPVCGe9ht4ff+9FmFOGCdKm4UnjXVzNj0yBVPgbbA7P8PXR990
 odlEoMWamQrWNlfJprffCQcg84ko7jZZ3cQ8+2eU3LBK/D9lsizVW/kzMtOUQXMFSJASkQ
 Y0roHj7sd6RyzB8mgJCujJPaYNayA0o=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-A378P8OHPEO1j_gZtt6ylQ-1; Fri, 28 Aug 2020 09:10:48 -0400
X-MC-Unique: A378P8OHPEO1j_gZtt6ylQ-1
Received: by mail-yb1-f200.google.com with SMTP id l67so1341060ybb.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 06:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aAIvqp3ccyjaTQHD3360UFrGFFGM5rwxIvGXNDKjOa4=;
 b=iBC/RMMA1KvHN7x9zYoIPCUnmhEN3mAg8lDvID2v8cGcI8IVEZDxOG0cHtFfYC8ZXr
 sevg3r9dFJHO9Rd9aSdoZJ2HMYtH/B/y9Dik5fPioZZAlRC/JLdQNRNAynOW8aGfFVsc
 bu8r1W/QkmrvNKKPR1UETmUniO3hVbB0RLgzPdgFyTGqfaj5bMXiwrfCoKbzrXVWWEbN
 vJEu0HQFn8H4yBOCDaGR2kQzdZ/aaQT+EQHl2G5T5O1UsYKrcAECPUcv03iBal9PptYO
 2wAiWN2CrHCj/yRxjA/se5nYmPEl9mhMFEke5XJIg88waVh8JqAQleMUafO5wdRQWGEb
 pCNw==
X-Gm-Message-State: AOAM5305Q5nAn8QXEQtkMrm7eQ43tzwgutucAcPrcowtzzRTEnDDu0WC
 ybkAJw5XzQ6PxLBosRn7Q9buKHWVgXuQLag0I8Ljuz5efSFD0oUJwXayu7BADfEifX3o15PZYvC
 Zjx+eottdNx5LcMjemGMYCYK06jLQLCE=
X-Received: by 2002:a25:238d:: with SMTP id j135mr2445154ybj.206.1598620247655; 
 Fri, 28 Aug 2020 06:10:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1SoB8jGKVKmTpRAFCIYcO3ZoyLPIGpquioWk0Mp6fgvIbAueJHlWwPhTEH7+DgjAQEoYZFRzFWFubjyiNocY=
X-Received: by 2002:a25:238d:: with SMTP id j135mr2445102ybj.206.1598620247261; 
 Fri, 28 Aug 2020 06:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200827133954.2118749-1-mst@redhat.com>
 <20200827133954.2118749-7-mst@redhat.com>
 <20200827194115.673f94de@imammedo-mac>
 <CAARzgwzLcu5iHrXNZrVbg2Yx27AvyYWrKqBZ0wK7CveQ_eKgsQ@mail.gmail.com>
 <20200828114907.42961cd3@redhat.com>
 <d67e8431-b23a-46ee-94f3-544c4476848e@Spark>
In-Reply-To: <d67e8431-b23a-46ee-94f3-544c4476848e@Spark>
From: Julia Suvorova <jusual@redhat.com>
Date: Fri, 28 Aug 2020 15:10:36 +0200
Message-ID: <CAMDeoFXa2NPwCE3u-OVsBGQQWOY9yk_048iL8gieboGU5Hj7+w@mail.gmail.com>
Subject: Re: [PULL 06/13] Introduce a new flag for i440fx to disable PCI
 hotplug on the root bus
To: Ani Sinha <ani@anisinha.ca>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 04:08:58
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 28, 2020 at 11:53 AM Ani Sinha <ani@anisinha.ca> wrote:
>
>
> Ani
> On Aug 28, 2020, 15:19 +0530, Igor Mammedov <imammedo@redhat.com>, wrote:
>
> On Thu, 27 Aug 2020 23:29:34 +0530
>
> Ani Sinha <ani@anisinha.ca> wrote:
>
>
> On Thu, Aug 27, 2020 at 11:11 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
>
> On Thu, 27 Aug 2020 09:40:34 -0400
>
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>
> From: Ani Sinha <ani@anisinha.ca>
>
>
> We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with which
>
> we can turn on or off PCI device hotplug on the root bus. This flag can be
>
> used to prevent all PCI devices from getting hotplugged or unplugged from the
>
> root PCI bus.
>
> This feature is targetted mostly towards Windows VMs. It is useful in cases
>
> where some hypervisor admins want to deploy guest VMs in a way so that the
>
> users of the guest OSes are not able to hot-eject certain PCI devices from
>
> the Windows system tray. Laine has explained the use case here in detail:
>
> https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
>
>
> Julia has resolved this issue for PCIE buses with the following commit:
>
> 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")
>
>
> This commit attempts to introduce similar behavior for PCI root buses used in
>
> i440fx machine types (although in this case, we do not have a per-slot
>
> capability to turn hotplug on or off).
>
>
> Usage:
>
> -global PIIX4_PM.acpi-root-pci-hotplug=off
>
>
> By default, this option is enabled which means that hotplug is turned on for
>
> the PCI root bus.
>
>
> The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for PCI-PCI
>
> bridges remain as is and can be used along with this new flag to control PCI
>
> hotplug on PCI bridges.
>
>
> This change has been tested using a Windows 2012R2 server guest image and also
>
> with a Windows 2019 server guest image on a Ubuntu 18.04 host using the latest
>
> master qemu from upstream.
>
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
> Message-Id: <20200821165403.26589-1-ani@anisinha.ca>
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>
>
> Tested-by: Igor Mammedov <imammedo@redhat.com>
>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>
> A glitch in scripts?
>
> I didn't review nor tested this (v8) version
>
>
> oops! I am so eager to get this done and dusted :)
>
> it's merged now,
>
>
> Wait it merged without your review?

Yeah, not only added into the pull request, but actually merged.

>
> can you add a test case for it please?
>
>
> You can use test_acpi_piix4_tcg_bridge() as model.
>
> See header comment at the top of bios-tables-test.c
>
> for how to prepare and submit testcase.
>
>
> Will get on it.

Also, while the whole approach seems good to me, it leaves the hotplug
registers initialized (see build_piix4_pci_hotplug()), even if both
root and bridges hotplug are disabled. Which you can exploit by
writing something like this to the io registers:

outl 0xae10 0
outl 0xae08 your_slot

And because of these quite interesting lines the device will be
successfully unplugged:

static PCIBus *acpi_pcihp_find_hotplug_bus(AcpiPciHpState *s, int bsel)
{
...
    /* Make bsel 0 eject root bus if bsel property is not set,
     * for compatibility with non acpi setups.
     * TODO: really needed?
     */
    if (!bsel && !find.bus) {
        find.bus = s->root;
    }
    return find.bus;
}

Could you please cover both issues in the follow-up patches?

Best regards, Julia Suvorova.

>
>
>
> ---
>
> include/hw/acpi/pcihp.h | 2 +-
>
> hw/acpi/pcihp.c | 23 ++++++++++++++++++++++-
>
> hw/acpi/piix4.c | 5 ++++-
>
> 3 files changed, 27 insertions(+), 3 deletions(-)
>
>
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>
> index 8bc4a4c01d..02f4665767 100644
>
> --- a/include/hw/acpi/pcihp.h
>
> +++ b/include/hw/acpi/pcihp.h
>
> @@ -67,7 +67,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>
> Error **errp);
>
>
> /* Called on reset */
>
> -void acpi_pcihp_reset(AcpiPciHpState *s);
>
> +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off);
>
>
> extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
>
>
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>
> index 9e31ab2da4..39b1f74442 100644
>
> --- a/hw/acpi/pcihp.c
>
> +++ b/hw/acpi/pcihp.c
>
> @@ -104,6 +104,24 @@ static void acpi_set_pci_info(void)
>
> }
>
> }
>
>
> +static void acpi_pcihp_disable_root_bus(void)
>
> +{
>
> + static bool root_hp_disabled;
>
> + PCIBus *bus;
>
> +
>
> + if (root_hp_disabled) {
>
> + return;
>
> + }
>
> +
>
> + bus = find_i440fx();
>
> + if (bus) {
>
> + /* setting the hotplug handler to NULL makes the bus non-hotpluggable */
>
> + qbus_set_hotplug_handler(BUS(bus), NULL);
>
> + }
>
> + root_hp_disabled = true;
>
> + return;
>
> +}
>
> +
>
> static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
>
> {
>
> AcpiPciHpFind *find = opaque;
>
> @@ -209,8 +227,11 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
>
> }
>
> }
>
>
> -void acpi_pcihp_reset(AcpiPciHpState *s)
>
> +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off)
>
> {
>
> + if (acpihp_root_off) {
>
> + acpi_pcihp_disable_root_bus();
>
> + }
>
> acpi_set_pci_info();
>
> acpi_pcihp_update(s);
>
> }
>
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>
> index 26bac4f16c..e6163bb6ce 100644
>
> --- a/hw/acpi/piix4.c
>
> +++ b/hw/acpi/piix4.c
>
> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>
>
> AcpiPciHpState acpi_pci_hotplug;
>
> bool use_acpi_hotplug_bridge;
>
> + bool use_acpi_root_pci_hotplug;
>
>
> uint8_t disable_s3;
>
> uint8_t disable_s4;
>
> @@ -324,7 +325,7 @@ static void piix4_pm_reset(DeviceState *dev)
>
> pci_conf[0x5B] = 0x02;
>
> }
>
> pm_io_space_update(s);
>
> - acpi_pcihp_reset(&s->acpi_pci_hotplug);
>
> + acpi_pcihp_reset(&s->acpi_pci_hotplug, !s->use_acpi_root_pci_hotplug);
>
> }
>
>
> static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
>
> @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
>
> DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>
> DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
>
> use_acpi_hotplug_bridge, true),
>
> + DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
>
> + use_acpi_root_pci_hotplug, true),
>
> DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>
> acpi_memory_hotplug.is_enabled, true),
>
> DEFINE_PROP_END_OF_LIST(),
>
>
>
>


