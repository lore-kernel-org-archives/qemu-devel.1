Received: from eggs.gnu.org ([2001:4830:134:3::10]:44104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVzPG-00068O-0x
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVzP9-0000CY-SF
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:09:14 -0400
Received: from [2001:8b0:1d0::2] (port=37624 helo=orth.archaic.org.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dVzP9-00005E-LW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:09:07 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 12:12:23 +0100
Message-Id: <1500030745-10619-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/2] slirp: handle errors in sosendoob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

At the moment the slirp sosendoob() function doesn't properly
handle errors from slirp_send(), and its callers don't do
anything with its return value either. (Coverity spots the
latter as CID 1005633.)

This patchset attempts to fix that. In the first patch we
fix sosendoob() itself so that we return errors to the caller
and treat short writes as reducing the amount of urgent data
to be sent. In the second patch we make the call in sowrite()
treat any return form sosendoob() which didn't transfer all
the urgent data as a "disconnect the socket" error in the
same way that it already handles errors for writes of
non-urgent data. The call to sosendoob() in sbappend() can
safely ignore any failures as in this case sowrite() will be
called shortly and will deal with them.

Coding style: I've opted to stick with the tab-indent
that the slirp code uses rather than reindent to QEMU standard.
Happy to go the other way if the maintainer prefers.

Changes v1->v2:
 * since sosendoob() updates so->so_urgc, we need to
   capture the old value to check that the write has
   actually written what it is supposed to.

thanks
-- PMM

Peter Maydell (2):
  slirp: Handle error returns from slirp_send() in sosendoob()
  slirp: Handle error returns from sosendoob()

 slirp/sbuf.c   |  2 +-
 slirp/socket.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 18 deletions(-)

-- 
2.7.4
