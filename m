Received: from eggs.gnu.org ([2001:4830:134:3::10]:45909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gKnRX-0004Cu-Dk
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gKnRU-000695-6y
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:46:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:54570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gKnRT-000648-Kt
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:46:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gKnRL-0006Fw-MT
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 16:45:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DAB202E80CF
	for <qemu-devel@nongnu.org>; Thu,  8 Nov 2018 16:45:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Nov 2018 16:29:21 -0000
From: tlloss <1795527@bugs.launchpad.net>
Reply-To: Bug 1795527 <1795527@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153843648798.30392.6657333416089253911.malonedeb@soybean.canonical.com>
Message-Id: <154169456138.25418.3840731863975105383.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1795527] Re: Malformed audio and video output
 stuttering after upgrade to QEMU 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

GIT BISECT RESULTS

So, I managed to run the git bisection and ended up having to do it
twice: once looking for the first commit that broke audio (turns out a
major total breakage occurs before the original diagnosed issue
appeared), then to spot the origin of the main issue (I ignored the
other form of malfunctioning, marking it as 'good').

---AUDIO BREAKAGE BISECT LOG---

git bisect start
# bad: [53a19a9a5f9811a911e9b69ef36afb0d66b5d85c] s390x/tcg: always enable =
AFP for linux-user
git bisect bad 53a19a9a5f9811a911e9b69ef36afb0d66b5d85c
# good: [4743c23509a51bd4ee85cc272287a41917d1be35] Update version for v2.12=
.0 release
git bisect good 4743c23509a51bd4ee85cc272287a41917d1be35
# bad: [7f9ddf64d5fe5bfaa91ae0ec52217d86f4d86452] target/arm: Implement SVE=
 Floating Point Accumulating Reduction Group
git bisect bad 7f9ddf64d5fe5bfaa91ae0ec52217d86f4d86452
# good: [cc9743c236cce8a35449e3ef67140287b68bb705] iscsi: Query and save de=
vice designator when opening
git bisect good cc9743c236cce8a35449e3ef67140287b68bb705
# good: [1e05197f24c49d52f339de9053bb1d17082f1be3] translate-all: iterate o=
ver TBs in a page with PAGE_FOR_EACH_TB
git bisect good 1e05197f24c49d52f339de9053bb1d17082f1be3
# good: [2aeba0d007d33efa12a6339bb140aa634e0d52eb] target/arm: Strict align=
ment for ARMv6-M and ARMv8-M Baseline
git bisect good 2aeba0d007d33efa12a6339bb140aa634e0d52eb
# bad: [00928a421d47f49691cace1207481b7aad31b1f1] Merge remote-tracking bra=
nch 'remotes/pmaydell/tags/pull-target-arm-20180626' into staging
git bisect bad 00928a421d47f49691cace1207481b7aad31b1f1
# bad: [35e238c9330669882487f9929e0aa97900431853] Merge remote-tracking bra=
nch 'remotes/kraxel/tags/audio-20180625-pull-request' into staging
git bisect bad 35e238c9330669882487f9929e0aa97900431853
# good: [c52e53f429aa562539f5da2e7c21c66c6f9a8a16] Merge remote-tracking br=
anch 'remotes/dgibson/tags/ppc-for-3.0-20180622' into staging
git bisect good c52e53f429aa562539f5da2e7c21c66c6f9a8a16
# good: [be25fcc4d2faeb3ffa8db813272963bae659c4c2] MAINTAINERS: Update QAPI=
 stanza for commit fb0bc835e56
git bisect good be25fcc4d2faeb3ffa8db813272963bae659c4c2
# good: [518d23a976b7dad77cfef3e41c3531ac89229b00] Merge remote-tracking br=
anch 'remotes/ehabkost/tags/python-next-pull-request' into staging
git bisect good 518d23a976b7dad77cfef3e41c3531ac89229b00
# bad: [8ced0669237b2bbedac3e4ce6fcf7aaaafaae663] audio/hda: tweak timer ad=
just logic
git bisect bad 8ced0669237b2bbedac3e4ce6fcf7aaaafaae663
# bad: [0a373bb310c1533e24aa5e3edbf206507fb342ea] audio/hda: turn some dpri=
ntfs into trace points
git bisect bad 0a373bb310c1533e24aa5e3edbf206507fb342ea
# bad: [280c1e1cdb24d80ecdfcdfc679ccc5e8ed7af45d] audio/hda: create millise=
cond timers that handle IO
git bisect bad 280c1e1cdb24d80ecdfcdfc679ccc5e8ed7af45d
# first bad commit: [280c1e1cdb24d80ecdfcdfc679ccc5e8ed7af45d] audio/hda: c=
reate millisecond timers that handle IO

---END---


---ORIGINAL ISSUE BISECT LOG---

git bisect start
# bad: [35e238c9330669882487f9929e0aa97900431853] Merge remote-tracking bra=
nch 'remotes/kraxel/tags/audio-20180625-pull-request' into staging
git bisect bad 35e238c9330669882487f9929e0aa97900431853
# good: [c52e53f429aa562539f5da2e7c21c66c6f9a8a16] Merge remote-tracking br=
anch 'remotes/dgibson/tags/ppc-for-3.0-20180622' into staging
git bisect good c52e53f429aa562539f5da2e7c21c66c6f9a8a16
# good: [cc2ae7c9de14efd72c6205825eb7cd980ac09c11] target/arm: Introduce AR=
M_FEATURE_M_MAIN
git bisect good cc2ae7c9de14efd72c6205825eb7cd980ac09c11
# good: [be25fcc4d2faeb3ffa8db813272963bae659c4c2] MAINTAINERS: Update QAPI=
 stanza for commit fb0bc835e56
git bisect good be25fcc4d2faeb3ffa8db813272963bae659c4c2
# good: [518d23a976b7dad77cfef3e41c3531ac89229b00] Merge remote-tracking br=
anch 'remotes/ehabkost/tags/python-next-pull-request' into staging
git bisect good 518d23a976b7dad77cfef3e41c3531ac89229b00
# good: [8ced0669237b2bbedac3e4ce6fcf7aaaafaae663] audio/hda: tweak timer a=
djust logic
git bisect good 8ced0669237b2bbedac3e4ce6fcf7aaaafaae663
# bad: [bc753dc09ff33d99bc9004d7286c50de1d5bece6] audio/hda: enable new tim=
er code by default.
git bisect bad bc753dc09ff33d99bc9004d7286c50de1d5bece6
# good: [4501ee16c76e89e0a2b2beb95f3b93f965997391] audio/hda: detect output=
 buffer overruns
git bisect good 4501ee16c76e89e0a2b2beb95f3b93f965997391
# first bad commit: [bc753dc09ff33d99bc9004d7286c50de1d5bece6] audio/hda: e=
nable new timer code by default.

---END---


I'm attaching both of them, just in case someone wants to replay them.

One thing that I'd like to point out is that the thing I called "total brea=
kage" looks extremely similar to what happens when I set a 2.12 machine on =
a 3.0 QEMU: complete distortion.
Do I have to study it more in order to see if it really produces the same e=
ffect?


Anyway, I'm sorry if such a simple matter took this long but, during one of=
 the initial bisections, an accidental misconfiguration in the testing envi=
ronment completely wasted the guest I was using (permanent Windows startup =
failure-level of wasted...).
I had to recover a few things and reinstall as many.

** Attachment added: "[AUDIO BREAKAGE LOG]"
   https://bugs.launchpad.net/qemu/+bug/1795527/+attachment/5210396/+files/=
qemu_bisect_total_audio_breakage.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1795527

Title:
  Malformed audio and video output stuttering after upgrade to QEMU 3.0

Status in QEMU:
  New

Bug description:
  My host is an x86_64 Arch Linux OS with a recompiled 4.18.10 hardened
  kernel, running a few KVM guests with varying OSes and configurations
  managed through a Libvirt stack.

  Among these guests I have two Windows 10 VMs with VGA passthrough and
  PulseAudio-backed virtual audio devices.

  After upgrading to QEMU 3.0.0, both of the Win10 guests started
  showing corrupted audio output in the form of unnatural reproduction
  speed and occasional but consistently misplaced audio fragments
  originating from what seems to be a circular buffer wrapping over
  itself (misbehaviour detected by starting some games with known OSTs
  and dialogues: soundtracks sound accelerated and past dialogue lines
  start replaying middle-sentence until the next line starts playing).

  In addition, the video output of the malfunctioning VMs regularly
  stutters roughly twice a second for a fraction of a second (sync'ed
  with the suspected buffer wrapping and especially pronounced during
  not-pre-rendered cutscenes), toghether with mouse freezes that look
  like actual input misses more than simple lack of screen refreshes.

  =

  The issue was succesfully reproduced without the managing stack, directly=
 with the following command line, on the most capable Windows guest:

   QEMU_AUDIO_DRV=3Dpa
   QEMU_PA_SERVER=3D127.0.0.1
   /usr/bin/qemu-system-x86_64 -name guest=3Dwin10_gms,debug-threads=3Don \
   -machine pc-i440fx-3.0,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-cor=
e=3Doff \                                                                  =
                                                                         =

   -cpu host,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff,hv_vendor_id=
=3D123456789abc,kvm=3Doff \          =

   -drive file=3D/usr/share/ovmf/x64/OVMF_CODE.fd,if=3Dpflash,format=3Draw,=
unit=3D0,readonly=3Don \       =

   -drive file=3D/var/lib/libvirt/qemu/nvram/win10_gms_VARS.fd,if=3Dpflash,=
format=3Draw,unit=3D1 \
   -m 5120 \                                                               =
               =

   -realtime mlock=3Doff \
   -smp 3,sockets=3D1,cores=3D3,threads=3D1 \
   -uuid 39b56ee2-6bae-4009-9108-7be26d5d63ac \
   -display none \                             =

   -no-user-config \
   -nodefaults \    =

   -rtc base=3Dlocaltime,driftfix=3Dslew \                                 =
                                                                           =
                                                                     =

   -global kvm-pit.lost_tick_policy=3Ddelay \                              =
                                    =

   -no-hpet \                              =

   -no-shutdown \
   -global PIIX4_PM.disable_s3=3D1 \
   -global PIIX4_PM.disable_s4=3D1 \
   -boot strict=3Don \              =

   -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x4.0x7 \
   -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multi=
function=3Don,addr=3D0x4 \
   -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=
=3D0x4.0x1 \             =

   -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=
=3D0x4.0x2 \
   -device ahci,id=3Dsata0,bus=3Dpci.0,addr=3D0x9 \                        =
         =

   -drive file=3D/dev/vms/win10_gaming,format=3Draw,if=3Dnone,id=3Ddrive-vi=
rtio-disk0,cache=3Dnone,aio=3Dnative \
   -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x5,drive=3Ddrive-v=
irtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don \
   -drive file=3D/dev/sr0,format=3Draw,if=3Dnone,id=3Ddrive-sata0-0-0,media=
=3Dcdrom,readonly=3Don \                                    =

   -device ide-cd,bus=3Dsata0.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0 \   =
                  =

   -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x3 \                  =
                                                                           =
                                                                       =

   -device hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 \          =
                                   =

   -device usb-host,hostbus=3D2,hostaddr=3D3,id=3Dhostdev0,bus=3Dusb.0,port=
=3D1 \
   -device vfio-pci,host=3D01:00.0,id=3Dhostdev1,bus=3Dpci.0,addr=3D0x6 \  =
    =

   -device vfio-pci,host=3D01:00.1,id=3Dhostdev2,bus=3Dpci.0,addr=3D0x7 \
   -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 \   =

   -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resour=
cecontrol=3Ddeny \
   -msg timestamp=3Don

  =

  By "purposedly misconfiguring" the codepaths and replacing "pc-i440fx-3.0=
" with "pc-i440fx-2.11" (basically reverting the config changes I needed to=
 do in order to update the domain definitions), the stuttering seems to dis=
appear (or at least becomes negligible) and the audio output, despite becom=
ing incredibly distorted, is consistent in every other way, with in-order d=
ialogues and (perceived) correct tempo.

  =

  In order to exclude eventual misconfigurations in the host's audio proces=
sing pipeline, I proceeded to update the domain definition's codepath of an=
other guest running Ubuntu 18.04 with a completely different hardware confi=
guration (no video card passthrough and no PulseAudio backconnection, just =
a plain emulated VirtIO display and Spice audio device).

  The audio issue presented itself again in the form of slightly sped up au=
dio playback from Internet videos interleaved with occasional "quenches" of=
 playing speed.
  Stutters are difficult to detect because of the poor refresh rate of the =
emulated VGA adapter, but I wouldn't be surprised to find them here too (ac=
tually, I *think* I sensed them, but I'm not sure enough to assess their ex=
istence).

  Once again, by reverting to the old 2.11 directive everything is back
  to normal.


  Given the fact that no official upgrade directives regarding required sam=
pling rate, period or sheduling adjustments were stated or handed-out to ad=
ministrators, I decided to report this behaviour as a bug.
  I hope this is the appropriate channel and that I didn't annoy anyone (th=
is is my first proper bug report, please forgive me for any innaccuracy).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1795527/+subscriptions
