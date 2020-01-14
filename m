Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F8DC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A367924672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nzht3jhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A367924672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMr2-00017G-Ng
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1irMny-0006Du-9k
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1irMnu-00038M-Co
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:04:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26677
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1irMnu-00037W-87
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579010661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXMyh8V6IQ6WFEYgbOOboZIxuxIBz8CaS87R31t2sfs=;
 b=Nzht3jhCX4OCg/DYZx0iwMPUAtC3WZBsbpvnyoZpD48tCRDMz0pu2Lif9r3ecR0Vqc8GCe
 XjTpNdj3J/jhU4JIJ5A9dM6xn7zFlKTqUu0g7PuHTmcdm/o6RYp4UYGOngGvN0qczHH7Dp
 8tgG0VbKoijMw4/DcjJG6aPjN9cp6Ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-rHxklj4tNm-q7LoJc1e5Og-1; Tue, 14 Jan 2020 09:04:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4483107ACC4;
 Tue, 14 Jan 2020 14:04:16 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6825E19C5B;
 Tue, 14 Jan 2020 14:04:16 +0000 (UTC)
Date: Tue, 14 Jan 2020 07:04:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: PCIe device paththrough via vfio issue
Message-ID: <20200114070415.3309a36e@x1.home>
In-Reply-To: <1e532c1c-ee61-d2ce-2633-f73c284c6acb@ozlabs.ru>
References: <9ebac151-0a9b-3f64-ccd8-0709088fa2b3@gmail.com>
 <20200113092820.7af3b10c@w520.home>
 <1e532c1c-ee61-d2ce-2633-f73c284c6acb@ozlabs.ru>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: rHxklj4tNm-q7LoJc1e5Og-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, yurij <lnkgyv@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 17:14:33 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 14/01/2020 03:28, Alex Williamson wrote:
> > On Mon, 13 Jan 2020 18:49:21 +0300
> > yurij <lnkgyv@gmail.com> wrote:
> >  =20
> >> Hello everybody!
> >>
> >> I have a specific PCIe device (sorry, but I can't tell about what is i=
t=20
> >> and what it does) but PCI configuration space consists of 4 BARs (lspc=
i=20
> >> output brief):
> >>
> >> lspci -s 84:00.00 -vvv
> >>
> >> . . .
> >> Region 0: Memory at fa000000 (64-bit, non-prefetchable) [size=3D16M]
> >> =09Region 2: Memory at fb001000 (32-bit, non-prefetchable) [size=3D4K]
> >> =09Region 3: Memory at fb000000 (32-bit, non-prefetchable) [size=3D4K]
> >> =09Region 4: Memory at f9000000 (64-bit, non-prefetchable) [size=3D16M=
]
> >> . . .
> >> Kernel driver in use: vfio-pci
> >> . . .
> >>
> >> BAR0 merged with BAR1, BAR4 merged with BAR5 so they are 64 bit width.
> >>
> >> I put this PCIe device in virtual machine via vfio:
> >>
> >> -device vfio-pci,host=3D84:00.0,id=3Dhostdev0,bus=3Dpci.6,addr=3D0x0
> >>
> >> Virtual machine successfully boot. PCI configuration space in virtual=
=20
> >> environment looks OK (lspci output brief):
> >>
> >> lspci -s 06:00.0 -vvv
> >>
> >> . . .
> >> Region 0: Memory at f8000000 (64-bit, non-prefetchable) [size=3D16M]
> >> =09Region 2: Memory at fa000000 (32-bit, non-prefetchable) [size=3D4K]
> >> =09Region 3: Memory at fa001000 (32-bit, non-prefetchable) [size=3D4K]
> >> =09Region 4: Memory at f9000000 (64-bit, non-prefetchable) [size=3D16M=
]
> >> . . .
> >> Kernel driver in use: custom_driver
> >>
> >> BAR0 merged with BAR1 and BAR4 merged with BAR5 and so they are also 6=
4=20
> >> bit width.
> >>
> >> The main problem in 4K HOLE in REGION 0 in virtual environment. So som=
e=20
> >> device features don't work.
> >>
> >> I have enabled iommu trace in host system (trace_event=3Diommu) and=20
> >> display all events (for i in $(find=20
> >> /sys/kernel/debug/tracing/events/iommu/ -name enable);do echo 1 > $i;=
=20
> >> done). I saw next events during virtual machine booting:
> >>
> >> # cat /sys/kernel/debug/tracing/trace
> >> . . .
> >>         CPU 0/KVM-3046  [051] .... 63113.338894: map: IOMMU:=20
> >> iova=3D0x00000000f8000000 paddr=3D0x00000000fa000000 size=3D24576
> >>         CPU 0/KVM-3046  [051] .... 63113.339177: map: IOMMU:=20
> >> iova=3D0x00000000f8007000 paddr=3D0x00000000fa007000 size=3D16748544
> >>         CPU 0/KVM-3046  [051] .... 63113.339444: map: IOMMU:=20
> >> iova=3D0x00000000fa000000 paddr=3D0x00000000fb001000 size=3D4096
> >>         CPU 0/KVM-3046  [051] .... 63113.339697: map: IOMMU:=20
> >> iova=3D0x00000000fa001000 paddr=3D0x00000000fb000000 size=3D4096
> >>         CPU 0/KVM-3046  [051] .... 63113.340209: map: IOMMU:=20
> >> iova=3D0x00000000f9000000 paddr=3D0x00000000f9000000 size=3D16777216
> >> . . .
> >>
> >> I have enabled qemu trace(-trace events=3D/root/qemu/trace_events). Tr=
ace=20
> >> file consists of the falling functions:
> >> vfio_region_mmap
> >> vfio_get_dev_region
> >> vfio_pci_size_rom
> >> vfio_pci_read_config
> >> vfio_pci_write_config
> >> vfio_iommu_map_notify
> >> vfio_listener_region_add_iommu
> >> vfio_listener_region_add_ram
> >>
> >> Some important brief from qemu trace:
> >> . . .
> >> =D1=8F=D0=BD=D0=B2 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_regio=
n_mmap Region=20
> >> 0000:84:00.0 BAR 0 mmaps[0] [0x0 - 0xffffff]
> >> =D1=8F=D0=BD=D0=B2 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_regio=
n_mmap Region=20
> >> 0000:84:00.0 BAR 2 mmaps[0] [0x0 - 0xfff]
> >> =D1=8F=D0=BD=D0=B2 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_regio=
n_mmap Region=20
> >> 0000:84:00.0 BAR 3 mmaps[0] [0x0 - 0xfff]
> >> =D1=8F=D0=BD=D0=B2 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_regio=
n_mmap Region=20
> >> 0000:84:00.0 BAR 4 mmaps[0] [0x0 - 0xffffff]
> >> . . .
> >> =D1=8F=D0=BD=D0=B2 13 18:17:37 VM qemu-system-x86_64[7131]:=20
> >> vfio_listener_region_add_ram region_add [ram] 0xf8000000 - 0xf8005fff=
=20
> >> [0x7f691e800000]
> >> =D1=8F=D0=BD=D0=B2 13 18:17:37 VM qemu-system-x86_64[7131]:=20
> >> vfio_listener_region_add_ram region_add [ram] 0xf8007000 - 0xf8ffffff=
=20
> >> [0x7f691e807000]
> >> =D1=8F=D0=BD=D0=B2 13 18:17:37 VM qemu-system-x86_64[7131]:=20
> >> vfio_listener_region_add_ram region_add [ram] 0xfa000000 - 0xfa000fff=
=20
> >> [0x7f6b5de37000]
> >> =D1=8F=D0=BD=D0=B2 13 18:17:37 VM qemu-system-x86_64[7131]:=20
> >> vfio_listener_region_add_ram region_add [ram] 0xfa001000 - 0xfa001fff=
=20
> >> [0x7f6b58004000]
> >> =D1=8F=D0=BD=D0=B2 13 18:17:37 VM qemu-system-x86_64[7131]:=20
> >> vfio_listener_region_add_ram region_add [ram] 0xf9000000 - 0xf9ffffff=
=20
> >> [0x7f691d800000]
> >>
> >> I use qemu 4.0.0 which I rebuild for tracing support=20
> >> (--enable-trace-backends=3Dsyslog).
> >>
> >> Please, help me solve this issue. Thank you! =20
> >=20
> > Something has probably created a QEMU MemoryRegion overlapping the BAR,
> > we do this for quirks where we want to intercept a range of MMIO for
> > emulation, but the offset 0x6000 on BAR0 doesn't sound familiar to me.
> > Run the VM with a monitor and see if 'info mtree' provides any info on
> > the handling of that overlap.  Thanks, =20
>=20
>=20
> Could not it be an MSIX region? 'info mtree -f' should tell exactly what
> is going on.

Oh, good call, that's probably it.  The PCI spec specifically
recommends against placing non-MSIX related registers within the same
4K page as the vector table to avoid such things:

 If a Base Address register that maps address space for the MSI-X Table
 or MSI-X PBA also maps other usable address space that is not
 associated with MSI-X structures, locations (e.g., for CSRs) used in
 the other address space must not share any naturally aligned 4-KB
 address range with one where either MSI-X structure resides. This
 allows system software where applicable to use different processor
 attributes for MSI-X structures and the other address space.

We have the following QEMU vfio-pci device option to relocate the BAR
elsewhere for hardware that violates that recommendation or for where
the PCI spec recommended alignment isn't sufficient:

 x-msix-relocation=3D<OffAutoPCIBAR> - off/auto/bar0/bar1/bar2/bar3/bar4/ba=
r5

In this case I'd probably recommend bar2 or bar3 as those BARs would
only be extended to 8K versus bar0/4 would be extended to 32M.  Thanks,

Alex


