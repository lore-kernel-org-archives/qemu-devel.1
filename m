Received: from eggs.gnu.org ([2001:4830:134:3::10]:53934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXz6k-0007KE-2W
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 20:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXz6e-0006Ah-70
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 20:51:09 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXz6c-00069q-Sf
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 20:51:03 -0500
Date: Fri, 14 Dec 2018 20:51:00 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181215015059.GA19384@flamenco>
References: <20181213050453.9677-1-cota@braap.org>
	<20181213050453.9677-8-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213050453.9677-8-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v5 07/73] cpu: make per-CPU locks an alias
 of the BQL in TCG rr mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, Dec 13, 2018 at 00:03:47 -0500, Emilio G. Cota wrote:
(snip)
> diff --git a/qom/cpu.c b/qom/cpu.c
> index aa15ea4af5..2ea5b1da08 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -371,7 +371,6 @@ static void cpu_common_initfn(Object *obj)
>      cpu->nr_cores = 1;
>      cpu->nr_threads = 1;
>  
> -    qemu_mutex_init(&cpu->lock);
>      qemu_cond_init(&cpu->cond);
>      QSIMPLEQ_INIT(&cpu->work_list);
>      QTAILQ_INIT(&cpu->breakpoints);

*ouch* this breaks user-mode, since we end up with cpu->lock == NULL.
I'm surprised that make check-qtest didn't pick this up--guess it's
all system-mode tests.

I've fixed this commit on github's v5 branch with the appended.

Thanks,

		Emilio
---
diff --git a/cpus.c b/cpus.c
index d8261903ac..9c6cd9b90f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2326,10 +2326,9 @@ void qemu_init_vcpu(CPUState *cpu)
      * cpu->lock is a standalone per-CPU lock.
      */
     if (qemu_is_tcg_rr()) {
+        qemu_mutex_destroy(cpu->lock);
+        g_free(cpu->lock);
         cpu->lock = &qemu_global_mutex;
-    } else {
-        cpu->lock = g_malloc(sizeof(*cpu->lock));
-        qemu_mutex_init(cpu->lock);
     }
 
     if (kvm_enabled()) {
diff --git a/qom/cpu.c b/qom/cpu.c
index 386b1e29dd..c4cb626393 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -367,6 +367,8 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
 
+    cpu->lock = g_new(QemuMutex, 1);
+    qemu_mutex_init(cpu->lock);
     qemu_cond_init(&cpu->cond);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
