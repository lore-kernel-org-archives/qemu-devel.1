Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78B1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6C2207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRUJejvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6C2207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLyM-0001vN-Rw
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbLwJ-0008Fg-Gr
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:27:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbLwI-0000SE-Np
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589970426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22ThqfLCOKXlMaqSVC7KqxILef2PKuDpGKq6uJE99j0=;
 b=IRUJejvODkm1Wty+mxXM26k3x2UCNl7VfcWaQlJo8lu/1CfOgUqYaqrinr6P6fx4ZLY0gy
 fc3YIW7hqS0WWyzEa3oJDFHqjQkW8gZUEjb2kiTVJa8W+V2lHex26X1LfWi+Sj8DKBzyT0
 CoQkE7mqBh770uktr38LSe6RjcW4KpE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-zEDQd6HXPvy5o9qTvfNe0w-1; Wed, 20 May 2020 06:27:03 -0400
X-MC-Unique: zEDQd6HXPvy5o9qTvfNe0w-1
Received: by mail-wm1-f72.google.com with SMTP id t82so742980wmf.4
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 03:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=22ThqfLCOKXlMaqSVC7KqxILef2PKuDpGKq6uJE99j0=;
 b=mlFWI51XqzMuMq9ErGyXaUFXgVyFD9Ql4hnO1cmy8bgiECF8896uVbIugu4fX6ajmd
 ApPleZAnjuhGUUYNevoBxyyKHkpTgRxiuA2Dkqn9cq/X8fYzTu8kDknT/radqY6ATvXG
 rtTtNeKg9CgF9u+NS7Ckaypgxxq8D5DpO4PVRSn8EAc5Yec2Ig8YSMTOVkw0mER9uDi5
 Zq/WMwYIcUvfARcCXghsSXpo91WC1i+7b1b6gFL3sFDlbjb/4z/jSegGVXbdIkQNt+Fw
 VZE+xd8XTFm8rwPvbQFJMAvHo5QqOz91oNICQdResey0HIcMg2Ycv4HrHo20qblG8DL/
 3FFQ==
X-Gm-Message-State: AOAM531G1LsLq42X4oqVyPSL2+2YsiPvEeCc3FV1rLqgMRh+fzLTq2B0
 fV+keaeJYm9e+1XTQVubw+vAUP18fbM4yc6UE16GTQbGiYQ0LToim/IVS2PxUSWp+RNlyoFtCUc
 iFSDOBR3DPPhDYkU=
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr3674090wrx.54.1589970421405; 
 Wed, 20 May 2020 03:27:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhttaRqZSokbOgIW8wEcW+xERUX4vEHbD95P790KI0pKivpOqhl52NGIcFo5bmEgK8E86VVA==
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr3674071wrx.54.1589970421127; 
 Wed, 20 May 2020 03:27:01 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id p7sm2550541wmg.38.2020.05.20.03.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 03:27:00 -0700 (PDT)
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: Li Feng <fengli@smartx.com>
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
 <20200514125220.GJ2787@work-vm>
 <CAHckoCyegWG9yH_y6VjHhnghfHJD-Wq+EmOyRZE3EYguTOHfPw@mail.gmail.com>
 <20200514151600.GO2787@work-vm>
 <CAHckoCxc2XTA3ckU0sq-BmbZZFtfAY_GaEOW46XFzfZ2qXjeMQ@mail.gmail.com>
 <20200514153129.GP2787@work-vm>
 <CAHckoCxOjNEAM4DwWtXS9JT_aPsqOtDAzf5zhhiRrDyAmQa00Q@mail.gmail.com>
 <CAHckoCwee+aNHcgRFvReCCz_0J-vLrM5=MPZFpqvQjkefV2MiQ@mail.gmail.com>
 <986fbf33-8127-870b-9163-4aa8d332553f@redhat.com>
 <CAHckoCxw=j8+uXHD3tzQc4vGkRu-_xhcHn8sSeiKaSHw=Bt6mA@mail.gmail.com>
 <7ecfb762-0359-92a4-d8b3-1a9e081ace92@redhat.com>
 <CAHckoCwEt+citc5pQkJxhsWkLuqJa47A98YUYtMHd7epmx0esQ@mail.gmail.com>
 <5902006b-655a-9208-796d-1af7b36da52c@redhat.com>
 <CAHckoCyZmYXU8bz-3UAVXGi1MpdNdb20no1-kB09MoWOGPz_VA@mail.gmail.com>
 <8ce60286-85a5-f338-c079-20e868da59dd@redhat.com>
 <CAHckoCxFGTgPwTXvf6H4AeGDmDyy2dfQRtEHD51QojZpv-0E+Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1a3a26b-7ce1-9be6-836e-cf5ff1f10a2c@redhat.com>
Date: Wed, 20 May 2020 12:26:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHckoCxFGTgPwTXvf6H4AeGDmDyy2dfQRtEHD51QojZpv-0E+Q@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: vkuznets@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/20 12:15, Li Feng wrote:
> /root/qemu-master/x86_64-softmmu/qemu-system-x86_64 -enable-kvm
> -device virtio-balloon -cpu
> host,-vmx-exit-nosave-debugctl,-vmx-exit-ack-intr,-vmx-exit-save-pat,-vmx-exit-load-pat,-vmx-exit-save-efer,-vmx-exit-load-efer,-vmx-exit-save-preemption-timer
> -smp 4 -m 2G -drive
> file=/root/html/fedora-10g.img,format=raw,cache=none,aio=native,if=none,id=drive-virtio-disk1
> -device virtio-blk-pci,scsi=off,drive=drive-virtio-disk1,id=virtio-disk1,bootindex=1
> -device virtio-net,netdev=nw1,mac=00:11:22:EE:EE:10 -netdev
> tap,id=nw1,script=no,downscript=no,ifname=tap0 -serial mon:stdio
> -nographic -object
> memory-backend-file,id=mem0,size=2G,mem-path=/dev/hugepages,share=on
> -numa node,memdev=mem0 -vnc 0.0.0.0:100 -machine usb=on,nvdimm -device
> usb-tablet -monitor tcp:0.0.0.0:1234,server,nowait -qmp
> tcp:0.0.0.0:2234,server,nowait -device
> virtio-serial-pci,id=virtio-serial0,max_ports=16 -chardev
> socket,id=channel1,path=/tmp/helloworld1,server,nowait -device
> virtserialport,chardev=channel1,name=com.redhat.rhevm.vdsm1,bus=virtio-serial0.0,id=port1
> 
> The CentOS version(qemu-kvm-ev-2.12.0-33.1.el7) works well on my VM.
> So I guess this is an issue in the upstream master codebase.

I don't know, it's really weird that KVM rejects bit 9.  It should be
fine as long as KVM_SET_CPUID2 is called before kvm_init_msrs (which is
true, it's some 30 lines earlier in kvm_arch_init_vcpu).

Thanks,

Paolo


