Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C55E2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXRo5Vku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C55E2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQKT-00088D-B5
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jwQJq-0007gc-FP
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:22:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jwQJn-0004sF-MN
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594992146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+EQzNyKsb2YCp3Iu8CmYMhz0A5AD+cVZrnsgTj56E7E=;
 b=SXRo5VkuWhWxpFvRFya9R/Zd7bx/lI/rSBn6bXn3xfiuh/9DGwiMxsUUUN7qPHmHSxIhNz
 lGaUjygfWM9cFfEAy+EqRWHkkYO+HbsgnHQgP5D/JhLqiIyaBgLCZRux3S7pWWocHYtprM
 WmQy8WucHHibkwmSOb1QG847PBcJm54=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-XsqddlOhOeaHdha4eb5Qog-1; Fri, 17 Jul 2020 09:22:25 -0400
X-MC-Unique: XsqddlOhOeaHdha4eb5Qog-1
Received: by mail-ej1-f71.google.com with SMTP id b14so5721431ejv.14
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 06:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+EQzNyKsb2YCp3Iu8CmYMhz0A5AD+cVZrnsgTj56E7E=;
 b=IHENtWDvgElFdtsHGKJxQ2mdfOR4XwE4wrGgy6r/z4g9K7G2Nxhlre13bijrIPGx0C
 igjuNSvLxNHLa+AH72fEDLaI7lmJ0Og55M7b8IfagJopfOfUgsHnhaIyFggDc7SEGx/c
 pE2r862MPV1dfwgFfDT7Hr2B+Aq3+ar3AVXfgjKtqff7jtO1wjH2PMgkktjbRWkCHdD0
 K8KOmBcDnfiyszDwr1Ki7vvbkr4jbrnbdvOD+ySCWFbsnwAPtcaJlbZkNjAxSb7ZV/Ms
 FeFUsOgVAU+WFSNEgaf4/sC8CIhvQp9U2hcoEjaArUpUDD0w0VpcF4nOfJmsX9CxzpRk
 BjiA==
X-Gm-Message-State: AOAM530djLucBAFzVJOvcVW7eEeK0lCBcthALPvwinbdSWtCLFi4VIHC
 5zxlvm3VvIyEPDNhfkR4CDx/pu+aRBPzERDvZvZK40Xx1GAnOGKGAEYxRV7Bt3cxw+dY0Tz4gUS
 lrzwwoMKdLSz2xsc=
X-Received: by 2002:a05:6402:359:: with SMTP id
 r25mr9006061edw.177.1594992143779; 
 Fri, 17 Jul 2020 06:22:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0Zv9lJSUEpNCCPfmTTv3D9RXL3tk8leWPPBVQOC6Y7CNh6CwkvUXwGKR6D+AeOzSZ7DNB2g==
X-Received: by 2002:a05:6402:359:: with SMTP id
 r25mr9006034edw.177.1594992143526; 
 Fri, 17 Jul 2020 06:22:23 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id m6sm4911787ejn.99.2020.07.17.06.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 06:22:22 -0700 (PDT)
Subject: Re: tests/vm infrastructure fails to notice that QEMU dying is a
 failure
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA8iKKDKEdq8TtbZNwqfsH=ZO78eEXWfrVbYTDjdy9DYDw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <890eb42e-cd77-2a63-c441-61637ac5094f@redhat.com>
Date: Fri, 17 Jul 2020 15:22:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8iKKDKEdq8TtbZNwqfsH=ZO78eEXWfrVbYTDjdy9DYDw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing John & Cleber.

On 7/17/20 3:08 PM, Peter Maydell wrote:
> If you run vm-build-openbsd, our makefile/scripting infrastructure
> seems to fail to notice that death of the QEMU process that's
> running the VM should be a failure, and ends up allowing make
> to return a success condition.
> 
> I have a script which runs a VM build which basically does:
> 
>   #!/bin/sh -e
>   make -C "build" "vm-build-openbsd" J=8 V=1
>   echo "OK DONE openbsd"
> 
> It just gave me this output (tail end of logfile). We're executing tests,
> and then the qemu-system-x86_64 that's running the OpenBSD VM gets
> a signal 9 (sigkill), for unclear reasons (oom killer??). The python
> scripting gets an exception, but doesn't exit with a failure status to
> make, which then thinks all is fine, exits success itself and allows
> the set -e script to proceed to print the "OK DONE" line...
> 
> 
> PASS 30 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/pca9552/pca9552-tests/tx-rx
> PASS 31 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/pca9552/pca9552-tests/rx-autoinc
> PASS 32 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/ds1338/ds1338-tests/tx-rx
> DEBUG:QMP.qemu-26462:>>> {'execute': 'quit'}
> DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594984057,
> 'microseconds': 485197}, 'event': 'NIC_RX_FILTER_CHANGED', 'data':
> {'path': '/machine/peripheral-anon/device[0]/virtio-backend'}}
> DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594985855,
> 'microseconds': 169552}, 'event': 'RTC_CHANGE', 'data': {'offset': 0}}
> DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594987655,
> 'microseconds': 169187}, 'event': 'RTC_CHANGE', 'data': {'offset': 0}}
> DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594989456,
> 'microseconds': 88866}, 'event': 'RTC_CHANGE', 'data': {'offset': 0}}
> DEBUG:QMP.qemu-26462:<<< {'return': {}}
> WARNING:qemu.machine:qemu received signal 9; command:
> "qemu-system-x86_64 -display none -vga none -chardev
> socket,id=mon,path=/var/tmp/qemu-26462-monitor.sock -mon
> chardev=mon,mode=control -machine pc -chardev
> socket,id=console,path=/var/tmp/qemu-26462-console.sock,server,nowait
> -serial chardev:console -nodefaults -m 4G -cpu max -netdev
> user,id=vnet,hostfwd=:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=vnet -vnc 127.0.0.1:0,to=20 -smp 8 -enable-kvm
> -drive file=/home/peter.maydell/.cache/qemu-vm/images/openbsd.img,snapshot=on,if=none,id=drive0,cache=writeback
> -device virtio-blk,drive=drive0,bootindex=0 -drive
> file=/home/peter.maydell/qemu-openbsd/build/vm-test-yzwn6xdc.tmp/data-993a1.tar,if=none,id=data-993a1,cache=writeback,format=raw
> -device virtio-blk,drive=data-993a1,serial=data-993a1,bootindex=1"
> Error in atexit._run_exitfuncs:
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
> line 436, in _do_shutdown
>     self._soft_shutdown(has_quit, timeout)
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
> line 419, in _soft_shutdown
>     self._popen.wait(timeout=timeout)
>   File "/usr/lib/python3.6/subprocess.py", line 1469, in wait
>     raise TimeoutExpired(self.args, timeout)
> subprocess.TimeoutExpired: Command '['qemu-system-x86_64', '-display',
> 'none', '-vga', 'none', '-chardev',
> 'socket,id=mon,path=/var/tmp/qemu-26462-monitor.sock', '-mon',
> 'chardev=mon,mode=control', '-machine', 'pc', '-chardev',
> 'socket,id=console,path=/var/tmp/qemu-26462-console.sock,server,nowait',
> '-serial', 'chardev:console', '-nodefaults', '-m', '4G', '-cpu',
> 'max', '-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22', '-device',
> 'virtio-net-pci,netdev=vnet', '-vnc', '127.0.0.1:0,to=20', '-smp',
> '8', '-enable-kvm', '-drive',
> 'file=/home/peter.maydell/.cache/qemu-vm/images/openbsd.img,snapshot=on,if=none,id=drive0,cache=writeback',
> '-device', 'virtio-blk,drive=drive0,bootindex=0', '-drive',
> 'file=/home/peter.maydell/qemu-openbsd/build/vm-test-yzwn6xdc.tmp/data-993a1.tar,if=none,id=data-993a1,cache=writeback,format=raw',
> '-device', 'virtio-blk,drive=data-993a1,serial=data-993a1,bootindex=1']'
> timed out after 3 seconds
> 
> The above exception was the direct cause of the following exception:
> 
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
> line 466, in shutdown
>     self._do_shutdown(has_quit, timeout=timeout)
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
> line 440, in _do_shutdown
>     from exc
> qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
> make: Leaving directory '/home/peter.maydell/qemu-openbsd/build'
> OK DONE openbsd
> 
> thanks
> -- PMM
> 


