Received: from eggs.gnu.org ([2001:4830:134:3::10]:45942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7nqe-0006Dv-Kf
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7nqd-00050Z-U4
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:57:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1494266456-2251-1-git-send-email-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e73e252e-61fc-6b2c-6e3f-f5a2e1f934cc@amsat.org>
Date: Mon, 8 May 2017 15:57:23 -0300
MIME-Version: 1.0
In-Reply-To: <1494266456-2251-1-git-send-email-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/xtensa: sim: use g_string/g_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/08/2017 03:00 PM, Max Filippov wrote:
> Replace malloc/free/sprintf with g_string/g_string_printf/g_string_free.
> Replace g_malloc with g_new when allocating the MemoryRegion to get more
> type safety.
>
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/xtensa/sim.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> index d2d1d3a..b27e28d 100644
> --- a/hw/xtensa/sim.c
> +++ b/hw/xtensa/sim.c
> @@ -41,21 +41,21 @@ static void xtensa_create_memory_regions(const XtensaMemory *memory,
>                                           const char *name)
>  {
>      unsigned i;
> -    char *num_name = malloc(strlen(name) + sizeof(i) * 3 + 1);
> +    GString *num_name = g_string_new(NULL);
>
>      for (i = 0; i < memory->num; ++i) {
>          MemoryRegion *m;
>
> -        sprintf(num_name, "%s%u", name, i);
> -        m = g_malloc(sizeof(*m));
> -        memory_region_init_ram(m, NULL, num_name,
> +        g_string_printf(num_name, "%s%u", name, i);
> +        m = g_new(MemoryRegion, 1);
> +        memory_region_init_ram(m, NULL, num_name->str,
>                                 memory->location[i].size,
>                                 &error_fatal);
>          vmstate_register_ram_global(m);
>          memory_region_add_subregion(get_system_memory(),
>                                      memory->location[i].addr, m);
>      }
> -    free(num_name);
> +    g_string_free(num_name, true);
>  }
>
>  static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
>
