Received: from eggs.gnu.org ([2001:4830:134:3::10]:59509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQR-0003MV-GZ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQN-0005fP-OR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:03 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQN-0005f7-I6
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:41:59 -0400
Received: by mail-wm0-x241.google.com with SMTP id d127so11018716wmf.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:41:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:21 +0200
Message-Id: <1496320911-51305-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/33] mc146818rtc: ensure LOST_TICK_POLICY_SLEW
 is only enabled on TARGET_I386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Any tick policy specified on other platforms rather on TARGET_I386
will fall back to LOST_TICK_POLICY_DISCARD silently, this patch makes
sure only TARGET_I386 can enable LOST_TICK_POLICY_SLEW

After that, we can enable LOST_TICK_POLICY_SLEW in the common code
which need not use '#ifdef TARGET_I386' to make these code be x86
specific anymore

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20170510083259.3900-4-xiaoguangrong@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index aeb60cc..4870a72 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -974,19 +974,19 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
 
     rtc_set_date_from_host(isadev);
 
-#ifdef TARGET_I386
     switch (s->lost_tick_policy) {
+#ifdef TARGET_I386
     case LOST_TICK_POLICY_SLEW:
         s->coalesced_timer =
             timer_new_ns(rtc_clock, rtc_coalesced_timer, s);
         break;
+#endif
     case LOST_TICK_POLICY_DISCARD:
         break;
     default:
         error_setg(errp, "Invalid lost tick policy.");
         return;
     }
-#endif
 
     s->periodic_timer = timer_new_ns(rtc_clock, rtc_periodic_timer, s);
     s->update_timer = timer_new_ns(rtc_clock, rtc_update_timer, s);
-- 
1.8.3.1
