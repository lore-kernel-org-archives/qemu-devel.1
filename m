Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26DAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A80B23359
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhqPBfdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A80B23359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpp7t-00011f-Oo
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpp7K-0000Xs-AH
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 04:26:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpp7H-0003q5-MG
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 04:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593419174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QASDTxfILlDDmHqq3uoY+yD4xTnPID36gxQ6hqP/G8Y=;
 b=HhqPBfdBLyJUXd7BVm4HhILC+dwWNhR9cQc9Yge5V2cVGIv7bJytbgTtkej2ujiLQuoCFH
 3DmJENZgzQ1XELo5kvt3ErrvtinQ+uQHlQ7gQaR/K0Cn3AQRrbDnhGtK8hpqXld3gjRbqh
 N3noeusK+JMoXZE7KtnbLRlHoYJx7aY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-rsOmNRq-PkKCbpJY_Qf49w-1; Mon, 29 Jun 2020 04:26:11 -0400
X-MC-Unique: rsOmNRq-PkKCbpJY_Qf49w-1
Received: by mail-wm1-f69.google.com with SMTP id z11so18129324wmg.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 01:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QASDTxfILlDDmHqq3uoY+yD4xTnPID36gxQ6hqP/G8Y=;
 b=MrAqGcnAE1IzaBhzJbHuCWxrdulUzsmUDdrdMRr8OwwkNdu8vKqTdOU32wpgLARSZX
 MCSBTglRufNbw3cdvEIsngJrozrfiCqDN7RWKoQ2haJotyzQY6gRnpuG2GYaNuzcRipI
 WlO23rW+9mXjQova6J/rutl0hF3KbkSxrZbTl8Rd6TXVPW2cqzPr2xkyYgMzn1ynsaSt
 jBtRyded8xr7QPrlFNx82lsf3wwUWQ9+b+BUlyeE9gQZq5daOn0IesX/KHnScSOZz/nX
 1yhwz+O3f4qNbYoDLly10lWx+BheL+VDZrU9fxRZtxwEvJTfYxF6xZddzlLiaWj09WLt
 l14w==
X-Gm-Message-State: AOAM532H19Bv7PEpLN73p/2tm6pFXjKKc3dlu8m6Eu3A+yhHEDAhR28E
 kefq64r7XHu+j8sjzU/Q9rkWsur37ifCcRKmPHTD44PBm7Rfvif73JIW/zNzRwU8R55TJJojrVN
 D9Bxr7DcvTiASDG4=
X-Received: by 2002:a5d:5549:: with SMTP id g9mr16866608wrw.419.1593419170236; 
 Mon, 29 Jun 2020 01:26:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzW8kHAT5u3jeVd/8c8SODQccwK2Qvt99haN9Q+vAZtsV7xuuobOlWYVgGQ11MEMVoJyo/lNA==
X-Received: by 2002:a5d:5549:: with SMTP id g9mr16866593wrw.419.1593419170012; 
 Mon, 29 Jun 2020 01:26:10 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g144sm31946392wme.2.2020.06.29.01.26.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 01:26:09 -0700 (PDT)
Subject: Re: [PATCH v4 00/16] python: add mypy support to python/qemu
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20200626204133.14500-1-jsnow@redhat.com>
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
Message-ID: <f7c36cc7-e05c-65cc-b6be-9da8d136b295@redhat.com>
Date: Mon, 29 Jun 2020 10:26:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626204133.14500-1-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 WEIRD_PORT=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Cleber/Wainer.

On 6/26/20 10:41 PM, John Snow wrote:
> Based-on: 20200626202350.11060-1-jsnow@redhat.com
> 
> This series modifies the python/qemu library to comply with mypy --strict.
> This requires my "refactor shutdown" patch as a pre-requisite.
> 
> v4:
> 001/16:[----] [--] 'python/qmp.py: Define common types'
> 002/16:[----] [--] 'iotests.py: use qemu.qmp type aliases'
> 003/16:[----] [--] 'python/qmp.py: re-absorb MonitorResponseError'
> 004/16:[----] [--] 'python/qmp.py: Do not return None from cmd_obj'
> 005/16:[----] [--] 'python/qmp.py: add casts to JSON deserialization'
> 006/16:[----] [--] 'python/qmp.py: add QMPProtocolError'
> 007/16:[----] [--] 'python/machine.py: Fix monitor address typing'
> 008/16:[----] [--] 'python/machine.py: reorder __init__'
> 009/16:[----] [--] 'python/machine.py: Don't modify state in _base_args()'
> 010/16:[----] [--] 'python/machine.py: Handle None events in events_wait'
> 011/16:[----] [--] 'python/machine.py: use qmp.command'
> 012/16:[0010] [FC] 'python/machine.py: Add _qmp access shim'
> 013/16:[----] [-C] 'python/machine.py: fix _popen access'
> 014/16:[----] [--] 'python/qemu: make 'args' style arguments immutable'
> 015/16:[----] [--] 'iotests.py: Adjust HMP kwargs typing'
> 016/16:[----] [-C] 'python/qemu: Add mypy type annotations'
> 
>  - Rebased on "refactor shutdown" v4
>  - Fixed _qmp access for scripts that disable QMP

See:

https://travis-ci.org/github/philmd/qemu/jobs/702507625#L5439

/ # uname -a
Linux buildroot 4.5.0-2-4kc-malta #1 Debian 4.5.5-1 (2016-05-29) mips
GNU/Linux
/ # reboot
/ # reboot: Restarting system
>>> {'execute': 'quit'}
qemu received signal 9; command: "mips-softmmu/qemu-system-mips -display
none -vga none -chardev
socket,id=mon,path=/tmp/tmpcojsc5u3/qemu-14540-monitor.sock -mon
chardev=mon,mode=control -machine malta -chardev
socket,id=console,path=/tmp/tmpcojsc5u3/qemu-14540-console.sock,server,nowait
-serial chardev:console -kernel
/tmp/avocado_xgmck2k5/avocado_job_83wkzs2f/12-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_mips_malta_cpio/boot/vmlinux-4.5.0-2-4kc-malta
-initrd
/tmp/avocado_xgmck2k5/avocado_job_83wkzs2f/12-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_mips_malta_cpiorootfs.cpio
-append printk.time=0 console=ttyS0 console=tty rdinit=/sbin/init
noreboot -no-reboot"

Reproduced traceback from:
/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-packages/avocado/core/test.py:886
Traceback (most recent call last):
  File
"/home/travis/build/philmd/qemu/build/tests/acceptance/avocado_qemu/__init__.py",
line 195, in tearDown
    vm.shutdown()
  File "/home/travis/build/philmd/qemu/python/qemu/machine.py", line
457, in shutdown
    self._do_shutdown(has_quit)
  File "/home/travis/build/philmd/qemu/python/qemu/machine.py", line
434, in _do_shutdown
    self._soft_shutdown(has_quit, timeout)
  File "/home/travis/build/philmd/qemu/python/qemu/machine.py", line
414, in _soft_shutdown
    self._qmp.cmd('quit')
  File "/home/travis/build/philmd/qemu/python/qemu/qmp.py", line 271, in cmd
    return self.cmd_obj(qmp_cmd)
  File "/home/travis/build/philmd/qemu/python/qemu/qmp.py", line 249, in
cmd_obj
    self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
BrokenPipeError: [Errno 32] Broken pipe


