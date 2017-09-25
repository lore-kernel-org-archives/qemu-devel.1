Received: from eggs.gnu.org ([2001:4830:134:3::10]:44323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dwYwJ-0004EE-L3
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dwYwG-0005rs-Gy
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:21:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:52414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dwYwG-0005rL-AR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:21:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dwYwD-0000fP-21
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 19:21:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9366F2E84AE
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 19:21:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Sep 2017 19:14:47 -0000
From: John Snow <1719282@bugs.launchpad.net>
Reply-To: Bug 1719282 <1719282@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150633291490.21822.10650098875082014124.malonedeb@chaenomeles.canonical.com>
Message-Id: <150636688753.5936.3002855789490248587.malone@soybean.canonical.com>
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

Do you have more information on the sequence of commands issued to QEMU?
I see the drive-mirror invocation, but then I don't see what causes the
shutdown or the BLOCK_JOB_COMPLETED event. Usually this is in response
to a user command. I'm wondering if the exact sequence issued is safe.

Do you have a reproducer that I could try on my system to examine the
behavior?

Also, 2.7 is a bit old at this point; do you have the ability to try a
version currently supported by the upstream project? (2.9 or 2.10?)

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
