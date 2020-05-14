Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A372C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431C1206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTlrqMMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431C1206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDMn-00075l-DS
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZDLj-0005Mn-U0
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:52:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39479
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZDLi-000243-7e
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589460748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g22qMY8Fba9TdWs6KD6NfeaKR04SyWvEx3JMgMKbhSk=;
 b=eTlrqMMZKCWj6OeVr51hESua5AJNsSmMXA14CrbV3mvr1+4NezhVqrlllnlsCz7j4AZzDA
 23cJNY0F0JxXjLWiO13ZuTOtevrZpfaRO8JtScIgEWuaN9XlhLYxvGyFs6KBD2hE/MDnIT
 AKOliq/2Vxg6qM8HdauVeyk4RwypreQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-BraYw9n8PHCugmUoHTlxGg-1; Thu, 14 May 2020 08:52:25 -0400
X-MC-Unique: BraYw9n8PHCugmUoHTlxGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B0658014D7;
 Thu, 14 May 2020 12:52:24 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07E0D78867;
 Thu, 14 May 2020 12:52:22 +0000 (UTC)
Date: Thu, 14 May 2020 13:52:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 vkuznets@redhat.com
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
Message-ID: <20200514125220.GJ2787@work-vm>
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
 <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
MIME-Version: 1.0
In-Reply-To: <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Li Feng <fengli@smartx.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
> Cc'ing David/Paolo in case they have a clue...
> 
> On 5/14/20 1:27 PM, Li Feng wrote:
> > Dear all,
> > 
> > I have encountered a weird crash.
> > I remember before a few days it works well and I rebase my code from upstream.
> > 
> > This is the command:
> > /root/qemu-master/x86_64-softmmu/qemu-system-x86_64 -enable-kvm
> > -device virtio-balloon -cpu host -smp 4 -m 2G -drive
> > file=/root/html/fedora-10g.img,format=raw,cache=none,aio=native,if=none,id=drive-virtio-disk1
> > -device virtio-blk-pci,scsi=off,drive=drive-virtio-disk1,id=virtio-disk1,bootindex=1
> > -device virtio-net,netdev=nw1,mac=00:11:22:EE:EE:10 -netdev
> > tap,id=nw1,script=no,downscript=no,ifname=tap0 -serial mon:stdio
> > -nographic -object
> > memory-backend-file,id=mem0,size=2G,mem-path=/dev/hugepages,share=on
> > -numa node,memdev=mem0 -vnc 0.0.0.0:100 -machine usb=on,nvdimm -device
> > usb-tablet -monitor unix:///tmp/a.socket,server,nowait -device
> > virtio-serial-pci,id=virtio-serial0,max_ports=16 -chardev
> > socket,id=channel1,path=/tmp/helloworld1,server,nowait -device
> > virtserialport,chardev=channel1,name=com.redhat.rhevm.vdsm1,bus=virtio-serial0.0,id=port1
> > -qmp tcp:0.0.0.0:2234,server,nowait
> > qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7fefff00036dfb
> > qemu-system-x86_64: /root/qemu-master/target/i386/kvm.c:2695:
> > kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.

48f is MSR_IA32_VMX_TRUE_EXIT_CTLS
I've not got a note of seeing that one before.

> > This is the commit record:
> > *   c88f1ffc19 - (origin/master, origin/HEAD) Merge remote-tracking
> > branch 'remotes/kevin/tags/for-upstream' into staging (3 days ago)
> > <Peter Maydell>
> > |\
> > | * 47e0b38a13 - block: Drop unused .bdrv_has_zero_init_truncate (3
> > days ago) <Eric Blake>
> > | * dbc636e791 - vhdx: Rework truncation logic (3 days ago) <Eric Blake>
> > | * bda4cdcbb9 - parallels: Rework truncation logic (3 days ago) <Eric Blake>
> > | * be9c9404db - ssh: Support BDRV_REQ_ZERO_WRITE for truncate (3 days
> > ago) <Eric Blake>
> > | * fec00559e7 - sheepdog: Support BDRV_REQ_ZERO_WRITE for truncate (3
> > days ago) <Eric Blake>
> > | * 2f98910d5b - rbd: Support BDRV_REQ_ZERO_WRITE for truncate (3 days
> > ago) <Eric Blake>
> > 
> > I run this qemu in a VM base on EXSi.
> > 
> > Does anyone have the same issue?

cc'ing in Vitaly since he knows VMWare stuff.

What's your host CPU?

Dave

> > 
> > Thanks,
> > 
> > Feng Li
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


