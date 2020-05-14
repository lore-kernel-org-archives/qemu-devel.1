Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175E9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB803206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0Joohk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB803206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDk0-0006md-4T
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jZDjL-0005yj-6T
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:16:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jZDjJ-0007kF-7b
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589462211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2eZUxtKgoo41/4TXbR5fjJMMHBb1EcLFi+pkPrCeTc=;
 b=G0Joohk9i0XSLKKGOfb7aS/3V9VBd2w848a+zPGgl8lyHeLpCYCQ1H6rMJQe3LzvokTsuN
 dtE3PY+13D1hFtBJUDll2tk2LkrGOZyq4RcuK0sRr21t2kVgHuJhbO+Pfm65MLXYdkXauL
 W1hv/D21X+2MFtHtaSwIl3roy6rf/wU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-20M2pf1POyC08eRIwx3mjA-1; Thu, 14 May 2020 09:15:25 -0400
X-MC-Unique: 20M2pf1POyC08eRIwx3mjA-1
Received: by mail-wr1-f72.google.com with SMTP id z5so1554115wrt.17
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 06:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=A2eZUxtKgoo41/4TXbR5fjJMMHBb1EcLFi+pkPrCeTc=;
 b=YBG7L3K91ZXckv0d1sttNlrtw/Fate+jMcYAOGwtJYDGBgN+JYaDP1QTeNxldDsRTy
 /YfwAPYsFVmOJmXiIUi3idH5TrfK3nBNoZsyuiC3WjKWsWGWZ0TyVVaQxUbZeggLAlXD
 bSag7HrX0S27rdjzOqBU3jB6RJTjRKwQiFRt7wSyNheacpmnoN38Au5fJwIADPgztOJV
 xs4Rov3hO5C2DbVi5A0KMoxF+NXndxS4l2Vq+LA8SNTnu6vRdSVerWNOCvMh1iD9KFuO
 XFc/9ogcuw7cllLbGg2lKOvtsoA01RAn+/oRnWPLvccaahV3gU+T7Cd2MvPohYQ8th15
 0cFA==
X-Gm-Message-State: AGi0Pua/NwpTGPrBlESzTIAJbJcNwgrHYvCeP2AkNystTzEysInjdBJn
 ZrqDS7oVcmkq1eYQqNKzruMtA38+IN04eVQ+vxJYwaGUyW76G3gmoyaaDIDLuUZ2w0iMz88zcUn
 lbr9YtHuq3JBAtU0=
X-Received: by 2002:a1c:1dd8:: with SMTP id
 d207mr29565545wmd.125.1589462124816; 
 Thu, 14 May 2020 06:15:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypKlVqstKl1Y18QrOIz07hvje1Y1gWi5Y7GyKi8wYfb6K2zYX+YAtprP8zof5qdyzGY/a44vSQ==
X-Received: by 2002:a1c:1dd8:: with SMTP id
 d207mr29565521wmd.125.1589462124545; 
 Thu, 14 May 2020 06:15:24 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id 128sm35182767wme.39.2020.05.14.06.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 06:15:23 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Li Feng <fengli@smartx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
In-Reply-To: <20200514125220.GJ2787@work-vm>
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
 <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
 <20200514125220.GJ2787@work-vm>
Date: Thu, 14 May 2020 15:15:22 +0200
Message-ID: <87r1vmwtcl.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Philippe Mathieu-DaudÃ© (philmd@redhat.com) wrote:
>> Cc'ing David/Paolo in case they have a clue...
>> 
>> On 5/14/20 1:27 PM, Li Feng wrote:
>> > Dear all,
>> > 
>> > I have encountered a weird crash.
>> > I remember before a few days it works well and I rebase my code from upstream.
>> > 
>> > This is the command:
>> > /root/qemu-master/x86_64-softmmu/qemu-system-x86_64 -enable-kvm
>> > -device virtio-balloon -cpu host -smp 4 -m 2G -drive
>> > file=/root/html/fedora-10g.img,format=raw,cache=none,aio=native,if=none,id=drive-virtio-disk1
>> > -device virtio-blk-pci,scsi=off,drive=drive-virtio-disk1,id=virtio-disk1,bootindex=1
>> > -device virtio-net,netdev=nw1,mac=00:11:22:EE:EE:10 -netdev
>> > tap,id=nw1,script=no,downscript=no,ifname=tap0 -serial mon:stdio
>> > -nographic -object
>> > memory-backend-file,id=mem0,size=2G,mem-path=/dev/hugepages,share=on
>> > -numa node,memdev=mem0 -vnc 0.0.0.0:100 -machine usb=on,nvdimm -device
>> > usb-tablet -monitor unix:///tmp/a.socket,server,nowait -device
>> > virtio-serial-pci,id=virtio-serial0,max_ports=16 -chardev
>> > socket,id=channel1,path=/tmp/helloworld1,server,nowait -device
>> > virtserialport,chardev=channel1,name=com.redhat.rhevm.vdsm1,bus=virtio-serial0.0,id=port1
>> > -qmp tcp:0.0.0.0:2234,server,nowait
>> > qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7fefff00036dfb
>> > qemu-system-x86_64: /root/qemu-master/target/i386/kvm.c:2695:
>> > kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
>
> 48f is MSR_IA32_VMX_TRUE_EXIT_CTLS
> I've not got a note of seeing that one before.
>

If you're not intended to run nested VMs (which would make it 3-level
nesting btw) you can try:

'-cpu host,-vmx'

The strange part is that we don't seem to mangle
MSR_IA32_VMX_TRUE_EXIT_CTLS in QEMU. I bet it has something to do with
VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR in KVM.

>> > This is the commit record:
>> > *   c88f1ffc19 - (origin/master, origin/HEAD) Merge remote-tracking
>> > branch 'remotes/kevin/tags/for-upstream' into staging (3 days ago)
>> > <Peter Maydell>
>> > |\
>> > | * 47e0b38a13 - block: Drop unused .bdrv_has_zero_init_truncate (3
>> > days ago) <Eric Blake>
>> > | * dbc636e791 - vhdx: Rework truncation logic (3 days ago) <Eric Blake>
>> > | * bda4cdcbb9 - parallels: Rework truncation logic (3 days ago) <Eric Blake>
>> > | * be9c9404db - ssh: Support BDRV_REQ_ZERO_WRITE for truncate (3 days
>> > ago) <Eric Blake>
>> > | * fec00559e7 - sheepdog: Support BDRV_REQ_ZERO_WRITE for truncate (3
>> > days ago) <Eric Blake>
>> > | * 2f98910d5b - rbd: Support BDRV_REQ_ZERO_WRITE for truncate (3 days
>> > ago) <Eric Blake>
>> > 
>> > I run this qemu in a VM base on EXSi.
>> > 
>> > Does anyone have the same issue?
>
> cc'ing in Vitaly since he knows VMWare stuff.

I wish it was true :-)

>
> What's your host CPU?
>

And what's your L1 kernel?

-- 
Vitaly


