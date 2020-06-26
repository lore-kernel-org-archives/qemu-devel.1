Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB108C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A32C20663
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJXLs5RE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A32C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1josAX-0003Pe-Pj
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jos9i-0002gl-O6
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:28:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jos9f-0002PD-H9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593192526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1EX+NkXGDApOp8HjmFIVOHRreaYh984gCVnC/a/Ng58=;
 b=PJXLs5RECwPkVBFzm5TtsrVZbrnS/vQzAs4p1yY89diKCzP6AhY8m7kbuc88tWpswWjPlB
 tJIfliiAS3P9NL+W+J1tplexUJv0tDvI5Umf6qhUMGmwMG9nWO0l8kfP015/3NWG8joI3z
 u+DHKehbpHCJ5vMlQVFd03k4btRwUHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-_IvJGOlFOI6dUkDyZqjiJQ-1; Fri, 26 Jun 2020 13:28:39 -0400
X-MC-Unique: _IvJGOlFOI6dUkDyZqjiJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6828804001
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 17:28:38 +0000 (UTC)
Received: from [10.10.119.184] (ovpn-119-184.rdu2.redhat.com [10.10.119.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D495D19C4F;
 Fri, 26 Jun 2020 17:28:37 +0000 (UTC)
Subject: Re: [PATCH v3 0/3] python/machine.py: refactor shutdown
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20200604195252.20739-1-jsnow@redhat.com>
 <8bd27ec8-1bb6-45e2-a43a-7e0229065414@redhat.com>
 <4012de28-5837-889a-eda1-b9957cbbbad1@redhat.com>
 <5d20012b-923c-0bf4-232d-272977087fe3@redhat.com>
 <20200616214900.GA347659@localhost.localdomain>
 <fd9c8f22-77fe-9689-9445-416fad9ff0fa@redhat.com>
 <19227083-5e99-e08f-4a6d-8d2edcdeacf8@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0f71e4b6-a9d4-9335-9071-e3fcc42a3aca@redhat.com>
Date: Fri, 26 Jun 2020 13:28:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <19227083-5e99-e08f-4a6d-8d2edcdeacf8@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
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
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/20/20 6:14 AM, Philippe Mathieu-Daudé wrote:
> On 6/17/20 7:13 PM, Philippe Mathieu-DaudÃ© wrote:
>> On 6/16/20 11:49 PM, Cleber Rosa wrote:
>>> On Mon, Jun 15, 2020 at 05:21:18PM +0200, Philippe Mathieu-DaudÃ© wrote:
>>>> On 6/9/20 11:55 PM, John Snow wrote:
>>>>>
>>>>>
>>>>> On 6/9/20 9:08 AM, Philippe Mathieu-DaudÃ© wrote:
>>>>>> Hi John,
>>>>>>
>>>>>> On 6/4/20 9:52 PM, John Snow wrote:
>>>>>>> v3:
>>>>>>>  - Split _post_shutdown refactor into own patch (now 1/3)
>>>>>>>  - Re-add sigkill warning squelch (now 3/3)
>>>>>>>
>>>>>>> NOTE: I re-added the squelch in its own patch for review purposes, but
>>>>>>> for the purposes of avoiding temporary breakage, a maintainer may wish
>>>>>>> to squash patches 2 and 3 if they are accepted.
>>>>>>>
>>>>>>> v2: Philippe took patches 1, 3 and 4.
>>>>>>>
>>>>>>> This is a re-write of what was:
>>>>>>> [PATCH RFC 03/32] python//machine.py: remove bare except
>>>>>>> [PATCH 2/4] python/machine.py: remove bare except
>>>>>>>
>>>>>>> It's a bit heavier handed, but it should address some of kwolf's
>>>>>>> feedback from the RFC version.
>>>>>>>
>>>>>>> Applies straight to origin/master, ought to pass pylint and flake8:
>>>>>>>
>>>>>>>> cd ~/src/qemu/python/qemu
>>>>>>>> pylint *.py
>>>>>>>> flake8 *.py
>>>>>>>
>>>>>>> John Snow (3):
>>>>>>>   python/machine.py: consolidate _post_shutdown()
>>>>>>>   python/machine.py: refactor shutdown
>>>>>>>   python/machine.py: re-add sigkill warning suppression
>>>>>>>
>>>>>>>  python/qemu/machine.py | 100 +++++++++++++++++++++++++++++------------
>>>>>>>  1 file changed, 71 insertions(+), 29 deletions(-)
>>>>>>>
>>>>>>
>>>>>> I'm now seeing this error:
>>>>>>
>>>>>> 21:31:58 DEBUG| / # reboot
>>>>>> 21:32:01 DEBUG| / # reboot: Restarting system
>>>>>> 21:32:01 DEBUG| >>> {'execute': 'quit'}
>>>>>> 21:32:01 WARNI| qemu received signal 9; command:
>>>>>> "mips-softmmu/qemu-system-mips -display none -vga none -chardev
>>>>>> socket,id=mon,path=/tmp/tmp679upvrk/qemu-10292-monitor.sock -mon
>>>>>> chardev=mon,mode=control -machine malta -chardev
>>>>>> socket,id=console,path=/tmp/tmp679upvrk/qemu-10292-console.sock,server,nowait
>>>>>> -serial chardev:console -kernel
>>>>>> /tmp/avocado_b3aaagr9/avocado_job_5bj0xe1h/12-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_mips_malta_cpio/boot/vmlinux-4.5.0-2-4kc-malta
>>>>>> -initrd
>>>>>> /tmp/avocado_b3aaagr9/avocado_job_5bj0xe1h/12-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_mips_malta_cpiorootfs.cpio
>>>>>> -append printk.time=0 console=ttyS0 console=tty rdinit=/sbin/init
>>>>>> noreboot -no-reboot"
>>>>>> 21:32:01 ERROR|
>>>>>> 21:32:01 ERROR| Reproduced traceback from:
>>>>>> /home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-packages/avocado/core/test.py:886
>>>>>> 21:32:01 ERROR| Traceback (most recent call last):
>>>>>> 21:32:01 ERROR|   File
>>>>>> "/home/travis/build/philmd/qemu/build/tests/acceptance/avocado_qemu/__init__.py",
>>>>>> line 195, in tearDown
>>>>>> 21:32:01 ERROR|     vm.shutdown()
>>>>>> 21:32:01 ERROR|   File
>>>>>> "/home/travis/build/philmd/qemu/python/qemu/machine.py", line 449, in
>>>>>> shutdown
>>>>>> 21:32:01 ERROR|     self._do_shutdown(has_quit)
>>>>>> 21:32:01 ERROR|   File
>>>>>> "/home/travis/build/philmd/qemu/python/qemu/machine.py", line 426, in
>>>>>> _do_shutdown
>>>>>> 21:32:01 ERROR|     self._soft_shutdown(has_quit, timeout)
>>>>>> 21:32:01 ERROR|   File
>>>>>> "/home/travis/build/philmd/qemu/python/qemu/machine.py", line 413, in
>>>>>> _soft_shutdown
>>>>>> 21:32:01 ERROR|     self._qmp.cmd('quit')
>>>>>> 21:32:01 ERROR|   File
>>>>>> "/home/travis/build/philmd/qemu/python/qemu/qmp.py", line 271, in cmd
>>>>>> 21:32:01 ERROR|     return self.cmd_obj(qmp_cmd)
>>>>>> 21:32:01 ERROR|   File
>>>>>> "/home/travis/build/philmd/qemu/python/qemu/qmp.py", line 249, in cmd_obj
>>>>>> 21:32:01 ERROR|     self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
>>>>>> 21:32:01 ERROR| BrokenPipeError: [Errno 32] Broken pipe
>>>>>> 21:32:01 ERROR|
>>>>>> 21:32:01 DEBUG| DATA (filename=output.expected) => NOT FOUND (data
>>>>>> sources: variant, test, file)
>>>>>> 21:32:01 DEBUG| DATA (filename=stdout.expected) => NOT FOUND (data
>>>>>> sources: variant, test, file)
>>>>>> 21:32:01 DEBUG| DATA (filename=stderr.expected) => NOT FOUND (data
>>>>>> sources: variant, test, file)
>>>>>> 21:32:01 DEBUG| Not logging /var/log/syslog (lack of permissions)
>>>>>> 21:32:01 ERROR| ERROR
>>>>>> 12-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_malta_cpio
>>>>>> -> TestSetupFail: [Errno 32] Broken pipe
>>>>>> 21:32:01 INFO |
>>>>>>
>>>>>> https://travis-ci.org/github/philmd/qemu/jobs/696142277#L5329
>>>>>>
>>>>>
>>>>> Gotcha.
>>>>>
>>>>> The problem here is that `test_mips_malta_cpio` in boot_linux_console.py
>>>>> does this:
>>>>>
>>>>>         self.vm.add_args('-kernel', kernel_path,
>>>>>                          '-initrd', initrd_path,
>>>>>                          '-append', kernel_command_line,
>>>>>                          '-no-reboot')
>>>>>
>>>>> and then:
>>>>>
>>>>> exec_command_and_wait_for_pattern(self, 'reboot',
>>>>>                          'reboot: Restarting system')
>>>>>
>>>>> and (in avocado_qemu/) __init__.py does this:
>>>>>
>>>>>     def tearDown(self):
>>>>>         for vm in self._vms.values():
>>>>>             vm.shutdown()
>>>>>
>>>>>
>>>>>
>>>>> What's happening here is that we are instructing QEMU to *close* when
>>>>> the guest reboots instead of allowing it to reboot. Then, we are issuing
>>>>> a reboot command to the guest, which will effectively terminate QEMU as
>>>>> well. Finally, we are trying to send a shutdown command to QEMU, but
>>>>> QEMU has already gone.
>>>>>
>>>>> Now, in the shutdown code, we do make an attempt to catch this:
>>>>>
>>>>> def is_running(self):
>>>>>     """Returns true if the VM is running."""
>>>>>     return self._popen is not None and self._popen.poll() is None
>>>>>
>>>>> But, well, race conditions.
>>>>>
>>>>> When we make it here:
>>>>>
>>>>>         if self._qmp is not None:
>>>>>             if not has_quit:
>>>>>                 self._qmp.cmd('quit')
>>>>>             self._qmp.close()
>>>>>
>>>>> We believe we are running and we believe we have an open QMP socket.
>>>>> Attempting to engage the socket by sending 'quit' causes the error.
>>>>>
>>>>> It's a tight window: if quit happens earlier, we send the command
>>>>> successfully and everything's OK. If quit happens later, we realize QEMU
>>>>> isn't running and proceed to cleanup.
>>>>
>>>> Nice debugging :)
>>>>
>>>>>
>>>>> Ultimately:
>>>>>
>>>>> - Avocado should not try to shut down QEMU twice, but
>>>>> - machine.py shouldn't enable the race condition either.
>>>>>
>>>>>
>>>>>
>>>>> for my part, how about this:
>>>>>
>>>>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>>>>> index 99bcb499878..813f8e477db 100644
>>>>> --- a/python/qemu/machine.py
>>>>> +++ b/python/qemu/machine.py
>>>>> @@ -385,7 +385,14 @@ def _soft_shutdown(self, has_quit: bool = False,
>>>>> timeout: int = 3) -> None:
>>>>>
>>>>>          if self._qmp is not None:
>>>>>              if not has_quit:
>>>>> -                self._qmp.cmd('quit')
>>>>> +                try:
>>>>> +                    self._qmp.cmd('quit')
>>>>> +                except (BrokenPipeError, ConnectionResetError):
>>>>> +                    # QMP went away just before or just after sending
>>>>> 'quit'
>>>>> +                    if not self.is_running():
>>>>> +                        # "Mission Accomplished"
>>>>> +                        pass
>>>>> +                    raise
>>>>
>>>> Looks OK to me, Cleber/Eduardo can you Ack?
>>>>
>>>
>>> John's description seems spot on, and so does the solution.  I was
>>> unable, though, to reproduce it given that the window is indeed tiny.
> 
> Still doesn't work...
> https://travis-ci.org/github/philmd/qemu/jobs/700309163#L5445
> 
I have overlooked a very fundamental mistake!

'pass' does not terminate execution of an exception handler...

It needs to be:

except (BrokenPipeError, ConnectionResetError):
    if self.is_running():
        raise

Will re-spin, sorry about that.

--js


