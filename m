Received: from eggs.gnu.org ([2001:4830:134:3::10]:39705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIj6-0003Ud-WA
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIj3-0007MT-U4
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:17:08 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36970)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIj3-0007LX-Js
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:17:05 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Jul 2018 15:17:06 +0300
Message-ID: <20180725121706.12867.98787.stgit@pasha-VirtualBox>
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 24/24] slirp: fix ipv6 timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

ICMP implementation for IPv6 uses timers based on virtual clock.
This is incorrect because this service is not related to the guest state.
This patch changes using virtual clock to the realtime.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 slirp/ip6_icmp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index ee333d0..e25818e 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -17,7 +17,7 @@ static void ra_timer_handler(void *opaque)
 {
     Slirp *slirp = opaque;
     timer_mod(slirp->ra_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
+              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + NDP_Interval);
     ndp_send_ra(slirp);
 }
 
@@ -27,9 +27,9 @@ void icmp6_init(Slirp *slirp)
         return;
     }
 
-    slirp->ra_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, ra_timer_handler, slirp);
+    slirp->ra_timer = timer_new_ms(QEMU_CLOCK_REALTIME, ra_timer_handler, slirp);
     timer_mod(slirp->ra_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
+              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + NDP_Interval);
 }
 
 void icmp6_cleanup(Slirp *slirp)
