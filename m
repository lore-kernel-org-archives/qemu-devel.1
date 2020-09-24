Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41560C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC75A221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ft2jNhzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC75A221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMY2-00070T-S8
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kLMXJ-0006a0-PR
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kLMXH-0006Yp-AV
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600935806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UVTWFal2k3LVUUU95O+Im2/EA2AqkOh29xp4KTQvuY0=;
 b=ft2jNhzSGMQ0jtVqMfpk2jIALLUK11TQm04pR4fRYdT9xJyjauQUayxruNiglqBhyPL6md
 pgVpD+/rrmpx17X5BnUzGuW6rark4PUl1iZqVnCDjebi/vm/PbOtXJuXmBudLDUOc7SXNt
 /lKDu6WC2QRd41f+YpRHjSxYIF0Ca/0=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-qudCXJUaNI-cEHIHITuBTg-1; Thu, 24 Sep 2020 04:23:25 -0400
X-MC-Unique: qudCXJUaNI-cEHIHITuBTg-1
Received: by mail-yb1-f200.google.com with SMTP id l67so2187723ybb.7
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 01:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UVTWFal2k3LVUUU95O+Im2/EA2AqkOh29xp4KTQvuY0=;
 b=feMBTVxNshOPUeNIbaDXZyeVfiVxMqw2OdsPq4sz170Tdynqe0k32mkXn6NpJwKmRc
 Wggoxzf1i3lYG9K8oiTKI8AKLg1ziuUarLeX1rt2dhM82oRzOsYcJOpPMHQH0fHBzgHI
 DHn3bq4z/DxwziApLh7VQEwVTq1C8trWyr3H8ym31SxAPgcLMF1K2xZGIhr0jyHy/C5J
 MUaHKy6+CY5AFh2xPWXtnJG9K5nC5cScm3FGrjK/izGcl3gKdVkIzUkg2DEGh3cgUuvW
 F1yGV9ZFZ5plQUN8OtGGttqKpOBc+0uYWBGIVh4Cstdq40mRqoULge0Ff83EyNxAs15o
 vCTg==
X-Gm-Message-State: AOAM532l7ccLRu0Y128m37Rsqt5QyajmcpuZL2GRWC6AkRCjFWxQbYT7
 8/65jmOfAM/ZpDUz3x9V1MJNqEsyc+8vqpyASAKMwG46I1QW7Do4E8S+BILztR0AxGxBGQW+CEu
 tJAu+BN+vng6iTOwMAD1qtSRGGFtelKI=
X-Received: by 2002:a25:4ac2:: with SMTP id x185mr5226290yba.81.1600935804387; 
 Thu, 24 Sep 2020 01:23:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9KDCiT9crMmSqj8IRRphO9Ev8XRgts9R2IC0VD6GVHuH1eTaUbfrfpmJ9FaiaTjtgDxz3jNnctfoz+eQ5dE4=
X-Received: by 2002:a25:4ac2:: with SMTP id x185mr5226265yba.81.1600935804124; 
 Thu, 24 Sep 2020 01:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924070013.165026-4-jusual@redhat.com>
 <20200924033305-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200924033305-mutt-send-email-mst@kernel.org>
From: Julia Suvorova <jusual@redhat.com>
Date: Thu, 24 Sep 2020 10:23:13 +0200
Message-ID: <CAMDeoFXobPuNnKB3bQB=20SPbvTCgNiE_UWJrtsT6d5aAS5sTQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/7] hw/pci/pcie: Do not initialize slot capability
 if acpihp is used
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 9:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 24, 2020 at 09:00:09AM +0200, Julia Suvorova wrote:
> > Instead of changing the hot-plug type in _OSC register, do not
> > initialize the slot capability or set the 'Slot Implemented' flag.
> > This way guest will choose ACPI hot-plug if it is preferred and leave
> > the option to use SHPC with pcie-pci-bridge.
> >
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  hw/i386/acpi-build.h |  2 ++
> >  hw/i386/acpi-build.c |  2 +-
> >  hw/pci/pcie.c        | 16 ++++++++++++++++
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> > index 487ec7710f..4c5bfb3d0b 100644
> > --- a/hw/i386/acpi-build.h
> > +++ b/hw/i386/acpi-build.h
> > @@ -11,4 +11,6 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
> >
> >  void acpi_setup(void);
> >
> > +Object *object_resolve_type_unambiguous(const char *typename);
> > +
> >  #endif
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index cf503b16af..b7811a8912 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -174,7 +174,7 @@ static void init_common_fadt_data(MachineState *ms, Object *o,
> >      *data = fadt;
> >  }
> >
> > -static Object *object_resolve_type_unambiguous(const char *typename)
> > +Object *object_resolve_type_unambiguous(const char *typename)
> >  {
> >      bool ambig;
> >      Object *o = object_resolve_path_type("", typename, &ambig);
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index 5b48bae0f6..c1a082e8b9 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -27,6 +27,8 @@
> >  #include "hw/pci/pci_bus.h"
> >  #include "hw/pci/pcie_regs.h"
> >  #include "hw/pci/pcie_port.h"
> > +#include "hw/i386/ich9.h"
> > +#include "hw/i386/acpi-build.h"
> >  #include "qemu/range.h"
> >
> >  //#define DEBUG_PCIE
>
>
> Not really happy with pcie.c getting an i386 dependency.
>
>
>
> > @@ -515,12 +517,26 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
> >      pcie_cap_slot_push_attention_button(hotplug_pdev);
> >  }
> >
> > +static bool acpi_pcihp_enabled(void)
> > +{
> > +    Object *lpc = object_resolve_type_unambiguous(TYPE_ICH9_LPC_DEVICE);
> > +
> > +    return lpc &&
> > +           object_property_get_bool(lpc, "acpi-pci-hotplug-with-bridge-support",
> > +                                    NULL);
> > +
> > +}
> > +
>
> Why not just check the property unconditionally?

Ok.

> >  /* pci express slot for pci express root/downstream port
> >     PCI express capability slot registers */
> >  void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
> >  {
> >      uint32_t pos = dev->exp.exp_cap;
> >
> > +    if (acpi_pcihp_enabled()) {
> > +        return;
> > +    }
> > +
>
> I think I would rather not teach pcie about acpi. How about we
> change the polarity, name the property
> "pci-native-hotplug" or whatever makes sense.

I'd prefer not to change the property name since the common code in
hw/i386/acpi-build.c depends on it, but I can add a new one if it
makes any sense.

> >      pci_word_test_and_set_mask(dev->config + pos + PCI_EXP_FLAGS,
> >                                 PCI_EXP_FLAGS_SLOT);
> >
> > --
> > 2.25.4
>


