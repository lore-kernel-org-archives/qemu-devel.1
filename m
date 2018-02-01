Received: from eggs.gnu.org ([2001:4830:134:3::10]:40010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ehFHc-0004G6-12
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ehFHZ-0000Qo-6X
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:52:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2159 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1ehFHY-0000Pi-Rf
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:52:05 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 1 Feb 2018 21:51:31 +0800
Message-ID: <1517493091-23620-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] rtc: placing RTC memory region outside BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, weidong.huang@huawei.com, Gonglei <arei.gonglei@huawei.com>

As windows guest use rtc as the clock source device,
and access rtc frequently. Let's move the rtc memory
region outside BQL to decrease overhead for windows guests.

$ cat strace_c.sh
strace -tt -p $1 -c -o result_$1.log &
sleep $2
pid=$(pidof strace)
kill $pid
cat result_$1.log

Before appling this change:
$ ./strace_c.sh 10528 30
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 93.87    0.119070          30      4000           ppoll
  3.27    0.004148           2      2038           ioctl
  2.66    0.003370           2      2014           futex
  0.09    0.000113           1       106           read
  0.09    0.000109           1       104           io_getevents
  0.02    0.000029           1        30           poll
  0.00    0.000000           0         1           write
------ ----------- ----------- --------- --------- ----------------
100.00    0.126839                  8293           total

After appling the change:
$ ./strace_c.sh 23829 30
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 92.86    0.067441          16      4094           ppoll
  4.85    0.003522           2      2136           ioctl
  1.17    0.000850           4       189           futex
  0.54    0.000395           2       202           read
  0.52    0.000379           2       202           io_getevents
  0.05    0.000037           1        30           poll
------ ----------- ----------- --------- --------- ----------------
100.00    0.072624                  6853           total

The futex call number decreases ~90.6% on an idle windows 7 guest.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 hw/timer/mc146818rtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 35a05a6..d9d99c5 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -986,6 +986,7 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     qemu_register_suspend_notifier(&s->suspend_notifier);
 
     memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
+    memory_region_clear_global_locking(&s->io);
     isa_register_ioport(isadev, &s->io, base);
 
     qdev_set_legacy_instance_id(dev, base, 3);
-- 
1.8.3.1
