Received: from eggs.gnu.org ([2001:4830:134:3::10]:51735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpGNg-0005Wt-8E
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpGNb-0006b8-LG
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:48 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpGNb-0006aY-Cq
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 13:11:30 -0400
Message-Id: <20180813171132.21939-2-cota@braap.org>
In-Reply-To: <20180813171132.21939-1-cota@braap.org>
References: <20180813171132.21939-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/3] qsp: QEMU's Synchronization Profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>

The goal of this module is to profile synchronization primitives
(i.e. mutexes, recursive mutexes and condition variables)
so that scalability issues can be quickly diagnosed.

Sync primitives are profiled by QSP based on the vaddr of the object accessed
as well as the call site (file:line_nr). That means the same object called
from two different call sites will be tracked in separate entries, and in the
report (see below) they will show up in different rows. See the comments
at the top of qsp.c for further info on this decision and the overall
design of QSP.

A report shows info about the tracked entries, sorted in descending order
of total wait time. Sample output:

Type               Object  Call site          Wait Time (s)         Count  Average (us)
---------------------------------------------------------------------------------------
condvar    0x557ee3090e80  cpus.c:1084              1.69207          2916        580.27
condvar    0x557ee30ceb10  cpus.c:1084              1.43442          2404        596.68
mutex      0x557ee2503540  cpus.c:1583              0.30300        636558          0.48
condvar    0x557ee2534460  cpus-common.c:216        0.13549         15513          8.73
condvar    0x557ee2534420  cpus-common.c:186        0.08927         15747          5.67
mutex      0x557ee3090a40  tcg/tcg.c:378            0.00823        120034          0.07
mutex      0x557ee3090a00  tcg/tcg.c:378            0.00820        117890          0.07
mutex      0x557ee3090ac0  tcg/tcg.c:378            0.00764        115954          0.07
mutex      0x557ee3090a80  tcg/tcg.c:378            0.00762        116573          0.07
mutex      0x557ee3090b00  tcg/tcg.c:378            0.00560         82547          0.07
---------------------------------------------------------------------------------------

Some perf numbers:

- Double-check that profiling disabled does not affect performance
  with `taskset -c 0 tests/atomic_add-bench -d 5 -m'. Host: AMD Opteron 6376.
  - Before: 14.25 Mops/s
  - After:  14.27 Mops/s (within noise range)

- Profiling overhead for `taskset -c 0 atomic_add-bench -d 5 -m' on
  AMD Opteron 6376:
  - No profiling: 14.27 Mops/s
  - W/ profiling:  3.05 Mops/s
  - W/o get_clock: 6.73 Mops/s
  That is, a 4.67X slowdown for mutex_lock.

  The third result is the performance measured for an instrumented mutex_lock
  that does not call get_clock and instead just increments the number of
  acquisitions for each entry. With this we measure the overhead of just
  the instrumentation + the hash table lookup.

- `taskset -c 0 tests/atomic_add-bench -d 5 -m' on Intel Xeon E5-2690:
  - W/o profiling: 33.95 Mops/s
  - W/ profiling:   8.08 Mops/s
  - W/o get_clock: 14.19 Mops/s
  That is, a 4.20X slowdown for mutex_lock.

Synchronization primitives are not called very often during a regular
QEMU run, so the overall performance impact of the profiler is quite
tolerable, as the following results show.

- Boot + shut down of debian-aarch64, on Intel Xeon E5-2690, 3 runs:
  -smp 1:
    - W/o profiling:
      16448.021211      task-clock (msec)         #    1.000 CPUs utilized            ( +-  0.27% )
            35,383      context-switches          #    0.002 M/sec                    ( +-  0.17% )
                 1      cpu-migrations            #    0.000 K/sec
            13,410      page-faults               #    0.815 K/sec                    ( +-  1.79% )
    47,526,630,360      cycles                    #    2.890 GHz                      ( +-  0.18% )  (83.33%)
    22,943,171,724      stalled-cycles-frontend   #   48.27% frontend cycles idle     ( +-  0.18% )  (83.35%)
    16,585,410,756      stalled-cycles-backend    #   34.90% backend  cycles idle     ( +-  0.32% )  (66.68%)
    60,962,863,668      instructions              #    1.28  insns per cycle
                                                  #    0.38  stalled cycles per insn  ( +-  0.06% )  (83.33%)
    10,910,210,349      branches                  #  663.314 M/sec                    ( +-  0.08% )  (83.33%)
       240,046,904      branch-misses             #    2.20% of all branches          ( +-  0.29% )  (83.33%)

      16.452269799 seconds time elapsed                                          ( +-  0.27% )

    - W/ profiling:
      16678.033593      task-clock (msec)         #    1.000 CPUs utilized            ( +-  0.09% )
            35,740      context-switches          #    0.002 M/sec                    ( +-  0.12% )
                 1      cpu-migrations            #    0.000 K/sec
            13,283      page-faults               #    0.796 K/sec                    ( +-  1.79% )
    48,208,446,365      cycles                    #    2.891 GHz                      ( +-  0.15% )  (83.34%)
    23,237,819,053      stalled-cycles-frontend   #   48.20% frontend cycles idle     ( +-  0.22% )  (83.34%)
    16,926,585,765      stalled-cycles-backend    #   35.11% backend  cycles idle     ( +-  0.30% )  (66.68%)
    61,620,102,560      instructions              #    1.28  insns per cycle
                                                  #    0.38  stalled cycles per insn  ( +-  0.20% )  (83.34%)
    11,015,082,852      branches                  #  660.455 M/sec                    ( +-  0.22% )  (83.32%)
       243,335,050      branch-misses             #    2.21% of all branches          ( +-  0.47% )  (83.33%)

      16.685661370 seconds time elapsed                                          ( +-  0.08% )

    That is, a 1.3% slowdown.

  -smp 8:
    - W/o profiling:
      21591.674202      task-clock (msec)         #    2.512 CPUs utilized            ( +-  0.04% )
           428,423      context-switches          #    0.020 M/sec                    ( +-  0.38% )
             8,474      cpu-migrations            #    0.392 K/sec                    ( +-  1.64% )
            27,668      page-faults               #    0.001 M/sec                    ( +-  4.56% )
    58,611,751,157      cycles                    #    2.715 GHz                      ( +-  0.27% )  (83.40%)
    31,033,543,440      stalled-cycles-frontend   #   52.95% frontend cycles idle     ( +-  0.45% )  (82.98%)
    22,983,788,382      stalled-cycles-backend    #   39.21% backend  cycles idle     ( +-  0.50% )  (66.80%)
    67,020,810,260      instructions              #    1.14  insns per cycle
                                                  #    0.46  stalled cycles per insn  ( +-  0.21% )  (83.45%)
    12,050,905,600      branches                  #  558.127 M/sec                    ( +-  0.16% )  (83.40%)
       271,074,726      branch-misses             #    2.25% of all branches          ( +-  0.33% )  (83.42%)

       8.595004141 seconds time elapsed                                          ( +-  0.65% )

    - W/ profiling:
      22227.582945      task-clock (msec)         #    2.516 CPUs utilized            ( +-  0.71% )
           487,009      context-switches          #    0.022 M/sec                    ( +-  1.43% )
             9,049      cpu-migrations            #    0.407 K/sec                    ( +-  0.99% )
            25,963      page-faults               #    0.001 M/sec                    ( +-  1.70% )
    60,705,049,201      cycles                    #    2.731 GHz                      ( +-  0.52% )  (83.33%)
    32,225,054,360      stalled-cycles-frontend   #   53.08% frontend cycles idle     ( +-  0.39% )  (83.50%)
    23,943,332,206      stalled-cycles-backend    #   39.44% backend  cycles idle     ( +-  0.40% )  (66.79%)
    68,775,229,321      instructions              #    1.13  insns per cycle
                                                  #    0.47  stalled cycles per insn  ( +-  0.45% )  (83.38%)
    12,361,594,986      branches                  #  556.138 M/sec                    ( +-  0.36% )  (83.46%)
       281,775,777      branch-misses             #    2.28% of all branches          ( +-  1.16% )  (82.93%)

       8.836031859 seconds time elapsed                                          ( +-  1.07% )

    That is, a 2.7% slowdown.

- Boot + shut down of debian-aarch64, on AMD Opteron 6376, 3 runs:
  -smp 1:
    - W/o profiling:
      27601.373288      task-clock (msec)         #    0.999 CPUs utilized            ( +-  0.74% )
            51,532      context-switches          #    0.002 M/sec                    ( +-  0.49% )
                 1      cpu-migrations            #    0.000 K/sec
            22,085      page-faults               #    0.800 K/sec                    ( +-  1.94% )
    63,051,935,104      cycles                    #    2.284 GHz                      ( +-  0.59% )  (83.32%)
    15,210,275,327      stalled-cycles-frontend   #   24.12% frontend cycles idle     ( +-  1.57% )  (83.33%)
    12,701,776,029      stalled-cycles-backend    #   20.14% backend  cycles idle     ( +-  0.65% )  (33.35%)
    64,895,509,291      instructions              #    1.03  insns per cycle
                                                  #    0.23  stalled cycles per insn  ( +-  0.15% )  (50.03%)
    11,598,175,695      branches                  #  420.203 M/sec                    ( +-  0.12% )  (66.69%)
       424,964,774      branch-misses             #    3.66% of all branches          ( +-  2.44% )  (83.34%)

      27.634390949 seconds time elapsed                                          ( +-  0.73% )

    - W/ profiling:
      28539.459861      task-clock (msec)         #    0.999 CPUs utilized            ( +-  0.90% )
            52,971      context-switches          #    0.002 M/sec                    ( +-  0.62% )
                 1      cpu-migrations            #    0.000 K/sec
            22,828      page-faults               #    0.800 K/sec                    ( +-  2.19% )
    65,196,667,837      cycles                    #    2.284 GHz                      ( +-  0.76% )  (83.32%)
    16,438,749,522      stalled-cycles-frontend   #   25.21% frontend cycles idle     ( +-  2.44% )  (83.34%)
    13,080,610,434      stalled-cycles-backend    #   20.06% backend  cycles idle     ( +-  1.22% )  (33.35%)
    65,744,290,786      instructions              #    1.01  insns per cycle
                                                  #    0.25  stalled cycles per insn  ( +-  0.17% )  (50.05%)
    11,760,663,051      branches                  #  412.084 M/sec                    ( +-  0.11% )  (66.69%)
       433,815,865      branch-misses             #    3.69% of all branches          ( +-  2.27% )  (83.34%)

      28.558462655 seconds time elapsed                                          ( +-  0.90% )

    That is, a 3.5% slowdown.

  -smp 8:
    - W/o profiling:
      67084.039812      task-clock (msec)         #    3.075 CPUs utilized            ( +-  0.57% )
           448,562      context-switches          #    0.007 M/sec                    ( +-  1.30% )
            13,417      cpu-migrations            #    0.200 K/sec                    ( +-  1.67% )
            38,428      page-faults               #    0.573 K/sec                    ( +-  2.60% )
    92,018,881,848      cycles                    #    1.372 GHz                      ( +-  0.51% )  (83.27%)
    24,887,145,043      stalled-cycles-frontend   #   27.05% frontend cycles idle     ( +-  0.97% )  (83.31%)
    10,843,517,286      stalled-cycles-backend    #   11.78% backend  cycles idle     ( +-  0.84% )  (33.45%)
    72,663,707,013      instructions              #    0.79  insns per cycle
                                                  #    0.34  stalled cycles per insn  ( +-  0.34% )  (50.14%)
    13,148,472,626      branches                  #  196.000 M/sec                    ( +-  0.26% )  (66.68%)
       524,683,844      branch-misses             #    3.99% of all branches          ( +-  0.31% )  (83.34%)

      21.816863743 seconds time elapsed                                          ( +-  1.37% )

    - W/ profiling:
      72646.052577      task-clock (msec)         #    3.088 CPUs utilized            ( +-  0.52% )
           558,334      context-switches          #    0.008 M/sec                    ( +-  0.35% )
            16,471      cpu-migrations            #    0.227 K/sec                    ( +-  1.35% )
            40,420      page-faults               #    0.556 K/sec                    ( +-  2.31% )
    99,025,850,252      cycles                    #    1.363 GHz                      ( +-  0.19% )  (83.14%)
    28,317,752,389      stalled-cycles-frontend   #   28.60% frontend cycles idle     ( +-  0.21% )  (83.29%)
    11,370,442,683      stalled-cycles-backend    #   11.48% backend  cycles idle     ( +-  0.78% )  (33.59%)
    75,859,240,699      instructions              #    0.77  insns per cycle
                                                  #    0.37  stalled cycles per insn  ( +-  0.11% )  (50.25%)
    13,774,590,759      branches                  #  189.612 M/sec                    ( +-  0.10% )  (66.87%)
       541,354,013      branch-misses             #    3.93% of all branches          ( +-  0.13% )  (83.50%)

      23.525659377 seconds time elapsed                                          ( +-  0.90% )

    That is, a 7.8% slowdown.

Note that as -smp increases the memory footprint of the profiling data grows
as well, which explains the slowdown increase as we add more guest CPUs.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 configure                   |   8 +
 include/qemu/qht.h          |   1 +
 include/qemu/qsp.h          |  38 +++
 include/qemu/thread-posix.h |   4 +-
 include/qemu/thread-win32.h |   5 +-
 include/qemu/thread.h       |  41 ++-
 util/qemu-thread-win32.c    |   4 +-
 util/qht.c                  |  47 +++-
 util/qsp.c                  | 545 ++++++++++++++++++++++++++++++++++++
 util/Makefile.objs          |   1 +
 10 files changed, 671 insertions(+), 23 deletions(-)
 create mode 100644 include/qemu/qsp.h
 create mode 100644 util/qsp.c

diff --git a/configure b/configure
index 2a7796ea80..d7fead7c85 100755
--- a/configure
+++ b/configure
@@ -408,6 +408,7 @@ bsd="no"
 linux="no"
 solaris="no"
 profiler="no"
+sync_profiler="no"
 cocoa="no"
 softmmu="yes"
 linux_user="no"
@@ -1163,6 +1164,8 @@ for opt do
   ;;
   --enable-profiler) profiler="yes"
   ;;
+  --enable-sync-profiler) sync_profiler="yes"
+  ;;
   --disable-cocoa) cocoa="no"
   ;;
   --enable-cocoa)
@@ -1621,6 +1624,7 @@ Advanced options (experts only):
   --tls-priority           default TLS protocol/cipher priority string
   --enable-gprof           QEMU profiling with gprof
   --enable-profiler        profiler support
+  --enable-sync-profiler   support profiling of synchronization primitives
   --enable-xen-pv-domain-build
                            xen pv domain builder
   --enable-debug-stack-usage
@@ -5893,6 +5897,7 @@ echo "gprof enabled     $gprof"
 echo "sparse enabled    $sparse"
 echo "strip binaries    $strip_opt"
 echo "profiler          $profiler"
+echo "sync profiler     $sync_profiler"
 echo "static build      $static"
 if test "$darwin" = "yes" ; then
     echo "Cocoa support     $cocoa"
@@ -6146,6 +6151,9 @@ fi
 if test "$profiler" = "yes" ; then
   echo "CONFIG_PROFILER=y" >> $config_host_mak
 fi
+if test "$sync_profiler" = "yes" ; then
+  echo "CONFIG_SYNC_PROFILER=y" >> $config_host_mak
+fi
 if test "$slirp" = "yes" ; then
   echo "CONFIG_SLIRP=y" >> $config_host_mak
   echo "CONFIG_SMBD_COMMAND=\"$smbd\"" >> $config_host_mak
diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index 1fb9116fa0..c9a11cc29a 100644
--- a/include/qemu/qht.h
+++ b/include/qemu/qht.h
@@ -46,6 +46,7 @@ typedef bool (*qht_lookup_func_t)(const void *obj, const void *userp);
 typedef void (*qht_iter_func_t)(struct qht *ht, void *p, uint32_t h, void *up);
 
 #define QHT_MODE_AUTO_RESIZE 0x1 /* auto-resize when heavily loaded */
+#define QHT_MODE_RAW_MUTEXES 0x2 /* bypass the profiler (QSP) */
 
 /**
  * qht_init - Initialize a QHT
diff --git a/include/qemu/qsp.h b/include/qemu/qsp.h
new file mode 100644
index 0000000000..e36f94ab1d
--- /dev/null
+++ b/include/qemu/qsp.h
@@ -0,0 +1,38 @@
+/*
+ * qsp.c - QEMU Synchronization Profiler
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * Note: this header file can *only* be included from thread.h.
+ */
+#ifndef QEMU_QSP_H
+#define QEMU_QSP_H
+
+#include "qemu/fprintf-fn.h"
+
+#ifdef CONFIG_SYNC_PROFILER
+
+void qsp_mutex_lock(QemuMutex *mutex, const char *file, unsigned line);
+int qsp_mutex_trylock(QemuMutex *mutex, const char *file, unsigned line);
+
+void qsp_rec_mutex_lock(QemuRecMutex *mutex, const char *file, unsigned line);
+int qsp_rec_mutex_trylock(QemuRecMutex *mutex, const char *file, unsigned line);
+
+void qsp_cond_wait(QemuCond *cond, QemuMutex *mutex, const char *file,
+                   unsigned line);
+
+void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max);
+
+#else /* !CONF_SYNC_PROFILER */
+
+static inline void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max)
+{
+    cpu_fprintf(f, "[Sync profiler not compiled]\n");
+}
+
+#endif /* !CONF_SYNC_PROFILER */
+
+#endif /* QEMU_QSP_H */
diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index fd27b34128..c903525062 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -6,8 +6,8 @@
 
 typedef QemuMutex QemuRecMutex;
 #define qemu_rec_mutex_destroy qemu_mutex_destroy
-#define qemu_rec_mutex_lock qemu_mutex_lock
-#define qemu_rec_mutex_trylock qemu_mutex_trylock
+#define qemu_rec_mutex_lock_impl    qemu_mutex_lock_impl
+#define qemu_rec_mutex_trylock_impl qemu_mutex_trylock_impl
 #define qemu_rec_mutex_unlock qemu_mutex_unlock
 
 struct QemuMutex {
diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index d668d789b4..50af5dd7ab 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -19,8 +19,9 @@ struct QemuRecMutex {
 };
 
 void qemu_rec_mutex_destroy(QemuRecMutex *mutex);
-void qemu_rec_mutex_lock(QemuRecMutex *mutex);
-int qemu_rec_mutex_trylock(QemuRecMutex *mutex);
+void qemu_rec_mutex_lock_impl(QemuRecMutex *mutex, const char *file, int line);
+int qemu_rec_mutex_trylock_impl(QemuRecMutex *mutex, const char *file,
+                                int line);
 void qemu_rec_mutex_unlock(QemuRecMutex *mutex);
 
 struct QemuCond {
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index ef7bd16123..55009bbf26 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -16,6 +16,9 @@ typedef struct QemuThread QemuThread;
 #include "qemu/thread-posix.h"
 #endif
 
+/* include QSP header once QemuMutex, QemuCond etc. are defined */
+#include "qemu/qsp.h"
+
 #define QEMU_THREAD_JOINABLE 0
 #define QEMU_THREAD_DETACHED 1
 
@@ -25,10 +28,27 @@ int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line);
 void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line);
 void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line);
 
-#define qemu_mutex_lock(mutex) \
-        qemu_mutex_lock_impl(mutex, __FILE__, __LINE__)
-#define qemu_mutex_trylock(mutex) \
-        qemu_mutex_trylock_impl(mutex, __FILE__, __LINE__)
+/* convenience macros to bypass the profiler */
+#define qemu_mutex_lock__raw(m)                         \
+        qemu_mutex_lock_impl(m, __FILE__, __LINE__)
+#define qemu_mutex_trylock__raw(m)                      \
+        qemu_mutex_trylock_impl(m, __FILE__, __LINE__)
+
+#ifdef CONFIG_SYNC_PROFILER
+# define qemu_mutex_lock(m)        qsp_mutex_lock(m, __FILE__, __LINE__)
+# define qemu_mutex_trylock(m)     qsp_mutex_trylock(m, __FILE__, __LINE__)
+# define qemu_rec_mutex_lock(m)    qsp_rec_mutex_lock(m, __FILE__, __LINE__)
+# define qemu_rec_mutex_trylock(m) qsp_rec_mutex_trylock(m, __FILE__, __LINE__)
+# define qemu_cond_wait(c, m)      qsp_cond_wait(c, m, __FILE__, __LINE__)
+#else
+# define qemu_mutex_lock(m)     qemu_mutex_lock_impl(m, __FILE__, __LINE__)
+# define qemu_mutex_trylock(m)  qemu_mutex_trylock_impl(m, __FILE__, __LINE__)
+# define qemu_rec_mutex_lock(m) qemu_rec_mutex_lock_impl(m, __FILE__, __LINE__)
+# define qemu_rec_mutex_trylock(m)                              \
+         qemu_rec_mutex_trylock_impl(m, __FILE__, __LINE__)
+# define qemu_cond_wait(c, m)   qemu_cond_wait_impl(c, m, __FILE__, __LINE__)
+#endif /* !CONFIG_SYNC_PROFILER */
+
 #define qemu_mutex_unlock(mutex) \
         qemu_mutex_unlock_impl(mutex, __FILE__, __LINE__)
 
@@ -47,6 +67,16 @@ static inline void (qemu_mutex_unlock)(QemuMutex *mutex)
     qemu_mutex_unlock(mutex);
 }
 
+static inline void (qemu_rec_mutex_lock)(QemuRecMutex *mutex)
+{
+    qemu_rec_mutex_lock(mutex);
+}
+
+static inline int (qemu_rec_mutex_trylock)(QemuRecMutex *mutex)
+{
+    return qemu_rec_mutex_trylock(mutex);
+}
+
 /* Prototypes for other functions are in thread-posix.h/thread-win32.h.  */
 void qemu_rec_mutex_init(QemuRecMutex *mutex);
 
@@ -63,9 +93,6 @@ void qemu_cond_broadcast(QemuCond *cond);
 void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex,
                          const char *file, const int line);
 
-#define qemu_cond_wait(cond, mutex) \
-        qemu_cond_wait_impl(cond, mutex, __FILE__, __LINE__)
-
 static inline void (qemu_cond_wait)(QemuCond *cond, QemuMutex *mutex)
 {
     qemu_cond_wait(cond, mutex);
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index b303188a36..4a363ca675 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -97,13 +97,13 @@ void qemu_rec_mutex_destroy(QemuRecMutex *mutex)
     DeleteCriticalSection(&mutex->lock);
 }
 
-void qemu_rec_mutex_lock(QemuRecMutex *mutex)
+void qemu_rec_mutex_lock_impl(QemuRecMutex *mutex, const char *file, int line)
 {
     assert(mutex->initialized);
     EnterCriticalSection(&mutex->lock);
 }
 
-int qemu_rec_mutex_trylock(QemuRecMutex *mutex)
+int qemu_rec_mutex_trylock_impl(QemuRecMutex *mutex, const char *file, int line)
 {
     assert(mutex->initialized);
     return !TryEnterCriticalSection(&mutex->lock);
diff --git a/util/qht.c b/util/qht.c
index c138777a9c..1e3a072e25 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -89,6 +89,33 @@
 #define QHT_BUCKET_ENTRIES 4
 #endif
 
+/*
+ * Do _not_ use qemu_mutex_[try]lock directly! Use these macros, otherwise
+ * the profiler (QSP) will deadlock.
+ */
+static inline void qht_lock(struct qht *ht)
+{
+    if (ht->mode & QHT_MODE_RAW_MUTEXES) {
+        qemu_mutex_lock__raw(&ht->lock);
+    } else {
+        qemu_mutex_lock(&ht->lock);
+    }
+}
+
+static inline int qht_trylock(struct qht *ht)
+{
+    if (ht->mode & QHT_MODE_RAW_MUTEXES) {
+        return qemu_mutex_trylock__raw(&(ht)->lock);
+    }
+    return qemu_mutex_trylock(&(ht)->lock);
+}
+
+/* this inline is not really necessary, but it helps keep code consistent */
+static inline void qht_unlock(struct qht *ht)
+{
+    qemu_mutex_unlock(&ht->lock);
+}
+
 /*
  * Note: reading partially-updated pointers in @pointers could lead to
  * segfaults. We thus access them with atomic_read/set; this guarantees
@@ -254,10 +281,10 @@ void qht_map_lock_buckets__no_stale(struct qht *ht, struct qht_map **pmap)
     qht_map_unlock_buckets(map);
 
     /* we raced with a resize; acquire ht->lock to see the updated ht->map */
-    qemu_mutex_lock(&ht->lock);
+    qht_lock(ht);
     map = ht->map;
     qht_map_lock_buckets(map);
-    qemu_mutex_unlock(&ht->lock);
+    qht_unlock(ht);
     *pmap = map;
     return;
 }
@@ -288,11 +315,11 @@ struct qht_bucket *qht_bucket_lock__no_stale(struct qht *ht, uint32_t hash,
     qemu_spin_unlock(&b->lock);
 
     /* we raced with a resize; acquire ht->lock to see the updated ht->map */
-    qemu_mutex_lock(&ht->lock);
+    qht_lock(ht);
     map = ht->map;
     b = qht_map_to_bucket(map, hash);
     qemu_spin_lock(&b->lock);
-    qemu_mutex_unlock(&ht->lock);
+    qht_unlock(ht);
     *pmap = map;
     return b;
 }
@@ -430,13 +457,13 @@ bool qht_reset_size(struct qht *ht, size_t n_elems)
 
     n_buckets = qht_elems_to_buckets(n_elems);
 
-    qemu_mutex_lock(&ht->lock);
+    qht_lock(ht);
     map = ht->map;
     if (n_buckets != map->n_buckets) {
         new = qht_map_create(n_buckets);
     }
     qht_do_resize_and_reset(ht, new);
-    qemu_mutex_unlock(&ht->lock);
+    qht_unlock(ht);
 
     return !!new;
 }
@@ -565,7 +592,7 @@ static __attribute__((noinline)) void qht_grow_maybe(struct qht *ht)
      * If the lock is taken it probably means there's an ongoing resize,
      * so bail out.
      */
-    if (qemu_mutex_trylock(&ht->lock)) {
+    if (qht_trylock(ht)) {
         return;
     }
     map = ht->map;
@@ -575,7 +602,7 @@ static __attribute__((noinline)) void qht_grow_maybe(struct qht *ht)
 
         qht_do_resize(ht, new);
     }
-    qemu_mutex_unlock(&ht->lock);
+    qht_unlock(ht);
 }
 
 bool qht_insert(struct qht *ht, void *p, uint32_t hash, void **existing)
@@ -788,7 +815,7 @@ bool qht_resize(struct qht *ht, size_t n_elems)
     size_t n_buckets = qht_elems_to_buckets(n_elems);
     size_t ret = false;
 
-    qemu_mutex_lock(&ht->lock);
+    qht_lock(ht);
     if (n_buckets != ht->map->n_buckets) {
         struct qht_map *new;
 
@@ -796,7 +823,7 @@ bool qht_resize(struct qht *ht, size_t n_elems)
         qht_do_resize(ht, new);
         ret = true;
     }
-    qemu_mutex_unlock(&ht->lock);
+    qht_unlock(ht);
 
     return ret;
 }
diff --git a/util/qsp.c b/util/qsp.c
new file mode 100644
index 0000000000..908e99cccf
--- /dev/null
+++ b/util/qsp.c
@@ -0,0 +1,545 @@
+/*
+ * qsp.c - QEMU Synchronization Profiler
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * QSP profiles the time spent in synchronization primitives, which can
+ * help diagnose performance problems, e.g. scalability issues when
+ * contention is high.
+ *
+ * The primitives currently supported are mutexes, recursive mutexes and
+ * condition variables. Note that not all related functions are intercepted;
+ * instead we profile only those functions that can have a performance impact,
+ * either due to blocking (e.g. cond_wait, mutex_lock) or cache line
+ * contention (e.g. mutex_lock, mutex_trylock).
+ *
+ * QSP's design focuses on speed and scalability. This is achieved
+ * by having threads do their profiling entirely on thread-local data.
+ * The appropriate thread-local data is found via a QHT, i.e. a concurrent hash
+ * table. To aggregate data in order to generate a report, we iterate over
+ * all entries in the hash table. Depending on the number of threads and
+ * synchronization objects this might be expensive, but note that it is
+ * very rarely called -- reports are generated only when requested by users.
+ *
+ * Reports are generated as a table where each row represents a call site. A
+ * call site is the triplet formed by the __file__ and __LINE__ of the caller
+ * as well as the address of the "object" (i.e. mutex, rec. mutex or condvar)
+ * being operated on. Focusing on call sites instead of just on objects might
+ * seem puzzling. However, it is a sensible choice since otherwise dealing with
+ * dynamically-allocated objects becomes difficult (e.g. what to do when an
+ * object is destroyed, or reused?). Furthermore, the call site info is of most
+ * importance, since it is callers, and not objects, what cause wait time.
+ *
+ * Alternative designs considered:
+ *
+ * - Use an off-the-shelf profiler such as mutrace. This is not a viable option
+ *   for us because QEMU has __malloc_hook set (by one of the libraries it
+ *   uses); leaving this hook unset is required to avoid deadlock in mutrace.
+ *
+ * - Use a glib HT for each thread, protecting each HT with its own lock.
+ *   This isn't simpler than the current design, and is 10% slower in the
+ *   atomic_add-bench microbenchmark (-m option).
+ *
+ * - For reports, just use a binary tree as we aggregate data, instead of having
+ *   an intermediate hash table. This would simplify the code only slightly, but
+ *   would perform badly if there were many threads and objects to track.
+ *
+ * Related Work:
+ * - Lennart Poettering's mutrace: http://0pointer.de/blog/projects/mutrace.html
+ * - Lozi, David, Thomas, Lawall and Muller. "Remote Core Locking: Migrating
+ *   Critical-Section Execution to Improve the Performance of Multithreaded
+ *   Applications", USENIX ATC'12.
+ */
+#include "qemu/osdep.h"
+#include "qemu/thread.h"
+#include "qemu/timer.h"
+#include "qemu/qht.h"
+#include "exec/tb-hash-xx.h"
+
+enum qsp_type {
+    QSP_MUTEX,
+    QSP_REC_MUTEX,
+    QSP_CONDVAR,
+};
+
+struct qsp_callsite {
+    const void *obj;
+    const char *file; /* i.e. __FILE__; shortened later */
+    unsigned int line;
+    enum qsp_type type;
+};
+
+struct qsp_entry {
+    void *thread_ptr;
+    const struct qsp_callsite *callsite;
+    uint64_t n_acqs;
+    uint64_t ns;
+};
+
+/* initial sizing for hash tables */
+#define QSP_INITIAL_SIZE 64
+
+/* If this file is moved, QSP_REL_PATH should be updated accordingly */
+#define QSP_REL_PATH "util/qsp.c"
+
+/* this file's full path. Used to present all call sites with relative paths */
+static size_t qsp_qemu_path_len;
+
+/* the address of qsp_thread gives us a unique 'thread ID' */
+static __thread int qsp_thread;
+
+/*
+ * Call sites are the same for all threads, so we track them in a separate hash
+ * table to save memory.
+ */
+static struct qht qsp_callsite_ht;
+
+static struct qht qsp_ht;
+static bool qsp_initialized, qsp_initializing;
+
+static const char * const qsp_typenames[] = {
+    [QSP_MUTEX]     = "mutex",
+    [QSP_REC_MUTEX] = "rec_mutex",
+    [QSP_CONDVAR]   = "condvar",
+};
+
+/*
+ * It pays off to _not_ hash callsite->file; hashing a string is slow, and
+ * without it we still get a pretty unique hash.
+ */
+static inline
+uint32_t do_qsp_callsite_hash(const struct qsp_callsite *callsite, uint64_t a)
+{
+    uint64_t b = (uint64_t)callsite->obj;
+    uint32_t e = callsite->line;
+    uint32_t f = callsite->type;
+
+    return tb_hash_func7(a, b, e, f, 0);
+}
+
+static inline
+uint32_t qsp_callsite_hash(const struct qsp_callsite *callsite)
+{
+    return do_qsp_callsite_hash(callsite, 0);
+}
+
+static inline uint32_t do_qsp_entry_hash(const struct qsp_entry *entry,
+                                         uint64_t a)
+{
+    return do_qsp_callsite_hash(entry->callsite, a);
+}
+
+static uint32_t qsp_entry_hash(const struct qsp_entry *entry)
+{
+    return do_qsp_entry_hash(entry, (uint64_t)entry->thread_ptr);
+}
+
+static uint32_t qsp_entry_no_thread_hash(const struct qsp_entry *entry)
+{
+    return do_qsp_entry_hash(entry, 0);
+}
+
+static bool qsp_callsite_cmp(const void *ap, const void *bp)
+{
+    const struct qsp_callsite *a = ap;
+    const struct qsp_callsite *b = bp;
+
+    return a == b ||
+        (a->obj == b->obj &&
+         a->line == b->line &&
+         a->type == b->type &&
+         (a->file == b->file || !strcmp(a->file, b->file)));
+}
+
+static bool qsp_entry_no_thread_cmp(const void *ap, const void *bp)
+{
+    const struct qsp_entry *a = ap;
+    const struct qsp_entry *b = bp;
+
+    return qsp_callsite_cmp(a->callsite, b->callsite);
+}
+
+static bool qsp_entry_cmp(const void *ap, const void *bp)
+{
+    const struct qsp_entry *a = ap;
+    const struct qsp_entry *b = bp;
+
+    return a->thread_ptr == b->thread_ptr &&
+        qsp_callsite_cmp(a->callsite, b->callsite);
+}
+
+/*
+ * Normally we'd call this from a constructor function, but we want it to work
+ * via libutil as well.
+ */
+static void qsp_do_init(void)
+{
+    /* make sure this file's path in the tree is up to date with QSP_REL_PATH */
+    g_assert(strstr(__FILE__, QSP_REL_PATH));
+    qsp_qemu_path_len = strlen(__FILE__) - strlen(QSP_REL_PATH);
+
+    qht_init(&qsp_ht, qsp_entry_cmp, QSP_INITIAL_SIZE,
+             QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
+    qht_init(&qsp_callsite_ht, qsp_callsite_cmp, QSP_INITIAL_SIZE,
+             QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
+}
+
+static __attribute__((noinline)) void qsp_init__slowpath(void)
+{
+    if (atomic_cmpxchg(&qsp_initializing, false, true) == false) {
+        qsp_do_init();
+        atomic_set(&qsp_initialized, true);
+    } else {
+        while (!atomic_read(&qsp_initialized)) {
+            cpu_relax();
+        }
+    }
+}
+
+/* qsp_init() must be called from _all_ exported functions */
+static inline void qsp_init(void)
+{
+    if (likely(atomic_read(&qsp_initialized))) {
+        return;
+    }
+    qsp_init__slowpath();
+}
+
+static struct qsp_callsite *qsp_callsite_find(const struct qsp_callsite *orig)
+{
+    struct qsp_callsite *callsite;
+    uint32_t hash;
+
+    hash = qsp_callsite_hash(orig);
+    callsite = qht_lookup(&qsp_callsite_ht, orig, hash);
+    if (callsite == NULL) {
+        void *existing = NULL;
+
+        callsite = g_new(struct qsp_callsite, 1);
+        memcpy(callsite, orig, sizeof(*callsite));
+        qht_insert(&qsp_callsite_ht, callsite, hash, &existing);
+        if (unlikely(existing)) {
+            g_free(callsite);
+            callsite = existing;
+        }
+    }
+    return callsite;
+}
+
+static struct qsp_entry *qsp_entry_create(struct qht *ht,
+                                          const struct qsp_entry *entry,
+                                          uint32_t hash)
+{
+    struct qsp_entry *e;
+    void *existing = NULL;
+
+    e = g_new(struct qsp_entry, 1);
+    memcpy(e, entry, sizeof(*e));
+    e->callsite = qsp_callsite_find(entry->callsite);
+    /* zero the counters; all other fields are constant */
+    e->n_acqs = 0;
+    e->ns = 0;
+
+    qht_insert(ht, e, hash, &existing);
+    if (unlikely(existing)) {
+        g_free(e);
+        e = existing;
+    }
+    return e;
+}
+
+static struct qsp_entry *qsp_entry_find(struct qht *ht,
+                                        const struct qsp_entry *entry,
+                                        uint32_t hash)
+{
+    struct qsp_entry *e;
+
+    e = qht_lookup(ht, entry, hash);
+    if (e == NULL) {
+        e = qsp_entry_create(ht, entry, hash);
+    }
+    return e;
+}
+
+static struct qsp_entry *qsp_entry_get(const void *obj, const char *file,
+                                       unsigned line, enum qsp_type type)
+{
+    struct qsp_callsite callsite = {
+        .obj = obj,
+        .file = file,
+        .line = line,
+        .type = type,
+    };
+    struct qsp_entry orig;
+    uint32_t hash;
+
+    qsp_init();
+
+    orig.thread_ptr = &qsp_thread;
+    orig.callsite = &callsite;
+
+    hash = qsp_entry_hash(&orig);
+    return qsp_entry_find(&qsp_ht, &orig, hash);
+}
+
+#define QSP_GEN_VOID(type_, qsp_t_, func_, impl_)                       \
+    void func_(type_ *obj, const char *file, unsigned line)             \
+    {                                                                   \
+        struct qsp_entry *e = qsp_entry_get(obj, file, line, qsp_t_);   \
+        int64_t t;                                                      \
+                                                                        \
+        t = get_clock();                                                \
+        impl_(obj, file, line);                                         \
+        atomic_set(&e->ns, e->ns + get_clock() - t);                    \
+        atomic_set(&e->n_acqs, e->n_acqs + 1);                          \
+    }
+
+#define QSP_GEN_RET1(type_, qsp_t_, func_, impl_)                       \
+    int func_(type_ *obj, const char *file, unsigned line)              \
+    {                                                                   \
+        struct qsp_entry *e = qsp_entry_get(obj, file, line, qsp_t_);   \
+        int64_t t;                                                      \
+        int err;                                                        \
+                                                                        \
+        t = get_clock();                                                \
+        err = impl_(obj, file, line);                                   \
+        atomic_set(&e->ns, e->ns + get_clock() - t);                    \
+        if (!err) {                                                     \
+            atomic_set(&e->n_acqs, e->n_acqs + 1);                      \
+        }                                                               \
+        return err;                                                     \
+    }
+
+QSP_GEN_VOID(QemuMutex, QSP_MUTEX, qsp_mutex_lock, qemu_mutex_lock_impl)
+QSP_GEN_RET1(QemuMutex, QSP_MUTEX, qsp_mutex_trylock, qemu_mutex_trylock_impl)
+
+QSP_GEN_VOID(QemuRecMutex, QSP_REC_MUTEX, qsp_rec_mutex_lock,
+             qemu_rec_mutex_lock_impl)
+QSP_GEN_RET1(QemuRecMutex, QSP_REC_MUTEX, qsp_rec_mutex_trylock,
+             qemu_rec_mutex_trylock_impl)
+
+void qsp_cond_wait(QemuCond *cond, QemuMutex *mutex, const char *file,
+                   unsigned line)
+{
+    struct qsp_entry *e;
+    int64_t t;
+
+    qsp_init();
+
+    e = qsp_entry_get(cond, file, line, QSP_CONDVAR);
+    t = get_clock();
+    qemu_cond_wait_impl(cond, mutex, file, line);
+    atomic_set(&e->ns, e->ns + get_clock() - t);
+    atomic_set(&e->n_acqs, e->n_acqs + 1);
+}
+
+static gint qsp_tree_cmp(gconstpointer ap, gconstpointer bp, gpointer up)
+{
+    const struct qsp_entry *a = ap;
+    const struct qsp_entry *b = bp;
+
+    if (a->ns > b->ns) {
+        return -1;
+    } else if (a->ns < b->ns) {
+        return 1;
+    } else {
+        const struct qsp_callsite *ca = a->callsite;
+        const struct qsp_callsite *cb = b->callsite;
+
+        /* same ns. Break the tie with the object's address */
+        if (ca->obj < cb->obj) {
+            return -1;
+        } else if (ca->obj > cb->obj) {
+            return 1;
+        } else {
+            int cmp;
+
+            /* same obj. Break the tie with the callsite's file */
+            cmp = strcmp(ca->file, cb->file);
+            if (cmp) {
+                return cmp;
+            }
+            /* same callsite file. Break the tie with the callsite's line */
+            g_assert(ca->line != cb->line);
+            if (ca->line < cb->line) {
+                return -1;
+            } else if (ca->line > cb->line) {
+                return 1;
+            } else {
+                /* break the tie with the callsite's type */
+                return cb->type - ca->type;
+            }
+        }
+    }
+}
+
+static void qsp_sort(struct qht *ht, void *p, uint32_t h, void *userp)
+{
+    struct qsp_entry *e = p;
+    GTree *tree = userp;
+
+    g_tree_insert(tree, e, NULL);
+}
+
+static void qsp_aggregate(struct qht *global_ht, void *p, uint32_t h, void *up)
+{
+    struct qht *ht = up;
+    const struct qsp_entry *e = p;
+    struct qsp_entry *agg;
+    uint32_t hash;
+
+    hash = qsp_entry_no_thread_hash(e);
+    agg = qsp_entry_find(ht, e, hash);
+    agg->ns += e->ns;
+    agg->n_acqs += e->n_acqs;
+}
+
+static void qsp_mktree(GTree *tree)
+{
+    struct qht ht;
+
+    /* first, create a hash table to aggregate all results */
+    qht_init(&ht, qsp_entry_no_thread_cmp, QSP_INITIAL_SIZE,
+             QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
+
+    /* then fill in the hash table by iterating over the global hash table */
+    qht_iter(&qsp_ht, qsp_aggregate, &ht);
+
+    /* sort the hash table elements by using a tree */
+    qht_iter(&ht, qsp_sort, tree);
+
+    /* free the hash table, but keep the elements (those are in the tree now) */
+    qht_destroy(&ht);
+}
+
+/* free string with g_free */
+static char *qsp_at(const struct qsp_callsite *callsite)
+{
+    GString *s = g_string_new("");
+    const char *shortened;
+
+    /* remove the absolute path to qemu */
+    if (unlikely(strlen(callsite->file) < qsp_qemu_path_len)) {
+        shortened = callsite->file;
+    } else {
+        shortened = callsite->file + qsp_qemu_path_len;
+    }
+    g_string_append_printf(s, "%s:%u", shortened, callsite->line);
+    return g_string_free(s, FALSE);
+}
+
+struct qsp_report_entry {
+    const void *obj;
+    char *callsite_at;
+    const char *typename;
+    double time_s;
+    double ns_avg;
+    uint64_t n_acqs;
+};
+
+struct qsp_report {
+    struct qsp_report_entry *entries;
+    size_t n_entries;
+    size_t max_n_entries;
+};
+
+static gboolean qsp_tree_report(gpointer key, gpointer value, gpointer udata)
+{
+    const struct qsp_entry *e = key;
+    struct qsp_report *report = udata;
+    struct qsp_report_entry *entry;
+
+    if (report->n_entries == report->max_n_entries) {
+        return TRUE;
+    }
+    entry = &report->entries[report->n_entries];
+    report->n_entries++;
+
+    entry->obj = e->callsite->obj;
+    entry->callsite_at = qsp_at(e->callsite);
+    entry->typename = qsp_typenames[e->callsite->type];
+    entry->time_s = e->ns * 1e-9;
+    entry->n_acqs = e->n_acqs;
+    entry->ns_avg = e->n_acqs ? e->ns / e->n_acqs : 0;
+    return FALSE;
+}
+
+static void
+pr_report(const struct qsp_report *rep, FILE *f, fprintf_function pr)
+{
+    char *dashes;
+    size_t max_len = 0;
+    int callsite_len = 0;
+    int callsite_rspace;
+    int n_dashes;
+    size_t i;
+
+    /* find out the maximum length of all 'callsite' fields */
+    for (i = 0; i < rep->n_entries; i++) {
+        const struct qsp_report_entry *e = &rep->entries[i];
+        size_t len = strlen(e->callsite_at);
+
+        if (len > max_len) {
+            max_len = len;
+        }
+    }
+
+    callsite_len = MAX(max_len, strlen("Call site"));
+    /* white space to leave to the right of "Call site" */
+    callsite_rspace = callsite_len - strlen("Call site");
+
+    pr(f, "Type               Object  Call site%*s  Wait Time (s)  "
+       "       Count  Average (us)\n", callsite_rspace, "");
+
+    /* build a horizontal rule with dashes */
+    n_dashes = 79 + callsite_rspace;
+    dashes = g_malloc(n_dashes + 1);
+    memset(dashes, '-', n_dashes);
+    dashes[n_dashes] = '\0';
+    pr(f, "%s\n", dashes);
+
+    for (i = 0; i < rep->n_entries; i++) {
+        const struct qsp_report_entry *e = &rep->entries[i];
+
+        pr(f, "%-9s  %14p  %s%*s  %13.5f  %12" PRIu64 "  %12.2f\n", e->typename,
+           e->obj, e->callsite_at, callsite_len - (int)strlen(e->callsite_at),
+           "", e->time_s, e->n_acqs, e->ns_avg * 1e-3);
+    }
+
+    pr(f, "%s\n", dashes);
+    g_free(dashes);
+}
+
+static void report_destroy(struct qsp_report *rep)
+{
+    size_t i;
+
+    for (i = 0; i < rep->n_entries; i++) {
+        struct qsp_report_entry *e = &rep->entries[i];
+
+        g_free(e->callsite_at);
+    }
+    g_free(rep->entries);
+}
+
+void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max)
+{
+    GTree *tree = g_tree_new_full(qsp_tree_cmp, NULL, g_free, NULL);
+    struct qsp_report rep;
+
+    qsp_init();
+
+    rep.entries = g_new0(struct qsp_report_entry, max);
+    rep.n_entries = 0;
+    rep.max_n_entries = max;
+
+    qsp_mktree(tree);
+    g_tree_foreach(tree, qsp_tree_report, &rep);
+    g_tree_destroy(tree);
+
+    pr_report(&rep, f, cpu_fprintf);
+    report_destroy(&rep);
+}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index e1c3fed4dc..579faa2ca6 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -3,6 +3,7 @@ util-obj-y += bufferiszero.o
 util-obj-y += lockcnt.o
 util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
 util-obj-y += main-loop.o iohandler.o
+util-obj-$(CONFIG_SYNC_PROFILER) += qsp.o
 util-obj-$(CONFIG_POSIX) += aio-posix.o
 util-obj-$(CONFIG_POSIX) += compatfd.o
 util-obj-$(CONFIG_POSIX) += event_notifier-posix.o
-- 
2.17.1
