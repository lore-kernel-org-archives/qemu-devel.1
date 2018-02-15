Received: from eggs.gnu.org ([2001:4830:134:3::10]:54287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emRbU-0003F0-J1
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emRbT-0006sK-Ro
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:02:08 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-2-git-send-email-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4c52fa6-67a3-da9d-b4e1-bfdc21ee9a88@redhat.com>
Date: Thu, 15 Feb 2018 16:01:43 -0600
MIME-Version: 1.0
In-Reply-To: <1518702707-7077-2-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/9] nbd/server: add nbd_opt_invalid helper
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

On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> NBD_REP_ERR_INVALID is often parameter to nbd_opt_drop and it would
> be used more in following patches. So, let's add a helper.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 50 ++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 36 insertions(+), 14 deletions(-)

More than twice the lines added compared to what was removed, so it's a 
tough call whether this refactoring makes a common pattern easier or 
just adds burden in tracing what gets executed, just to remove a 
parameter.  I'm not opposed to the patch, but want to see how it helps 
the rest of the series.

At any rate, the conversion itself is done correctly, so if we keep the 
patch, it has earned:

Reviewed-by: Eric Blake <eblake@redhat.com>


>   
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

No documentation comments?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
