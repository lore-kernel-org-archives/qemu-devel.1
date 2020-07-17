Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51368C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 22:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195F12070A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 22:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqifhwkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195F12070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwYn4-0000Zf-BG
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 18:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jwYmM-000088-9a
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 18:24:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31779
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jwYmJ-0003dg-HC
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 18:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595024664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBht/kAZTwTvrir99vnGsrS7OGGjMkHxzQimvCMfn7Y=;
 b=gqifhwkVClMsALPAvfsD5JhukA+nwafIRCJEEli6RGE/i9e11MmJSynLr8g0vxHbxFHYI3
 x1PVBQoZjOr+EQYWVyDO6yqarIYgSeI6iLRK2FQl4E3KZL7UZnVWG4nKecSjtkoy83lk2c
 kumDcNffe7kKfsHR5diXFqv2PvOxFgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-9jb-zLS7OvWcl1pCJu8vRQ-1; Fri, 17 Jul 2020 18:24:20 -0400
X-MC-Unique: 9jb-zLS7OvWcl1pCJu8vRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DA9C100A61D;
 Fri, 17 Jul 2020 22:24:19 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-115-162.rdu2.redhat.com [10.10.115.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 847365C5FA;
 Fri, 17 Jul 2020 22:24:18 +0000 (UTC)
Subject: Re: tests/vm infrastructure fails to notice that QEMU dying is a
 failure
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA8iKKDKEdq8TtbZNwqfsH=ZO78eEXWfrVbYTDjdy9DYDw@mail.gmail.com>
 <890eb42e-cd77-2a63-c441-61637ac5094f@redhat.com>
 <42c71a79-4911-dc47-d983-783d98e819c5@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <89f309c2-9909-f306-2f2b-93fc1b8adc17@redhat.com>
Date: Fri, 17 Jul 2020 18:24:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <42c71a79-4911-dc47-d983-783d98e819c5@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 17:59:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 robert.foley@linaro.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 9:25 AM, Philippe Mathieu-Daudé wrote:
> On 7/17/20 3:22 PM, Philippe Mathieu-Daudé wrote:
>> Cc'ing John & Cleber.
>>
>> On 7/17/20 3:08 PM, Peter Maydell wrote:
>>> If you run vm-build-openbsd, our makefile/scripting infrastructure
>>> seems to fail to notice that death of the QEMU process that's
>>> running the VM should be a failure, and ends up allowing make
>>> to return a success condition.
>>>
>>> I have a script which runs a VM build which basically does:
>>>
>>>    #!/bin/sh -e
>>>    make -C "build" "vm-build-openbsd" J=8 V=1
>>>    echo "OK DONE openbsd"
>>>
>>> It just gave me this output (tail end of logfile). We're executing tests,
>>> and then the qemu-system-x86_64 that's running the OpenBSD VM gets
>>> a signal 9 (sigkill), for unclear reasons (oom killer??). The python
>>> scripting gets an exception, but doesn't exit with a failure status to
>>> make, which then thinks all is fine, exits success itself and allows
>>> the set -e script to proceed to print the "OK DONE" line...

The signal 9 is likely due to QEMU freezing on exit. The machine.py code 
waits about 3 seconds after trying to shut QEMU down gracefully before 
sending SIGKILL and cleaning up forcefully.

>>>
>>>
>>> PASS 30 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/pca9552/pca9552-tests/tx-rx
>>> PASS 31 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/pca9552/pca9552-tests/rx-autoinc
>>> PASS 32 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/ds1338/ds1338-tests/tx-rx
>>> DEBUG:QMP.qemu-26462:>>> {'execute': 'quit'}
>>> DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594984057,
>>> 'microseconds': 485197}, 'event': 'NIC_RX_FILTER_CHANGED', 'data':
>>> {'path': '/machine/peripheral-anon/device[0]/virtio-backend'}}
>>> DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594985855,
>>> 'microseconds': 169552}, 'event': 'RTC_CHANGE', 'data': {'offset': 0}}
>>> DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594987655,
>>> 'microseconds': 169187}, 'event': 'RTC_CHANGE', 'data': {'offset': 0}}
>>> DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594989456,
>>> 'microseconds': 88866}, 'event': 'RTC_CHANGE', 'data': {'offset': 0}}
>>> DEBUG:QMP.qemu-26462:<<< {'return': {}}
>>> WARNING:qemu.machine:qemu received signal 9; command:
>>> "qemu-system-x86_64 -display none -vga none -chardev
>>> socket,id=mon,path=/var/tmp/qemu-26462-monitor.sock -mon
>>> chardev=mon,mode=control -machine pc -chardev
>>> socket,id=console,path=/var/tmp/qemu-26462-console.sock,server,nowait
>>> -serial chardev:console -nodefaults -m 4G -cpu max -netdev
>>> user,id=vnet,hostfwd=:127.0.0.1:0-:22 -device
>>> virtio-net-pci,netdev=vnet -vnc 127.0.0.1:0,to=20 -smp 8 -enable-kvm
>>> -drive file=/home/peter.maydell/.cache/qemu-vm/images/openbsd.img,snapshot=on,if=none,id=drive0,cache=writeback
>>> -device virtio-blk,drive=drive0,bootindex=0 -drive
>>> file=/home/peter.maydell/qemu-openbsd/build/vm-test-yzwn6xdc.tmp/data-993a1.tar,if=none,id=data-993a1,cache=writeback,format=raw
>>> -device virtio-blk,drive=data-993a1,serial=data-993a1,bootindex=1"
>>> Error in atexit._run_exitfuncs:
>>> Traceback (most recent call last):
>>>    File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
>>> line 436, in _do_shutdown
>>>      self._soft_shutdown(has_quit, timeout)
>>>    File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
>>> line 419, in _soft_shutdown
>>>      self._popen.wait(timeout=timeout)
>>>    File "/usr/lib/python3.6/subprocess.py", line 1469, in wait
>>>      raise TimeoutExpired(self.args, timeout)

This is where it times out waiting for the process to exit of its own 
volition. This is the "Inner" exception ...

>>> subprocess.TimeoutExpired: Command '['qemu-system-x86_64', '-display',
>>> 'none', '-vga', 'none', '-chardev',
>>> 'socket,id=mon,path=/var/tmp/qemu-26462-monitor.sock', '-mon',
>>> 'chardev=mon,mode=control', '-machine', 'pc', '-chardev',
>>> 'socket,id=console,path=/var/tmp/qemu-26462-console.sock,server,nowait',
>>> '-serial', 'chardev:console', '-nodefaults', '-m', '4G', '-cpu',
>>> 'max', '-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22', '-device',
>>> 'virtio-net-pci,netdev=vnet', '-vnc', '127.0.0.1:0,to=20', '-smp',
>>> '8', '-enable-kvm', '-drive',
>>> 'file=/home/peter.maydell/.cache/qemu-vm/images/openbsd.img,snapshot=on,if=none,id=drive0,cache=writeback',
>>> '-device', 'virtio-blk,drive=drive0,bootindex=0', '-drive',
>>> 'file=/home/peter.maydell/qemu-openbsd/build/vm-test-yzwn6xdc.tmp/data-993a1.tar,if=none,id=data-993a1,cache=writeback,format=raw',
>>> '-device', 'virtio-blk,drive=data-993a1,serial=data-993a1,bootindex=1']'
>>> timed out after 3 seconds
>>>
>>> The above exception was the direct cause of the following exception:
>>>
>>> Traceback (most recent call last):
>>>    File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
>>> line 466, in shutdown
>>>      self._do_shutdown(has_quit, timeout=timeout)
>>>    File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
>>> line 440, in _do_shutdown
>>>      from exc
>>> qemu.machine.AbnormalShutdown: Could not perform graceful shutdown

And this is the "Outer" exception, the machine.py cleanup handler 
letting you know that while it did perform cleanup, QEMU was not shut 
down properly.

>>> make: Leaving directory '/home/peter.maydell/qemu-openbsd/build'
>>> OK DONE openbsd
> 
> John it seems due to the addition of the 'finally' clause in
> 193bf1c061 ("python/machine.py: split shutdown into hard and
> soft flavors").
> 

That's surprising. I'll look into this Monday, but the "Finally: " 
should only perform some actions without suppressing the exception. You 
can see here it DIDN'T suppress it.

...but maybe we don't return non-zero if an exception gets raised during 
atexit()? Maybe that's what's happening here.

... ... Ah, guess what, that's exactly it. atexit suppresses exceptions. 
You just never noticed this problem before because machine.py used to 
suppress problems during shutdown instead of reporting them.

```
#!/usr/bin/env python3

import atexit
from qemu import machine

def handler():
     raise machine.AbnormalShutdown("oh no")

atexit.register(handler)
```

Oops, this returns a zero code.


So:

- basevm.py should likely be converted to a context manager object just 
like machine.py's QEMUMachine class was so cleanup can happen explicitly 
when the VM object goes out of scope.

(Callers would use: "with baseVM() as foo:" pattern, or, where that's 
not possible, call an explicit .shutdown().)

- The real problem, though: Why is QEMU hanging? It might need a longer 
timeout, or it might be having problems with the console socket again.

(CC Robert Foley who has been working on the Console socket draining 
problems. Maybe he has some insight here?)

--js


