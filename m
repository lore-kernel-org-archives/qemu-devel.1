Received: from eggs.gnu.org ([2001:4830:134:3::10]:36292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA8-0000dE-SA
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA7-0005bZ-IQ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52175)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqXA6-0005Yx-KV
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 17 Aug 2018 01:18:50 -0400
Message-Id: <20180817051853.23792-7-cota@braap.org>
In-Reply-To: <20180817051853.23792-1-cota@braap.org>
References: <20180817051853.23792-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 6/9] tests/atomic_add-bench: add -p to enable
 sync profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Fam Zheng <famz@redhat.com>

When used together with -m, this allows us to benchmark the
profiler's performance impact on qemu_mutex_lock.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/atomic_add-bench.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
index f96d448f77..2f6c72f63a 100644
--- a/tests/atomic_add-bench.c
+++ b/tests/atomic_add-bench.c
@@ -26,6 +26,7 @@ static bool test_stop;
 static const char commands_string[] =
     " -n = number of threads\n"
     " -m = use mutexes instead of atomic increments\n"
+    " -p = enable sync profiler\n"
     " -d = duration in seconds\n"
     " -r = range (will be rounded up to pow2)";
 
@@ -143,7 +144,7 @@ static void parse_args(int argc, char *argv[])
     int c;
 
     for (;;) {
-        c = getopt(argc, argv, "hd:n:mr:");
+        c = getopt(argc, argv, "hd:n:mpr:");
         if (c < 0) {
             break;
         }
@@ -160,6 +161,9 @@ static void parse_args(int argc, char *argv[])
         case 'm':
             use_mutex = true;
             break;
+        case 'p':
+            qsp_enable();
+            break;
         case 'r':
             range = pow2ceil(atoi(optarg));
             break;
-- 
2.17.1
