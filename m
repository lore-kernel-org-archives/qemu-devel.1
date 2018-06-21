Received: from eggs.gnu.org ([2001:4830:134:3::10]:36185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW0mR-0002KU-AM
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW0mO-0005tz-2i
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:41:47 -0400
References: <20180413143156.11409-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c7cb351c-4215-3937-37fa-ad704dcf95c8@redhat.com>
Date: Thu, 21 Jun 2018 09:41:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180413143156.11409-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/server: introduce NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com

On 04/13/2018 09:31 AM, Vladimir Sementsov-Ogievskiy wrote:
> Handle nbd CACHE command. Just do read, without sending read data back.
> Cache mechanism should be done by exported node driver chain.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/nbd.h |  3 ++-
>   nbd/server.c        | 10 ++++++----
>   2 files changed, 8 insertions(+), 5 deletions(-)

Missing a change to nbd/common.c nbd_cmd_lookup().

> @@ -1911,7 +1913,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
>       int ret;
>       NBDExport *exp = client->exp;
>   
> -    assert(request->type == NBD_CMD_READ);
> +    assert(request->type == NBD_CMD_READ || request->type == NBD_CMD_CACHE);

Also, missing a call into this function for NBD_CMD_CACHE.

Squashing the following, then adding to my NBD queue, with:

Reviewed-by: Eric Blake <eblake@redhat.com>

diff --git i/nbd/common.c w/nbd/common.c
index 8c95c1d606e..41f5ed8d9fa 100644
--- i/nbd/common.c
+++ w/nbd/common.c
@@ -148,6 +148,8 @@ const char *nbd_cmd_lookup(uint16_t cmd)
          return "flush";
      case NBD_CMD_TRIM:
          return "trim";
+    case NBD_CMD_CACHE:
+        return "cache";
      case NBD_CMD_WRITE_ZEROES:
          return "write zeroes";
      case NBD_CMD_BLOCK_STATUS:
diff --git i/nbd/server.c w/nbd/server.c
index 323c6d84004..274604609f4 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -2173,6 +2173,7 @@ static coroutine_fn int 
nbd_handle_request(NBDClient *client,

      switch (request->type) {
      case NBD_CMD_READ:
+    case NBD_CMD_CACHE:
          return nbd_do_cmd_read(client, request, data, errp);

      case NBD_CMD_WRITE:


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
