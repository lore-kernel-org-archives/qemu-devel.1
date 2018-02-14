Received: from eggs.gnu.org ([2001:4830:134:3::10]:50458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em4Kn-0007ud-Nk
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 16:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em4Km-0008Hi-SX
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 16:11:21 -0500
References: <20180214204915.7980-1-mreitz@redhat.com>
	<20180214204915.7980-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb2c00e1-eae0-7d71-b4dc-0df0054a3fb2@redhat.com>
Date: Wed, 14 Feb 2018 15:11:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180214204915.7980-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] block/ssh: Make ssh_grow_file()
 blocking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org

On 02/14/2018 02:49 PM, Max Reitz wrote:
> At runtime (that is, during a future ssh_truncate()), the SSH session is
> non-blocking.  However, ssh_truncate() (or rather, bdrv_truncate() in
> general) is not a coroutine, so this resize operation needs to block.
> 
> For ssh_create(), that is fine, too; the session is never set to
> non-blocking anyway.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/ssh.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/block/ssh.c b/block/ssh.c
> index 964e55f7fe..ff8576f21e 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -803,17 +803,24 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
>       return ret;
>   }
>   
> +/* Note: This is a blocking operation */
>   static int ssh_grow_file(BDRVSSHState *s, int64_t offset, Error **errp)
>   {
>       ssize_t ret;
>       char c[1] = { '\0' };
> +    int was_blocking = libssh2_session_get_blocking(s->session);
>   
>       /* offset must be strictly greater than the current size so we do
>        * not overwrite anything */
>       assert(offset > 0 && offset > s->attrs.filesize);
>   
> +    libssh2_session_set_blocking(s->session, 1);
> +
>       libssh2_sftp_seek64(s->sftp_handle, offset - 1);
>       ret = libssh2_sftp_write(s->sftp_handle, c, 1);
> +
> +    libssh2_session_set_blocking(s->session, was_blocking);

Is it worth skipping the two libssh2_session_set_blocking() calls if 
was_blocking is 1?  But that's a micro-optimization that probably won't 
be noticeable, so I'm also fine with unconditional.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
