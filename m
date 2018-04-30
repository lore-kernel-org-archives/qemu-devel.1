Received: from eggs.gnu.org ([2001:4830:134:3::10]:53672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDBp4-0004Wg-Lb
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDBp3-0002ju-RB
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:38:42 -0400
References: <20180428144123.30333-1-mreitz@redhat.com>
	<20180428144123.30333-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b32a971-b110-6844-39c1-f9c2d4d39682@redhat.com>
Date: Mon, 30 Apr 2018 11:38:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180428144123.30333-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-io: Exit with error when a
 command failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 04/28/2018 09:41 AM, Max Reitz wrote:
> Currently, qemu-io basically always returns success when it gets to
> interactive mode (so once the whole command line has been parsed; even
> before the commands on the command line are interpreted).  That is not
> very useful.
> 
> This patch makes qemu-io return failure when any of the executed
> commands failed.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1519617
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qemu-io.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 

> @@ -672,5 +683,10 @@ int main(int argc, char **argv)
>   
>       blk_unref(qemuio_blk);
>       g_free(readline_state);
> -    return 0;
> +
> +    if (ret < 0) {
> +        return 1;
> +    } else {
> +        return 0;
> +    }

Would spelling this EXIT_SUCCESS/EXIT_FAILURE make it any more legible? 
But we aren't consistently using those anywhere else, so you aren't 
making it worse by using 0/1.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
