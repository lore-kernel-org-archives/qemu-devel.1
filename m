Received: from eggs.gnu.org ([2001:4830:134:3::10]:33777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cJMsa-0005aj-DF
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cJMsU-000419-1X
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:03:04 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:36086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cJMsT-00040d-Qg
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:02:57 -0500
Received: by mail-ua0-x236.google.com with SMTP id 88so24453015uaq.3
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 08:02:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXm9ssLC5C+gV_agkEW_fdUY=NWBMvHqMh55UhYTR276g@mail.gmail.com>
References: <000301d259dc$f9d097c0$ed71c740$@ru>
	<000601d25a95$12b1b9f0$38152dd0$@ru>
	<20161220102126.GE5602@stefanha-x1.localdomain>
	<002501d25ab1$af024b00$0d06e100$@ru>
	<CAJSP0QXm9ssLC5C+gV_agkEW_fdUY=NWBMvHqMh55UhYTR276g@mail.gmail.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Tue, 20 Dec 2016 16:02:54 +0000
Message-ID: <CAHDbmO0nFH6f9ZTjKbPuu2j5PZ_tSN8dV8WJqPpm=4mbPmM67g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-2.8-rc4 is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Maydell <peter.maydell@linaro.org>

So having a quick review on #qemu with Stefan I think this is an
existing race condition that may have been made more likely with
recent changes. AFAICT what is happening is mouse movement in the GUI
is translated into PS2 events which are injected as interrupts into
the system by GUI thread. For whatever weird x86 reason the IRQ's are
triggered by writing to a ROM area of the system. As a result
invalidation of translated ROM code is triggered that clashes with a
tb_flush which is occurring at the same time.

I suspect you could make the race more likely to hit by starting the
system with --tb-size 1 which will make the tb_flush()'s more frequent
at the same time as wiggling the mouse a lot. If you could test this
on 2.7 I suspect you'll find it's just as crash-able.

Once the rest of MTTCG gets merged the tb_lock() will become active
for the SoftMMU which will prevent the race (as one vCPU will be able
to trigger invalidations in another vCPUs code).

As far as the problem of injecting events into the vCPU is concerned I
think the correct solution would be queue the work up using the
async_run_on_cpu functions which in the current case would ensure only
one thing was happening at a time. Certainly the design of QEMU isn't
expecting non-vCPU threads to invalidate TBs. The gdbstub does this as
well but currently gets away with it as generally the vCPUs are in a
halted state when changes are made.

I'm currently on holiday but I'll keep an eye out for this thread if
anyone has any follow up questions. It would be nice if one of the x86
guys could explain exactly what this weird ROM/IRQ setup is and why it
exists.

On 20 December 2016 at 14:02, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Dec 20, 2016 at 11:10 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wr=
ote:
>>> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
>>> On Tue, Dec 20, 2016 at 10:45:44AM +0300, Pavel Dovgalyuk wrote:
>>> > It also fails much earlier when I enable logs with "-d int -D log".
>>> >
>>> > Here is backtrace for this failure:
>>> >
>>> >
>>> >
>>> > #0  0x0000000076e79e52 in ntdll!EtwpCreateEtwThread ()
>>> >
>>> >    from /c/Windows/SYSTEM32/ntdll.dll
>>> >
>>> > #1  0x0000000076e56965 in ntdll!EtwEventSetInformation ()
>>> >
>>> >    from /c/Windows/SYSTEM32/ntdll.dll
>>> >
>>> > #2  0x0000000076e942d9 in ntdll!RtlLogStackBackTrace ()
>>> >
>>> >    from /c/Windows/SYSTEM32/ntdll.dll
>>> >
>>> > #3  0x0000000076e3797c in ntdll!TpAlpcRegisterCompletionList ()
>>> >
>>> >    from /c/Windows/SYSTEM32/ntdll.dll
>>> >
>>> > #4  0x000007fefdc810c8 in msvcrt!free () from /c/Windows/system32/msv=
crt.dll
>>>
>>> Looks like a heap corruption bug since free() is failing.
>>
>> Seems to be a race condition.
>> When I add logs into invalidate_page_bitmap, the bug disappears.
>> It seems that someone tries to free the same page bitmap twice and simul=
taneously.
>
> Does the following workaround prevent the crashes?
>
> -global apic-common.vapic=3Doff
>
>> Here is the stack trace for two threads at the moment when qemu fails:
>> Failed thread:
>> #0  0x0000000076e79e52 in ntdll!EtwpCreateEtwThread ()
>>    from /c/Windows/SYSTEM32/ntdll.dll
>> #1  0x0000000076e56965 in ntdll!EtwEventSetInformation ()
>>    from /c/Windows/SYSTEM32/ntdll.dll
>> #2  0x0000000076e942d9 in ntdll!RtlLogStackBackTrace ()
>>    from /c/Windows/SYSTEM32/ntdll.dll
>> #3  0x0000000076e3797c in ntdll!TpAlpcRegisterCompletionList ()
>>    from /c/Windows/SYSTEM32/ntdll.dll
>> #4  0x000007fefdc810c8 in msvcrt!free () from /c/Windows/system32/msvcrt=
.dll
>> #5  0x000000000040c57d in invalidate_page_bitmap (p=3D<optimized out>,
>>     p=3D<optimized out>) at D:/Projects/QEMU/qemu/translate-all.c:881
>> #6  tb_invalidate_phys_page_range (start=3D826113, end=3Dend@entry=3D826=
116,
>>     is_cpu_write_access=3Dis_cpu_write_access@entry=3D0)
>>     at D:/Projects/QEMU/qemu/translate-all.c:1527
>> #7  0x000000000040c5ed in tb_invalidate_phys_range_1 (end=3D826116,
>>     start=3D<optimized out>) at D:/Projects/QEMU/qemu/translate-all.c:14=
14
>> #8  tb_invalidate_phys_range (start=3Dstart@entry=3D826113, end=3Dend@en=
try=3D826116)
>>     at D:/Projects/QEMU/qemu/translate-all.c:1424
>> #9  0x0000000000402e5f in invalidate_and_set_dirty (mr=3Dmr@entry=3D0x56=
9e980,
>>     addr=3D<optimized out>, length=3D<optimized out>)
>>     at D:/Projects/QEMU/qemu/exec.c:2511
>> #10 0x0000000000406af7 in cpu_physical_memory_write_rom_internal (
>>     type=3DWRITE_DATA, len=3D3, buf=3D0x22f411 "", addr=3D826113,
>>     as=3D0xab4280 <address_space_memory>) at D:/Projects/QEMU/qemu/exec.=
c:2795
>> <and more>
>>
>> Another thread:
>> #0  0x00000000007411b0 in g_free ()
>> #1  0x000000000040b6b4 in invalidate_page_bitmap (p=3D0x1143f738, p=3D0x=
1143f738)
>>     at D:/Projects/QEMU/qemu/translate-all.c:881
>> #2  page_flush_tb_1 (level=3Dlevel@entry=3D0, lp=3D0x5715058)
>>     at D:/Projects/QEMU/qemu/translate-all.c:900
>> #3  0x000000000040b6ee in page_flush_tb_1 (level=3D1, lp=3D0xac8ac0 <l1_=
map>)
>>     at D:/Projects/QEMU/qemu/translate-all.c:906
>> #4  0x000000000040b7b3 in page_flush_tb ()
>>     at D:/Projects/QEMU/qemu/translate-all.c:916
>> #5  do_tb_flush (cpu=3D<optimized out>, tb_flush_count=3D...)
>>     at D:/Projects/QEMU/qemu/translate-all.c:954
>> #6  0x0000000000519ac1 in process_queued_cpu_work (cpu=3D0x5632fd0)
>>     at cpus-common.c:338
>> #7  0x0000000000439761 in qemu_wait_io_event_common (cpu=3D0x5632fd0)
>>     at D:/Projects/QEMU/qemu/cpus.c:942
>> #8  qemu_tcg_wait_io_event (cpu=3D<optimized out>)
>>     at D:/Projects/QEMU/qemu/cpus.c:957
>> #9  qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x5632fd0)
>>     at D:/Projects/QEMU/qemu/cpus.c:1216
>> #10 0x000000000072c285 in win32_start_routine (arg=3D0x565ba40)
>>     at util/qemu-thread-win32.c:406
>> #11 0x000007fefdc8415f in srand () from /c/Windows/system32/msvcrt.dll
>> #12 0x000007fefdc86ebd in msvcrt!_ftime64_s ()
>> <and more>
>>
>>>
>>> QEMU 2.8.0 is scheduled for release today.  I have checked that
>>> qemu-system-i386.exe works but without playing an MP3 file in Windows
>>> XP.
>>>
>>> I plan to go ahead with the release unless information becomes availabl=
e
>>> that suggests it affects more than just this one scenario.
>>
>>> >
>>> >
>>> > I encountered the following bug with the latest version of QEMU.
>>> >
>>> > I use windows host and start qemu with the following command line:
>>> >
>>> > qemu-system-i386.exe -soundhw ac97 -snapshot -hda disk.qcow2 -net non=
e
>>> >
>>> >
>>> >
>>> > Guest system is Windows XP 32-bit. It founds new hardware (including =
audio controller)
>>> >
>>> > and I start playing mp3 file.
>>> >
>>> > After seconds of playing qemu fails with an exception.
>>> >
>>> >
>>> >
>>> > I tried to bisect between 2.7 and 2.8, but bug is not stable.
>>> >
>>> > It manifested itself at commits "68701de1362b29fd6941a2021e9393ddbe60=
edd8" and
>>> > "6a928d25b6d8bc3729c3d28326c6db13b9481059".
>>
>>
>> Pavel Dovgalyuk
>>
>



--=20
Alex Benn=C3=A9e
KVM/QEMU Hacker for Linaro
