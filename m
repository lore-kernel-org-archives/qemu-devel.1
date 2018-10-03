Received: from eggs.gnu.org ([2001:4830:134:3::10]:40903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7l3v-0001tl-34
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7l3u-0004tt-Cw
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:35:51 -0400
References: <20181003170228.95973-1-vsementsov@virtuozzo.com>
	<20181003170228.95973-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9326209c-5954-269c-f304-bb182895ce76@redhat.com>
Date: Wed, 3 Oct 2018 12:35:42 -0500
MIME-Version: 1.0
In-Reply-To: <20181003170228.95973-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] nbd/server: drop old-style negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@virtuozzo.com, rjones@redhat.com, berrange@redhat.com

On 10/3/18 12:02 PM, Vladimir Sementsov-Ogievskiy wrote:
> After the previous commit, nbd_client_new first parameter is always
> NULL. Let's drop it with all corresponding old-style negotiation code
> path which is unreachable now.

Being able to force oldstyle negotiation for interoperability testing 
may still be useful. But as fewer and fewer interesting clients exist 
that want oldstyle (after all, extensions are only usable with 
newstyle), I'm finding it hard to justify that we need qemu to be the 
oldstyle server for such interoperability testing (and I can always keep 
an older qemu binary around).

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/nbd.h |  3 +--
>   blockdev-nbd.c      |  2 +-
>   nbd/server.c        | 53 +++++++++++++--------------------------------
>   qemu-nbd.c          |  2 +-
>   4 files changed, 18 insertions(+), 42 deletions(-)
> 

> +++ b/blockdev-nbd.c
> @@ -36,7 +36,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
>                          gpointer opaque)
>   {
>       qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
> -    nbd_client_new(NULL, cioc,
> +    nbd_client_new(cioc,
>                      nbd_server->tlscreds, NULL,

Could rewrap into fewer lines, but that's cosmetic.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
