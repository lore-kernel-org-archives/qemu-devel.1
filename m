Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F01DC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2960021849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et4iwu3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2960021849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoQ8w-000813-Ex
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 06:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53887)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hoQ8g-0007bn-AS
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hoQ8c-0008DC-W1
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:29:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hoQ8c-0008CG-Ih
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:29:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id f9so31705594wre.12
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 03:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6BaGnEtn43N16RXSVMyJw2DhFJwrdprZ6C5Brjy572s=;
 b=et4iwu3yPpc2l3dFOASZ0zhaSTBsQPaodKKVo1WZDdJXyLSWwOHDguVp+GzbU4KUCi
 MUCubKVDi1/Enx07FDnPxQyybhdf+oYUQ+o2BJBoWzp8umuz0JoWx3foqYMZZCeaWhTJ
 GPZXbUnjbUNS+TDUcRa8y9dawjU3Bo5BudIQnzW1u/n/0xYd9gbRSv4MlgI1inhLkJlA
 z5gP/ZzF50wkKbd5wQwZptQfJJ0POSoJzQwKMwTYesDay0OqCwqmUOAI8hlGe8JvhdkD
 gUJOPQgSZmTwZpXfA32X58RM48hnDDYB12DsvqOAQl83FJnFQCJjJNJ1eJI5PWqdfRtj
 rRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6BaGnEtn43N16RXSVMyJw2DhFJwrdprZ6C5Brjy572s=;
 b=KjuD1a8/fSt0S+vXF40/L7OGUArAAU8G4gLkJQt+EZj4gs0lsdkg1uraG5n09IU+Fz
 CeoFoXQfd1lcTM60cZKvXzpq3ZQsYk/B2QCGHfvh1mQUVnB/jJzRuJ1TlrM+g5pbX6MW
 Co7RCsBF0UEX9SGV/ZuJktqJLuebs5yKC1DYvaxyJLwAazrA7gBMUnNDAIKU6K6KLZRW
 YWi/qlUWRh4omODUgkXyFc9s6c/DTeT/lJdnz2uYnMQjStGBn8s3F5TL7iO1funarDVx
 BvWSyGERc7cMWZIbnfJwjxj2th9/V/PoFShm0MedmbQOsmTVmrQlzr5qg5gW0YBYYmIL
 Lzyw==
X-Gm-Message-State: APjAAAW+Qtom6pqVh06bqp/1ZvHC1UbD3gmBImKPy9y6jJvUekD5qo8H
 lM+vwifBqBLZAFIxupAbbz8=
X-Google-Smtp-Source: APXvYqwea8p+Q3yC94H1X0aZpZ8/zzXKHJU4v1TKpt603F2uukY37Pj/JaSxepRgCvbYBwxkRTF7WQ==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr55918967wrq.110.1563532157202; 
 Fri, 19 Jul 2019 03:29:17 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id e5sm31605066wro.41.2019.07.19.03.29.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 03:29:16 -0700 (PDT)
Date: Fri, 19 Jul 2019 11:29:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190719102915.GG18585@stefanha-x1.localdomain>
References: <20190702121106.28374-1-slp@redhat.com>
 <20190703095825.GE11844@stefanha-x1.localdomain>
 <87d0i7tlkl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3xoW37o/FfUZJwQG"
Content-Disposition: inline
In-Reply-To: <87d0i7tlkl.fsf@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 sgarzare@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 05:21:46PM +0200, Sergio Lopez wrote:
>=20
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Tue, Jul 02, 2019 at 02:11:02PM +0200, Sergio Lopez wrote:
> >> Microvm is a machine type inspired by both NEMU and Firecracker, and
> >> constructed after the machine model implemented by the latter.
> >>=20
> >> It's main purpose is providing users a KVM-only machine type with fast
> >> boot times, minimal attack surface (measured as the number of IO ports
> >> and MMIO regions exposed to the Guest) and small footprint (specially
> >> when combined with the ongoing QEMU modularization effort).
> >>=20
> >> Normally, other than the device support provided by KVM itself,
> >> microvm only supports virtio-mmio devices. Microvm also includes a
> >> legacy mode, which adds an ISA bus with a 16550A serial port, useful
> >> for being able to see the early boot kernel messages.
> >>=20
> >> Microvm only supports booting PVH-enabled Linux ELF images. Booting
> >> other PVH-enabled kernels may be possible, but due to the lack of ACPI
> >> and firmware, we're relying on the command line for specifying the
> >> location of the virtio-mmio transports. If there's an interest on
> >> using this machine type with other kernels, we'll try to find some
> >> kind of middle ground solution.
> >>=20
> >> This is the list of the exposed IO ports and MMIO regions when running
> >> in non-legacy mode:
> >>=20
> >> address-space: memory
> >>     00000000d0000000-00000000d00001ff (prio 0, i/o): virtio-mmio
> >>     00000000d0000200-00000000d00003ff (prio 0, i/o): virtio-mmio
> >>     00000000d0000400-00000000d00005ff (prio 0, i/o): virtio-mmio
> >>     00000000d0000600-00000000d00007ff (prio 0, i/o): virtio-mmio
> >>     00000000d0000800-00000000d00009ff (prio 0, i/o): virtio-mmio
> >>     00000000d0000a00-00000000d0000bff (prio 0, i/o): virtio-mmio
> >>     00000000d0000c00-00000000d0000dff (prio 0, i/o): virtio-mmio
> >>     00000000d0000e00-00000000d0000fff (prio 0, i/o): virtio-mmio
> >>     00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
> >>=20
> >> address-space: I/O
> >>   0000000000000000-000000000000ffff (prio 0, i/o): io
> >>     0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
> >>     0000000000000040-0000000000000043 (prio 0, i/o): kvm-pit
> >>     000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
> >>     00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
> >>     00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
> >>     00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
> >>=20
> >> A QEMU instance with the microvm machine type can be invoked this way:
> >>=20
> >>  - Normal mode:
> >>=20
> >> qemu-system-x86_64 -M microvm -m 512m -smp 2 \
> >>  -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
> >>  -nodefaults -no-user-config \
> >>  -chardev pty,id=3Dvirtiocon0,server \
> >>  -device virtio-serial-device \
> >>  -device virtconsole,chardev=3Dvirtiocon0 \
> >>  -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
> >>  -device virtio-blk-device,drive=3Dtest \
> >>  -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
> >>  -device virtio-net-device,netdev=3Dtap0
> >>=20
> >>  - Legacy mode:
> >>=20
> >> qemu-system-x86_64 -M microvm,legacy -m 512m -smp 2 \
> >>  -kernel vmlinux -append "console=3DttyS0 root=3D/dev/vda" \
> >>  -nodefaults -no-user-config \
> >>  -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
> >>  -device virtio-blk-device,drive=3Dtest \
> >>  -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
> >>  -device virtio-net-device,netdev=3Dtap0 \
> >>  -serial stdio
> >
> > Please post metrics that compare this against a minimal Q35.
> >
> > With qboot it was later found that SeaBIOS can achieve comparable boot
> > times, so it wasn't worth maintaining qboot.
> >
> > Data is needed to show that microvm is really a significant improvement
> > over a minimal Q35.
>=20
> I've just ran some numbers using Stefano Garzarella's qemu-boot-time
> scripts [1] on a server with 2xIntel Xeon Silver 4114 2.20GHz, using the
> upstream QEMU (474f3938d79ab36b9231c9ad3b5a9314c2aeacde) built with
> minimal features [2]. The VM boots a minimal kernel [3] without initrd,
> using a kata container image as root via virtio-blk (though this isn't
> really relevant, as we're just taking measurements until the kernel is
> about to exec init).
>=20
> To try to make the comparison as fair as possible, I've used a minimal
> q35 machine with as few devices as possible. Disabling HPET and PIT at
> the same time caused the kernel to get stuck on boot, so I ran two
> iterations, one without HPET and the other without PIT:
>=20
>=20
> -----------------
>  | Q35 with HPET |
>  -----------------
>=20
> Command line:
>=20
> ./x86_64-softmmu/qemu-system-x86_64 -m 512m -enable-kvm -M q35,smbus=3Dof=
f,nvdimm=3Doff,pit=3Doff,vmport=3Doff,sata=3Doff,usb=3Doff,graphics=3Doff -=
kernel /root/src/images/vmlinux-5.2 -append "console=3Dhvc0 reboot=3Dk pani=
c=3D1 root=3D/dev/vda quiet" -smp 1 -nodefaults -no-user-config -chardev pt=
y,id=3Dvirtiocon0,server -device virtio-serial -device virtconsole,chardev=
=3Dvirtiocon0 -drive id=3Dtest,file=3D/root/src/images/hello-rootfs.ext4,fo=
rmat=3Draw,if=3Dnone -device virtio-blk,drive=3Dtest
>=20
> Average boot times after 10 consecutive runs:
>=20
>  qemu_init_end: 77.637936
>  linux_start_kernel: 117.082526 (+39.44459)
>  linux_start_user: 364.629972 (+247.547446)
>=20
> Memory tree:
>=20
>  address-space: memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     0000000000000000-000000001fffffff (prio 0, i/o): alias ram-below-4g @=
pc.ram 0000000000000000-000000001fffffff
>     0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>       00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>       00000000000e0000-00000000000fffff (prio 1, i/o): alias isa-bios @pc=
=2Ebios 0000000000020000-000000000003ffff
>       00000000febf4000-00000000febf7fff (prio 1, i/o): virtio-pci
>         00000000febf4000-00000000febf4fff (prio 0, i/o): virtio-pci-common
>         00000000febf5000-00000000febf5fff (prio 0, i/o): virtio-pci-isr
>         00000000febf6000-00000000febf6fff (prio 0, i/o): virtio-pci-device
>         00000000febf7000-00000000febf7fff (prio 0, i/o): virtio-pci-notify
>       00000000febf8000-00000000febfbfff (prio 1, i/o): virtio-pci
>         00000000febf8000-00000000febf8fff (prio 0, i/o): virtio-pci-common
>         00000000febf9000-00000000febf9fff (prio 0, i/o): virtio-pci-isr
>         00000000febfa000-00000000febfafff (prio 0, i/o): virtio-pci-device
>         00000000febfb000-00000000febfbfff (prio 0, i/o): virtio-pci-notify
>       00000000febfe000-00000000febfefff (prio 1, i/o): virtio-serial-pci-=
msix
>         00000000febfe000-00000000febfe01f (prio 0, i/o): msix-table
>         00000000febfe800-00000000febfe807 (prio 0, i/o): msix-pba
>       00000000febff000-00000000febfffff (prio 1, i/o): virtio-blk-pci-msix
>         00000000febff000-00000000febff01f (prio 0, i/o): msix-table
>         00000000febff800-00000000febff807 (prio 0, i/o): msix-pba
>       00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>     00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @=
pci 00000000000a0000-00000000000bffff
>     00000000000c0000-00000000000c2fff (prio 1000, i/o): alias kvmvapic-ro=
m @pc.ram 00000000000c0000-00000000000c2fff
>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000c0000-00000000000c3fff [disabled]
>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000c0000-00000000000c3fff [disabled]
>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000c0000-00000000000c3fff
>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000c0000-00000000000c3fff [disabled]
>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000c4000-00000000000c7fff [disabled]
>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000c4000-00000000000c7fff [disabled]
>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000c4000-00000000000c7fff
>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000c4000-00000000000c7fff [disabled]
>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000c8000-00000000000cbfff [disabled]
>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000c8000-00000000000cbfff [disabled]
>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000c8000-00000000000cbfff
>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci 0=
0000000000c8000-00000000000cbfff [disabled]
>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000cc000-00000000000cffff [disabled]
>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000cc000-00000000000cffff [disabled]
>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000cc000-00000000000cffff
>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci 0=
0000000000cc000-00000000000cffff [disabled]
>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000d0000-00000000000d3fff [disabled]
>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000d0000-00000000000d3fff [disabled]
>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000d0000-00000000000d3fff
>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000d0000-00000000000d3fff [disabled]
>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000d4000-00000000000d7fff [disabled]
>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000d4000-00000000000d7fff [disabled]
>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000d4000-00000000000d7fff
>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000d4000-00000000000d7fff [disabled]
>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000d8000-00000000000dbfff [disabled]
>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000d8000-00000000000dbfff [disabled]
>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000d8000-00000000000dbfff
>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci 0=
0000000000d8000-00000000000dbfff [disabled]
>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000dc000-00000000000dffff [disabled]
>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000dc000-00000000000dffff [disabled]
>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000dc000-00000000000dffff
>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci 0=
0000000000dc000-00000000000dffff [disabled]
>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000e0000-00000000000e3fff [disabled]
>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000e0000-00000000000e3fff [disabled]
>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000e0000-00000000000e3fff
>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000e0000-00000000000e3fff [disabled]
>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000e4000-00000000000e7fff [disabled]
>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000e4000-00000000000e7fff [disabled]
>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000e4000-00000000000e7fff
>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000e4000-00000000000e7fff [disabled]
>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000e8000-00000000000ebfff
>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000e8000-00000000000ebfff [disabled]
>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000e8000-00000000000ebfff [disabled]
>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci 0=
0000000000e8000-00000000000ebfff [disabled]
>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000ec000-00000000000effff
>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000ec000-00000000000effff [disabled]
>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000ec000-00000000000effff [disabled]
>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci 0=
0000000000ec000-00000000000effff [disabled]
>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000f0000-00000000000fffff [disabled]
>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000f0000-00000000000fffff [disabled]
>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000f0000-00000000000fffff
>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci 0=
0000000000f0000-00000000000fffff [disabled]
>     0000000020000000-0000000020000000 (prio 1, i/o): tseg-blackhole [disa=
bled]
>     00000000b0000000-00000000bfffffff (prio 0, i/o): pcie-mmcfg-mmio
>     00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>     00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
>     00000000fed1c000-00000000fed1ffff (prio 1, i/o): lpc-rcrb-mmio
>     00000000feda0000-00000000fedbffff (prio 1, i/o): alias smram-open-hig=
h @pc.ram 00000000000a0000-00000000000bffff [disabled]
>     00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>=20
>  address-space: I/O
>   0000000000000000-000000000000ffff (prio 0, i/o): io
>     0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
>     0000000000000008-000000000000000f (prio 0, i/o): dma-cont
>     0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
>     0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
>     0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
>     0000000000000070-0000000000000071 (prio 0, i/o): rtc
>       0000000000000070-0000000000000070 (prio 0, i/o): rtc-index
>     000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
>     0000000000000080-0000000000000080 (prio 0, i/o): ioport80
>     0000000000000081-0000000000000083 (prio 0, i/o): dma-page
>     0000000000000087-0000000000000087 (prio 0, i/o): dma-page
>     0000000000000089-000000000000008b (prio 0, i/o): dma-page
>     000000000000008f-000000000000008f (prio 0, i/o): dma-page
>     0000000000000092-0000000000000092 (prio 0, i/o): port92
>     00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
>     00000000000000b2-00000000000000b3 (prio 0, i/o): apm-io
>     00000000000000c0-00000000000000cf (prio 0, i/o): dma-chan
>     00000000000000d0-00000000000000df (prio 0, i/o): dma-cont
>     00000000000000f0-00000000000000f0 (prio 0, i/o): ioportF0
>     00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
>     00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
>     0000000000000510-0000000000000511 (prio 0, i/o): fwcfg
>     0000000000000514-000000000000051b (prio 0, i/o): fwcfg.dma
>     0000000000000600-000000000000067f (prio 0, i/o): ich9-pm
>       0000000000000600-0000000000000603 (prio 0, i/o): acpi-evt
>       0000000000000604-0000000000000605 (prio 0, i/o): acpi-cnt
>       0000000000000608-000000000000060b (prio 0, i/o): acpi-tmr
>       0000000000000620-000000000000062f (prio 0, i/o): acpi-gpe0
>       0000000000000630-0000000000000637 (prio 0, i/o): acpi-smi
>       0000000000000660-000000000000067f (prio 0, i/o): sm-tco
>     0000000000000cd8-0000000000000ce3 (prio 0, i/o): acpi-mem-hotplug
>     0000000000000cf8-0000000000000cfb (prio 0, i/o): pci-conf-idx
>     0000000000000cf9-0000000000000cf9 (prio 1, i/o): lpc-reset-control
>     0000000000000cfc-0000000000000cff (prio 0, i/o): pci-conf-data
>     000000000000c000-000000000000c07f (prio 1, i/o): virtio-pci
>     000000000000c080-000000000000c0bf (prio 1, i/o): virtio-pci
>=20
>=20
>  ----------------
>  | Q35 with PIT |
>  ----------------
>=20
> Command line:
>=20
> ./x86_64-softmmu/qemu-system-x86_64 -m 512m -enable-kvm -M q35,smbus=3Dof=
f,nvdimm=3Doff,pit=3Don,vmport=3Doff,sata=3Doff,usb=3Doff,graphics=3Doff -n=
o-hpet -kernel /root/src/images/vmlinux-5.2 -append "console=3Dhvc0 reboot=
=3Dk panic=3D1 root=3D/dev/vda quiet" -smp 1 -nodefaults -no-user-config -c=
hardev pty,id=3Dvirtiocon0,server -device virtio-serial -device virtconsole=
,chardev=3Dvirtiocon0 -drive id=3Dtest,file=3D/root/src/images/hello-rootfs=
=2Eext4,format=3Draw,if=3Dnone -device virtio-blk,drive=3Dtest
>=20
> Average boot times after 10 consecutive runs:
>=20
>  qemu_init_end: 77.467852
>  linux_start_kernel: 116.688472 (+39.22062)
>  linux_start_user: 363.033365 (+246.344893)
>=20
> Memory tree:
>=20
> address-space: memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     0000000000000000-000000001fffffff (prio 0, i/o): alias ram-below-4g @=
pc.ram 0000000000000000-000000001fffffff
>     0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>       00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>       00000000000e0000-00000000000fffff (prio 1, i/o): alias isa-bios @pc=
=2Ebios 0000000000020000-000000000003ffff
>       00000000febf4000-00000000febf7fff (prio 1, i/o): virtio-pci
>         00000000febf4000-00000000febf4fff (prio 0, i/o): virtio-pci-common
>         00000000febf5000-00000000febf5fff (prio 0, i/o): virtio-pci-isr
>         00000000febf6000-00000000febf6fff (prio 0, i/o): virtio-pci-device
>         00000000febf7000-00000000febf7fff (prio 0, i/o): virtio-pci-notify
>       00000000febf8000-00000000febfbfff (prio 1, i/o): virtio-pci
>         00000000febf8000-00000000febf8fff (prio 0, i/o): virtio-pci-common
>         00000000febf9000-00000000febf9fff (prio 0, i/o): virtio-pci-isr
>         00000000febfa000-00000000febfafff (prio 0, i/o): virtio-pci-device
>         00000000febfb000-00000000febfbfff (prio 0, i/o): virtio-pci-notify
>       00000000febfe000-00000000febfefff (prio 1, i/o): virtio-serial-pci-=
msix
>         00000000febfe000-00000000febfe01f (prio 0, i/o): msix-table
>         00000000febfe800-00000000febfe807 (prio 0, i/o): msix-pba
>       00000000febff000-00000000febfffff (prio 1, i/o): virtio-blk-pci-msix
>         00000000febff000-00000000febff01f (prio 0, i/o): msix-table
>         00000000febff800-00000000febff807 (prio 0, i/o): msix-pba
>       00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>     00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @=
pci 00000000000a0000-00000000000bffff
>     00000000000c0000-00000000000c2fff (prio 1000, i/o): alias kvmvapic-ro=
m @pc.ram 00000000000c0000-00000000000c2fff
>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000c0000-00000000000c3fff [disabled]
>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000c0000-00000000000c3fff [disabled]
>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000c0000-00000000000c3fff
>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000c0000-00000000000c3fff [disabled]
>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000c4000-00000000000c7fff [disabled]
>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000c4000-00000000000c7fff [disabled]
>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000c4000-00000000000c7fff
>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000c4000-00000000000c7fff [disabled]
>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000c8000-00000000000cbfff [disabled]
>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000c8000-00000000000cbfff [disabled]
>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000c8000-00000000000cbfff
>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci 0=
0000000000c8000-00000000000cbfff [disabled]
>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000cc000-00000000000cffff [disabled]
>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000cc000-00000000000cffff [disabled]
>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000cc000-00000000000cffff
>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci 0=
0000000000cc000-00000000000cffff [disabled]
>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000d0000-00000000000d3fff [disabled]
>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000d0000-00000000000d3fff [disabled]
>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000d0000-00000000000d3fff
>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000d0000-00000000000d3fff [disabled]
>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000d4000-00000000000d7fff [disabled]
>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000d4000-00000000000d7fff [disabled]
>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000d4000-00000000000d7fff
>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000d4000-00000000000d7fff [disabled]
>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000d8000-00000000000dbfff [disabled]
>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000d8000-00000000000dbfff [disabled]
>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000d8000-00000000000dbfff
>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci 0=
0000000000d8000-00000000000dbfff [disabled]
>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000dc000-00000000000dffff [disabled]
>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000dc000-00000000000dffff [disabled]
>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000dc000-00000000000dffff
>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci 0=
0000000000dc000-00000000000dffff [disabled]
>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000e0000-00000000000e3fff [disabled]
>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000e0000-00000000000e3fff [disabled]
>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000e0000-00000000000e3fff
>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000e0000-00000000000e3fff [disabled]
>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000e4000-00000000000e7fff [disabled]
>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000e4000-00000000000e7fff [disabled]
>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000e4000-00000000000e7fff
>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci 0=
0000000000e4000-00000000000e7fff [disabled]
>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000e8000-00000000000ebfff
>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000e8000-00000000000ebfff [disabled]
>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000e8000-00000000000ebfff [disabled]
>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci 0=
0000000000e8000-00000000000ebfff [disabled]
>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000ec000-00000000000effff
>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000ec000-00000000000effff [disabled]
>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000ec000-00000000000effff [disabled]
>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci 0=
0000000000ec000-00000000000effff [disabled]
>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-ram @pc.ra=
m 00000000000f0000-00000000000fffff [disabled]
>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pc.ra=
m 00000000000f0000-00000000000fffff [disabled]
>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-rom @pc.ra=
m 00000000000f0000-00000000000fffff
>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci 0=
0000000000f0000-00000000000fffff [disabled]
>     0000000020000000-0000000020000000 (prio 1, i/o): tseg-blackhole [disa=
bled]
>     00000000b0000000-00000000bfffffff (prio 0, i/o): pcie-mmcfg-mmio
>     00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>     00000000fed1c000-00000000fed1ffff (prio 1, i/o): lpc-rcrb-mmio
>     00000000feda0000-00000000fedbffff (prio 1, i/o): alias smram-open-hig=
h @pc.ram 00000000000a0000-00000000000bffff [disabled]
>     00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>=20
> address-space: I/O
>   0000000000000000-000000000000ffff (prio 0, i/o): io
>     0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
>     0000000000000008-000000000000000f (prio 0, i/o): dma-cont
>     0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
>     0000000000000040-0000000000000043 (prio 0, i/o): kvm-pit
>     0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
>     0000000000000061-0000000000000061 (prio 0, i/o): pcspk
>     0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
>     0000000000000070-0000000000000071 (prio 0, i/o): rtc
>       0000000000000070-0000000000000070 (prio 0, i/o): rtc-index
>     000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
>     0000000000000080-0000000000000080 (prio 0, i/o): ioport80
>     0000000000000081-0000000000000083 (prio 0, i/o): dma-page
>     0000000000000087-0000000000000087 (prio 0, i/o): dma-page
>     0000000000000089-000000000000008b (prio 0, i/o): dma-page
>     000000000000008f-000000000000008f (prio 0, i/o): dma-page
>     0000000000000092-0000000000000092 (prio 0, i/o): port92
>     00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
>     00000000000000b2-00000000000000b3 (prio 0, i/o): apm-io
>     00000000000000c0-00000000000000cf (prio 0, i/o): dma-chan
>     00000000000000d0-00000000000000df (prio 0, i/o): dma-cont
>     00000000000000f0-00000000000000f0 (prio 0, i/o): ioportF0
>     00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
>     00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
>     0000000000000510-0000000000000511 (prio 0, i/o): fwcfg
>     0000000000000514-000000000000051b (prio 0, i/o): fwcfg.dma
>     0000000000000600-000000000000067f (prio 0, i/o): ich9-pm
>       0000000000000600-0000000000000603 (prio 0, i/o): acpi-evt
>       0000000000000604-0000000000000605 (prio 0, i/o): acpi-cnt
>       0000000000000608-000000000000060b (prio 0, i/o): acpi-tmr
>       0000000000000620-000000000000062f (prio 0, i/o): acpi-gpe0
>       0000000000000630-0000000000000637 (prio 0, i/o): acpi-smi
>       0000000000000660-000000000000067f (prio 0, i/o): sm-tco
>     0000000000000cd8-0000000000000ce3 (prio 0, i/o): acpi-mem-hotplug
>     0000000000000cf8-0000000000000cfb (prio 0, i/o): pci-conf-idx
>     0000000000000cf9-0000000000000cf9 (prio 1, i/o): lpc-reset-control
>     0000000000000cfc-0000000000000cff (prio 0, i/o): pci-conf-data
>     000000000000c000-000000000000c07f (prio 1, i/o): virtio-pci
>     000000000000c080-000000000000c0bf (prio 1, i/o): virtio-pci
>=20
>=20
>  -----------
>  | microvm |
>  -----------
>=20
> Command line:
>=20
> ./x86_64-softmmu/qemu-system-x86_64 -m 512m -enable-kvm -M microvm -kerne=
l /root/src/images/vmlinux-5.2 -append "console=3Dhvc0 reboot=3Dk panic=3D1=
 root=3D/dev/vda quiet" -smp 1 -nodefaults -no-user-config -chardev pty,id=
=3Dvirtiocon0,server -device virtio-serial-device -device virtconsole,chard=
ev=3Dvirtiocon0 -drive id=3Dtest,file=3D/root/src/images/hello-rootfs.ext4,=
format=3Draw,if=3Dnone -device virtio-blk-device,drive=3Dtest
>=20
> Average boot times after 10 consecutive runs:
>=20
>  qemu_init_end: 64.043264
>  linux_start_kernel: 65.481782 (+1.438518)
>  linux_start_user: 114.938353 (+49.456571)
>=20
> Memory tree:
>=20
>  address-space: memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     0000000000000000-000000001fffffff (prio 0, i/o): alias ram-below-4g @=
microvm.ram 0000000000000000-000000001fffffff
>     00000000d0000000-00000000d00001ff (prio 0, i/o): virtio-mmio
>     00000000d0000200-00000000d00003ff (prio 0, i/o): virtio-mmio
>     00000000d0000400-00000000d00005ff (prio 0, i/o): virtio-mmio
>     00000000d0000600-00000000d00007ff (prio 0, i/o): virtio-mmio
>     00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>     00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>=20
>  address-space: I/O
>   0000000000000000-000000000000ffff (prio 0, i/o): io
>     000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
>=20
>=20
>  --------------
>  | Conclusion |
>  --------------
>=20
> The average boot time of microvm is a third of Q35's (115ms vs. 363ms),
> and is smaller on all sections (QEMU initialization, firmware overhead
> and kernel start-to-user).
>=20
> Microvm's memory tree is also visibly simpler, significantly reducing
> the exposed surface to the guest.
>=20
> While we can certainly work on making Q35 smaller, I definitely think
> it's better (and way safer!) having a specialized machine type for a
> specific use case, than a minimal Q35 whose behavior significantly
> diverges from a conventional Q35.

Interesting, so not a 10x difference!  This might be amenable to
optimization.

My concern with microvm is that it's so limited that few users will be
able to benefit from the reduced attack surface and faster startup time.
I think it's worth investigating slimming down Q35 further first.

In terms of startup time the first step would be profiling Q35 kernel
startup to find out what's taking so long (firmware initialization, PCI
probing, etc)?

> Sergio.
>=20
> [1] https://github.com/stefano-garzarella/qemu-boot-time
> [2] https://paste.fedoraproject.org/paste/YZ9Ok-dJtQrc0xxctFm-nw
> [3] https://paste.fedoraproject.org/paste/sck0jfioAJdMq51HH6wkmA



--3xoW37o/FfUZJwQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0xm3sACgkQnKSrs4Gr
c8idxQf9HtKFvdE1rP6Gs5UyNDZX05XsZCkcMBKs/EZlso2SP2aaSO3ykozsjlFo
YrMsv32+518GYcnrE1qeXkPdUbzPq+v6rPubzvkk5YWZ0oR4Y+Ut+jCaaZrz6rvH
cbefqUOEv9sz9Bpv/fWGe3H8rgOW4t8z4kLTegAJfMra6hhA3/v9lLrWRNZtZQPR
NAGumbmLgfMxECkbjaWkhjG3exeOxxe0IyjOE/2M4aiDI/snT2myipWdBxRAs/kR
6O0e8Zy3Dh1g+GQbfRiVwBo35/04PGyPsRLoatLTePvdh9vmUK2WGzNJej8DDQk2
OreNu482TWaAZBiZYySuLEenkLZ1JQ==
=iy+7
-----END PGP SIGNATURE-----

--3xoW37o/FfUZJwQG--

