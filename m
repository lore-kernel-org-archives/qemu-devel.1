Received: from eggs.gnu.org ([2001:4830:134:3::10]:35188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLud-00009f-Ns
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLuc-0003oU-Pi
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:03:31 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <99141855-5def-4ec8-ca4e-f4cf245c57bd@redhat.com>
Date: Tue, 19 Jun 2018 14:03:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180609151758.17343-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/6] nbd/server: refactor
 NBDExportMetaContexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use NBDExport pointer instead of just export name: there no needs to

s/no needs/is no need/

> store duplicated name in the struct, moreover, NBDExport will be used
> further.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 

> @@ -399,10 +399,9 @@ static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)
>       return nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
>   }
>   
> -static void nbd_check_meta_export_name(NBDClient *client)
> +static void nbd_check_meta_export(NBDClient *client)
>   {
> -    client->export_meta.valid &= !strcmp(client->exp->name,
> -                                         client->export_meta.export_name);
> +    client->export_meta.valid &= client->exp == client->export_meta.exp;

Changes from string comparison to pointer comparison...

> @@ -853,15 +852,15 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>   
>       memset(meta, 0, sizeof(*meta));
>   
> -    ret = nbd_opt_read_name(client, meta->export_name, NULL, errp);
> +    ret = nbd_opt_read_name(client, export_name, NULL, errp);
>       if (ret <= 0) {
>           return ret;
>       }
>   
> -    exp = nbd_export_find(meta->export_name);
> -    if (exp == NULL) {
> +    meta->exp = nbd_export_find(export_name);
> +    if (meta->exp == NULL) {

...by remembering the results of the string comparison performed under 
the hood.  Looks good.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
