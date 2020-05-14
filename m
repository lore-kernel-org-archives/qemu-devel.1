Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FCAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E194206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKrs2wtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E194206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFc7-0004Lp-Ae
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZFaw-0002nZ-9w
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:16:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25982
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZFau-0002Y7-7o
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589469379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ax2nespP5l33+/Aiih29T2uCEwrFNH29jWrtyNgRYS4=;
 b=dKrs2wtcsa9u5cr101cep6eD9upiH4VYoFK81LMCjUzQegvmH4SNuwgk8+c2JJtVm8Js3H
 LoO7tuc78uhQB0M+yRJRZ9GR+SRddeENWoPsGcm95FmjXAlBlOPZA6IzUWJheN2zrmg4DC
 V79jBeLpimgMoaXTvH4+nh4IoBpZLqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-PO57t2MgP3-r43qP1OvR_A-1; Thu, 14 May 2020 11:16:05 -0400
X-MC-Unique: PO57t2MgP3-r43qP1OvR_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0E43107ACF8;
 Thu, 14 May 2020 15:16:03 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C34296AD05;
 Thu, 14 May 2020 15:16:02 +0000 (UTC)
Date: Thu, 14 May 2020 16:16:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Li Feng <fengli@smartx.com>
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
Message-ID: <20200514151600.GO2787@work-vm>
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
 <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
 <20200514125220.GJ2787@work-vm>
 <CAHckoCyegWG9yH_y6VjHhnghfHJD-Wq+EmOyRZE3EYguTOHfPw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHckoCyegWG9yH_y6VjHhnghfHJD-Wq+EmOyRZE3EYguTOHfPw@mail.gmail.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vkuznets@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Li Feng (fengli@smartx.com) wrote:
> EXSi CPU is : Intel(R) Xeon(R) CPU E5-2640 v3 @ 2.60GHz
> This is my vm, I run qemu in it.

Do you know what the real hardware is?

Dave

> (base) 20-05-14 15:32:50 root@31_216:~  lscpu
> Architecture:          x86_64
> CPU op-mode(s):        32-bit, 64-bit
> Byte Order:            Little Endian
> CPU(s):                16
> On-line CPU(s) list:   0-15
> Thread(s) per core:    1
> Core(s) per socket:    1
> Socket(s):             16
> NUMA node(s):          1
> Vendor ID:             GenuineIntel
> CPU family:            6
> Model:                 63
> Model name:            Intel(R) Xeon(R) CPU E5-2640 v3 @ 2.60GHz
> Stepping:              2
> CPU MHz:               2599.998
> BogoMIPS:              5199.99
> Virtualization:        VT-x
> Hypervisor vendor:     VMware
> Virtualization type:   full
> L1d cache:             32K
> L1i cache:             32K
> L2 cache:              256K
> L3 cache:              20480K
> NUMA node0 CPU(s):     0-15
> Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep
> mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss syscall
> nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts nopl xtopology
> tsc_reliable nonstop_tsc cpuid pni pclmulqdq vmx ssse3 fma cx16 pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
> f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single
> tpr_shadow vnmi ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2
> invpcid xsaveopt arat
> 
> Thanks,
> 
> Feng Li
> 
> Dr. David Alan Gilbert <dgilbert@redhat.com> 于2020年5月14日周四 下午8:52写道：
> >
> > * Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
> > > Cc'ing David/Paolo in case they have a clue...
> > >
> > > On 5/14/20 1:27 PM, Li Feng wrote:
> > > > Dear all,
> > > >
> > > > I have encountered a weird crash.
> > > > I remember before a few days it works well and I rebase my code from upstream.
> > > >
> > > > This is the command:
> > > > /root/qemu-master/x86_64-softmmu/qemu-system-x86_64 -enable-kvm
> > > > -device virtio-balloon -cpu host -smp 4 -m 2G -drive
> > > > file=/root/html/fedora-10g.img,format=raw,cache=none,aio=native,if=none,id=drive-virtio-disk1
> > > > -device virtio-blk-pci,scsi=off,drive=drive-virtio-disk1,id=virtio-disk1,bootindex=1
> > > > -device virtio-net,netdev=nw1,mac=00:11:22:EE:EE:10 -netdev
> > > > tap,id=nw1,script=no,downscript=no,ifname=tap0 -serial mon:stdio
> > > > -nographic -object
> > > > memory-backend-file,id=mem0,size=2G,mem-path=/dev/hugepages,share=on
> > > > -numa node,memdev=mem0 -vnc 0.0.0.0:100 -machine usb=on,nvdimm -device
> > > > usb-tablet -monitor unix:///tmp/a.socket,server,nowait -device
> > > > virtio-serial-pci,id=virtio-serial0,max_ports=16 -chardev
> > > > socket,id=channel1,path=/tmp/helloworld1,server,nowait -device
> > > > virtserialport,chardev=channel1,name=com.redhat.rhevm.vdsm1,bus=virtio-serial0.0,id=port1
> > > > -qmp tcp:0.0.0.0:2234,server,nowait
> > > > qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7fefff00036dfb
> > > > qemu-system-x86_64: /root/qemu-master/target/i386/kvm.c:2695:
> > > > kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
> >
> > 48f is MSR_IA32_VMX_TRUE_EXIT_CTLS
> > I've not got a note of seeing that one before.
> >
> > > > This is the commit record:
> > > > *   c88f1ffc19 - (origin/master, origin/HEAD) Merge remote-tracking
> > > > branch 'remotes/kevin/tags/for-upstream' into staging (3 days ago)
> > > > <Peter Maydell>
> > > > |\
> > > > | * 47e0b38a13 - block: Drop unused .bdrv_has_zero_init_truncate (3
> > > > days ago) <Eric Blake>
> > > > | * dbc636e791 - vhdx: Rework truncation logic (3 days ago) <Eric Blake>
> > > > | * bda4cdcbb9 - parallels: Rework truncation logic (3 days ago) <Eric Blake>
> > > > | * be9c9404db - ssh: Support BDRV_REQ_ZERO_WRITE for truncate (3 days
> > > > ago) <Eric Blake>
> > > > | * fec00559e7 - sheepdog: Support BDRV_REQ_ZERO_WRITE for truncate (3
> > > > days ago) <Eric Blake>
> > > > | * 2f98910d5b - rbd: Support BDRV_REQ_ZERO_WRITE for truncate (3 days
> > > > ago) <Eric Blake>
> > > >
> > > > I run this qemu in a VM base on EXSi.
> > > >
> > > > Does anyone have the same issue?
> >
> > cc'ing in Vitaly since he knows VMWare stuff.
> >
> > What's your host CPU?
> >
> > Dave
> >
> > > >
> > > > Thanks,
> > > >
> > > > Feng Li
> > > >
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


