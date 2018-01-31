Received: from eggs.gnu.org ([2001:4830:134:3::10]:38419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egh8o-0006Ue-Gh
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 20:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egh8k-0007bz-TE
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 20:24:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1egh8k-0007aF-M3
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 20:24:42 -0500
References: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
	<20180123085432.3419.84711.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cdd33248-c2b8-dfe1-1e8b-108503f15e77@redhat.com>
Date: Tue, 30 Jan 2018 20:24:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180123085432.3419.84711.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v5 13/24] kvm: remove BQL lock/unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 23/01/2018 03:54, Pavel Dovgalyuk wrote:
> @@ -1861,7 +1861,6 @@ int kvm_cpu_exec(CPUState *cpu)
>          return EXCP_HLT;
>      }
> =20
> -    qemu_mutex_unlock_iothread();
>      cpu_exec_start(cpu);
>      do {
>          MemTxAttrs attrs;


So this means that kvm_cpu_exec is now called without taking the BQL.
I'll leave aside the bisectability issue (patch 11 breaks kvm_cpu_exec,
because this qemu_mutex_unlock_iothread now has an assertion failure),
since they are easily fixed by squashing patches 11-13 together.

The lines immediately above are

    if (kvm_arch_process_async_events(cpu)) {
        atomic_set(&cpu->exit_request, 0);
        return EXCP_HLT;
    }

So this means that, after patch 11, kvm_arch_process_async_events went
from "called with BQL taken" to "called with BQL not taken".  And that
is completely broken, because it accesses cs->interrupt_request just
like cpu_has_work.  Previous reviews have ascertained that accessing
cs->interrupt_request requires taking the BQL; this is the same, except
worse because now we can even *write* cs->interrupt_request (clear bits)
without taking the lock.  I don't need to explain to you why this is bad.

         .------------------------------------------------.
         | .--------------------------------------------. |
         | | This is not how you are supposed to modify | |
         | |             multi-threaded code.           | |
         | '--------------------------------------------' |
         '------------------------------------------------'

If something can be accessed outside a lock, e.g. with atomics, that has
to be documented.  In addition, if it's not obvious whether a function
is called with a lock or without, you add comments that make it clear.
Take a lock at accel/tcg/translate-all.c or exec.c for examples.

This is the last pass through this series that I make.  I'll pick the
patches that I consider ready, for everything else you'll have to find a
reviewer that is willing to look through the series and vouch for it
with a "Reviewed-by".

Paolo
