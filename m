Received: from eggs.gnu.org ([2001:4830:134:3::10]:42608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekFjn-0005hr-Ig
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekFjj-0005Y9-Jy
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:57:39 -0500
References: <20180209202621.97852-1-yasmins@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <baf09d46-934f-1f82-1f68-21ae22ffd2f9@redhat.com>
Date: Fri, 9 Feb 2018 14:57:33 -0600
MIME-Version: 1.0
In-Reply-To: <20180209202621.97852-1-yasmins@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] dump: Show custom message for ENOSPC
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

On 02/09/2018 02:26 PM, Yasmin Beatriz wrote:
> This patch intends to make a more specific message for when
> the system has not enough space to save guest memory.
> 
> Reported-by: yilzhang@redhat.com
> Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Signed-off-by: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
> ---

> @@ -364,7 +364,11 @@ static void write_data(DumpState *s, void *buf, int length, Error **errp)
>   
>       ret = fd_write_vmcore(buf, length, s);
>       if (ret < 0) {
> -        error_setg(errp, "dump: failed to save memory");
> +        if (ret == -ENOSPC) {
> +            error_setg(errp, "dump: not enough space to save memory");
> +        } else {
> +            error_setg(errp, "dump: failed to save memory");
> +        }

Why is this caller the only one in the file that gets distinguished 
error messages?  And why not use error_setg_errno() instead of 
open-coding just one special errno value?  If you're changing the return 
value of fd_write_vmcore() anyways, I'd suggest that ALL callers in the 
file be updated to use error_setg_errno().

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
