Received: from eggs.gnu.org ([2001:4830:134:3::10]:36493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7gUA-000456-1e
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7gJV-0003wv-2z
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:31:37 -0400
References: <20181002230218.13949-1-jsnow@redhat.com>
	<20181002230218.13949-7-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba6d67da-4708-aebe-557c-0a065515c523@redhat.com>
Date: Wed, 3 Oct 2018 07:31:21 -0500
MIME-Version: 1.0
In-Reply-To: <20181002230218.13949-7-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 6/6] nbd: forbid use of frozen bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 10/2/18 6:02 PM, John Snow wrote:
> Whether it's "locked" or "frozen", it's in use and should
> not be allowed for the purposes of this operation.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   nbd/server.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index c3dd402b45..940b7aa0cd 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2478,8 +2478,8 @@ void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
>           return;
>       }
>   
> -    if (bdrv_dirty_bitmap_qmp_locked(bm)) {
> -        error_setg(errp, "Bitmap '%s' is locked", bitmap);
> +    if (bdrv_dirty_bitmap_user_locked(bm)) {
> +        error_setg(errp, "Bitmap '%s' is in use", bitmap);

Again, I'm not sure about this. A locked bitmap is unchanging.  A frozen 
bitmap is split, and might change when the split is resolved, so we are 
correct that we cannot tolerate a frozen bitmap. But if locking were 
changed to a refcount instead of a bool, I don't see why we have to 
forbid a locked bitmap.  Then again, as in 5/6, the user can work around 
this limitation by cloning a locked bitmap into an unlocked temporary 
one, where we are trading ease of maintenance for a bit more user effort.

Weak Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
