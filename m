Received: from eggs.gnu.org ([2001:4830:134:3::10]:44454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cedtg-0002Y4-KS
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cedtb-0000EZ-Mo
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:28:08 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <skiver.cloud.yzy@gmail.com>)
	id 1cedtb-0000E3-HP
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:28:03 -0500
Received: by mail-pg0-x244.google.com with SMTP id a123so1590984pgc.3
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 00:28:03 -0800 (PST)
From: Ziyue Yang <skiver.cloud.yzy@gmail.com>
Date: Fri, 17 Feb 2017 16:27:03 +0800
Message-Id: <20170217082704.23270-2-skiver.cloud.yzy@gmail.com>
In-Reply-To: <20170217082704.23270-1-skiver.cloud.yzy@gmail.com>
References: <20170217082704.23270-1-skiver.cloud.yzy@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] monitor.c: make mon_get_cpu return NULL
 when there is no CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, Ziyue Yang <yzylivezh@hotmail.com>, Ziyue Yang <skiver.cloud.yzy@gmail.com>

From: Ziyue Yang <yzylivezh@hotmail.com>

Currently mon_get_cpu always dereferences first_cpu without checking
whether it's a valid pointer. This commit adds check before dereferencing,
and reports "No CPU" info if there isn't any CPU then returns NULL.

Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>
---
 monitor.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index 3cd72a9bab..6b25cf7a2b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1026,6 +1026,10 @@ int monitor_set_cpu(int cpu_index)
 CPUState *mon_get_cpu(void)
 {
     if (!cur_mon->mon_cpu) {
+        if (!first_cpu) {
+            monitor_printf(cur_mon, "No CPU available on this machine\n");
+            return NULL;
+        }
         monitor_set_cpu(first_cpu->cpu_index);
     }
     cpu_synchronize_state(cur_mon->mon_cpu);
@@ -2495,11 +2499,11 @@ static int default_fmt_size = 4;
 static int is_valid_option(const char *c, const char *typestr)
 {
     char option[3];
-  
+
     option[0] = '-';
     option[1] = *c;
     option[2] = '\0';
-  
+
     typestr = strstr(typestr, option);
     return (typestr != NULL);
 }
@@ -2864,7 +2868,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     p++;
                     if(c != *p) {
                         if(!is_valid_option(p, typestr)) {
-                  
+
                             monitor_printf(mon, "%s: unsupported option -%c\n",
                                            cmd->name, *p);
                             goto fail;
-- 
2.11.0
