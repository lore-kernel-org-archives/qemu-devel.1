Received: from eggs.gnu.org ([2001:4830:134:3::10]:34762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fuws0-0004zU-He
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fuwrv-00082I-JW
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:34:36 -0400
References: <153553435604.51992.5640085189104207249.stgit@lep8c.aus.stglabs.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bcff9977-cfe4-761f-7e97-4e411fcf6864@vivier.eu>
Date: Wed, 29 Aug 2018 11:33:50 +0200
MIME-Version: 1.0
In-Reply-To: <153553435604.51992.5640085189104207249.stgit@lep8c.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: elf: mmap all the
 target-pages of hostpage for data segment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, riku.voipio@iki.fi
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Le 29/08/2018 à 11:23, Shivaprasad G Bhat a écrit :
> If the hostpage size is greater than the TARGET_PAGESIZE, the
> target-pages of size TARGET_PAGESIZE are marked valid only till the
> length requested during the elfload. The glibc attempts to consume unused
> space in the last page of data segment(__libc_memalign() in
> elf/dl-minimal.c). If PT_LOAD p_align is greater than or
> equal to hostpage size, the GLRO(dl_pagesize) is actually the host pagesize
> as set in the auxillary vectors. So, there is no explicit mmap request for
> the remaining target-pages on the last hostpage. The glibc assumes that
> particular space as available and subsequent attempts to use
> those addresses lead to crash as the target_mmap has not marked them valid
> for those target-pages.
> 
> The issue is seen when trying to chroot to 16.04-x86_64 ubuntu on a PPC64
> host where the fork fails to access the thread_id as it is allocated on a
> page not marked valid. The recent glibc doesn't have checks for thread-id in
> fork, but the issue can manifest somewhere else, none the less.
> 
> The fix here is to map all the target-pages of the hostpage during the
> elfload if the p_align is greater than or equal to hostpage size, for
> data segment to allow the glibc for proper consumption.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
> ---
> v2: https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg05943.html
> Changes from v2:
>     - Simplified the macro as suggested.
>     - Fixed some grammatical error in commit message.
> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg05730.html
> Changes from v1:
>    - Made the conditionals consistent with the commit "33143c446e" and
>      changed the commit message accordingly.
> 
>  linux-user/elfload.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
