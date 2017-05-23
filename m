Received: from eggs.gnu.org ([2001:4830:134:3::10]:48345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDC8X-0005fO-Og
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDC8W-0006f4-Ox
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:54:17 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDC8W-0006ew-JG
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:54:16 -0400
Received: by mail-qk0-x242.google.com with SMTP id u75so23274912qka.1
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 08:54:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-3-rth@twiddle.net>
	<20170523104851.37tseiq5zlpwevr6@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d059a3b3-ac6c-27d2-5270-b6d5b32cc41d@twiddle.net>
Date: Tue, 23 May 2017 08:54:11 -0700
MIME-Version: 1.0
In-Reply-To: <20170523104851.37tseiq5zlpwevr6@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/31] target/s390x: Implement EXECUTE via
 new TranslationBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

On 05/23/2017 03:48 AM, Aurelien Jarno wrote:
> On 2017-05-22 20:02, Richard Henderson wrote:
>> Previously, helper_ex would construct the insn and then implement
>> the insn via direct calls other helpers.  This was sufficient to
>> boot Linux but that is all.
>>
>> It is easy enough to go the whole nine yards by stashing state for
>> EXECUTE within the cpu, and then relying on a new TB to be created
>> that properly and completely interprets the insn.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>   target/s390x/cpu.h         |   4 +-
>>   target/s390x/helper.h      |   2 +-
>>   target/s390x/insn-data.def |   4 +-
>>   target/s390x/machine.c     |  19 +++++++
>>   target/s390x/mem_helper.c  | 136 +++++++++++----------------------------------
>>   target/s390x/translate.c   | 124 +++++++++++++++++++++++++----------------
>>   6 files changed, 133 insertions(+), 156 deletions(-)
> 
> This looks good on the principle, and finally removes a big hack. That
> said it prevent my test system to boot. I haven't investigated why yet.

Hmm.  I've not got a complete environment -- merely booting a kernel up to the 
point it fails to find a rootfs.  Which did find several problems with my first 
attempts at this, but wouldn't have exercised paging.  I'll try again to get a 
full install working...

I wonder if I needed to adjust s390_cpu_handle_mmu_fault (and its myriad 
subroutines) to handle setting ILEN correctly.

There might be a simpler fix though.  Currently I advance the PC and remember 
the ilen of the EX(RL).  Maybe better to *not* advance the PC so as to have the 
original EX(RL) right there for ILEN_LATER and ILEN_LATER_INC to operate on.

Something like this, as a delta patch.


r~


diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 67c85f0..5773f92 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2206,8 +2206,10 @@ static ExitStatus op_ex(DisasContext *s, DisasOps *o)
          tcg_temp_free_i64(v1);
      }

-    /* End the TB; a new TB will be created for modified insn.  */
-    return EXIT_PC_STALE;
+    /* End the TB; a new TB will be created for modified insn.
+       Note that the modified insn runs with this same PC.  */
+    update_psw_addr(s);
+    return EXIT_PC_UPDATED;
  }

  static ExitStatus op_fieb(DisasContext *s, DisasOps *o)
@@ -5189,14 +5191,10 @@ static const DisasInsn *extract_insn
          insn = s->ex_value & 0xffffffffffff0000ull;
          ilen = s->ex_value & 0xff;
          op = insn >> 56;
-        s->ilen = ilen;
-        s->next_pc = s->pc;
      } else {
          insn = ld_code2(env, pc);
          op = (insn >> 8) & 0xff;
          ilen = get_ilen(op);
-        s->ilen = ilen;
-        s->next_pc = s->pc + ilen;

          switch (ilen) {
          case 2:
@@ -5212,6 +5210,8 @@ static const DisasInsn *extract_insn
              g_assert_not_reached();
          }
      }
+    s->next_pc = s->pc + ilen;
+    s->ilen = ilen;

      /* We can't actually determine the insn format until we've looked up
         the full insn opcode.  Which we can't do without locating the
@@ -5470,17 +5470,14 @@ void gen_intermediate_code

          /* If we reach a page boundary, are single stepping,
             or exhaust instruction count, stop generation.  */
-        if (status == NO_EXIT) {
-            if (unlikely(dc.ex_value)) {
-                /* The PC on entry is already advanced.  */
-                status = EXIT_PC_UPDATED;
-            } else if (dc.pc >= next_page_start
-                       || tcg_op_buf_full()
-                       || num_insns >= max_insns
-                       || singlestep
-                       || cs->singlestep_enabled) {
-                status = EXIT_PC_STALE;
-            }
+        if (status == NO_EXIT
+            && (dc.pc >= next_page_start
+                || tcg_op_buf_full()
+                || num_insns >= max_insns
+                || singlestep
+                || cs->singlestep_enabled
+                || dc.ex_value)) {
+            status = EXIT_PC_STALE;
          }
      } while (status == NO_EXIT);
