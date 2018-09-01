Received: from eggs.gnu.org ([2001:4830:134:3::10]:59865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvzD8-0000Xk-LQ
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 02:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvzBQ-00020k-0E
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 02:15:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:35052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fvzBP-00020U-Qk
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 02:14:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fvzBO-0003Vc-OB
	for <qemu-devel@nongnu.org>; Sat, 01 Sep 2018 06:14:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B273B2E80C9
	for <qemu-devel@nongnu.org>; Sat,  1 Sep 2018 06:14:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Sep 2018 05:57:14 -0000
From: Andy <1490611@bugs.launchpad.net>
Reply-To: Bug 1490611 <1490611@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150831152901.21817.58033.malonedeb@gac.canonical.com>
Message-Id: <153578143444.32458.12466143869920053185.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1490611] Re: Using qemu >=2.2.1 to convert
 raw->VHD (fixed) adds extra padding to the result file,
 which Microsoft Azure rejects as invalid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm using this version on xenial,
andy@bastion:~/temp$ qemu-img -h
qemu-img version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.31), Copyright (c) 2004=
-2008 Fabrice Bellard

qemu-img convert -f raw -O vpc -o subformat=3Dfixed,force_size
/tmp/azure_config_disk_image20180901-22672-16zxelu papapa2.vhd

unfortunately the papapa2.vhd size is 25166336!=3D25165824 which means
it's not aligned in MiB.

could you please help?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1490611

Title:
  Using qemu >=3D2.2.1 to convert raw->VHD (fixed) adds extra padding to
  the result file, which Microsoft Azure rejects as invalid

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Xenial:
  Fix Released

Bug description:
  [Impact]

  =C2=A0* Starting with a raw disk image, using "qemu-img convert" to conve=
rt
  from raw to VHD results in the output VHD file's virtual size being
  aligned to the nearest 516096 bytes (16 heads x 63 sectors per head x
  512 bytes per sector), instead of preserving the input file's size as
  the output VHD's virtual disk size.

  =C2=A0* Microsoft Azure requires that disk images (VHDs) submitted for
  upload have virtual sizes aligned to a megabyte boundary. (Ex. 4096MB,
  4097MB, 4098MB, etc. are OK, 4096.5MB is rejected with an error.) This
  is reflected in Microsoft's documentation: https://azure.microsoft.com
  /en-us/documentation/articles/virtual-machines-linux-create-upload-
  vhd-generic/

  =C2=A0* The fix for this bug is a backport from upstream.
  http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dfb9245c2610932d33ce14

  [Test Case]

  =C2=A0* This is reproducible with the following set of commands (including
  the Azure command line tools from https://github.com/Azure/azure-
  xplat-cli). For the following example, I used qemu version 2.2.1:

  $ dd if=3D/dev/zero of=3Dsource-disk.img bs=3D1M count=3D4096

  $ stat source-disk.img
  =C2=A0=C2=A0File: =E2=80=98source-disk.img=E2=80=99
  =C2=A0=C2=A0Size: 4294967296      Blocks: 798656     IO Block: 4096   reg=
ular file
  Device: fc01h/64513d    Inode: 13247963    Links: 1
  Access: (0644/-rw-r--r--)  Uid: ( 1000/  smkent)   Gid: ( 1000/  smkent)
  Access: 2015-08-18 09:48:02.613988480 -0700
  Modify: 2015-08-18 09:48:02.825985646 -0700
  Change: 2015-08-18 09:48:02.825985646 -0700
  =C2=A0Birth: -

  $ qemu-img convert -f raw -o subformat=3Dfixed -O vpc source-disk.img
  dest-disk.vhd

  $ stat dest-disk.vhd
  =C2=A0=C2=A0File: =E2=80=98dest-disk.vhd=E2=80=99
  =C2=A0=C2=A0Size: 4296499712      Blocks: 535216     IO Block: 4096   reg=
ular file
  Device: fc01h/64513d    Inode: 13247964    Links: 1
  Access: (0644/-rw-r--r--)  Uid: ( 1000/  smkent)   Gid: ( 1000/  smkent)
  Access: 2015-08-18 09:50:22.252077624 -0700
  Modify: 2015-08-18 09:49:24.424868868 -0700
  Change: 2015-08-18 09:49:24.424868868 -0700
  =C2=A0Birth: -

  $ azure vm image create testimage1 dest-disk.vhd -o linux -l "West US"
  info:    Executing command vm image create
  + Retrieving storage accounts
  info:    VHD size : 4097 MB
  info:    Uploading 4195800.5 KB
  Requested:100.0% Completed:100.0% Running:   0 Time: 1m 0s Speed:  6744 K=
B/s
  info:    https://[redacted].blob.core.windows.net/vm-images/dest-disk.vhd=
 was uploaded successfully
  error:   The VHD https://[redacted].blob.core.windows.net/vm-images/dest-=
disk.vhd has an unsupported virtual size of 4296499200 bytes.  The size mus=
t be a whole number (in MBs).
  info:    Error information has been recorded to /home/smkent/.azure/azure=
.err
  error:   vm image create command failed

  =C2=A0* A fixed qemu-img will not result in an error during azure image
  creation. It will require passing -o force_size, which will leverage
  the backported functionality.

  [Regression Potential]

  =C2=A0* The upstream fix introduces a qemu-img option (-o force_size) whi=
ch
  is unset by default. The regression potential is very low, as a
  result.

  ...

  I also ran the above commands using qemu 2.4.0, which resulted in the
  same error as the conversion behavior is the same.

  However, qemu 2.1.1 and earlier (including qemu 2.0.0 installed by
  Ubuntu 14.04) does not pad the virtual disk size during conversion.
  Using qemu-img convert from qemu versions <=3D2.1.1 results in a VHD
  that is exactly the size of the raw input file plus 512 bytes (for the
  VHD footer). Those qemu versions do not attempt to realign the disk.
  As a result, Azure accepts VHD files created using those versions of
  qemu-img convert for upload.

  Is there a reason why newer qemu realigns the converted VHD file? It
  would be useful if an option were added to disable this feature, as
  current versions of qemu cannot be used to create VHD files for Azure
  using Microsoft's official instructions.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1490611/+subscriptions
