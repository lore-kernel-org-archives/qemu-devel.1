Received: from eggs.gnu.org ([2001:4830:134:3::10]:56841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elu41-0001lT-Ee
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elu3y-0004Bb-8o
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:13:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1elu3y-0004Ap-3H
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:13:18 -0500
References: <1518598187-27169-1-git-send-email-whois.zihan.yang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f4fd107-e836-ad27-0778-aa13c9f93b23@redhat.com>
Date: Wed, 14 Feb 2018 11:13:14 +0100
MIME-Version: 1.0
In-Reply-To: <1518598187-27169-1-git-send-email-whois.zihan.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] RAMList: replace QemuMutex with
 CompatGMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 14/02/2018 09:49, Zihan Yang wrote:
> change the mutex member in RAMList structure from QemuMutex to CompatGMutex.
> qemu_mutex_init() is just deleted instead of being replaced with g_mutex_init()
> because there is no need to do initialize a mutex that is statically allocated.
> 
> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>

I'm not sure what is the advantage of this change.  QEMU is more or less
uniformly using QemuMutex and QemuCond.

Paolo

> ---
>  exec.c                 | 5 ++---
>  include/exec/ramlist.h | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index e8d7b33..90cdd05 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1423,12 +1423,12 @@ void qemu_flush_coalesced_mmio_buffer(void)
>  
>  void qemu_mutex_lock_ramlist(void)
>  {
> -    qemu_mutex_lock(&ram_list.mutex);
> +    g_mutex_lock(&ram_list.mutex);
>  }
>  
>  void qemu_mutex_unlock_ramlist(void)
>  {
> -    qemu_mutex_unlock(&ram_list.mutex);
> +    g_mutex_unlock(&ram_list.mutex);
>  }
>  
>  void ram_block_dump(Monitor *mon)
> @@ -3331,7 +3331,6 @@ void cpu_register_map_client(QEMUBH *bh)
>  
>  void cpu_exec_init_all(void)
>  {
> -    qemu_mutex_init(&ram_list.mutex);
>      /* The data structures we set up here depend on knowing the page size,
>       * so no more changes can be made after this point.
>       * In an ideal world, nothing we did before we had finished the
> diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
> index 2e2ac6c..24be5e4 100644
> --- a/include/exec/ramlist.h
> +++ b/include/exec/ramlist.h
> @@ -45,7 +45,7 @@ typedef struct {
>  } DirtyMemoryBlocks;
>  
>  typedef struct RAMList {
> -    QemuMutex mutex;
> +    CompatGMutex mutex;
>      RAMBlock *mru_block;
>      /* RCU-enabled, writes protected by the ramlist lock. */
>      QLIST_HEAD(, RAMBlock) blocks;
> 
