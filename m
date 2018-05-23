Received: from eggs.gnu.org ([2001:4830:134:3::10]:40025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLYxX-0003L6-4N
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLYxW-0005rZ-DA
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:58:03 -0400
References: <20180523102419.28665-1-vsementsov@virtuozzo.com>
	<20180523102419.28665-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2bfd177c-3112-77a0-b214-52feca6580dd@redhat.com>
Date: Wed, 23 May 2018 13:57:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180523102419.28665-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] nbd/server: fix trace
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

On 05/23/2018 05:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Return code = 1 doesn't mean that we parsed base:allocation. Move
> trace point to appropriate place.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 

> @@ -768,10 +771,10 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
>       }
>   
>       if (strncmp(query, "allocation", alen) == 0) {
> +        trace_nbd_negotiate_meta_query_parse("base:allocation");
>           meta->base_allocation = true;
>       }

It's probably worth tracing even when we successfully skip the request, 
as in:

if (strncmp...) {
     trace_nbd_negotiate_meta_query_parse("base:allocation");
     meta->base_allocation = true;
} else {
     trace_nbd_negotiate_meta_query_skip("unrecognized request %s", query);
}

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
