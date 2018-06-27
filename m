Received: from eggs.gnu.org ([2001:4830:134:3::10]:46170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quytelda@tamalin.org>) id 1fYBO8-0004ug-DY
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quytelda@tamalin.org>) id 1fYBO3-0001bi-4y
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:25:40 -0400
Received: from mout.perfora.net ([74.208.4.196]:53967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <quytelda@tamalin.org>)
	id 1fYBO2-0001aZ-Td
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:25:35 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]) by mrelay.perfora.net
	(mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
	0MHZc2-1fbTAe3Xhs-003UOY
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 16:25:32 +0200
Received: by mail-pl0-f45.google.com with SMTP id 31-v6so1123030plc.4
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 07:25:32 -0700 (PDT)
MIME-Version: 1.0
From: Quytelda Kahja <quytelda@tamalin.org>
Date: Wed, 27 Jun 2018 07:25:20 -0700
Message-ID: <CAFLvi203QwYCdfdhq6pb855xOZbt-bOiMsYU3cDSx6itHeu2=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [BUG] qed_aio_write_alloc: Assertion
 `s->allocating_acb == NULL' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello all,
I wanted to submit a bug report in the tracker, but it seem to require
an Ubuntu One account, which I'm having trouble with, so I'll just
give it here and hopefully somebody can make use of it.  The issue
seems to be in an experimental format, so it's likely not very
consequential anyway.

For the sake of anyone else simply googling for a workaround, I'll
just paste in the (cleaned up) brief IRC conversation about my issue
from the official channel:
<quy> I'm using QEMU version 2.12.0 on an x86_64 host (Arch Linux,
Kernel v4.17.2), and I'm trying to create an x86_64 virtual machine
(FreeBSD-11.1).  The VM always aborts at the same point in the
installation (downloading 'ports.tgz') with the following error
message:
"qemu-system-x86_64: /build/qemu/src/qemu-2.12.0/block/qed.c:1197:
qed_aio_write_alloc: Assertion `s->allocating_acb == NULL' failed.
zsh: abort (core dumped)  qemu-system-x86_64 -smp 2 -m 4096
-enable-kvm -hda freebsd/freebsd.qed -devic"
The commands I ran to create the machine are as follows:
"qemu-img create -f qed freebsd/freebsd.qed 16G"
"qemu-system-x86_64 -smp 2 -m 4096 -enable-kvm -hda
freebsd/freebsd.qed -device e1000,netdev=net0 -netdev user,id=net0
-cdrom FreeBSD-11.1-RELEASE-amd64-bootonly.iso -boot order=d"
I tried adding logging options with the -d flag, but I didn't get
anything that seemed relevant, since I'm not sure what to look for.
<stsquad> ohh what's a qed device?
<stsquad> quy: it might be a workaround to use a qcow2 image for now
<stsquad> ahh the wiki has a statement "It is not recommended to use
QED for any new images. "
<danpb> 'qed' was an experimental disk image format created by IBM
before qcow2 v3 came along
<danpb> honestly nothing should ever use  QED these days
<danpb> the good ideas from QED became  qcow2v3
<stsquad> danpb: sounds like we should put a warning on the option to
remind users of that fact
<danpb> quy: sounds like qed driver is simply broken - please do file
a bug against qemu bug tracker
<danpb> quy: but you should also really switch to qcow2
<quy> I see; some people need to update their wikis then.  I don't
remember where which guide I read when I first learned what little
QEMU I know, but I remember it specifically remember it saying QED was
the newest and most optimal format.
<stsquad> quy: we can only be responsible for our own wiki I'm afraid...
<danpb> if you remember where you saw that please let us know so we
can try to get it fixed
<quy> Thank you very much for the info; I will switch to QCOW.
Unfortunately, I'm not sure if I will be able to file any bug reports
in the tracker as I can't seem to log Launchpad, which it seems to
require.
<danpb> quy:  an email to the mailing list would suffice too if you
can't deal with launchpad
<danpb> kwolf: ^^^ in case you're interested in possible QED
assertions from 2.12

If any more info is needed, feel free to email me; I'm not actually
subscribed to this list though.
Thank you,
Quytelda Kahja
