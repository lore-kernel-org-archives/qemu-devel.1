Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FB3C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 10:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062D320771
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 10:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZasvTodK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062D320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmaXH-0006zk-9k
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 06:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmaWa-0006TD-0h
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 06:15:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36833
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmaWW-00076v-Pd
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 06:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592648094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RPpXWtxZ2F65qCO5zwG4/584v4MxDd55WsQzSYEVzl8=;
 b=ZasvTodKEKr8S/Ox8jngQMskdy2WwSov3zYFb4OgrqUXP1+mxbfy0cPiH0nvzAwKlCYec+
 VMMgcwqE/npUWFL95bwOKZN+8NYtWRqca27obZnepIheEOY1LalMa3chiTd+9+LpcJxMfS
 +jnvi6+EPSU0DGkJHIM2j+ocRlVW1+M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-21sZU4Y6O2Gq5Tra1JC3NA-1; Sat, 20 Jun 2020 06:14:51 -0400
X-MC-Unique: 21sZU4Y6O2Gq5Tra1JC3NA-1
Received: by mail-wr1-f72.google.com with SMTP id h6so6282081wrx.4
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 03:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=nq5dCbLdsz5d9qGiNIqUIi10oLk1XLrcfpHYmxKQnxs=;
 b=Oml9iwpW8gKnt6fM/d1TOGD8fQeF2i4Sczshr5WAwpBubKipE3nF71PPE9q8QxJGwg
 34dsC00w0yFvOCO1DmL2kKFFNvrcZ5Z2oBMOhWXwjvGwzUztXGTWN224XZEUAS0YPKl6
 awjtD1X7TsT97OfEjiNk+ImbXb0ATxI1hpEQ6HaijBQsp/PvoxvFN8AA4KaGe9UdHWcs
 0UuZOFiXbrqEXX3K/wYGmMfMw37AwlwKNo/EGxq62RWVizhYN69odKbkrgZVj4qRHLpQ
 kEs1I4PHHB+YHd/2YjVqBWcENLx6C+tEV1pGmGl6XR0ogBLQ2l/n/VI5JQqS4NB9ji64
 gciA==
X-Gm-Message-State: AOAM532XF71jR4C/jyS9x+BC9HTc/ToN9wVcLe34IBMYMgPfqMjkSdcs
 0sbAUyf1QyPrACgrldA/JZhf7i0vWeDz2027uSZdWCXoxhp5ABOf7Z6s6qFte26/SaOF1zexSPX
 vnTL1wnniJpQjRlk=
X-Received: by 2002:a5d:4446:: with SMTP id x6mr8239174wrr.119.1592648088805; 
 Sat, 20 Jun 2020 03:14:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp4wtlLLBx/Vm9nj4sqwmUydLEDNmzLgAfskfCg7LjL+oRvkpQD9AIqFApLXUuMlbj4fP11w==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr8239152wrr.119.1592648088493; 
 Sat, 20 Jun 2020 03:14:48 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id t5sm4091108wmj.37.2020.06.20.03.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jun 2020 03:14:47 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] python/machine.py: refactor shutdown
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
References: <20200604195252.20739-1-jsnow@redhat.com>
 <8bd27ec8-1bb6-45e2-a43a-7e0229065414@redhat.com>
 <4012de28-5837-889a-eda1-b9957cbbbad1@redhat.com>
 <5d20012b-923c-0bf4-232d-272977087fe3@redhat.com>
 <20200616214900.GA347659@localhost.localdomain>
 <fd9c8f22-77fe-9689-9445-416fad9ff0fa@redhat.com>
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
Message-ID: <19227083-5e99-e08f-4a6d-8d2edcdeacf8@redhat.com>
Date: Sat, 20 Jun 2020 12:14:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <fd9c8f22-77fe-9689-9445-416fad9ff0fa@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 04:14:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 7:13 PM, Philippe Mathieu-Daudé wrote:
> On 6/16/20 11:49 PM, Cleber Rosa wrote:
>> On Mon, Jun 15, 2020 at 05:21:18PM +0200, Philippe Mathieu-Daudé wrote:
>>> On 6/9/20 11:55 PM, John Snow wrote:
>>>>
>>>>
>>>> On 6/9/20 9:08 AM, Philippe Mathieu-Daudé wrote:
>>>>> Hi John,
>>>>>
>>>>> On 6/4/20 9:52 PM, John Snow wrote:
>>>>>> v3:
>>>>>>  - Split _post_shutdown refactor into own patch (now 1/3)
>>>>>>  - Re-add sigkill warning squelch (now 3/3)
>>>>>>
>>>>>> NOTE: I re-added the squelch in its own patch for review purposes, but
>>>>>> for the purposes of avoiding temporary breakage, a maintainer may wish
>>>>>> to squash patches 2 and 3 if they are accepted.
>>>>>>
>>>>>> v2: Philippe took patches 1, 3 and 4.
>>>>>>
>>>>>> This is a re-write of what was:
>>>>>> [PATCH RFC 03/32] python//machine.py: remove bare except
>>>>>> [PATCH 2/4] python/machine.py: remove bare except
>>>>>>
>>>>>> It's a bit heavier handed, but it should address some of kwolf's
>>>>>> feedback from the RFC version.
>>>>>>
>>>>>> Applies straight to origin/master, ought to pass pylint and flake8:
>>>>>>
>>>>>>> cd ~/src/qemu/python/qemu
>>>>>>> pylint *.py
>>>>>>> flake8 *.py
>>>>>>
>>>>>> John Snow (3):
>>>>>>   python/machine.py: consolidate _post_shutdown()
>>>>>>   python/machine.py: refactor shutdown
>>>>>>   python/machine.py: re-add sigkill warning suppression
>>>>>>
>>>>>>  python/qemu/machine.py | 100 +++++++++++++++++++++++++++++------------
>>>>>>  1 file changed, 71 insertions(+), 29 deletions(-)
>>>>>>
>>>>>
>>>>> I'm now seeing this error:
>>>>>
>>>>> 21:31:58 DEBUG| / # reboot
>>>>> 21:32:01 DEBUG| / # reboot: Restarting system
>>>>> 21:32:01 DEBUG| >>> {'execute': 'quit'}
>>>>> 21:32:01 WARNI| qemu received signal 9; command:
>>>>> "mips-softmmu/qemu-system-mips -display none -vga none -chardev
>>>>> socket,id=mon,path=/tmp/tmp679upvrk/qemu-10292-monitor.sock -mon
>>>>> chardev=mon,mode=control -machine malta -chardev
>>>>> socket,id=console,path=/tmp/tmp679upvrk/qemu-10292-console.sock,server,nowait
>>>>> -serial chardev:console -kernel
>>>>> /tmp/avocado_b3aaagr9/avocado_job_5bj0xe1h/12-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_mips_malta_cpio/boot/vmlinux-4.5.0-2-4kc-malta
>>>>> -initrd
>>>>> /tmp/avocado_b3aaagr9/avocado_job_5bj0xe1h/12-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_mips_malta_cpiorootfs.cpio
>>>>> -append printk.time=0 console=ttyS0 console=tty rdinit=/sbin/init
>>>>> noreboot -no-reboot"
>>>>> 21:32:01 ERROR|
>>>>> 21:32:01 ERROR| Reproduced traceback from:
>>>>> /home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-packages/avocado/core/test.py:886
>>>>> 21:32:01 ERROR| Traceback (most recent call last):
>>>>> 21:32:01 ERROR|   File
>>>>> "/home/travis/build/philmd/qemu/build/tests/acceptance/avocado_qemu/__init__.py",
>>>>> line 195, in tearDown
>>>>> 21:32:01 ERROR|     vm.shutdown()
>>>>> 21:32:01 ERROR|   File
>>>>> "/home/travis/build/philmd/qemu/python/qemu/machine.py", line 449, in
>>>>> shutdown
>>>>> 21:32:01 ERROR|     self._do_shutdown(has_quit)
>>>>> 21:32:01 ERROR|   File
>>>>> "/home/travis/build/philmd/qemu/python/qemu/machine.py", line 426, in
>>>>> _do_shutdown
>>>>> 21:32:01 ERROR|     self._soft_shutdown(has_quit, timeout)
>>>>> 21:32:01 ERROR|   File
>>>>> "/home/travis/build/philmd/qemu/python/qemu/machine.py", line 413, in
>>>>> _soft_shutdown
>>>>> 21:32:01 ERROR|     self._qmp.cmd('quit')
>>>>> 21:32:01 ERROR|   File
>>>>> "/home/travis/build/philmd/qemu/python/qemu/qmp.py", line 271, in cmd
>>>>> 21:32:01 ERROR|     return self.cmd_obj(qmp_cmd)
>>>>> 21:32:01 ERROR|   File
>>>>> "/home/travis/build/philmd/qemu/python/qemu/qmp.py", line 249, in cmd_obj
>>>>> 21:32:01 ERROR|     self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
>>>>> 21:32:01 ERROR| BrokenPipeError: [Errno 32] Broken pipe
>>>>> 21:32:01 ERROR|
>>>>> 21:32:01 DEBUG| DATA (filename=output.expected) => NOT FOUND (data
>>>>> sources: variant, test, file)
>>>>> 21:32:01 DEBUG| DATA (filename=stdout.expected) => NOT FOUND (data
>>>>> sources: variant, test, file)
>>>>> 21:32:01 DEBUG| DATA (filename=stderr.expected) => NOT FOUND (data
>>>>> sources: variant, test, file)
>>>>> 21:32:01 DEBUG| Not logging /var/log/syslog (lack of permissions)
>>>>> 21:32:01 ERROR| ERROR
>>>>> 12-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_malta_cpio
>>>>> -> TestSetupFail: [Errno 32] Broken pipe
>>>>> 21:32:01 INFO |
>>>>>
>>>>> https://travis-ci.org/github/philmd/qemu/jobs/696142277#L5329
>>>>>
>>>>
>>>> Gotcha.
>>>>
>>>> The problem here is that `test_mips_malta_cpio` in boot_linux_console.py
>>>> does this:
>>>>
>>>>         self.vm.add_args('-kernel', kernel_path,
>>>>                          '-initrd', initrd_path,
>>>>                          '-append', kernel_command_line,
>>>>                          '-no-reboot')
>>>>
>>>> and then:
>>>>
>>>> exec_command_and_wait_for_pattern(self, 'reboot',
>>>>                          'reboot: Restarting system')
>>>>
>>>> and (in avocado_qemu/) __init__.py does this:
>>>>
>>>>     def tearDown(self):
>>>>         for vm in self._vms.values():
>>>>             vm.shutdown()
>>>>
>>>>
>>>>
>>>> What's happening here is that we are instructing QEMU to *close* when
>>>> the guest reboots instead of allowing it to reboot. Then, we are issuing
>>>> a reboot command to the guest, which will effectively terminate QEMU as
>>>> well. Finally, we are trying to send a shutdown command to QEMU, but
>>>> QEMU has already gone.
>>>>
>>>> Now, in the shutdown code, we do make an attempt to catch this:
>>>>
>>>> def is_running(self):
>>>>     """Returns true if the VM is running."""
>>>>     return self._popen is not None and self._popen.poll() is None
>>>>
>>>> But, well, race conditions.
>>>>
>>>> When we make it here:
>>>>
>>>>         if self._qmp is not None:
>>>>             if not has_quit:
>>>>                 self._qmp.cmd('quit')
>>>>             self._qmp.close()
>>>>
>>>> We believe we are running and we believe we have an open QMP socket.
>>>> Attempting to engage the socket by sending 'quit' causes the error.
>>>>
>>>> It's a tight window: if quit happens earlier, we send the command
>>>> successfully and everything's OK. If quit happens later, we realize QEMU
>>>> isn't running and proceed to cleanup.
>>>
>>> Nice debugging :)
>>>
>>>>
>>>> Ultimately:
>>>>
>>>> - Avocado should not try to shut down QEMU twice, but
>>>> - machine.py shouldn't enable the race condition either.
>>>>
>>>>
>>>>
>>>> for my part, how about this:
>>>>
>>>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>>>> index 99bcb499878..813f8e477db 100644
>>>> --- a/python/qemu/machine.py
>>>> +++ b/python/qemu/machine.py
>>>> @@ -385,7 +385,14 @@ def _soft_shutdown(self, has_quit: bool = False,
>>>> timeout: int = 3) -> None:
>>>>
>>>>          if self._qmp is not None:
>>>>              if not has_quit:
>>>> -                self._qmp.cmd('quit')
>>>> +                try:
>>>> +                    self._qmp.cmd('quit')
>>>> +                except (BrokenPipeError, ConnectionResetError):
>>>> +                    # QMP went away just before or just after sending
>>>> 'quit'
>>>> +                    if not self.is_running():
>>>> +                        # "Mission Accomplished"
>>>> +                        pass
>>>> +                    raise
>>>
>>> Looks OK to me, Cleber/Eduardo can you Ack?
>>>
>>
>> John's description seems spot on, and so does the solution.  I was
>> unable, though, to reproduce it given that the window is indeed tiny.

Still doesn't work...
https://travis-ci.org/github/philmd/qemu/jobs/700309163#L5445

>>
>> Phil,
>>
>> In addition to this, wouldn't it make sense to:
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> index 3d02519660..e117597e3b 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -180,8 +180,8 @@ class BootLinuxConsole(LinuxKernelTest):
>>                                 + 'rdinit=/sbin/init noreboot')
>>          self.vm.add_args('-kernel', kernel_path,
>>                           '-initrd', initrd_path,
>> -                         '-append', kernel_command_line,
>> -                         '-no-reboot')
>> +                         '-append', kernel_command_line)
> 
> Very few machines implement the hardware shutdown (sending
> the SHUTDOWN_CAUSE_GUEST_SHUTDOWN event). AFAIK The
> SHUTDOWN_CAUSE_GUEST_RESET is a bit more present.
> When the hardware doesn't model this, the guest loops
> infinitely. Some physical machines are not supposed to
> power off, until cutting its power. So firmware also loops
> without trying to power things off.
> 
> '-no-reboot' means "if the guest tries to reboot, consider
> the emulation done".
> 
>> +
>>          self.vm.launch()
>>          self.wait_for_console_pattern('Boot successful.')
>>  
>> @@ -189,8 +189,8 @@ class BootLinuxConsole(LinuxKernelTest):
>>                                                  'BogoMIPS')
>>          exec_command_and_wait_for_pattern(self, 'uname -a',
>>                                                  'Debian')
>> -        exec_command_and_wait_for_pattern(self, 'reboot',
>> -                                                'reboot: Restarting system')
>> +        exec_command_and_wait_for_pattern(self, 'halt',
>> +                                                'reboot: System halted')
>>  
>>      @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
>>      def test_mips64el_malta_5KEc_cpio(self):
>>
>> Do you know of any reason to "fake halt" (reboot) instead of actually
>> halting from the guests?
> 
> This might be my embedded system reflex (explained earlier, some
> hardware can not power itself down). I will give your diff a try.
> 
>>
>>>>              self._qmp.close()
>>>>
>>>>          self._popen.wait(timeout=timeout)
>>>>
>>>
>>
>> Either way (^ with this extra block):
>>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> Tested-by: Cleber Rosa <crosa@redhat.com>
> 
> Thanks!
> 


