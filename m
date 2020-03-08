Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A744FC10F28
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 07:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6257220663
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 07:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2NQq5QT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6257220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAqnY-0000PV-Gt
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 03:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAqmq-0008Fc-Uj
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 03:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAqmn-00007w-Rr
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 03:55:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23555
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAqmn-0008VR-K5
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 03:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583654144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bk1eJFHWPNYwXgmgIgrCTgUnIxpdqLjzS3WY9m+6e2s=;
 b=E2NQq5QTtknLcMJDAsmnZatnN2qJ8gy9pJ7SPY3+23LTRcSrGcu2qxBJ8vLQt0MtMq8YHi
 NKIwyuCvjerCU169H+80gwaqBXG3VJDyFWKJqk0sa5zQBBv4DZ2eIRRaoCFoKLHA1knjgL
 j0fq2lMxpXpCVkQCYzmn3tnXFOpenaw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-VU4ESeJjMJ2EY9n5hOfsow-1; Sun, 08 Mar 2020 03:55:43 -0400
X-MC-Unique: VU4ESeJjMJ2EY9n5hOfsow-1
Received: by mail-qk1-f198.google.com with SMTP id m6so1609229qkm.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 23:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dcVUm4B4vO68jLIPB1CjCTQUpwYAA3Uz1MtdhFz4cpA=;
 b=sw8si567NnV475CXlsrVFaTnCr7vKAyw3JKSPIqX47Wzl2lqfx2Te716Tc+lKJvqDh
 Y5+3eMkL7m7DpH2eCG5KSt3Alc0il/7z4+XU8ekAdivZx3Ex1L+mqkztweeoklEWLNEW
 T0lyKix5+pP8mMxGJ7IhqMunFZFJiHugGqU+c6jwuZLbmNH1XUFi7BEJm8tvKd0HKZnt
 GNG6+sL/olCRUyieuDdyUAcjKCXKMiwci5S4tazfcul6lbwdZbNCBEciAXIaVFao+0W1
 O7BCjmzrCzbLwFETHiynoU+htTyLFlI6xhydmRm+ZVpA7tRl6ixSd22yH3l2LPKfq5g3
 bPmA==
X-Gm-Message-State: ANhLgQ1cNrWUEkyTF6cCJvXtJHd0L1+nJApFuH1BZFFvPhHoOeZeUmUn
 OGVsG3gX/CbqPq7P9H/jolNwLwPc1N1UnvLBeyCvCImy1l9ZYP2c32pJ2xNwGPH9SFBHy34+iqV
 1T3e97aVDnuZR9qM=
X-Received: by 2002:ac8:3003:: with SMTP id f3mr3937570qte.293.1583654139382; 
 Sat, 07 Mar 2020 23:55:39 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtfAw5DMrD9wr3mY99Z3Fb0dw8CfFlnU5VZhafbDirTOpvwlP+EG1w2C7UqPgVExpcGRi/0nw==
X-Received: by 2002:ac8:3003:: with SMTP id f3mr3937531qte.293.1583654138862; 
 Sat, 07 Mar 2020 23:55:38 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id 6sm7644717qky.30.2020.03.07.23.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 23:55:38 -0800 (PST)
Date: Sun, 8 Mar 2020 03:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/2] misc: Replace zero-length arrays with flexible
 array member (automatic)
Message-ID: <20200308035457-mutt-send-email-mst@kernel.org>
References: <20200304153816.23636-1-philmd@redhat.com>
 <20200304153816.23636-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200304153816.23636-2-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Paul Durrant <paul@xen.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 04, 2020 at 04:38:15PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Description copied from Linux kernel commit from Gustavo A. R. Silva
> (see [3]):
>=20
> --v-- description start --v--
>=20
>   The current codebase makes use of the zero-length array language
>   extension to the C90 standard, but the preferred mechanism to
>   declare variable-length types such as these ones is a flexible
>   array member [1], introduced in C99:
>=20
>   struct foo {
>       int stuff;
>       struct boo array[];
>   };
>=20
>   By making use of the mechanism above, we will get a compiler
>   warning in case the flexible array does not occur last in the
>   structure, which will help us prevent some kind of undefined
>   behavior bugs from being unadvertenly introduced [2] to the
>   Linux codebase from now on.
>=20
> --^-- description end --^--
>=20
> Do the similar housekeeping in the QEMU codebase (which uses
> C99 since commit 7be41675f7cb).
>=20
> All these instances of code were found with the help of the
> following Coccinelle script:
>=20
>   @@
>   identifier s, m, a;
>   type t, T;
>   @@
>    struct s {
>       ...
>       t m;
>   -   T a[0];
>   +   T a[];
>   };
>   @@
>   identifier s, m, a;
>   type t, T;
>   @@
>    struct s {
>       ...
>       t m;
>   -   T a[0];
>   +   T a[];
>    } QEMU_PACKED;
>=20
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D76497732932f
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/=
commit/?id=3D17642a2fbd2c1
>=20
> Inspired-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2: cocci script updated to not match structures of onlyi
> a single flexible array member:
>=20
>   block/qed.h:106:14: error: flexible array member 'offsets' not allowed =
in otherwise empty struct
>       uint64_t offsets[];             /* in bytes */
>                ^
> ---
>  bsd-user/qemu.h                       |  2 +-
>  contrib/libvhost-user/libvhost-user.h |  2 +-
>  hw/m68k/bootinfo.h                    |  2 +-
>  hw/scsi/srp.h                         |  6 +++---
>  hw/xen/xen_pt.h                       |  2 +-
>  include/hw/acpi/acpi-defs.h           | 12 ++++++------
>  include/hw/arm/smmu-common.h          |  2 +-
>  include/hw/i386/intel_iommu.h         |  3 ++-
>  include/hw/virtio/virtio-iommu.h      |  2 +-
>  include/sysemu/cryptodev.h            |  2 +-
>  include/tcg/tcg.h                     |  2 +-
>  pc-bios/s390-ccw/bootmap.h            |  2 +-
>  pc-bios/s390-ccw/sclp.h               |  2 +-
>  tests/qtest/libqos/ahci.h             |  2 +-
>  block/linux-aio.c                     |  2 +-
>  hw/acpi/nvdimm.c                      |  6 +++---
>  hw/dma/soc_dma.c                      |  2 +-
>  hw/i386/x86.c                         |  2 +-
>  hw/misc/omap_l4.c                     |  2 +-
>  hw/nvram/eeprom93xx.c                 |  2 +-
>  hw/rdma/vmw/pvrdma_qp_ops.c           |  4 ++--
>  hw/usb/dev-network.c                  |  2 +-
>  hw/usb/dev-smartcard-reader.c         |  4 ++--
>  hw/virtio/virtio.c                    |  4 ++--
>  net/queue.c                           |  2 +-
>  25 files changed, 38 insertions(+), 37 deletions(-)
>=20
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index 09e8aed9c7..f8bb1e5459 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -95,7 +95,7 @@ typedef struct TaskState {
>      struct sigqueue *first_free; /* first free siginfo queue entry */
>      int signal_pending; /* non zero if a signal may be pending */
> =20
> -    uint8_t stack[0];
> +    uint8_t stack[];
>  } __attribute__((aligned(16))) TaskState;
> =20
>  void init_task_state(TaskState *ts);
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 6fc8000e99..f30394fab6 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -286,7 +286,7 @@ typedef struct VuVirtqInflight {
>      uint16_t used_idx;
> =20
>      /* Used to track the state of each descriptor in descriptor table */
> -    VuDescStateSplit desc[0];
> +    VuDescStateSplit desc[];
>  } VuVirtqInflight;
> =20
>  typedef struct VuVirtqInflightDesc {
> diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
> index 5f8ded2686..c954270aad 100644
> --- a/hw/m68k/bootinfo.h
> +++ b/hw/m68k/bootinfo.h
> @@ -14,7 +14,7 @@
>  struct bi_record {
>      uint16_t tag;        /* tag ID */
>      uint16_t size;       /* size of record */
> -    uint32_t data[0];    /* data */
> +    uint32_t data[];     /* data */
>  };
> =20
>  /* machine independent tags */
> diff --git a/hw/scsi/srp.h b/hw/scsi/srp.h
> index d27f31d2d5..54c954badd 100644
> --- a/hw/scsi/srp.h
> +++ b/hw/scsi/srp.h
> @@ -112,7 +112,7 @@ struct srp_direct_buf {
>  struct srp_indirect_buf {
>      struct srp_direct_buf    table_desc;
>      uint32_t                 len;
> -    struct srp_direct_buf    desc_list[0];
> +    struct srp_direct_buf    desc_list[];
>  } QEMU_PACKED;
> =20
>  enum {
> @@ -211,7 +211,7 @@ struct srp_cmd {
>      uint8_t    reserved4;
>      uint8_t    add_cdb_len;
>      uint8_t    cdb[16];
> -    uint8_t    add_data[0];
> +    uint8_t    add_data[];
>  } QEMU_PACKED;
> =20
>  enum {
> @@ -241,7 +241,7 @@ struct srp_rsp {
>      uint32_t   data_in_res_cnt;
>      uint32_t   sense_data_len;
>      uint32_t   resp_data_len;
> -    uint8_t    data[0];
> +    uint8_t    data[];
>  } QEMU_PACKED;
> =20
>  #endif /* SCSI_SRP_H */
> diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
> index 9167bbaf6d..179775db7b 100644
> --- a/hw/xen/xen_pt.h
> +++ b/hw/xen/xen_pt.h
> @@ -203,7 +203,7 @@ typedef struct XenPTMSIX {
>      uint64_t mmio_base_addr;
>      MemoryRegion mmio;
>      void *phys_iomem_base;
> -    XenPTMSIXEntry msix_entry[0];
> +    XenPTMSIXEntry msix_entry[];
>  } XenPTMSIX;
> =20
>  struct XenPCIPassthroughState {
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 57a3f58b0c..19f7ba7b70 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -518,7 +518,7 @@ struct AcpiDmarDeviceScope {
>      struct {
>          uint8_t device;
>          uint8_t function;
> -    } path[0];
> +    } path[];
>  } QEMU_PACKED;
>  typedef struct AcpiDmarDeviceScope AcpiDmarDeviceScope;
> =20
> @@ -530,7 +530,7 @@ struct AcpiDmarHardwareUnit {
>      uint8_t reserved;
>      uint16_t pci_segment;   /* The PCI Segment associated with this unit=
 */
>      uint64_t address;   /* Base address of remapping hardware register-s=
et */
> -    AcpiDmarDeviceScope scope[0];
> +    AcpiDmarDeviceScope scope[];
>  } QEMU_PACKED;
>  typedef struct AcpiDmarHardwareUnit AcpiDmarHardwareUnit;
> =20
> @@ -541,7 +541,7 @@ struct AcpiDmarRootPortATS {
>      uint8_t flags;
>      uint8_t reserved;
>      uint16_t pci_segment;
> -    AcpiDmarDeviceScope scope[0];
> +    AcpiDmarDeviceScope scope[];
>  } QEMU_PACKED;
>  typedef struct AcpiDmarRootPortATS AcpiDmarRootPortATS;
> =20
> @@ -604,7 +604,7 @@ typedef struct AcpiIortMemoryAccess AcpiIortMemoryAcc=
ess;
>  struct AcpiIortItsGroup {
>      ACPI_IORT_NODE_HEADER_DEF
>      uint32_t its_count;
> -    uint32_t identifiers[0];
> +    uint32_t identifiers[];
>  } QEMU_PACKED;
>  typedef struct AcpiIortItsGroup AcpiIortItsGroup;
> =20
> @@ -621,7 +621,7 @@ struct AcpiIortSmmu3 {
>      uint32_t pri_gsiv;
>      uint32_t gerr_gsiv;
>      uint32_t sync_gsiv;
> -    AcpiIortIdMapping id_mapping_array[0];
> +    AcpiIortIdMapping id_mapping_array[];
>  } QEMU_PACKED;
>  typedef struct AcpiIortSmmu3 AcpiIortSmmu3;
> =20
> @@ -630,7 +630,7 @@ struct AcpiIortRC {
>      AcpiIortMemoryAccess memory_properties;
>      uint32_t ats_attribute;
>      uint32_t pci_segment_number;
> -    AcpiIortIdMapping id_mapping_array[0];
> +    AcpiIortIdMapping id_mapping_array[];
>  } QEMU_PACKED;
>  typedef struct AcpiIortRC AcpiIortRC;
> =20
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 1f37844e5c..ca4a4b1ad1 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -85,7 +85,7 @@ typedef struct SMMUDevice {
> =20
>  typedef struct SMMUPciBus {
>      PCIBus       *bus;
> -    SMMUDevice   *pbdev[0]; /* Parent array is sparse, so dynamically al=
loc */
> +    SMMUDevice   *pbdev[]; /* Parent array is sparse, so dynamically all=
oc */
>  } SMMUPciBus;
> =20
>  typedef struct SMMUIOTLBKey {
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.=
h
> index 66b931e526..67aaa64c1b 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -118,7 +118,8 @@ struct VTDAddressSpace {
> =20
>  struct VTDBus {
>      PCIBus* bus;=09=09/* A reference to the bus to provide translation f=
or */
> -    VTDAddressSpace *dev_as[0];=09/* A table of VTDAddressSpace objects =
indexed by devfn */
> +    /* A table of VTDAddressSpace objects indexed by devfn */
> +    VTDAddressSpace *dev_as[];
>  };
> =20
>  struct VTDIOTLBEntry {
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-=
iommu.h
> index 6f67f1020a..e653004d7c 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -41,7 +41,7 @@ typedef struct IOMMUDevice {
> =20
>  typedef struct IOMMUPciBus {
>      PCIBus       *bus;
> -    IOMMUDevice  *pbdev[0]; /* Parent array is sparse, so dynamically al=
loc */
> +    IOMMUDevice  *pbdev[]; /* Parent array is sparse, so dynamically all=
oc */
>  } IOMMUPciBus;
> =20
>  typedef struct VirtIOIOMMU {
> diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
> index a9afb7e5b5..35eab06d0e 100644
> --- a/include/sysemu/cryptodev.h
> +++ b/include/sysemu/cryptodev.h
> @@ -143,7 +143,7 @@ typedef struct CryptoDevBackendSymOpInfo {
>      uint8_t *dst;
>      uint8_t *aad_data;
>      uint8_t *digest_result;
> -    uint8_t data[0];
> +    uint8_t data[];
>  } CryptoDevBackendSymOpInfo;
> =20
>  typedef struct CryptoDevBackendClass {
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 54e5446880..c48bd76b0a 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -267,7 +267,7 @@ struct TCGLabel {
>  typedef struct TCGPool {
>      struct TCGPool *next;
>      int size;
> -    uint8_t data[0] __attribute__ ((aligned));
> +    uint8_t data[] __attribute__ ((aligned));
>  } TCGPool;
> =20
>  #define TCG_POOL_CHUNK_SIZE 32768
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index 94f53a5f1e..12a0166aae 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -136,7 +136,7 @@ typedef struct BootMapScriptHeader {
> =20
>  typedef struct BootMapScript {
>      BootMapScriptHeader header;
> -    BootMapScriptEntry  entry[0];
> +    BootMapScriptEntry  entry[];
>  } __attribute__ ((packed)) BootMapScript;
> =20
>  /*
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index 8450161ba7..64b53cad29 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -95,7 +95,7 @@ typedef struct EventBufferHeader {
>  typedef struct WriteEventData {
>      SCCBHeader h;
>      EventBufferHeader ebh;
> -    char data[0];
> +    char data[];
>  } __attribute__((packed)) WriteEventData;
> =20
>  typedef struct ReadEventData {
> diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
> index f05b3e5fce..44ab1104b5 100644
> --- a/tests/qtest/libqos/ahci.h
> +++ b/tests/qtest/libqos/ahci.h
> @@ -351,7 +351,7 @@ typedef struct AHCIQState {
>  typedef struct FIS {
>      uint8_t fis_type;
>      uint8_t flags;
> -    char data[0];
> +    char data[];
>  } __attribute__((__packed__)) FIS;
> =20
>  /**
> diff --git a/block/linux-aio.c b/block/linux-aio.c
> index 91204a25a2..3c0527c2bf 100644
> --- a/block/linux-aio.c
> +++ b/block/linux-aio.c
> @@ -121,7 +121,7 @@ struct aio_ring {
>      unsigned    incompat_features;
>      unsigned    header_length;  /* size of aio_ring */
> =20
> -    struct io_event io_events[0];
> +    struct io_event io_events[];
>  };
> =20
>  /**
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 5219dd0e2e..eb6a37b14e 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -485,7 +485,7 @@ struct NvdimmFuncGetLabelDataOut {
>      /* the size of buffer filled by QEMU. */
>      uint32_t len;
>      uint32_t func_ret_status; /* return status code. */
> -    uint8_t out_buf[0]; /* the data got via Get Namesapce Label function=
. */
> +    uint8_t out_buf[]; /* the data got via Get Namesapce Label function.=
 */
>  } QEMU_PACKED;
>  typedef struct NvdimmFuncGetLabelDataOut NvdimmFuncGetLabelDataOut;
>  QEMU_BUILD_BUG_ON(sizeof(NvdimmFuncGetLabelDataOut) > NVDIMM_DSM_MEMORY_=
SIZE);
> @@ -493,7 +493,7 @@ QEMU_BUILD_BUG_ON(sizeof(NvdimmFuncGetLabelDataOut) >=
 NVDIMM_DSM_MEMORY_SIZE);
>  struct NvdimmFuncSetLabelDataIn {
>      uint32_t offset; /* the offset in the namespace label data area. */
>      uint32_t length; /* the size of data is to be written via the functi=
on. */
> -    uint8_t in_buf[0]; /* the data written to label data area. */
> +    uint8_t in_buf[]; /* the data written to label data area. */
>  } QEMU_PACKED;
>  typedef struct NvdimmFuncSetLabelDataIn NvdimmFuncSetLabelDataIn;
>  QEMU_BUILD_BUG_ON(sizeof(NvdimmFuncSetLabelDataIn) +
> @@ -510,7 +510,7 @@ struct NvdimmFuncReadFITOut {
>      /* the size of buffer filled by QEMU. */
>      uint32_t len;
>      uint32_t func_ret_status; /* return status code. */
> -    uint8_t fit[0]; /* the FIT data. */
> +    uint8_t fit[]; /* the FIT data. */
>  } QEMU_PACKED;
>  typedef struct NvdimmFuncReadFITOut NvdimmFuncReadFITOut;
>  QEMU_BUILD_BUG_ON(sizeof(NvdimmFuncReadFITOut) > NVDIMM_DSM_MEMORY_SIZE)=
;
> diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
> index c3e41581b6..3a430057f5 100644
> --- a/hw/dma/soc_dma.c
> +++ b/hw/dma/soc_dma.c
> @@ -80,7 +80,7 @@ struct dma_s {
>      } *memmap;
>      int memmap_size;
> =20
> -    struct soc_dma_ch_s ch[0];
> +    struct soc_dma_ch_s ch[];
>  };
> =20
>  static void soc_dma_ch_schedule(struct soc_dma_ch_s *ch, int delay_bytes=
)
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 7f38e6ba8b..08246523f2 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -328,7 +328,7 @@ struct setup_data {
>      uint64_t next;
>      uint32_t type;
>      uint32_t len;
> -    uint8_t data[0];
> +    uint8_t data[];
>  } __attribute__((packed));
> =20
> =20
> diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c
> index 61b6df564a..54aeaecd69 100644
> --- a/hw/misc/omap_l4.c
> +++ b/hw/misc/omap_l4.c
> @@ -24,7 +24,7 @@ struct omap_l4_s {
>      MemoryRegion *address_space;
>      hwaddr base;
>      int ta_num;
> -    struct omap_target_agent_s ta[0];
> +    struct omap_target_agent_s ta[];
>  };
> =20
>  struct omap_l4_s *omap_l4_init(MemoryRegion *address_space,
> diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
> index 07f09549ed..ca6f591c84 100644
> --- a/hw/nvram/eeprom93xx.c
> +++ b/hw/nvram/eeprom93xx.c
> @@ -86,7 +86,7 @@ struct _eeprom_t {
>      uint8_t  addrbits;
>      uint16_t size;
>      uint16_t data;
> -    uint16_t contents[0];
> +    uint16_t contents[];
>  };
> =20
>  /* Code for saving and restoring of EEPROM state. */
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index bd6db858de..8050287a6c 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -34,13 +34,13 @@ typedef struct CompHandlerCtx {
>  /* Send Queue WQE */
>  typedef struct PvrdmaSqWqe {
>      struct pvrdma_sq_wqe_hdr hdr;
> -    struct pvrdma_sge sge[0];
> +    struct pvrdma_sge sge[];
>  } PvrdmaSqWqe;
> =20
>  /* Recv Queue WQE */
>  typedef struct PvrdmaRqWqe {
>      struct pvrdma_rq_wqe_hdr hdr;
> -    struct pvrdma_sge sge[0];
> +    struct pvrdma_sge sge[];
>  } PvrdmaRqWqe;
> =20
>  /*
> diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
> index 9a78ad928b..6210427544 100644
> --- a/hw/usb/dev-network.c
> +++ b/hw/usb/dev-network.c
> @@ -626,7 +626,7 @@ static const uint32_t oid_supported_list[] =3D
>  struct rndis_response {
>      QTAILQ_ENTRY(rndis_response) entries;
>      uint32_t length;
> -    uint8_t buf[0];
> +    uint8_t buf[];
>  };
> =20
>  typedef struct USBNetState {
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
> index 02693a26ad..ef72738ced 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -227,7 +227,7 @@ typedef struct QEMU_PACKED CCID_Parameter {
>  typedef struct QEMU_PACKED CCID_DataBlock {
>      CCID_BULK_IN b;
>      uint8_t      bChainParameter;
> -    uint8_t      abData[0];
> +    uint8_t      abData[];
>  } CCID_DataBlock;
> =20
>  /* 6.1.4 PC_to_RDR_XfrBlock */
> @@ -235,7 +235,7 @@ typedef struct QEMU_PACKED CCID_XferBlock {
>      CCID_Header  hdr;
>      uint8_t      bBWI; /* Block Waiting Timeout */
>      uint16_t     wLevelParameter; /* XXX currently unused */
> -    uint8_t      abData[0];
> +    uint8_t      abData[];
>  } CCID_XferBlock;
> =20
>  typedef struct QEMU_PACKED CCID_IccPowerOn {
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index b2d415e5dd..b6c8ef5bc0 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -54,7 +54,7 @@ typedef struct VRingAvail
>  {
>      uint16_t flags;
>      uint16_t idx;
> -    uint16_t ring[0];
> +    uint16_t ring[];
>  } VRingAvail;
> =20
>  typedef struct VRingUsedElem
> @@ -67,7 +67,7 @@ typedef struct VRingUsed
>  {
>      uint16_t flags;
>      uint16_t idx;
> -    VRingUsedElem ring[0];
> +    VRingUsedElem ring[];
>  } VRingUsed;
> =20
>  typedef struct VRingMemoryRegionCaches {
> diff --git a/net/queue.c b/net/queue.c
> index 61276ca4be..0164727e39 100644
> --- a/net/queue.c
> +++ b/net/queue.c
> @@ -46,7 +46,7 @@ struct NetPacket {
>      unsigned flags;
>      int size;
>      NetPacketSent *sent_cb;
> -    uint8_t data[0];
> +    uint8_t data[];
>  };
> =20
>  struct NetQueue {
> --=20
> 2.21.1


