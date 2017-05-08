Received: from eggs.gnu.org ([2001:4830:134:3::10]:48130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7ilU-0003S9-Kc
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7ilP-0006zr-V3
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:31:52 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:32820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7ilP-0006zh-NY
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:31:47 -0400
Received: by mail-wr0-x229.google.com with SMTP id w50so43762663wrc.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 06:31:47 -0700 (PDT)
References: <20170508073529.23449-1-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508073529.23449-1-pbonzini@redhat.com>
Date: Mon, 08 May 2017 14:32:30 +0100
Message-ID: <87r2zz8oep.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

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

It seems a little sketchy using the size of the storage type as a proxy
for the number of bytes used by the format specifier in a format string.
In this sort of situation I'd just use Glib and stop worrying about it:

  GString num_name = g_string_new(NULL);
  ...

      g_string_printf(num_name, "%s%u", name, i);
      m = g_new(MemoryRegion, 1);
      memory_region_init_ram(m, NULL, num_name->str,
                             memory->location[i].size,
                             &error_fatal);

      ...

  g_string_free(name, TRUE);

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


--
Alex Bennée
