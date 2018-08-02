Received: from eggs.gnu.org ([2001:4830:134:3::10]:37171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flEwz-0004mE-Tb
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flEww-0001LD-PT
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:51:37 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  2 Aug 2018 17:50:24 +0300
Message-Id: <d655ef7e4063be4b540b9e748af31d951d846775.1533219143.git.berto@igalia.com>
In-Reply-To: <cover.1533219143.git.berto@igalia.com>
References: <cover.1533219143.git.berto@igalia.com>
In-Reply-To: <cover.1533219143.git.berto@igalia.com>
References: <cover.1533219143.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/4] throttle-groups: Skip the round-robin if a
 member is being drained
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

In the throttling code after an I/O request has been completed the
next one is selected from a different member using a round-robin
algorithm. This ensures that all members get a chance to finish their
pending I/O requests.

However, if a group member has its I/O limits disabled (because it's
being drained) then we should always give it priority in order to have
all its pending requests finished as soon as possible.

If we don't do this we could have a member in the process of being
drained waiting for the throttled requests of other members, for which
the I/O limits still apply.

This can have additional consequences: if we're running in qtest mode
(with QEMU_CLOCK_VIRTUAL) then timers can only fire if we advance the
clock manually, so attempting to drain a block device can hang QEMU in
the BDRV_POLL_WHILE() loop at the end of bdrv_do_drained_begin().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/throttle-groups.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index e297b04e17..d46c56b31e 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -221,6 +221,15 @@ static ThrottleGroupMember *next_throttle_token(ThrottleGroupMember *tgm,
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     ThrottleGroupMember *token, *start;
 
+    /* If this member has its I/O limits disabled then it means that
+     * it's being drained. Skip the round-robin search and return tgm
+     * immediately if it has pending requests. Otherwise we could be
+     * forcing it to wait for other member's throttled requests. */
+    if (tgm_has_pending_reqs(tgm, is_write) &&
+        atomic_read(&tgm->io_limits_disabled)) {
+        return tgm;
+    }
+
     start = token = tg->tokens[is_write];
 
     /* get next bs round in round robin style */
-- 
2.11.0
