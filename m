Received: from eggs.gnu.org ([2001:4830:134:3::10]:36485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dtxWc-000175-0v
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dtxWY-00015X-Qx
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dtxWY-00015A-KY
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:59:50 -0400
References: <20170918101709.30421-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7702271-0af0-d33d-5ebe-364ce75a68df@redhat.com>
Date: Mon, 18 Sep 2017 16:59:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170918101709.30421-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3 00/13] memory: Reduce memory use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 18/09/2017 12:16, Alexey Kardashevskiy wrote:
> This was inspired by https://bugzilla.redhat.com/show_bug.cgi?id=1481593
> Previous versions:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01559.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04069.html
> 
> This patchset tries to reduce amount of memory used by FlatViews
> and tries share as many FVs between address spaces as possible.
> 
> Changelog:
> v3:
> * addressed comments from v2, mainly simplified the code

Looks almost ready.  I had a couple comments on patch 11.  However, if
they are wrong, I can just queue patches 2-13 immediately.  Your work on
other optimizations can then continue on top.

Thanks!

Paolo

> v2:
> * total rework
> 
> 
> 
> 
> This is based on sha1
> 4f2058ded4 Peter Maydell "Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170917' into staging".
> 
> Please comment. Thanks.
> 
> 
> 
> Alexey Kardashevskiy (13):
>   memory: Postpone flatview and dispatch tree building till all devices
>     are added
>   exec: Explicitely export target AS from
>     address_space_translate_internal
>   memory: Open code FlatView rendering
>   memory: Move FlatView allocation to a helper
>   memory: Move AddressSpaceDispatch from AddressSpace to FlatView
>   memory: Remove AddressSpace pointer from AddressSpaceDispatch
>   memory: Switch memory from using AddressSpace to FlatView
>   memory: Cleanup after switching to FlatView
>   memory: Rename mem_begin/mem_commit/mem_add helpers
>   memory: Store physical root MR in FlatView
>   memory: Share FlatView's and dispatch trees between address spaces
>   memory: Get rid of address_space_init_shareable
>   memory: Add flat views to HMP "info mtree"
> 
>  include/exec/memory-internal.h |  16 +-
>  include/exec/memory.h          |  76 +++++-----
>  include/hw/arm/armv7m.h        |   2 +-
>  cpus.c                         |   5 +-
>  exec.c                         | 330 +++++++++++++++++++++++++----------------
>  hw/arm/armv7m.c                |   9 +-
>  hw/intc/openpic_kvm.c          |   2 +-
>  memory.c                       | 271 +++++++++++++++++++++++----------
>  monitor.c                      |   3 +-
>  target/arm/cpu.c               |  16 +-
>  target/i386/cpu.c              |   5 +-
>  vl.c                           |   9 ++
>  hmp-commands-info.hx           |   7 +-
>  13 files changed, 478 insertions(+), 273 deletions(-)
> 
