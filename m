Received: from eggs.gnu.org ([2001:4830:134:3::10]:37214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5XaN-0000zs-Hh
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5XaJ-0008OE-Bw
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:15:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:59564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f5XaJ-0008LD-4H
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:15:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f5XaH-0002pt-2G
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 14:15:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0EEA82E80CD
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 14:15:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Apr 2018 14:09:42 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1761535 <1761535@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152294403750.8450.15164247999601342743.malonedeb@soybean.canonical.com>
Message-Id: <152328298269.2319.12165270081836982743.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1761535] Re: qemu-aarch64-static docker
 arm64v8/openjdk coredump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I think this should be fixed by
https://patchwork.ozlabs.org/patch/896295/

(incidentally the segfault is in the guest /bin/sh, not in javac or ls.)


** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1761535

Title:
  qemu-aarch64-static docker arm64v8/openjdk coredump

Status in QEMU:
  In Progress

Bug description:
  I am using qemu-aarch64-static to run the arm64v8/openjdk official
  image on my x86 machine. Using QEMU master, I immediately hit a bug
  which hangs the container. With Ubuntu default version qemu-aarch64
  version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.24) and qemu-aarch64
  version 2.11.1 (v2.11.1-dirty) the hang does not take place.

  To reproduce (and get to the core dump):

  $ /tmp/tmptgyg3nvh/qemu-aarch64-static/qemu-aarch64-static -version
  qemu-aarch64 version 2.11.91 (v2.12.0-rc1-5-g47d3b60-dirty)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  $ docker run -it -v /tmp/tmptgyg3nvh/qemu-aarch64-static:/usr/bin/qemu-aa=
rch64-static arm64v8/openjdk /bin/bash
  root@bf75cf45d311:/# javac
  Usage: javac <options> <source files>
  where possible options include:
    -g                         Generate all debugging info
  <...snip...>
    @<filename>                Read options and filenames from file

  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  ...TERMINAL HANGS...

  =

  To get the core dump, In a separate terminal:

  # snapshot the file system of the hung image
  $ docker commit $(docker ps -aqf "name=3Dlatest_qemu") qemu_coredump

  # connect with known working qemu
  $ docker run -t -v /usr/bin/qemu-aarch64-static:/usr/bin/qemu-aarch64-sta=
tic  -i qemu_coredump /bin/bash

  $$ ls -lat
  total 10608
  <snip>
  -rw-r--r--   1 root root 10792960 Mar 29 18:02 qemu_bash_20180329-180251_=
1.core
  drwxrwxrwt   5 root root     4096 Mar 29 18:02 tmp
  <snip>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1761535/+subscriptions
