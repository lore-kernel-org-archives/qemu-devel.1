Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E455C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D1921850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK8HGjRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D1921850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLvI-0007Ve-CZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hjLuW-00076Z-OS
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hjLuU-0004Uu-7J
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:57:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
 id 1hjLuS-0004JN-SB
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:57:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so322306wrr.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2ZF0ghNT9B5EnJB2D+K7cDVKXiIxooB4Zu9GlsIVc6o=;
 b=KK8HGjRulNVdNA7Ct4r+krkx0JADA0nr49Y1eSGGaAemu4NuKIlfSN2Y2nJ+5cswfZ
 ChQ3dGLXmFBfP3p3TCMwXWdXUWVASvQtvw4j9AytmL1Mx6atmi1qTahcmQ8aJ8bSedIq
 JBkEadpe5i27KQ72UIWQetZKBWC3MEPGb+DeOHFV2pE/Na1Izh+cm0xwZFPn45uSgnhq
 WDEcCvFhYpgNG55Ebnk8j4iA6gFcUJKecAMP/vpWiCW+eZnnJYuZPLUH8t2R4eO4d7rj
 +HZimN72E34/FSnTMlvvZdFL8TEKfyEA7pj2iQ5biSq+/yiu4IYi8ufEsNUzEFLdvLxN
 PMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2ZF0ghNT9B5EnJB2D+K7cDVKXiIxooB4Zu9GlsIVc6o=;
 b=t52i48mElPTKKC4yBgnQm4kfD11cX3+eXjCbQoqYF2c42b1xh3c5z5BmDD5p85hJCV
 OQ31W3K6tOeCQ+yeLDlr/prMe/mVFH/tueuMU0He0kZGfqgLb8GIvuPZ+ZfQ7mSPuFMy
 XD6KDx6bLpBBlVhHXLtKBqJiYEsZnQ8qfEVCvBtjzMGKSgtnpQhrRj8VVFMRM1UtxnJp
 DWVqTfns5h3u+otPOI2axhekVKz6B7J+Czbd6ZEKOw+4+XltY4Go75dZZKeWaBl085R6
 yp5RuOcwh1UjKdiecIBhaalendvMGk2K33OHPwoIeIaw4Uh1uhUN9hW8IeZ8JewIX1d8
 K+DQ==
X-Gm-Message-State: APjAAAXpHQGtX1T2Ds233EPNT7cv1qVP/bavGo0hCKXMVJ0X3v6iLAkJ
 unkVk01OjVm+VA8ZOaj8AoHxMpzZ1Y721i9Jk8w=
X-Google-Smtp-Source: APXvYqz5pB8220HyxMVgiPMJuJoUzyoN9PVlmB6gQsQ8wBvLrAQJTc+KXR8QRo+B5VuKyFs+7/9smzmk/1/0rR9muL8=
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr767630wrn.52.1562324262041;
 Fri, 05 Jul 2019 03:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190705010711.23277-1-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190705010711.23277-1-marcel.apfelbaum@gmail.com>
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Date: Fri, 5 Jul 2019 16:27:29 +0530
Message-ID: <CAMzgYoNZkEYg9-OEc0p3HkZ6QYNFDR6MkE_WWx+YYduEp2FwUg@mail.gmail.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: dmitry.fleytman@gmail.com, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019 at 06:38, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
> At some point vmxnet3 live migration stopped working and git-bisect
> didn't help finding a working version.
> The issue is the PCI configuration space is not being migrated
> successfully and MSIX remains masked at destination.
>
> Remove the migration differentiation between PCI and PCIe since
> the logic resides now inside VMSTATE_PCI_DEVICE.
> Remove also the VMXNET3_COMPAT_FLAG_DISABLE_PCIE based differentiation
> since at 'realize' time is decided if the device is PCI or PCIe,
> then the above macro is enough.
>
> Use the opportunity to move to the standard VMSTATE_MSIX
> instead of the deprecated SaveVMHandlers.
>
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Tested-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>

> ---
>  hw/net/vmxnet3.c | 52 ++----------------------------------------------
>  1 file changed, 2 insertions(+), 50 deletions(-)
>
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 10d01d0058..8b17548b02 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2141,21 +2141,6 @@ vmxnet3_cleanup_msi(VMXNET3State *s)
>      msi_uninit(d);
>  }
>
> -static void
> -vmxnet3_msix_save(QEMUFile *f, void *opaque)
> -{
> -    PCIDevice *d = PCI_DEVICE(opaque);
> -    msix_save(d, f);
> -}
> -
> -static int
> -vmxnet3_msix_load(QEMUFile *f, void *opaque, int version_id)
> -{
> -    PCIDevice *d = PCI_DEVICE(opaque);
> -    msix_load(d, f);
> -    return 0;
> -}
> -
>  static const MemoryRegionOps b0_ops = {
>      .read = vmxnet3_io_bar0_read,
>      .write = vmxnet3_io_bar0_write,
> @@ -2176,11 +2161,6 @@ static const MemoryRegionOps b1_ops = {
>      },
>  };
>
> -static SaveVMHandlers savevm_vmxnet3_msix = {
> -    .save_state = vmxnet3_msix_save,
> -    .load_state = vmxnet3_msix_load,
> -};
> -
>  static uint64_t vmxnet3_device_serial_num(VMXNET3State *s)
>  {
>      uint64_t dsn_payload;
> @@ -2203,7 +2183,6 @@ static uint64_t vmxnet3_device_serial_num(VMXNET3State *s)
>
>  static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(pci_dev);
>      VMXNET3State *s = VMXNET3(pci_dev);
>      int ret;
>
> @@ -2249,8 +2228,6 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
>          pcie_dev_ser_num_init(pci_dev, VMXNET3_DSN_OFFSET,
>                                vmxnet3_device_serial_num(s));
>      }
> -
> -    register_savevm_live(dev, "vmxnet3-msix", -1, 1, &savevm_vmxnet3_msix, s);
>  }
>
>  static void vmxnet3_instance_init(Object *obj)
> @@ -2440,29 +2417,6 @@ static const VMStateDescription vmstate_vmxnet3_int_state = {
>      }
>  };
>
> -static bool vmxnet3_vmstate_need_pcie_device(void *opaque)
> -{
> -    VMXNET3State *s = VMXNET3(opaque);
> -
> -    return !(s->compat_flags & VMXNET3_COMPAT_FLAG_DISABLE_PCIE);
> -}
> -
> -static bool vmxnet3_vmstate_test_pci_device(void *opaque, int version_id)
> -{
> -    return !vmxnet3_vmstate_need_pcie_device(opaque);
> -}
> -
> -static const VMStateDescription vmstate_vmxnet3_pcie_device = {
> -    .name = "vmxnet3/pcie",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .needed = vmxnet3_vmstate_need_pcie_device,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
>  static const VMStateDescription vmstate_vmxnet3 = {
>      .name = "vmxnet3",
>      .version_id = 1,
> @@ -2470,9 +2424,8 @@ static const VMStateDescription vmstate_vmxnet3 = {
>      .pre_save = vmxnet3_pre_save,
>      .post_load = vmxnet3_post_load,
>      .fields = (VMStateField[]) {
> -            VMSTATE_STRUCT_TEST(parent_obj, VMXNET3State,
> -                                vmxnet3_vmstate_test_pci_device, 0,
> -                                vmstate_pci_device, PCIDevice),
> +            VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
> +            VMSTATE_MSIX(parent_obj, VMXNET3State),
>              VMSTATE_BOOL(rx_packets_compound, VMXNET3State),
>              VMSTATE_BOOL(rx_vlan_stripping, VMXNET3State),
>              VMSTATE_BOOL(lro_supported, VMXNET3State),
> @@ -2508,7 +2461,6 @@ static const VMStateDescription vmstate_vmxnet3 = {
>      },
>      .subsections = (const VMStateDescription*[]) {
>          &vmxstate_vmxnet3_mcast_list,
> -        &vmstate_vmxnet3_pcie_device,
>          NULL
>      }
>  };
> --
> 2.17.1
>

