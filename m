Received: from eggs.gnu.org ([2001:4830:134:3::10]:48275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fx94r-0005Hn-9g
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fx94n-0000D6-Su
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:00:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:33006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fx94n-0000CE-MW
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:00:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fx94m-0003yc-Oe
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 11:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B55202E80C8
	for <qemu-devel@nongnu.org>; Tue,  4 Sep 2018 11:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Sep 2018 10:54:15 -0000
From: Daniel Berrange <1790617@bugs.launchpad.net>
Reply-To: Bug 1790617 <1790617@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153605729836.31419.16934091552250503095.malonedeb@soybean.canonical.com>
Message-Id: <153605845587.31697.12635771253892967934.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1790617] Re: Version of disk image format not
 exhibited using the 'qemu-img info' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There's no concept of versions for "raw" images as there's no metadata
at all - its just raw disk content.

For the qcow2 format, the version 2 vs version 3 distinction is not
something that is intended to be exposed externally. A version 3 format
file is still handled by the qcow2 format driver, and there is no qcow3
driver.

At an end user level you can specify a compatibility level "0.10" vs
"1.1" which indicates what QEMU version your image shuld be compatible
with - from 'man qemu-img':

         "compat"
             Determines the qcow2 version to use. "compat=3D0.10" uses the =
traditional image format
             that can be read by any QEMU since 0.10.  "compat=3D1.1" enabl=
es image format extensions
             that only QEMU 1.1 and newer understand (this is the default).=
 Amongst others, this
             includes zero clusters, which allow efficient copy-on-read for=
 sparse images.

Internally, compat=3D1.1, will cause qemu to use qcow2 version 3, but
that's not something users should be concerned with.

Docs that talk about version 2 vs version 3 should be fixed as that's
not something user should be exposed to. They should just talk about the
compat level.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1790617

Title:
  Version of disk image format not exhibited using the 'qemu-img info'
  command

Status in QEMU:
  Invalid

Bug description:
  OS: Fedora (64 bits) =E2=80=93 Linux =E2=80=93. Last available component:=
 qemu-
  img.x86_64 2:2.11.2-2.fc28

  Description: version of disk image format not exhibited using the
  'qemu-img info' command.

  Command 'qemu-img info qcow2 [image-file-name.img]' produces this stderr =
message:
  qemu-img: Expecting one image file name
  Try 'qemu-img --help' for more information

  How to reproduce in terminal:
  1. Create a VM using Raw disk image format =

  2. Run either commands 'qemu-img info -f raw [image-file-name.img]', 'qem=
u-img info [image-file-name.img]'.
  3. Run either commands 'qemu-img info -f qcow2 [image-file-name.qcow2]', =
'qemu-img info [image-file-name.qcow2]'.

  Actual result: output model resulting from step .2 exhibits following inf=
ormations:
  image: image-file-name.img
  file format: raw
  virtual size: _G (_ bytes)
  disk size: _G

  Output model resulting from step .3 exhibits following informations:
  image: image-file-name.qcow2
  file format: qcow2
  virtual size: _G (_ bytes)
  disk size: _G
  cluster_size: _
  Snapshot list:
  ID        TAG                 VM SIZE                DATE       VM CLOCK
  1         snapshot1          _G 2018-07-31 18:27:49   00:03:45.890

  Format specific information:
      compat: 1.1
      lazy refcounts: true
      refcount bits: 16
      corrupt: false

  Actual result: raw and qcow2 formats respective versions =E2=80=93which a=
re
  likely to be mentioned as "version"=E2=80=93 to be exhibited.

  Additional information: in documentation lastly updated 2018-08-23 at
  https://access.redhat.com/documentation/en-
  us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administ=
ration_guide/index
  it is stated in chapters:

  14.10 =E2=80=93 'images in raw format can be resized in both directions, =
whereas qcow2 version 2 or qcow2 version 3 images can be grown';
  14.12 =E2=80=93 'the qcow2 version supplied with Red Hat Enterprise Linux=
 7 is 1.1', 'To know which version you are using, run qemu-img info qcow2 [=
imagefilename.img] command.'.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1790617/+subscriptions
