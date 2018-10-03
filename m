Received: from eggs.gnu.org ([2001:4830:134:3::10]:59517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7jS4-0008V0-0q
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7jS0-0004w9-Ro
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:52:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7jS0-0004vV-J0
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:52:36 -0400
References: <20181002212921.30982-1-cota@braap.org>
	<20181002212921.30982-3-cota@braap.org> <87h8i3l75j.fsf@linaro.org>
	<a01a9547-d182-daaf-724a-5a836dd9ff02@redhat.com>
	<20181003154844.GA27366@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91494a20-1090-3e3f-e099-ed06bd6e0e51@redhat.com>
Date: Wed, 3 Oct 2018 17:52:32 +0200
MIME-Version: 1.0
In-Reply-To: <20181003154844.GA27366@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] cputlb: serialize tlb updates with
 env->tlb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 03/10/2018 17:48, Emilio G. Cota wrote:
>> it's probably best to do all atomic_set instead of just the memberwise copy.
> Atomics aren't necessary here, as long as the copy is protected by the
> lock. This allows other vCPUs to see a consistent view of the data (since
> they always acquire the TLB lock), and since copy_tlb is only called
> by the vCPU that owns the TLB, regular reads from this vCPU will always
> see consistent data.

For reads I agree, but you may actually get a torn read if the writer
doesn't use atomic_set.

That's because in order to avoid UB all reads or writes that are
concurrent with another write must be atomic, and the write must be
atomic too.  The lock does prevent write-write concurrent accesses, but
not read-write, so the write must be atomic here.

Paolo
