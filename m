Received: from eggs.gnu.org ([2001:4830:134:3::10]:51127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ePCj4-0000lH-8I
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ePCj0-00021h-8w
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:29:54 -0500
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
	<20170202051445.5735-96-david@gibson.dropbear.id.au>
	<72cdaa82-8496-1d1d-e7bc-3f962f3853d1@suse.de>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <819a1e85-f50e-e1b0-55c0-696225b42606@redhat.com>
Date: Wed, 13 Dec 2017 20:29:40 +0100
MIME-Version: 1.0
In-Reply-To: <72cdaa82-8496-1d1d-e7bc-3f962f3853d1@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 095/107] spapr: clock should count only if
 vm is running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru

On 13/12/2017 20:19, Alexander Graf wrote:
> 
> 
> On 02.02.17 06:14, David Gibson wrote:
>> From: Laurent Vivier <lvivier@redhat.com>
>>
>> This is a port to ppc of the i386 commit:
>>     00f4d64 kvmclock: clock should count only if vm is running
>>
>> We remove timebase_post_load function, and use the VM state
>> change handler to save and restore the guest_timebase (on stop
>> and continue).
>>
>> We keep timebase_pre_save to reduce the clock difference on
>> migration like in:
>>     6053a86 kvmclock: reduce kvmclock difference on migration
>>
>> Time base offset has originally been introduced by commit
>>     98a8b52 spapr: Add support for time base offset migration
>>
>> So while VM is paused, the time is stopped. This allows to have
>> the same result with date (based on Time Base Register) and
>> hwclock (based on "get-time-of-day" RTAS call).
>>
>> Moreover in TCG mode, the Time Base is always paused, so this
>> patch also adjust the behavior between TCG and KVM.
>>
>> VM state field "time_of_the_day_ns" is now useless but we keep
>> it to be able to migrate to older version of the machine.
>>
>> As vmstate_ppc_timebase structure (with timebase_pre_save() and
>> timebase_post_load() functions) was only used by vmstate_spapr,
>> we register the VM state change handler only in ppc_spapr_init().
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Just a small heads-up: I've been debugging an OpenQA regression lately
> where our automated testing regressed with QEMU 2.9. With stock 2.9.1, I
> get a failure rate of "weird" effects (probably TB divergence between
> vcpus) of ~30%. With this patch reverted it's back to 0%.
> 
> I *think* something here causes the TB offset of multiple threads (I'm
> running -smp 2,threads=2) to diverge.
> 
> I'll keep debugging things tomorrow, but I'll be happy to see anyone
> else beat me to analyze what is going wrong ;).

Don't know if it can be related, but for migration we need:

http://patchwork.ozlabs.org/patch/840170/

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index b9c49c22f2..4e11e6f489 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8081,10 +8081,10 @@  static void gen_spr_power8_ebb(CPUPPCState *env)
 /* Virtual Time Base */
 static void gen_spr_vtb(CPUPPCState *env)
 {
-    spr_register(env, SPR_VTB, "VTB",
+    spr_register_kvm(env, SPR_VTB, "VTB",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
-                 0x00000000);
+                 KVM_REG_PPC_VTB, 0x00000000);
 }

 static void gen_spr_power8_fscr(CPUPPCState *env)

Thanks,
Laurent
