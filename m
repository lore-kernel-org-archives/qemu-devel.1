Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F13CC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904BF2151B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPoR9A4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904BF2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXgl-0004cG-Du
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXdM-0000Yu-EH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:52:13 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXdE-00048W-H9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:52:12 -0400
Received: by mail-ed1-x543.google.com with SMTP id l16so7386264eds.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=caHjS/WIJjsXKLhU3sCqHfEZhFFo+eNIGG83EqXvGAs=;
 b=jPoR9A4YUehTrnAnXb+/TcQ6D6clHF0WoLaj/APwOFoGgW7vKhXziU0O+J5gmCyBGi
 TtHVrCTpzq2/jzrPBUNiweoO5KgqHl2PdimnyNe2GuMSj3EZITwLHGADIvWJbe0KKvSX
 c0q9CeRsF2uzuUWglsp5+Wgi94a2+14a3PniZxzswBquNx0F/GgI3l5rTkn2wkhW+2bX
 XWT6Jy89jAciI8IjRb3+0B6GU6hoO5iHKSXRgseudgrqTJdNVHTZZxEYdE1g2Aw6a+hz
 Ia8/hDlJMJ5MFU7dXS911aKF3XB32unmtnYXc7mtP5bLyQ/bfg9h5X4oDDn3t0doCgiE
 nKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=caHjS/WIJjsXKLhU3sCqHfEZhFFo+eNIGG83EqXvGAs=;
 b=pbxSbgZnNSVp+175Xr6BwlbR9r5HksrCNm3wjwLoOXCl0fBmx048n19GX4FqtC0bmv
 n5zeHI0bPxMHN5QE1rjpdCa0D9pcdHZ+8bl1RkYQNNHDn4h30GpFJDyCUD3t+2qFfMYd
 cXWtkfATY+Bzf+yczXtTGFpOb5UfVfnH9F2B2glN4z3GPmcy+0y2sYx8CND9esRZNlLn
 GLkz0AvmfsVcJg8ouH6hqwY3FNHoiM/I1mNbvf9JDL2TWzumQaNPRs/9byhhQILiKqw3
 /w32ZdyniO+icg/0S0StW3IwYAjdtEpP6Ih5yRQjkdR39/aYIiUgfxTUrqZUmSF5zg61
 NKFw==
X-Gm-Message-State: AOAM532pu+t1LC4JMqcU+3b4qAWlDXlnxSXUJVFhIsmpjCArijLnQeH9
 ALAkmaQQJW9OmbB/PXHN5nWlyi/Qcwn+CTlctMG416NW6XfrYQ==
X-Google-Smtp-Source: ABdhPJz1jBeTXc5mF2YK6wmu1+7GP+tVvX1bG00cmfYR3tCKQFyam6g0WD64vPDCFNMSB7vgmSeW9+/D5eALMQj5hgQ=
X-Received: by 2002:aa7:cd56:: with SMTP id v22mr3234485edw.245.1604076722566; 
 Fri, 30 Oct 2020 09:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-27-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-27-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 20:51:49 +0400
Message-ID: <CAJ+F1CJLWYuJY2S8r_ZnXk7THX=udZmd9h1n1mkoP=EyHd_=0w@mail.gmail.com>
Subject: Re: [PATCH 26/36] qdev: Move softmmu properties to
 qdev-properties-system.h
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003db96605b2e637f6"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003db96605b2e637f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:17 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Move the property types and property macros implemented in
> qdev-properties-system.c to a new qdev-properties-system.h
> header.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  audio/audio.h                       |  1 +
>  include/hw/block/block.h            |  1 +
>  include/hw/qdev-properties-system.h | 68 +++++++++++++++++++++++++++++
>  include/hw/qdev-properties.h        | 61 --------------------------
>  include/net/net.h                   |  1 +
>  hw/arm/pxa2xx.c                     |  1 +
>  hw/arm/strongarm.c                  |  1 +
>  hw/block/fdc.c                      |  1 +
>  hw/block/m25p80.c                   |  1 +
>  hw/block/nand.c                     |  1 +
>  hw/block/onenand.c                  |  1 +
>  hw/block/pflash_cfi01.c             |  1 +
>  hw/block/pflash_cfi02.c             |  1 +
>  hw/block/vhost-user-blk.c           |  1 +
>  hw/char/avr_usart.c                 |  1 +
>  hw/char/bcm2835_aux.c               |  1 +
>  hw/char/cadence_uart.c              |  1 +
>  hw/char/cmsdk-apb-uart.c            |  1 +
>  hw/char/debugcon.c                  |  1 +
>  hw/char/digic-uart.c                |  1 +
>  hw/char/escc.c                      |  1 +
>  hw/char/etraxfs_ser.c               |  1 +
>  hw/char/exynos4210_uart.c           |  1 +
>  hw/char/grlib_apbuart.c             |  1 +
>  hw/char/ibex_uart.c                 |  1 +
>  hw/char/imx_serial.c                |  1 +
>  hw/char/ipoctal232.c                |  1 +
>  hw/char/lm32_juart.c                |  1 +
>  hw/char/lm32_uart.c                 |  1 +
>  hw/char/mcf_uart.c                  |  1 +
>  hw/char/milkymist-uart.c            |  1 +
>  hw/char/nrf51_uart.c                |  1 +
>  hw/char/parallel.c                  |  1 +
>  hw/char/pl011.c                     |  1 +
>  hw/char/renesas_sci.c               |  1 +
>  hw/char/sclpconsole-lm.c            |  1 +
>  hw/char/sclpconsole.c               |  1 +
>  hw/char/serial-pci-multi.c          |  1 +
>  hw/char/serial.c                    |  1 +
>  hw/char/spapr_vty.c                 |  1 +
>  hw/char/stm32f2xx_usart.c           |  1 +
>  hw/char/terminal3270.c              |  1 +
>  hw/char/virtio-console.c            |  1 +
>  hw/char/xilinx_uartlite.c           |  1 +
>  hw/core/qdev-properties-system.c    |  1 +
>  hw/i386/kvm/i8254.c                 |  1 +
>  hw/ide/qdev.c                       |  1 +
>  hw/ipmi/ipmi_bmc_extern.c           |  1 +
>  hw/misc/ivshmem.c                   |  1 +
>  hw/misc/mac_via.c                   |  1 +
>  hw/misc/sifive_u_otp.c              |  1 +
>  hw/net/rocker/rocker.c              |  1 +
>  hw/nvram/eeprom_at24c.c             |  1 +
>  hw/nvram/spapr_nvram.c              |  1 +
>  hw/pci-bridge/gen_pcie_root_port.c  |  1 +
>  hw/pci/pci.c                        |  1 +
>  hw/ppc/pnv_pnor.c                   |  1 +
>  hw/rdma/vmw/pvrdma_main.c           |  1 +
>  hw/rtc/mc146818rtc.c                |  1 +
>  hw/scsi/scsi-disk.c                 |  1 +
>  hw/scsi/scsi-generic.c              |  1 +
>  hw/scsi/vhost-user-scsi.c           |  1 +
>  hw/sd/sd.c                          |  1 +
>  hw/usb/ccid-card-passthru.c         |  1 +
>  hw/usb/dev-serial.c                 |  1 +
>  hw/usb/redirect.c                   |  1 +
>  hw/vfio/pci.c                       |  1 +
>  hw/virtio/vhost-user-fs.c           |  1 +
>  hw/virtio/vhost-user-vsock.c        |  1 +
>  hw/virtio/virtio-iommu-pci.c        |  1 +
>  hw/xen/xen_pt.c                     |  1 +
>  migration/migration.c               |  1 +
>  72 files changed, 138 insertions(+), 61 deletions(-)
>  create mode 100644 include/hw/qdev-properties-system.h
>
> diff --git a/audio/audio.h b/audio/audio.h
> index b883ebfb1f..21fe3226ae 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -28,6 +28,7 @@
>  #include "qemu/queue.h"
>  #include "qapi/qapi-types-audio.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>
>  typedef void (*audio_callback_fn) (void *opaque, int avail);
>
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index 1e8b6253dd..c172cbe65f 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -13,6 +13,7 @@
>
>  #include "exec/hwaddr.h"
>  #include "qapi/qapi-types-block-core.h"
> +#include "hw/qdev-properties-system.h"
>
>  /* Configuration */
>
> diff --git a/include/hw/qdev-properties-system.h
> b/include/hw/qdev-properties-system.h
> new file mode 100644
> index 0000000000..0792d5236e
> --- /dev/null
> +++ b/include/hw/qdev-properties-system.h
> @@ -0,0 +1,68 @@
> +#ifndef HW_QDEV_PROPERTIES_SYSTEM_H
> +#define HW_QDEV_PROPERTIES_SYSTEM_H
> +
> +#include "hw/qdev-properties.h"
> +
> +extern const PropertyInfo qdev_prop_drive;
> +extern const PropertyInfo qdev_prop_drive_iothread;
> +extern const PropertyInfo qdev_prop_chr;
> +extern const PropertyInfo qdev_prop_macaddr;
> +extern const PropertyInfo qdev_prop_netdev;
> +extern const PropertyInfo qdev_prop_audiodev;
> +extern const PropertyInfo qdev_prop_losttickpolicy;
> +extern const PropertyInfo qdev_prop_blocksize;
> +extern const PropertyInfo qdev_prop_blockdev_on_error;
> +extern const PropertyInfo qdev_prop_bios_chs_trans;
> +extern const PropertyInfo qdev_prop_fdc_drive_type;
> +extern const PropertyInfo qdev_prop_multifd_compression;
> +extern const PropertyInfo qdev_prop_reserved_region;
> +extern const PropertyInfo qdev_prop_pci_devfn;
> +extern const PropertyInfo qdev_prop_pci_host_devaddr;
> +extern const PropertyInfo qdev_prop_off_auto_pcibar;
> +extern const PropertyInfo qdev_prop_pcie_link_speed;
> +extern const PropertyInfo qdev_prop_pcie_link_width;
> +
> +#define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
> +#define DEFINE_PROP_CHR(_n, _s, _f)             \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
> +#define DEFINE_PROP_NETDEV(_n, _s, _f)             \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)
> +#define DEFINE_PROP_DRIVE(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_drive, BlockBackend *)
> +#define DEFINE_PROP_DRIVE_IOTHREAD(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
> +#define DEFINE_PROP_MACADDR(_n, _s, _f)         \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
> +#define DEFINE_PROP_RESERVED_REGION(_n, _s, _f)         \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_reserved_region, ReservedRegion)
> +#define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compression, \
> +                       MultiFDCompression)
> +#define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
> +                        LostTickPolicy)
> +#define DEFINE_PROP_BLOCKDEV_ON_ERROR(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_blockdev_on_error, \
> +                        BlockdevOnError)
> +#define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
> +#define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
> +#define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr,
> PCIHostDeviceAddress)
> +#define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
> +                        OffAutoPCIBAR)
> +#define DEFINE_PROP_PCIE_LINK_SPEED(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_speed, \
> +                        PCIExpLinkSpeed)
> +#define DEFINE_PROP_PCIE_LINK_WIDTH(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_width, \
> +                        PCIExpLinkWidth)
> +#define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
> +
> +
> +
> +#endif
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 4146dac281..3a7b4c8643 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -55,30 +55,12 @@ extern const PropertyInfo qdev_prop_uint64;
>  extern const PropertyInfo qdev_prop_int64;
>  extern const PropertyInfo qdev_prop_size;
>  extern const PropertyInfo qdev_prop_string;
> -extern const PropertyInfo qdev_prop_chr;
>  extern const PropertyInfo qdev_prop_tpm;
> -extern const PropertyInfo qdev_prop_macaddr;
> -extern const PropertyInfo qdev_prop_reserved_region;
>  extern const PropertyInfo qdev_prop_on_off_auto;
> -extern const PropertyInfo qdev_prop_multifd_compression;
> -extern const PropertyInfo qdev_prop_losttickpolicy;
> -extern const PropertyInfo qdev_prop_blockdev_on_error;
> -extern const PropertyInfo qdev_prop_bios_chs_trans;
> -extern const PropertyInfo qdev_prop_fdc_drive_type;
> -extern const PropertyInfo qdev_prop_drive;
> -extern const PropertyInfo qdev_prop_drive_iothread;
> -extern const PropertyInfo qdev_prop_netdev;
> -extern const PropertyInfo qdev_prop_pci_devfn;
>  extern const PropertyInfo qdev_prop_size32;
> -extern const PropertyInfo qdev_prop_blocksize;
> -extern const PropertyInfo qdev_prop_pci_host_devaddr;
>  extern const PropertyInfo qdev_prop_uuid;
>  extern const PropertyInfo qdev_prop_arraylen;
> -extern const PropertyInfo qdev_prop_audiodev;
>  extern const PropertyInfo qdev_prop_link;
> -extern const PropertyInfo qdev_prop_off_auto_pcibar;
> -extern const PropertyInfo qdev_prop_pcie_link_speed;
> -extern const PropertyInfo qdev_prop_pcie_link_width;
>
>  #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
>          .name      =3D (_name),                                    \
> @@ -209,52 +191,12 @@ extern const PropertyInfo qdev_prop_pcie_link_width=
;
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
>  #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
> -#define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
> -
> -#define DEFINE_PROP_CHR(_n, _s, _f)             \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
>  #define DEFINE_PROP_STRING(_n, _s, _f)             \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
> -#define DEFINE_PROP_NETDEV(_n, _s, _f)             \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)
> -#define DEFINE_PROP_DRIVE(_n, _s, _f) \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_drive, BlockBackend *)
> -#define DEFINE_PROP_DRIVE_IOTHREAD(_n, _s, _f) \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
> -#define DEFINE_PROP_MACADDR(_n, _s, _f)         \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
> -#define DEFINE_PROP_RESERVED_REGION(_n, _s, _f)         \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_reserved_region, ReservedRegion)
>  #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
> -#define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compression, \
> -                       MultiFDCompression)
> -#define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
> -                        LostTickPolicy)
> -#define DEFINE_PROP_BLOCKDEV_ON_ERROR(_n, _s, _f, _d) \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_blockdev_on_error, \
> -                        BlockdevOnError)
> -#define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
>  #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
> -#define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
> -#define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr,
> PCIHostDeviceAddress)
> -#define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
> -                        OffAutoPCIBAR)
> -#define DEFINE_PROP_PCIE_LINK_SPEED(_n, _s, _f, _d) \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_speed, \
> -                        PCIExpLinkSpeed)
> -#define DEFINE_PROP_PCIE_LINK_WIDTH(_n, _s, _f, _d) \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_width, \
> -                        PCIExpLinkWidth)
> -
>  #define DEFINE_PROP_UUID(_name, _state, _field) {                  \
>          .name      =3D (_name),                                      \
>          .info      =3D &qdev_prop_uuid,                              \
> @@ -262,9 +204,6 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>              + type_check(QemuUUID, typeof_field(_state, _field)),  \
>          .set_default =3D true,                                       \
>          }
> -#define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
> -
>  #define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) {        \
>          .name      =3D (_name),                                      \
>          .info      =3D &qdev_prop_uuid,                              \
> diff --git a/include/net/net.h b/include/net/net.h
> index 897b2d7595..da48bc8254 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -4,6 +4,7 @@
>  #include "qemu/queue.h"
>  #include "qapi/qapi-types-net.h"
>  #include "net/queue.h"
> +#include "hw/qdev-properties-system.h"
>
>  #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
>  #define MAC_ARG(x) ((uint8_t *)(x))[0], ((uint8_t *)(x))[1], \
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index 591776ba88..9c8030a271 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -21,6 +21,7 @@
>  #include "hw/i2c/i2c.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/ssi/ssi.h"
>  #include "hw/sd/sd.h"
>  #include "chardev/char-fe.h"
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index ca7c385f31..c7ca54bcea 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -33,6 +33,7 @@
>  #include "hw/boards.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "strongarm.h"
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 4c2c35e223..3636874432 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -36,6 +36,7 @@
>  #include "hw/irq.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "hw/block/block.h"
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 483925f57a..0ef7f00cb6 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -25,6 +25,7 @@
>  #include "qemu/units.h"
>  #include "sysemu/block-backend.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/ssi/ssi.h"
>  #include "migration/vmstate.h"
>  #include "qemu/bitops.h"
> diff --git a/hw/block/nand.c b/hw/block/nand.c
> index bcceb64ebb..5558f5d2fa 100644
> --- a/hw/block/nand.c
> +++ b/hw/block/nand.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/block/flash.h"
>  #include "sysemu/block-backend.h"
>  #include "migration/vmstate.h"
> diff --git a/hw/block/onenand.c b/hw/block/onenand.c
> index 5ff7be86bb..579a73d7f7 100644
> --- a/hw/block/onenand.c
> +++ b/hw/block/onenand.c
> @@ -24,6 +24,7 @@
>  #include "hw/block/flash.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "sysemu/block-backend.h"
>  #include "exec/memory.h"
>  #include "hw/sysbus.h"
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index f0fcd63f84..90baa72f82 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -40,6 +40,7 @@
>  #include "hw/block/block.h"
>  #include "hw/block/flash.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "sysemu/block-backend.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index eb02fccfa5..e2d8a004fe 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -36,6 +36,7 @@
>  #include "hw/block/block.h"
>  #include "hw/block/flash.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/bitmap.h"
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index a076b1e54d..492dc73275 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -22,6 +22,7 @@
>  #include "qemu/cutils.h"
>  #include "hw/qdev-core.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/vhost-user-blk.h"
>  #include "hw/virtio/virtio.h"
> diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
> index fbe2a112b7..5bcf9db0b7 100644
> --- a/hw/char/avr_usart.c
> +++ b/hw/char/avr_usart.c
> @@ -24,6 +24,7 @@
>  #include "qemu/log.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>
>  static int avr_usart_can_receive(void *opaque)
>  {
> diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> index dade2ab5fd..96410b1ff8 100644
> --- a/hw/char/bcm2835_aux.c
> +++ b/hw/char/bcm2835_aux.c
> @@ -24,6 +24,7 @@
>  #include "hw/char/bcm2835_aux.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index e196906c92..c603e14012 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -32,6 +32,7 @@
>  #include "hw/char/cadence_uart.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-clock.h"
> +#include "hw/qdev-properties-system.h"
>  #include "trace.h"
>
>  #ifdef CADENCE_UART_ERR_DEBUG
> diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
> index 626b68f2ec..ba2cbbee3d 100644
> --- a/hw/char/cmsdk-apb-uart.c
> +++ b/hw/char/cmsdk-apb-uart.c
> @@ -27,6 +27,7 @@
>  #include "chardev/char-serial.h"
>  #include "hw/char/cmsdk-apb-uart.h"
>  #include "hw/irq.h"
> +#include "hw/qdev-properties-system.h"
>
>  REG32(DATA, 0)
>  REG32(STATE, 4)
> diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
> index 2a063ad72c..fdb04fee09 100644
> --- a/hw/char/debugcon.c
> +++ b/hw/char/debugcon.c
> @@ -30,6 +30,7 @@
>  #include "chardev/char-fe.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "qom/object.h"
>
>  #define TYPE_ISA_DEBUGCON_DEVICE "isa-debugcon"
> diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
> index e130cb4692..00e5df5517 100644
> --- a/hw/char/digic-uart.c
> +++ b/hw/char/digic-uart.c
> @@ -35,6 +35,7 @@
>
>  #include "hw/char/digic-uart.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>
>  enum {
>      ST_RX_RDY =3D (1 << 0),
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 7d16ee8688..52e7978287 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
> diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
> index d9fba2ae6c..6bee3ee18e 100644
> --- a/hw/char/etraxfs_ser.c
> +++ b/hw/char/etraxfs_ser.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/sysbus.h"
>  #include "chardev/char-fe.h"
>  #include "qemu/log.h"
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index 96afe3580f..6361df2ad3 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -32,6 +32,7 @@
>  #include "hw/arm/exynos4210.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>
>  #include "trace.h"
>  #include "qom/object.h"
> diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
> index 3f80f6824e..82ff40a530 100644
> --- a/hw/char/grlib_apbuart.c
> +++ b/hw/char/grlib_apbuart.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/sparc/grlib.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
> diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
> index cc49a35013..89f1182c9b 100644
> --- a/hw/char/ibex_uart.c
> +++ b/hw/char/ibex_uart.c
> @@ -30,6 +30,7 @@
>  #include "hw/irq.h"
>  #include "hw/qdev-clock.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
> index 731b8fc64c..ee1375e26d 100644
> --- a/hw/char/imx_serial.c
> +++ b/hw/char/imx_serial.c
> @@ -22,6 +22,7 @@
>  #include "hw/char/imx_serial.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
> index ad000a39b9..3311e0872c 100644
> --- a/hw/char/ipoctal232.c
> +++ b/hw/char/ipoctal232.c
> @@ -12,6 +12,7 @@
>  #include "hw/ipack/ipack.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "qemu/bitops.h"
>  #include "qemu/module.h"
> diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
> index b97aacba91..c5ead05e08 100644
> --- a/hw/char/lm32_juart.c
> +++ b/hw/char/lm32_juart.c
> @@ -26,6 +26,7 @@
>
>  #include "hw/char/lm32_juart.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "qom/object.h"
>
>  enum {
> diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
> index 0e8b4e46a3..5cb87de548 100644
> --- a/hw/char/lm32_uart.c
> +++ b/hw/char/lm32_uart.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
> index e6814faffb..6fa4ac502c 100644
> --- a/hw/char/mcf_uart.c
> +++ b/hw/char/mcf_uart.c
> @@ -13,6 +13,7 @@
>  #include "qapi/error.h"
>  #include "hw/m68k/mcf.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "chardev/char-fe.h"
>  #include "qom/object.h"
>
> diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
> index 1e83dbcafa..09e2f6bd76 100644
> --- a/hw/char/milkymist-uart.c
> +++ b/hw/char/milkymist-uart.c
> @@ -24,6 +24,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
> index d1fef77acd..045ca5fa40 100644
> --- a/hw/char/nrf51_uart.c
> +++ b/hw/char/nrf51_uart.c
> @@ -18,6 +18,7 @@
>  #include "hw/char/nrf51_uart.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
>
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index 8b418abf71..b45e67bfbb 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -32,6 +32,7 @@
>  #include "hw/irq.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "hw/char/parallel.h"
>  #include "sysemu/reset.h"
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index ede16c781c..ea4a4e5235 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -23,6 +23,7 @@
>  #include "hw/irq.h"
>  #include "hw/sysbus.h"
>  #include "hw/qdev-clock.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "chardev/char-fe.h"
>  #include "qemu/log.h"
> diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
> index 5d7c6e6523..1c63467290 100644
> --- a/hw/char/renesas_sci.c
> +++ b/hw/char/renesas_sci.c
> @@ -26,6 +26,7 @@
>  #include "hw/irq.h"
>  #include "hw/registerfields.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/char/renesas_sci.h"
>  #include "migration/vmstate.h"
>
> diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> index 81f6d0ed4f..b9e9b2d453 100644
> --- a/hw/char/sclpconsole-lm.c
> +++ b/hw/char/sclpconsole-lm.c
> @@ -23,6 +23,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/s390x/event-facility.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/s390x/ebcdic.h"
>  #include "qom/object.h"
>
> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> index aa72ab40b9..c36b572222 100644
> --- a/hw/char/sclpconsole.c
> +++ b/hw/char/sclpconsole.c
> @@ -20,6 +20,7 @@
>  #include "hw/s390x/sclp.h"
>  #include "migration/vmstate.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/s390x/event-facility.h"
>  #include "chardev/char-fe.h"
>  #include "qom/object.h"
> diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> index 2cf3e44177..3a9f96c2d1 100644
> --- a/hw/char/serial-pci-multi.c
> +++ b/hw/char/serial-pci-multi.c
> @@ -33,6 +33,7 @@
>  #include "hw/irq.h"
>  #include "hw/pci/pci.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>
>  #define PCI_SERIAL_MAX_PORTS 4
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 97f71879ff..d99daa7695 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -35,6 +35,7 @@
>  #include "qemu/error-report.h"
>  #include "trace.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>
>  #define UART_LCR_DLAB  0x80    /* Divisor latch access bit */
>
> diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
> index e726d4d915..79eaa2fa52 100644
> --- a/hw/char/spapr_vty.c
> +++ b/hw/char/spapr_vty.c
> @@ -8,6 +8,7 @@
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_vio.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "qom/object.h"
>
>  #define VTERM_BUFSIZE   16
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index 0d661be6d3..8df0832424 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -26,6 +26,7 @@
>  #include "hw/char/stm32f2xx_usart.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>
> diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
> index d77981bb6d..a9a46c8ed3 100644
> --- a/hw/char/terminal3270.c
> +++ b/hw/char/terminal3270.c
> @@ -16,6 +16,7 @@
>  #include "qemu/module.h"
>  #include "chardev/char-fe.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/s390x/3270-ccw.h"
>  #include "qom/object.h"
>
> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> index bc752cf90f..6b132caa29 100644
> --- a/hw/char/virtio-console.c
> +++ b/hw/char/virtio-console.c
> @@ -16,6 +16,7 @@
>  #include "qemu/module.h"
>  #include "trace.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/virtio/virtio-serial.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-char.h"
> diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
> index 2e773ec4c4..99b9a6f851 100644
> --- a/hw/char/xilinx_uartlite.c
> +++ b/hw/char/xilinx_uartlite.c
> @@ -26,6 +26,7 @@
>  #include "qemu/log.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
>  #include "chardev/char-fe.h"
> diff --git a/hw/core/qdev-properties-system.c
> b/hw/core/qdev-properties-system.c
> index 448d77ecab..8cfa9a3d20 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -12,6 +12,7 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "qapi/qapi-types-block.h"
> diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
> index 40d84734e7..c73254e886 100644
> --- a/hw/i386/kvm/i8254.c
> +++ b/hw/i386/kvm/i8254.c
> @@ -32,6 +32,7 @@
>  #include "sysemu/runstate.h"
>  #include "hw/timer/i8254.h"
>  #include "hw/timer/i8254_internal.h"
> +#include "hw/qdev-properties-system.h"
>  #include "sysemu/kvm.h"
>  #include "qom/object.h"
>
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 27ff1f7f66..73499a6235 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -26,6 +26,7 @@
>  #include "qemu/module.h"
>  #include "hw/ide/internal.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "hw/block/block.h"
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index c3f3306e66..e141a5cd45 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -35,6 +35,7 @@
>  #include "chardev/char-fe.h"
>  #include "hw/ipmi/ipmi.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "qom/object.h"
>
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index e321e5cb69..0505b52c98 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -23,6 +23,7 @@
>  #include "qemu/cutils.h"
>  #include "hw/pci/pci.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  #include "sysemu/kvm.h"
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 6db62dab7d..488d086a17 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -28,6 +28,7 @@
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "sysemu/block-backend.h"
>  #include "trace.h"
>  #include "qemu/log.h"
> diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
> index 60066375ab..4401787a5c 100644
> --- a/hw/misc/sifive_u_otp.c
> +++ b/hw/misc/sifive_u_otp.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/sysbus.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 1af1e6fa2f..0fb8db1dee 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -18,6 +18,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/pci/pci.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "hw/pci/msix.h"
>  #include "net/net.h"
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index 3e93dbbffb..af6f5dbb99 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -13,6 +13,7 @@
>  #include "qemu/module.h"
>  #include "hw/i2c/i2c.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "sysemu/block-backend.h"
>  #include "qom/object.h"
>
> diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
> index fc53a42572..9e51bc82ae 100644
> --- a/hw/nvram/spapr_nvram.c
> +++ b/hw/nvram/spapr_nvram.c
> @@ -39,6 +39,7 @@
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_vio.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "qom/object.h"
>
>  struct SpaprNvram {
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c
> b/hw/pci-bridge/gen_pcie_root_port.c
> index 8931afc049..ec9907917e 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -16,6 +16,7 @@
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pcie_port.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "qom/object.h"
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 100c9381c2..2cd644285c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -30,6 +30,7 @@
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_host.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/qemu-file-types.h"
>  #include "migration/vmstate.h"
>  #include "monitor/monitor.h"
> diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
> index c365ee58b8..ef8dff03e0 100644
> --- a/hw/ppc/pnv_pnor.c
> +++ b/hw/ppc/pnv_pnor.c
> @@ -17,6 +17,7 @@
>  #include "hw/loader.h"
>  #include "hw/ppc/pnv_pnor.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>
>  static uint64_t pnv_pnor_read(void *opaque, hwaddr addr, unsigned size)
>  {
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 77b1235a3f..8593570332 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -21,6 +21,7 @@
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "cpu.h"
>  #include "trace.h"
>  #include "monitor/monitor.h"
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index 7a38540cb9..5d0fcacd0c 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -30,6 +30,7 @@
>  #include "hw/acpi/aml-build.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "qemu/timer.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/replay.h"
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index e859534eaf..f9a591cd17 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -34,6 +34,7 @@
>  #include "sysemu/blockdev.h"
>  #include "hw/block/block.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "sysemu/dma.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/cutils.h"
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index 2cb23ca891..9740f7e36a 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -19,6 +19,7 @@
>  #include "hw/scsi/scsi.h"
>  #include "migration/qemu-file-types.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/scsi/emulation.h"
>  #include "sysemu/block-backend.h"
>  #include "trace.h"
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 7c0631656c..4666019442 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -21,6 +21,7 @@
>  #include "hw/fw-path-provider.h"
>  #include "hw/qdev-core.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/vhost-backend.h"
>  #include "hw/virtio/vhost-user-scsi.h"
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 3091382614..fa07398c8c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -42,6 +42,7 @@
>  #include "qapi/error.h"
>  #include "qemu/bitmap.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
>  #include "qemu/log.h"
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index e8e9d37e88..c27c602697 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -14,6 +14,7 @@
>  #include <libcacard.h>
>  #include "chardev/char-fe.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index b1622b7c7f..504e1ef423 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -14,6 +14,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/usb.h"
>  #include "migration/vmstate.h"
>  #include "desc.h"
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index 3238de6bb8..0b7e0e15f4 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -42,6 +42,7 @@
>  #include <usbredirfilter.h>
>
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/usb.h"
>  #include "migration/qemu-file-types.h"
>  #include "migration/vmstate.h"
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 0d83eb0e47..2e7e4bd6c7 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -27,6 +27,7 @@
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index 1bc5d03a00..ed036ad9c1 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -16,6 +16,7 @@
>  #include "standard-headers/linux/virtio_fs.h"
>  #include "qapi/error.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
> index 3534a39d62..a6f08c26b9 100644
> --- a/hw/virtio/vhost-user-vsock.c
> +++ b/hw/virtio/vhost-user-vsock.c
> @@ -13,6 +13,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/virtio/vhost-user-vsock.h"
>
>  static const int user_feature_bits[] =3D {
> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
> index 378f63b210..770c286be7 100644
> --- a/hw/virtio/virtio-iommu-pci.c
> +++ b/hw/virtio/virtio-iommu-pci.c
> @@ -14,6 +14,7 @@
>  #include "virtio-pci.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "qapi/error.h"
>  #include "hw/boards.h"
>  #include "qom/object.h"
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index 6d359ee486..3cbd08b10e 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -58,6 +58,7 @@
>
>  #include "hw/pci/pci.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/xen/xen.h"
>  #include "hw/i386/pc.h"
>  #include "hw/xen/xen-legacy-backend.h"
> diff --git a/migration/migration.c b/migration/migration.c
> index 9bb4fee5ac..071e35ed44 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -52,6 +52,7 @@
>  #include "migration/colo.h"
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "monitor/monitor.h"
>  #include "net/announce.h"
>  #include "qemu/queue.h"
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000003db96605b2e637f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:17 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Mo=
ve the property types and property macros implemented in<br>
qdev-properties-system.c to a new qdev-properties-system.h<br>
header.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt=
;</div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0audio/audio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0include/hw/block/block.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
=C2=A0include/hw/qdev-properties-system.h | 68 ++++++++++++++++++++++++++++=
+<br>
=C2=A0include/hw/qdev-properties.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 61 --------=
------------------<br>
=C2=A0include/net/net.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/arm/pxa2xx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/arm/strongarm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/block/fdc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/block/m25p80.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/block/nand.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/block/onenand.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/block/pflash_cfi01.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 1 +<br>
=C2=A0hw/block/pflash_cfi02.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 1 +<br>
=C2=A0hw/block/vhost-user-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0hw/char/avr_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/char/bcm2835_aux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/char/cadence_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/cmsdk-apb-uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
=C2=A0hw/char/debugcon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/digic-uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/escc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/etraxfs_ser.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/char/exynos4210_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0hw/char/grlib_apbuart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 1 +<br>
=C2=A0hw/char/ibex_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/char/imx_serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/ipoctal232.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/lm32_juart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/lm32_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/char/mcf_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/milkymist-uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
=C2=A0hw/char/nrf51_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/parallel.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/pl011.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/char/renesas_sci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/char/sclpconsole-lm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
=C2=A0hw/char/sclpconsole.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/char/serial-pci-multi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
1 +<br>
=C2=A0hw/char/serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/spapr_vty.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/char/stm32f2xx_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0hw/char/terminal3270.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1 +<br>
=C2=A0hw/char/virtio-console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
=C2=A0hw/char/xilinx_uartlite.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0hw/core/qdev-properties-system.c=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/i386/kvm/i8254.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/ide/qdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/ipmi/ipmi_bmc_extern.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0hw/misc/ivshmem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/misc/mac_via.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/misc/sifive_u_otp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1 +<br>
=C2=A0hw/net/rocker/rocker.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1 +<br>
=C2=A0hw/nvram/eeprom_at24c.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 1 +<br>
=C2=A0hw/nvram/spapr_nvram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1 +<br>
=C2=A0hw/pci-bridge/gen_pcie_root_port.c=C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/pci/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/ppc/pnv_pnor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/rdma/vmw/pvrdma_main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0hw/rtc/mc146818rtc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/scsi/scsi-disk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/scsi/scsi-generic.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1 +<br>
=C2=A0hw/scsi/vhost-user-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0hw/sd/sd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/usb/ccid-card-passthru.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
1 +<br>
=C2=A0hw/usb/dev-serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/usb/redirect.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/vfio/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0hw/virtio/vhost-user-fs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0hw/virtio/vhost-user-vsock.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<b=
r>
=C2=A0hw/virtio/virtio-iommu-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<b=
r>
=C2=A0hw/xen/xen_pt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0migration/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 1 +<br>
=C2=A072 files changed, 138 insertions(+), 61 deletions(-)<br>
=C2=A0create mode 100644 include/hw/qdev-properties-system.h<br>
<br>
diff --git a/audio/audio.h b/audio/audio.h<br>
index b883ebfb1f..21fe3226ae 100644<br>
--- a/audio/audio.h<br>
+++ b/audio/audio.h<br>
@@ -28,6 +28,7 @@<br>
=C2=A0#include &quot;qemu/queue.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-types-audio.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
<br>
=C2=A0typedef void (*audio_callback_fn) (void *opaque, int avail);<br>
<br>
diff --git a/include/hw/block/block.h b/include/hw/block/block.h<br>
index 1e8b6253dd..c172cbe65f 100644<br>
--- a/include/hw/block/block.h<br>
+++ b/include/hw/block/block.h<br>
@@ -13,6 +13,7 @@<br>
<br>
=C2=A0#include &quot;exec/hwaddr.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-types-block-core.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
<br>
=C2=A0/* Configuration */<br>
<br>
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properti=
es-system.h<br>
new file mode 100644<br>
index 0000000000..0792d5236e<br>
--- /dev/null<br>
+++ b/include/hw/qdev-properties-system.h<br>
@@ -0,0 +1,68 @@<br>
+#ifndef HW_QDEV_PROPERTIES_SYSTEM_H<br>
+#define HW_QDEV_PROPERTIES_SYSTEM_H<br>
+<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+<br>
+extern const PropertyInfo qdev_prop_drive;<br>
+extern const PropertyInfo qdev_prop_drive_iothread;<br>
+extern const PropertyInfo qdev_prop_chr;<br>
+extern const PropertyInfo qdev_prop_macaddr;<br>
+extern const PropertyInfo qdev_prop_netdev;<br>
+extern const PropertyInfo qdev_prop_audiodev;<br>
+extern const PropertyInfo qdev_prop_losttickpolicy;<br>
+extern const PropertyInfo qdev_prop_blocksize;<br>
+extern const PropertyInfo qdev_prop_blockdev_on_error;<br>
+extern const PropertyInfo qdev_prop_bios_chs_trans;<br>
+extern const PropertyInfo qdev_prop_fdc_drive_type;<br>
+extern const PropertyInfo qdev_prop_multifd_compression;<br>
+extern const PropertyInfo qdev_prop_reserved_region;<br>
+extern const PropertyInfo qdev_prop_pci_devfn;<br>
+extern const PropertyInfo qdev_prop_pci_host_devaddr;<br>
+extern const PropertyInfo qdev_prop_off_auto_pcibar;<br>
+extern const PropertyInfo qdev_prop_pcie_link_speed;<br>
+extern const PropertyInfo qdev_prop_pcie_link_width;<br>
+<br>
+#define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int3=
2_t)<br>
+#define DEFINE_PROP_CHR(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)<br>
+#define DEFINE_PROP_NETDEV(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)<br>
+#define DEFINE_PROP_DRIVE(_n, _s, _f) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_drive, BlockBackend *)<br>
+#define DEFINE_PROP_DRIVE_IOTHREAD(_n, _s, _f) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBacke=
nd *)<br>
+#define DEFINE_PROP_MACADDR(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\=
<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)<br>
+#define DEFINE_PROP_RESERVED_REGION(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0\<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_reserved_region, ReservedR=
egion)<br>
+#define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compres=
sion, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MultiFDCompression)<br>
+#define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy,=
 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 LostTickPolicy)<br>
+#define DEFINE_PROP_BLOCKDEV_ON_ERROR(_n, _s, _f, _d) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_blockdev_on_err=
or, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BlockdevOnError)<br>
+#define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans,=
 int)<br>
+#define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uin=
t32_t)<br>
+#define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostD=
eviceAddress)<br>
+#define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar=
, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OffAutoPCIBAR)<br>
+#define DEFINE_PROP_PCIE_LINK_SPEED(_n, _s, _f, _d) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_speed=
, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 PCIExpLinkSpeed)<br>
+#define DEFINE_PROP_PCIE_LINK_WIDTH(_n, _s, _f, _d) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_width=
, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 PCIExpLinkWidth)<br>
+#define DEFINE_PROP_AUDIODEV(_n, _s, _f) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)<b=
r>
+<br>
+<br>
+<br>
+#endif<br>
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h<br=
>
index 4146dac281..3a7b4c8643 100644<br>
--- a/include/hw/qdev-properties.h<br>
+++ b/include/hw/qdev-properties.h<br>
@@ -55,30 +55,12 @@ extern const PropertyInfo qdev_prop_uint64;<br>
=C2=A0extern const PropertyInfo qdev_prop_int64;<br>
=C2=A0extern const PropertyInfo qdev_prop_size;<br>
=C2=A0extern const PropertyInfo qdev_prop_string;<br>
-extern const PropertyInfo qdev_prop_chr;<br>
=C2=A0extern const PropertyInfo qdev_prop_tpm;<br>
-extern const PropertyInfo qdev_prop_macaddr;<br>
-extern const PropertyInfo qdev_prop_reserved_region;<br>
=C2=A0extern const PropertyInfo qdev_prop_on_off_auto;<br>
-extern const PropertyInfo qdev_prop_multifd_compression;<br>
-extern const PropertyInfo qdev_prop_losttickpolicy;<br>
-extern const PropertyInfo qdev_prop_blockdev_on_error;<br>
-extern const PropertyInfo qdev_prop_bios_chs_trans;<br>
-extern const PropertyInfo qdev_prop_fdc_drive_type;<br>
-extern const PropertyInfo qdev_prop_drive;<br>
-extern const PropertyInfo qdev_prop_drive_iothread;<br>
-extern const PropertyInfo qdev_prop_netdev;<br>
-extern const PropertyInfo qdev_prop_pci_devfn;<br>
=C2=A0extern const PropertyInfo qdev_prop_size32;<br>
-extern const PropertyInfo qdev_prop_blocksize;<br>
-extern const PropertyInfo qdev_prop_pci_host_devaddr;<br>
=C2=A0extern const PropertyInfo qdev_prop_uuid;<br>
=C2=A0extern const PropertyInfo qdev_prop_arraylen;<br>
-extern const PropertyInfo qdev_prop_audiodev;<br>
=C2=A0extern const PropertyInfo qdev_prop_link;<br>
-extern const PropertyInfo qdev_prop_off_auto_pcibar;<br>
-extern const PropertyInfo qdev_prop_pcie_link_speed;<br>
-extern const PropertyInfo qdev_prop_pcie_link_width;<br>
<br>
=C2=A0#define DEFINE_PROP(_name, _state, _field, _prop, _type) { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =3D (_name),=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
@@ -209,52 +191,12 @@ extern const PropertyInfo qdev_prop_pcie_link_width;<=
br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int=
64_t)<br>
=C2=A0#define DEFINE_PROP_SIZE(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, ui=
nt64_t)<br>
-#define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int3=
2_t)<br>
-<br>
-#define DEFINE_PROP_CHR(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)<br>
=C2=A0#define DEFINE_PROP_STRING(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)<br>
-#define DEFINE_PROP_NETDEV(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)<br>
-#define DEFINE_PROP_DRIVE(_n, _s, _f) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_drive, BlockBackend *)<br>
-#define DEFINE_PROP_DRIVE_IOTHREAD(_n, _s, _f) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBacke=
nd *)<br>
-#define DEFINE_PROP_MACADDR(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\=
<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)<br>
-#define DEFINE_PROP_RESERVED_REGION(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_reserved_region, ReservedR=
egion)<br>
=C2=A0#define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_aut=
o, OnOffAuto)<br>
-#define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compres=
sion, \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MultiFDCompression)<br>
-#define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy,=
 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 LostTickPolicy)<br>
-#define DEFINE_PROP_BLOCKDEV_ON_ERROR(_n, _s, _f, _d) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_blockdev_on_err=
or, \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BlockdevOnError)<br>
-#define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans,=
 int)<br>
=C2=A0#define DEFINE_PROP_SIZE32(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, =
uint32_t)<br>
-#define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uin=
t32_t)<br>
-#define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostD=
eviceAddress)<br>
-#define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar=
, \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OffAutoPCIBAR)<br>
-#define DEFINE_PROP_PCIE_LINK_SPEED(_n, _s, _f, _d) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_speed=
, \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 PCIExpLinkSpeed)<br>
-#define DEFINE_PROP_PCIE_LINK_WIDTH(_n, _s, _f, _d) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_width=
, \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 PCIExpLinkWidth)<br>
-<br>
=C2=A0#define DEFINE_PROP_UUID(_name, _state, _field) {=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =3D (_name),=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info=C2=A0 =C2=A0 =C2=A0 =3D &amp;qdev_p=
rop_uuid,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
@@ -262,9 +204,6 @@ extern const PropertyInfo qdev_prop_pcie_link_width;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ type_check(QemuUUID, type=
of_field(_state, _field)),=C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_default =3D true,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-#define DEFINE_PROP_AUDIODEV(_n, _s, _f) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)<b=
r>
-<br>
=C2=A0#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) {=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =3D (_name),=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info=C2=A0 =C2=A0 =C2=A0 =3D &amp;qdev_p=
rop_uuid,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
diff --git a/include/net/net.h b/include/net/net.h<br>
index 897b2d7595..da48bc8254 100644<br>
--- a/include/net/net.h<br>
+++ b/include/net/net.h<br>
@@ -4,6 +4,7 @@<br>
=C2=A0#include &quot;qemu/queue.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-types-net.h&quot;<br>
=C2=A0#include &quot;net/queue.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
<br>
=C2=A0#define MAC_FMT &quot;%02X:%02X:%02X:%02X:%02X:%02X&quot;<br>
=C2=A0#define MAC_ARG(x) ((uint8_t *)(x))[0], ((uint8_t *)(x))[1], \<br>
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c<br>
index 591776ba88..9c8030a271 100644<br>
--- a/hw/arm/pxa2xx.c<br>
+++ b/hw/arm/pxa2xx.c<br>
@@ -21,6 +21,7 @@<br>
=C2=A0#include &quot;hw/i2c/i2c.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/ssi/ssi.h&quot;<br>
=C2=A0#include &quot;hw/sd/sd.h&quot;<br>
=C2=A0#include &quot;chardev/char-fe.h&quot;<br>
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c<br>
index ca7c385f31..c7ca54bcea 100644<br>
--- a/hw/arm/strongarm.c<br>
+++ b/hw/arm/strongarm.c<br>
@@ -33,6 +33,7 @@<br>
=C2=A0#include &quot;hw/boards.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;strongarm.h&quot;<br>
diff --git a/hw/block/fdc.c b/hw/block/fdc.c<br>
index 4c2c35e223..3636874432 100644<br>
--- a/hw/block/fdc.c<br>
+++ b/hw/block/fdc.c<br>
@@ -36,6 +36,7 @@<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/isa/isa.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;hw/block/block.h&quot;<br>
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c<br>
index 483925f57a..0ef7f00cb6 100644<br>
--- a/hw/block/m25p80.c<br>
+++ b/hw/block/m25p80.c<br>
@@ -25,6 +25,7 @@<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
=C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/ssi/ssi.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qemu/bitops.h&quot;<br>
diff --git a/hw/block/nand.c b/hw/block/nand.c<br>
index bcceb64ebb..5558f5d2fa 100644<br>
--- a/hw/block/nand.c<br>
+++ b/hw/block/nand.c<br>
@@ -21,6 +21,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;hw/hw.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/block/flash.h&quot;<br>
=C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
diff --git a/hw/block/onenand.c b/hw/block/onenand.c<br>
index 5ff7be86bb..579a73d7f7 100644<br>
--- a/hw/block/onenand.c<br>
+++ b/hw/block/onenand.c<br>
@@ -24,6 +24,7 @@<br>
=C2=A0#include &quot;hw/block/flash.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
=C2=A0#include &quot;exec/memory.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c<br>
index f0fcd63f84..90baa72f82 100644<br>
--- a/hw/block/pflash_cfi01.c<br>
+++ b/hw/block/pflash_cfi01.c<br>
@@ -40,6 +40,7 @@<br>
=C2=A0#include &quot;hw/block/block.h&quot;<br>
=C2=A0#include &quot;hw/block/flash.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c<br>
index eb02fccfa5..e2d8a004fe 100644<br>
--- a/hw/block/pflash_cfi02.c<br>
+++ b/hw/block/pflash_cfi02.c<br>
@@ -36,6 +36,7 @@<br>
=C2=A0#include &quot;hw/block/block.h&quot;<br>
=C2=A0#include &quot;hw/block/flash.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/bitmap.h&quot;<br>
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c<br>
index a076b1e54d..492dc73275 100644<br>
--- a/hw/block/vhost-user-blk.c<br>
+++ b/hw/block/vhost-user-blk.c<br>
@@ -22,6 +22,7 @@<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;hw/qdev-core.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/virtio/vhost.h&quot;<br>
=C2=A0#include &quot;hw/virtio/vhost-user-blk.h&quot;<br>
=C2=A0#include &quot;hw/virtio/virtio.h&quot;<br>
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c<br>
index fbe2a112b7..5bcf9db0b7 100644<br>
--- a/hw/char/avr_usart.c<br>
+++ b/hw/char/avr_usart.c<br>
@@ -24,6 +24,7 @@<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
<br>
=C2=A0static int avr_usart_can_receive(void *opaque)<br>
=C2=A0{<br>
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c<br>
index dade2ab5fd..96410b1ff8 100644<br>
--- a/hw/char/bcm2835_aux.c<br>
+++ b/hw/char/bcm2835_aux.c<br>
@@ -24,6 +24,7 @@<br>
=C2=A0#include &quot;hw/char/bcm2835_aux.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c<br>
index e196906c92..c603e14012 100644<br>
--- a/hw/char/cadence_uart.c<br>
+++ b/hw/char/cadence_uart.c<br>
@@ -32,6 +32,7 @@<br>
=C2=A0#include &quot;hw/char/cadence_uart.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-clock.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
<br>
=C2=A0#ifdef CADENCE_UART_ERR_DEBUG<br>
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c<br>
index 626b68f2ec..ba2cbbee3d 100644<br>
--- a/hw/char/cmsdk-apb-uart.c<br>
+++ b/hw/char/cmsdk-apb-uart.c<br>
@@ -27,6 +27,7 @@<br>
=C2=A0#include &quot;chardev/char-serial.h&quot;<br>
=C2=A0#include &quot;hw/char/cmsdk-apb-uart.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
<br>
=C2=A0REG32(DATA, 0)<br>
=C2=A0REG32(STATE, 4)<br>
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c<br>
index 2a063ad72c..fdb04fee09 100644<br>
--- a/hw/char/debugcon.c<br>
+++ b/hw/char/debugcon.c<br>
@@ -30,6 +30,7 @@<br>
=C2=A0#include &quot;chardev/char-fe.h&quot;<br>
=C2=A0#include &quot;hw/isa/isa.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
=C2=A0#define TYPE_ISA_DEBUGCON_DEVICE &quot;isa-debugcon&quot;<br>
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c<br>
index e130cb4692..00e5df5517 100644<br>
--- a/hw/char/digic-uart.c<br>
+++ b/hw/char/digic-uart.c<br>
@@ -35,6 +35,7 @@<br>
<br>
=C2=A0#include &quot;hw/char/digic-uart.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
<br>
=C2=A0enum {<br>
=C2=A0 =C2=A0 =C2=A0ST_RX_RDY =3D (1 &lt;&lt; 0),<br>
diff --git a/hw/char/escc.c b/hw/char/escc.c<br>
index 7d16ee8688..52e7978287 100644<br>
--- a/hw/char/escc.c<br>
+++ b/hw/char/escc.c<br>
@@ -25,6 +25,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c<br>
index d9fba2ae6c..6bee3ee18e 100644<br>
--- a/hw/char/etraxfs_ser.c<br>
+++ b/hw/char/etraxfs_ser.c<br>
@@ -25,6 +25,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;chardev/char-fe.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c<br>
index 96afe3580f..6361df2ad3 100644<br>
--- a/hw/char/exynos4210_uart.c<br>
+++ b/hw/char/exynos4210_uart.c<br>
@@ -32,6 +32,7 @@<br>
=C2=A0#include &quot;hw/arm/exynos4210.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
<br>
=C2=A0#include &quot;trace.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c<br>
index 3f80f6824e..82ff40a530 100644<br>
--- a/hw/char/grlib_apbuart.c<br>
+++ b/hw/char/grlib_apbuart.c<br>
@@ -25,6 +25,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/sparc/grlib.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c<br>
index cc49a35013..89f1182c9b 100644<br>
--- a/hw/char/ibex_uart.c<br>
+++ b/hw/char/ibex_uart.c<br>
@@ -30,6 +30,7 @@<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-clock.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c<br>
index 731b8fc64c..ee1375e26d 100644<br>
--- a/hw/char/imx_serial.c<br>
+++ b/hw/char/imx_serial.c<br>
@@ -22,6 +22,7 @@<br>
=C2=A0#include &quot;hw/char/imx_serial.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c<br>
index ad000a39b9..3311e0872c 100644<br>
--- a/hw/char/ipoctal232.c<br>
+++ b/hw/char/ipoctal232.c<br>
@@ -12,6 +12,7 @@<br>
=C2=A0#include &quot;hw/ipack/ipack.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qemu/bitops.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c<br>
index b97aacba91..c5ead05e08 100644<br>
--- a/hw/char/lm32_juart.c<br>
+++ b/hw/char/lm32_juart.c<br>
@@ -26,6 +26,7 @@<br>
<br>
=C2=A0#include &quot;hw/char/lm32_juart.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
=C2=A0enum {<br>
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c<br>
index 0e8b4e46a3..5cb87de548 100644<br>
--- a/hw/char/lm32_uart.c<br>
+++ b/hw/char/lm32_uart.c<br>
@@ -25,6 +25,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c<br>
index e6814faffb..6fa4ac502c 100644<br>
--- a/hw/char/mcf_uart.c<br>
+++ b/hw/char/mcf_uart.c<br>
@@ -13,6 +13,7 @@<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;hw/m68k/mcf.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;chardev/char-fe.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c<br>
index 1e83dbcafa..09e2f6bd76 100644<br>
--- a/hw/char/milkymist-uart.c<br>
+++ b/hw/char/milkymist-uart.c<br>
@@ -24,6 +24,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c<br>
index d1fef77acd..045ca5fa40 100644<br>
--- a/hw/char/nrf51_uart.c<br>
+++ b/hw/char/nrf51_uart.c<br>
@@ -18,6 +18,7 @@<br>
=C2=A0#include &quot;hw/char/nrf51_uart.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
<br>
diff --git a/hw/char/parallel.c b/hw/char/parallel.c<br>
index 8b418abf71..b45e67bfbb 100644<br>
--- a/hw/char/parallel.c<br>
+++ b/hw/char/parallel.c<br>
@@ -32,6 +32,7 @@<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/isa/isa.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;hw/char/parallel.h&quot;<br>
=C2=A0#include &quot;sysemu/reset.h&quot;<br>
diff --git a/hw/char/pl011.c b/hw/char/pl011.c<br>
index ede16c781c..ea4a4e5235 100644<br>
--- a/hw/char/pl011.c<br>
+++ b/hw/char/pl011.c<br>
@@ -23,6 +23,7 @@<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;hw/qdev-clock.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;chardev/char-fe.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c<br>
index 5d7c6e6523..1c63467290 100644<br>
--- a/hw/char/renesas_sci.c<br>
+++ b/hw/char/renesas_sci.c<br>
@@ -26,6 +26,7 @@<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/registerfields.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/char/renesas_sci.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
<br>
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c<br>
index 81f6d0ed4f..b9e9b2d453 100644<br>
--- a/hw/char/sclpconsole-lm.c<br>
+++ b/hw/char/sclpconsole-lm.c<br>
@@ -23,6 +23,7 @@<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;hw/s390x/event-facility.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/s390x/ebcdic.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c<br>
index aa72ab40b9..c36b572222 100644<br>
--- a/hw/char/sclpconsole.c<br>
+++ b/hw/char/sclpconsole.c<br>
@@ -20,6 +20,7 @@<br>
=C2=A0#include &quot;hw/s390x/sclp.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/s390x/event-facility.h&quot;<br>
=C2=A0#include &quot;chardev/char-fe.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c<br>
index 2cf3e44177..3a9f96c2d1 100644<br>
--- a/hw/char/serial-pci-multi.c<br>
+++ b/hw/char/serial-pci-multi.c<br>
@@ -33,6 +33,7 @@<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
<br>
=C2=A0#define PCI_SERIAL_MAX_PORTS 4<br>
diff --git a/hw/char/serial.c b/hw/char/serial.c<br>
index 97f71879ff..d99daa7695 100644<br>
--- a/hw/char/serial.c<br>
+++ b/hw/char/serial.c<br>
@@ -35,6 +35,7 @@<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
<br>
=C2=A0#define UART_LCR_DLAB=C2=A0 0x80=C2=A0 =C2=A0 /* Divisor latch access=
 bit */<br>
<br>
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c<br>
index e726d4d915..79eaa2fa52 100644<br>
--- a/hw/char/spapr_vty.c<br>
+++ b/hw/char/spapr_vty.c<br>
@@ -8,6 +8,7 @@<br>
=C2=A0#include &quot;hw/ppc/spapr.h&quot;<br>
=C2=A0#include &quot;hw/ppc/spapr_vio.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
=C2=A0#define VTERM_BUFSIZE=C2=A0 =C2=A016<br>
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c<br>
index 0d661be6d3..8df0832424 100644<br>
--- a/hw/char/stm32f2xx_usart.c<br>
+++ b/hw/char/stm32f2xx_usart.c<br>
@@ -26,6 +26,7 @@<br>
=C2=A0#include &quot;hw/char/stm32f2xx_usart.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
<br>
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c<br>
index d77981bb6d..a9a46c8ed3 100644<br>
--- a/hw/char/terminal3270.c<br>
+++ b/hw/char/terminal3270.c<br>
@@ -16,6 +16,7 @@<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;chardev/char-fe.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/s390x/3270-ccw.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c<br>
index bc752cf90f..6b132caa29 100644<br>
--- a/hw/char/virtio-console.c<br>
+++ b/hw/char/virtio-console.c<br>
@@ -16,6 +16,7 @@<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/virtio/virtio-serial.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-events-char.h&quot;<br>
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c<br>
index 2e773ec4c4..99b9a6f851 100644<br>
--- a/hw/char/xilinx_uartlite.c<br>
+++ b/hw/char/xilinx_uartlite.c<br>
@@ -26,6 +26,7 @@<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;chardev/char-fe.h&quot;<br>
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-sys=
tem.c<br>
index 448d77ecab..8cfa9a3d20 100644<br>
--- a/hw/core/qdev-properties-system.c<br>
+++ b/hw/core/qdev-properties-system.c<br>
@@ -12,6 +12,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qapi/visitor.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-types-block.h&quot;<br>
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c<br>
index 40d84734e7..c73254e886 100644<br>
--- a/hw/i386/kvm/i8254.c<br>
+++ b/hw/i386/kvm/i8254.c<br>
@@ -32,6 +32,7 @@<br>
=C2=A0#include &quot;sysemu/runstate.h&quot;<br>
=C2=A0#include &quot;hw/timer/i8254.h&quot;<br>
=C2=A0#include &quot;hw/timer/i8254_internal.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;sysemu/kvm.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c<br>
index 27ff1f7f66..73499a6235 100644<br>
--- a/hw/ide/qdev.c<br>
+++ b/hw/ide/qdev.c<br>
@@ -26,6 +26,7 @@<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;hw/ide/internal.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
=C2=A0#include &quot;sysemu/blockdev.h&quot;<br>
=C2=A0#include &quot;hw/block/block.h&quot;<br>
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c<br>
index c3f3306e66..e141a5cd45 100644<br>
--- a/hw/ipmi/ipmi_bmc_extern.c<br>
+++ b/hw/ipmi/ipmi_bmc_extern.c<br>
@@ -35,6 +35,7 @@<br>
=C2=A0#include &quot;chardev/char-fe.h&quot;<br>
=C2=A0#include &quot;hw/ipmi/ipmi.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c<br>
index e321e5cb69..0505b52c98 100644<br>
--- a/hw/misc/ivshmem.c<br>
+++ b/hw/misc/ivshmem.c<br>
@@ -23,6 +23,7 @@<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/pci/msi.h&quot;<br>
=C2=A0#include &quot;hw/pci/msix.h&quot;<br>
=C2=A0#include &quot;sysemu/kvm.h&quot;<br>
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c<br>
index 6db62dab7d..488d086a17 100644<br>
--- a/hw/misc/mac_via.c<br>
+++ b/hw/misc/mac_via.c<br>
@@ -28,6 +28,7 @@<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c<br>
index 60066375ab..4401787a5c 100644<br>
--- a/hw/misc/sifive_u_otp.c<br>
+++ b/hw/misc/sifive_u_otp.c<br>
@@ -21,6 +21,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c<br>
index 1af1e6fa2f..0fb8db1dee 100644<br>
--- a/hw/net/rocker/rocker.c<br>
+++ b/hw/net/rocker/rocker.c<br>
@@ -18,6 +18,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;hw/pci/msix.h&quot;<br>
=C2=A0#include &quot;net/net.h&quot;<br>
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c<br>
index 3e93dbbffb..af6f5dbb99 100644<br>
--- a/hw/nvram/eeprom_at24c.c<br>
+++ b/hw/nvram/eeprom_at24c.c<br>
@@ -13,6 +13,7 @@<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;hw/i2c/i2c.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c<br>
index fc53a42572..9e51bc82ae 100644<br>
--- a/hw/nvram/spapr_nvram.c<br>
+++ b/hw/nvram/spapr_nvram.c<br>
@@ -39,6 +39,7 @@<br>
=C2=A0#include &quot;hw/ppc/spapr.h&quot;<br>
=C2=A0#include &quot;hw/ppc/spapr_vio.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
=C2=A0struct SpaprNvram {<br>
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_ro=
ot_port.c<br>
index 8931afc049..ec9907917e 100644<br>
--- a/hw/pci-bridge/gen_pcie_root_port.c<br>
+++ b/hw/pci-bridge/gen_pcie_root_port.c<br>
@@ -16,6 +16,7 @@<br>
=C2=A0#include &quot;hw/pci/msix.h&quot;<br>
=C2=A0#include &quot;hw/pci/pcie_port.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
diff --git a/hw/pci/pci.c b/hw/pci/pci.c<br>
index 100c9381c2..2cd644285c 100644<br>
--- a/hw/pci/pci.c<br>
+++ b/hw/pci/pci.c<br>
@@ -30,6 +30,7 @@<br>
=C2=A0#include &quot;hw/pci/pci_bus.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci_host.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/qemu-file-types.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;monitor/monitor.h&quot;<br>
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c<br>
index c365ee58b8..ef8dff03e0 100644<br>
--- a/hw/ppc/pnv_pnor.c<br>
+++ b/hw/ppc/pnv_pnor.c<br>
@@ -17,6 +17,7 @@<br>
=C2=A0#include &quot;hw/loader.h&quot;<br>
=C2=A0#include &quot;hw/ppc/pnv_pnor.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
<br>
=C2=A0static uint64_t pnv_pnor_read(void *opaque, hwaddr addr, unsigned siz=
e)<br>
=C2=A0{<br>
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c<br>
index 77b1235a3f..8593570332 100644<br>
--- a/hw/rdma/vmw/pvrdma_main.c<br>
+++ b/hw/rdma/vmw/pvrdma_main.c<br>
@@ -21,6 +21,7 @@<br>
=C2=A0#include &quot;hw/pci/msi.h&quot;<br>
=C2=A0#include &quot;hw/pci/msix.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;cpu.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
=C2=A0#include &quot;monitor/monitor.h&quot;<br>
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c<br>
index 7a38540cb9..5d0fcacd0c 100644<br>
--- a/hw/rtc/mc146818rtc.c<br>
+++ b/hw/rtc/mc146818rtc.c<br>
@@ -30,6 +30,7 @@<br>
=C2=A0#include &quot;hw/acpi/aml-build.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;qemu/timer.h&quot;<br>
=C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
=C2=A0#include &quot;sysemu/replay.h&quot;<br>
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c<br>
index e859534eaf..f9a591cd17 100644<br>
--- a/hw/scsi/scsi-disk.c<br>
+++ b/hw/scsi/scsi-disk.c<br>
@@ -34,6 +34,7 @@<br>
=C2=A0#include &quot;sysemu/blockdev.h&quot;<br>
=C2=A0#include &quot;hw/block/block.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;sysemu/dma.h&quot;<br>
=C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c<br>
index 2cb23ca891..9740f7e36a 100644<br>
--- a/hw/scsi/scsi-generic.c<br>
+++ b/hw/scsi/scsi-generic.c<br>
@@ -19,6 +19,7 @@<br>
=C2=A0#include &quot;hw/scsi/scsi.h&quot;<br>
=C2=A0#include &quot;migration/qemu-file-types.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/scsi/emulation.h&quot;<br>
=C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c<br>
index 7c0631656c..4666019442 100644<br>
--- a/hw/scsi/vhost-user-scsi.c<br>
+++ b/hw/scsi/vhost-user-scsi.c<br>
@@ -21,6 +21,7 @@<br>
=C2=A0#include &quot;hw/fw-path-provider.h&quot;<br>
=C2=A0#include &quot;hw/qdev-core.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/virtio/vhost.h&quot;<br>
=C2=A0#include &quot;hw/virtio/vhost-backend.h&quot;<br>
=C2=A0#include &quot;hw/virtio/vhost-user-scsi.h&quot;<br>
diff --git a/hw/sd/sd.c b/hw/sd/sd.c<br>
index 3091382614..fa07398c8c 100644<br>
--- a/hw/sd/sd.c<br>
+++ b/hw/sd/sd.c<br>
@@ -42,6 +42,7 @@<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qemu/bitmap.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/timer.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c<br>
index e8e9d37e88..c27c602697 100644<br>
--- a/hw/usb/ccid-card-passthru.c<br>
+++ b/hw/usb/ccid-card-passthru.c<br>
@@ -14,6 +14,7 @@<br>
=C2=A0#include &lt;libcacard.h&gt;<br>
=C2=A0#include &quot;chardev/char-fe.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c<br>
index b1622b7c7f..504e1ef423 100644<br>
--- a/hw/usb/dev-serial.c<br>
+++ b/hw/usb/dev-serial.c<br>
@@ -14,6 +14,7 @@<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/usb.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;desc.h&quot;<br>
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c<br>
index 3238de6bb8..0b7e0e15f4 100644<br>
--- a/hw/usb/redirect.c<br>
+++ b/hw/usb/redirect.c<br>
@@ -42,6 +42,7 @@<br>
=C2=A0#include &lt;usbredirfilter.h&gt;<br>
<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/usb.h&quot;<br>
=C2=A0#include &quot;migration/qemu-file-types.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c<br>
index 0d83eb0e47..2e7e4bd6c7 100644<br>
--- a/hw/vfio/pci.c<br>
+++ b/hw/vfio/pci.c<br>
@@ -27,6 +27,7 @@<br>
=C2=A0#include &quot;hw/pci/msix.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci_bridge.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/main-loop.h&quot;<br>
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c<br>
index 1bc5d03a00..ed036ad9c1 100644<br>
--- a/hw/virtio/vhost-user-fs.c<br>
+++ b/hw/virtio/vhost-user-fs.c<br>
@@ -16,6 +16,7 @@<br>
=C2=A0#include &quot;standard-headers/linux/virtio_fs.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/virtio/virtio-bus.h&quot;<br>
=C2=A0#include &quot;hw/virtio/virtio-access.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c<br=
>
index 3534a39d62..a6f08c26b9 100644<br>
--- a/hw/virtio/vhost-user-vsock.c<br>
+++ b/hw/virtio/vhost-user-vsock.c<br>
@@ -13,6 +13,7 @@<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/virtio/vhost-user-vsock.h&quot;<br>
<br>
=C2=A0static const int user_feature_bits[] =3D {<br>
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c<br=
>
index 378f63b210..770c286be7 100644<br>
--- a/hw/virtio/virtio-iommu-pci.c<br>
+++ b/hw/virtio/virtio-iommu-pci.c<br>
@@ -14,6 +14,7 @@<br>
=C2=A0#include &quot;virtio-pci.h&quot;<br>
=C2=A0#include &quot;hw/virtio/virtio-iommu.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;hw/boards.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c<br>
index 6d359ee486..3cbd08b10e 100644<br>
--- a/hw/xen/xen_pt.c<br>
+++ b/hw/xen/xen_pt.c<br>
@@ -58,6 +58,7 @@<br>
<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;hw/xen/xen.h&quot;<br>
=C2=A0#include &quot;hw/i386/pc.h&quot;<br>
=C2=A0#include &quot;hw/xen/xen-legacy-backend.h&quot;<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index 9bb4fee5ac..071e35ed44 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -52,6 +52,7 @@<br>
=C2=A0#include &quot;migration/colo.h&quot;<br>
=C2=A0#include &quot;hw/boards.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
=C2=A0#include &quot;monitor/monitor.h&quot;<br>
=C2=A0#include &quot;net/announce.h&quot;<br>
=C2=A0#include &quot;qemu/queue.h&quot;<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000003db96605b2e637f6--

