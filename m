Received: from eggs.gnu.org ([2001:4830:134:3::10]:52601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtqIJ-0000Rb-Kr
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtqII-0007y8-Ki
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:16:39 -0400
Date: Mon, 18 Sep 2017 15:16:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170918071630.GI15551@lemon.lan>
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915101008.16646-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915101008.16646-2-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-io: Reset qemuio_blk permissions
 before each command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

On Fri, 09/15 12:10, Kevin Wolf wrote:
> qemu-io provides a 'reopen' command that allows switching from writable
> to read-only access. We need to make sure that we don't try to keep
> write permissions to a BlockBackend that becomes read-only, otherwise
> things are going to fail.
> 
> command() already makes sure to request any additional permissions that
> a qemu-io command requires, so just resetting the permissions to values
> that are safe for read-only images is enough to fix this.
> 
> As a side effect, this makes the output of qemu-iotests case 187 more
> consistent.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-io.c                  | 13 +++++++++++++
>  tests/qemu-iotests/187.out |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-io.c b/qemu-io.c
> index 265445ad89..9e031f0f8e 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -366,6 +366,12 @@ static void command_loop(void)
>      char *input;
>  
>      for (i = 0; !done && i < ncmdline; i++) {
> +        /* Make sure that we start each command with clean permissions and only
> +         * add whatever the specific cmdinfo_t describes */
> +        if (qemuio_blk) {
> +            blk_set_perm(qemuio_blk, BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL,
> +                         &error_abort);
> +        }
>          done = qemuio_command(qemuio_blk, cmdline[i]);
>      }
>      if (cmdline) {
> @@ -391,6 +397,13 @@ static void command_loop(void)
>          if (input == NULL) {
>              break;
>          }
> +
> +        /* Make sure that we start each command with clean permissions and only
> +         * add whatever the specific cmdinfo_t describes */
> +        if (qemuio_blk) {
> +            blk_set_perm(qemuio_blk, BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL,
> +                         &error_abort);
> +        }
>          done = qemuio_command(qemuio_blk, input);
>          g_free(input);
>  
> diff --git a/tests/qemu-iotests/187.out b/tests/qemu-iotests/187.out
> index 68fb944cd5..30b987f71f 100644
> --- a/tests/qemu-iotests/187.out
> +++ b/tests/qemu-iotests/187.out
> @@ -12,7 +12,7 @@ Start from read-write
>  
>  wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -write failed: Operation not permitted
> +Block node is read-only
>  wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  *** done
> -- 
> 2.13.5
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
