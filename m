Received: from eggs.gnu.org ([2001:4830:134:3::10]:42006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKNgv-0003bP-QV
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKNgq-0000RI-SK
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:11:45 -0500
Date: Thu, 30 Nov 2017 13:11:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171130131133.7caedb9f.cohuck@redhat.com>
In-Reply-To: <d4a11905-f8a0-0c35-badb-64c613d89980@redhat.com>
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-9-david@redhat.com>
	<1690618c-ac06-8aa8-75ba-58fe95ab0d78@redhat.com>
	<d4a11905-f8a0-0c35-badb-64c613d89980@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 08/16] s390x/tcg: don't exit
 the cpu loop in s390_cpu_virt_mem_rw()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Thu, 30 Nov 2017 12:57:00 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 30.11.2017 12:39, Thomas Huth wrote:
> > On 29.11.2017 21:26, David Hildenbrand wrote:  
> >> s390_cpu_virt_mem_rw() must always return, so callers can react on
> >> an exception (e.g. see ioinst_handle_stcrw()).
> >>
> >> Therefore, using program_interrupt() is wrong. Fix that up.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  target/s390x/mmu_helper.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> >> index dbe2f511f8..2c7f3d7d95 100644
> >> --- a/target/s390x/mmu_helper.c
> >> +++ b/target/s390x/mmu_helper.c
> >> @@ -459,7 +459,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
> >>          }
> >>          if (!address_space_access_valid(&address_space_memory, pages[i],
> >>                                          TARGET_PAGE_SIZE, is_write)) {
> >> -            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
> >> +            trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
> >>              return -EFAULT;
> >>          }
> >>          addr += TARGET_PAGE_SIZE;  
> > 
> > Is that still right when running with KVM? I think the exception will
> > then silently be ignored instead?  
> 
> Good point (for older KVM). And ugly.
> 
> if (kvm_enabled()) {
> 	kvm_s390_program_interrupt...
> } else {
> 	trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
> }

Maybe add a comment that this is only for old kernels that do not
support the mem op interface?
