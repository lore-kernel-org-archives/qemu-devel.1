Received: from eggs.gnu.org ([2001:4830:134:3::10]:56051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMzzD-0004oq-R1
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMzz8-0003mR-JE
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:33:59 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55291)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gMzz6-0003k4-HO
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:33:54 -0500
Date: Wed, 14 Nov 2018 13:33:46 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181114183346.GA13059@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-45-cota@braap.org>
	<87sh03d2z9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sh03d2z9.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 44/48] cpus: lockstep execution support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Wed, Nov 14, 2018 at 16:43:22 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> <snip>
> >
> >  void cpu_interrupt(CPUState *cpu, int mask);
> > diff --git a/cpus.c b/cpus.c
> > index 3efe89354d..a446632a5c 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> <snip>
> > +
> > +static void cpu_lockstep_init(CPUState *cpu)
> > +{
> > +    if (!lockstep_enabled) {
> > +        return;
> > +    }
> > +    qemu_mutex_lock(&lockstep_lock);
> > +    /*
> > +     * HACK: avoid racing with a wakeup, which would miss the addition
> > +     * of this CPU; just wait until no wakeup is ongoing.
> > +     */
> > +    while (unlikely(lockstep_ongoing_wakeup)) {
> > +        qemu_mutex_unlock(&lockstep_lock);
> > +        sched_yield();
> 
> This breaks Windows builds. I suspect if we do want to this sort of
> functionality we'll need to expose a utility function in
> oslib-posix/oslib-win32

This was just a quick hack to avoid adding a condvar to the
wake-up fast path. Fixed in v2 with the below, which only calls
cond_broadcast if needed (i.e. very rarely).

Thanks,

		Emilio

diff --git a/cpus.c b/cpus.c
index d7d1bd3e00..06a952e504 100644
--- a/cpus.c
+++ b/cpus.c
@@ -84,8 +84,10 @@ static unsigned int throttle_percentage;
 static bool lockstep_enabled;
 static bool lockstep_ongoing_wakeup;
 static QemuMutex lockstep_lock;
+static QemuCond lockstep_cond;
 static int n_lockstep_running_cpus;
 static int n_lockstep_cpus;
+static int n_lockstep_initializing_cpus;
 static CPUState **lockstep_cpus;
 
 #define CPU_THROTTLE_PCT_MIN 1
@@ -1260,6 +1262,7 @@ void qemu_init_cpu_loop(void)
     qemu_init_sigbus();
     qemu_mutex_init(&qemu_global_mutex);
     qemu_mutex_init(&lockstep_lock);
+    qemu_cond_init(&lockstep_cond);
 
     qemu_thread_get_self(&io_thread);
 }
@@ -1369,6 +1372,13 @@ static void lockstep_check_stop(CPUState *cpu)
             cpu_mutex_lock(cpu);
             qemu_mutex_lock(&lockstep_lock);
             lockstep_ongoing_wakeup = false;
+            /*
+             * If newly spawned CPUs are waiting to be added to the wait list,
+             * let them do so now.
+             */
+            if (unlikely(n_lockstep_initializing_cpus)) {
+                qemu_cond_broadcast(&lockstep_cond);
+            }
         }
         qemu_mutex_unlock(&lockstep_lock);
     }
@@ -1379,16 +1389,15 @@ static void cpu_lockstep_init(CPUState *cpu)
     if (!lockstep_enabled) {
         return;
     }
+
     qemu_mutex_lock(&lockstep_lock);
-    /*
-     * HACK: avoid racing with a wakeup, which would miss the addition
-     * of this CPU; just wait until no wakeup is ongoing.
-     */
-    while (unlikely(lockstep_ongoing_wakeup)) {
-        qemu_mutex_unlock(&lockstep_lock);
-        sched_yield();
-        qemu_mutex_lock(&lockstep_lock);
+    /* avoid racing with a wakeup, which would miss the addition of this CPU */
+    n_lockstep_initializing_cpus++;
+    while (lockstep_ongoing_wakeup) {
+        qemu_cond_wait(&lockstep_cond, &lockstep_lock);
     }
+    n_lockstep_initializing_cpus--;
+
     lockstep_cpus = g_realloc(lockstep_cpus,
                               (n_lockstep_cpus + 1) * sizeof(CPUState *));
     lockstep_cpus[n_lockstep_cpus++] = cpu;
