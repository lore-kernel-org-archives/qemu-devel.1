Received: from eggs.gnu.org ([2001:4830:134:3::10]:41989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyfAd-0002lF-Bc
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyfAc-0000AU-9l
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:56:55 -0400
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af833096-cbc3-24db-0cf0-a446f231c5fd@redhat.com>
Date: Wed, 21 Mar 2018 09:56:36 -0500
MIME-Version: 1.0
In-Reply-To: <20180321121940.39426-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] nbd/server: refactor
 nbd_negotiate_meta_query for several namespaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, nbd list <nbd@other.debian.org>

[adding NBD list]

On 03/21/2018 07:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 60 +++++++++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 43 insertions(+), 17 deletions(-)

> +struct {
> +    const char *ns;
> +    int (*func)(NBDClient *, NBDExportMetaContexts *, uint32_t, Error **);
> +} meta_namespace_handlers[] = {
> +    /* namespaces should go in non-decreasing order by name length */
> +    {.ns = "base:", .func = nbd_meta_base_query},
> +};
> +

> @@ -787,9 +793,12 @@ static int nbd_negotiate_meta_query(NBDClient *client,
>                                       NBDExportMetaContexts *meta, Error **errp)
>   {
>       int ret;
> -    char query[sizeof("base:") - 1];
> -    size_t baselen = strlen("base:");
> +    int i;
>       uint32_t len;
> +    int bytes_done = 0;
> +    char *query;
> +    int nb_ns = sizeof(meta_namespace_handlers) /
> +                sizeof(meta_namespace_handlers[0]);

Use the ARRAY_SIZE() macro here.

> +    query = g_malloc(strlen(meta_namespace_handlers[nb_ns - 1].ns));

So this sizes a buffer according to the largest namespace we expect to 
handle,...

>   
> -    len -= baselen;
> -    ret = nbd_opt_read(client, query, baselen, errp);
> -    if (ret <= 0) {
> -        return ret;
> -    }
> -    if (strncmp(query, "base:", baselen) != 0) {
> -        return nbd_opt_skip(client, len, errp);
> +    for (i = 0; i < nb_ns; i++) {
> +        const char *ns = meta_namespace_handlers[i].ns;
> +        int ns_len = strlen(ns);
> +        int diff_len = strlen(ns) - bytes_done;
> +
> +        assert(diff_len >= 0);
> +
> +        if (diff_len > 0) {
> +            if (len < diff_len) {
> +                ret = nbd_opt_skip(client, len, errp);
> +                goto out;
> +            }
> +
> +            len -= diff_len;
> +            ret = nbd_opt_read(client, query + bytes_done, diff_len, errp);
> +            if (ret <= 0) {
> +                goto out;
> +            }
> +        }
> +
> +        if (!strncmp(query, ns, ns_len)) {
> +            ret = meta_namespace_handlers[i].func(client, meta, len, errp);
> +            goto out;
> +        }


...then you do multiple iterative reads as you step through the list. 
You know, if you encounter a ':' at any point in the iterative reads, 
you don't have to continue through the rest of the handlers (the query 
belongs to a short-named namespace we didn't recognize).

Is it any smarter to just blindly do a single read of MIN(querylen, 
maxlen), then strchr() for ':' (if not found, it's not a namespace we 
recognize), and then look up if the name matches, at which point we then 
read the rest of the query and refactor the namespace handler to be 
passed the already-parsed leafname, rather than having to parse the 
leafname off the wire in the handler?

I'm STILL wondering if the NBD spec should specify namespace and 
leafname as separate fields rather than requiring the server to parse 
for ':'.  We have only a couple of weeks before the qemu 2.12 release 
cements in place an implementation of the BLOCK_STATUS extension.  And 
we've already discussed that if we make a change, we have to consider 
using a different constant for NBD_OPT_SET_META_CONTEXT to play nicely 
with the existing Virtuozzo implementation that currently matches what 
is slated to land in qemu 2.12 if no further qemu patches are submitted. 
  Is it worth me proposing a doc change to demonstrate what the 
difference would look like, along with corresponding qemu changes to 
match, to decide if including it in 2.12 is worth it?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
