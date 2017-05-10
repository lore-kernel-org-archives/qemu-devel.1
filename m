Received: from eggs.gnu.org ([2001:4830:134:3::10]:40725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d8TSY-0005xo-AO
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d8TSU-0001rM-Vd
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:23:26 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d8TSU-0001pX-L5
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:23:22 -0400
Received: by mail-wr0-x229.google.com with SMTP id l50so47962477wrc.3
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 08:23:22 -0700 (PDT)
References: <20170505103822.20641-1-alex.bennee@linaro.org>
	<006301d2c994$7bd42850$737c78f0$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <006301d2c994$7bd42850$737c78f0$@ru>
Date: Wed, 10 May 2017 16:24:07 +0100
Message-ID: <87efvw91m0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/9] BQL and Replay Lock changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: pbonzini@redhat.com, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru, cota@braap.org, qemu-devel@nongnu.org


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

> Guest Windows XP doesn't boot with these patches.

I'm guessing there is hardware attached to that machine? Did the asserts
catch double locking? As I said there are still changes to be made to
the hardware emulation that saves async events with the device data.

But the real question is do you think that re-purposing replay_lock to
give the sequential guarantees that the BQL used to is the right
approach?

>
> Pavel Dovgalyuk
>
>
>> -----Original Message-----
>> From: Alex Bennée [mailto:alex.bennee@linaro.org]
>> Sent: Friday, May 05, 2017 1:38 PM
>> To: pbonzini@redhat.com; boost.lists@gmail.com; pavel.dovgaluk@ispras.ru
>> Cc: cota@braap.org; qemu-devel@nongnu.org; Alex Bennée
>> Subject: [RFC PATCH v1 0/9] BQL and Replay Lock changes
>>
>> Hi,
>>
>> This RFC does two principle things. It continues the push to reduce
>> the BQL lock contention to a minimum by dropping the BQL for most of
>> the run loop - eventually only holding it for timer processing and
>> sleeping. The second part is an attempt to fix the breakage caused to
>> record/replay by the previous work reducing the BQL in 2.9.
>>
>> The patch breakdown is as follows:
>>
>>  - target/arm/arm-powertctl: drop BQL assertions
>>
>> This just fixes a bogus assert. The async work doesn't need BQL
>> protection as it is all done in the context of the vCPU (meaning
>> nothing else should be messing with it). However going forward we will
>> need to audit all the async work calls to make sure they are fine to
>> run outside of the BQL.
>>
>>  - cpus: push BQL lock to qemu_*_wait_io_event
>>  - cpus: only take BQL for sleeping threads
>>
>> The BQL reduction is done in two stages, mainly to make bisection
>> easier.
>>
>>  - replay/replay-internal.c: track holding of replay_lock
>>  - replay: make locking visible outside replay code
>>  - replay: push replay_mutex_lock up the call tree
>>
>> There is still more work to do here but essentially replay_lock now
>> replaces the BQL in keeping synchronisation between main-loop and the
>> TCG thread - it is no longer a fine lock for the replay log but a
>> gross lock that keeps batches of updates together. So far I have been
>> testing with the simple testcase:
>>
>>   ./arm-softmmu/qemu-system-arm -machine type=vexpress-a9 -m 1024 \
>>     -display none -smp 1 -kernel ../images/vexpress-kernel.img \
>>     -dtb ../images/vexpress-v2p-ca9.dtb  \
>>     -append "console=ttyAMA0" -serial mon:stdio \
>>     -icount shift=7,rr=record,rrfile=replay.bin
>>
>> ..and that works fine. However more complex testing with more devices
>> to exercise the async events code is needed here. One change that
>> needs some careful care is we are now not dropping the replay_mutex
>> lock between events.
>>
>> And finally:
>>
>>  - scripts/qemu-gdb: add simple tcg lock status helper
>>  - util/qemu-thread-*: add qemu_lock, locked and unlock trace events
>>  - scripts/analyse-locks-simpletrace.py: script to analyse lock times
>>
>> These are helpers I wrote while debugging the locking. The GDB helper
>> is fairly dump but does attempt to show where locks are held. The
>> qemu-lock tracing is a little hacky but could prove useful in doing
>> more detailed lock analysis.
>>
>> Any thoughts/comments? Does this seem like a reasonable direction to
>> go?
>>
>> Alex Bennée (9):
>>   target/arm/arm-powertctl: drop BQL assertions
>>   cpus: push BQL lock to qemu_*_wait_io_event
>>   cpus: only take BQL for sleeping threads
>>   replay/replay-internal.c: track holding of replay_lock
>>   replay: make locking visible outside replay code
>>   replay: push replay_mutex_lock up the call tree
>>   scripts/qemu-gdb: add simple tcg lock status helper
>>   util/qemu-thread-*: add qemu_lock, locked and unlock trace events
>>   scripts/analyse-locks-simpletrace.py: script to analyse lock times
>>
>>  cpus-common.c                        | 13 ++---
>>  cpus.c                               | 57 ++++++++++++++++++---
>>  docs/replay.txt                      | 19 +++++++
>>  include/qemu/thread.h                |  7 ++-
>>  include/sysemu/replay.h              | 16 ++++++
>>  kvm-all.c                            |  4 --
>>  replay/replay-char.c                 | 21 +++-----
>>  replay/replay-events.c               | 18 ++-----
>>  replay/replay-internal.c             | 22 +++++++-
>>  replay/replay-internal.h             |  5 +-
>>  replay/replay-time.c                 | 10 ++--
>>  replay/replay.c                      | 40 +++++++--------
>>  scripts/analyse-locks-simpletrace.py | 99 ++++++++++++++++++++++++++++++++++++
>>  scripts/qemu-gdb.py                  |  3 +-
>>  scripts/qemugdb/tcg.py               | 46 +++++++++++++++++
>>  stubs/replay.c                       | 15 ++++++
>>  target/arm/arm-powerctl.c            |  8 ---
>>  target/i386/hax-all.c                |  2 -
>>  util/main-loop.c                     | 23 +++++++--
>>  util/qemu-thread-posix.c             | 11 +++-
>>  util/trace-events                    |  5 ++
>>  vl.c                                 |  2 +
>>  22 files changed, 353 insertions(+), 93 deletions(-)
>>  create mode 100755 scripts/analyse-locks-simpletrace.py
>>  create mode 100644 scripts/qemugdb/tcg.py
>>
>> --
>> 2.11.0


--
Alex Bennée
