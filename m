Received: from eggs.gnu.org ([2001:4830:134:3::10]:55377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fuBK3-0006IG-Ji
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fuBBj-0003aF-Nw
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:39:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:37652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fuBBj-0003a1-I2
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:39:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fuBBi-0005zd-Q6
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 06:39:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B84C52E8023
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 06:39:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Aug 2018 06:26:37 -0000
From: Thomas Huth <1493033@bugs.launchpad.net>
Reply-To: Bug 1493033 <1493033@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150907121719.19946.55925.malonedeb@soybean.canonical.com>
Message-Id: <153535119747.6126.362949851127683066.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1493033] Re: memory leak/high memory usage with
 spice webdav feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU and spice? Or could we close this ticket
nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1493033

Title:
  memory leak/high memory usage with spice webdav feature

Status in QEMU:
  Incomplete

Bug description:
  This bug is being open due the comment:
  https://bugs.freedesktop.org/show_bug.cgi?id=3D91350#c9

  Description of problem:
  When copying big files from client to guest, the memory usage in the host=
 grows by about the size of the file. This is partially spice problem due t=
he memory pool being able to increase as much as necessary without a limit =
which should be handled by the patches sent in the mailing list [0]

  [0] http://lists.freedesktop.org/archives/spice-
  devel/2015-August/021644.html

  At the same time, massif shows high memory usage by qemu as well [1]
  (output attached)

  [1] (peak)
  ->49.64% (267,580,319B) 0x308B89: malloc_and_trace (vl.c:2724)
  | ->49.38% (266,167,561B) 0x67CE678: g_malloc (gmem.c:97)
  | | ->49.03% (264,241,152B) 0x511D8E: qemu_coroutine_new (coroutine-ucont=
ext.c:106)
  | | | ->49.03% (264,241,152B) 0x510E24: qemu_coroutine_create (qemu-corou=
tine.c:74)
  (...)

  The file being shared was a 320M ogv video.

  Version-Release number of selected component (if applicable):
  QEMU emulator version 2.3.93
  SPICE and SPICE-GTK: from git master

  How reproducible:
  100%

  Steps to Reproduce:
  1-) build spice-gtk with --enable-webdav=3Dyes
  2-) enable webdav in your VM by following:
  https://elmarco.fedorapeople.org/manual.html#_folder_sharing
  3-) using remote-viewer with webdav patches, connects to a fedora guest
  4-) Open nautilus, go to 'Browse Network'
  5-) On remote-viewer, enable shared folder by File > Preferences > [X] Sh=
are folder
  6-) The spice client folder should appear: Double-click to mount it.
  7-) Check the memory of your qemu process
  8-) Copy a big file (let's say, 300 MB) from the shared folder to local VM
  9-) See the memory consumption of qemu grows by a lot;

  Actual results:
  Memory usage grows during copy and is not freed

  Expected results:
  Memory should have an upper limit to grow and should be freed after copy

  Additional info:
  Also reported in Fedora/rawhide: https://bugzilla.redhat.com/show_bug.cgi=
?id=3D1256376
  SPICE upstream bug: https://bugs.freedesktop.org/show_bug.cgi?id=3D91350

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1493033/+subscriptions
