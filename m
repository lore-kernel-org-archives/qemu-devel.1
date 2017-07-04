Received: from eggs.gnu.org ([2001:4830:134:3::10]:42671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSKba-0005oR-A3
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSKbX-00027X-7h
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:58:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSKbX-00027D-1A
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:58:47 -0400
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-21-git-send-email-pbonzini@redhat.com>
	<9bf31fb2-a4a8-e3f7-5947-3a7d014281fe@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca5e5764-118f-c69e-2034-c56ebf1f2de3@redhat.com>
Date: Tue, 4 Jul 2017 11:58:42 +0200
MIME-Version: 1.0
In-Reply-To: <9bf31fb2-a4a8-e3f7-5947-3a7d014281fe@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/22] target/i386: add the tcg_enabled()
 in target/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com



On 03/07/2017 22:19, Richard Henderson wrote:
> On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
>> @@ -215,10 +215,12 @@ void breakpoint_handler(CPUState *cs)
>>       if (cs->watchpoint_hit) {
>>           if (cs->watchpoint_hit->flags & BP_CPU) {
>>               cs->watchpoint_hit = NULL;
>> -            if (check_hw_breakpoints(env, false)) {
>> -                raise_exception(env, EXCP01_DB);
>> -            } else {
>> -                cpu_loop_exit_noexc(cs);
>> +            if (tcg_enabled()) {
>> +                if (check_hw_breakpoints(env, false)) {
>> +                    raise_exception(env, EXCP01_DB);
>> +                } else {
>> +                    cpu_loop_exit_noexc(cs);
>> +                }
> 
> This seems like an odd place for the tcg_enabled check.  It seems like
> it should be much higher in the if/call chain.
> 
> Why are we doing all these bp checks only to disable the final raising
> of an exception?
> 
> Indeed, what in bpt_helper.c needs to be compiled in when !tcg_enabled?

Only cpu_x86_update_dr7, but it's not used by KVM (I was worried about
guest debug aka gdbstub mode).  So that's my own brain fart; I'll wrap
the cpu_x86_update_dr7 with tcg_enabled and drop the file altogether.

Paolo
