Received: from eggs.gnu.org ([2001:4830:134:3::10]:45297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQlm-0005KE-7C
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQli-0008AX-7X
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:08:50 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dLQli-0008AD-13
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:08:46 -0400
Received: by mail-wr0-x22e.google.com with SMTP id q97so12559689wrb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 02:08:45 -0700 (PDT)
References: <1497351329-12936-1-git-send-email-thuth@redhat.com>
	<87wp8ght4g.fsf@linaro.org>
	<877f0et1zo.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <877f0et1zo.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Date: Thu, 15 Jun 2017 10:09:19 +0100
Message-ID: <87r2ylmxc0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc/excp_helper: Take
 BQL before calling cpu_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <bherren@au1.ibm.com>


Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

> Alex Bennée <alex.bennee@linaro.org> writes:
>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> Since the introduction of MTTCG, using the msgsnd instruction
>>> abort()s if being called without holding the BQL. So let's protect
>>> that part of the code now with qemu_mutex_lock_iothread().
>>>
>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1694998
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> p.s. I was checking the ppc code for other CPU_FOREACH patterns and I
>> noticed the tlb_flush calls could probably use the tlb_flush_all_cpus
>> API instead of manually looping themselves.
>
> Will that be synchronous call? In PPC, we do lazy tlb flush, the tlb
> flushes are batched until a synchronization point (for optimization).

No by default the non-synced flushes will occur at the end of the
current executing block (cpu->exit_request is set and the work is done
when we exit the run-loop).

> The batching is achieved using a tlb_need_flush (global/local) and when
> there is isync/ptesync or an exception, the actual flush is done. At
> this point we need to make sure that the flush is synchronous.

If you want to ensure the flush is synchronous you need to call the
_all_cpus_synced variants and do a cpu_loop_exit in your helper. This
ensures that all the flushes queued up will be executed before execution
starts at the next PC of the calling thread.

>
>> You should also double check the semantics to make sure none of them
>> need to use the _synced variant and a cpu_exit if the flush needs to
>> complete w.r.t the originating CPU.
>
> Regards,
> Nikunj


--
Alex Bennée
