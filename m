Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481FAC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E58215EA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axHhpT1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E58215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57628 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfh9a-00006R-Lf
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 04:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60902)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hfh8p-00086g-5P
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hfh8o-0001gs-1B
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:49:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hfh8n-0001db-Pw
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:49:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id x17so16839037wrl.9
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 01:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=2xgWGW5YYwBeir2g59IFHHTy/C3LKY1IPFZV46tjMn4=;
 b=axHhpT1UpAEb9Sb2c68meWIa/nxwM5qroPDe1jGj+m/6EpgB791JEARiN2Zww4jzCf
 oAKF10/zvfO+9FOQNykxyx5El2B7cf/K5tEySFIMUS7ynC19Uoed634Ug2CGnzliu/rd
 NgNlOWNay5g5ftah6TjpkqDUxjS0wM2HGQ3ACynXFTvFr49HZQFI/Opz5E9NTWHjVMih
 mGtfKtxqrCtzrpwN0xWPvblIJXJJuj1iO8CGhvX96MFzMfH3Yoh5/zaHn1KKPzwQh2LQ
 xAIk1fEHJLykoyZBVnet+zn303w2diQNIse6Hf6KEnXjp1mnTQ99CXeScKcx9KRA466J
 hWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2xgWGW5YYwBeir2g59IFHHTy/C3LKY1IPFZV46tjMn4=;
 b=LEa/KGbnd1QarN+w2tQgePDp8Bw5lNZbXXRYi7qQKXtIswTBYoW5RZ8Kp23OyyD1n2
 7UJGKcVDRTnA+8Ak3AEqTKpq9BZ1/OUknfztmwi4q0C1lkQO0nYWdKI9Z7SBhFBF5POK
 xjR+JpblTI9eNbk3OrnUqG1BiYZVDyKV4yZdO3MM9vVGjQkktwxFzCm4Yo8Q2ADDsdFq
 jbVnyPJcwnJMczYMbiZ1KYSEpJjw78+2XBxanZzpquoYjfHN3nw0WEtNyn4UUNgYg3HF
 P4PW8vlTkbI+Yp38EqxXHWeEFXG5rxXqtSN2IgMYCw5eAeZVgIXhUhBw0sj7LaLeKm4Q
 Ecow==
X-Gm-Message-State: APjAAAWrWv06AGZM1JWyQrM9zuOYNYCkusBFJBcAWj1VYBB9viy0TWL9
 bQEMM/fxs/gEqJJpceTWzN8=
X-Google-Smtp-Source: APXvYqx2PXwS+JDeWoOJuHmoE6KTpkt9j3dMW4a0ufQmyt7fw1o5osyaLWOF1LqpeiBY7o3vBbDLrQ==
X-Received: by 2002:adf:da47:: with SMTP id r7mr27332824wrl.56.1561452562772; 
 Tue, 25 Jun 2019 01:49:22 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
 by smtp.gmail.com with ESMTPSA id j7sm18577809wru.54.2019.06.25.01.49.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 01:49:22 -0700 (PDT)
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20190621144541.13770-1-skrtbhtngr@gmail.com>
 <a80f7beb-48c1-553a-f137-731e5500b608@gmail.com>
 <1AD565D7-F99E-4879-BFEF-0E2C7474A09A@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <91874483-215c-1ccc-6f33-5ceeb8f6ec47@gmail.com>
Date: Tue, 25 Jun 2019 11:49:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1AD565D7-F99E-4879-BFEF-0E2C7474A09A@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [RFC 0/1] Add live migration support to the PVRDMA
 device
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
Cc: Sukrit Bhatnagar <skrtbhtngr@gmail.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Dmitry,

On 6/25/19 11:39 AM, Dmitry Fleytman wrote:
>
>> On 25 Jun 2019, at 11:14, Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
>>
>> Hi Sukrit
>>
>> On 6/21/19 5:45 PM, Sukrit Bhatnagar wrote:
>>> Hi,
>> [...]
>>> This RFC is meant to request suggestions on the things which are
>>> working and for help on the things which are not.
>>>
>> [...]
>>> What is not working:
>>>
>> [...]
>>> * It seems that vmxnet3 migration itself is not working properly, at least
>>>    for me. The pvrdma device depends on it, vmxnet3 is function 0 and pvrdma
>>>    is function 1. This is happening even for a build of unmodified code from
>>>    the master branch.
>>>    After migration, the network connectivity is lost at destination.
>>>    Things are fine at the source before migration.
>>>    This is the command I am using at src:
>>>
>>>    sudo /home/skrtbhtngr/qemu/build/x86_64-softmmu/qemu-system-x86_64 \
>>>      -enable-kvm \
>>>      -m 2G -smp cpus=2 \
>>>      -hda /home/skrtbhtngr/fedora.img \
>>>      -netdev tap,id=hostnet0 \
>>>      -device vmxnet3,netdev=hostnet0,id=net0,mac=52:54:00:99:ff:bc \
>>>      -monitor telnet:127.0.0.1:4444,server,nowait \
>>>      -trace events=/home/skrtbhtngr/trace-events \
>>>      -vnc 0.0.0.0:0
>>>
>>>    Similar command is used for the dest. Currently, I am trying
>>>    same-host migration for testing purpose, without the pvrdma device.
>>>    Two tap interfaces, for src and dest were created successfully at
>>>    the host. Kernel logs:
>>>    ...
>>>    br0: port 2(tap0) entered forwarding state
>>>    ...
>>>    br0: port 3(tap1) entered forwarding state
>>>
>>>    tcpdump at the dest reports only outgoing ARP packets, which ask
>>>    for gateway: "ARP, Request who-has _gateway tell guest1".
>>>
>>>    Tried using user (slirp) as the network backend, but no luck.
>>>       Also tried git bisect to find the issue using a working commit (given
>>>    by Marcel), but it turns out that it is very old and I faced build
>>>    errors one after another.
>>>
>>>    Please note that e1000 live migration is working fine in the same setup.
>>>
>> I tried to git bisect , but I couldn't find a working version of vmxnet supporting live migration ....
>> I tried even a commit from December 2014 and it didn't work.
>>
>> What is strange (to me) is that the networking packets can't be sent from the guest (after migration)
>> even after rebooting the guest.
> This makes me think that some network offload configuration wasn’t properly migrated or applied.
> What network backend are you using?

Suktrit tried with tap device, I tried with slirp.
If you can point me to the property that disables all the offloads it 
will really help.

> Do you see any outgoing packets in the sniffer?

I didn't use the sniffer, I checked dmesg in guest, there was a line 
complaining that it can't send packets.

Thanks,
Marcel

>> Any help or pointer would be greatly appreciated.
>> Thanks,
>> Marcel
>>
>>
>> [...]


