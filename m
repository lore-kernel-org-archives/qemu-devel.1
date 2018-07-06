Received: from eggs.gnu.org ([2001:4830:134:3::10]:33704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbT1a-0002hu-Jl
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbT1X-0000gE-Gi
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:51:58 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Jul 2018 12:51:27 -0300
Message-Id: <20180706155127.7483-4-f4bug@amsat.org>
In-Reply-To: <20180706155127.7483-1-f4bug@amsat.org>
References: <20180706155127.7483-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.0 3/3] linux-user: Report error message
 on stderr, rather than stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org

Code change produced with:

  git ls-files linux-user | \
  xargs sed -i -E 's/(\s+)printf\s*\(("Unhandled.*)\);/\1fprintf(stderr, \2);/g'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/alpha/cpu_loop.c      | 2 +-
 linux-user/cris/cpu_loop.c       | 2 +-
 linux-user/microblaze/cpu_loop.c | 6 +++---
 linux-user/sh4/cpu_loop.c        | 2 +-
 linux-user/sparc/cpu_loop.c      | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index b87fcaea87..c1a98c8cbf 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -196,7 +196,7 @@ void cpu_loop(CPUAlphaState *env)
             arch_interrupt = false;
             break;
         default:
-            printf ("Unhandled trap: 0x%x\n", trapnr);
+            fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
             cpu_dump_state(cs, stderr, fprintf, 0);
             exit(EXIT_FAILURE);
         }
diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
index 1c5eca9f83..37bdcfa8cc 100644
--- a/linux-user/cris/cpu_loop.c
+++ b/linux-user/cris/cpu_loop.c
@@ -81,7 +81,7 @@ void cpu_loop(CPUCRISState *env)
             cpu_exec_step_atomic(cs);
             break;
         default:
-            printf ("Unhandled trap: 0x%x\n", trapnr);
+            fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
             cpu_dump_state(cs, stderr, fprintf, 0);
             exit(EXIT_FAILURE);
         }
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 5af12d5b21..2af93eb39a 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -105,8 +105,8 @@ void cpu_loop(CPUMBState *env)
                     queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
                     break;
                 default:
-                    printf("Unhandled hw-exception: 0x%" PRIx64 "\n",
-                           env->sregs[SR_ESR] & ESR_EC_MASK);
+                    fprintf(stderr, "Unhandled hw-exception: 0x%" PRIx64 "\n",
+                            env->sregs[SR_ESR] & ESR_EC_MASK);
                     cpu_dump_state(cs, stderr, fprintf, 0);
                     exit(EXIT_FAILURE);
                     break;
@@ -130,7 +130,7 @@ void cpu_loop(CPUMBState *env)
             cpu_exec_step_atomic(cs);
             break;
         default:
-            printf ("Unhandled trap: 0x%x\n", trapnr);
+            fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
             cpu_dump_state(cs, stderr, fprintf, 0);
             exit(EXIT_FAILURE);
         }
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 418833ea25..fdd348170b 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -84,7 +84,7 @@ void cpu_loop(CPUSH4State *env)
             arch_interrupt = false;
             break;
         default:
-            printf ("Unhandled trap: 0x%x\n", trapnr);
+            fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
             cpu_dump_state(cs, stderr, fprintf, 0);
             exit(EXIT_FAILURE);
         }
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7c4796ca23..91f714afc6 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -285,7 +285,7 @@ void cpu_loop (CPUSPARCState *env)
             cpu_exec_step_atomic(cs);
             break;
         default:
-            printf ("Unhandled trap: 0x%x\n", trapnr);
+            fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
             cpu_dump_state(cs, stderr, fprintf, 0);
             exit(EXIT_FAILURE);
         }
-- 
2.18.0
