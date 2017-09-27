Received: from eggs.gnu.org ([2001:4830:134:3::10]:58581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxAiJ-0004GN-Mj
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxAiF-0004DK-Ce
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:41:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:55524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dxAiF-0004Cq-3s
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:41:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dxAiC-0002pI-5f
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 11:41:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 281422E8494
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 11:41:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Sep 2017 11:32:02 -0000
From: Farid Zarazvand <1719282@bugs.launchpad.net>
Reply-To: Bug 1719282 <1719282@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150633291490.21822.10650098875082014124.malonedeb@chaenomeles.canonical.com>
Message-Id: <150651192277.6013.96852606342035762.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1719282] Re: Unable to boot after drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In last try, vm shutdown before completing blockjob.
So i tried again and these are the exact qmp commands which i used:

Sequence of qmp commands:

socat UNIX-CONNECT:/var/run/qemu-server/48016.qmp STDIO
{"QMP": {"version": {"qemu": {"micro": 0, "minor": 7, "major": 2}, "package=
": "pve-qemu-kvm_2.7.0-10"}, "capabilities": []}}
{ "execute": "qmp_capabilities" }
{"return": {}}
{ "execute": "drive-mirror",
  "arguments": {
    "device": "drive-ide0",
    "target": "/diskb/48016/vm-48016-disk-1.raw",
    "sync": "full",
    "mode": "absolute-paths",
    "speed": 0
  }
}
{"return": {}}
{"timestamp": {"seconds": 1506434603, "microseconds": 633439}, "event": "BL=
OCK_JOB_READY", "data": {"device": "drive-ide0", "len": 268479496192, "offs=
et": 268479496192, "speed": 0, "type": "mirror"}}
{ "execute": 'block-job-complete', 'arguments': { 'device': 'drive-ide0' } }
{"return": {}}
{"timestamp": {"seconds": 1506494590, "microseconds": 735601}, "event": "BL=
OCK_JOB_COMPLETED", "data": {"device": "drive-ide0", "len": 278522167296, "=
offset": 278522167296, "speed": 0, "type": "mirror"}}

Then i poweroff VM and start it again from new image, but grub starts in
rescue mode.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719282

Title:
  Unable to boot after drive-mirror

Status in QEMU:
  New

Bug description:
  Hi,
  I am using "drive-mirror" qmp block-job command to transfer VM disk image=
 to other path (different physical disk on host).
  Unfortunately after shutting down and starting from new image, VM is unab=
le to boot and qrub enters rescue mode displaying following error:
  ```
  error: file '/grub/i386-pc/normal.mod' not found.
  Entering rescue mode...
  grub rescue>
  ```

  To investigate the problem, I compared both RAW images using linux
  "cmp -l" command and found out that they differ in 569028 bytes
  starting from address 185598977 to 252708864 which are located on
  /boot partition.

  So I mounted /boot partition of mirrored RAW image on host OS and it
  seems that file-system is broken and grub folder is not recognized.
  But /boot on original RAW image has no problem.

  Mirrored Image:
  ls -l /mnt/vm-boot/
  ls: cannot access /mnt/vm-boot/grub: Structure needs cleaning
  total 38168
  -rw-r--r-- 1 root root   157721 Oct 19  2016 config-3.16.0-4-amd64
  -rw-r--r-- 1 root root   129281 Sep 20  2015 config-3.2.0-4-amd64
  d????????? ? ?    ?           ?            ? grub
  -rw-r--r-- 1 root root 15739360 Nov  2  2016 initrd.img-3.16.0-4-amd64
  -rw-r--r-- 1 root root 12115412 Oct 10  2015 initrd.img-3.2.0-4-amd64
  drwxr-xr-x 2 root root    12288 Oct  7  2013 lost+found
  -rw-r--r-- 1 root root  2679264 Oct 19  2016 System.map-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2114662 Sep 20  2015 System.map-3.2.0-4-amd64
  -rw-r--r-- 1 root root  3126448 Oct 19  2016 vmlinuz-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2842592 Sep 20  2015 vmlinuz-3.2.0-4-amd64

  Original Image:
  ls /mnt/vm-boot/ -l
  total 38173
  -rw-r--r-- 1 root root   157721 Oct 19  2016 config-3.16.0-4-amd64
  -rw-r--r-- 1 root root   129281 Sep 20  2015 config-3.2.0-4-amd64
  drwxr-xr-x 5 root root     5120 Nov  2  2016 grub
  -rw-r--r-- 1 root root 15739360 Nov  2  2016 initrd.img-3.16.0-4-amd64
  -rw-r--r-- 1 root root 12115412 Oct 10  2015 initrd.img-3.2.0-4-amd64
  drwxr-xr-x 2 root root    12288 Oct  7  2013 lost+found
  -rw-r--r-- 1 root root  2679264 Oct 19  2016 System.map-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2114662 Sep 20  2015 System.map-3.2.0-4-amd64
  -rw-r--r-- 1 root root  3126448 Oct 19  2016 vmlinuz-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2842592 Sep 20  2015 vmlinuz-3.2.0-4-amd64

  ls /mnt/vm-boot/grub/ -l
  total 2376
  -rw-r--r-- 1 root root      48 Oct  7  2013 device.map
  drwxr-xr-x 2 root root    1024 Oct 10  2015 fonts
  -r--r--r-- 1 root root    9432 Nov  2  2016 grub.cfg
  -rw-r--r-- 1 root root    1024 Oct  7  2013 grubenv
  drwxr-xr-x 2 root root    6144 Aug  6  2016 i386-pc
  drwxr-xr-x 2 root root    1024 Aug  6  2016 locale
  -rw-r--r-- 1 root root 2400500 Aug  6  2016 unicode.pf2

  qemu Version: 2.7.0-10

  Host OS: Debian 8x64
  Guest OS: Debian 8x64

  QMP Commands log:
  socat UNIX-CONNECT:/var/run/qemu-server/48016.qmp STDIO
  {"QMP": {"version": {"qemu": {"micro": 0, "minor": 7, "major": 2}, "packa=
ge": "pve-qemu-kvm_2.7.0-10"}, "capabilities": []}}
  { "execute": "qmp_capabilities" }
  {"return": {}}
  { "execute": "drive-mirror",
    "arguments": {
      "device": "drive-ide0",
      "target": "/diskc/48016/vm-48016-disk-2.raw",
      "sync": "full",
      "mode": "absolute-paths",
      "speed": 0
    }
  }
  {"return": {}}
  {"timestamp": {"seconds": 1506331591, "microseconds": 623095}, "event": "=
BLOCK_JOB_READY", "data": {"device": "drive-ide0", "len": 269445758976, "of=
fset": 269445758976, "speed": 0, "type": "mirror"}}
  {"timestamp": {"seconds": 1506332641, "microseconds": 245272}, "event": "=
SHUTDOWN"}
  {"timestamp": {"seconds": 1506332641, "microseconds": 377751}, "event": "=
BLOCK_JOB_COMPLETED", "data": {"device": "drive-ide0", "len": 271707340800,=
 "offset": 271707340800, "speed": 0, "type": "mirror"}}

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1719282/+subscriptions
