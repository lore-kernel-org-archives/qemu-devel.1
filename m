Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ADDC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 08:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314EA2070E
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 08:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9ROzcn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314EA2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVAih-0001o0-6H
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 03:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iVAhr-00014P-Mr
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iVAho-0002g8-Hb
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:42:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42463
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iVAho-0002fy-CG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573720939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9PG70WZj8aRtvzjuIJBzpN70f6dLmU39OdoSPt79lg=;
 b=i9ROzcn0Cn/fmY9TQUZvQYox53DfSq41iUswex4RNItdv+sLG6lCpHj3oTVRGbsEmxaBh7
 bp61GBW9QNAasRlDGK1tbYHaB/9aXmfDPXMXI60FOMlvpf+n8Xy4ENiyUGTxSgna5770uR
 QjGtJfMKHksk5SMNRoi/KTAbnbqxXF4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-UtukC2N4Ms6SMg7SbP_IJA-1; Thu, 14 Nov 2019 03:42:18 -0500
Received: by mail-qv1-f70.google.com with SMTP id d12so3603785qvm.12
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 00:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=477D88+Z33A/pH3qXEj/VGAACI0SvY1TLMkBZNKuVNk=;
 b=R1GvvFj2oZA0mQ0SrfAGu6mj99w2UUwSKi9SxqXcgmRfK7ly90x+44UB6ZNHAny9MT
 p8mRKF7sV5hEX8c2gedvNMVn9CI71XIqusKw1AZgLvpjzh7J3mBPQGtIriYF3VPRWj34
 QmHkV/bM8jRWQJuUSRfbX47woRHg99DoozHBLhQfWdBh85zuB0is9vBIEJ3BdCP3tSJe
 kjDHoxEdLGphLhYManP1TxjBdCaOAkIJaUGJ5HMZt3zAN3lNw7ML0qnCEUXwA63WwB3f
 bQQBLTqkMeVe9koEzyfEOC+YbRLWA5xtIRymK5y6/8K4nyDi8jBnukbAHaIG1uthl6+u
 rFuQ==
X-Gm-Message-State: APjAAAUcwCxVZC6GSWaqLw7dmXl6vrzRXPJa5VOga7m2Z8RiCHR1AOhR
 mXFLDObOf0Wts0FoKXIV3m9O7WnnpxXYM5QXks0NTZFVRvB/Dzwd/tyTFqRqLYTn8JRrOj1j4gB
 7ntY32id0nRdYYJw=
X-Received: by 2002:a05:620a:13d1:: with SMTP id
 g17mr6309362qkl.313.1573720936376; 
 Thu, 14 Nov 2019 00:42:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqyb3nIOzP0jegpcrKTqK29D26yuqfY3f7sFznCZ0PUf6Z7/pLWkMLLgYzE6wBFNXxTG95luEQ==
X-Received: by 2002:a05:620a:13d1:: with SMTP id
 g17mr6309347qkl.313.1573720935942; 
 Thu, 14 Nov 2019 00:42:15 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id z5sm2854539qtm.9.2019.11.14.00.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2019 00:42:15 -0800 (PST)
Date: Thu, 14 Nov 2019 03:42:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: virtio,iommu_platform=on
Message-ID: <20191114034049-mutt-send-email-mst@kernel.org>
References: <17da2769-1999-a0a3-590d-9f9bc6a9adc3@ozlabs.ru>
 <20191112014821-mutt-send-email-mst@kernel.org>
 <7ac95a46-b2ae-005b-1907-5302d5b0a39d@ozlabs.ru>
 <20191113045747-mutt-send-email-mst@kernel.org>
 <83876a34-8bc1-c69b-d846-4ac35a8c0a47@ozlabs.ru>
MIME-Version: 1.0
In-Reply-To: <83876a34-8bc1-c69b-d846-4ac35a8c0a47@ozlabs.ru>
X-MC-Unique: UtukC2N4Ms6SMg7SbP_IJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 14, 2019 at 09:58:47AM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 13/11/2019 21:00, Michael S. Tsirkin wrote:
> > On Wed, Nov 13, 2019 at 03:44:28PM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 12/11/2019 18:08, Michael S. Tsirkin wrote:
> >>> On Tue, Nov 12, 2019 at 02:53:49PM +1100, Alexey Kardashevskiy wrote:
> >>>> Hi!
> >>>>
> >>>> I am enabling IOMMU for virtio in the pseries firmware (SLOF) and se=
eing
> >>>> problems, one of them is SLOF does SCSI bus scan, then it stops the
> >>>> virtio-scsi by clearing MMIO|IO|BUSMASTER from PCI_COMMAND (as SLOF
> >>>> stopped using the devices) and when this happens, I see unassigned
> >>>> memory access (see below) which happens because disabling busmaster
> >>>> disables IOMMU and QEMU cannot access the rings to do some shutdown.=
 And
> >>>> when this happens, the device does not come back even if SLOF re-ena=
bles it.
> >>>
> >>> In fact clearing bus master should disable ring access even
> >>> without the IOMMU.
> >>> Once you do this you should not wait for rings to be processed,
> >>> it is safe to assume they won't be touched again and just
> >>> free up any buffers that have not been used.
> >>>
> >>> Why don't you see this without IOMMU?
> >>
> >> Because without IOMMU, virtio can always access rings, it does not nee=
d
> >> bus master address space for that.
> >=20
> > Right and that's a bug in virtio scsi. E.g. virtio net checks
> > bus mastering before each access.
>=20
> You have to be specific - virtio scsi in the guest or in QEMU?

If a device accesses memory with bus master on, it's buggy.

>=20
> > Which is all well and good, but we can't just break the world
> > so I guess we first need to fix SLOF, and then add
> > a compat property. And maybe keep it broken for
> > legacy ...
> >=20
> >>
> >>> It's a bug I think, probably there to work around buggy guests.
> >>>
> >>> So pls fix this in SLOF and then hopefully we can drop the
> >>> work arounds and have clearing bus master actually block DMA.
> >>
> >>
> >> Laszlo suggested writing 0 to the status but this does not seem helpin=
g,
> >> with both ioeventfd=3Dtrue/false. It looks like setting/clearing busma=
ster
> >> bit confused memory region caches in QEMU's virtio. I am confused whic=
h
> >> direction to keep digging to, any suggestions? Thanks,
> >>
> >=20
> > to clarify you reset after setting bus master? right?
>=20
>=20
> I was talking about clearing the bus master, and where I call that
> virtio reset does not matter. Thanks,
>=20
>=20

so

bus master =3D0
reset
bus master =3D1

device does not recover?


> >=20
> >=20
> >>
> >>>
> >>>> Hacking SLOF to not clear BUSMASTER makes virtio-scsi work but it is
> >>>> hardly a right fix.
> >>>>
> >>>> Is this something expected? Thanks,
> >>>>
> >>>>
> >>>> Here is the exact command line:
> >>>>
> >>>> /home/aik/pbuild/qemu-garrison2-ppc64/ppc64-softmmu/qemu-system-ppc6=
4 \
> >>>>
> >>>> -nodefaults \
> >>>>
> >>>> -chardev stdio,id=3DSTDIO0,signal=3Doff,mux=3Don \
> >>>>
> >>>> -device spapr-vty,id=3Dsvty0,reg=3D0x71000110,chardev=3DSTDIO0 \
> >>>>
> >>>> -mon id=3DMON0,chardev=3DSTDIO0,mode=3Dreadline \
> >>>>
> >>>> -nographic \
> >>>>
> >>>> -vga none \
> >>>>
> >>>> -enable-kvm \
> >>>> -m 2G \
> >>>>
> >>>> -device
> >>>> virtio-scsi-pci,id=3Dvscsi0,iommu_platform=3Don,disable-modern=3Doff=
,disable-legacy=3Don
> >>>> \
> >>>> -drive id=3DDRIVE0,if=3Dnone,file=3Dimg/u1804-64le.qcow2,format=3Dqc=
ow2 \
> >>>>
> >>>> -device scsi-disk,id=3Dscsi-disk0,drive=3DDRIVE0 \
> >>>>
> >>>> -snapshot \
> >>>>
> >>>> -smp 1 \
> >>>>
> >>>> -machine pseries \
> >>>>
> >>>> -L /home/aik/t/qemu-ppc64-bios/ \
> >>>>
> >>>> -trace events=3Dqemu_trace_events \
> >>>>
> >>>> -d guest_errors \
> >>>>
> >>>> -chardev socket,id=3DSOCKET0,server,nowait,path=3Dqemu.mon.ssh59518 =
\
> >>>>
> >>>> -mon chardev=3DSOCKET0,mode=3Dcontrol
> >>>>
> >>>>
> >>>>
> >>>> Here is the backtrace:
> >>>>
> >>>> Thread 5 "qemu-system-ppc" hit Breakpoint 8, unassigned_mem_accepts
> >>>> (opaque=3D0x0, addr=3D0x5802, size=3D0x2, is_write=3D0x0, attrs=3D..=
.) at /home/
> >>>> aik/p/qemu/memory.c:1275
> >>>> 1275        return false;
> >>>> #0  unassigned_mem_accepts (opaque=3D0x0, addr=3D0x5802, size=3D0x2,
> >>>> is_write=3D0x0, attrs=3D...) at /home/aik/p/qemu/memory.c:1275
> >>>> #1  0x00000000100a8ac8 in memory_region_access_valid (mr=3D0x1105c23=
0
> >>>> <io_mem_unassigned>, addr=3D0x5802, size=3D0x2, is_write=3D0x0, attr=
s=3D...) at
> >>>> /home/aik/p/qemu/memory.c:1377
> >>>> #2  0x00000000100a8c88 in memory_region_dispatch_read (mr=3D0x1105c2=
30
> >>>> <io_mem_unassigned>, addr=3D0x5802, pval=3D0x7ffff550d410, op=3DMO_1=
6,
> >>>> attrs=3D...) at /home/aik/p/qemu/memory.c:1418
> >>>> #3  0x000000001001cad4 in address_space_lduw_internal_cached_slow
> >>>> (cache=3D0x7fff68036fa0, addr=3D0x2, attrs=3D..., result=3D0x0,
> >>>> endian=3DDEVICE_LITTLE_ENDIAN) at /home/aik/p/qemu/memory_ldst.inc.c=
:211
> >>>> #4  0x000000001001cc84 in address_space_lduw_le_cached_slow
> >>>> (cache=3D0x7fff68036fa0, addr=3D0x2, attrs=3D..., result=3D0x0) at
> >>>> /home/aik/p/qemu/memory_ldst.inc.c:249
> >>>> #5  0x000000001019bd80 in address_space_lduw_le_cached
> >>>> (cache=3D0x7fff68036fa0, addr=3D0x2, attrs=3D..., result=3D0x0) at
> >>>> /home/aik/p/qemu/include/exec/memory_ldst_cached.inc.h:56
> >>>> #6  0x000000001019c10c in lduw_le_phys_cached (cache=3D0x7fff68036fa=
0,
> >>>> addr=3D0x2) at /home/aik/p/qemu/include/exec/memory_ldst_phys.inc.h:=
91
> >>>> #7  0x000000001019d86c in virtio_lduw_phys_cached (vdev=3D0x118b9110=
,
> >>>> cache=3D0x7fff68036fa0, pa=3D0x2) at
> >>>> /home/aik/p/qemu/include/hw/virtio/virtio-access.h:166
> >>>> #8  0x000000001019e648 in vring_avail_idx (vq=3D0x118c2720) at
> >>>> /home/aik/p/qemu/hw/virtio/virtio.c:302
> >>>> #9  0x000000001019f5bc in virtio_queue_split_empty (vq=3D0x118c2720)=
 at
> >>>> /home/aik/p/qemu/hw/virtio/virtio.c:581
> >>>> #10 0x000000001019f838 in virtio_queue_empty (vq=3D0x118c2720) at
> >>>> /home/aik/p/qemu/hw/virtio/virtio.c:612
> >>>> #11 0x00000000101a8fa8 in virtio_queue_host_notifier_aio_poll
> >>>> (opaque=3D0x118c2798) at /home/aik/p/qemu/hw/virtio/virtio.c:3389
> >>>> #12 0x000000001092679c in run_poll_handlers_once (ctx=3D0x11212e40,
> >>>> timeout=3D0x7ffff550d7d8) at /home/aik/p/qemu/util/aio-posix.c:520
> >>>> #13 0x0000000010926aec in try_poll_mode (ctx=3D0x11212e40,
> >>>> timeout=3D0x7ffff550d7d8) at /home/aik/p/qemu/util/aio-posix.c:607
> >>>> #14 0x0000000010926c2c in aio_poll (ctx=3D0x11212e40, blocking=3D0x1=
) at
> >>>> /home/aik/p/qemu/util/aio-posix.c:639
> >>>> #15 0x000000001091fe0c in aio_wait_bh_oneshot (ctx=3D0x11212e40,
> >>>> cb=3D0x1016f35c <virtio_scsi_dataplane_stop_bh>, opaque=3D0x118b9110=
) at
> >>>> /home/aik/p/qemu/util/aio-wait.c:71
> >>>> #16 0x000000001016fa60 in virtio_scsi_dataplane_stop (vdev=3D0x118b9=
110)
> >>>> at /home/aik/p/qemu/hw/scsi/virtio-scsi-dataplane.c:211
> >>>> #17 0x0000000010684740 in virtio_bus_stop_ioeventfd (bus=3D0x118b909=
8) at
> >>>> /home/aik/p/qemu/hw/virtio/virtio-bus.c:245
> >>>> #18 0x0000000010688290 in virtio_pci_stop_ioeventfd (proxy=3D0x118b0=
fa0)
> >>>> at /home/aik/p/qemu/hw/virtio/virtio-pci.c:292
> >>>> #19 0x00000000106891e8 in virtio_write_config (pci_dev=3D0x118b0fa0,
> >>>> address=3D0x4, val=3D0x100100, len=3D0x4) at
> >>>> /home/aik/p/qemu/hw/virtio/virtio-pci.c:613
> >>>> #20 0x00000000105b7228 in pci_host_config_write_common
> >>>> (pci_dev=3D0x118b0fa0, addr=3D0x4, limit=3D0x100, val=3D0x100100, le=
n=3D0x4) at
> >>>> /home/aik/p/qemu/hw/pci/pci_host.c:81
> >>>> #21 0x00000000101f7bdc in finish_write_pci_config (spapr=3D0x1121720=
0,
> >>>> buid=3D0x800000020000000, addr=3D0x4, size=3D0x4, val=3D0x100100,
> >>>> rets=3D0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_pci.c:192
> >>>> #22 0x00000000101f7cec in rtas_ibm_write_pci_config (cpu=3D0x11540df=
0,
> >>>> spapr=3D0x11217200, token=3D0x2017, nargs=3D0x5, args=3D0x7e7533cc, =
nret=3D0x1,
> >>>> rets=3D0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_pci.c:216
> >>>> #23 0x00000000101f5860 in spapr_rtas_call (cpu=3D0x11540df0,
> >>>> spapr=3D0x11217200, token=3D0x2017, nargs=3D0x5, args=3D0x7e7533cc, =
nret=3D0x1,
> >>>> rets=3D0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_rtas.c:416
> >>>> #24 0x00000000101ee214 in h_rtas (cpu=3D0x11540df0, spapr=3D0x112172=
00,
> >>>> opcode=3D0xf000, args=3D0x7ffff4cf0030) at
> >>>> /home/aik/p/qemu/hw/ppc/spapr_hcall.c:1214
> >>>> #25 0x00000000101f0524 in spapr_hypercall (cpu=3D0x11540df0,
> >>>> opcode=3D0xf000, args=3D0x7ffff4cf0030) at
> >>>> /home/aik/p/qemu/hw/ppc/spapr_hcall.c:2014
> >>>> #26 0x000000001033bff0 in kvm_arch_handle_exit (cs=3D0x11540df0,
> >>>> run=3D0x7ffff4cf0000) at /home/aik/p/qemu/target/ppc/kvm.c:1684
> >>>> #27 0x00000000100cc7c8 in kvm_cpu_exec (cpu=3D0x11540df0) at
> >>>> /home/aik/p/qemu/accel/kvm/kvm-all.c:2391
> >>>> #28 0x000000001008edf8 in qemu_kvm_cpu_thread_fn (arg=3D0x11540df0) =
at
> >>>> /home/aik/p/qemu/cpus.c:1318
> >>>> #29 0x000000001092c704 in qemu_thread_start (args=3D0x11588d90) at
> >>>> /home/aik/p/qemu/util/qemu-thread-posix.c:519
> >>>> #30 0x00007ffff7b58070 in start_thread (arg=3D0x7ffff550ebf0) at
> >>>> pthread_create.c:335
> >>>> #31 0x00007ffff7aa3a70 in clone () at
> >>>> ../sysdeps/unix/sysv/linux/powerpc/powerpc64/clone.S:96
> >>>> (gdb)
> >>>>
> >>>> --=20
> >>>> Alexey
> >>>
> >>
> >> --=20
> >> Alexey
> >=20
>=20
> --=20
> Alexey


