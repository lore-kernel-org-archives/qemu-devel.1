Received: from eggs.gnu.org ([2001:4830:134:3::10]:46197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chIdn-0006pa-F8
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chIdk-0001v7-6L
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:22:43 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chIdk-0001uJ-0Q
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:22:40 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so3738105wmv.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 08:22:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CAJSP0QVjokCyvVtDcyWBhDqsWKwdNX6zyAo1uL9VmyzMfakS9A@mail.gmail.com>
	<87y3wwy9gb.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a1cfbe26-c85a-e521-dfcf-5b31913394c4@redhat.com>
Date: Fri, 24 Feb 2017 17:22:36 +0100
MIME-Version: 1.0
In-Reply-To: <87y3wwy9gb.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Hang in aio/multi/mutex/mcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>



On 23/02/2017 20:48, Alex Bennée wrote:
> Hope that helps the debugging ;-)

Worst case we can just remove the test (it's only there for performance
comparison, not a bug in actual QEMU code), but this seems to help here:

diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
index f11e990..8b0b40e 100644
--- a/tests/test-aio-multithread.c
+++ b/tests/test-aio-multithread.c
@@ -309,7 +309,7 @@ static void mcs_mutex_lock(void)
 static void mcs_mutex_unlock(void)
 {
     int next;
-    if (nodes[id].next == -1) {
+    if (atomic_read(&nodes[id].next) == -1) {
         if (atomic_read(&mutex_head) == id &&
             atomic_cmpxchg(&mutex_head, id, -1) == id) {
             /* Last item in the list, exit.  */
@@ -323,7 +323,7 @@ static void mcs_mutex_unlock(void)
     }

     /* Wake up the next in line.  */
-    next = nodes[id].next;
+    next = atomic_read(&nodes[id].next);
     nodes[next].locked = 0;
     qemu_futex_wake(&nodes[next].locked, 1);
 }

Paolo
