Received: from eggs.gnu.org ([2001:4830:134:3::10]:53540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWLUs-0002vd-Cf
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWLUp-0007SY-3l
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:12:14 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cWLUo-0007SB-S5
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:12:11 -0500
Received: by mail-lf0-x244.google.com with SMTP id h65so20340363lfi.3
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 03:12:10 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d1244b7-a861-7b5d-eb1e-670548c67205@redhat.com>
Date: Wed, 25 Jan 2017 12:12:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170124071654.4572.41407.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/14] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, kraxel@redhat.com



On 24/01/2017 08:16, Pavel Dovgalyuk wrote:
> This set of patches includes several fixes for replay and vmstate.
> 
> This patches add rrsnapshot option for icount. rrshapshot option creates
> start snapshot at record and loads it at replay. It allows preserving
> the state of disk images used by virtual machine. This vm state can also
> use used to roll back the execution while replaying.
> 
> With these patches operations with audio devices can also be recorded
> and replayed. All interactions with passthrough audio (including
> microphone input) are recorded automatically when -soundhw is specified
> at the command line.
> 
> This set of patches includes fixes and additions for icount and
> record/replay implementation:
>  - VM start/stop in replay mode
>  - overlay creation for blkreplay filter
>  - rrsnapshot option for record/replay
>  - vmstate fix for integratorcp ARM platform
>  - vmstate fixes for apic and rtc
>  - fixes for icount record/replay mode
>  - record/replay for audio devices
> 
> v7 changes:
>  - Fixed exception replaying when TB cache is full and
>    when tb_find is called when there are no instructions about to execute
>  - Added record/replay for audio devices

Queued patches 1, 2, 6, 8, 9.

Please post patches for ARM, block and audio maintainers separately if
you don't get attention soon.

Paolo

> v6 changes:
>  - Added overlay creation for blkreplay driver
>  - Fixed vmstate loading for apic and rtc
>  - Fixed instruction counting for apic instruction patching
> 
> v5 changes:
>  - Recording is stopped when initial snapshot cannot be created
>  - Minor changes
> 
> v4 changes:
>  - Overlay option is removed from blkreplay driver (as suggested by Paolo Bonzini)
>  - Minor changes
> 
> v3 changes:
>  - Added rrsnapshot option for specifying the initial snapshot name (as suggested by Paolo Bonzini)
>  - Minor changes
> 
> ---
> 
> Pavel Dovgalyuk (14):
>       icount: update instruction counter on apic patching
>       replay: improve interrupt handling
>       replay: exception replay fix
>       icount: exit cpu loop on expire
>       apic: save apic_delivered flag
>       replay: don't use rtc clock on loadvm phase
>       integratorcp: adding vmstate for save/restore
>       savevm: add public save_vmstate function
>       replay: save/load initial state
>       block: implement bdrv_snapshot_goto for blkreplay
>       blkreplay: create temporary overlay for underlaying devices
>       replay: disable default snapshot for record/replay
>       audio: make audio poll timer deterministic
>       replay: add record/replay for audio passthrough
> 
> 
>  audio/audio.c                   |   15 +++++--
>  audio/audio.h                   |    5 ++
>  audio/mixeng.c                  |   31 ++++++++++++++
>  block/blkreplay.c               |   84 +++++++++++++++++++++++++++++++++++++++
>  cpu-exec.c                      |   21 ++++++++--
>  docs/replay.txt                 |   23 +++++++++++
>  hw/arm/integratorcp.c           |   62 +++++++++++++++++++++++++++++
>  hw/i386/kvmvapic.c              |    6 +++
>  hw/intc/apic_common.c           |   32 +++++++++++++++
>  hw/timer/mc146818rtc.c          |   14 +++++--
>  include/hw/i386/apic_internal.h |    2 +
>  include/sysemu/replay.h         |   16 +++++++
>  include/sysemu/sysemu.h         |    1 
>  migration/savevm.c              |   33 ++++++++++-----
>  qemu-options.hx                 |    8 +++-
>  replay/Makefile.objs            |    1 
>  replay/replay-audio.c           |   79 +++++++++++++++++++++++++++++++++++++
>  replay/replay-internal.h        |    4 ++
>  replay/replay-snapshot.c        |   17 ++++++++
>  replay/replay.c                 |    5 ++
>  stubs/replay.c                  |    1 
>  target/i386/seg_helper.c        |    1 
>  vl.c                            |   17 +++++++-
>  23 files changed, 450 insertions(+), 28 deletions(-)
>  create mode 100644 replay/replay-audio.c
> 
