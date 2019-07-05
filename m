Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53EBC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3ACC216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYN6VlnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3ACC216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLwu-0008SI-1l
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 07:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33034)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1hjLw8-0007zN-6d
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1hjLw4-0000wL-92
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:59:28 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1hjLw2-0000bG-9P
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:59:23 -0400
Received: by mail-lj1-x243.google.com with SMTP id r9so8856981ljg.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=kwZW8vnzzRofyJVOsIH815vzHXOSmv2hxCpIH70GXME=;
 b=VYN6VlnSm42M8+08ZMP7Tvd9pPYk+sMZrK7d5LDfafLBWSh9/qi+AjlQuhDDr7fAfJ
 GYXIIktavFKPA2G+zBseIYOkFAzV2rmDNgiiBNAUvKjsjXwRBwx8B9VghrfP2QKcD8Y2
 dpKjCXrT6vw2ujTpUoKuAcvYGhgA4Uu8exEFePcxGTbAbVSMxTyp6F0MhKK4wV+Fi2sg
 bkMXhp795aNwEi5N7QiVujqn+BqrD+iyfwhm5t94g13VK1tlUJLkLFCx+AhfEGzlGGEI
 HeezEwyrXK31ReAn8PeSfm2GKFPxtQG0kqAY79ooAqy7qXIOPm+t0jxVmZNuiENQ7gMn
 5WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=kwZW8vnzzRofyJVOsIH815vzHXOSmv2hxCpIH70GXME=;
 b=DaNUSIt7wDaSnCKdnBTmoU2gRy6gNKXJeadJAGv/TR9IzPbQKvJ3I6gGdCPBuqNSYg
 uy7aOataoH1O5VoEnWwGT7FMNgdpyJyY4ZLVjn/PHTqF0SUWl9ALN5NdPjpTgsfdkY51
 qEHOYln8x+/IGJZ4lWZJ8/W4weEGwQoL6fY7FgvOtMMxaIbzPPBOQ7fUmp5LaGVbaE7N
 OQFe3kaTQwvRiTn+s9GOEU+de9EIGAfeq2X5RFxczrlWeTnu3bkgENHpuSmhu9o5oyYC
 d7aq89hw/XL4js6RRoFunkVXDty+RAb+kQ/fo5vNfxfUr1K1QP1fmuFi3pIjX1MnNFR6
 gxYA==
X-Gm-Message-State: APjAAAX1bIhf/JkoGv5p6qT4pFqPVxKsyIxPzjNiS6yfiog01N5KDcwk
 J3L8W+06+nZMpVr+RUgMBTk=
X-Google-Smtp-Source: APXvYqx7WculQnl6rWh9yzlQS8bDa0OfNgqg/qU0c+YKPLeJcFwtTTqAFzydDi7Aol/S/hXRAFMPFw==
X-Received: by 2002:a2e:9b57:: with SMTP id o23mr1828888ljj.67.1562324357565; 
 Fri, 05 Jul 2019 03:59:17 -0700 (PDT)
Received: from [10.0.0.131] ([79.143.35.147])
 by smtp.gmail.com with ESMTPSA id n1sm1321249lfk.19.2019.07.05.03.59.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 03:59:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20190705010711.23277-1-marcel.apfelbaum@gmail.com>
Date: Fri, 5 Jul 2019 13:59:15 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <03CB6DEC-3D25-4C09-9C9C-3A5206D1D1F7@gmail.com>
References: <20190705010711.23277-1-marcel.apfelbaum@gmail.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] hw/net: fix vmxnet3 live migration
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
Cc: skrtbhtngr@gmail.com, qemu-devel@nongnu.org, yuval.shaia@oracle.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On 5 Jul 2019, at 4:07, Marcel Apfelbaum <marcel.apfelbaum@gmail.com> =
wrote:
>=20
> At some point vmxnet3 live migration stopped working and git-bisect
> didn't help finding a working version.
> The issue is the PCI configuration space is not being migrated
> successfully and MSIX remains masked at destination.
>=20
> Remove the migration differentiation between PCI and PCIe since
> the logic resides now inside VMSTATE_PCI_DEVICE.
> Remove also the VMXNET3_COMPAT_FLAG_DISABLE_PCIE based differentiation
> since at 'realize' time is decided if the device is PCI or PCIe,
> then the above macro is enough.
>=20
> Use the opportunity to move to the standard VMSTATE_MSIX
> instead of the deprecated SaveVMHandlers.
>=20
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>


Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>


> ---
> hw/net/vmxnet3.c | 52 ++----------------------------------------------
> 1 file changed, 2 insertions(+), 50 deletions(-)
>=20
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 10d01d0058..8b17548b02 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2141,21 +2141,6 @@ vmxnet3_cleanup_msi(VMXNET3State *s)
>     msi_uninit(d);
> }
>=20
> -static void
> -vmxnet3_msix_save(QEMUFile *f, void *opaque)
> -{
> -    PCIDevice *d =3D PCI_DEVICE(opaque);
> -    msix_save(d, f);
> -}
> -
> -static int
> -vmxnet3_msix_load(QEMUFile *f, void *opaque, int version_id)
> -{
> -    PCIDevice *d =3D PCI_DEVICE(opaque);
> -    msix_load(d, f);
> -    return 0;
> -}
> -
> static const MemoryRegionOps b0_ops =3D {
>     .read =3D vmxnet3_io_bar0_read,
>     .write =3D vmxnet3_io_bar0_write,
> @@ -2176,11 +2161,6 @@ static const MemoryRegionOps b1_ops =3D {
>     },
> };
>=20
> -static SaveVMHandlers savevm_vmxnet3_msix =3D {
> -    .save_state =3D vmxnet3_msix_save,
> -    .load_state =3D vmxnet3_msix_load,
> -};
> -
> static uint64_t vmxnet3_device_serial_num(VMXNET3State *s)
> {
>     uint64_t dsn_payload;
> @@ -2203,7 +2183,6 @@ static uint64_t =
vmxnet3_device_serial_num(VMXNET3State *s)
>=20
> static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
> {
> -    DeviceState *dev =3D DEVICE(pci_dev);
>     VMXNET3State *s =3D VMXNET3(pci_dev);
>     int ret;
>=20
> @@ -2249,8 +2228,6 @@ static void vmxnet3_pci_realize(PCIDevice =
*pci_dev, Error **errp)
>         pcie_dev_ser_num_init(pci_dev, VMXNET3_DSN_OFFSET,
>                               vmxnet3_device_serial_num(s));
>     }
> -
> -    register_savevm_live(dev, "vmxnet3-msix", -1, 1, =
&savevm_vmxnet3_msix, s);
> }
>=20
> static void vmxnet3_instance_init(Object *obj)
> @@ -2440,29 +2417,6 @@ static const VMStateDescription =
vmstate_vmxnet3_int_state =3D {
>     }
> };
>=20
> -static bool vmxnet3_vmstate_need_pcie_device(void *opaque)
> -{
> -    VMXNET3State *s =3D VMXNET3(opaque);
> -
> -    return !(s->compat_flags & VMXNET3_COMPAT_FLAG_DISABLE_PCIE);
> -}
> -
> -static bool vmxnet3_vmstate_test_pci_device(void *opaque, int =
version_id)
> -{
> -    return !vmxnet3_vmstate_need_pcie_device(opaque);
> -}
> -
> -static const VMStateDescription vmstate_vmxnet3_pcie_device =3D {
> -    .name =3D "vmxnet3/pcie",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> -    .needed =3D vmxnet3_vmstate_need_pcie_device,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> static const VMStateDescription vmstate_vmxnet3 =3D {
>     .name =3D "vmxnet3",
>     .version_id =3D 1,
> @@ -2470,9 +2424,8 @@ static const VMStateDescription vmstate_vmxnet3 =
=3D {
>     .pre_save =3D vmxnet3_pre_save,
>     .post_load =3D vmxnet3_post_load,
>     .fields =3D (VMStateField[]) {
> -            VMSTATE_STRUCT_TEST(parent_obj, VMXNET3State,
> -                                vmxnet3_vmstate_test_pci_device, 0,
> -                                vmstate_pci_device, PCIDevice),
> +            VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
> +            VMSTATE_MSIX(parent_obj, VMXNET3State),
>             VMSTATE_BOOL(rx_packets_compound, VMXNET3State),
>             VMSTATE_BOOL(rx_vlan_stripping, VMXNET3State),
>             VMSTATE_BOOL(lro_supported, VMXNET3State),
> @@ -2508,7 +2461,6 @@ static const VMStateDescription vmstate_vmxnet3 =
=3D {
>     },
>     .subsections =3D (const VMStateDescription*[]) {
>         &vmxstate_vmxnet3_mcast_list,
> -        &vmstate_vmxnet3_pcie_device,
>         NULL
>     }
> };
> --=20
> 2.17.1
>=20


