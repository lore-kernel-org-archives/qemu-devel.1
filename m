Received: from eggs.gnu.org ([209.51.188.92]:35941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gujGj-0003d3-Rw
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gujGi-0000GU-Oi
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:35:29 -0500
Received: from indium.canonical.com ([91.189.90.7]:37256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gujGi-0000G2-Hf
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:35:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gujGh-0000ua-Rg
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 19:35:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C81E92E80C7
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 19:35:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Feb 2019 19:30:25 -0000
From: Kris M <krislema2@gmail.com>
Reply-To: Bug 1816052 <1816052@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155024186658.3618.3655538630796654144.malonedeb@wampee.canonical.com>
Message-Id: <155025902524.371.14112894474245738460.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1816052] Re: qemu system emulator fails to start
 if no sound card is present on host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

That was Ubuntu DD current on comment #1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1816052

Title:
  qemu system emulator fails to start if no sound card is present on
  host

Status in QEMU:
  New

Bug description:
  A plain build from git master at
  81dbcfa9e1d8bab3f7c4cc923c0b40cd666f374f on Fedora 29 x86_64 host,
  with no options passed to configure.

  Trying to launch QEMU on a  host with no audio card present:

  # ls /dev/snd/
  seq  timer

  It will fail to initialize alsa and abort startup:

  # qemu-system-x86_64 -cdrom Fedora-Workstation-Live-x86_64-29-1.2.iso  -m=
 4000 -vnc 0.0.0.0:1 =

  ALSA lib confmisc.c:767:(parse_card) cannot find card '0'
  ALSA lib conf.c:4555:(_snd_config_evaluate) function snd_func_card_driver=
 returned error: No such file or directory
  ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
  ALSA lib conf.c:4555:(_snd_config_evaluate) function snd_func_concat retu=
rned error: No such file or directory
  ALSA lib confmisc.c:1246:(snd_func_refer) error evaluating name
  ALSA lib conf.c:4555:(_snd_config_evaluate) function snd_func_refer retur=
ned error: No such file or directory
  ALSA lib conf.c:5034:(snd_config_expand) Evaluate error: No such file or =
directory
  ALSA lib pcm.c:2565:(snd_pcm_open_noupdate) Unknown PCM default
  alsa: Could not initialize DAC
  alsa: Failed to open `default':
  alsa: Reason: No such file or directory
  ALSA lib confmisc.c:767:(parse_card) cannot find card '0'
  ALSA lib conf.c:4555:(_snd_config_evaluate) function snd_func_card_driver=
 returned error: No such file or directory
  ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
  ALSA lib conf.c:4555:(_snd_config_evaluate) function snd_func_concat retu=
rned error: No such file or directory
  ALSA lib confmisc.c:1246:(snd_func_refer) error evaluating name
  ALSA lib conf.c:4555:(_snd_config_evaluate) function snd_func_refer retur=
ned error: No such file or directory
  ALSA lib conf.c:5034:(snd_config_expand) Evaluate error: No such file or =
directory
  ALSA lib pcm.c:2565:(snd_pcm_open_noupdate) Unknown PCM default
  alsa: Could not initialize DAC
  alsa: Failed to open `default':
  alsa: Reason: No such file or directory
  init fail
  audio: Failed to create voice `pcspk'
  qemu-system-x86_64: Initialization of device isa-pcspk failed: Initializi=
ng audio voice failed

  =

  git bisect blames this change:

  =

    commit 6a48541873f14b597630283f8f5397674ad82ea9 (HEAD, refs/bisect/bad)
    Author: Gerd Hoffmann <kraxel@redhat.com>
    Date:   Thu Jan 24 12:20:55 2019 +0100

      audio: probe audio drivers by default
      =

      Add the drivers listed in audio_possible_drivers to audio_drv_list,
      using the try-* variants.  That way the probable drivers are compiled=
 by
      default if possible.
      =

      Additioal tweaks:
        linux: reorder to: pa alsa sdl oss.
        *bsd: drop pa.
      =

      Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
      Message-id: 20190124112055.547-7-kraxel@redhat.com

  =

  This changed our probe order:

     Linux)
    -  audio_drv_list=3D"oss"
    +  audio_drv_list=3D"try-pa try-alsa try-sdl oss"

  After some debugging I can see that 'audio_init' successfully
  initializes the alsa driver.

  When the pcspk devices goes to AUD_open_out though, the alsa driver
  fails spewing the above text to stderr and thus causes QEMU to fail.

  This looks very much like the ALSA driver in QEMU is broken -
  audio_init() should not have succeeded unless the ALSA driver knew it
  could later succesfully honour AUD_open_out.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1816052/+subscriptions
