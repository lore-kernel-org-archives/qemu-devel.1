Received: from eggs.gnu.org ([2001:4830:134:3::10]:57990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dSxJO-0005pc-Df
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 23:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dSxJL-0002y3-62
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 23:18:38 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dSxJL-0002xp-1U
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 23:18:35 -0400
Received: by mail-qt0-x244.google.com with SMTP id c20so1011341qte.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 20:18:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<1499187763-8211-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f4a09c28-8907-0181-741c-ca33aa3bb3f2@amsat.org>
Date: Thu, 6 Jul 2017 00:18:28 -0300
MIME-Version: 1.0
In-Reply-To: <1499187763-8211-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] include/hw/boards.h: Document
 memory_region_allocate_system_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, patches@linaro.org

Hi Peter, Paolo,

On 07/04/2017 02:02 PM, Peter Maydell wrote:
> Add a documentation comment for memory_region_allocate_system_memory().
> 
> In particular, the reason for this function's existence and the
> requirement on board code to call it exactly once are non-obvious.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/boards.h | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 76ce021..1bc5389 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -9,6 +9,34 @@
>   #include "qom/object.h"
>   #include "qom/cpu.h"
>   
> +/**
> + * memory_region_allocate_system_memory - Allocate a board's main memory
> + * @mr: the #MemoryRegion to be initialized
> + * @owner: the object that tracks the region's reference count
> + * @name: name of the memory region
> + * @ram_size: size of the region in bytes
> + *
> + * This function allocates the main memory for a board model, and
> + * initializes @mr appropriately. It also arranges for the memory
> + * to be migrated (by calling vmstate_register_ram_global()).
> + *
> + * Memory allocated via this function will be backed with the memory
> + * backend the user provided using -mem-path if appropriate; this
> + * is typically used to cause host huge pages to be used.
> + * This function should therefore be called by a board exactly once,

Using memory-backend-file objects one can use different mem-path.

Maybe removing the global mem_path used by vl.c for "main memory" (which 
is a memory-backend-file without naming it) this "exactly once" case can 
be avoided.

> + * for the primary or largest RAM area it implements.
> + *
> + * For boards where the major RAM is split into two parts in the memory
> + * map, you can deal with this by calling memory_region_allocate_system_memory()
> + * once to get a MemoryRegion with enough RAM for both parts, and then
> + * creating alias MemoryRegions via memory_region_init_alias() which
> + * alias into different parts of the RAM MemoryRegion and can be mapped
> + * into the memory map in the appropriate places.
> + *
> + * Smaller pieces of memory (display RAM, static RAMs, etc) don't need
> + * to be backed via the -mem-path memory backend and can simply
> + * be created via memory_region_init_ram().
> + */
>   void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
>                                             const char *name,
>                                             uint64_t ram_size);
> 
