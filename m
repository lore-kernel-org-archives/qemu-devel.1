Received: from eggs.gnu.org ([2001:4830:134:3::10]:53487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJKL8-0004Tu-Eh
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 08:20:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJKL6-0006rq-UL
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 08:20:22 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:33283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cJKL6-0006rA-P5
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 08:20:20 -0500
Received: by mail-it0-x242.google.com with SMTP id c20so13813037itb.0
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 05:20:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <002501d25ab1$af024b00$0d06e100$@ru>
References: <000301d259dc$f9d097c0$ed71c740$@ru>
	<000601d25a95$12b1b9f0$38152dd0$@ru>
	<20161220102126.GE5602@stefanha-x1.localdomain>
	<002501d25ab1$af024b00$0d06e100$@ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 20 Dec 2016 13:20:19 +0000
Message-ID: <CAJSP0QUPnYp4W7PJtNqiXsstPg6RUu=1x_v74_Qov53B8LzYCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-2.8-rc4 is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, Dec 20, 2016 at 11:10 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
>> On Tue, Dec 20, 2016 at 10:45:44AM +0300, Pavel Dovgalyuk wrote:
>> > It also fails much earlier when I enable logs with "-d int -D log".
>> >
>> > Here is backtrace for this failure:
>> >
>> >
>> >
>> > #0  0x0000000076e79e52 in ntdll!EtwpCreateEtwThread ()
>> >
>> >    from /c/Windows/SYSTEM32/ntdll.dll
>> >
>> > #1  0x0000000076e56965 in ntdll!EtwEventSetInformation ()
>> >
>> >    from /c/Windows/SYSTEM32/ntdll.dll
>> >
>> > #2  0x0000000076e942d9 in ntdll!RtlLogStackBackTrace ()
>> >
>> >    from /c/Windows/SYSTEM32/ntdll.dll
>> >
>> > #3  0x0000000076e3797c in ntdll!TpAlpcRegisterCompletionList ()
>> >
>> >    from /c/Windows/SYSTEM32/ntdll.dll
>> >
>> > #4  0x000007fefdc810c8 in msvcrt!free () from /c/Windows/system32/msvcrt.dll
>>
>> Looks like a heap corruption bug since free() is failing.
>
> Seems to be a race condition.
> When I add logs into invalidate_page_bitmap, the bug disappears.
> It seems that someone tries to free the same page bitmap twice and simultaneously.

It definitely looks like the locking is incomplete in this code path.
tb_lock() does nothing in a softmmu build.

Alex: Is this bug due to missing MTTCG patches in QEMU 2.8?

>
> Here is the stack trace for two threads at the moment when qemu fails:
> Failed thread:
> #0  0x0000000076e79e52 in ntdll!EtwpCreateEtwThread ()
>    from /c/Windows/SYSTEM32/ntdll.dll
> #1  0x0000000076e56965 in ntdll!EtwEventSetInformation ()
>    from /c/Windows/SYSTEM32/ntdll.dll
> #2  0x0000000076e942d9 in ntdll!RtlLogStackBackTrace ()
>    from /c/Windows/SYSTEM32/ntdll.dll
> #3  0x0000000076e3797c in ntdll!TpAlpcRegisterCompletionList ()
>    from /c/Windows/SYSTEM32/ntdll.dll
> #4  0x000007fefdc810c8 in msvcrt!free () from /c/Windows/system32/msvcrt.dll
> #5  0x000000000040c57d in invalidate_page_bitmap (p=<optimized out>,
>     p=<optimized out>) at D:/Projects/QEMU/qemu/translate-all.c:881
> #6  tb_invalidate_phys_page_range (start=826113, end=end@entry=826116,
>     is_cpu_write_access=is_cpu_write_access@entry=0)
>     at D:/Projects/QEMU/qemu/translate-all.c:1527
> #7  0x000000000040c5ed in tb_invalidate_phys_range_1 (end=826116,
>     start=<optimized out>) at D:/Projects/QEMU/qemu/translate-all.c:1414
> #8  tb_invalidate_phys_range (start=start@entry=826113, end=end@entry=826116)
>     at D:/Projects/QEMU/qemu/translate-all.c:1424
> #9  0x0000000000402e5f in invalidate_and_set_dirty (mr=mr@entry=0x569e980,
>     addr=<optimized out>, length=<optimized out>)
>     at D:/Projects/QEMU/qemu/exec.c:2511
> #10 0x0000000000406af7 in cpu_physical_memory_write_rom_internal (
>     type=WRITE_DATA, len=3, buf=0x22f411 "", addr=826113,
>     as=0xab4280 <address_space_memory>) at D:/Projects/QEMU/qemu/exec.c:2795
> <and more>
>
> Another thread:
> #0  0x00000000007411b0 in g_free ()
> #1  0x000000000040b6b4 in invalidate_page_bitmap (p=0x1143f738, p=0x1143f738)
>     at D:/Projects/QEMU/qemu/translate-all.c:881
> #2  page_flush_tb_1 (level=level@entry=0, lp=0x5715058)
>     at D:/Projects/QEMU/qemu/translate-all.c:900
> #3  0x000000000040b6ee in page_flush_tb_1 (level=1, lp=0xac8ac0 <l1_map>)
>     at D:/Projects/QEMU/qemu/translate-all.c:906
> #4  0x000000000040b7b3 in page_flush_tb ()
>     at D:/Projects/QEMU/qemu/translate-all.c:916
> #5  do_tb_flush (cpu=<optimized out>, tb_flush_count=...)
>     at D:/Projects/QEMU/qemu/translate-all.c:954
> #6  0x0000000000519ac1 in process_queued_cpu_work (cpu=0x5632fd0)
>     at cpus-common.c:338
> #7  0x0000000000439761 in qemu_wait_io_event_common (cpu=0x5632fd0)
>     at D:/Projects/QEMU/qemu/cpus.c:942
> #8  qemu_tcg_wait_io_event (cpu=<optimized out>)
>     at D:/Projects/QEMU/qemu/cpus.c:957
> #9  qemu_tcg_cpu_thread_fn (arg=arg@entry=0x5632fd0)
>     at D:/Projects/QEMU/qemu/cpus.c:1216
> #10 0x000000000072c285 in win32_start_routine (arg=0x565ba40)
>     at util/qemu-thread-win32.c:406
> #11 0x000007fefdc8415f in srand () from /c/Windows/system32/msvcrt.dll
> #12 0x000007fefdc86ebd in msvcrt!_ftime64_s ()
> <and more>
>
>>
>> QEMU 2.8.0 is scheduled for release today.  I have checked that
>> qemu-system-i386.exe works but without playing an MP3 file in Windows
>> XP.
>>
>> I plan to go ahead with the release unless information becomes available
>> that suggests it affects more than just this one scenario.
>
>> >
>> >
>> > I encountered the following bug with the latest version of QEMU.
>> >
>> > I use windows host and start qemu with the following command line:
>> >
>> > qemu-system-i386.exe -soundhw ac97 -snapshot -hda disk.qcow2 -net none
>> >
>> >
>> >
>> > Guest system is Windows XP 32-bit. It founds new hardware (including audio controller)
>> >
>> > and I start playing mp3 file.
>> >
>> > After seconds of playing qemu fails with an exception.
>> >
>> >
>> >
>> > I tried to bisect between 2.7 and 2.8, but bug is not stable.
>> >
>> > It manifested itself at commits "68701de1362b29fd6941a2021e9393ddbe60edd8" and
>> > "6a928d25b6d8bc3729c3d28326c6db13b9481059".
>
>
> Pavel Dovgalyuk
>
