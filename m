Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197ECC2D0F8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 21:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C597520740
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 21:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXeuk3Kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C597520740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYc0S-0002z1-Vl
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 17:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYbze-0002Lt-B8
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:59:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44007
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYbzc-0008GZ-BA
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589317150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IHRfdQ9zqxbC/pxM895aB1gXmEpR3VEfF+8jBN2dQBA=;
 b=iXeuk3Kp4dDf4T72w8b7i2TYgj5uTCrtLF+P3CUHnA6TPJcJkaSG3b6r5tYLaZ2OYR8c6H
 D/0Z0zOA+vqg1GPBJTzm/26uLy+Ur6acSiFpNA93F0o4HJvDY6yuZ9dyf8+V+7Lb5JIunx
 dEJ/0IxmEfwBT/ZroAt9oOSj2Ef9Sq4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-KsPo-2BGNXOuzMJxlZGAnQ-1; Tue, 12 May 2020 16:59:06 -0400
X-MC-Unique: KsPo-2BGNXOuzMJxlZGAnQ-1
Received: by mail-wr1-f70.google.com with SMTP id u5so5640679wrt.22
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 13:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IHRfdQ9zqxbC/pxM895aB1gXmEpR3VEfF+8jBN2dQBA=;
 b=CpZrN7mVHN78Bu2qw3VCHfY8MTtOSGxlIFmT87oZRKaLt0oQfrSKG/OH4q2OHW+gcQ
 hh/WkF0Owl5lRact308oMjIsmPGOlJBxllcQf1YgyOaawJbPgcE+/smevrPmKzuAoZ1s
 qyq9YeOOvuQnFY5epOpbwp9tr/11+tRG9e7qX14lnM2wmZ7qNAlpSD0ZeDMSph58kBvC
 xor/ytK1cZivaEFfE5fhkrD8zdxpe3RlHGVMESAxNsZXpi1iyhweebi2HKLQi7aNnprV
 OzwLjQoFDUSQOQ7SCBcPjkjCmrP5/6MLJShC0l2LKJn75uwU4vU496NYREWwqs16LB5u
 hKTA==
X-Gm-Message-State: AGi0Pubtt4lz5XCU/v8giZKeNV4nsQ7XCf/OGPEHmTKcKhZPBDY+evIB
 AVgamStuhATN5ZwWUX2N+dUZ/KmSDLqBfPpQI5yKwEAlTILvPvrlIXRz9pWQqBRhqZYQBrxTD/q
 eSWqNAfmOCeQWV80=
X-Received: by 2002:a5d:560c:: with SMTP id l12mr26459867wrv.309.1589317144037; 
 Tue, 12 May 2020 13:59:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypKiyDeKyg2sR4ZOOVBCi/IVntfW5TLFrW763gErd/c9mkS+PeJ9RAtJu71AhY/v/7h6Vkqyzw==
X-Received: by 2002:a5d:560c:: with SMTP id l12mr26459841wrv.309.1589317143730; 
 Tue, 12 May 2020 13:59:03 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a24sm32863303wmb.24.2020.05.12.13.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 13:59:03 -0700 (PDT)
Subject: Re: [PATCH 0/2] use unsigned type for MegasasState fields
To: Alexander Bulekov <alxndr@bu.edu>, P J P <ppandit@redhat.com>
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <26201c24-c483-85a7-2f4b-b3cc56d4b8b7@redhat.com>
 <nycvar.YSQ.7.76.2005122357030.1451610@xnncv>
 <20200512190803.o6vr2shjmhsplsjx@mozz.bu.edu>
 <20200512194759.nb42yurlnynr5yrw@mozz.bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <810b7ee0-e3eb-cd08-887a-df97a8576c9c@redhat.com>
Date: Tue, 12 May 2020 22:59:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512194759.nb42yurlnynr5yrw@mozz.bu.edu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Ren Ding <rding@gatech.edu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 9:48 PM, Alexander Bulekov wrote:
> Oops I realized I posted a bad stacktrace and a bad reproducer :)
> Fixed stacktrace:
> 
> ==20527==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7f79f968a5e0 at pc 0x55b6bb84ce28 bp 0x7ffcbca04eb0 sp 0x7ffcbca04ea8
> READ of size 8 at 0x7f79f968a5e0 thread T0
> 
> #0 0x55fbeb2bdafc in megasas_lookup_frame /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:449:30
> #1 0x55fbeb27caa9 in megasas_handle_abort /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:1904:17
> #2 0x55fbeb26cb77 in megasas_handle_frame /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:1961:24
> #3 0x55fbeb267b78 in megasas_mmio_write /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:2122:9
> #4 0x55fbe90b117b in memory_region_write_accessor /home/alxndr/Development/qemu-bugs/qemu2/qemu/memory.c:496:5
> #5 0x55fbe90b05e4 in access_with_adjusted_size /home/alxndr/Development/qemu-bugs/qemu2/qemu/memory.c:557:18
> #6 0x55fbe90ae177 in memory_region_dispatch_write /home/alxndr/Development/qemu-bugs/qemu2/qemu/memory.c:1488:16
> #7 0x55fbe8d97325 in flatview_write_continue /home/alxndr/Development/qemu-bugs/qemu2/qemu/exec.c:3174:23
> 
> Fixed reproducer (tested on qemu 5.0 built with ASAN with these patches):

Is this the one reported as LP#1878259?
"Null-pointer dereference in megasas_handle_frame"
https://bugs.launchpad.net/qemu/+bug/1878259

> 
> cat << EOF | qemu-system-i386 -qtest stdio -nographic -monitor none \
> -serial none -M q35 -device megasas -device scsi-cd,drive=null0 \
> -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic
> outl 0xcf8 0x80001814
> outl 0xcfc 0xc021
> outl 0xcf8 0x80001818
> outl 0xcf8 0x80001804
> outw 0xcfc 0x7
> outl 0xcf8 0x80001810
> outl 0xcfc 0xe10c0000
> outl 0xcf8 0x8000f810
> write 0x0 0x18 0x060017e1ff00f8ffffffff60efffffffffffffffffffffff
> write 0xff00 0x1 0x06
> write 0xc021e10c0040 0x81 0x755e08ff0000845e08ff0000935e08ff0000a25e08ff0000b15e08ff0000c05e08ff0000cf5e08ff0000de5e08ff0000ed5e08ff0000fc5e08ff00000b5e08ff00001a5e08ff0000295e08ff0000385e08ff0000475e08ff0000565e08ff0000655e08ff0000745e08ff0000835e08ff0000925e08ff0000a15e08ff0000b05e08
> -M pc-q35-5.0 -no-shutdown -M q35 -device megasas -device scsi-cd,drive=null0 -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic
> 
> EOF
> 
> On 200512 1508, Alexander Bulekov wrote:
>> Hello Prasad,
>> I noticed this since I found a similar issue recently, using a fuzzer.
>> I applied your patches, but I can still reproduce the heap-overflow,
>> unless I'm missing something:
>>
>> ==20527==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7f79f968a5e0 at pc 0x55b6bb84ce28 bp 0x7ffcbca04eb0 sp 0x7ffcbca04ea8
>> READ of size 8 at 0x7f79f968a5e0 thread T0
>>      #0 0x55fbeb2bdafc in megasas_lookup_frame /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:449:30
>>      #0 0x55b6bb84ce27 in megasas_lookup_frame (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x1c1fe27)
>>      #1 0x55b6bb82f3e4 in megasas_handle_abort (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x1c023e4)
>>      #2 0x55b6bb8293df in megasas_handle_frame (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x1bfc3df)
>>      #3 0x55b6bb8275eb in megasas_mmio_write (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x1bfa5eb)
>>      #4 0x55b6bab5c864 in memory_region_write_accessor (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0xf2f864)
>>      #5 0x55b6bab5c239 in access_with_adjusted_size (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0xf2f239)
>>      #6 0x55b6bab5ada5 in memory_region_dispatch_write (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0xf2dda5)
>>      #7 0x55b6ba994bf3 in flatview_write_continue (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0xd67bf3)
>>      #8 0x55b6ba984ad8 in flatview_write (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0xd57ad8)
>>      #1 0x55fbeb27caa9 in megasas_handle_abort /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:1904:17
>>      #2 0x55fbeb26cb77 in megasas_handle_frame /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:1961:24
>>      #3 0x55fbeb267b78 in megasas_mmio_write /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:2122:9
>>      #4 0x55fbe90b117b in memory_region_write_accessor /home/alxndr/Development/qemu-bugs/qemu2/qemu/memory.c:496:5
>>      #5 0x55fbe90b05e4 in access_with_adjusted_size /home/alxndr/Development/qemu-bugs/qemu2/qemu/memory.c:557:18
>>      #6 0x55fbe90ae177 in memory_region_dispatch_write /home/alxndr/Development/qemu-bugs/qemu2/qemu/memory.c:1488:16
>>      #7 0x55fbe8d97325 in flatview_write_continue /home/alxndr/Development/qemu-bugs/qemu2/qemu/exec.c:3174:23
>>
>> To reproduce:
>> cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -qtest stdio -nographic -monitor none -serial none  -M q35 -device megasas -device scsi-cd,drive=null0 -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic
>> outl 0xcf8 0x80001814
>> outl 0xcfc 0xc021
>> outl 0xcf8 0x80001818
>> outl 0xcf8 0x80001804
>> outw 0xcfc 0x7
>> outl 0xcf8 0x80001810
>> outl 0xcfc 0xe10c0000
>> outl 0xcf8 0x8000f810
>> write 0x0 0x18 0x060017e1ff00f8ffffffff60efffffffffffffffffffffff
>> write 0xff00 0x1 0x06
>> write 0xc021e10c0040 0x81 0x755e08ff0000845e08ff0000935e08ff0000a25e08ff0000b15e08ff0000c05e08ff0000cf5e08ff0000de5e08ff0000ed5e08ff0000fc5e08ff00000b5e08ff00001a5e08ff0000295e08ff0000385e08ff0000475e08ff0000565e08ff0000655e08ff0000745e08ff0000835e08ff0000925e08ff0000a15e08ff0000b05e08
>> -M pc-q35-5.0 -no-shutdown -M q35 -device megasas -device scsi-cd,drive=null0 -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic
>> EOF
>>
>> -Alex
>>
>> On 200513 0007, P J P wrote:
>>> +-- On Tue, 12 May 2020, Philippe Mathieu-Daudé wrote --+
>>> | Cc'ing Marc-André our signed/unsigned conversion expert (with Paolo).
>>>
>>>    megasas_init_firmware
>>>      pa_lo = le32_to_cpu(initq->pi_addr_lo);
>>>      pa_hi = le32_to_cpu(initq->pi_addr_hi);
>>>      s->producer_pa = ((uint64_t) pa_hi << 32) | pa_lo;
>>>      s->reply_queue_head = ldl_le_pci_dma(pcid, s->producer_pa);
>>>
>>> IIUC, here ldl_le_pci_dma() returns an 'uint32_t' type, but since
>>> 'reply_queue_head' is a signed int, large 'uint32_t' value turns negative.
>>>
>>> | Do you have a reproducer?
>>>
>>>    Yes, there is a reproducer with ASAN, though it did not work for me.
>>> Ren(CC'd) had shared this trace:
>>>
>>> AddressSanitizer: heap-buffer-overflow on address 0x7f9159054058 at pc 0x55763514b5cd bp 0x7f9179bd6d90 sp 0x7f9179bd6d88
>>> READ of size 8 at 0x7f9159054058 thread T2
>>>    #0 0x55763514b5cc in megasas_lookup_frame /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:449:30
>>>    #1 0x55763513205c in megasas_handle_abort /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:1904:17
>>>    #2 0x55763512d0f8 in megasas_handle_frame /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:1961:24
>>>    #3 0x55763512ba7d in megasas_mmio_write /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:2122:9
>>>    #4 0x55763515247c in megasas_port_write /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:2173:5
>>>    #5 0x557634621b3b in memory_region_write_accessor /home/ren/tmp/redacted-dbg/qemu/memory.c:483:5
>>>    #6 0x557634621741 in access_with_adjusted_size /home/ren/tmp/redacted-dbg/qemu/memory.c:544:18
>>>    #7 0x557634620498 in memory_region_dispatch_write /home/ren/tmp/redacted-dbg/qemu/memory.c:1482:16
>>>    #8 0x5576344b6b6c in flatview_write_continue /home/ren/tmp/redacted-dbg/qemu/exec.c:3161:23
>>>    #9 0x5576344a87d9 in flatview_write /home/ren/tmp/redacted-dbg/qemu/exec.c:3201:14
>>>    #10 0x5576344a8376 in address_space_write /home/ren/tmp/redacted-dbg/qemu/exec.c:3291:18
>>>    #11 0x5576344a8af4 in address_space_rw /home/ren/tmp/redacted-dbg/qemu/exec.c:3301:16
>>>    #12 0x557634689e10 in kvm_handle_io /home/ren/tmp/redacted-dbg/qemu/accel/kvm/kvm-all.c:2086:9
>>>    #13 0x557634688a45 in kvm_cpu_exec /home/ren/tmp/redacted-dbg/qemu/accel/kvm/kvm-all.c:2332:13
>>>    #14 0x5576345ee7aa in qemu_kvm_cpu_thread_fn /home/ren/tmp/redacted-dbg/qemu/cpus.c:1299:17
>>>    #15 0x557635a11509 in qemu_thread_start /home/ren/tmp/redacted-dbg/qemu/util/qemu-thread-posix.c:519:9
>>>    #16 0x7f918cec26b9 in start_thread (/lib/x86_64-linux-gnu/libpthread.so.0+0x76b9)
>>>    #17 0x7f918c5d441c in clone /build/glibc-LK5gWL/glibc-2.23/misc/../sysdeps/unix/sysv/linux/x86_64/clone.S:109
>>>
>>>
>>> Thank you.
>>> --
>>> Prasad J Pandit / Red Hat Product Security Team
>>> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
>>
>>
> 


