Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67F6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816BB206B6
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSrUTl/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816BB206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGJO-0000wT-QY
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 03:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1jrGIl-0008Qc-Vi
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:40:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43493
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1jrGIk-0001lP-4S
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593762000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJVae7Z79T9PaX5y6IjZ1t+GJr9GK1W2DX7m6ZyCv0I=;
 b=HSrUTl/Yxkf8c9ncAivWpdte8Tcl1whQ4tuFyz3HEXbU6Y6CbH9/EMgSkQKNElmgb2qPIR
 rsOegZ49Rss2lZuDRgjhAWqbNFOE87lbrWLEcs/kJbOKb4I8qrfpZUs4jg2ZH4bARZ+YYv
 g7SdqC+5kjZ6QpPeEG/CjrO0yPo1/cA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-iJPeYpSrP5GLc7sstJ_J0g-1; Fri, 03 Jul 2020 03:39:57 -0400
X-MC-Unique: iJPeYpSrP5GLc7sstJ_J0g-1
Received: by mail-qk1-f200.google.com with SMTP id u186so21202431qka.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 00:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yJVae7Z79T9PaX5y6IjZ1t+GJr9GK1W2DX7m6ZyCv0I=;
 b=Cizr4/SE4SNb/v30DCYjKhfbJVYU/U75/L6V6QzKPfyMsz8g+E+hcfdPVnJsanMlun
 3YgQXOtluQg0SO6qnxQWklkgzclWxULkcxyb0hoXG8iqo3+Ypm81bINLDHgbPnmOfxvY
 zWvjm0MG6q9PU66SO8HpUFgVMzaevPEoiDWw5w07g/tAd6Z0xpqMKayXzeXuGxCZYkxH
 u5lwr0MArRoBFkVi38aJwTtLa8L7Vlf727QKqmSzO/q1u8v6XA3mhBO5rxEzka8DsYr/
 5M+CFPHWmSgu2sqY3fcNsq01qn0tPahu7rlnOdUnH6o1TQWTpN5vFVhJgqBBO5cqMpWw
 XeSg==
X-Gm-Message-State: AOAM530RfRpfzwM+hf7YXieZF7Zfw8EB6v1TLL+Jg2Xep2KXWWjalZNh
 VMkHCbGwqaB+SVGn+0W4yrmiGE3onCGwKHHBasmPG1lsGUZIA0H3hljYfUPQ7Ewg/whlLJ3htuL
 CZCgECfF1SF1GiC3AagU7ngRry/icoXk=
X-Received: by 2002:ad4:4bb2:: with SMTP id i18mr34378456qvw.8.1593761996789; 
 Fri, 03 Jul 2020 00:39:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5PysNvLgFwxVOtYYKhPasqkg4DxpRPltDsytjtQFaefu3wdfwSzxOL9haZWx6O/9NrU8mofbu60D7atKXuYg=
X-Received: by 2002:ad4:4bb2:: with SMTP id i18mr34378441qvw.8.1593761996535; 
 Fri, 03 Jul 2020 00:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200626064122.9252-1-eperezma@redhat.com>
 <52d97ca5-7dbd-3178-64d6-509a8f096f0b@redhat.com>
In-Reply-To: <52d97ca5-7dbd-3178-64d6-509a8f096f0b@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 3 Jul 2020 09:39:20 +0200
Message-ID: <CAJaqyWe3QoCQ7=pe7mCpa548kLRDdhhfLydtbgzX7nkSkJ6img@mail.gmail.com>
Subject: Re: [RFC v2 0/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Paolo Bonzini <pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Avi Kivity <avi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 5:05 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 26/06/20 08:41, Eugenio P=C3=A9rez wrote:
> > If we examinate *entry in frame 4 of backtrace:
> > *entry =3D {target_as =3D 0x555556f6c050, iova =3D 0x0, translated_addr=
 =3D 0x0,
> > addr_mask =3D 0xffffffffffffffff, perm =3D 0x0}
> >
> > Which (I think) tries to invalidate all the TLB registers of the device=
.
> >
> > Just deleting that assert is enough for the VM to start and communicate
> > using IOMMU, but maybe a better alternative is possible. We could move
> > it to the caller functions in other cases than IOMMU invalidation, or
> > make it conditional only if not invalidating.
>
> Yes, I think moving it up in the call stack is better. I cannot say
> where because the backtrace was destroyed by git (due to lines starting
> with "#").
>

Ouch, what a failure!

Pasting here for completion, sorry!

(gdb) bt
#0  0x00007ffff521370f in raise () at /lib64/libc.so.6
#1  0x00007ffff51fdb25 in abort () at /lib64/libc.so.6
#2  0x00007ffff51fd9f9 in _nl_load_domain.cold.0 () at /lib64/libc.so.6
#3  0x00007ffff520bcc6 in .annobin_assert.c_end () at /lib64/libc.so.6
#4  0x0000555555888171 in memory_region_notify_one
(notifier=3D0x7ffde0487fa8, entry=3D0x7ffde5dfe200) at
/home/qemu/memory.c:1918
#5  0x0000555555888247 in memory_region_notify_iommu
(iommu_mr=3D0x555556f6c0b0, iommu_idx=3D0, entry=3D...) at
/home/qemu/memory.c:1941
#6  0x0000555555951c8d in vtd_process_device_iotlb_desc
(s=3D0x555557609000, inv_desc=3D0x7ffde5dfe2d0)
    at /home/qemu/hw/i386/intel_iommu.c:2468
#7  0x0000555555951e6a in vtd_process_inv_desc (s=3D0x555557609000) at
/home/qemu/hw/i386/intel_iommu.c:2531
#8  0x0000555555951fa5 in vtd_fetch_inv_desc (s=3D0x555557609000) at
/home/qemu/hw/i386/intel_iommu.c:2563
#9  0x00005555559520e5 in vtd_handle_iqt_write (s=3D0x555557609000) at
/home/qemu/hw/i386/intel_iommu.c:2590
#10 0x0000555555952b45 in vtd_mem_write (opaque=3D0x555557609000,
addr=3D136, val=3D2688, size=3D4) at /home/qemu/hw/i386/intel_iommu.c:2837
#11 0x0000555555883e17 in memory_region_write_accessor
    (mr=3D0x555557609330, addr=3D136, value=3D0x7ffde5dfe478, size=3D4,
shift=3D0, mask=3D4294967295, attrs=3D...) at /home/qemu/memory.c:483
#12 0x000055555588401d in access_with_adjusted_size
    (addr=3D136, value=3D0x7ffde5dfe478, size=3D4, access_size_min=3D4,
access_size_max=3D8, access_fn=3D
    0x555555883d38 <memory_region_write_accessor>, mr=3D0x555557609330,
attrs=3D...) at /home/qemu/memory.c:544
#13 0x0000555555886f37 in memory_region_dispatch_write
(mr=3D0x555557609330, addr=3D136, data=3D2688, op=3DMO_32, attrs=3D...)
    at /home/qemu/memory.c:1476
#14 0x0000555555827a03 in flatview_write_continue
    (fv=3D0x7ffdd8503150, addr=3D4275634312, attrs=3D...,
ptr=3D0x7ffff7ff0028, len=3D4, addr1=3D136, l=3D4, mr=3D0x555557609330) at
/home/qemu/exec.c:3146
#15 0x0000555555827b48 in flatview_write (fv=3D0x7ffdd8503150,
addr=3D4275634312, attrs=3D..., buf=3D0x7ffff7ff0028, len=3D4)
    at /home/qemu/exec.c:3186
#16 0x0000555555827e9d in address_space_write
    (as=3D0x5555567ca640 <address_space_memory>, addr=3D4275634312,
attrs=3D..., buf=3D0x7ffff7ff0028, len=3D4) at /home/qemu/exec.c:3277
#17 0x0000555555827f0a in address_space_rw
    (as=3D0x5555567ca640 <address_space_memory>, addr=3D4275634312,
attrs=3D..., buf=3D0x7ffff7ff0028, len=3D4, is_write=3Dtrue)
    at /home/qemu/exec.c:3287
#18 0x000055555589b633 in kvm_cpu_exec (cpu=3D0x555556b65640) at
/home/qemu/accel/kvm/kvm-all.c:2511
#19 0x0000555555876ba8 in qemu_kvm_cpu_thread_fn (arg=3D0x555556b65640)
at /home/qemu/cpus.c:1284
#20 0x0000555555dafff1 in qemu_thread_start (args=3D0x555556b8c3b0) at
util/qemu-thread-posix.c:521
#21 0x00007ffff55a62de in start_thread () at /lib64/libpthread.so.0
#22 0x00007ffff52d7e83 in clone () at /lib64/libc.so.6

(gdb) frame 4
#4  0x0000555555888171 in memory_region_notify_one
(notifier=3D0x7ffde0487fa8, entry=3D0x7ffde5dfe200) at
/home/qemu/memory.c:1918
1918        assert(entry->iova >=3D notifier->start && entry_end <=3D
notifier->end);
(gdb) p *entry
$1 =3D {target_as =3D 0x555556f6c050, iova =3D 0, translated_addr =3D 0,
addr_mask =3D 18446744073709551615, perm =3D IOMMU_NONE}

Thanks!

> Paolo
>
> > Any comment would be appreciated. Thanks!
> >
> > Guest kernel version: kernel-3.10.0-1151.el7.x86_64
> >
> > Bug reference: https://bugs.launchpad.net/qemu/+bug/1885175
> >
> > v2: Actually delete assertion instead of just commenting out using C99
> >
> > Eugenio P=C3=A9rez (1):
> >   memory: Delete assertion in memory_region_unregister_iommu_notifier
> >
> >  memory.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
>


