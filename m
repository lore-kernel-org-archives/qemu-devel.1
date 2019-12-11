Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7550C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF3222B48
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrjXAVFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF3222B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if532-0002WD-7e
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1if52J-0001w7-PF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1if52H-0006Ky-El
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:40:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41477
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1if52G-0006Ij-US
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576082423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cotwrvhrBLlOX+u6bkNYkuynFuQ2DSYOMG3pJLCJaeQ=;
 b=NrjXAVFdfkKBVtB8MOie4tKi2c6EHHg3caEtdQsI2X+DBg88TT9pNdOUYwIc1EOgR2i+l7
 RHxZ02XmsGgYszKPwhc4/TkPZbBPr7Z+HMzkHHzlfGh0Ods6xO2JwaY5CRtul9u5zjKnb3
 NYx1l6lns+18UxhR51gfhpqSMWwPrLg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-CvSBUTmiP1-DsI83yZ3T5g-1; Wed, 11 Dec 2019 11:40:20 -0500
Received: by mail-qt1-f199.google.com with SMTP id k27so4732235qtu.12
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 08:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g0cOjXW4SkTBCf9OMHaW1IzT+97O5aKVzdaDN2Z44yk=;
 b=ObXluAIX1I8Z80C2ar71MPyjNIYKI0Xta0FRgtoHpP5HLamXXpJSb2bgCKnLpaNdE7
 Gxf0/jDMJvwN2be3XWSHPTNVoo37uq46IXrIhL1q0ZnUzo61M75pdBSlFOHjzcCpciZ+
 xM0iWgXDXjDOycM3ofgLAwJYuvc/MhaylltmdepVQPmrhCvbN8GAdrI/ift55Tn3Ai9Q
 bL8dkkn/g9jqtIGG09LZREUPvYq9gaWGPtrSzqxKD3elcHiSDXptUtRE4iAX3L2KzEd5
 YxyIUQJy3qShgd1inIVRBBNXFn0H3xGJcXkCN6+VpYroQhOPy5q3u6XDaveXQ1YZI66C
 /+UA==
X-Gm-Message-State: APjAAAVXrirvUiigEBVN6lFKvCpAJpZAQ2TGoRUT0Ci0WwcR0CsscqPn
 cFSWMDgTMhNAzmwDI82TvSWuEGkG+U+XbkjxcGq7nH+wt8LmJ3nskRouPNrnAe3jgwFULAPpu/t
 zn0UuuZVKyNzXPqc=
X-Received: by 2002:ac8:27ae:: with SMTP id w43mr3545696qtw.273.1576082419737; 
 Wed, 11 Dec 2019 08:40:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1vKJQyZfu2GHV0E+PAw8rPcBNi3e7u9c0nxV8ZjTZ7LVVo1qckCfqaaHBEEl2Qm520/4LIA==
X-Received: by 2002:ac8:27ae:: with SMTP id w43mr3545663qtw.273.1576082419420; 
 Wed, 11 Dec 2019 08:40:19 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id d25sm1028760qtn.49.2019.12.11.08.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 08:40:18 -0800 (PST)
Date: Wed, 11 Dec 2019 11:40:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 00/20] VIRTIO-IOMMU device
Message-ID: <20191211113936-mutt-send-email-mst@kernel.org>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
X-MC-Unique: CvSBUTmiP1-DsI83yZ3T5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, quintela@redhat.com, jean-philippe.brucker@arm.com,
 qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:23PM +0100, Eric Auger wrote:
> This series implements the QEMU virtio-iommu device.
>=20
> This matches the v0.12 spec and the corresponding virtio-iommu
> driver upstreamed in 5.3.
>=20
> The pci proxy for the virtio-iommu device is instantiated using
> "-device virtio-iommu-pci". This series still relies on ACPI IORT/DT
> integration. Note the ACPI IORT integration is not yet upstreamed
> and testing needs to be based on Jean-Philippe's additional
> kernel patches [1].

Or the config space approach? I really liked that one.

>=20
> Work is ongoing to remove IORT adherence and allow the
> bindings between the IOMMU and the root complex to be defined
> and written into the PCI device configuration space. The outcome
> of this work is uncertain at this stage though. See [2].
>=20
> So only patches 1-11 fully rely on upstreamed kernel code. Others
> should be considered as RFC.
>=20
> This respin allows people to test on ARM and x86. It also
> brings migration support (tested on ARM) and various cleanups.
> Reserved regions are now passed through an array of properties.
> A libqos test also is introduced to test the virtio-iommu API.
>=20
> Note integration with vhost devices and vfio devices is not part
> of this series. Please follow Bharat's respins [3].
>=20
> The 1st Patch ("migration: Support QLIST migration") was sent
> separately [4].
>=20
> Best Regards
>=20
> Eric
>=20
> This series can be found at:
> https://github.com/eauger/qemu/tree/v4.2-rc2-virtio-iommu-v11
>=20
> [1] kernel branch to be used for guest
>     https://github.com/eauger/linux/tree/v5.4-rc8-virtio-iommu-iort
> [2] [RFC 00/13] virtio-iommu on non-devicetree platforms
> [3] VFIO/VHOST integration is not part of this series. Please follow
>     [PATCH RFC v5 0/5] virtio-iommu: VFIO integration respins
> [4] [PATCH v6] migration: Support QLIST migration
>=20
> Testing:
> - tested with guest using virtio-net-pci
>   (,vhost=3Doff,iommu_platform,disable-modern=3Doff,disable-legacy=3Don)
>   and virtio-blk-pci
> - migration on ARM
> - on x86 PC machine I get some AHCI non translated transactions,
>   very early. This does not prevent the guest from boot and behaving
>   properly. Warnings look like:
> qemu-system-x86_64: virtio_iommu_translate sid=3D250 is not known!!
> qemu-system-x86_64: no buffer available in event queue to report event
> qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS
> receive buffer address
>=20
> History:
>=20
> v10 -> v11:
> - introduce virtio_iommu_handle_req macro
> - migration support
> - introduce DEFINE_PROP_INTERVAL and pass reserved regions
>   through an array of those
> - domain gtree simplification
>=20
> v9 -> v10:
> - rebase on 4.1.0-rc2, compliance with 0.12 spec
> - removed ACPI part
> - cleanup (see individual change logs)
> - moved to a PATCH series
>=20
> v8 -> v9:
> - virtio-iommu-pci device needs to be instantiated from the command
>   line (RID is not imposed anymore).
> - tail structure properly initialized
>=20
> v7 -> v8:
> - virtio-iommu-pci added
> - virt instantiation modified
> - DT and ACPI modified to exclude the iommu RID from the mapping
> - VIRTIO_IOMMU_F_BYPASS, VIRTIO_F_VERSION_1 features exposed
>=20
> v6 -> v7:
> - rebase on qemu 3.0.0-rc3
> - minor update against v0.7
> - fix issue with EP not on pci.0 and ACPI probing
> - change the instantiation method
>=20
> v5 -> v6:
> - minor update against v0.6 spec
> - fix g_hash_table_lookup in virtio_iommu_find_add_as
> - replace some error_reports by qemu_log_mask(LOG_GUEST_ERROR, ...)
>=20
> v4 -> v5:
> - event queue and fault reporting
> - we now return the IOAPIC MSI region if the virtio-iommu is instantiated
>   in a PC machine.
> - we bypass transactions on MSI HW region and fault on reserved ones.
> - We support ACPI boot with mach-virt (based on IORT proposal)
> - We moved to the new driver naming conventions
> - simplified mach-virt instantiation
> - worked around the disappearing of pci_find_primary_bus
> - in virtio_iommu_translate, check the dev->as is not NULL
> - initialize as->device_list in virtio_iommu_get_as
> - initialize bufstate.error to false in virtio_iommu_probe
>=20
> v3 -> v4:
> - probe request support although no reserved region is returned at
>   the moment
> - unmap semantics less strict, as specified in v0.4
> - device registration, attach/detach revisited
> - split into smaller patches to ease review
> - propose a way to inform the IOMMU mr about the page_size_mask
>   of underlying HW IOMMU, if any
> - remove warning associated with the translation of the MSI doorbell
>=20
> v2 -> v3:
> - rebase on top of 2.10-rc0 and especially
>   [PATCH qemu v9 0/2] memory/iommu: QOM'fy IOMMU MemoryRegion
> - add mutex init
> - fix as->mappings deletion using g_tree_ref/unref
> - when a dev is attached whereas it is already attached to
>   another address space, first detach it
> - fix some error values
> - page_sizes =3D TARGET_PAGE_MASK;
> - I haven't changed the unmap() semantics yet, waiting for the
>   next virtio-iommu spec revision.
>=20
> v1 -> v2:
> - fix redefinition of viommu_as typedef
>=20
>=20
>=20
> Eric Auger (20):
>   migration: Support QLIST migration
>   virtio-iommu: Add skeleton
>   virtio-iommu: Decode the command payload
>   virtio-iommu: Add the iommu regions
>   virtio-iommu: Endpoint and domains structs and helpers
>   virtio-iommu: Implement attach/detach command
>   virtio-iommu: Implement map/unmap
>   virtio-iommu: Implement translate
>   virtio-iommu: Implement fault reporting
>   virtio-iommu-pci: Add virtio iommu pci support
>   hw/arm/virt: Add the virtio-iommu device tree mappings
>   qapi: Introduce DEFINE_PROP_INTERVAL
>   virtio-iommu: Implement probe request
>   virtio-iommu: Handle reserved regions in the translation process
>   virtio-iommu-pci: Add array of Interval properties
>   hw/arm/virt-acpi-build: Introduce fill_iort_idmap helper
>   hw/arm/virt-acpi-build: Add virtio-iommu node in IORT table
>   virtio-iommu: Support migration
>   pc: Add support for virtio-iommu-pci
>   tests: Add virtio-iommu test
>=20
>  hw/arm/virt-acpi-build.c         |  91 ++-
>  hw/arm/virt.c                    |  53 +-
>  hw/core/qdev-properties.c        |  90 +++
>  hw/i386/acpi-build.c             |  72 +++
>  hw/i386/pc.c                     |  15 +-
>  hw/virtio/Kconfig                |   5 +
>  hw/virtio/Makefile.objs          |   2 +
>  hw/virtio/trace-events           |  22 +
>  hw/virtio/virtio-iommu-pci.c     |  91 +++
>  hw/virtio/virtio-iommu.c         | 952 +++++++++++++++++++++++++++++++
>  include/exec/memory.h            |   6 +
>  include/hw/acpi/acpi-defs.h      |  21 +-
>  include/hw/arm/virt.h            |   2 +
>  include/hw/i386/pc.h             |   2 +
>  include/hw/pci/pci.h             |   1 +
>  include/hw/qdev-properties.h     |   3 +
>  include/hw/virtio/virtio-iommu.h |  67 +++
>  include/migration/vmstate.h      |  21 +
>  include/qemu/queue.h             |  39 ++
>  include/qemu/typedefs.h          |   1 +
>  migration/trace-events           |   5 +
>  migration/vmstate-types.c        |  70 +++
>  qdev-monitor.c                   |   1 +
>  tests/Makefile.include           |   2 +
>  tests/libqos/virtio-iommu.c      | 177 ++++++
>  tests/libqos/virtio-iommu.h      |  45 ++
>  tests/test-vmstate.c             | 170 ++++++
>  tests/virtio-iommu-test.c        | 261 +++++++++
>  28 files changed, 2253 insertions(+), 34 deletions(-)
>  create mode 100644 hw/virtio/virtio-iommu-pci.c
>  create mode 100644 hw/virtio/virtio-iommu.c
>  create mode 100644 include/hw/virtio/virtio-iommu.h
>  create mode 100644 tests/libqos/virtio-iommu.c
>  create mode 100644 tests/libqos/virtio-iommu.h
>  create mode 100644 tests/virtio-iommu-test.c
>=20
> --=20
> 2.20.1


