Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C913C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4ED821473
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqtOitrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ED821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDeU-0005UV-0p
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlDdN-0004Rk-At
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:36:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlDdG-0006vJ-Dx
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592321773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LUk/agWDmqH+rfLt6e5VtD+jKTeD5s30YU0Uqrmhl48=;
 b=dqtOitrUzmudZR11pk4Nn9tiJwBmKhgrKPwMd8qIJnCoTk+vtFaybTxV9/UEcoXye4F6gh
 SSLpVgSy7qHBK7/Fcy4FKnYTcHMXxYgP4EVkGfArmfOMCJgR2JU1IYMQIwV7SEBe7arwxe
 GU4G6kof/05XBpNRzuwQ/3aBlzyqOzk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-jaRBy1f-PWG7EV_E4goRrg-1; Tue, 16 Jun 2020 11:36:07 -0400
X-MC-Unique: jaRBy1f-PWG7EV_E4goRrg-1
Received: by mail-wm1-f70.google.com with SMTP id k185so1111237wme.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 08:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=LUk/agWDmqH+rfLt6e5VtD+jKTeD5s30YU0Uqrmhl48=;
 b=o+/GLS8xMlmQ+dz7yjaSGWW+Gw6OoAkWOM9vkZK33DA2LR7iIBVHXLW+yNHcCieqX3
 X6VCx4zK0fPjuXiyHrmmqt6P7JiHnSh/02rlUhSWjM35Aly00kk7/IC6vajadEFsS4WU
 sOMdMBKxMqbCCDTXpTafEAh0/bu/reYMfHXdxf1LhnraeXLiHo1/fHQJVrmEKFvS92wM
 EBbvvEkG9DSU7QJiXPtZh5whq2fBZiVFSD53P1gM/r55im2kphSDlDihi91HdKsOJdCz
 5bObnwnARHpnx21+tEXtpUxLOWXeoSbpTDHU7Yv5n2YCz9d/wXS5Xbk/LgQvA4mCdcio
 aiIw==
X-Gm-Message-State: AOAM532dzKKsZBUI9Wm41kd9vngx7imWroMi+a/q/geDg4v3GzUaquq8
 xZML3AiBtZmx5WduTV38eY2s92SurXnFZEmPh+K9uNqFlOR/GSnyVovY9+R1aabdEEb7ptIqdCO
 T/YqjcPV5G38a1nE=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr3708789wma.36.1592321766766; 
 Tue, 16 Jun 2020 08:36:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyr5ohOfDUfoPJLmPBL+m+AqOOxNBHQT/Ot/Ff/ftMN/WPsuCcNkl7WfbBhXEQBRiTZtqAEmQ==
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr3708756wma.36.1592321766447; 
 Tue, 16 Jun 2020 08:36:06 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id z8sm29257519wru.33.2020.06.16.08.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 08:36:05 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] python/machine.py: refactor shutdown
To: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20200604195252.20739-1-jsnow@redhat.com>
 <8bd27ec8-1bb6-45e2-a43a-7e0229065414@redhat.com>
 <4012de28-5837-889a-eda1-b9957cbbbad1@redhat.com>
 <5d20012b-923c-0bf4-232d-272977087fe3@redhat.com>
 <20200615222152.GT2366737@habkost.net>
 <85b19f6a-5521-4672-b146-89be361527e6@redhat.com>
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
Message-ID: <4600209a-dca8-b194-9ec1-3d143be1a9a9@redhat.com>
Date: Tue, 16 Jun 2020 17:36:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <85b19f6a-5521-4672-b146-89be361527e6@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 5:06 PM, John Snow wrote:
> 
> 
> On 6/15/20 6:21 PM, Eduardo Habkost wrote:
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
>>
>> Looks good to me.
>>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>
>>
>>>
>>>>              self._qmp.close()
>>>>
>>>>          self._popen.wait(timeout=timeout)
>>>>
>>>
>>
> 
> I'll respin with the fix squashed.

Not needed, it is here already:
https://gitlab.com/philmd/qemu/-/commit/d95ff1cf5d47f96d
I was waiting the build to success to respond to this
thread.

> 
> Thanks!
> 
> --js
> 


