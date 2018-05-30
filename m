Received: from eggs.gnu.org ([2001:4830:134:3::10]:57674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO57U-0006jZ-UW
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO57R-0001Ph-On
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:42:45 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO57R-0001PP-JF
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:42:41 -0400
Received: by mail-qk0-x243.google.com with SMTP id h7-v6so7892770qkm.0
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 10:42:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530162349.31100-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <213a7a34-4982-f076-f0a9-716cd8babea3@amsat.org>
Date: Wed, 30 May 2018 14:42:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180530162349.31100-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qom: support orphan objects in
 object_get_canonical_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: aik@ozlabs.ru

On 05/30/2018 01:23 PM, Paolo Bonzini wrote:
> Mostly a rewrite, in order to keep the loop simple.

Thus easier to review using "git difftool -y -x sdiff" (or whichever
tool you prefer, such meld).  "git format-patch" doesn't provide a way
to generate side-by-side diffs applicable.

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qom/object.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 0fc972030e..4f30431ae3 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1669,25 +1669,28 @@ gchar *object_get_canonical_path(Object *obj)
>      Object *root = object_get_root();
>      char *newpath, *path = NULL;
>  
> -    while (obj != root) {
> +    if (obj == root) {
> +        return g_strdup("/");
> +    }
> +
> +    do {
>          char *component = object_get_canonical_path_component(obj);
>  
> -        if (path) {
> -            newpath = g_strdup_printf("%s/%s", component, path);
> -            g_free(component);
> +        if (!component) {
> +            /* A canonical path must be complete, so discard what was
> +             * collected so far.
> +             */
>              g_free(path);
> -            path = newpath;
> -        } else {
> -            path = component;
> +            return NULL;

This function now matches his documentation!

>          }
>  
> -        obj = obj->parent;
> -    }
> -
> -    newpath = g_strdup_printf("/%s", path ? path : "");
> -    g_free(path);
> +        newpath = g_strdup_printf("/%s%s", component, path ? path : "");
> +        g_free(path);
> +        g_free(component);
> +        path = newpath;

Easier to read in 2 lines:

           obj = obj->parent;
       } while (obj != root);

> +    } while ((obj = obj->parent) != root);
>  
> -    return newpath;
> +    return path;
>  }
>  
>  Object *object_resolve_path_component(Object *parent, const gchar *part)
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
