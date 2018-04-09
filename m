Received: from eggs.gnu.org ([2001:4830:134:3::10]:42168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5VOi-0006Ux-6k
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5VOd-0000XQ-BU
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:55:44 -0400
Date: Mon, 9 Apr 2018 13:55:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180409135529.308fa637.cohuck@redhat.com>
In-Reply-To: <8d2a6da1-f45c-ba59-38cd-5e66db2bfd69@de.ibm.com>
References: <20180409113019.14568-1-david@redhat.com>
	<20180409113019.14568-2-david@redhat.com>
	<8d2a6da1-f45c-ba59-38cd-5e66db2bfd69@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.12 1/2] s390x/mmu:
 don't overwrite pending exception in mmu translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, 9 Apr 2018 13:50:03 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 04/09/2018 01:30 PM, David Hildenbrand wrote:
> > If we already triggered another exception, don't overwrite it with a
> > protection exception.
> > 
> > Signed-off-by: David Hildenbrand <david@redhat.com>  
> 
> 
> Can you add your description from the cover letter regarding
> "only applies to old KVM instances without the virtual memory access
> IOCTL in KVM."

Will add that.

> 
> with that
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  target/s390x/mmu_helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> > index 1deeb6e6e4..a25deef5dd 100644
> > --- a/target/s390x/mmu_helper.c
> > +++ b/target/s390x/mmu_helper.c
> > @@ -325,7 +325,7 @@ static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
> >  
> >      r = mmu_translate_region(env, vaddr, asc, asce, level, raddr, flags, rw,
> >                               exc);
> > -    if (rw == MMU_DATA_STORE && !(*flags & PAGE_WRITE)) {
> > +    if (!r && rw == MMU_DATA_STORE && !(*flags & PAGE_WRITE)) {
> >          trigger_prot_fault(env, vaddr, asc, rw, exc);
> >          return -1;
> >      }
> >   
> 
