Received: from eggs.gnu.org ([2001:4830:134:3::10]:39088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duyKb-00016b-Mg
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duyKY-0002Ks-El
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duyKY-0002Bj-67
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:03:38 -0400
References: <20170921085110.25598-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5e836306-27bd-a0fd-5bdd-8c8a510bf8eb@redhat.com>
Date: Thu, 21 Sep 2017 12:03:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170921085110.25598-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v5 00/18] memory: Store physical root
 MR in FlatView
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 21/09/2017 10:50, Alexey Kardashevskiy wrote:
> This was inspired by https://bugzilla.redhat.com/show_bug.cgi?id=1481593
> Previous versions:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01559.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04069.html
> v3: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04523.html
> v4: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg05669.html
> 
> This patchset tries to reduce amount of memory used by FlatViews
> and tries share as many FVs between address spaces as possible.

Thanks, this looks good!  (Patch 18 indeed is not what I had in mind :)).

Paolo


> Changelog:
> v5:
> * removed "memory: Give memory_region_transaction_commit a hint" (broken)
> * added "memory: Avoid temporary FlatView allocation in a single child case"
> but I suggest ditching it, it is just there to demonsrate how I checked
> the suggested idea
> * updated example of "info mtree -f -d" in 14/18 to demonstrate the result
> 
> v4:
> * total rework again to provide grounds for new 15/18, 17/18, 18/18
> 
> v3:
> * addressed comments from v2, mainly simplified the code
> 
> v2:
> * total rework
> 
> 
> This is based on sha1
> c51700273a Peter Maydell "Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170919-v2' into staging".
> 
> Please comment. Thanks.
> 
> 
> 
> Alexey Kardashevskiy (18):
>   exec: Explicitly export target AS from
>     address_space_translate_internal
>   memory: Open code FlatView rendering
>   memory: Move FlatView allocation to a helper
>   memory: Move AddressSpaceDispatch from AddressSpace to FlatView
>   memory: Remove AddressSpace pointer from AddressSpaceDispatch
>   memory: Switch memory from using AddressSpace to FlatView
>   memory: Cleanup after switching to FlatView
>   memory: Rename mem_begin/mem_commit/mem_add helpers
>   memory: Store physical root MR in FlatView
>   memory: Alloc dispatch tree where topology is generared
>   memory: Move address_space_update_ioeventfds
>   memory: Share FlatView's and dispatch trees between address spaces
>   memory: Do not allocate FlatView in address_space_init
>   memory: Rework "info mtree" to print flat views and dispatch trees
>   memory: Share special empty FlatView
>   memory: Get rid of address_space_init_shareable
>   memory: Create FlatView directly
>   memory: Avoid temporary FlatView allocation in a single child case
> 
>  include/exec/memory-internal.h |  16 +-
>  include/exec/memory.h          |  76 +++++-----
>  include/hw/arm/armv7m.h        |   2 +-
>  cpus.c                         |   5 +-
>  exec.c                         | 330 ++++++++++++++++++++++++----------------
>  hw/arm/armv7m.c                |   9 +-
>  hw/intc/openpic_kvm.c          |   2 +-
>  memory.c                       | 335 +++++++++++++++++++++++++++++++----------
>  monitor.c                      |   3 +-
>  target/arm/cpu.c               |  16 +-
>  target/i386/cpu.c              |   5 +-
>  hmp-commands-info.hx           |   7 +-
>  12 files changed, 533 insertions(+), 273 deletions(-)
> 
