Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7FEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5531E206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAui3grH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5531E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZCh4-0000Yo-Cy
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZCg7-0007wR-5X
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:09:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31323
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZCg4-0008Rd-2K
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589458166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gH+nLTfI748xYpanaWsMtl6uRK0WmDGX9pG2oo13/nQ=;
 b=MAui3grHG+P1YK2XXbPmBT/IEWNODvzf9eQS3YJOOR22XcbdR5Gqxum7uhAsU6C3y+bs/g
 UJKP2qZcBrA6z2HkVKwc81i+iWbueK3J4waCE2q7e/0KJd+ubHOsZrswIW3UHSNpRC7EkD
 dLXsgOFjPi5VmNI27KSzmfkphGPZBS0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-TuzLV6VXMUWBxnmhYq6XBQ-1; Thu, 14 May 2020 08:09:23 -0400
X-MC-Unique: TuzLV6VXMUWBxnmhYq6XBQ-1
Received: by mail-wr1-f72.google.com with SMTP id w9so1490543wrr.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 05:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gH+nLTfI748xYpanaWsMtl6uRK0WmDGX9pG2oo13/nQ=;
 b=pxloOfVJsbLzi4Yn4/lUZc1q/hEGTG5ptPWBL4WcoSVnaJ3xmrVYVfn4uICVnduByZ
 ClhBP5M4q7agRUpiOBU8LxtSty4DDK6TwpeOxHd12SMMWBmhpKMsmvq/o0eHvqJUyjZ3
 0QItRyk3rkQCyg7wI/Vo/ka0luFkyTmDLeKU0BOV8NyS0jLiCB8iXu+f6dLTid5STagg
 DlkfyWqJZi2lx+ZAxUfZHv5GBJTBlW7SniweQlkR3njmTJTk7RtUvgBAXX4ECvYAec3a
 vXdkiATBrPN0c1goWVP7MRW2HWR5ifC1UZP/Ot2VBs73DEbPmS1svViGAN4c27h8jAAr
 TP4w==
X-Gm-Message-State: AGi0PuaQGmhGjyNrBSBUqEpeLFiY+ofMwuhOv1aAzWCxSQxLgYibKsUQ
 lAi3m5YV7FBclSJ3LbqhxnbwainaTFDIwPbnKllBm6yqI45F9yxr1rTbOgN0/ys8fLInIYmPsQR
 pq+eH6iyTCgJHTdg=
X-Received: by 2002:a7b:c399:: with SMTP id s25mr46677620wmj.169.1589458161800; 
 Thu, 14 May 2020 05:09:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJxtmLA0JxT79Oh5FIDBYasd2/6AQnV3V7XsDvN1Kh1vdB7IiYQsjq1Pg1CcLWC4ArGXzre4w==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr46677601wmj.169.1589458161526; 
 Thu, 14 May 2020 05:09:21 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v11sm3672877wrv.53.2020.05.14.05.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 05:09:20 -0700 (PDT)
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: Li Feng <fengli@smartx.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
Date: Thu, 14 May 2020 14:09:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing David/Paolo in case they have a clue...

On 5/14/20 1:27 PM, Li Feng wrote:
> Dear all,
> 
> I have encountered a weird crash.
> I remember before a few days it works well and I rebase my code from upstream.
> 
> This is the command:
> /root/qemu-master/x86_64-softmmu/qemu-system-x86_64 -enable-kvm
> -device virtio-balloon -cpu host -smp 4 -m 2G -drive
> file=/root/html/fedora-10g.img,format=raw,cache=none,aio=native,if=none,id=drive-virtio-disk1
> -device virtio-blk-pci,scsi=off,drive=drive-virtio-disk1,id=virtio-disk1,bootindex=1
> -device virtio-net,netdev=nw1,mac=00:11:22:EE:EE:10 -netdev
> tap,id=nw1,script=no,downscript=no,ifname=tap0 -serial mon:stdio
> -nographic -object
> memory-backend-file,id=mem0,size=2G,mem-path=/dev/hugepages,share=on
> -numa node,memdev=mem0 -vnc 0.0.0.0:100 -machine usb=on,nvdimm -device
> usb-tablet -monitor unix:///tmp/a.socket,server,nowait -device
> virtio-serial-pci,id=virtio-serial0,max_ports=16 -chardev
> socket,id=channel1,path=/tmp/helloworld1,server,nowait -device
> virtserialport,chardev=channel1,name=com.redhat.rhevm.vdsm1,bus=virtio-serial0.0,id=port1
> -qmp tcp:0.0.0.0:2234,server,nowait
> qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7fefff00036dfb
> qemu-system-x86_64: /root/qemu-master/target/i386/kvm.c:2695:
> kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
> 
> This is the commit record:
> *   c88f1ffc19 - (origin/master, origin/HEAD) Merge remote-tracking
> branch 'remotes/kevin/tags/for-upstream' into staging (3 days ago)
> <Peter Maydell>
> |\
> | * 47e0b38a13 - block: Drop unused .bdrv_has_zero_init_truncate (3
> days ago) <Eric Blake>
> | * dbc636e791 - vhdx: Rework truncation logic (3 days ago) <Eric Blake>
> | * bda4cdcbb9 - parallels: Rework truncation logic (3 days ago) <Eric Blake>
> | * be9c9404db - ssh: Support BDRV_REQ_ZERO_WRITE for truncate (3 days
> ago) <Eric Blake>
> | * fec00559e7 - sheepdog: Support BDRV_REQ_ZERO_WRITE for truncate (3
> days ago) <Eric Blake>
> | * 2f98910d5b - rbd: Support BDRV_REQ_ZERO_WRITE for truncate (3 days
> ago) <Eric Blake>
> 
> I run this qemu in a VM base on EXSi.
> 
> Does anyone have the same issue?
> 
> Thanks,
> 
> Feng Li
> 


