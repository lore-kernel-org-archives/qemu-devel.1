Received: from eggs.gnu.org ([2001:4830:134:3::10]:42920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d8N3o-0000hB-SR
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d8N3o-0003kV-2Y
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:28 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d8N3n-0003k0-Tt
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:28 -0400
Received: by mail-pg0-x243.google.com with SMTP id 64so3227262pgb.3
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 01:33:27 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed, 10 May 2017 16:32:57 +0800
Message-Id: <20170510083259.3900-4-xiaoguangrong@tencent.com>
In-Reply-To: <20170510083259.3900-1-xiaoguangrong@tencent.com>
References: <20170510083259.3900-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 3/5] mc146818rtc: ensure
 LOST_TICK_POLICY_SLEW is only enabled on TARGET_I386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Any tick policy specified on other platforms rather on TARGET_I386
will fall back to LOST_TICK_POLICY_DISCARD silently, this patch makes
sure only TARGET_I386 can enable LOST_TICK_POLICY_SLEW

After that, we can enable LOST_TICK_POLICY_SLEW in the common code
which need not use '#ifdef TARGET_I386' to make these code be x86
specific anymore

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/timer/mc146818rtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index dac6744..9810bd5 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -980,19 +980,19 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
 
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
2.9.3
