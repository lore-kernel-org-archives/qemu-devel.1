Received: from eggs.gnu.org ([2001:4830:134:3::10]:39802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK3Hd-0002FR-Nr
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK3Hc-000775-Sx
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gK3HX-0006vv-An
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:45 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 15:13:19 +0000
Message-Id: <20181106151323.16154-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1 0/4] slirp: fix coverity issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

There are three outstanding Coverity issues for the slirp code.
This patchset fixes them:
 * easiest first, we explicitly check for so->s == -1 in slirp_send()
   to avoid possibly passing -1 to the send() function.
   In an ideal world we could assert() it wasn't -1, but the
   slirp code is too complicated to be sure...
 * we render a bug in an error-handling codepath moot by
   switching socreate() to use g_new() rather than malloc(),
   which means it can no longer fail and we can delete all the
   error-handling code
 * last and most complicated, we fix a lack of error handling
   and possible deadlock in fork_exec() by moving the child
   socket creation and connect to before fork(), where we can
   handle the errors appropriately

Tested with an aarch64 Linux guest which I got to do various
networky things including an 'apt-get update' and downloading
some packages. Also tested the '-net user,smb=/some/dir' which
is the most common use of the fork_exec() codepath.

I've taken the usual approach of "fix up the indentation
only locally so as to placate checkpatch" with this patchset.
Happy to adjust if you have some other preference.
(I'm veering towards the opinion that at some point we should
just say "globally reindent slirp/, because the piecemeal
approach hasn't in practice resulted in a very good outcome";
but that's up to you.)

Peter Maydell (4):
  slirp: Don't pass possibly -1 fd to send()
  slirp: Use g_new() to allocate sockets in socreate()
  slirp: Remove code that handles socreate() failure
  slirp: fork_exec(): create and connect child socket before fork()

 slirp/ip_icmp.c   |  2 +-
 slirp/misc.c      | 55 +++++++++++++++++++++++++++++------------------
 slirp/slirp.c     | 14 +++++++++---
 slirp/socket.c    | 17 ++++++---------
 slirp/tcp_input.c |  7 +++---
 slirp/tcp_subr.c  |  7 +-----
 slirp/udp.c       |  6 ------
 slirp/udp6.c      |  3 ---
 8 files changed, 56 insertions(+), 55 deletions(-)

-- 
2.19.1
