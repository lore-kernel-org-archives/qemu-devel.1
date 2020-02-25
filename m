Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAE7C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB09E21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgfBMs4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB09E21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bse-0005Ug-5X
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6brx-0004iX-68
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6brv-0000TT-68
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:11:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6brv-0000RM-1h
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5rE75g4c3uUfSOaNhfF/EGhygHk4JeS5VjX076YT+Uk=;
 b=cgfBMs4OVZrhV9OAPs4o+O/Q/+UAnAx5b1OMzOmnYBibNMoZRSIOjdnJ33Hh4pki+qDm8W
 eVVi1YePm6ux7nqBIkJ27s9hlJvHKFZ1R4ze4k0mA03+0+HpPj4OOdmhZDljJLxp+aDcGP
 58B94FT7O9B5KdhdMsK0GNxrXmKWgeI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-rQnSZnJUPKKlpY90JunX9g-1; Tue, 25 Feb 2020 10:11:23 -0500
X-MC-Unique: rQnSZnJUPKKlpY90JunX9g-1
Received: by mail-qt1-f199.google.com with SMTP id t9so15227317qtn.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9CNy190iObG7pL5oBwitHB4AnmdN1OE1QzGcm003dEQ=;
 b=SI1Apw/I/naMKH/dNV935MpZ6q8clwkfRmmjJHCfgP/lm5M2jTfP4KPyCS9KSI1sWD
 PPKLSo6r2Im6tn4p3+nl6O5x4aMQF0HTKKhVEA0UtfmrQ8nm/r42bMM2zkmhHcVnF08y
 AffwUCufgR+NIWJ3b43qMVkr27+q6b4bCBsoE2v3I62TOkEU4XthHAURhZSq8c9XMijz
 By8zjF7o2+yxDJUs9ojV2zB2kV4k9RXLYUyEqTyIlnAAQmNbEAEHRCI9+rcCl//7cCAj
 nUK8EdYSbvl7LK+8+oVduywzBFHWiJLma1KaWEC8XxYZfQ2kkW9JE3tTctaeSGZ5i6gZ
 uhog==
X-Gm-Message-State: APjAAAWKpG8cfvNwN954ffLS57KSxOKWlc11NhJ5Pi4lNlDbWxKQI3ny
 cpHsm8EnB41eDn6JprpKK/egB2VC0hwIv5hzROKyO+NlbtF7Yn1kAXrs3Vaa37JqLWNXMa1m0X6
 d6qN99kSJDEdsFnc=
X-Received: by 2002:ac8:1e90:: with SMTP id c16mr53626592qtm.265.1582643481875; 
 Tue, 25 Feb 2020 07:11:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxERTr9KeGfI/PAnK/YC/eo37aB4Is9HIrH2istKYPZVjaVPm/kt7UJKwaqs2y8fMc1c467hQ==
X-Received: by 2002:ac8:1e90:: with SMTP id c16mr53626556qtm.265.1582643481522; 
 Tue, 25 Feb 2020 07:11:21 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 79sm3651082qkf.129.2020.02.25.07.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:11:20 -0800 (PST)
Date: Tue, 25 Feb 2020 10:11:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH v2] pcie_root_port: Add enable_hotplug option
Message-ID: <20200225100722-mutt-send-email-mst@kernel.org>
References: <20200219145540.648365-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200219145540.648365-1-jusual@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 03:55:40PM +0100, Julia Suvorova wrote:
> Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
> manage it and restrict unplug for the whole machine. This is going to
> prevent user-initiated unplug in guests (Windows mostly).
> Hotplug is enabled by default.
> Usage:
>     -device pcie-root-port,enable-hotplug=3Dfalse,...
>=20
> If you want to disable hot-unplug on some downstream ports of one
> switch, disable hot-unplug on PCIe Root Port connected to the upstream
> port as well as on the selected downstream ports.
>=20
> Discussion related:
>     https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00530.html
>=20
> Signed-off-by: Julia Suvorova <jusual@redhat.com>

OK but now that I look at it, can't we put this
property on PCIE slot? We really need it for downstream
root ports too, and it seems attractive to be able to just specify
it on TYPE_PCIE_SLOT.

> ---
> v1: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04868.html
>=20
> v2:
>     * change name of the option to 'enable-hotplug' [Laine]
>     * change order of enabling capability bits [Igor]
>     * enable HPS bit [Igor]
>     * add option to xio3130_downstream [J=E1n]
>=20
>  hw/pci-bridge/pcie_root_port.c     |  3 ++-
>  hw/pci-bridge/xio3130_downstream.c |  3 ++-
>  hw/pci/pcie.c                      | 11 +++++++----
>  include/hw/pci/pcie.h              |  2 +-
>  include/hw/pci/pcie_port.h         |  1 +
>  5 files changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_por=
t.c
> index 0ba4e4dea4..6eb2bc4564 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -94,7 +94,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
> =20
>      pcie_cap_arifwd_init(d);
>      pcie_cap_deverr_init(d);
> -    pcie_cap_slot_init(d, s->slot);
> +    pcie_cap_slot_init(d, s);
>      pcie_cap_root_init(d);
> =20
>      pcie_chassis_create(s->chassis);
> @@ -147,6 +147,7 @@ static Property rp_props[] =3D {
>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>      DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
> +    DEFINE_PROP_BOOL("enable-hotplug", PCIESlot, enable_hotplug, true),
>      DEFINE_PROP_END_OF_LIST()
>  };
> =20
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_d=
ownstream.c
> index 153a4acad2..e8c388c547 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -94,7 +94,7 @@ static void xio3130_downstream_realize(PCIDevice *d, Er=
ror **errp)
>      }
>      pcie_cap_flr_init(d);
>      pcie_cap_deverr_init(d);
> -    pcie_cap_slot_init(d, s->slot);
> +    pcie_cap_slot_init(d, s);
>      pcie_cap_arifwd_init(d);
> =20
>      pcie_chassis_create(s->chassis);
> @@ -136,6 +136,7 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
>  static Property xio3130_downstream_props[] =3D {
>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> +    DEFINE_PROP_BOOL("enable-hotplug", PCIESlot, enable_hotplug, true),
>      DEFINE_PROP_END_OF_LIST()
>  };
> =20
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 08718188bb..a963c0f82e 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -495,7 +495,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *=
hotplug_dev,
> =20
>  /* pci express slot for pci express root/downstream port
>     PCI express capability slot registers */
> -void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot)
> +void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
>  {
>      uint32_t pos =3D dev->exp.exp_cap;
> =20
> @@ -505,13 +505,16 @@ void pcie_cap_slot_init(PCIDevice *dev, uint16_t sl=
ot)
>      pci_long_test_and_clear_mask(dev->config + pos + PCI_EXP_SLTCAP,
>                                   ~PCI_EXP_SLTCAP_PSN);
>      pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_SLTCAP,
> -                               (slot << PCI_EXP_SLTCAP_PSN_SHIFT) |
> +                               (s->slot << PCI_EXP_SLTCAP_PSN_SHIFT) |
>                                 PCI_EXP_SLTCAP_EIP |
> -                               PCI_EXP_SLTCAP_HPS |
> -                               PCI_EXP_SLTCAP_HPC |
>                                 PCI_EXP_SLTCAP_PIP |
>                                 PCI_EXP_SLTCAP_AIP |
>                                 PCI_EXP_SLTCAP_ABP);
> +    if (s->enable_hotplug) {
> +        pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_SLTCAP,
> +                                   PCI_EXP_SLTCAP_HPS |
> +                                   PCI_EXP_SLTCAP_HPC);
> +    }
> =20
>      if (dev->cap_present & QEMU_PCIE_SLTCAP_PCP) {
>          pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_SLTCAP,
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 7064875835..14c58ebdb6 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -104,7 +104,7 @@ void pcie_cap_deverr_reset(PCIDevice *dev);
>  void pcie_cap_lnkctl_init(PCIDevice *dev);
>  void pcie_cap_lnkctl_reset(PCIDevice *dev);
> =20
> -void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
> +void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s);
>  void pcie_cap_slot_reset(PCIDevice *dev);
>  void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_=
sta);
>  void pcie_cap_slot_write_config(PCIDevice *dev,
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index 4b3d254b08..71be598dda 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -55,6 +55,7 @@ struct PCIESlot {
> =20
>      /* Disable ACS (really for a pcie_root_port) */
>      bool        disable_acs;
> +    bool        enable_hotplug;
>      QLIST_ENTRY(PCIESlot) next;
>  };
> =20
> --=20
> 2.24.1


