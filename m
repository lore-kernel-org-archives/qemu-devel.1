Received: from eggs.gnu.org ([2001:4830:134:3::10]:55598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZvhq-0003eZ-6b
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZvhn-0006nd-1O
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:32:58 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:39208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZvhm-0006n9-OA
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:32:54 -0500
Received: by mail-wm0-f42.google.com with SMTP id i11so10426470wmf.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 01:32:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
	<ecc919de-5193-a83c-0e29-4b8d9bc8d7d7@redhat.com>
Message-ID: <e0cbd675-7872-05c3-8c3e-214ef93e4552@redhat.com>
Date: Fri, 12 Jan 2018 10:32:50 +0100
MIME-Version: 1.0
In-Reply-To: <ecc919de-5193-a83c-0e29-4b8d9bc8d7d7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 00/30] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org

On 11/01/2018 13:56, Paolo Bonzini wrote:
> On 11/01/2018 09:24, Pavel Dovgalyuk wrote:
>> Accidentally sent draft version of patches to the mailing list.
>> Please consider this one as the correct one.
>>
>> This set of patches includex fixes from Alex Bennée for fixing
>> BQL and replay locks after inventing the MTTCG. It also includes some
>> additional replay patches that makes this set of fixes working.
>> It is also fixes some vmstate creation (and loading) issues
>> in record/replay modes:
>>  - VM start/stop fixes in replay mode
>>  - overlay creation for blkreplay filter
>>  - fixes for vmstate save/load in record/replay mode
>>  - fixes for host clock vmstate
>>  - fixes for icount timers vmstate
>>
>> There is also a set of helper scripts written by Alex Bennée
>> for debugging the record/replay code.
> 
> For now, I'm applying patches 13, 24-26 and 28.

Which don't compile on Windows.

This is the second series I've applied from you this morning that
doesn't compile at all.  Please be more careful.

Paolo

> 
> Paolo
> 
>>
>> v3 changes:
>>  - removed upstreamed patches
>>  - fixed bug with recursive checkpoints
>>  - fixed bug with icount warp checkpoint
>>
>> v2 changes:
>>  - updated lock/unlock logic (as suggested by Paolo Bonzini)
>>  - updated cpu execution loop to avoid races in setting/resetting exit request (as suggested by Paolo Bonzini)
>>  - minor changes
>>
>> ---
>>
>> Alex Bennée (12):
>>       target/arm/arm-powertctl: drop BQL assertions
>>       cpus: push BQL lock to qemu_*_wait_io_event
>>       cpus: only take BQL for sleeping threads
>>       replay/replay.c: bump REPLAY_VERSION again
>>       replay/replay-internal.c: track holding of replay_lock
>>       replay: make locking visible outside replay code
>>       replay: push replay_mutex_lock up the call tree
>>       scripts/qemu-gdb: add simple tcg lock status helper
>>       util/qemu-thread-*: add qemu_lock, locked and unlock trace events
>>       scripts/analyse-locks-simpletrace.py: script to analyse lock times
>>       scripts/replay-dump.py: replay log dumper
>>       scripts/qemu-gdb/timers.py: new helper to dump timer state
>>
>> Pavel Dovgalyuk (18):
>>       hpet: recover timer offset correctly
>>       cpu: flush TB cache when loading VMState
>>       This patch adds a condition before overwriting exception_index fields.
>>       block: implement bdrv_snapshot_goto for blkreplay
>>       blkreplay: create temporary overlay for underlaying devices
>>       replay: disable default snapshot for record/replay
>>       replay: fix processing async events
>>       replay: fixed replay_enable_events
>>       replay: fix save/load vm for non-empty queue
>>       replay: added replay log format description
>>       replay: make safe vmstop at record/replay
>>       replay: save prior value of the host clock
>>       icount: fixed saving/restoring of icount warp timers
>>       replay: don't destroy mutex at exit
>>       replay: check return values of fwrite
>>       replay: avoid recursive call of checkpoints
>>       replay: improve replay performance
>>       replay: don't process async events when warping the clock
>>
>>
>>  accel/kvm/kvm-all.c                  |    4 
>>  accel/tcg/cpu-exec.c                 |    5 -
>>  block/blkreplay.c                    |   73 ++++++++
>>  cpus-common.c                        |   13 +
>>  cpus.c                               |  184 +++++++++++++++-----
>>  docs/replay.txt                      |   91 ++++++++++
>>  exec.c                               |    1 
>>  hw/timer/hpet.c                      |   30 +++
>>  include/hw/compat.h                  |    6 +
>>  include/qemu/thread.h                |   19 ++
>>  include/qemu/timer.h                 |   14 ++
>>  include/sysemu/replay.h              |   22 ++
>>  migration/savevm.c                   |   13 +
>>  replay/replay-char.c                 |   21 +-
>>  replay/replay-events.c               |   30 +--
>>  replay/replay-internal.c             |   48 +++++
>>  replay/replay-internal.h             |    9 +
>>  replay/replay-snapshot.c             |    9 +
>>  replay/replay-time.c                 |   10 +
>>  replay/replay.c                      |   75 ++++++--
>>  scripts/analyse-locks-simpletrace.py |   99 +++++++++++
>>  scripts/qemu-gdb.py                  |    4 
>>  scripts/qemugdb/tcg.py               |   46 +++++
>>  scripts/qemugdb/timers.py            |   54 ++++++
>>  scripts/replay-dump.py               |  308 ++++++++++++++++++++++++++++++++++
>>  stubs/replay.c                       |   16 ++
>>  target/arm/arm-powerctl.c            |    8 -
>>  target/i386/hax-all.c                |    2 
>>  util/main-loop.c                     |   17 +-
>>  util/qemu-thread-posix.c             |   21 +-
>>  util/qemu-timer.c                    |   12 +
>>  util/trace-events                    |    7 -
>>  vl.c                                 |   12 +
>>  33 files changed, 1112 insertions(+), 171 deletions(-)
>>  create mode 100755 scripts/analyse-locks-simpletrace.py
>>  create mode 100644 scripts/qemugdb/tcg.py
>>  create mode 100644 scripts/qemugdb/timers.py
>>  create mode 100755 scripts/replay-dump.py
>>
> 
> 
