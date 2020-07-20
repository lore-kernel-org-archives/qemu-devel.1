Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614B4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141D220B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VE1H0hlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141D220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWZ2-000853-C3
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxWYP-0007dp-S4
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:14:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60613
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxWYN-0002IF-J5
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595254442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nk6D55s1TOf0YtayXOeaOZG3+KoELkf784HwZuqum60=;
 b=VE1H0hlM6Mzb84kTfzeuJXZIo6b8Mz2Zy/baWiRwYtHI17o4T/pyKogPSak8mUcU7hCsfn
 OHdJ0YTaADOdgWxWZZejZ2y05qCxR4zdK2Uyw38joKQKGUnezlFBmtIjrTu4oFG+ltpYPv
 m33xORBflAKAfXZS0nRUPcAdwfQOd2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-jO3bFoZvOSiFNZe-fzt1TA-1; Mon, 20 Jul 2020 10:12:35 -0400
X-MC-Unique: jO3bFoZvOSiFNZe-fzt1TA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C8BB80BCAB;
 Mon, 20 Jul 2020 14:12:34 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-119-174.rdu2.redhat.com [10.10.119.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 815FC1002391;
 Mon, 20 Jul 2020 14:12:33 +0000 (UTC)
Subject: Re: various iotests failures apparently due to overly optimistic
 timeout settings
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA_dEBT1jNLWeThhmKisFNwbaSUe+vAEEbv5bnVVb+=bjA@mail.gmail.com>
 <20200720104641.GB5541@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Message-ID: <90c29aa8-ad14-0538-0e29-c2c9c434a051@redhat.com>
Date: Mon, 20 Jul 2020 10:12:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720104641.GB5541@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:16:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 6:46 AM, Kevin Wolf wrote:
> Am 19.07.2020 um 14:07 hat Peter Maydell geschrieben:
>> I just had a bunch of iotests fail on a freebsd VM test run.
>> I think the machine the VM runs on is sometimes a bit heavily
>> loaded for I/O, which means the VM can run slowly. This causes
>> various over-optimistic timeouts in the iotest testsuite to
>> spuriously fail. I also saw the 030 failure on the netbsd VM.
>>
>> Can we try to avoid timing-sensitive tests where we can,
>> and make timeouts longer than 3 seconds where we can't, please?
>> This kind of intermittent failure makes my mergetests flaky.
> 
> John, I think this is a result of your recent python/qemu/ changes that
> make failure of graceful shutdown an error rather than just silently
> falling back to SIGKILL.
> 
> Should the default timeout be longer, should iotests override the
> default, or should iotests just always kill their VM instead of trying
> to shut it down gracefully?
> 
> Kevin
> 

Let's make it longer. Since you are seeing the failures, can you edit 
python/qemu/machine.py and find the default timeout of 3 seconds for 
shutdown() and change it to 10? 30? 60?

3 seconds was enough for me, but they shouldn't be freezing.

If there are cases where the QEMU binary is hanging or not exiting 
correctly, or it's not important that it exits correctly, we can 
override it; in those cases use vm.kill() instead of vm.shutdown().

Or, if you want to try to shut it down normally but don't care if it 
doesn't work right, you can do:

try:
     vm.shutdown()
except AbornalShutdown:
     pass

>> Relevant bits of the log below, there are several different
>> flavours of failure.
>>
>>
>>    TEST    iotest-qcow2: 030 [fail]
>> QEMU          --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
>> -nodefaults -display none -machine virt -accel qtest
>> QEMU_IMG      --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-img"
>> QEMU_IO       --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-io"
>> --cache writeback --aio threads -f qcow2
>> QEMU_NBD      --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-nbd"
>> IMGFMT        -- qcow2 (compat=1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
>> TEST_DIR      -- /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch
>> SOCK_DIR      -- /tmp/tmp.JFidXl5N
>> SOCKET_SCM_HELPER --
>>
>> --- /home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/030.out
>> 2020-07-19 09:29:05.000000000 +0000
>> +++ /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/030.out.bad
>>   2020-07-19 09:52:04.256005000 +0000
>> @@ -1,5 +1,57 @@
>> -...........................
>> +WARNING:qemu.machine:qemu received signal 9; command:
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64
>> -display none -vga none -chardev
>> socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-24906-monitor.sock -mon
>> chardev=mon,mode=control -qtest
>> unix:path=/tmp/tmp.JFidXl5N/qemu-24906-qtest.sock -accel qtest
>> -nodefaults -display none -machine virt -accel qtest -drive
>> if=virtio,id=drive0,file=blkdebug::/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch/test.img,format=qcow2,cache=writeback,aio=threads"
>> +WARNING:qemu.machine:qemu received signal 9; command:
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64
>> -display none -vga none -chardev
>> socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-24906-monitor.sock -mon
>> chardev=mon,mode=control -qtest
>> unix:path=/tmp/tmp.JFidXl5N/qemu-24906-qtest.sock -accel qtest
>> -nodefaults -display none -machine virt -accel qtest -drive
>> if=virtio,id=drive0,file=blkdebug::/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch/test.img,format=qcow2,cache=writeback,aio=threads,backing.node-name=mid,backing.backing.node-name=base"
>> +...............E......E....
>> +======================================================================
>> +ERROR: test_set_speed (__main__.TestSetSpeed)
>>   ----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 436, in _do_shutdown
>> +    self._soft_shutdown(has_quit, timeout)
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 419, in _soft_shutdown
>> +    self._popen.wait(timeout=timeout)
>> +  File "/usr/local/lib/python3.7/subprocess.py", line 1019, in wait
>> +    return self._wait(timeout=timeout)
>> +  File "/usr/local/lib/python3.7/subprocess.py", line 1645, in _wait
>> +    raise TimeoutExpired(self.args, timeout)
>> +subprocess.TimeoutExpired: Command
>> '['/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64',
>> '-display', 'none', '-vga', 'none', '-chardev',
>> 'socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-24906-monitor.sock',
>> '-mon', 'chardev=mon,mode=control', '-qtest',
>> 'unix:path=/tmp/tmp.JFidXl5N/qemu-24906-qtest.sock', '-accel',
>> 'qtest', '-nodefaults', '-display', 'none', '-machine', 'virt',
>> '-accel', 'qtest', '-drive',
>> 'if=virtio,id=drive0,file=blkdebug::/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch/test.img,format=qcow2,cache=writeback,aio=threads']'
>> timed out after 3 seconds
>> +
>> +The above exception was the direct cause of the following exception:
>> +
>> +Traceback (most recent call last):
>> +  File "030", line 900, in tearDown
>> +    self.vm.shutdown()
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 466, in shutdown
>> +    self._do_shutdown(has_quit, timeout=timeout)
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 440, in _do_shutdown
>> +    from exc
>> +qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
>> +
>> +======================================================================
>> +ERROR: test_stream_no_op (__main__.TestSingleDrive)
>> +----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 436, in _do_shutdown
>> +    self._soft_shutdown(has_quit, timeout)
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 419, in _soft_shutdown
>> +    self._popen.wait(timeout=timeout)
>> +  File "/usr/local/lib/python3.7/subprocess.py", line 1019, in wait
>> +    return self._wait(timeout=timeout)
>> +  File "/usr/local/lib/python3.7/subprocess.py", line 1645, in _wait
>> +    raise TimeoutExpired(self.args, timeout)
>> +subprocess.TimeoutExpired: Command
>> '['/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64',
>> '-display', 'none', '-vga', 'none', '-chardev',
>> 'socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-24906-monitor.sock',
>> '-mon', 'chardev=mon,mode=control', '-qtest',
>> 'unix:path=/tmp/tmp.JFidXl5N/qemu-24906-qtest.sock', '-accel',
>> 'qtest', '-nodefaults', '-display', 'none', '-machine', 'virt',
>> '-accel', 'qtest', '-drive',
>> 'if=virtio,id=drive0,file=blkdebug::/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch/test.img,format=qcow2,cache=writeback,aio=threads,backing.node-name=mid,backing.backing.node-name=base']'
>> timed out after 3 seconds
>> +
>> +The above exception was the direct cause of the following exception:
>> +
>> +Traceback (most recent call last):
>> +  File "030", line 131, in test_stream_no_op
>> +    self.vm.shutdown()
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 466, in shutdown
>> +    self._do_shutdown(has_quit, timeout=timeout)
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 440, in _do_shutdown
>> +    from exc
>> +qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
>> +
>> +----------------------------------------------------------------------
>>   Ran 27 tests
>>
>> -OK
>> +FAILED (errors=2)
>>    TEST    iotest-qcow2: 031
>>    TEST    iotest-qcow2: 032
>>    TEST    iotest-qcow2: 033
>>    TEST    iotest-qcow2: 034 [not run]
>>    TEST    iotest-qcow2: 035
>>    TEST    iotest-qcow2: 036
>>    TEST    iotest-qcow2: 037
>>    TEST    iotest-qcow2: 038 [not run]
>>    TEST    iotest-qcow2: 039 [not run]
>>    TEST    iotest-qcow2: 040 [fail]
>> QEMU          --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
>> -nodefaults -display none -machine virt -accel qtest
>> QEMU_IMG      --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-img"
>> QEMU_IO       --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-io"
>> --cache writeback --aio threads -f qcow2
>> QEMU_NBD      --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-nbd"
>> IMGFMT        -- qcow2 (compat=1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
>> TEST_DIR      -- /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch
>> SOCK_DIR      -- /tmp/tmp.JFidXl5N
>> SOCKET_SCM_HELPER --
>>
>> --- /home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/040.out
>> 2020-07-19 09:29:05.000000000 +0000
>> +++ /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/040.out.bad
>>   2020-07-19 09:55:10.837942000 +0000
>> @@ -1,5 +1,31 @@
>> -...........................................................
>> +WARNING:qemu.machine:qemu received signal 9; command:
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64
>> -display none -vga none -chardev
>> socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-27241-monitor.sock -mon
>> chardev=mon,mode=control -qtest
>> unix:path=/tmp/tmp.JFidXl5N/qemu-27241-qtest.sock -accel qtest
>> -nodefaults -display none -machine virt -accel qtest"
>> +...........................E...............................
>> +======================================================================
>> +ERROR: testIntermediateReadErrorStop (__main__.TestErrorHandling)
>>   ----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 436, in _do_shutdown
>> +    self._soft_shutdown(has_quit, timeout)
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 419, in _soft_shutdown
>> +    self._popen.wait(timeout=timeout)
>> +  File "/usr/local/lib/python3.7/subprocess.py", line 1019, in wait
>> +    return self._wait(timeout=timeout)
>> +  File "/usr/local/lib/python3.7/subprocess.py", line 1645, in _wait
>> +    raise TimeoutExpired(self.args, timeout)
>> +subprocess.TimeoutExpired: Command
>> '['/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64',
>> '-display', 'none', '-vga', 'none', '-chardev',
>> 'socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-27241-monitor.sock',
>> '-mon', 'chardev=mon,mode=control', '-qtest',
>> 'unix:path=/tmp/tmp.JFidXl5N/qemu-27241-qtest.sock', '-accel',
>> 'qtest', '-nodefaults', '-display', 'none', '-machine', 'virt',
>> '-accel', 'qtest']' timed out after 3 seconds
>> +
>> +The above exception was the direct cause of the following exception:
>> +
>> +Traceback (most recent call last):
>> +  File "040", line 687, in testIntermediateReadErrorStop
>> +    self.vm.shutdown()
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 466, in shutdown
>> +    self._do_shutdown(has_quit, timeout=timeout)
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 440, in _do_shutdown
>> +    from exc
>> +qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
>> +
>> +----------------------------------------------------------------------
>>   Ran 59 tests
>>
>> -OK
>> +FAILED (errors=1)
>>    TEST    iotest-qcow2: 041 [fail]
>> QEMU          --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
>> -nodefaults -disp
>> lay none -machine virt -accel qtest
>> QEMU_IMG      --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-img"
>> QEMU_IO       --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-io"
>> --cache writeback --aio threads -f qcow2
>> QEMU_NBD      --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-nbd"
>> IMGFMT        -- qcow2 (compat=1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
>> TEST_DIR      -- /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch
>> SOCK_DIR      -- /tmp/tmp.JFidXl5N
>> SOCKET_SCM_HELPER --
>>
>> --- /home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/041.out
>> 2020-07-19 09:29:05.000000000 +0000
>> +++ /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/041.out.bad
>>   2020-07-19 10:05:09.812434000 +0000
>> @@ -1,5 +1,29 @@
>> -........................................................................................................
>> +...........................................................................E............................
>> +======================================================================
>> +ERROR: test_pause (__main__.TestSingleDrive)
>>   ----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +  File "041", line 109, in test_pause
>> +    self.pause_job('drive0')
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/iotests.py",
>> line 978, in pause_job
>> +    return self.pause_wait(job_id)
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/iotests.py",
>> line 964, in pause_wait
>> +    result = self.vm.qmp('query-block-jobs')
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 511, in qmp
>> +    return self._qmp.cmd(cmd, args=qmp_args)
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/qmp.py",
>> line 266, in cmd
>> +    return self.cmd_obj(qmp_cmd)
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/qmp.py",
>> line 247, in cmd_obj
>> +    resp = self.__json_read()
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/qmp.py",
>> line 137, in __json_read
>> +    data = self.__sockfile.readline()
>> +  File "/usr/local/lib/python3.7/socket.py", line 589, in readinto
>> +    return self._sock.recv_into(b)
>> +  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/iotests.py",
>> line 416, in timeout
>> +    raise Exception(self.errmsg)
>> +Exception: Timeout waiting for job to pause
>> +
>> +----------------------------------------------------------------------
>>   Ran 104 tests
>>
>> -OK
>> +FAILED (errors=1)
>>
>> [...]
>>    TEST    iotest-qcow2: 156 [fail]
>> QEMU          --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
>> -nodefaults -disp
>> lay none -machine virt -accel qtest
>> QEMU_IMG      --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-img"
>> QEMU_IO       --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-io"
>> --cache writeback --aio threads -f qcow2
>> QEMU_NBD      --
>> "/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-nbd"
>> IMGFMT        -- qcow2 (compat=1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
>> TEST_DIR      -- /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch
>> SOCK_DIR      -- /tmp/tmp.JFidXl5N
>> SOCKET_SCM_HELPER --
>>
>> --- /home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/156.out
>> 2020-07-19 09:29:05.000000000 +0000
>> +++ /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/156.out.bad
>>   2020-07-19 10:14:48.438647000 +0000
>> @@ -19,48 +19,4 @@
>>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id":
>> "source"}}
>>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id":
>> "source"}}
>>   {"return": {}}
>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id":
>> "source"}}
>> -{"timestamp": {fcntl(): Bad file descriptor
>> "seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event":
>> "BLOCK_JOB_READY", "data": {"device": "source", "len": 131072,
>> "offset": 131072, "speed": 0, "type": "mirror"}}
>> -{ 'execute': 'human-monitor-command', 'arguments': { 'command-line':
>> 'qemu-io source "write -P 4 192k 64k"' } }
>> -wrote 65536/65536 bytes at offset 196608
>> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -{"return": ""}
>> -{ 'execute': 'block-job-complete', 'arguments': { 'device': 'source' } }
>> -{"return": {}}
>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id":
>> "source"}}
>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id":
>> "source"}}
>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "BLOCK_JOB_COMPLETED", "data": {"device": "source", "len":
>> 196608, "offset": 196608, "speed": 0, "type": "mirror"}}
>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id":
>> "source"}}
>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id":
>> "source"}}
>> -
>> -{ 'execute': 'human-monitor-command', 'arguments': { 'command-line':
>> 'qemu-io source "read -P 1 0k 64k"' } }
>> -read 65536/65536 bytes at offset 0
>> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -{"return": ""}
>> -{ 'execute': 'human-monitor-command', 'arguments': { 'command-line':
>> 'qemu-io source "read -P 2 64k 64k"' } }
>> -read 65536/65536 bytes at offset 65536
>> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -{"return": ""}
>> -{ 'execute': 'human-monitor-command', 'arguments': { 'command-line':
>> 'qemu-io source "read -P 3 128k 64k"' } }
>> -read 65536/65536 bytes at offset 131072
>> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -{"return": ""}
>> -{ 'execute': 'human-monitor-command', 'arguments': { 'command-line':
>> 'qemu-io source "read -P 4 192k 64k"' } }
>> -read 65536/65536 bytes at offset 196608
>> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -{"return": ""}
>> -
>> -{ 'execute': 'quit' }
>> -{"return": {}}
>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "SHUTDOWN", "data": {"guest": false, "reason":
>> "host-qmp-quit"}}
>> -
>> -read 65536/65536 bytes at offset 0
>> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -read 65536/65536 bytes at offset 65536
>> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -read 65536/65536 bytes at offset 131072
>> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -read 65536/65536 bytes at offset 196608
>> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -
>> -*** done
>> +Timeout waiting for BLOCK_JOB_READY on handle 0
>>    TEST    iotest-qcow2: 158
>>
>>
>> thanks
>> -- PMM
>>
> 
> 


