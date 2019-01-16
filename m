Received: from eggs.gnu.org ([209.51.188.92]:57704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukd-000402-Af
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjuka-0002iv-C2
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:34406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjukS-0002Xt-6I
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:31 -0500
Received: by mail-wm1-x32c.google.com with SMTP id y185so2236900wmd.1
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:26 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:33 +0100
Message-Id: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/50] Audio 5.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hi,

Here's an updated version of my audio 5.1 patches. Bigger changes from the
previous version:

* Removed QemuOpts, use qobject_input_visitor.  This also means I removed my two
  OptsVisitor patches as they are no longer needed.  I haven't done the input
  and output option merging, I think they're better this way as we can share a
  few functions between the input and output, but it has its drawbacks too with
  its extra nesting, so it's still up for debate.
* Trivial qapi fixes
* MIN/MAX: Eric Blake's patches[1] should fix the osdep.h problems eventually,
  so I left that out of my patch series.

Additionally, programmingkidx@gmail.com reported some problems with the
coreaudio backend, but since I don't have a Mac I can't really test/debug it.
Any help is greatly appreciated!

Regards,
Zoltan

[1]: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00727.html

Kővágó, Zoltán (50):
  qapi: qapi for audio backends
  audio: use qapi AudioFormat instead of audfmt_e
  audio: -audiodev command line option: documentation
  audio: -audiodev command line option basic implementation
  alsaaudio: port to -audiodev config
  coreaudio: port to -audiodev config
  dsoundaudio: port to -audiodev config
  noaudio: port to -audiodev config
  ossaudio: port to -audiodev config
  paaudio: port to -audiodev config
  sdlaudio: port to -audiodev config
  spiceaudio: port to -audiodev config
  wavaudio: port to -audiodev config
  audio: -audiodev command line option: cleanup
  audio: reduce glob_audio_state usage
  audio: basic support for multi backend audio
  audio: add audiodev properties to frontends
  audio: audiodev= parameters no longer optional when -audiodev present
  paaudio: do not move stream when sink/source name is specified
  paaudio: properly disconnect streams in fini_*
  audio: remove audio_MIN, audio_MAX
  audio: do not run each backend in audio_run
  paaudio: fix playback glitches
  audio: remove read and write pcm_ops
  audio: use size_t where makes sense
  audio: api for mixeng code free backends
  alsaaudio: port to the new audio backend api
  coreaudio: port to the new audio backend api
  dsoundaudio: port to the new audio backend api
  noaudio: port to the new audio backend api
  ossaudio: port to the new audio backend api
  paaudio: port to the new audio backend api
  sdlaudio: port to the new audio backend api
  spiceaudio: port to the new audio backend api
  wavaudio: port to the new audio backend api
  audio: remove remains of the old backend api
  audio: unify input and output mixeng buffer management
  audio: remove hw->samples, buffer_size_in/out pcm_ops
  audio: common rate control code for timer based outputs
  audio: split ctl_* functions into enable_* and volume_*
  audio: add mixeng option (documentation)
  audio: make mixeng optional
  paaudio: get/put_buffer functions
  audio: support more than two channels in volume setting
  audio: replace shift in audio_pcm_info with bytes_per_frame
  audio: basic support for multichannel audio
  paaudio: channel-map option
  usb-audio: do not count on avail bytes actually available
  usb-audio: support more than two channels of audio
  usbaudio: change playback counters to 64 bit

 configure                        |    5 -
 Makefile.objs                    |    6 +-
 qapi/audio.json                  |  241 +++++
 qapi/qapi-schema.json            |    1 +
 audio/audio.h                    |   76 +-
 audio/audio_int.h                |  141 +--
 audio/audio_pt_int.h             |   22 -
 audio/audio_template.h           |  112 ++-
 audio/dsound_template.h          |   63 +-
 audio/mixeng.h                   |    9 +-
 audio/rate_template.h            |    2 +-
 include/hw/qdev-properties.h     |    3 +
 include/sysemu/replay.h          |    4 +-
 ui/vnc.h                         |    2 +
 audio/alsaaudio.c                |  771 +++++----------
 audio/audio.c                    | 1571 +++++++++++++++---------------
 audio/audio_legacy.c             |  548 +++++++++++
 audio/audio_pt_int.c             |  174 ----
 audio/audio_win_int.c            |   18 +-
 audio/coreaudio.c                |  198 ++--
 audio/dsoundaudio.c              |  449 +++------
 audio/noaudio.c                  |   98 +-
 audio/ossaudio.c                 |  608 +++++-------
 audio/paaudio.c                  |  894 +++++++----------
 audio/sdlaudio.c                 |  218 ++---
 audio/spiceaudio.c               |  286 ++----
 audio/wavaudio.c                 |  158 +--
 audio/wavcapture.c               |    8 +-
 hw/arm/omap2.c                   |    2 +-
 hw/audio/ac97.c                  |   13 +-
 hw/audio/adlib.c                 |    7 +-
 hw/audio/cs4231a.c               |   11 +-
 hw/audio/es1370.c                |   17 +-
 hw/audio/gus.c                   |    9 +-
 hw/audio/hda-codec.c             |   35 +-
 hw/audio/lm4549.c                |    6 +-
 hw/audio/milkymist-ac97.c        |   16 +-
 hw/audio/pcspk.c                 |    5 +-
 hw/audio/pl041.c                 |    1 +
 hw/audio/sb16.c                  |   17 +-
 hw/audio/wm8750.c                |   16 +-
 hw/core/qdev-properties-system.c |   57 ++
 hw/display/xlnx_dp.c             |    2 +-
 hw/input/tsc210x.c               |    2 +-
 hw/usb/dev-audio.c               |  464 +++++++--
 monitor.c                        |   12 +-
 replay/replay-audio.c            |   16 +-
 replay/replay.c                  |    2 +-
 ui/vnc.c                         |   41 +-
 vl.c                             |    7 +-
 audio/Makefile.objs              |    3 +-
 hmp-commands.hx                  |   11 +-
 qemu-options.hx                  |  242 ++++-
 53 files changed, 3985 insertions(+), 3715 deletions(-)
 create mode 100644 qapi/audio.json
 delete mode 100644 audio/audio_pt_int.h
 create mode 100644 audio/audio_legacy.c
 delete mode 100644 audio/audio_pt_int.c

-- 
2.20.1
