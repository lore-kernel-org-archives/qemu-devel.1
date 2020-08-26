Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84A4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8632C2078A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZX6Tj1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8632C2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwwo-0004BX-JE
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kAwvL-0002kY-KF
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:01:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52131
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kAwvI-0001Mi-41
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598454070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8X09hWiB9qUOIs0u4FLQzRbOzS/rzcs/m9ayF+EkvEk=;
 b=HZX6Tj1Lmnex7YpjO+g/szuNMyGsJb8JxhuzSIyozaC09J7boACWoaJYLet3b57Dl+gIJr
 M8lx/kCmRrgChXrnLHCb3199PTNvrsTq3P1yu6mzACAdTtX1YUWMfa+blH5aE3/OChXGy/
 PcuMSmcSpnYZnennnJG0WWmuy4r12gQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-_1E3Hs29OTaBS2qNSY8-NA-1; Wed, 26 Aug 2020 11:01:09 -0400
X-MC-Unique: _1E3Hs29OTaBS2qNSY8-NA-1
Received: by mail-qt1-f197.google.com with SMTP id c8so1919041qtp.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8X09hWiB9qUOIs0u4FLQzRbOzS/rzcs/m9ayF+EkvEk=;
 b=Qyv8QgBZkDsJ6lVA47b4v7Jh6kyaVk7msblm1wqzoRjXyNysJSwK248EMa2ge4UGTE
 fsz9YcK0Fpg+JaBuGDsNik1n+lbDBGMYwRNWnmXBIeLIko2bjcOw/iiCLRqHmrjur2Ux
 FhjdBzIHhhmE6oP/EvXG3WrJvseJELjGblS1S9eNjRC19doKROA5rcyGUs8AtoH50uYg
 WvlQgBypLNoRD/r6WqaVtdrvjyhiI9jqgBMb/e8+wKywzqPo9WRcK26osM4qpMX2bQ+a
 oM4I4w1SzP5aXrlVSZmk/fqkJVl3JRAqcGExbI28rYc79+8AGgRq4yuyeJ+DosgQcTBM
 HUHQ==
X-Gm-Message-State: AOAM5325VQ6uaMbAAJdE5w7fOFmTL77XhI+p/J10w8xkez/r4KsvQOxF
 1bpsWxZAN5R/rR6gkA+QQHCJUAqxA+QYVddqozH+973GwjsURNUaC0zqKewJI5r6i+bQxFaV/tH
 5mmzoCythmGJd6HFnWfuHumEd/LJ83v0=
X-Received: by 2002:a37:3d4:: with SMTP id 203mr3855710qkd.497.1598454067647; 
 Wed, 26 Aug 2020 08:01:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQqmZA9fBETYGhFLG2PJdr6AdkZYTM0Gp2fTSxeFg/qkhWh+rUxjNDprN7nUn96O9lZBgoJS4XmgH1MiAdJgM=
X-Received: by 2002:a37:3d4:: with SMTP id 203mr3855624qkd.497.1598454066945; 
 Wed, 26 Aug 2020 08:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200826143651.7915-1-eperezma@redhat.com>
In-Reply-To: <20200826143651.7915-1-eperezma@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Aug 2020 17:00:30 +0200
Message-ID: <CAJaqyWf5vgSNvix99aWzrm2kDZ5xHQ_binRkpTe7WifDrLCjyw@mail.gmail.com>
Subject: Re: [RFC v6 00/13] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:16:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

Sending v6 to see if that is on the same page as what you meant.
Making each setting of "type" explicitly IOMMU_IOTLB_NONE if not used
in notifications. This is done in different commits in case this helps
review of different architectures.

I think that this way we have too much freedom between entry flags
(currently only access type, RW) and notification type. Since not all
of them are valid nor used in the same context, I think this adds
complexity. I'm wondering if:

Option a) We could make it private to memory.c, and make it a flag of
memory_region_notify_iommu (like "bool deviotlb_type)". IOW, instead
of making it a member of IOMMUTLBEntry, wrap the "entry" parameter of
memory_region_notify_iommu in a new private structure defined in
memory.c that adds that flag.

Option b) We could keep the IOMMUTLBNotificationType enum (open to
suggestions for a better name :)), but not embed it in the struct,
like:

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 477c3af24c..d9150e7b7e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -72,7 +72,8 @@ typedef enum {
     IOMMU_RO   =3D 1,
     IOMMU_WO   =3D 2,
     IOMMU_RW   =3D 3,
-} IOMMUAccessFlags;
+    IOMMU_DEVIOTLB =3D 4,
+} IOMMUEntryFlags;

 #define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_WO : =
0))

@@ -81,10 +82,18 @@ struct IOMMUTLBEntry {
     hwaddr                   iova;
     hwaddr                   translated_addr;
     hwaddr                   addr_mask;  /* 0xfff =3D 4k translation */
-    IOMMUAccessFlags         perm;
+    IOMMUEntryFlags          flags;
     IOMMUTLBNotificationType type; /* Only valid if it is a notification *=
/
 };

+IOMMUTLBNotificationType iommu_tlb_entry_type(struct IOMMUTLBEntry *s) {
+    if (s->flags & IOMMU_DEVIOTLB)
+        return IOMMU_DEVIOTLB_UNMAP;
+    else if (s->flags & IOMMU_RW)
+        return IOMMU_IOTLB_MAP;
+    return IOMMU_IOTLB_UNMAP;
+}
+
--

Thanks!

On Wed, Aug 26, 2020 at 4:38 PM Eugenio P=C3=A9rez <eperezma@redhat.com> wr=
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
> #0  0x00007ffff521370f in raise () at /lib64/libc.so.6
> #1  0x00007ffff51fdb25 in abort () at /lib64/libc.so.6
> #2  0x00007ffff51fd9f9 in _nl_load_domain.cold.0 () at /lib64/libc.so.6
> #3  0x00007ffff520bcc6 in .annobin_assert.c_end () at /lib64/libc.so.6
> #4  0x0000555555888171 in memory_region_notify_one (notifier=3D0x7ffde048=
7fa8,
>                                                     entry=3D0x7ffde5dfe20=
0)
>                           at /home/qemu/memory.c:1918
> #5  0x0000555555888247 in memory_region_notify_iommu (iommu_mr=3D0x555556=
f6c0b0,
>                                                       iommu_idx=3D0, entr=
y=3D...)
>                           at /home/qemu/memory.c:1941
> #6  0x0000555555951c8d in vtd_process_device_iotlb_desc (s=3D0x5555576090=
00,
>                                                        inv_desc=3D0x7ffde=
5dfe2d0)
>                           at /home/qemu/hw/i386/intel_iommu.c:2468
> #7  0x0000555555951e6a in vtd_process_inv_desc (s=3D0x555557609000)
>                           at /home/qemu/hw/i386/intel_iommu.c:2531
> #8  0x0000555555951fa5 in vtd_fetch_inv_desc (s=3D0x555557609000)
>                           at /home/qemu/hw/i386/intel_iommu.c:2563
> #9  0x00005555559520e5 in vtd_handle_iqt_write (s=3D0x555557609000)
>                           at /home/qemu/hw/i386/intel_iommu.c:2590
> #10 0x0000555555952b45 in vtd_mem_write (opaque=3D0x555557609000, addr=3D=
136,
>                                          val=3D2688, size=3D4)
>                           at /home/qemu/hw/i386/intel_iommu.c:2837
> #11 0x0000555555883e17 in memory_region_write_accessor (mr=3D0x5555576093=
30,
>                                                         addr=3D136,
>                                                         value=3D0x7ffde5d=
fe478,
>                                                         size=3D4,
>                                                         shift=3D0,
>                                                         mask=3D4294967295=
,
>                                                         attrs=3D...)
>                          at /home/qemu/memory.c:483
> #12 0x000055555588401d in access_with_adjusted_size (addr=3D136,
>                        value=3D0x7ffde5dfe478,
>                        size=3D4,
>                        access_size_min=3D4,
>                        access_size_max=3D8,
>                        access_fn=3D0x555555883d38 <memory_region_write_ac=
cessor>,
>                        mr=3D0x555557609330,
>                        attrs=3D...)
>                        at /home/qemu/memory.c:544
> #13 0x0000555555886f37 in memory_region_dispatch_write (mr=3D0x5555576093=
30,
>                                                        addr=3D136,
>                                                        data=3D2688,
>                                                        op=3DMO_32,
>                                                        attrs=3D...)
>                          at /home/qemu/memory.c:1476
> #14 0x0000555555827a03 in flatview_write_continue (fv=3D0x7ffdd8503150,
>                                                    addr=3D4275634312,
>                                                    attrs=3D...,
>                                                    ptr=3D0x7ffff7ff0028,
>                                                    len=3D4,
>                                                    addr1=3D136,
>                                                    l=3D4,
>                                                    mr=3D0x555557609330)
>                           at /home/qemu/exec.c:3146
> #15 0x0000555555827b48 in flatview_write (fv=3D0x7ffdd8503150,
>                                           addr=3D4275634312,
>                                           attrs=3D...,
>                                           buf=3D0x7ffff7ff0028,
>                                           len=3D4)
>                           at /home/qemu/exec.c:3186
> #16 0x0000555555827e9d in address_space_write (
>                                       as=3D0x5555567ca640 <address_space_=
memory>,
>                                       addr=3D4275634312,
>                                       attrs=3D...,
>                                       buf=3D0x7ffff7ff0028,
>                                       len=3D4)
>                           at /home/qemu/exec.c:3277
> #17 0x0000555555827f0a in address_space_rw (
>                                       as=3D0x5555567ca640 <address_space_=
memory>,
>                                       addr=3D4275634312,
>                                       attrs=3D...,
>                                       buf=3D0x7ffff7ff0028,
>                                       len=3D4,
>                                       is_write=3Dtrue)
>                           at /home/qemu/exec.c:3287
> #18 0x000055555589b633 in kvm_cpu_exec (cpu=3D0x555556b65640)
>                                at /home/qemu/accel/kvm/kvm-all.c:2511
> #19 0x0000555555876ba8 in qemu_kvm_cpu_thread_fn (arg=3D0x555556b65640)
>                                at /home/qemu/cpus.c:1284
> #20 0x0000555555dafff1 in qemu_thread_start (args=3D0x555556b8c3b0)
>                                at util/qemu-thread-posix.c:521
> #21 0x00007ffff55a62de in start_thread () at /lib64/libpthread.so.0
> #22 0x00007ffff52d7e83 in clone () at /lib64/libc.so.6
>
> (gdb) frame 4
> #4  0x0000555555888171 in memory_region_notify_one
>                       (notifier=3D0x7ffde0487fa8, entry=3D0x7ffde5dfe200)
>                       at /home/qemu/memory.c:1918
> 1918        assert(entry->iova >=3D notifier->start && entry_end <=3D
> notifier->end);
> (gdb) p *entry
> $1 =3D {target_as =3D 0x555556f6c050, iova =3D 0, translated_addr =3D 0,
> addr_mask =3D 18446744073709551615, perm =3D IOMMU_NONE}
> --
>
> Tested with vhost-net, host<->guest communication. Still more testing
> needed, since it touches a few architectures and configurations.
>
> v6: Introduce "type" field for IOMMUTLBEntry. Fill in all uses.
>     Update tests reports with more fine-tuning (CPU, RPS/XPS tunning).
>
> v5: Skip regular IOTLB notifications in dev_iotlb notifiers
>
> v4: Rename IOMMU_NOTIFIER_IOTLB -> IOMMU_NOTIFIER_DEVIOTLB.
>     Make vhost-net notifier just IOMMU_NOTIFIER_DEVIOTLB, not
>     IOMMU_NOTIFIER_UNMAP
>
> v3: Skip the assertion in case notifier is a IOTLB one, since they can ma=
nage
>     arbitrary ranges. Using a flag in the notifier for now, as Peter sugg=
ested.
>
> v2: Actually delete assertion instead of just commenting out using C99
>
> Eugenio P=C3=A9rez (13):
>   memory: Rename memory_region_notify_one to
>     memory_region_notify_iommu_one
>   memory: Add IOMMUTLBNotificationType to IOMMUTLBEntry
>   hw/alpha/typhoon: Mark all IOMMUTLBEntry as IOMMU_IOTLB_NONE type
>   amd_iommu: Mark all IOMMUTLBEntry as IOMMU_IOTLB_NONE type
>   hw/arm/smmu: Fill IOMMUTLBEntry notifier type
>   dma/rc4030: Mark all IOMMUTLBEntry as IOMMU_IOTLB_NONE type
>   intel_iommu: Mark IOMMUTLBEntry of page notification as
>     IOMMU_IOTLB_UNMAP type
>   virtio-iommu: Mark virtio_iommu_translate IOTLB as IOMMU_IOTLB_NONE
>     type
>   intel_iommu: Set IOMMUTLBEntry type in vtd_page_walk_level
>   memory: Notify IOMMU IOTLB based on entry type, not permissions
>   memory: Add IOMMU_DEVIOTLB_UNMAP IOMMUTLBNotificationType
>   intel_iommu: Do not notify regular iotlb to device-iotlb notifiers
>   memory: Skip bad range assertion if notifier is DEVIOTLB type
>
>  hw/alpha/typhoon.c       |  1 +
>  hw/arm/smmu-common.c     |  4 +++-
>  hw/arm/smmuv3.c          |  4 +++-
>  hw/dma/rc4030.c          |  1 +
>  hw/i386/amd_iommu.c      |  7 ++++++-
>  hw/i386/intel_iommu.c    | 14 +++++++++++--
>  hw/virtio/vhost.c        |  2 +-
>  hw/virtio/virtio-iommu.c |  1 +
>  include/exec/memory.h    | 26 ++++++++++++++++-------
>  softmmu/memory.c         | 45 ++++++++++++++++++++++++++++++----------
>  10 files changed, 80 insertions(+), 25 deletions(-)
>
> --
> 2.18.1
>
>


