Received: from eggs.gnu.org ([2001:4830:134:3::10]:48488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fIUEj-00079C-8g
	for qemu-devel@nongnu.org; Tue, 15 May 2018 03:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fIUEg-0004EX-4C
	for qemu-devel@nongnu.org; Tue, 15 May 2018 03:19:05 -0400
References: <20180515063128.7040-1-olaf@aepfle.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d17ae62a-03a5-61fa-934a-4cb917d14222@redhat.com>
Date: Tue, 15 May 2018 09:18:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180515063128.7040-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] replace functions which are only
 available in glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, qemu-trivial@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org

On 15.05.2018 08:31, Olaf Hering wrote:
> Currently the minimal supported version of glib is 2.22.
> Since testing is done with a glib that claims to be 2.22, but in fact
> has APIs from newer version of glib, this bug was not caught during
> submit of the patch referenced below.
> 
> Replace g_realloc_n, which is available only since 2.24, with g_renew.
> 
> Fixes commit 418026ca43 ("util: Introduce vfio helpers")
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  This must go into stable-2.12.

In that case please CC: qemu-stable@nongnu.org (done now).

Reviewed-by: Thomas Huth <thuth@redhat.com>

>  util/vfio-helpers.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 006674c916..1d9272efa4 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -522,8 +522,7 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
>  
>      assert(index >= 0);
>      s->nr_mappings++;
> -    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
> -                              s->nr_mappings);
> +    s->mappings = g_renew(IOVAMapping, s->mappings, s->nr_mappings);
>      insert = &s->mappings[index];
>      shift = s->nr_mappings - index - 1;
>      if (shift) {
> @@ -577,8 +576,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping,
>      memmove(mapping, &s->mappings[index + 1],
>              sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
>      s->nr_mappings--;
> -    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
> -                              s->nr_mappings);
> +    s->mappings = g_renew(IOVAMapping, s->mappings, s->nr_mappings);
>  }
>  
>  /* Check if the mapping list is (ascending) ordered. */
> 
