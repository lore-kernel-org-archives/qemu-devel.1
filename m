Received: from eggs.gnu.org ([2001:4830:134:3::10]:42671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d804V-0005Jm-Ge
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d804R-0004y1-Lk
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:00:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1494266456-2251-1-git-send-email-jcmvbkbc@gmail.com>
Date: Tue, 09 May 2017 10:00:32 +0200
In-Reply-To: <1494266456-2251-1-git-send-email-jcmvbkbc@gmail.com> (Max
	Filippov's message of "Mon, 8 May 2017 11:00:56 -0700")
Message-ID: <87lgq61mu7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/xtensa: sim: use g_string/g_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Max Filippov <jcmvbkbc@gmail.com> writes:

> Replace malloc/free/sprintf with g_string/g_string_printf/g_string_free.
> Replace g_malloc with g_new when allocating the MemoryRegion to get more
> type safety.
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  hw/xtensa/sim.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> index d2d1d3a..b27e28d 100644
> --- a/hw/xtensa/sim.c
> +++ b/hw/xtensa/sim.c
> @@ -41,21 +41,21 @@ static void xtensa_create_memory_regions(const Xtensa=
Memory *memory,
>                                           const char *name)
>  {
>      unsigned i;
> -    char *num_name =3D malloc(strlen(name) + sizeof(i) * 3 + 1);
> +    GString *num_name =3D g_string_new(NULL);
>=20=20
>      for (i =3D 0; i < memory->num; ++i) {
>          MemoryRegion *m;
>=20=20
> -        sprintf(num_name, "%s%u", name, i);
> -        m =3D g_malloc(sizeof(*m));
> -        memory_region_init_ram(m, NULL, num_name,
> +        g_string_printf(num_name, "%s%u", name, i);

I'd make that

           num_name =3D g_strdup_printf("%s%u, name, i);

for less churn.  Have to free(num_name) in the loop, of course.

> +        m =3D g_new(MemoryRegion, 1);
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
>=20=20
>  static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
