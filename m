Received: from eggs.gnu.org ([2001:4830:134:3::10]:58026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshy-0005fW-Hk
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshx-0003Dj-QD
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:50 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshx-0003CK-Jg
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:49 -0400
Received: by mail-wm0-x241.google.com with SMTP id h21so868361wmd.1
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:49 -0700 (PDT)
Received: from donizetti.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	x107sm1557951wrb.97.2018.03.13.15.47.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 13 Mar 2018 15:47:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:32 +0100
Message-Id: <20180313224719.4954-23-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/69] rcutorture: remove synchronize_rcu from
 readers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This gives much worse numbers for readers, especially if synchronize_rcu
is made more expensive as is the case with --enable-membarrier.  Before:

   $ tests/rcutorture 10 stress 10
   n_reads: 98304  n_updates: 529  n_mberror: 0
   rcu_stress_count: 98302 2 0 0 0 0 0 0 0 0 0

After:

   $ tests/rcutorture 10 stress 10
   n_reads: 165158482  n_updates: 429  n_mberror: 0
   rcu_stress_count: 165154364 4118 0 0 0 0 0 0 0 0 0

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/rcutorture.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 4002ecf123..49311c82ea 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -238,7 +238,6 @@ long long rcu_stress_count[RCU_STRESS_PIPE_LEN + 1];
 static void *rcu_read_stress_test(void *arg)
 {
     int i;
-    int itercnt = 0;
     struct rcu_stress *p;
     int pc;
     long long n_reads_local = 0;
@@ -269,9 +268,6 @@ static void *rcu_read_stress_test(void *arg)
         }
         rcu_stress_local[pc]++;
         n_reads_local++;
-        if ((++itercnt % 0x1000) == 0) {
-            synchronize_rcu();
-        }
     }
     qemu_mutex_lock(&counts_mutex);
     n_reads += n_reads_local;
-- 
2.14.3
