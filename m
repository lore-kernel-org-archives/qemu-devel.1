Received: from eggs.gnu.org ([2001:4830:134:3::10]:60583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNBw-000357-EQ
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNBr-0005SU-HD
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:39:44 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-9-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1690618c-ac06-8aa8-75ba-58fe95ab0d78@redhat.com>
Date: Thu, 30 Nov 2017 12:39:32 +0100
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 29.11.2017 21:26, David Hildenbrand wrote:
> s390_cpu_virt_mem_rw() must always return, so callers can react on
> an exception (e.g. see ioinst_handle_stcrw()).
> 
> Therefore, using program_interrupt() is wrong. Fix that up.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mmu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index dbe2f511f8..2c7f3d7d95 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -459,7 +459,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
>          }
>          if (!address_space_access_valid(&address_space_memory, pages[i],
>                                          TARGET_PAGE_SIZE, is_write)) {
> -            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
> +            trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
>              return -EFAULT;
>          }
>          addr += TARGET_PAGE_SIZE;

Is that still right when running with KVM? I think the exception will
then silently be ignored instead?

 Thomas
