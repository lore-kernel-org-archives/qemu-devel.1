Received: from eggs.gnu.org ([2001:4830:134:3::10]:50883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evZit-0001dD-OF
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 22:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evZis-0007Dk-KC
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 22:31:31 -0400
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
	<20180312152126.286890-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3000907b-888d-2164-df16-1ac54acafba5@redhat.com>
Date: Mon, 12 Mar 2018 21:31:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180312152126.286890-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/8] nbd/server: add nbd_read_opt_name
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
> Add helper to read name in format:
> 
>    uint32 len       (<= NBD_MAX_NAME_SIZE)
>    len bytes string (not 0-terminated)
> 
> The helper would be reused in following patch.

s/would/will/

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> v2: splitted and changed a lot helper from larger patch of v1

'split' (one of those weird English words whose past and present tense 
are spelled the same way; there is no 'splitted')

> 
>   nbd/server.c | 55 ++++++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index d163964cf9..085e14afbf 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -273,6 +273,47 @@ static int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
>       return qio_channel_read_all(client->ioc, buffer, size, errp) < 0 ? -EIO : 1;
>   }
>   
> +/* nbd_opt_read_name
> + *
> + * Read string in format:

Read a string in the format:

> + *   uint32_t len     (<= NBD_MAX_NAME_SIZE)
> + *   len bytes string (not 0-terminated)
> + *
> + * @name should be enough to store NBD_MAX_NAME_SIZE+1.
> + * if @length is non-zero, it would be set to read string length.

s/if/If/
s/would/will/
s/read/the actual/

> + *
> + * Return -errno on I/O error, 0 if option was completely handled by
> + * sending a reply about inconsistent lengths, or 1 on success. */
> +static int nbd_opt_read_name(NBDClient *client, char *name, uint32_t *length,
> +                             Error **errp)
> +{

Function looks good.

> @@ -455,19 +496,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
>           2 bytes: N, number of requests (can be 0)
>           N * 2 bytes: N requests
>       */
> -    rc = nbd_opt_read(client, &namelen, sizeof(namelen), errp);
> -    if (rc <= 0) {
> -        return rc;
> -    }
> -    be32_to_cpus(&namelen);
> -    if (namelen >= sizeof(name)) {
> -        return nbd_opt_invalid(client, errp, "name too long for qemu");
> -    }
> -    rc = nbd_opt_read(client, name, namelen, errp);
> -    if (rc <= 0) {
> -        return rc;
> -    }
> -    name[namelen] = '\0';
> +    rc = nbd_opt_read_name(client, name, &namelen, errp);
>       trace_nbd_negotiate_handle_export_name_request(name);
>   
>       rc = nbd_opt_read(client, &requests, sizeof(requests), errp);

Oh, so close. You overwrote rc instead of checking for errors.  I'm 
squashing in the obvious fix, plus the grammar changes, then adding:
Reviewed-by: Eric Blake <eblake@redhat.com>

diff --git i/nbd/server.c w/nbd/server.c
index 850c6cd2dad..e28526600c4 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -497,6 +497,9 @@ static int nbd_negotiate_handle_info(NBDClient 
*client, uint16_t myflags,
          N * 2 bytes: N requests
      */
      rc = nbd_opt_read_name(client, name, &namelen, errp);
+    if (rc <= 0) {
+        return rc;
+    }
      trace_nbd_negotiate_handle_export_name_request(name);

      rc = nbd_opt_read(client, &requests, sizeof(requests), errp);


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
