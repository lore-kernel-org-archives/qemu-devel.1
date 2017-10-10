Received: from eggs.gnu.org ([2001:4830:134:3::10]:34110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1ryj-0006qU-O7
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1ryg-0001vV-F6
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:41:37 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:47735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1ryg-0001v2-8i
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:41:34 -0400
Received: by mail-wm0-f43.google.com with SMTP id t69so3836827wmt.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 03:41:34 -0700 (PDT)
References: <CAFEAcA_qCmsekM+bQT8qa7hceSSm2vcoYs-eTzKyH_BOpiVVcw@mail.gmail.com>
	<87zi8z9vng.fsf@linaro.org>
	<CAFEAcA92r=9F=1TTj3YznUSGZR_zzmThfPWvx=ryLjhJFmj__w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09da157a-0f6a-3641-5aba-9bdd020c9a13@redhat.com>
Date: Tue, 10 Oct 2017 12:41:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA92r=9F=1TTj3YznUSGZR_zzmThfPWvx=ryLjhJFmj__w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] tcg/translate-all.c:169: tb_lock: Assertion
 `!have_tb_lock' failed when doing cpu_restore_state in usermode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 10/10/2017 12:07, Peter Maydell wrote:
> On 10 October 2017 at 10:53, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> Running the test program
>>> http://people.linaro.org/~peter.maydell/thumb-over-page
>>> (source at http://people.linaro.org/~peter.maydell/thumb-over-page.c)
>>> in the usermode emulator:
>>>  ./build/x86/arm-linux-user/qemu-arm
>>> ~/linaro/qemu-misc-tests/thumb-over-page
>>
>> Does this fail when run via system mode as well?
> 
> Nope, only usermode. (Makes sense, since the handle_cpu_signal()
> codepath is only used in usermode emulation.)

I've seen the same on x86.  Using the program counter from translate.c 
here looks very fishy:

    /* Now we have a real cpu fault.  Since this is the exact location of
     * the exception, we must undo the adjustment done by cpu_restore_state
     * for handling call return addresses.  */
    cpu_restore_state(cpu, pc + GETPC_ADJ);

and cpu_restore_state would just return false because tb_find_pc fails.  Maybe
something like this?

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 492ea0826c..66a4351b96 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -119,10 +119,13 @@ static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
         return 1; /* the MMU fault was handled without causing real CPU fault */
     }
 
-    /* Now we have a real cpu fault.  Since this is the exact location of
-     * the exception, we must undo the adjustment done by cpu_restore_state
-     * for handling call return addresses.  */
-    cpu_restore_state(cpu, pc + GETPC_ADJ);
+    if (pc >= (uintptr_t)tcg_ctx.code_gen_buffer &&
+        pc < (uintptr_t)tcg_ctx.code_gen_ptr) {
+        /* Now we have a real cpu fault.  Since this is the exact location of
+         * the exception, we must undo the adjustment done by cpu_restore_state
+         * for handling call return addresses.  */
+        cpu_restore_state(cpu, pc + GETPC_ADJ);
+    }
 
     sigprocmask(SIG_SETMASK, old_set, NULL);
     cpu_loop_exit(cpu);

(very rough idea)

Paolo
