Received: from eggs.gnu.org ([2001:4830:134:3::10]:58924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDAPZ-0005mv-Dk
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDAPY-0004r1-Cb
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:17 -0400
References: <20180428144123.30333-1-mreitz@redhat.com>
	<20180428144123.30333-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <26182b94-a34a-ad71-255b-f18dd677efd6@redhat.com>
Date: Mon, 30 Apr 2018 10:08:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180428144123.30333-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] qemu-io: Let command functions return
 error code
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
> This is basically what everything else in the qemu code base does, so we
> can do it here, too.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/qemu-io.h |   4 +-
>   qemu-io-cmds.c    | 346 ++++++++++++++++++++++++++++++++----------------------
>   qemu-io.c         |  34 ++++--
>   3 files changed, 227 insertions(+), 157 deletions(-)
> 
> diff --git a/include/qemu-io.h b/include/qemu-io.h
> index 06cdfbf660..380724ad59 100644
> --- a/include/qemu-io.h
> +++ b/include/qemu-io.h
> @@ -22,7 +22,7 @@
>   
>   #define CMD_FLAG_GLOBAL ((int)0x80000000) /* don't iterate "args" */
>   
> -typedef void (*cfunc_t)(BlockBackend *blk, int argc, char **argv);
> +typedef int (*cfunc_t)(BlockBackend *blk, int argc, char **argv);

Quite a bit of churn on the definition here; squashing 1 and 2 might 
make for a smaller patch.  But I agree that doing it this way (2 
separate patches) forces us to audit (with the compiler's help) that all 
callers are caught and adjusted to the new semantics.

However, a comment before the typedef would be useful, so that writing a 
new command knows what semantics it must provide.  It can be as simple as:

/* Implement a qemu-io command.
  * Operate on @blk using @argc/@argv as the command's arguments, and
  * return 0 on success or negative errno on failure.
  */

With a comment added,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
