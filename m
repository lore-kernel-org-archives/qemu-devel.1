Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3E2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 18:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA56B206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 18:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkzgQt7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA56B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Ykz-0002so-TN
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 14:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k5YkD-0002Rs-Tf
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 14:11:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54769
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k5YkA-0004a0-Qk
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 14:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597169485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJ+wwCxM2xf0Wje9eKwDbH8QVR0ykSyhBz4g6fpP2is=;
 b=JkzgQt7QVTgzFMIm4nGyovSTkYmp3/LZJCBsldafozwwLaYR4iHlcNn93/vVnPmAbInKuO
 hMHdGRjM9NaRG4S4o/czfXu4dtOu4Bx8zYthCL06F8E22W0MyFTStzsvluIi5EB3Ck6d6D
 yNJgLYE4YZmZEEaFs8pF0Dm1BLJ8wCw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-7NXxEG4kNXOI6CV0vYDDpg-1; Tue, 11 Aug 2020 14:11:22 -0400
X-MC-Unique: 7NXxEG4kNXOI6CV0vYDDpg-1
Received: by mail-qv1-f72.google.com with SMTP id v5so10239427qvr.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 11:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jJ+wwCxM2xf0Wje9eKwDbH8QVR0ykSyhBz4g6fpP2is=;
 b=U9wFrn2IY0rsZqMHhWFsvLfXS0tiIN01qtWwuZR2EwmyquXxfvxBs+tUztds6B47xk
 zhHoV4+xofIn9zo3dZq32HBkSSqLI61WMTL7Hz4dBUxoEE4Q5FVmC6LjfgEwMlNyTaDX
 Qcv7KsaSnFT2/gYKtzxuTzrRCzD4GCSLNQTk5aAL+BUGd+2xEZIZrdVfl++ZCjLb2FsW
 tbwA60Zc48zA3i+cTNo0PBBoUnUzEdQhRyNXKxsxep7yEI7aaCZCEZnljiSLsorL1nH6
 1m0Syef7dAjWP+Q9r+wqgKAgzwVAxkSrA9iv9Jd2HyrzbltxYUoV8LB1oIuTPAb98ZmS
 d03g==
X-Gm-Message-State: AOAM530vGvla3NUD2U1jpHkJAkN0+Pxmv8vJJOzceo+LSSLGvQcpF3cX
 g2y823yeAYVFrqApyQWAyIzvn9sa7o72i6XUXcxkUNUX2nQ6MI44owuZMe1QgsoajysK31nd5zb
 O0uHRl2G1DYG8TR4WUXGs7/dELf/80gQ=
X-Received: by 2002:ac8:7051:: with SMTP id y17mr2487181qtm.22.1597169481287; 
 Tue, 11 Aug 2020 11:11:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznYtwxDtgr9O9ATysYeulWO48HOLBhW8B/grtiMwiEIj5k1mtzRIz6ASfppsyYyUX2P25xrjehovjePQWathk=
X-Received: by 2002:ac8:7051:: with SMTP id y17mr2487142qtm.22.1597169480986; 
 Tue, 11 Aug 2020 11:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200811175533.7359-1-eperezma@redhat.com>
In-Reply-To: <20200811175533.7359-1-eperezma@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 11 Aug 2020 20:10:44 +0200
Message-ID: <CAJaqyWf24F8ERAuvYj+0Xv=+cYj4v1MCmvCmQFTqcfLVYYCVuQ@mail.gmail.com>
Subject: Re: [RFC v3 0/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eperezma@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:41:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 7:56 PM Eugenio P=C3=A9rez <eperezma@redhat.com> wr=
ote:
>
> I am able to hit this assertion when a Red Hat 7 guest virtio_net device
> raises an "Invalidation" of all the TLB entries. This happens in the
> guest's startup if 'intel_iommu=3Don' argument is passed to the guest
> kernel and right IOMMU/ATS devices are declared in qemu's command line.
>
> Command line:
> /home/qemu/x86_64-softmmu/qemu-system-x86_64 -name \
> guest=3Drhel7-test,debug-threads=3Don -machine \
> pc-q35-5.1,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff,kernel_irqchip=3Ds=
plit \
> -cpu \
> Broadwell,vme=3Don,ss=3Don,vmx=3Don,f16c=3Don,rdrand=3Don,hypervisor=3Don=
,arat=3Don,tsc-adjust=3Don,umip=3Don,arch-capabilities=3Don,xsaveopt=3Don,p=
dpe1gb=3Don,abm=3Don,skip-l1dfl-vmentry=3Don,rtm=3Don,hle=3Don \
> -m 8096 -realtime mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -u=
uid \
> d022ecbf-679e-4755-87ce-eb87fc5bbc5d -display none -no-user-config \
> -nodefaults -rtc base=3Dutc,driftfix=3Dslew -global \
> kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global \
> ICH9-LPC.disable_s3=3D1 -global ICH9-LPC.disable_s4=3D1 -boot strict=3Don=
 \
> -device intel-iommu,intremap=3Don,device-iotlb=3Don -device \
> pcie-root-port,port=3D0x8,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,multifuncti=
on=3Don,addr=3D0x1 \
> -device \
> pcie-root-port,port=3D0x9,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,addr=3D0x1.=
0x1 \
> -device \
> pcie-root-port,port=3D0xa,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,addr=3D0x1.=
0x2 \
> -device \
> pcie-root-port,port=3D0xb,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,addr=3D0x1.=
0x3 \
> -device \
> pcie-root-port,port=3D0xc,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x1.=
0x4 \
> -device \
> pcie-root-port,port=3D0xd,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x1.=
0x5 \
> -device \
> pcie-root-port,port=3D0xe,chassis=3D7,id=3Dpci.7,bus=3Dpcie.0,addr=3D0x1.=
0x6 \
> -device qemu-xhci,p2=3D15,p3=3D15,id=3Dusb,bus=3Dpci.2,addr=3D0x0 -device=
 \
> virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.3,addr=3D0x0 -drive \
> file=3D/home/virtio-test2.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virti=
o-disk0 \
> -device \
> virtio-blk-pci,scsi=3Doff,bus=3Dpci.4,addr=3D0x0,drive=3Ddrive-virtio-dis=
k0,id=3Dvirtio-disk0,bootindex=3D1 \
> -netdev tap,id=3Dhostnet0,vhost=3Don,vhostforce=3Don -device \
> virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:0d:1d:f2,bus=3D=
pci.1,addr=3D0x0,iommu_platform=3Don,ats=3Don \
> -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.5,addr=3D0x0 -object \
> rng-random,id=3Dobjrng0,filename=3D/dev/urandom -device \
> virtio-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.6,addr=3D0x0 -s -msg \
> timestamp=3Don
>
> Full backtrace:
>
>     at /home/qemu/hw/i386/intel_iommu.c:2468
>     (mr=3D0x555557609330, addr=3D136, value=3D0x7ffde5dfe478, size=3D4, s=
hift=3D0, mask=3D4294967295, attrs=3D...) at /home/qemu/memory.c:483
>     (addr=3D136, value=3D0x7ffde5dfe478, size=3D4, access_size_min=3D4, a=
ccess_size_max=3D8, access_fn=3D
>     0x555555883d38 <memory_region_write_accessor>, mr=3D0x555557609330, a=
ttrs=3D...) at /home/qemu/memory.c:544
>     at /home/qemu/memory.c:1476
>     (fv=3D0x7ffde00935d0, addr=3D4275634312, attrs=3D..., ptr=3D0x7ffff7f=
f0028, len=3D4, addr1=3D136, l=3D4, mr=3D0x555557609330) at /home/qemu/exec=
.c:3146
>     at /home/qemu/exec.c:3186
>     (as=3D0x5555567ca640 <address_space_memory>, addr=3D4275634312, attrs=
=3D..., buf=3D0x7ffff7ff0028, len=3D4) at /home/qemu/exec.c:3277
>     (as=3D0x5555567ca640 <address_space_memory>, addr=3D4275634312, attrs=
=3D..., buf=3D0x7ffff7ff0028, len=3D4, is_write=3Dtrue)
>     at /home/qemu/exec.c:3287
>
> --
>
> Tested with vhost-net, with a linux bridge to forward packets.
> Forwarding with vhostuser interfaces + dpdk-testpmd io forwarding mode se=
ems
> broken also in v5.1.0-rc3.
>
> v3: Skip the assertion in case notifier is a IOTLB one, since they can ma=
nage
>     arbitrary ranges. Using a flag in the notifier for now, as Peter sugg=
ested.
>
> v2: Actually delete assertion instead of just commenting out using C99
>
> Eugenio P=C3=A9rez (1):
>   memory: Skip bad range assertion if notifier supports arbitrary masks
>
>  hw/virtio/vhost.c     |  2 +-
>  include/exec/memory.h |  2 ++
>  softmmu/memory.c      | 10 ++++++++--
>  3 files changed, 11 insertions(+), 3 deletions(-)
>
> --
> 2.18.1
>
>

Using this patch as a reference, I'm having problems to understand:

- I'm not sure that the flag name expresses clearly the notifier capability=
.
- What would be the advantages of using another field (NotifierType?)
in the notifier to express that it accepts arbitrary ranges for
unmapping? (If I understood correctly Jason's proposal)
- Is it possible (or advisable) to skip all the page splitting in
vtd_page_walk if the memory range notifier supports these arbitrary
ranges? What would be the disadvantages? (Maybe in a future patch). It
seems it is advisable to me, but I would like to double confirm.

I think I don't miss anything, please let me know otherwise.

Thanks!

PS: Sorry I forgot to recover the backtrace properly, it will be
included in the next RFC/patch version. In case somebody misses it, it
is here: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01015.htm=
l
.


