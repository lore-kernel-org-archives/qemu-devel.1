Received: from eggs.gnu.org ([2001:4830:134:3::10]:56351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCp3-0001DQ-07
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCoz-0004db-Vm
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:55:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:53288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRCoz-0004dV-PE
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:55:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRCoy-0000F1-Rz
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:55:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A93482E80C9
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:55:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 06:43:43 -0000
From: Thomas Huth <1586756@bugs.launchpad.net>
Reply-To: Bug 1586756 <1586756@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160529110018.18315.70473.malonedeb@soybean.canonical.com>
Message-Id: <20170111064343.21157.67004.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1586756] Re: "-serial unix:" option of
 qemu-system-arm is broken in qemu 2.6.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has been committed here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D6ab3fc32ea640026726b
... and been released with QEMU version 2.8

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1586756

Title:
  "-serial unix:" option of qemu-system-arm is broken in qemu 2.6.0

Status in QEMU:
  Fix Released

Bug description:
  I found a bug of "-serial unix:PATH_TO_SOCKET" in qemu 2.6.0 (qemu 2.5.1 =
works fine).
  Occasionally, a part of the output of qemu disappears in the bug.

  It looks like following commit is the cause:

  char: ensure all clients are in non-blocking mode (Author: Daniel P. Berr=
ange <berrange@redhat.com>)
  http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D64c800f8087485227278=
47b9cdc73412f22dffb9

  In this commit, UNIX socket is set to non-blocking mode, but qemu_chr_fe_=
write function doesn't handle EAGAIN.
  You should fix code like that:

  ---
  diff --git a/qemu-char.c b/qemu-char.c
  index b597ee1..0361d78 100644
  --- a/qemu-char.c
  +++ b/qemu-char.c
  @@ -270,6 +270,7 @@ static int qemu_chr_fe_write_buffer(CharDriverState *=
s, const uint8_t *buf, int
   int qemu_chr_fe_write(CharDriverState *s, const uint8_t *buf, int len)
   {
       int ret;
  +    int offset =3D 0;
   =

       if (s->replay && replay_mode =3D=3D REPLAY_MODE_PLAY) {
           int offset;
  @@ -280,7 +281,21 @@ int qemu_chr_fe_write(CharDriverState *s, const uint=
8_t *buf, int len)
       }
   =

       qemu_mutex_lock(&s->chr_write_lock);
  -    ret =3D s->chr_write(s, buf, len);
  +
  +    while (offset < len) {
  +    retry:
  +        ret =3D s->chr_write(s, buf, len);
  +        if (ret < 0 && errno =3D=3D EAGAIN) {
  +            g_usleep(100);
  +            goto retry;
  +        }
  +
  +        if (ret <=3D 0) {
  +            break;
  +        }
  +
  +        offset +=3D ret;
  +    }
   =

       if (ret > 0) {
           qemu_chr_fe_write_log(s, buf, ret);
  ---

  Or please do "git revert 64c800f808748522727847b9cdc73412f22dffb9".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1586756/+subscriptions
