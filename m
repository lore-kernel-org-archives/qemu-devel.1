Received: from eggs.gnu.org ([2001:4830:134:3::10]:33708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4n-0002II-S2
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4W-0006oj-Fr
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:11 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:40649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4V-00067s-HC
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:59 -0400
Received: by mail-wm0-x229.google.com with SMTP id y9-v6so3497250wma.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:58 +0200
Message-Id: <1534870966-9287-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 26/74] hmp-commands-info: add sync-profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

The command introduced here is just for developers. This means that:

- the info displayed and the output format could change in the future
- the command is only meant to be used from HMP, not from QMP

Sample output:

(qemu) sync-profile
sync-profile is off
(qemu) info sync-profile
Type               Object  Call site  Wait Time (s)         Count  Average (us)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
(qemu) sync-profile on
(qemu) sync-profile
sync-profile is on
(qemu) info sync-profile 15
Type               Object  Call site                 Wait Time (s)         Count  Average (us)
----------------------------------------------------------------------------------------------
condvar    0x55a01813ced0  cpus.c:1165                    91.38235          2842      32154.24
BQL mutex  0x55a0171b7140  cpus.c:1434                    12.56490          5787       2171.23
BQL mutex  0x55a0171b7140  accel/tcg/cpu-exec.c:432        7.75846          2844       2728.01
BQL mutex  0x55a0171b7140  accel/tcg/cputlb.c:870          5.09889          2884       1767.99
BQL mutex  0x55a0171b7140  accel/tcg/cpu-exec.c:529        3.46140          3254       1063.74
BQL mutex  0x55a0171b7140  accel/tcg/cputlb.c:804          0.76333          8655         88.20
BQL mutex  0x55a0171b7140  cpus.c:1466                     0.60893          2941        207.05
BQL mutex  0x55a0171b7140  util/main-loop.c:236            0.00894          6425          1.39
mutex      [           3]  util/qemu-timer.c:520           0.00342         50611          0.07
mutex      [           2]  util/qemu-timer.c:426           0.00254         31336          0.08
mutex      [           3]  util/qemu-timer.c:234           0.00107         19275          0.06
mutex      0x55a0171d9960  vl.c:763                        0.00043          6425          0.07
mutex      0x55a0180d1bb0  monitor.c:458                   0.00015          1603          0.09
mutex      0x55a0180e4c78  chardev/char.c:109              0.00002           217          0.08
mutex      0x55a0180d1bb0  monitor.c:448                   0.00001           162          0.08
----------------------------------------------------------------------------------------------
(qemu) info sync-profile -m 15
Type               Object  Call site                 Wait Time (s)         Count  Average (us)
----------------------------------------------------------------------------------------------
condvar    0x55a01813ced0  cpus.c:1165                    95.11196          3051      31174.03
BQL mutex  0x55a0171b7140  accel/tcg/cpu-exec.c:432        7.92108          3052       2595.37
BQL mutex  0x55a0171b7140  cpus.c:1434                    13.38253          6210       2155.00
BQL mutex  0x55a0171b7140  accel/tcg/cputlb.c:870          5.09901          3093       1648.57
BQL mutex  0x55a0171b7140  accel/tcg/cpu-exec.c:529        4.21123          3468       1214.31
BQL mutex  0x55a0171b7140  cpus.c:1466                     0.60895          3156        192.95
BQL mutex  0x55a0171b7140  accel/tcg/cputlb.c:804          0.76337          9282         82.24
BQL mutex  0x55a0171b7140  util/main-loop.c:236            0.00944          6889          1.37
mutex      0x55a01813ce80  tcg/tcg.c:397                   0.00000            24          0.15
mutex      0x55a0180d1bb0  monitor.c:458                   0.00018          1922          0.09
mutex      [           2]  util/qemu-timer.c:426           0.00266         32710          0.08
mutex      0x55a0180e4c78  chardev/char.c:109              0.00002           260          0.08
mutex      0x55a0180d1bb0  monitor.c:448                   0.00001           187          0.08
mutex      0x55a0171d9960  vl.c:763                        0.00047          6889          0.07
mutex      [           3]  util/qemu-timer.c:520           0.00362         53377          0.07
----------------------------------------------------------------------------------------------
(qemu) info sync-profile -m -n 15
Type               Object  Call site                 Wait Time (s)         Count  Average (us)
----------------------------------------------------------------------------------------------
condvar    0x55a01813ced0  cpus.c:1165                   101.39331          3398      29839.12
BQL mutex  0x55a0171b7140  accel/tcg/cpu-exec.c:432        7.92112          3399       2330.43
BQL mutex  0x55a0171b7140  cpus.c:1434                    14.28280          6922       2063.39
BQL mutex  0x55a0171b7140  accel/tcg/cputlb.c:870          5.77505          3445       1676.36
BQL mutex  0x55a0171b7140  accel/tcg/cpu-exec.c:529        5.66139          3883       1457.99
BQL mutex  0x55a0171b7140  cpus.c:1466                     0.60901          3519        173.06
BQL mutex  0x55a0171b7140  accel/tcg/cputlb.c:804          0.76351         10338         73.85
BQL mutex  0x55a0171b7140  util/main-loop.c:236            0.01032          7664          1.35
mutex      0x55a0180e4f08  util/qemu-timer.c:426           0.00041           901          0.45
mutex      0x55a01813ce80  tcg/tcg.c:397                   0.00000            24          0.15
mutex      0x55a0180d1bb0  monitor.c:458                   0.00022          2319          0.09
mutex      0x55a0180e4c78  chardev/char.c:109              0.00003           306          0.08
mutex      0x55a0180e4f08  util/qemu-timer.c:520           0.00068          8565          0.08
mutex      0x55a0180d1bb0  monitor.c:448                   0.00002           215          0.08
mutex      0x55a0180e4f78  util/qemu-timer.c:426           0.00247         34224          0.07
----------------------------------------------------------------------------------------------
(qemu) sync-profile reset
(qemu) info sync-profile -m 2
Type               Object  Call site               Wait Time (s)         Count  Average (us)
--------------------------------------------------------------------------------------------
condvar    0x55a01813ced0  cpus.c:1165                   2.78756            99      28157.12
BQL mutex  0x55a0171b7140  accel/tcg/cputlb.c:870        0.33054           102       3240.55
--------------------------------------------------------------------------------------------
(qemu) sync-profile off
(qemu) sync-profile
sync-profile is off
(qemu) sync-profile reset
(qemu) info sync-profile
Type               Object  Call site  Wait Time (s)         Count  Average (us)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hmp-commands-info.hx | 22 ++++++++++++++++++++++
 monitor.c            | 11 +++++++++++
 2 files changed, 33 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 70639f6..cbee8b9 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -300,6 +300,28 @@ Show dynamic compiler opcode counters
 ETEXI
 
     {
+        .name       = "sync-profile",
+        .args_type  = "mean:-m,no_coalesce:-n,max:i?",
+        .params     = "[-m] [-n] [max]",
+        .help       = "show synchronization profiling info, up to max entries "
+                      "(default: 10), sorted by total wait time. (-m: sort by "
+                      "mean wait time; -n: do not coalesce objects with the "
+                      "same call site)",
+        .cmd        = hmp_info_sync_profile,
+    },
+
+STEXI
+@item info sync-profile [-m|-n] [@var{max}]
+@findex info sync-profile
+Show synchronization profiling info, up to @var{max} entries (default: 10),
+sorted by total wait time.
+        -m: sort by mean wait time
+        -n: do not coalesce objects with the same call site
+When different objects that share the same call site are coalesced, the "Object"
+field shows---enclosed in brackets---the number of objects being coalesced.
+ETEXI
+
+    {
         .name       = "kvm",
         .args_type  = "",
         .params     = "",
diff --git a/monitor.c b/monitor.c
index a1999e3..94f6735 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1454,6 +1454,17 @@ static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
 }
 #endif
 
+static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
+{
+    int64_t max = qdict_get_try_int(qdict, "max", 10);
+    bool mean = qdict_get_try_bool(qdict, "mean", false);
+    bool coalesce = !qdict_get_try_bool(qdict, "no_coalesce", false);
+    enum QSPSortBy sort_by;
+
+    sort_by = mean ? QSP_SORT_BY_AVG_WAIT_TIME : QSP_SORT_BY_TOTAL_WAIT_TIME;
+    qsp_report((FILE *)mon, monitor_fprintf, max, sort_by, coalesce);
+}
+
 static void hmp_info_history(Monitor *mon, const QDict *qdict)
 {
     int i;
-- 
1.8.3.1
