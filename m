Received: from eggs.gnu.org ([2001:4830:134:3::10]:49857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1erOer-0007eB-SC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1erOen-0005zx-01
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:54:05 -0500
References: <20180301120826.6847-1-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <395cd836-3adc-b432-5c17-b7dc01dcee1e@redhat.com>
Date: Thu, 1 Mar 2018 14:53:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180301120826.6847-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tcg: fix loading 31bit PSWs with
 the highest bit set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 01.03.2018 13:08, David Hildenbrand wrote:
> Let's also put the 31-bit hack in front of the REAL MMU, otherwise right
> now we get errors when loading a PSW where the highest bit is set (e.g.
> via s390-netboot.img). The highest bit is not masked away, therefore we
> inject addressing exceptions into the guest.
> 
> The proper fix will later be to do all address wrapping before accessing
> the MMU - so we won't get any "wrong" entries in there (which makes
> flushing also easier). But that will require more work (wrapping in
> load_psw, wrapping when incrementing the PC, wrapping every memory
> access).
> 
> This fixes the tests/pxe-test test.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index 411051edc3..dfee221111 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -107,6 +107,10 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr, int size,
>              return 1;
>          }
>      } else if (mmu_idx == MMU_REAL_IDX) {
> +        /* 31-Bit mode */
> +        if (!(env->psw.mask & PSW_MASK_64)) {
> +            vaddr &= 0x7fffffff;
> +        }

Since the preceeding if-statement has exactly the same check, I think
you could also merge the two checks by putting that in front of the
if-statement instead?

Apart from that, patch looks good to me.

 Thomas
