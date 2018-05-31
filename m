Received: from eggs.gnu.org ([2001:4830:134:3::10]:55670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fOEWW-0006Mh-NW
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fOEWR-0001kv-SC
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:45:12 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:43811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fOEWR-0001kh-Es
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:45:07 -0400
Received: by mail-pg0-x243.google.com with SMTP id p8-v6so9063448pgq.10
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 20:45:07 -0700 (PDT)
References: <20180530162349.31100-1-pbonzini@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b1cca715-e58f-0013-20fb-9470ce3b6137@ozlabs.ru>
Date: Thu, 31 May 2018 13:45:02 +1000
MIME-Version: 1.0
In-Reply-To: <20180530162349.31100-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 31/5/18 2:23 am, Paolo Bonzini wrote:
> Mostly a rewrite, in order to keep the loop simple.
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

Well, this is correct indeed for the normal case when the result is used
for internal business but for my task (show the owner of an MR or at least
give a clue what to grep for) it will discard a partial path.

I guess I could print a typename if object_get_canonical_path() returns
NULL, I'll repost v4.


>              g_free(path);
> -            path = newpath;
> -        } else {
> -            path = component;
> +            return NULL;
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
> +    } while ((obj = obj->parent) != root);
>  
> -    return newpath;
> +    return path;
>  }
>  
>  Object *object_resolve_path_component(Object *parent, const gchar *part)
> 


-- 
Alexey
