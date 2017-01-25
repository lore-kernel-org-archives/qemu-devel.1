Received: from eggs.gnu.org ([2001:4830:134:3::10]:36362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWMG0-0001iF-4v
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWMFu-0007lY-Na
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:00:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWMFu-0007lE-9I
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:00:50 -0500
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
	<20170124071719.4572.92155.stgit@PASHA-ISP>
	<db455af4-4d66-d81f-4f4f-1ad47100dffe@redhat.com>
	<000701d27701$2a0aa8e0$7e1ffaa0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <edb33598-ba1e-883b-ed61-61b7a50f8f0c@redhat.com>
Date: Wed, 25 Jan 2017 13:00:46 +0100
MIME-Version: 1.0
In-Reply-To: <000701d27701$2a0aa8e0$7e1ffaa0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 04/14] icount: exit cpu loop on expire
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com



On 25/01/2017 12:50, Pavel Dovgalyuk wrote:
>>> +                /* icount has expired, we need to break the execution loop.
>>> +                   This check is needed before tb_find to make execution
>>> +                   deterministic - tb_find may cause an exception
>>> +                   while translating the code from non-mapped page. */
>>> +                if (use_icount && ((cpu->icount_extra == 0
>>> +                                    && cpu->icount_decr.u16.low == 0)
>>> +                                || (int32_t)cpu->icount_decr.u32 < 0)) {
>>> +                    if (cpu->exception_index == -1) {
>>> +                        cpu->exception_index = EXCP_INTERRUPT;
>>> +                    }
>>> +                    cpu_loop_exit(cpu);
>>> +                }
>> Can this can be placed in cpu_handle_interrupt itself?  
> I guess it could. I placed it here because it doesn't related to interrupts.

True, on the other hand neither is

    if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
        atomic_set(&cpu->exit_request, 0);
        cpu->exception_index = EXCP_INTERRUPT;
        cpu_loop_exit(cpu);
    }

Except for the replay_has_interrupt() that you added, but I don't understand
that one either...

Paolo
