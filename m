Received: from eggs.gnu.org ([2001:4830:134:3::10]:38178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jrtc27@jrtc27.com>) id 1f8RKI-0002x4-AW
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jrtc27@jrtc27.com>) id 1f8RKC-00050w-FG
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:11:18 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jrtc27@jrtc27.com>) id 1f8RKC-0004zm-75
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:11:12 -0400
Received: by mail-wr0-x244.google.com with SMTP id w3so19339662wrg.2
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 07:11:11 -0700 (PDT)
From: James Clarke <jrtc27@jrtc27.com>
Date: Tue, 17 Apr 2018 15:10:58 +0100
Message-Id: <20180417141058.31236-1-jrtc27@jrtc27.com>
Subject: [Qemu-devel] [PATCH] slirp: Send window updates to guest after
 window was closed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: James Clarke <jrtc27@jrtc27.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

If the receive window presented to the guest closes, slirp should send a
window update once the window reopens sufficiently, rather than forcing
the guest to send a window probe, which can take several seconds.

Signed-off-by: James Clarke <jrtc27@jrtc27.com>
---

Hi,
I encountered this whilst running a (k)FreeBSD build server for Debian.
The host's upload link is over ADSL and thus rather slow, so slirp's
outgoing buffer soon fills up, causing it to close its receive window.
However, without this patch, slirp does not send a window update back to
the guest once it starts draining its outgoing buffer and thus opening
its receive window, causing the guest to remain blocked until its
persist timer next fires and it sends a zero window probe. In the case
of a Linux guest, this starts at ~200ms and grows exponentially, though
most of the time the receive window has already opened by then and thus
the unnecessary delay doesn't have too much of an effect, but the
FreeBSD network stack defaults to a 5s minimum for the persist timer and
thus spends the vast majority of its time not transmitting data, with
the upload speed achieved around 10 KiB/s for this particular guest and
link.

VirtualBox, which uses slirp for its NAT networking mode, also
encountered this and fixed it back in 2014 with [1], but interestingly
decided to set its own delayed ACK flag and wait for its own timer to
fire, rather than calling tcp_output directly. I don't know what their
motivation for that decision was, but to me that seems to add an
unnecessary delay of up to a few hundred ms (though that is of course
still much better than 5s).

I have been testing this patch for the past few days with the build
server uploading its huge backlog of packages one at a time. It is now
reaching 1.3 Mbit/s and networking has remained seemingly stable.

Regards,
James

[1] https://github.com/mirror/vbox/commit/87c7aa2e8d26b989da6e85d532695f1e3b050aaa

 slirp/slirp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 1cb6b07004..238fb04115 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -676,13 +676,13 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
                         /* continue; */
                     } else {
                         ret = sowrite(so);
+                        if (ret > 0) {
+                            /* Call tcp_output in case we need to send a window
+                             * update to the guest, otherwise it will be stuck
+                             * until it sends a window probe. */
+                            tcp_output(sototcpcb(so));
+                        }
                     }
-                    /*
-                     * XXXXX If we wrote something (a lot), there
-                     * could be a need for a window update.
-                     * In the worst case, the remote will send
-                     * a window probe to get things going again
-                     */
                 }

                 /*
--
2.17.0
