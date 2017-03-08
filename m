Received: from eggs.gnu.org ([2001:4830:134:3::10]:58221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cldht-00070a-MX
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 10:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cldhq-00072s-Jq
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 10:40:53 -0500
Received: from h2042504.stratoserver.net ([85.214.107.226]:52846)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cldhq-00071v-9v
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 10:40:50 -0500
References: <20170308001637.9838-1-git@kirschju.re>
	<20170308115909.GD10232@work-vm>
From: Julian Kirsch <git@kirschju.re>
Message-ID: <24b64496-ea69-5ab1-e0c1-096172158d88@kirschju.re>
Date: Wed, 8 Mar 2017 16:40:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170308115909.GD10232@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] X86/HMP: Expose x86 model specific
 registers via human monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 08.03.2017 12:59, Dr. David Alan Gilbert wrote:
> * Julian Kirsch (git@kirschju.re) wrote:
> 
> I'll leave those who know more about gdb to answer whether that's the best way
> of doing it; but I can see them being useful to those just trying to debug
> stuff from the monitor.
> 

Just want to make a side note here that the qemu monitor is fully accessible
from gdb using the "monitor" command. Hence adding the commands to hmp makes
them available for the monitor and gdb clients at the same time.

> 
> I think the patch needs to be split up; you should at least have:
>   a) The big part that moves the helpers (if that's the right thing to do)
>   b) The qmp code
>   c) The hmp code
> 
> I also don't see why you need to move the helpers.

Yes, splitting the patch up into three smaller ones sounds like a good idea.

The helpers are moved to helpers.c because none of the functions in
misc_helpers.c seems to be contained in any header file (just referenced by
tcg). I didn't want to be an exception to this rule. Moving the functionality to
cpu_x86_[rd|wr]msr and including their prototype in target/i386/cpu.h also makes
them available to the qmp code in cpus.c in a way I considered elegant enough.
Besides, helper_cpuid/cpu_x86_cpuid seem to follow the same structure. Correct
me if I'm wrong on this one.


>> There are several things I would like to pooint out about this patch:
>>   - The "msr-list" command currently displays MSR values for all virtual cpus.
>>     This is somewhat inconsistent with "info registers" just displaying the
>>     value of the current default cpu. One might think about just displaying the
>>     current value and offer access to other CPU's MSRs by means of switching
>>     between CPUs using the "cpu" monitor command.
> 
> Yes, it's probably best to make it just the current CPU to be consistent.
> 

Will take care of this as well. This will causes me to rename "msr-list" to
"msr-get".

>>   - The new version of x86_cpu_rdmsr exposes MSRs that are arguably of
>>     questionable help for any human / tool using the monitor. However I merely
>>     felt a deep urge to reflect the full MSR list from kvm.c when writing the
>>     code.
> 
> No point in guessing which ones the human will need; may as well give them
> everything so they can debug bugs that are obscure.
> 

Alright, then let's keep the shadiness.

>>   - While the need for msr-list is evident (see commit msg), msr-set could be
>>     used in more obscure cases. For instance, one might offer a way to access
>>     and configure performance counter MSRs of the guest via the hmp. If this
>>     feels too much like an inacceptable hack, I'll happily drop the msr-set
>>     part.
> 
> It feels reasonable to have it for debugging.
> 

Fine with me.

> (Heck, aren't those big switch statements depressing, I'm sure there
> must be a way to turn a chunk of them into a table that could be shared between
> the helpers and even maybe the kvm code; anyway, not the subject of this patch).
> 

(I fully agree.)

> Dave
> 

Best,
Julian
