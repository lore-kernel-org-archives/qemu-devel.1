Received: from eggs.gnu.org ([2001:4830:134:3::10]:56887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWjk1-00024J-I1
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWjjy-0007nm-AE
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:05:29 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:36790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cWjjy-0007nW-3f
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:05:26 -0500
Received: by mail-wj0-x242.google.com with SMTP id kq3so4592532wjc.3
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 05:05:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8bf9db63-8f01-9b46-0915-95f0c9e42f60@redhat.com>
Date: Thu, 26 Jan 2017 14:05:23 +0100
MIME-Version: 1.0
In-Reply-To: <20170126123411.5412.44769.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 0/9] replay additions
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



On 26/01/2017 13:34, Pavel Dovgalyuk wrote:
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
> v8 changes:
>  - Refined replay exception processing (as suggested by Paolo Bonzini)
>  - Saving/restoring static variable for APIC only once (as suggested by Paolo Bonzini)
>  - Removed already queued patches
>  - Minor fixes
> 
> v7 changes:
>  - Fixed exception replaying when TB cache is full and
>    when tb_find is called when there are no instructions about to execute
>  - Added record/replay for audio devices
> 
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
> Pavel Dovgalyuk (9):
>       replay: exception replay fix
>       icount: exit cpu loop on expire
>       apic: save apic_delivered flag
>       integratorcp: adding vmstate for save/restore
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
>  cpu-exec.c                      |   24 +++++++++--
>  docs/replay.txt                 |    7 +++
>  hw/arm/integratorcp.c           |   62 +++++++++++++++++++++++++++++
>  hw/intc/apic_common.c           |   37 +++++++++++++++++
>  include/hw/i386/apic_internal.h |    2 +
>  include/sysemu/replay.h         |    7 +++
>  replay/Makefile.objs            |    1 
>  replay/replay-audio.c           |   79 +++++++++++++++++++++++++++++++++++++
>  replay/replay-internal.h        |    4 ++
>  stubs/replay.c                  |    1 
>  translate-all.c                 |    3 +
>  vl.c                            |   10 ++++-
>  16 files changed, 361 insertions(+), 11 deletions(-)
>  create mode 100644 replay/replay-audio.c
> 

Queued patch 1 too.

Thanks for following my reviews.  Record/replay has the potential of
making the code either much better or much worse, and I know we can make
it better because it's what happened for icount.  But if it makes the
code worse, at some point it becomes a labyrinth and the only choice is
to remove RR support. :(  So let's avoid that!

Paolo
Paolo
