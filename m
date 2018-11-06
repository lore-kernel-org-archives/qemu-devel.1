Received: from eggs.gnu.org ([2001:4830:134:3::10]:49351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gK0kq-0004lC-9H
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gK0fL-00012G-67
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:41:14 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:46188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gK0fJ-0000h9-EG
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:41:05 -0500
Received: by mail-lf1-x141.google.com with SMTP id f23so4166409lfc.13
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 04:41:00 -0800 (PST)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Tue,  6 Nov 2018 18:40:50 +0600
Message-Id: <cover.1541507990.git.artem.k.pisarenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/2] chardev: fix mess in OPENED/CLOSED
 events when muxed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>

This issue actually more complex. Idea of generating events from inside function called '*_set_handlers' isn't good, at least its implicit nature, and especially a fact, that function decides about open state (see 'fe_open' variable), but generates event only in one direction. Combined with 'mux_chr_set_handlers()' hack this makes things even worse.
Better solution is to change fe interface and rewrite all frontends code (a lot of stuff in hw/char/* and somewhere else).
Although first patch doesn't fix any bug (known to me), its main effect is optimization of emulation performance by avoiding extra activity.
Added testing demonstrates issue and prevents potential bugs in future.

v3 changes:
 - extended commit message explaining fix (as supposed by Marc-André Lureau)

v2 changes:
 - fix failed unit test
 - 'mux_chr_set_handlers()' hack rewritten (as supposed by Marc-André Lureau)
 - added testing of issue to unit test (new patch)

Artem Pisarenko (2):
  chardev: fix mess in OPENED/CLOSED events when muxed
  tests/test-char: add muxed chardev testing for open/close

 chardev/char-fe.c         | 33 +++++++++++++------
 chardev/char-mux.c        | 16 +++++-----
 include/chardev/char-fe.h | 18 ++++++++++-
 tests/test-char.c         | 80 +++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 127 insertions(+), 20 deletions(-)

-- 
2.7.4
