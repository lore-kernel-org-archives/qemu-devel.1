Received: from eggs.gnu.org ([2001:4830:134:3::10]:53599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIUba-0005uP-1C
	for qemu-devel@nongnu.org; Tue, 15 May 2018 03:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIUbW-0002F5-UQ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 03:42:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180515055949.6446-1-olaf@aepfle.de>
Date: Tue, 15 May 2018 09:42:36 +0200
In-Reply-To: <20180515055949.6446-1-olaf@aepfle.de> (Olaf Hering's message of
	"Tue, 15 May 2018 07:59:48 +0200")
Message-ID: <87mux1jrf7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] replace functions which are only available
 in glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Olaf Hering <olaf@aepfle.de> writes:

> Currently the minimal supported version of glib is 2.22.
> Since testing is done with a glib that claims to be 2.22, but in fact
> has APIs from newer version of glib, this bug was not caught during
> submit of the patch referenced below.
>
> Replace g_realloc_n, which is available only since 2.24, with g_renew.

We're about to bump our required GLib version to 2.34.  See
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02562.html
Message-ID: <751a3b4f-55ef-dec0-aec9-6b48922b7843@redhat.com>

However, the patch may make sense for stable anyway.

> Fixes commit 418026ca43 ("util: Introduce vfio helpers")
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>
> This must go into stable-2.12.

Please see docs/devel/stable-process.rst for how to get a patch into a
stable release.

>  util/vfio-helpers.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 006674c916..5fd4f5f212 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -522,8 +522,7 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
>  
>      assert(index >= 0);
>      s->nr_mappings++;
> -    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
> -                              s->nr_mappings);
> +    s->mappings = g_renew(IOVAMapping *, s->mappings, s->nr_mappings);

I'm afraid this switches from allocating a bunch of IOVAMapping to a
bunch of IOVAMapping *.  My gcc duly warns.

>      insert = &s->mappings[index];
>      shift = s->nr_mappings - index - 1;
>      if (shift) {
> @@ -577,8 +576,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping,
>      memmove(mapping, &s->mappings[index + 1],
>              sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
>      s->nr_mappings--;
> -    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
> -                              s->nr_mappings);
> +    s->mappings = g_renew(IOVAMapping *, s->mappings, s->nr_mappings);

Likewise.

>  }
>  
>  /* Check if the mapping list is (ascending) ordered. */
