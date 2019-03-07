Received: from eggs.gnu.org ([209.51.188.92]:52463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h1vzm-00053F-8S
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h1vzl-0003K1-4S
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:35:46 -0500
Date: Thu, 7 Mar 2019 17:35:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190307173534.34b1113e.cohuck@redhat.com>
In-Reply-To: <20190307121539.12842-1-david@redhat.com>
References: <20190307121539.12842-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/32] s390x/tcg: Vector Instruction
 Support Part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu,  7 Mar 2019 13:15:07 +0100
David Hildenbrand <david@redhat.com> wrote:

> This is the first part of vector instruction support for s390x. Parts
> will be sent and reviewed piece by piece.
> 
> Part 1: Vector Support Instructions
> Part 2: Vector Integer Instructions
> Part 3: Vector String Instructions
> Part 4: Vector Floating-Point Instructions
> 
> The current state can be found at (kept updated):
>     https://github.com/davidhildenbrand/qemu/tree/vx
> It is based on
>     https://github.com/cohuck/qemu/tree/s390-next
> 
> With the current state I can boot Linux kernel + user space compiled with
> SIMD support. This allows to boot distributions compiled exclusively for
> z13, requiring SIMD support. Also, I have a growing set of tests for
> kvm-unit-tests and tests/tcg which I cross-test on a real s390x system.
> 
> In this part, the basic infrastructure and all Vector Support Instructions
> introduced with the "Vector Facility" are added. The Vector Extension
> Facilities are not considered for now.
> 
> We make use of the existing gvec expansion + ool (out-of-line) support.
> This will be heavily used especially for part 2 (Integer Instructions)
> where we can actually reuse quite some existing gvec expansions.
> 
> v2 -> v3:
> - "s390x/tcg: Utilities for vector instruction helpers"
> -- inline helpers in header file
> - "s390x/tcg: Implement VECTOR LOAD MULTIPLE"
> -- optimize loading of last element
> - "s390x/tcg: Implement VECTOR PACK *"
> -- make the static funtion arrays const
> - "s390x/tcg: Implement VECTOR REPLICATE"
> -- use "tcg_gen_gvec_dup_mem"
> - "s390x/tcg: Provide probe_write helper"
> -- Add check for CONFIG_USER_ONLY
> -- Optimize calculation of length
> - Added r-b's
> 
> v1 -> v2:
> - Basically address all wonderful review comments from Richard (too many
>   to name them all)
> - Probe write access to get rid of FIXMEs
> - Heavily rework "s390x/tcg: Implement VECTOR PACK *"
> -- Process cc and !cc separately.
> -- Helper for VPK
> - Don't use a temporary vector register (for now)
> - Drop load_vec_element() and store_vec_element()
> - Use ES_* instead of MO_*, will come in handy when we use ES_128 later
> - .... many many other minor things
> 
> David Hildenbrand (32):
>   s390x/tcg: Define vector instruction formats
>   s390x/tcg: Check vector register instructions at central point
>   s390x/tcg: Utilities for vector instruction helpers
>   s390x/tcg: Implement VECTOR GATHER ELEMENT
>   s390x/tcg: Implement VECTOR GENERATE BYTE MASK
>   s390x/tcg: Implement VECTOR GENERATE MASK
>   s390x/tcg: Implement VECTOR LOAD
>   s390x/tcg: Implement VECTOR LOAD AND REPLICATE
>   s390x/tcg: Implement VECTOR LOAD ELEMENT
>   s390x/tcg: Implement VECTOR LOAD ELEMENT IMMEDIATE
>   s390x/tcg: Implement VECTOR LOAD GR FROM VR ELEMENT
>   s390x/tcg: Implement VECTOR LOAD LOGICAL ELEMENT AND ZERO
>   s390x/tcg: Implement VECTOR LOAD MULTIPLE
>   s390x/tcg: Implement VECTOR LOAD TO BLOCK BOUNDARY
>   s390x/tcg: Implement VECTOR LOAD VR ELEMENT FROM GR
>   s390x/tcg: Implement VECTOR LOAD VR FROM GRS DISJOINT
>   s390x/tcg: Implement VECTOR LOAD WITH LENGTH
>   s390x/tcg: Implement VECTOR MERGE (HIGH|LOW)
>   s390x/tcg: Implement VECTOR PACK *
>   s390x/tcg: Implement VECTOR PERMUTE
>   s390x/tcg: Implement VECTOR PERMUTE DOUBLEWORD IMMEDIATE
>   s390x/tcg: Implement VECTOR REPLICATE
>   s390x/tcg: Implement VECTOR REPLICATE IMMEDIATE
>   s390x/tcg: Implement VECTOR SCATTER ELEMENT
>   s390x/tcg: Implement VECTOR SELECT
>   s390x/tcg: Implement VECTOR SIGN EXTEND TO DOUBLEWORD
>   s390x/tcg: Provide probe_write_access helper
>   s390x/tcg: Implement VECTOR STORE
>   s390x/tcg: Implement VECTOR STORE ELEMENT
>   s390x/tcg: Implement VECTOR STORE MULTIPLE
>   s390x/tcg: Implement VECTOR STORE WITH LENGTH
>   s390x/tcg: Implement VECTOR UNPACK *
> 
>  target/s390x/Makefile.objs      |   1 +
>  target/s390x/cpu.h              |   7 +
>  target/s390x/helper.h           |  21 +
>  target/s390x/insn-data.def      |  82 +++
>  target/s390x/insn-format.def    |  25 +
>  target/s390x/internal.h         |   2 +
>  target/s390x/mem_helper.c       |  25 +
>  target/s390x/translate.c        |  61 ++-
>  target/s390x/translate_vx.inc.c | 935 ++++++++++++++++++++++++++++++++
>  target/s390x/vec.h              | 101 ++++
>  target/s390x/vec_helper.c       | 193 +++++++
>  11 files changed, 1452 insertions(+), 1 deletion(-)
>  create mode 100644 target/s390x/translate_vx.inc.c
>  create mode 100644 target/s390x/vec.h
>  create mode 100644 target/s390x/vec_helper.c
> 

Thanks, applied.
