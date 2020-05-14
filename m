Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD538C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB8220657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="TGPuc6pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB8220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFWp-0005Wn-Ox
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jZFVB-0002dt-SL
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:10:25 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933]:44549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jZFVA-0000xV-8Y
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:10:25 -0400
Received: by mail-ua1-x933.google.com with SMTP id z16so1236382uae.11
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WZw11k3WTIkIls6UR/pZsIkj2G2RW+0rshDY6qEqg6A=;
 b=TGPuc6pqjWtpYvme1FZPkosUGZ30ZxTZBLMGCVfcix5Is8OWGAx8b5Z8m/6wTvMFVT
 YoYPmIKP+oUIKIHpF3dqh9JdLaRoeoWv7ScVnKppY6Jp8ZYuh5j1IxsoEh8Rs71f2oRH
 +F44RXlcsXjveH3CU2EGOa2OYvs6P3aEsGD6OlVeE51dzyxvMLopsXI+XwOr1g7yFuP0
 XKsRkjL+EPbHF2Iz4NFNAX5LPBXgMNervjbEH30m6z9M/rV0Y2QXN1PftHYC280JnLNe
 FiRor6/A+nF/foUpM5YNJSU8G0VwzDWZaY19/y3qVqgMqz6HGjDaFnKhPL2wPX+C9gE5
 48qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WZw11k3WTIkIls6UR/pZsIkj2G2RW+0rshDY6qEqg6A=;
 b=OZ/XyTxmWvJ1jvF5XwF9iXrSgqZafNwfCQ+Qyy919hyoVbTB9Pvv+SLRBCb3oTn1KJ
 yKLi+ngukQ7gL8MISqtMrS1jghnMwTLkktfWM5WD3nP+QEuUruMPB+ihyzVDoP79AFsF
 xDl2m4QdHN9hQr6Z7kd11WWrD3jsF4UuDuPp9qoNjnSV6pNi6bX6L/fX4KAx3LKgZPi8
 hQC3F1fUHS4ARea7HTpT+oIEax9exhSY9/M3eqTbt+jD7mVbq9f/iLKKbyIoOxEr6z+I
 EasjGKCXzGBmkWT2D4/vti02Uv+bTgqPPTy2loLIjRfUP1t920PK1oxmtrwsKIQdaqPA
 fxiw==
X-Gm-Message-State: AOAM531wOMNY5rOUpGTMuqMqlvy7qsUqTSDl4m3CTxG9GRkCm4zoK8Y3
 rhqiEPr1xlZ5ubjIikHC1kpaTkGdqtbzbc9z/12DlQ==
X-Google-Smtp-Source: ABdhPJyilNUp7a8vEpp8/a/bb9XtlP01ViUkm8IEfg4d8Wy2qQAi1ZBDnydk18JbYLwIL75TlZVGjI6rmj5k4S/HOts=
X-Received: by 2002:ab0:b13:: with SMTP id b19mr4372213uak.91.1589469021929;
 Thu, 14 May 2020 08:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
 <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
 <20200514125220.GJ2787@work-vm>
In-Reply-To: <20200514125220.GJ2787@work-vm>
From: Li Feng <fengli@smartx.com>
Date: Thu, 14 May 2020 23:10:10 +0800
Message-ID: <CAHckoCyegWG9yH_y6VjHhnghfHJD-Wq+EmOyRZE3EYguTOHfPw@mail.gmail.com>
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::933;
 envelope-from=fengli@smartx.com; helo=mail-ua1-x933.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

EXSi CPU is : Intel(R) Xeon(R) CPU E5-2640 v3 @ 2.60GHz
This is my vm, I run qemu in it.

(base) 20-05-14 15:32:50 root@31_216:~  lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             16
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 63
Model name:            Intel(R) Xeon(R) CPU E5-2640 v3 @ 2.60GHz
Stepping:              2
CPU MHz:               2599.998
BogoMIPS:              5199.99
Virtualization:        VT-x
Hypervisor vendor:     VMware
Virtualization type:   full
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              20480K
NUMA node0 CPU(s):     0-15
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss syscall
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts nopl xtopology
tsc_reliable nonstop_tsc cpuid pni pclmulqdq vmx ssse3 fma cx16 pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single
tpr_shadow vnmi ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2
invpcid xsaveopt arat

Thanks,

Feng Li

Dr. David Alan Gilbert <dgilbert@redhat.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=
=8814=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:52=E5=86=99=E9=81=93=
=EF=BC=9A
>
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
> > Cc'ing David/Paolo in case they have a clue...
> >
> > On 5/14/20 1:27 PM, Li Feng wrote:
> > > Dear all,
> > >
> > > I have encountered a weird crash.
> > > I remember before a few days it works well and I rebase my code from =
upstream.
> > >
> > > This is the command:
> > > /root/qemu-master/x86_64-softmmu/qemu-system-x86_64 -enable-kvm
> > > -device virtio-balloon -cpu host -smp 4 -m 2G -drive
> > > file=3D/root/html/fedora-10g.img,format=3Draw,cache=3Dnone,aio=3Dnati=
ve,if=3Dnone,id=3Ddrive-virtio-disk1
> > > -device virtio-blk-pci,scsi=3Doff,drive=3Ddrive-virtio-disk1,id=3Dvir=
tio-disk1,bootindex=3D1
> > > -device virtio-net,netdev=3Dnw1,mac=3D00:11:22:EE:EE:10 -netdev
> > > tap,id=3Dnw1,script=3Dno,downscript=3Dno,ifname=3Dtap0 -serial mon:st=
dio
> > > -nographic -object
> > > memory-backend-file,id=3Dmem0,size=3D2G,mem-path=3D/dev/hugepages,sha=
re=3Don
> > > -numa node,memdev=3Dmem0 -vnc 0.0.0.0:100 -machine usb=3Don,nvdimm -d=
evice
> > > usb-tablet -monitor unix:///tmp/a.socket,server,nowait -device
> > > virtio-serial-pci,id=3Dvirtio-serial0,max_ports=3D16 -chardev
> > > socket,id=3Dchannel1,path=3D/tmp/helloworld1,server,nowait -device
> > > virtserialport,chardev=3Dchannel1,name=3Dcom.redhat.rhevm.vdsm1,bus=
=3Dvirtio-serial0.0,id=3Dport1
> > > -qmp tcp:0.0.0.0:2234,server,nowait
> > > qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7fefff00036df=
b
> > > qemu-system-x86_64: /root/qemu-master/target/i386/kvm.c:2695:
> > > kvm_buf_set_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' fail=
ed.
>
> 48f is MSR_IA32_VMX_TRUE_EXIT_CTLS
> I've not got a note of seeing that one before.
>
> > > This is the commit record:
> > > *   c88f1ffc19 - (origin/master, origin/HEAD) Merge remote-tracking
> > > branch 'remotes/kevin/tags/for-upstream' into staging (3 days ago)
> > > <Peter Maydell>
> > > |\
> > > | * 47e0b38a13 - block: Drop unused .bdrv_has_zero_init_truncate (3
> > > days ago) <Eric Blake>
> > > | * dbc636e791 - vhdx: Rework truncation logic (3 days ago) <Eric Bla=
ke>
> > > | * bda4cdcbb9 - parallels: Rework truncation logic (3 days ago) <Eri=
c Blake>
> > > | * be9c9404db - ssh: Support BDRV_REQ_ZERO_WRITE for truncate (3 day=
s
> > > ago) <Eric Blake>
> > > | * fec00559e7 - sheepdog: Support BDRV_REQ_ZERO_WRITE for truncate (=
3
> > > days ago) <Eric Blake>
> > > | * 2f98910d5b - rbd: Support BDRV_REQ_ZERO_WRITE for truncate (3 day=
s
> > > ago) <Eric Blake>
> > >
> > > I run this qemu in a VM base on EXSi.
> > >
> > > Does anyone have the same issue?
>
> cc'ing in Vitaly since he knows VMWare stuff.
>
> What's your host CPU?
>
> Dave
>
> > >
> > > Thanks,
> > >
> > > Feng Li
> > >
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

