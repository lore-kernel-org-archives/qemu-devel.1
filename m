Received: from eggs.gnu.org ([2001:4830:134:3::10]:48904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evZY2-0006Xe-8N
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 22:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evZY1-0007nu-5z
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 22:20:18 -0400
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
	<20180312152126.286890-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7ef746aa-7650-0406-a814-43d0b055caa3@redhat.com>
Date: Mon, 12 Mar 2018 21:20:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180312152126.286890-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/8] nbd/server: add nbd_opt_invalid
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 03/12/2018 10:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> NBD_REP_ERR_INVALID is often parameter to nbd_opt_drop and it would
> be used more in following patches. So, let's add a helper.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v2: add Eric's r-b
> 
>   nbd/server.c | 50 ++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 36 insertions(+), 14 deletions(-)

I mentioned on v1 that the code is technically correct (and hence you 
are correct that I gave R-b which still stands), but it's still a lot of 
net lines added, for what really amounts to:

> +static int GCC_FMT_ATTR(4, 5)
> +nbd_opt_drop(NBDClient *client, uint32_t type, Error **errp,
> +             const char *fmt, ...)
> +{
> +    int ret;
> +    va_list va;
> +
> +    va_start(va, fmt);
> +    ret = nbd_opt_vdrop(client, type, errp, fmt, va);
> +    va_end(va);
> +
> +    return ret;
> +}
> +
> +static int GCC_FMT_ATTR(3, 4)
> +nbd_opt_invalid(NBDClient *client, Error **errp, const char *fmt, ...)
> +{
> +    int ret;
> +    va_list va;
> +
> +    va_start(va, fmt);
> +    ret = nbd_opt_vdrop(client, NBD_REP_ERR_INVALID, errp, fmt, va);
> +    va_end(va);
> +
> +    return ret;
> +}

two nearly identical functions, that differ by one providing an implicit 
argument...

> @@ -241,9 +265,9 @@ static int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
>                           Error **errp)
>   {
>       if (size > client->optlen) {
> -        return nbd_opt_drop(client, NBD_REP_ERR_INVALID, errp,
> -                            "Inconsistent lengths in option %s",
> -                            nbd_opt_lookup(client->opt));
> +        return nbd_opt_invalid(client, errp,
> +                               "Inconsistent lengths in option %s",
> +                               nbd_opt_lookup(client->opt));

...all so this and four other callers (two in this patch, two more added 
in patch 3) can skip typing NBD_REP_ERR_INVALID.  But at this point, 
it's easier to keep the patch as part of the series.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
