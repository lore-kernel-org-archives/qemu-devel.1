Received: from eggs.gnu.org ([2001:4830:134:3::10]:46931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g7IWz-00059R-Ai
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g7IWu-0004HL-Cg
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:07:57 -0400
Date: Tue, 2 Oct 2018 13:07:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181002130741.779f163e.cohuck@redhat.com>
In-Reply-To: <20180927130303.12236-1-david@redhat.com>
References: <20180927130303.12236-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/9] s390x: instruction flags and AFP
 registers for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Thu, 27 Sep 2018 15:02:54 +0200
David Hildenbrand <david@redhat.com> wrote:

> I wanted to add AFP-register control related checks for a long time.
> However, doing these checks in each and every relevant handler is ugly.
> 
> As I will need similar checks for vector instructions (yes, I'm looking into
> that but it might take some time), I decided to introduce per-instruction
> flags, that allow to to check such "instruction properties" globally.
> Tagging e.g. privileged instructions that way turns out quite nice.
> 
> Of course, while at it some fixes and cleanups.
> 
> v3 -> v4
> - Use deposit32() and simplify one assert in patch #2
> - Rename IF_HFP[123] to IF_AFP[123] in patch #5 and #6
> - Moved comment fixup from patch #8 to patch #7 (again :/)
> - Added r-bs
> 
> v2 -> v3:
> - Moved comment fixup from patch #8 to patch #7
> - Added an include to kvm.c in patch #1 to make it compile
> - Added r-bs
> 
> v1 -> v2:
> - added "s390x: move tcg_s390_program_interrupt() into TCG code and ..."
> - Some checkpatch changes lead to some false positives in the last two
>   patches ... to work around them, I dropped some unnecessary parantheses.
> 
> David Hildenbrand (9):
>   s390x: move tcg_s390_program_interrupt() into TCG code and mark it
>     noreturn
>   s390x/tcg: factor out and fix DATA exception injection
>   s390x/tcg: store in the TB flags if AFP is enabled
>   s390x/tcg: support flags for instructions
>   s390x/tcg: add instruction flags for floating point instructions
>   s390x/tcg: check for AFP-register, BFP and DFP data exceptions
>   s390x/tcg: handle privileged instructions via flags
>   s390x/tcg: fix FP register pair checks
>   s390x/tcg: refactor specification checking
> 
>  target/s390x/cpu.h         |   9 +
>  target/s390x/excp_helper.c |  36 ++++
>  target/s390x/fpu_helper.c  |  13 +-
>  target/s390x/helper.h      |   1 +
>  target/s390x/insn-data.def | 395 +++++++++++++++++++------------------
>  target/s390x/interrupt.c   |  15 +-
>  target/s390x/kvm.c         |   4 +-
>  target/s390x/tcg-stub.c    |  10 +
>  target/s390x/tcg_s390x.h   |   4 +
>  target/s390x/translate.c   | 197 ++++++++----------
>  10 files changed, 344 insertions(+), 340 deletions(-)
> 

Thanks, applied.
