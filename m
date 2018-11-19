Received: from eggs.gnu.org ([2001:4830:134:3::10]:32769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gOo9z-0001Sa-Cz
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gOo9y-0007H4-Cn
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:20:35 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gOo9y-0007FH-36
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:20:34 -0500
Received: by mail-wm1-x344.google.com with SMTP id r11-v6so6313154wmb.2
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 10:20:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20181116164806.26929-1-pbonzini@redhat.com>
	<20181116164806.26929-2-pbonzini@redhat.com>
	<20181116171226.GC2457@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d42a7861-ac2f-8c7c-b824-edb8ab2ee283@redhat.com>
Date: Mon, 19 Nov 2018 19:20:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181116171226.GC2457@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: savevm: consult migration
 blockers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

On 16/11/18 18:12, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> There is really no difference between live migration and savevm, except
>> that savevm does not require bdrv_invalidate_cache to be implemented
>> by all disks.  However, it is unlikely that savevm is used with anything
>> except qcow2 disks, so the penalty is small and worth the improvement
>> in catching bad usage of savevm.
>>
>> Only one place was taking care of savevm when adding a migration blocker,
>> and it can be removed.
> 
> OK, I'm not sure if it was actually a split between savevm and migration
> or just that the migration blockers were added later.

Just the latter, I think.

>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  migration/savevm.c | 4 ++++
>>  target/i386/kvm.c  | 3 ---
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index ef707b8c43..1c49776a91 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2455,6 +2455,10 @@ int save_snapshot(const char *name, Error **errp)
>>      struct tm tm;
>>      AioContext *aio_context;
>>  
>> +    if (migration_is_blocked(errp)) {
>> +        return false;
>> +    }
>> +
>>      if (!replay_can_snapshot()) {
>>          error_setg(errp, "Record/replay does not allow making snapshot "
>>                     "right now. Try once more later.");
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 3b6fbd3f20..d222b68fe4 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -1284,7 +1284,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>      if (!env->user_tsc_khz) {
>>          if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
>>              invtsc_mig_blocker == NULL) {
>> -            /* for migration */
>>              error_setg(&invtsc_mig_blocker,
>>                         "State blocked by non-migratable CPU device"
>>                         " (invtsc flag)");
>> @@ -1294,8 +1293,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>                  error_free(invtsc_mig_blocker);
>>                  return r;
>>              }
>> -            /* for savevm */
>> -            vmstate_x86_cpu.unmigratable = 1;
> 
> So that means vmstate_x86_cpu can be static now - but why does it live
> in machine.c rather than cpu.c ?

Generally all vmstate lives in machine.c.  Just historical reasons, it
was moved out of vl.c (!) many moons ago.

Paolo
