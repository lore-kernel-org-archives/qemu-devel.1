Received: from eggs.gnu.org ([2001:4830:134:3::10]:41243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekFfd-0002wF-D6
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:53:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekFfZ-00033f-Ck
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:53:21 -0500
References: <20180209193138.97198-1-yasmins@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8cf6861-042a-4c6e-0163-b49b38b577d3@redhat.com>
Date: Fri, 9 Feb 2018 14:52:59 -0600
MIME-Version: 1.0
In-Reply-To: <20180209193138.97198-1-yasmins@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dump: Show custom message for ENOSPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-trivial@nongnu.org, joserz@linux.vnet.ibm.com

On 02/09/2018 01:31 PM, Yasmin Beatriz wrote:
> This patch intends to make a more specific message for when
> the system has not enough space to save guest memory.
> 
> Reported-by: yilzhang@redhat.com
> Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Signed-off-by: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
> ---
>   dump.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/dump.c b/dump.c
> index e9dfed060a..eb56ff53f6 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -106,6 +106,9 @@ static int fd_write_vmcore(const void *buf, size_t size, void *opaque)
>   
>       written_size = qemu_write_full(s->fd, buf, size);
>       if (written_size != size) {
> +        if (errno == ENOSPC) {
> +            return -ENOSPC;
> +        }
>           return -1;

Mixing a return of -1 and negative errno is ugly (as -1 is 
indistinguishable from -EPERM on many, but not all, operating systems). 
If you need to distinguish between different error types, then return 
negative errno in all places.

>       }
>   
> @@ -364,7 +367,11 @@ static void write_data(DumpState *s, void *buf, int length, Error **errp)
>   
>       ret = fd_write_vmcore(buf, length, s);
>       if (ret < 0) {
> -        error_setg(errp, "dump: failed to save memory");

Or, if you really want better error messages, it might make sense to 
push errp setting down into fd_write_vmcore() (all callers have to be 
updated).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
