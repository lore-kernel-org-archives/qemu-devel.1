Received: from eggs.gnu.org ([2001:4830:134:3::10]:41757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO7B-0003sJ-7z
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO7A-00017S-Fm
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:55:41 -0500
References: <20180307215010.30706-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <22d1a396-c59c-b546-6d0b-52302a7b69db@vivier.eu>
Date: Fri, 9 Mar 2018 20:55:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180307215010.30706-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 05/11] linux-user: fix
 mmap/munmap/mprotect/mremap/shmat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-stable@nongnu.org

Le 07/03/2018 à 22:50, Max Filippov a écrit :
> In linux-user QEMU that runs for a target with TARGET_ABI_BITS bigger
> than L1_MAP_ADDR_SPACE_BITS an assertion in page_set_flags fires when
> mmap, munmap, mprotect, mremap or shmat is called for an address outside
> the guest address space. mmap and mprotect should return ENOMEM in such
> case.
> 
> Change definition of GUEST_ADDR_MAX to always be the last valid guest
> address. Account for this change in open_self_maps.
> Add macro guest_addr_valid that verifies if the guest address is valid.
> Add function guest_range_valid that verifies if address range is within
> guest address space and does not wrap around. Use that macro in
> mmap/munmap/mprotect/mremap/shmat for error checking.
> 
> Cc: qemu-stable@nongnu.org
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v5->v6:
> - drop 'if (len)' clause from guest_range_valid and explicitly compare
>   len with GUEST_ADDR_MAX.
> 
> Changes v4->v5:
> - change definition of GUEST_ADDR_MAX to always be the last valid guest
>   address. Account for this change in guest_addr_valid and open_self_maps.
> - turn guest_range_valid into a function.
> 
> Changes v3->v4:
> - change GUEST_ADDR_MAX and h2g_valid definitions as suggested by Laurent
>   Vivier.
> 
> Changes v2->v3:
> - fix comparison in guest_valid: it must be 'less' to preserve the existing
>   functionality, not 'less or equal'.
> - fix guest_range_valid: it may not use guest_valid, because single range
>   that occupies all of the guest address space is valid.
> 
>  include/exec/cpu-all.h  |  6 +++++-
>  include/exec/cpu_ldst.h | 16 +++++++---------
>  linux-user/mmap.c       | 20 +++++++++++++++-----
>  linux-user/syscall.c    |  5 ++++-
>  4 files changed, 31 insertions(+), 16 deletions(-)
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
