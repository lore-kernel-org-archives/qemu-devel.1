Received: from eggs.gnu.org ([2001:4830:134:3::10]:52195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7h7m-0000BD-5C
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7h7l-0006ij-B2
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:46:46 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508073529.23449-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <962a9aa7-6442-1aff-3ab2-400cf3cb8421@amsat.org>
Date: Mon, 8 May 2017 08:46:34 -0300
MIME-Version: 1.0
In-Reply-To: <20170508073529.23449-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] xtensa: use g_malloc/g_new/g_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>

On 05/08/2017 04:35 AM, Paolo Bonzini wrote:
> Replace malloc/free with g_malloc/g_free to get a program exit on
> out of memory.
>
> Replace g_malloc with g_new when allocating the MemoryRegion to
> get more type safety.
>
> Reported by Coverity.
>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/xtensa/sim.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> index d2d1d3a6fd..97307728f7 100644
> --- a/hw/xtensa/sim.c
> +++ b/hw/xtensa/sim.c
> @@ -41,13 +41,13 @@ static void xtensa_create_memory_regions(const XtensaMemory *memory,
>                                           const char *name)
>  {
>      unsigned i;
> -    char *num_name = malloc(strlen(name) + sizeof(i) * 3 + 1);
> +    char *num_name = g_malloc(strlen(name) + sizeof(i) * 3 + 1);
>
>      for (i = 0; i < memory->num; ++i) {
>          MemoryRegion *m;
>
>          sprintf(num_name, "%s%u", name, i);
> -        m = g_malloc(sizeof(*m));
> +        m = g_new(MemoryRegion, 1);
>          memory_region_init_ram(m, NULL, num_name,
>                                 memory->location[i].size,
>                                 &error_fatal);
> @@ -55,7 +55,7 @@ static void xtensa_create_memory_regions(const XtensaMemory *memory,
>          memory_region_add_subregion(get_system_memory(),
>                                      memory->location[i].addr, m);
>      }
> -    free(num_name);
> +    g_free(num_name);
>  }
>
>  static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
>
