Received: from eggs.gnu.org ([209.51.188.92]:56334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGHVG-0000rQ-VK
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGHVG-0003Ck-3a
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:23:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGHVF-0003CF-Sl
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:23:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-11-armbru@redhat.com>
	<20190415155306.GN2852@work-vm>
Date: Tue, 16 Apr 2019 08:23:30 +0200
In-Reply-To: <20190415155306.GN2852@work-vm> (David Alan Gilbert's message of
	"Mon, 15 Apr 2019 16:53:07 +0100")
Message-ID: <87tvey79jx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/17] target: Clean up how the dump_mmu()
 print
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> The various dump_mmu() take an fprintf()-like callback and a FILE * to
>> pass to it, and so do their helper functions.  Passing around callback
>> and argument is rather tiresome.
>> 
>> Most dump_mmu() are called only by the target's hmp_info_tlb().  These
>> all pass monitor_printf() cast to fprintf_function and the current
>> monitor cast to FILE *.
>> 
>> SPARC's dump_mmu() gets also called from target/sparc/ldst_helper.c a
>> few times #ifdef DEBUG_MMU.  These calls pass fprintf() and stdout.
>
> You might want to fixup the DPRINTF_MMU in ldst_helper.c to also
> use qemu_printf.

Hmm.  Makes DPRINTF_MMU() consistent with how dump_mmu() prints, but
inconsistent with how the other DPRINTF_*() print.  Dunno...

All that debug code should really be tracepoints of course.

I'll leave DPRINTF_MMU() alone unless a maintainer (cc'ed) wants me to
update it.

>> The type-punning is technically undefined behaviour, but works in
>> practice.  Clean up: drop the callback, and call qemu_printf()
>> instead.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!
